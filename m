Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1B6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E49207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390335AbgFYHpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:45:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:45030 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390196AbgFYHpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:45:25 -0400
IronPort-SDR: ih2qe31/MnSyPRcoySATnDIYBWJAhMcu6sB+8eWOoKNqVAsivDpyh1QK69Vz08TxeJYl7KY0Vh
 X3tJJVWWGRTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="229508976"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="229508976"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 00:45:23 -0700
IronPort-SDR: fbWzgUQtZj9rXxZUjUJVkz+RfkqTTiv2Y+nqxk/NV9Kg09VzHEKCyhF695CyYtvoLjOkKSWQP2
 65/Iz63EJEkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="385396963"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 25 Jun 2020 00:45:18 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Jun 2020 10:45:17 +0300
Date:   Thu, 25 Jun 2020 10:45:17 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Casey Bowman <casey.g.bowman@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yicheng Li <yichengli@chromium.org>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Add TBT compat
 support
Message-ID: <20200625074517.GC1487@kuha.fi.intel.com>
References: <20200624080926.165107-1-pmalani@chromium.org>
 <20200624080926.165107-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624080926.165107-2-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 01:09:24AM -0700, Prashant Malani wrote:
> Add mux control support for Thunderbolt compatibility mode.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Co-developed-by: Azhar Shaikh <azhar.shaikh@intel.com>
> Co-developed-by: Casey Bowman <casey.g.bowman@intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 70 ++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 1df1386f32e4..0c041b79cbba 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -17,6 +17,7 @@
>  #include <linux/usb/typec_altmode.h>
>  #include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_mux.h>
> +#include <linux/usb/typec_tbt.h>
>  #include <linux/usb/role.h>
>  
>  #define DRV_NAME "cros-ec-typec"
> @@ -24,6 +25,7 @@
>  /* Supported alt modes. */
>  enum {
>  	CROS_EC_ALTMODE_DP = 0,
> +	CROS_EC_ALTMODE_TBT,
>  	CROS_EC_ALTMODE_MAX,
>  };
>  
> @@ -165,6 +167,14 @@ static void cros_typec_register_port_altmodes(struct cros_typec_data *typec,
>  	port->p_altmode[CROS_EC_ALTMODE_DP].svid = USB_TYPEC_DP_SID;
>  	port->p_altmode[CROS_EC_ALTMODE_DP].mode = USB_TYPEC_DP_MODE;
>  
> +	/*
> +	 * Register TBT compatibility alt mode. The EC will not enter the mode
> +	 * if it doesn't support it, so it's safe to register it unconditionally
> +	 * here for now.
> +	 */
> +	port->p_altmode[CROS_EC_ALTMODE_TBT].svid = USB_TYPEC_TBT_SID;
> +	port->p_altmode[CROS_EC_ALTMODE_TBT].mode = TYPEC_ANY_MODE;
> +
>  	port->state.alt = NULL;
>  	port->state.mode = TYPEC_STATE_USB;
>  	port->state.data = NULL;
> @@ -391,6 +401,62 @@ static int cros_typec_usb_safe_state(struct cros_typec_port *port)
>  	return typec_mux_set(port->mux, &port->state);
>  }
>  
> +/*
> + * Spoof the VDOs that were likely communicated by the partner for TBT alt
> + * mode.
> + */
> +static int cros_typec_enable_tbt(struct cros_typec_data *typec,
> +				 int port_num,
> +				 struct ec_response_usb_pd_control_v2 *pd_ctrl)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +	struct typec_thunderbolt_data data;
> +	int ret;
> +
> +	if (typec->pd_ctrl_ver < 2) {
> +		dev_err(typec->dev,
> +			"PD_CTRL version too old: %d\n", typec->pd_ctrl_ver);
> +		return -ENOTSUPP;
> +	}
> +
> +	/* Device Discover Mode VDO */
> +	data.device_mode = TBT_MODE;
> +
> +	if (pd_ctrl->control_flags & USB_PD_CTRL_TBT_LEGACY_ADAPTER)
> +		data.device_mode = TBT_SET_ADAPTER(TBT_ADAPTER_TBT3);
> +
> +	/* Cable Discover Mode VDO */
> +	data.cable_mode = TBT_MODE;
> +	data.cable_mode |= TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
> +
> +	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
> +		data.cable_mode |= TBT_CABLE_OPTICAL;
> +
> +	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> +		data.cable_mode |= TBT_CABLE_LINK_TRAINING;
> +
> +	if (pd_ctrl->cable_gen)
> +		data.cable_mode |= TBT_CABLE_ROUNDED;
> +
> +	/* Enter Mode VDO */
> +	data.enter_vdo = TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
> +
> +	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> +		data.enter_vdo |= TBT_ENTER_MODE_ACTIVE_CABLE;
> +
> +	if (!port->state.alt) {
> +		port->state.alt = &port->p_altmode[CROS_EC_ALTMODE_TBT];
> +		ret = cros_typec_usb_safe_state(port);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	port->state.data = &data;
> +	port->state.mode = TYPEC_TBT_MODE;
> +
> +	return typec_mux_set(port->mux, &port->state);
> +}
> +
>  /* Spoof the VDOs that were likely communicated by the partner. */
>  static int cros_typec_enable_dp(struct cros_typec_data *typec,
>  				int port_num,
> @@ -448,7 +514,9 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  	if (ret)
>  		return ret;
>  
> -	if (mux_flags & USB_PD_MUX_DP_ENABLED) {
> +	if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
> +		ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
> +	} else if (mux_flags & USB_PD_MUX_DP_ENABLED) {
>  		ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
>  	} else if (mux_flags & USB_PD_MUX_SAFE_MODE) {
>  		ret = cros_typec_usb_safe_state(port);
> -- 
> 2.27.0.111.gc72c7da667-goog

thanks,

-- 
heikki
