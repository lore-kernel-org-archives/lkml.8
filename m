Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01B6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F522074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFPITe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:19:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:6511 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgFPITd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:19:33 -0400
IronPort-SDR: iy3MO/pWUsFfvzzKSNoRbd3Pd096OwtLy6cvH14CW9pf/qjFQOaFpdVHA4RAefHrCh3Q1zwt+K
 p2JEmhZ3s47Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 01:19:18 -0700
IronPort-SDR: smuYqMfrtPufZWfwP8OF+mIsJDQZQKVDIcypLmurkN1+sKqmofCwwLb1hmIkO1zJjVMmwPUyRl
 TuipIJK+uaUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="382803214"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 16 Jun 2020 01:19:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 16 Jun 2020 11:19:15 +0300
Date:   Tue, 16 Jun 2020 11:19:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 3/4] platform/chrome: typec: Add USB mux control
Message-ID: <20200616081915.GI3213128@kuha.fi.intel.com>
References: <20200528113607.120841-1-pmalani@chromium.org>
 <20200528113607.120841-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528113607.120841-4-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:36:07AM -0700, Prashant Malani wrote:
> Add support to configure various Type C switches appropriately using the
> Type C connector class API, when the Chrome OS EC informs the AP that
> the USB operating mode has been entered.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 100 +++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index d69a88464cef..9ebf9abed16f 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -14,6 +14,7 @@
>  #include <linux/platform_data/cros_usbpd_notify.h>
>  #include <linux/platform_device.h>
>  #include <linux/usb/typec.h>
> +#include <linux/usb/typec_altmode.h>
>  #include <linux/usb/typec_mux.h>
>  #include <linux/usb/role.h>
>  
> @@ -30,6 +31,10 @@ struct cros_typec_port {
>  	struct typec_switch *ori_sw;
>  	struct typec_mux *mux;
>  	struct usb_role_switch *role_sw;
> +
> +	/* Variables keeping track of switch state. */
> +	struct typec_mux_state state;
> +	uint8_t mux_flags;
>  };
>  
>  /* Platform-specific data for the Chrome OS EC Type C controller. */
> @@ -264,6 +269,23 @@ static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
>  	return ret;
>  }
>  
> +static void cros_typec_remove_partner(struct cros_typec_data *typec,
> +				     int port_num)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +
> +	port->state.alt = NULL;
> +	port->state.mode = TYPEC_STATE_USB;
> +	port->state.data = NULL;
> +
> +	usb_role_switch_set_role(port->role_sw, USB_ROLE_NONE);
> +	typec_switch_set(port->ori_sw, TYPEC_ORIENTATION_NONE);
> +	typec_mux_set(port->mux, &port->state);
> +
> +	typec_unregister_partner(port->partner);
> +	port->partner = NULL;
> +}
> +
>  static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
>  		int port_num, struct ec_response_usb_pd_control *resp)
>  {
> @@ -317,16 +339,69 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
>  	} else {
>  		if (!typec->ports[port_num]->partner)
>  			return;
> +		cros_typec_remove_partner(typec, port_num);
> +	}
> +}
> +
> +static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
> +				   struct ec_response_usb_pd_mux_info *resp)
> +{
> +	struct ec_params_usb_pd_mux_info req = {
> +		.port = port_num,
> +	};
> +
> +	return cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_MUX_INFO, &req,
> +				     sizeof(req), resp, sizeof(*resp));
> +}
> +
> +static int cros_typec_usb_safe_state(struct cros_typec_port *port)
> +{
> +	port->state.mode = TYPEC_STATE_SAFE;
> +
> +	return typec_mux_set(port->mux, &port->state);
> +}
>  
> -		typec_unregister_partner(typec->ports[port_num]->partner);
> -		typec->ports[port_num]->partner = NULL;
> +int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
> +			     uint8_t mux_flags)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +	enum typec_orientation orientation;
> +	int ret;
> +
> +	if (!port->partner)
> +		return 0;
> +
> +	if (mux_flags & USB_PD_MUX_POLARITY_INVERTED)
> +		orientation = TYPEC_ORIENTATION_REVERSE;
> +	else
> +		orientation = TYPEC_ORIENTATION_NORMAL;
> +
> +	ret = typec_switch_set(port->ori_sw, orientation);
> +	if (ret)
> +		return ret;
> +
> +	port->state.alt = NULL;
> +	port->state.mode = TYPEC_STATE_USB;
> +
> +	if (mux_flags & USB_PD_MUX_SAFE_MODE)
> +		ret = cros_typec_usb_safe_state(port);
> +	else if (mux_flags & USB_PD_MUX_USB_ENABLED)
> +		ret = typec_mux_set(port->mux, &port->state);
> +	else {
> +		dev_info(typec->dev,
> +			 "Unsupported mode requested, mux flags: %x\n",
> +			 mux_flags);
> +		ret = -ENOTSUPP;
>  	}
> +
> +	return ret;
>  }
>  
>  static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  {
>  	struct ec_params_usb_pd_control req;
>  	struct ec_response_usb_pd_control_v1 resp;
> +	struct ec_response_usb_pd_mux_info mux_resp;
>  	int ret;
>  
>  	if (port_num < 0 || port_num >= typec->num_ports) {
> @@ -357,7 +432,26 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  		cros_typec_set_port_params_v0(typec, port_num,
>  			(struct ec_response_usb_pd_control *) &resp);
>  
> -	return 0;
> +	/* Update the switches if they exist, according to requested state */
> +	ret = cros_typec_get_mux_info(typec, port_num, &mux_resp);
> +	if (ret < 0) {
> +		dev_warn(typec->dev,
> +			 "Failed to get mux info for port: %d, err = %d\n",
> +			 port_num, ret);
> +		return 0;
> +	}
> +
> +	/* No change needs to be made, let's exit early. */
> +	if (typec->ports[port_num]->mux_flags == mux_resp.flags)
> +		return 0;
> +
> +	typec->ports[port_num]->mux_flags = mux_resp.flags;
> +	ret = cros_typec_configure_mux(typec, port_num, mux_resp.flags);
> +	if (ret)
> +		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
> +
> +	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
> +					!!(resp.role & PD_CTRL_RESP_ROLE_DATA));
>  }
>  
>  static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> -- 
> 2.27.0.rc0.183.gde8f92d652-goog

-- 
heikki
