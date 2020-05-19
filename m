Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D304C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32056207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgESVYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:24:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57650 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESVYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:24:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 10FDB2A03F5
Subject: Re: [PATCH v2 2/2] platform/chrome: typec: Register Type C switches
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Heikki Krogerus <heikki.krogerus@intel.linux.com>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20200518071707.161843-1-pmalani@chromium.org>
 <20200518071707.161843-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <cb86eb4a-3bce-48d0-5cf9-8126d3517f0e@collabora.com>
Date:   Tue, 19 May 2020 23:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518071707.161843-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for the patch.

On 18/5/20 9:17, Prashant Malani wrote:
> Register Type C mux and switch handles, when provided via firmware
> bindings. These will allow the cros-ec-typec driver, and also alternate
> mode drivers to configure connected Muxes correctly, according to PD
> information retrieved from the Chrome OS EC.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@intel.linux.com>

For my own reference:

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Patch 1/2 still needs a review from Rob, I'll wait for that before queue the
patches.

Thanks,
 Enric

> ---
> 
> Changes in v2:
> - Changed dev_info prints to dev_dbg.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 47 +++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 66b8d21092af..6e79f917314b 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -14,6 +14,8 @@
>  #include <linux/platform_data/cros_usbpd_notify.h>
>  #include <linux/platform_device.h>
>  #include <linux/usb/typec.h>
> +#include <linux/usb/typec_mux.h>
> +#include <linux/usb/role.h>
>  
>  #define DRV_NAME "cros-ec-typec"
>  
> @@ -25,6 +27,9 @@ struct cros_typec_port {
>  	struct typec_partner *partner;
>  	/* Port partner PD identity info. */
>  	struct usb_pd_identity p_identity;
> +	struct typec_switch *ori_sw;
> +	struct typec_mux *mux;
> +	struct usb_role_switch *role_sw;
>  };
>  
>  /* Platform-specific data for the Chrome OS EC Type C controller. */
> @@ -84,6 +89,40 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
>  	return 0;
>  }
>  
> +static int cros_typec_get_switch_handles(struct cros_typec_port *port,
> +					 struct fwnode_handle *fwnode,
> +					 struct device *dev)
> +{
> +	port->mux = fwnode_typec_mux_get(fwnode, NULL);
> +	if (IS_ERR(port->mux)) {
> +		dev_dbg(dev, "Mux handle not found.\n");
> +		goto mux_err;
> +	}
> +
> +	port->ori_sw = fwnode_typec_switch_get(fwnode);
> +	if (IS_ERR(port->ori_sw)) {
> +		dev_dbg(dev, "Orientation switch handle not found.\n");
> +		goto ori_sw_err;
> +	}
> +
> +	port->role_sw = fwnode_usb_role_switch_get(fwnode);
> +	if (IS_ERR(port->role_sw)) {
> +		dev_dbg(dev, "USB role switch handle not found.\n");
> +		goto role_sw_err;
> +	}
> +
> +	return 0;
> +
> +role_sw_err:
> +	usb_role_switch_put(port->role_sw);
> +ori_sw_err:
> +	typec_switch_put(port->ori_sw);
> +mux_err:
> +	typec_mux_put(port->mux);
> +
> +	return -ENODEV;
> +}
> +
>  static void cros_unregister_ports(struct cros_typec_data *typec)
>  {
>  	int i;
> @@ -91,6 +130,9 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
>  	for (i = 0; i < typec->num_ports; i++) {
>  		if (!typec->ports[i])
>  			continue;
> +		usb_role_switch_put(typec->ports[i]->role_sw);
> +		typec_switch_put(typec->ports[i]->ori_sw);
> +		typec_mux_put(typec->ports[i]->mux);
>  		typec_unregister_port(typec->ports[i]->port);
>  	}
>  }
> @@ -153,6 +195,11 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  			ret = PTR_ERR(cros_port->port);
>  			goto unregister_ports;
>  		}
> +
> +		ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
> +		if (ret)
> +			dev_dbg(dev, "No switch control for port %d\n",
> +				port_num);
>  	}
>  
>  	return 0;
> 
