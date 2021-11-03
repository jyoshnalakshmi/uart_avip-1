`ifndef VIRTUAL_SEQUENCER_INCLUDED_
`define VIRTUAL_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: virtual_sequencer
// Description:
// This class contains the handle of  master sequencer,slave sequencer and environment config 
//--------------------------------------------------------------------------------------------
class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
  `uvm_component_utils(virtual_sequencer)

  // Variable: env_cfg_h
  // Declaring environment configuration handle
  env_config env_cfg_h;

  // Variable: master_seqr_h
  // Declaring master sequencer handle
  master_sequencer master_seqr_h;

  // Variable: slave_seqr_h
  // Declaring slave sequencer handle
  slave_sequencer slave_seqr_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "virtual_sequencer", uvm_component parent=null);
  extern virtual function void build_phase(uvm_phase phase);

endclass : virtual_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - instance name of the  virtual_sequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function virtual_sequencer::new(string name = "virtual_sequencer",uvm_component parent=null );
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Get the environment config
// creates the master and slave sequencer
//
// Parameters:
//  phase - stores the current phase
//--------------------------------------------------------------------------------------------
function void virtual_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg_h))begin
    `uvm_error("VSEQR","COULDNT GET")
  end
  master_seqr_h=master_sequencer::type_id::create("master_seqr_h",this);
  slave_seqr_h=slave_sequencer::type_id::create("slave_seqr_h",this);
endfunction : build_phase

`endif

