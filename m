Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE05C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8F4207D0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X43aN7cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgFEJMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgFEJMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:12:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054F1C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 02:12:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so4614293pfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ndmQhjYf3Omikz5HxkrMLPwxxI1tHog0aNimzRFtGNQ=;
        b=X43aN7cljM7PmkM9LxXxE0ACV+fNd0snn6Hx+Z/AA8GmteMbJYboseQ/EeSRyokL9y
         NuF8PIx5Dc6iZWAyIpR9PC/WJteLs6dRssRbT9VNc/Ls+oQWTTjG3L9MuHwGrddbOzK5
         WhLGLPXi73rUDI3c+hn7u8i7UcqqrebpOJFXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ndmQhjYf3Omikz5HxkrMLPwxxI1tHog0aNimzRFtGNQ=;
        b=DTF5//ONU7R5buYAS/MzWjlphFiRDqGJX4W/2+NFiUXrd3jwovj/wqftgCyQ5YIOqb
         n9S945cWJSsnvbbtFoOkwTyemILQ5+1bv6/4eyAw/YLMUp0e6a6FxRXbg0+zF2zNweiH
         VyIVPEjOrotKp/+1BPYVIydiIvLjAaEzmNNn0IZyPfeBM1lbmFuNhI4VrygImF+sQaEB
         u1+PZxEeHs/2+vqPXWFTGDWQ8ATt3l9VF5HTAidZNe9CHIBmQOVSPHgNoq9t8zvkkG9e
         nbHCXxyMayVmUZ+XFcFVSR7hKiFa/WIXIQWiYvpT2JXAthMQNU9ejtQnOkYph1L5GfJm
         vNVg==
X-Gm-Message-State: AOAM532rPs65Fgvmldtr2CGZA5XVwPxVGiBxJCR5gggukOa5ildoZ3Ea
        Wl3PiYVFiU7VjjR0y20KVm/YSlbSPN8=
X-Google-Smtp-Source: ABdhPJzI4RphIdbJE/EnFI/dq4hty4yuYeFst1vWiLd/d81ZKbK+1BoPhgA0eEswMc2nlMOHSBf5oA==
X-Received: by 2002:a63:7c5a:: with SMTP id l26mr7933743pgn.397.1591348369144;
        Fri, 05 Jun 2020 02:12:49 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id 3sm6865141pfi.68.2020.06.05.02.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 02:12:47 -0700 (PDT)
Date:   Fri, 5 Jun 2020 02:12:46 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 4/4] platform/chrome: typec: Support DP alt mode
Message-ID: <20200605091246.GC98441@google.com>
References: <20200528113607.120841-1-pmalani@chromium.org>
 <20200528113607.120841-5-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528113607.120841-5-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, May 28, 2020 at 04:36:10AM -0700, Prashant Malani wrote:
> Handle Chrome EC mux events to configure on-board muxes correctly while
> entering DP alternate mode. Since we don't surface SVID and VDO
> information regarding the DP alternate mode, configure the Type C
> muxes directly from the port driver. Later, when mode discovery
> information is correctly surfaced to the driver, we can register the DP
> alternate mode driver and let it handle the mux configuration.
> 
> Also, modify the struct_typec_state state management to account for the
> addition of DP alternate mode.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
Sorry, forgot to mention (and will add to subsequent versions):
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 90 ++++++++++++++++++++++---
>  1 file changed, 80 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 9ebf9abed16f..509fc761906b 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -15,11 +15,18 @@
>  #include <linux/platform_device.h>
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_altmode.h>
> +#include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_mux.h>
>  #include <linux/usb/role.h>
>  
>  #define DRV_NAME "cros-ec-typec"
>  
> +/* Supported alt modes. */
> +enum {
> +	CROS_EC_ALTMODE_DP = 0,
> +	CROS_EC_ALTMODE_MAX,
> +};
> +
>  /* Per port data. */
>  struct cros_typec_port {
>  	struct typec_port *port;
> @@ -35,6 +42,9 @@ struct cros_typec_port {
>  	/* Variables keeping track of switch state. */
>  	struct typec_mux_state state;
>  	uint8_t mux_flags;
> +
> +	/* Port alt modes. */
> +	struct typec_altmode p_altmode[CROS_EC_ALTMODE_MAX];
>  };
>  
>  /* Platform-specific data for the Chrome OS EC Type C controller. */
> @@ -142,6 +152,24 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
>  	}
>  }
>  
> +/*
> + * Fake the alt mode structs until we actually start registering Type C port
> + * and partner alt modes.
> + */
> +static void cros_typec_register_port_altmodes(struct cros_typec_data *typec,
> +					      int port_num)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +
> +	/* All PD capable CrOS devices are assumed to support DP altmode. */
> +	port->p_altmode[CROS_EC_ALTMODE_DP].svid = USB_TYPEC_DP_SID;
> +	port->p_altmode[CROS_EC_ALTMODE_DP].mode = USB_TYPEC_DP_MODE;
> +
> +	port->state.alt = NULL;
> +	port->state.mode = TYPEC_STATE_USB;
> +	port->state.data = NULL;
> +}
> +
>  static int cros_typec_init_ports(struct cros_typec_data *typec)
>  {
>  	struct device *dev = typec->dev;
> @@ -205,6 +233,8 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  		if (ret)
>  			dev_dbg(dev, "No switch control for port %d\n",
>  				port_num);
> +
> +		cros_typec_register_port_altmodes(typec, port_num);
>  	}
>  
>  	return 0;
> @@ -361,8 +391,46 @@ static int cros_typec_usb_safe_state(struct cros_typec_port *port)
>  	return typec_mux_set(port->mux, &port->state);
>  }
>  
> +/* Spoof the VDOs that were likely communicated by the partner. */
> +static int cros_typec_enable_dp(struct cros_typec_data *typec,
> +				int port_num,
> +				struct ec_response_usb_pd_control_v2 *pd_ctrl)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +	struct typec_displayport_data dp_data;
> +	int ret;
> +
> +	if (typec->pd_ctrl_ver < 2) {
> +		dev_err(typec->dev,
> +			"PD_CTRL version too old: %d\n", typec->pd_ctrl_ver);
> +		return -ENOTSUPP;
> +	}
> +
> +	/* Status VDO. */
> +	dp_data.status = DP_STATUS_ENABLED;
> +	if (port->mux_flags & USB_PD_MUX_HPD_IRQ)
> +		dp_data.status |= DP_STATUS_IRQ_HPD;
> +	if (port->mux_flags & USB_PD_MUX_HPD_LVL)
> +		dp_data.status |= DP_STATUS_HPD_STATE;
> +
> +	/* Configuration VDO. */
> +	dp_data.conf = DP_CONF_SET_PIN_ASSIGN(pd_ctrl->dp_mode);
> +	if (!port->state.alt) {
> +		port->state.alt = &port->p_altmode[CROS_EC_ALTMODE_DP];
> +		ret = cros_typec_usb_safe_state(port);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	port->state.data = &dp_data;
> +	port->state.mode = TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
> +
> +	return typec_mux_set(port->mux, &port->state);
> +}
> +
>  int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
> -			     uint8_t mux_flags)
> +			     uint8_t mux_flags,
> +			     struct ec_response_usb_pd_control_v2 *pd_ctrl)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  	enum typec_orientation orientation;
> @@ -380,14 +448,15 @@ int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  	if (ret)
>  		return ret;
>  
> -	port->state.alt = NULL;
> -	port->state.mode = TYPEC_STATE_USB;
> -
> -	if (mux_flags & USB_PD_MUX_SAFE_MODE)
> +	if (mux_flags & USB_PD_MUX_DP_ENABLED) {
> +		ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
> +	} else if (mux_flags & USB_PD_MUX_SAFE_MODE) {
>  		ret = cros_typec_usb_safe_state(port);
> -	else if (mux_flags & USB_PD_MUX_USB_ENABLED)
> +	} else if (mux_flags & USB_PD_MUX_USB_ENABLED) {
> +		port->state.alt = NULL;
> +		port->state.mode = TYPEC_STATE_USB;
>  		ret = typec_mux_set(port->mux, &port->state);
> -	else {
> +	} else {
>  		dev_info(typec->dev,
>  			 "Unsupported mode requested, mux flags: %x\n",
>  			 mux_flags);
> @@ -400,7 +469,7 @@ int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  {
>  	struct ec_params_usb_pd_control req;
> -	struct ec_response_usb_pd_control_v1 resp;
> +	struct ec_response_usb_pd_control_v2 resp;
>  	struct ec_response_usb_pd_mux_info mux_resp;
>  	int ret;
>  
> @@ -427,7 +496,8 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  	dev_dbg(typec->dev, "State %d: %s\n", port_num, resp.state);
>  
>  	if (typec->pd_ctrl_ver != 0)
> -		cros_typec_set_port_params_v1(typec, port_num, &resp);
> +		cros_typec_set_port_params_v1(typec, port_num,
> +			(struct ec_response_usb_pd_control_v1 *)&resp);
>  	else
>  		cros_typec_set_port_params_v0(typec, port_num,
>  			(struct ec_response_usb_pd_control *) &resp);
> @@ -446,7 +516,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  		return 0;
>  
>  	typec->ports[port_num]->mux_flags = mux_resp.flags;
> -	ret = cros_typec_configure_mux(typec, port_num, mux_resp.flags);
> +	ret = cros_typec_configure_mux(typec, port_num, mux_resp.flags, &resp);
>  	if (ret)
>  		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
>  
> -- 
> 2.27.0.rc0.183.gde8f92d652-goog
> 
