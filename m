Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B230BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A732075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IoQCXgG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgFEJME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgFEJME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:12:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48ECC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 02:12:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d10so4864418pgn.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 02:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R3umsPvnSzwZU2xH3HFNy1drAh9yQ4MxxNA4Wtf6VCE=;
        b=IoQCXgG6Bgxl7u7NfB/tnixtdrJ5MGdAWZrz1yA6PL53QjsDHzh9HSrhiXdrgLt00G
         unt6lpkwAbu8uB7AWc0y4462QD7MK+Lzu/yNFL/Za5p8M6zq9ZNwe5aZAOI1HyLxnPTG
         /TGlHseCFiZ7wAz5aaFGI6xVtfdUCYtJJuWkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R3umsPvnSzwZU2xH3HFNy1drAh9yQ4MxxNA4Wtf6VCE=;
        b=ka/AaW3hbjhUvr8cQEKltjzTcQKxNHkC09ZWia9YtU6tJxVV5dPNmg7LqIQ4jEudt3
         ENyMGk1avq/cJDgBcYYF+aoY7karvyUgJqyWhJeH/qt1txXtPd3gHB0bU63a5e+jakcJ
         KV0S2ysujsyTMedQ7a1bOUJ0p+YLmTixmZ3yD8C/q0YOOoAvfMkx0tJSkiW/IipRwnUu
         Qu2/myssmcA20jnTA82XtpwJuL7+1Da4pvqRxDjbNrbZqYIU6ccSf9VgLy3gcSvWLnKv
         /dXK6gjMPTVSo3EQPq17T2/xw3dvjfhfYwzXiFikM63R5RvjfAaVdCglDsnPr56ShgE8
         KdWA==
X-Gm-Message-State: AOAM530tTqq1VzQAsntoZvpgX5xFSjS0jV4JE/3hakX81IMJMt0ghqkS
        7JapRUhBfO+VC/CJhBsDos5nYS4tr6U=
X-Google-Smtp-Source: ABdhPJwOgDIpgOGceUBQkaECw4ggPWCA1FnZhseIh9pSBPvDHPQgrEy4dRnCPHbsCfNwtQyco9RKzQ==
X-Received: by 2002:a05:6a00:2c3:: with SMTP id b3mr9179044pft.20.1591348322029;
        Fri, 05 Jun 2020 02:12:02 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id w6sm7270317pjy.15.2020.06.05.02.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 02:12:01 -0700 (PDT)
Date:   Fri, 5 Jun 2020 02:12:00 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 3/4] platform/chrome: typec: Add USB mux control
Message-ID: <20200605091200.GB98441@google.com>
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

Hi,

On Thu, May 28, 2020 at 04:36:07AM -0700, Prashant Malani wrote:
> Add support to configure various Type C switches appropriately using the
> Type C connector class API, when the Chrome OS EC informs the AP that
> the USB operating mode has been entered.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
Forgot to mention (and will add in subsequent versions):
Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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
> 
