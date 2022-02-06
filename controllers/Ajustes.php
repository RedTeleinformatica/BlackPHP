<?php

#	Options controller
#	By: Edwin Fajardo
#	Date-time: 2020-06-18 23:46

class Ajustes extends Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->module = get_class($this);
		$this->view->data["module"] = $this->module;
	}

	public function index()
	{
		$this->session_required("html", $this->module);
		$this->view->data["title"] = 'Configuraci&oacute;n';
		$this->view->standard_menu();
		$this->view->data["nav"] = $this->view->render("nav", true);
		$this->loadModel("entity");
		$module = $this->model->get_module_by_name($this->module);
		$this->view->data["methods"] = $this->model->get_entity_methods($this->entity_id, $module["module_id"]);
		$this->view->data["content"] = $this->view->render("generic_menu", true);
		$this->view->render('main');
	}

	public function Datos()
	{
		$this->session_required("html", $this->module);
		$this->view->data["title"] = 'Datos del negocio';
		$this->view->standard_form();
		$this->view->data["nav"] = $this->view->render("nav", true);
		$this->view->data["content"] = $this->view->render("settings/entity", true);
		$this->view->render('main');
	}

	public function Preferencias()
	{
		$this->session_required("html", $this->module);
		$this->view->data["title"] = 'Preferencias';
		$this->view->standard_form();
		$this->view->data["nav"] = $this->view->render("nav", true);
		$this->view->data["content"] = $this->view->render("settings/preferences", true);
		$this->view->render('main');
	}

	public function Usuarios()
	{
		$this->session_required("html", $this->module);
		$this->view->data["title"] = 'Usuarios';
		$this->view->standard_list();
		$this->view->data["nav"] = $this->view->render("nav", true);
		$this->view->data["print_title"] = "Usuarios";
		$this->view->data["print_header"] = $this->view->render("print_header", true);
		$this->view->data["content"] = $this->view->render("settings/user_list", true);
		$this->view->render('main');
	}

	public function RegistrarUsuario()
	{
		$this->session_required("html", $this->module);
		$this->view->data["title"] = 'Registrar usuario';
		$this->view->standard_form();
		$this->view->data["nav"] = $this->view->render("nav", true);
		$this->view->restrict[] = "edition";
		$this->loadModel("user");
		$this->view->data["content"] = $this->view->render("settings/user_edit", true);
		$this->view->render('main');
	}

	public function EditarUsuario($user_id)
	{
		$this->session_required("html", $this->module);
		$this->view->data["title"] = 'Editar usuario';
		$this->view->standard_form();
		$this->view->data["nav"] = $this->view->render("nav", true);
		if($user_id == Session::get("user_id"))
		{
			$this->view->restrict[] = "no_self";
		}
		else
		{
			$this->loadModel("user");
			$this->view->data["branches"] = $this->model->get_user_branches(Session::get("user_id"));
		}
		$this->view->restrict[] = "creation";
		$this->view->data["content"] = $this->view->render("settings/user_edit", true);
		$this->view->render('main');
	}

	public function users_table_loader()
	{
		$this->session_required("json");
		$this->loadModel("user");
		$data = Array();
		$users = $this->model->get_all($this->entity_id);
		$status = Array("Eliminado", "Activo", "Inactivo");
		foreach($users as $key => $user)
		{
			$users[$key]["status"] = $status[$users[$key]["status"]];
		}
		$data["content"] = $users;
		echo json_encode($data);
	}

	public function save_user()
	{
		$this->session_required("json");
		$data = Array("success" => false);
		if(empty($_POST["user_name"]))
		{
			echo json_encode($data);
			return;
		}
		$time = Date("Y-m-d H:i:s");
		$this->loadModel("user");
		$user_id = 0;
		if(!empty($_POST["user_id"]))
		{
			$data_set = Array(
				"user_id" => $_POST["user_id"],
				"user_name" => $_POST["user_name"],
				"edition_user" => Session::get("user_id"),
				"edition_time" => $time
			);
			if(!empty($_POST["password"]))
			{
				$data_set["password"] = md5($_POST["password"]);
			}
			$data = $this->model->update_user($data_set);
			$user_id = $_POST["user_id"];
		}
		else
		{
			$comp_id = $this->entity_id;
			$nickname = $this->model->get_user_by_nickname($_POST["nickname"], $comp_id);
			if(isset($nickname["user_id"]))
			{
				$data["title"] = "Error";
				$data["message"] = "El nombre de usuario ya existe.";
				$data["theme"] = "red";
				echo json_encode($data);
				return;
			}
			$data_set = Array(
				"user_name" => $_POST["user_name"],
				"nickname" => $_POST["nickname"],
				"entity_id" => $comp_id,
				"password" => md5($_POST["password"]),
				"creation_user" => Session::get("user_id"),
				"creation_time" => $time,
				"edition_user" => Session::get("user_id"),
				"edition_time" => $time
			);
			$data = $this->model->set_user($data_set);
			$user_id = $data["id"];
		}

		if($user_id != Session::get("user_id"))
		{
			#Set module access
			$data_set = Array(
				"user_id" => $user_id,
				"edition_user" => Session::get("user_id"),
				"edition_time" => $time,
				"status" => 0
			);
			$this->model->revoke_permissions($data_set);
			foreach($_POST["modules"] as $module_id)
			{
				#$module = $this->model->get_module_by_name($module_name);
				$access = $this->model->get_module_access($user_id, $module_id);
				if(isset($access["user_id"]))
				{
					$data_set = Array(
						"module_id" => $module_id,
						"user_id" => $user_id,
						"access_type" => 1,
						"edition_user" => Session::get("user_id"),
						"edition_time" => $time,
						"status" => 1
					);
					$this->model->update_access($data_set);
				}
				else
				{
					$data_set = Array(
						"module_id" => $module_id,
						"user_id" => $user_id,
						"access_type" => 1,
						"creation_user" => Session::get("user_id"),
						"creation_time" => $time,
						"edition_user" => Session::get("user_id"),
						"edition_time" => $time
					);
					$this->model->set_access($data_set);
				}
			}
		}
		$data["success"] = true;
		$data["title"] = "Éxito";
		$data["message"] = "Los cambios se han guardado";
		$data["theme"] = "green";
		$data["reload_after"] = true;
		echo json_encode($data);
	}

	public function load_form_data()
	{
		$data = Array();
		if($_POST["method"] == "Datos")
		{
			$this->loadModel("entity");
			$data["update"] = $this->model->get_entity_by_id($this->entity_id);
		}
		if($_POST["method"] == "EditarUsuario")
		{
			$this->loadModel("user");
			$data["update"] = $this->model->get_user($_POST["id"]);
			$data["check"] = Array();
			$data["check"]["modules"] = $this->model->get_all_permissions($_POST["id"]);
		}
		if($_POST["method"] == "Preferencias")
		{
			$this->loadModel("entity");
			$data["themes"] = $this->model->get_themes();
			$data["update"] = Array(
				"theme_id" => Session::get("theme_id")
			);
		}
		echo json_encode($data);
	}

	public function save_entity()
	{
		$this->session_required("json");
		$data = Array("success" => false);
		if(!empty($_POST["entity_name"]))
		{
			$time = Date("Y-m-d H:i:s");
			$data_set = Array(
				"entity_id" => $this->entity_id,
				"entity_name" => $_POST["entity_name"],
				"entity_slogan" => $_POST["entity_slogan"],
				"edition_user" => Session::get("user_id"),
				"user_edition_time" => $time
			);
			$this->loadModel("entity");
			$data = $this->model->update_entity($data_set);
			Session::set("entity", $this->model->get_entity_by_id($this->entity_id));
			$data["success"] = true;
			$data["title"] = "Éxito";
			$data["message"] = "Datos guardados con éxito";
			$data["theme"] = "green";
			$data["no_reset"] = true;

			#Save image
			if(!empty($_FILES["images"]["name"]))
			{
				$extension = strtolower(pathinfo($_FILES["images"]["name"][0], PATHINFO_EXTENSION));
				if($_SERVER["SERVER_NAME"] == $_SERVER["SERVER_ADDR"])
				{
					$dir = "entities/local/";
				}
				else
				{
					$dir = "entities/" . $this->entity_subdomain . "/";
				}
				$file = $dir . "logo." . $extension;
				$generic_file = glob($dir . "logo.*");
				if(!is_dir($dir))
				{
					mkdir($dir, 0755, true);
				}
				else
				{
					foreach($generic_file as $previous)
					{
						unlink($previous);
					}
				}
				move_uploaded_file($_FILES["images"]["tmp_name"][0], $file);
			}
		}
		echo json_encode($data);
	}
	public function delete_user()
	{
		$this->session_required("json");
		$data = Array("deleted" => false);
		if(empty($_POST["id"]))
		{
			echo json_encode($data);
			return;
		}
		$this->loadModel("user");
		$user = $this->model->get_user($_POST["id"]);
		$time = Date("Y-m-d H:i:s");
		$data_set = Array(
			"user_id" => $user["user_id"],
			"nickname" => null,
			"status" => 0,
			"edition_user" => Session::get("user_id"),
			"edition_time" => $time
		);
		$data = $this->model->update_user($data_set);
		$data["deleted"] = $data["affected"] > 0;
		echo json_encode($data);
	}

	public function Informacion()
	{
		$this->session_required("html", $this->module);
		$this->view->data["title"] = 'Informaci&oacute;n';
		$this->view->standard_details();
		$this->view->data["system_short_date"] = Date("d/m/Y");
		$this->view->data["nav"] = $this->view->render("nav", true);
		$this->view->data["content_id"] = "info_details";
		$this->view->data["content"] = $this->view->render("content_loader", true);
		$this->view->render('main');
	}

	public function info_details_loader()
	{
		$this->session_required("internal");
		$info = Array();
		if(file_exists("app_info.json"))
		{
			$info = json_decode(file_get_contents("app_info.json"), true);
			$info["last_update_ago"] = date_utilities::sql_date_to_ago($info["last_update"]);
			$info["last_update"] = date_utilities::sql_date_to_string($info["last_update"], true);
		}
		else
		{
			$files = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($_SERVER["DOCUMENT_ROOT"]), RecursiveIteratorIterator::SELF_FIRST);
			$last_modified = 0;
			foreach($files as $file_object)
			{
				$modified = $file_object->getMTime();
				if($modified > $last_modified)
				{
					$last_modified = $modified;
				}
			}
			$info["last_update"] = date_utilities::sql_date_to_string(Date("Y-m-d H:i:s", $last_modified), true);
			$info["last_update_ago"] = date_utilities::sql_date_to_ago(Date("Y-m-d H:i:s", $last_modified));
			$info["version"] = "1.0";
			$info["number"] = "0";
		}
		foreach($info as $key => $item)
		{
			$this->view->data[$key] = $item;
		}
		$this->view->render('settings/info_details');
	}

	public function save_preferences()
	{
		$this->session_required("json");
		$data = $_POST;
		$data["success"] = false;
		if($data["theme_id"] != Session::get("theme_id"))
		{
			$this->loadModel("user");
			$user = $this->model->get_user(Session::get("user_id"));
			$user["theme_id"] = $data["theme_id"];
			$this->model->update_user($user);
			$theme = $this->model->get_theme($data["theme_id"]);
			Session::set("theme_id", $theme["theme_id"]);
			Session::set("theme_url", $theme["theme_url"]);
			$data["reload_after"] = true;
		}
		$data["success"] = true;
		$data["title"] = "Éxito";
		$data["message"] = "Preferencias guardadas con éxito";
		$data["theme"] = "green";
		echo json_encode($data);
	}

	public function DetalleSucursal()
	{
		$this->session_required("html", $this->module);
		$this->view->data["title"] = 'Detalle de sucursal';
		$this->view->standard_details();
		$this->view->data["nav"] = $this->view->render("nav", true);
		$this->view->data["content_id"] = "branch_details";
		$this->view->data["content"] = $this->view->render("content_loader", true);
		$this->view->render('main');
	}

	public function branch_details_loader()
	{
		$this->session_required("internal");
		$this->loadModel("entity");
		$store_types = Array("", "Sala de ventas", "Bodega", "Sala de ventas y bodega");
		$branch = $this->model->get_branch($_POST["id"]);
		$branch["store_type"] = $store_types[$branch["store_type"]];
		$this->view->data = array_merge($this->view->data, $branch);
		$this->user_actions($branch);
		$this->view->data["print_title"] = "Detalle de sucursal";
		$this->view->data["print_header"] = $this->view->render("print_header", true);
		$this->view->render("settings/branch_details");
	}

	public function DetalleUsuario()
	{
		$this->session_required("html", $this->module);
		$this->view->data["title"] = 'Detalle de usuario';
		$this->view->standard_details();
		$this->view->data["system_short_date"] = Date("d/m/Y");
		$this->view->data["nav"] = $this->view->render("nav", true);
		$this->view->data["content_id"] = "user_details";
		$this->view->data["content"] = $this->view->render("content_loader", true);
		$this->view->render('main');
	}

	public function user_details_loader()
	{
		$this->session_required("internal");
		$this->loadModel("user");
		$id = $_POST["id"];
		$user = $this->model->get_user($id);
		$this->view->data = array_merge($this->view->data, $user);
		$sessions = $this->model->get_sessions_by_user(0, $id);
		$i = 0;
		foreach($sessions as $key => $session)
		{
			$sessions[$key]["item"] = ++$i;
			$time = strtotime($session["date_time"]);
			$sessions[$key]["session_date"] = Date("d/m/Y", $time);
			$sessions[$key]["session_time"] = Date("h:i a", $time);
			$purchases[$key]["amount"] = number_format($purchase["amount"], 2);
		}
		$this->view->data["sessions"] = $sessions;

		$modules = $this->model->get_user_entity_modules($this->entity_id, $id);
		$i = -1;
		$j = 0;
		$modules_table = Array();
		foreach($modules as $k => $module)
		{
			if($k % 4 == 0)
			{
				$i++;
				$modules_table[$i] = Array();
				$j = 0;
			}
			$modules_table[$i]["module_" . $j] = $module["module_name"];
			$j++;
			$k++;
		}
		while($j % 4 != 0)
		{
			$modules_table[$i]["module_" . $j] = "";
			$j++;
		}
		$this->view->data["user_modules"] = $modules_table;
		#User photo
		$photo = glob("entities/" . $this->entity_id . "/users/profile_" . $user["user_id"] . ".*");
		if(count($photo) > 0)
		{
			$this->view->data["user_photo"] = $photo[0];
		}
		else
		{
			$this->view->data["user_photo"] = "public/images/user.png";
		}
		$this->user_actions($user);
		$this->view->data["print_title"] = "Datos del usuario";
		$this->view->data["print_header"] = $this->view->render("print_header", true);
		$this->view->render("settings/user_details");
	}
}
?>
