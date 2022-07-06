<?php
/**
 * Model for entity_modules
 * 
 * Generated by BlackPHP
 */

class entity_modules_model
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

	/** @var int $cmodule_id ID de la tabla */
	private $cmodule_id;

	/** @var int $entity_id ID de la empresa */
	private $entity_id;

	/** @var int $module_id ID del módulo */
	private $module_id;

	/** @var int $module_order Ubicación del módulo en el menú */
	private $module_order;

	/** @var string $creation_time - */
	private $creation_time;

	/** @var string $edition_time - */
	private $edition_time;

	/** @var int $status - */
	private $status;

	/**
	 * Constructor de la clase
	 * 
	 * Inicializa las propiedades generales de la tabla
	 */
	public function __construct()
	{
		$this->_table_name = "entity_modules";
		$this->_primary_key = "cmodule_id";
		$this->_timestamps = false;
		$this->_soft_delete = true;
	}

	public function getCmodule_id()
	{
		return $this->cmodule_id;
	}

	public function setCmodule_id($value)
	{
		$this->cmodule_id = (int)$value;
	}

	public function getEntity_id()
	{
		return $this->entity_id;
	}

	public function setEntity_id($value)
	{
		$this->entity_id = (int)$value;
	}

	public function getModule_id()
	{
		return $this->module_id;
	}

	public function setModule_id($value)
	{
		$this->module_id = (int)$value;
	}

	public function getModule_order()
	{
		return $this->module_order;
	}

	public function setModule_order($value)
	{
		$this->module_order = (int)$value;
	}

	public function getCreation_time()
	{
		return $this->creation_time;
	}

	public function setCreation_time($value)
	{
		$this->creation_time = (string)$value;
	}

	public function getEdition_time()
	{
		return $this->edition_time;
	}

	public function setEdition_time($value)
	{
		$this->edition_time = (string)$value;
	}

	public function getStatus()
	{
		return $this->status;
	}

	public function setStatus($value)
	{
		$this->status = (int)$value;
	}
}
?>