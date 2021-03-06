<?php
/**
 * Model for entities
 * 
 * Generated by BlackPHP
 */

class entities_model
{
	use ORM;

	/** @var int $entity_id ID de la tabla */
	private $entity_id;

	/** @var string $entity_name Nombre de la empresa */
	private $entity_name;

	/** @var string $entity_slogan Eslogan de la empresa */
	private $entity_slogan;

	/** @var int $admin_user Usuario principal (Superadministrador) */
	private $admin_user;

	/** @var string $entity_date Fecha actual de operaciones (En caso que difiera del sistema) */
	private $entity_date;

	/** @var string $entity_begin Fecha de inicio de las operaciones */
	private $entity_begin;

	/** @var string $entity_subdomain Subdominio (Para funcionamiento en línea) */
	private $entity_subdomain;

	/** @var string $sys_name Nombre de la distribución del sistema */
	private $sys_name;

	/** @var string $default_locale Idioma por defecto de la entidad */
	private $default_locale;

	/** @var int $creation_installer ID del usuario que instaló el sistema */
	private $creation_installer;

	/** @var string $creation_time - */
	private $creation_time;

	/** @var int $edition_installer - */
	private $edition_installer;

	/** @var string $installer_edition_time - */
	private $installer_edition_time;

	/** @var int $edition_user - */
	private $edition_user;

	/** @var string $user_edition_time - */
	private $user_edition_time;

	/** @var int $status - */
	private $status;


	/** @var string $_table_name Nombre de la tabla */
	private static $_table_name = "entities";

	/** @var string $_primary_key Llave primaria */
	private static $_primary_key = "entity_id";

	/** @var bool $_timestamps La tabla usa marcas de tiempo para la inserción y edición de datos */
	private static $_timestamps = false;

	/** @var bool $_soft_delete La tabla soporta borrado suave */
	private static $_soft_delete = true;

	/**
	 * Constructor de la clase
	 * 
	 * Se inicializan las propiedades con los valores de los campos default
	 * de la base de datos
	 **/
	public function __construct()
	{
		$this->status = 1;
	}

	public function getEntity_id()
	{
		return $this->entity_id;
	}

	public function setEntity_id($value)
	{
		$this->entity_id = $value === null ? null : (int)$value;
	}

	public function getEntity_name()
	{
		return $this->entity_name;
	}

	public function setEntity_name($value)
	{
		$this->entity_name = $value === null ? null : (string)$value;
	}

	public function getEntity_slogan()
	{
		return $this->entity_slogan;
	}

	public function setEntity_slogan($value)
	{
		$this->entity_slogan = $value === null ? null : (string)$value;
	}

	public function getAdmin_user()
	{
		return $this->admin_user;
	}

	public function setAdmin_user($value)
	{
		$this->admin_user = $value === null ? null : (int)$value;
	}

	public function getEntity_date()
	{
		return $this->entity_date;
	}

	public function setEntity_date($value)
	{
		$this->entity_date = $value === null ? null : (string)$value;
	}

	public function getEntity_begin()
	{
		return $this->entity_begin;
	}

	public function setEntity_begin($value)
	{
		$this->entity_begin = $value === null ? null : (string)$value;
	}

	public function getEntity_subdomain()
	{
		return $this->entity_subdomain;
	}

	public function setEntity_subdomain($value)
	{
		$this->entity_subdomain = $value === null ? null : (string)$value;
	}

	public function getSys_name()
	{
		return $this->sys_name;
	}

	public function setSys_name($value)
	{
		$this->sys_name = $value === null ? null : (string)$value;
	}

	public function getDefault_locale()
	{
		return $this->default_locale;
	}

	public function setDefault_locale($value)
	{
		$this->default_locale = $value === null ? null : (string)$value;
	}

	public function getCreation_installer()
	{
		return $this->creation_installer;
	}

	public function setCreation_installer($value)
	{
		$this->creation_installer = $value === null ? null : (int)$value;
	}

	public function getCreation_time()
	{
		return $this->creation_time;
	}

	public function setCreation_time($value)
	{
		$this->creation_time = $value === null ? null : (string)$value;
	}

	public function getEdition_installer()
	{
		return $this->edition_installer;
	}

	public function setEdition_installer($value)
	{
		$this->edition_installer = $value === null ? null : (int)$value;
	}

	public function getInstaller_edition_time()
	{
		return $this->installer_edition_time;
	}

	public function setInstaller_edition_time($value)
	{
		$this->installer_edition_time = $value === null ? null : (string)$value;
	}

	public function getEdition_user()
	{
		return $this->edition_user;
	}

	public function setEdition_user($value)
	{
		$this->edition_user = $value === null ? null : (int)$value;
	}

	public function getUser_edition_time()
	{
		return $this->user_edition_time;
	}

	public function setUser_edition_time($value)
	{
		$this->user_edition_time = $value === null ? null : (string)$value;
	}

	public function getStatus()
	{
		return $this->status;
	}

	public function setStatus($value)
	{
		$this->status = $value === null ? null : (int)$value;
	}

	public function entity_methods()
	{
		entity_methods::flush();
		return entity_methods::where("entity_id", $this->entity_id);
	}

	public function entity_modules()
	{
		entity_modules::flush();
		return entity_modules::where("entity_id", $this->entity_id);
	}

	public function users()
	{
		users::flush();
		return users::where("entity_id", $this->entity_id);
	}
}
?>
