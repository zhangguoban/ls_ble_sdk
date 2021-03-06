#ifndef _SIG_MESH_CTL_H_
#define _SIG_MESH_CTL_H_
#include "ls_ble.h"
#include "ls_sig_mesh.h"
#include "tinyfs.h"

extern uint16_t mesh_key_lid;

enum MESH_MDL_CFG
{
    /// ************ Generic Server ************
    /// Generic OnOff Server
    MESH_MDL_CFG_ONOFF = 0,
    /// Generic Level Server
    MESH_MDL_CFG_LEVEL,
    /// Generic Default Transition Time
    MESH_MDL_CFG_DFT_TRANS_TIME,
    /// Generic Power OnOff
    MESH_MDL_CFG_POWER_ONOFF,
    /// Generic Power Level
    MESH_MDL_CFG_POWER_LEVEL,
    /// Generic Battery
    MESH_MDL_CFG_BATTERY,
    /// Generic Location
    MESH_MDL_CFG_LOCATION,
    /// ************ Lighting Server ***********
    /// Light Lightness Server
    MESH_MDL_CFG_LIGHTS_LN = 50,
    /// Light CTL Server
    MESH_MDL_CFG_LIGHTS_CTL,
    /// Light HSL Server
    MESH_MDL_CFG_LIGHTS_HSL
};

// Generic OnOff Set
struct mesh_generic_onoff_set
{
    uint8_t onoff;
    uint8_t tid;
    uint8_t ttl;
    uint8_t delay;
};

// Generic OnOff Status
struct mesh_generic_onoff_status
{
    uint8_t present_onoff;
    uint8_t target_onoff;
    uint8_t remain;
}__attribute__((packed));

// General Level Status
struct mesh_generic_level_set
{
    uint16_t level;
    uint8_t tid;
    uint8_t ttl;
    uint8_t delay;
};

// General Level Status
struct mesh_generic_level_status
{
    uint16_t current_level;
    uint16_t target_level;
    uint8_t remain;
}__attribute__((packed));

// Light HSL Set
struct mesh_hsl_model_set
{
    uint16_t lightness;
    uint16_t hue;
    uint16_t hsl_saturation;
    uint8_t tid;
    uint8_t transition_time;
    uint8_t delay;
}__attribute__((packed));

// Light HSL Status
struct mesh_hsl_model_status
{
    uint16_t hsl_lightness;
    uint16_t hsl_hue;
    uint16_t hsl_saturation;
    uint8_t remain;
} __attribute__((packed));

struct mesh_ctl_model_set
{
    uint16_t lightness;
    uint16_t temperature;
    uint16_t delta_UV;
    uint8_t tid;
    uint8_t trans_time;
    uint8_t delay;
}__attribute__((packed));

// Light CTL Status
struct mesh_ctl_model_status
{
    uint16_t current_lightness;
    uint16_t current_temperature;
    uint16_t target_lightness;
    uint16_t target_temperature;
    uint8_t remain;
} __attribute__((packed)) ;

// Vendor Model Set new
struct mesh_vendor_model_set
{
    uint8_t tid;
    uint16_t attr_type;
    uint8_t *attr_parameter;
}__attribute__((packed));

// Vendor Model Indication
struct mesh_vendor_model_indication
{
    uint8_t tid;
    uint16_t attr_type;
    uint8_t *attr_parameter;
}__attribute__((packed));

void mesh_send_custom_adv(uint16_t duration,uint8_t *adv_data,uint8_t adv_data_length);
void sig_mesh_mdl_state_upd_hdl(struct model_state_upd* msg);
#endif // _SIG_MESH_CTL_H_
