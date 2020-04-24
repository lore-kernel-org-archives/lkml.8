Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6CBC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B770020767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgDXLgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:36:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:40392 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgDXLgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:36:32 -0400
IronPort-SDR: Kebrq8v6JEcnldjX7rpb/IULwVXfr0Q64oOmZKPD2NJWTOKCob0SwG7GeFwtLySKXY42RktKi3
 5II2Tw4aeUWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 04:36:32 -0700
IronPort-SDR: Zv1XQsnCbqAAkdkjaL1/fIzxcODcfmHGKS6fmVD0B8qRxGCIIzktBorvwINQcos/2ij8JRYSx6
 m+Tvk52l0XpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="366323045"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 24 Apr 2020 04:36:29 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 24 Apr 2020 14:36:28 +0300
Date:   Fri, 24 Apr 2020 14:36:28 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, twawrzynczak@chromium.org,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] platform/chrome: typec: Register Type C switches
Message-ID: <20200424113628.GC1575367@kuha.fi.intel.com>
References: <20200422222242.241699-1-pmalani@chromium.org>
 <20200422222242.241699-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422222242.241699-2-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:22:41PM -0700, Prashant Malani wrote:
> Register Type C mux and switch handles, when provided via firmware
> bindings. These will allow the cros-ec-typec driver, and also alternate
> mode drivers to configure connected Muxes correctly, according to PD
> information retrieved from the Chrome OS EC.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@intel.linux.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 47 +++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index eda57db26f8d..324ead297c4d 100644
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
> +		dev_info(dev, "Mux handle not found.\n");
> +		goto mux_err;
> +	}
> +
> +	port->ori_sw = fwnode_typec_switch_get(fwnode);
> +	if (IS_ERR(port->ori_sw)) {
> +		dev_info(dev, "Orientation switch handle not found.\n");
> +		goto ori_sw_err;
> +	}
> +
> +	port->role_sw = fwnode_usb_role_switch_get(fwnode);
> +	if (IS_ERR(port->role_sw)) {
> +		dev_info(dev, "USB role switch handle not found.\n");
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
> +			dev_info(dev, "No switch control for port %d\n",
> +				 port_num);
>  	}
>  
>  	return 0;
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog

thanks,

-- 
heikki
