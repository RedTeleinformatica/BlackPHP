<?php
/**
 * Model for app_actions
 * 
 * Generated by BlackPHP
 */

class app_actions_model
{
	use ORM;

	/** @var string $_table_name Nombre de la tabla */
	private $_table_name;

	/** @var string $_primary_key Llave primaria */
	private $_primary_key;

	/** @var bool $_timestamps La tabla usa marcas de tiempo para la inserción y edición de datos */
	private $_timestamps;

	/** @var bool $_soft_delete La tabla soporta borrado suave */
	private $_soft_delete;

	/** @var int $action_id ID del registro */
	private $action_id;

	/** @var string $action_key Clave de la acción */
	private $action_key;

	/** @var string $infinitive_verb Verbo en infinitivo */
	private $infinitive_verb;

	/** @var string $past_verb Verbo en pasado */
	private $past_verb;

	/**
	 * Constructor de la clase
	 * 
	 * Inicializa las propiedades generales de la tabla
	 */
	public function __construct()
	{
		$this->_table_name = "app_actions";
		$this->_primary_key = "action_id";
		$this->_timestamps = false;
		$this->_soft_delete = false;
	}

	public function getAction_id()
	{
		return $this->action_id;
	}

	public function setAction_id($value)
	{
		$this->action_id = (int)$value;
	}

	public function getAction_key()
	{
		return $this->action_key;
	}

	public function setAction_key($value)
	{
		$this->action_key = (string)$value;
	}

	public function getInfinitive_verb()
	{
		return $this->infinitive_verb;
	}

	public function setInfinitive_verb($value)
	{
		$this->infinitive_verb = (string)$value;
	}

	public function getPast_verb()
	{
		return $this->past_verb;
	}

	public function setPast_verb($value)
	{
		$this->past_verb = (string)$value;
	}

	public function user_logs()
	{
		user_logs::flush();
		return user_logs::where("action_id", $this->action_id);
	}
}
?>