Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21D9C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84BF206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406896AbgDNHvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:51:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:56952 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406887AbgDNHvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:51:44 -0400
IronPort-SDR: 4K8u486T520x7WCGCVq5pi9fnNa80BxsVxIeD03KHLFbUAZnYwp4Hy17f/7X4ojPQnGE/e4PnU
 EepXuEazTsCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 00:51:42 -0700
IronPort-SDR: f5LxvHPDvb3L6pF1VJ6270DRqEL0kj1MnmpwZG28X1T4xNF+Wi73/PHI9HJdMOoK/251IFfeON
 bwPkzCRmkU7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="363305097"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Apr 2020 00:51:39 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Apr 2020 10:51:38 +0300
Date:   Tue, 14 Apr 2020 10:51:38 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 2/3] platform/chrome: typec: Add struct for port data
Message-ID: <20200414075138.GB2828150@kuha.fi.intel.com>
References: <20200410002316.202107-1-pmalani@chromium.org>
 <20200410002316.202107-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410002316.202107-3-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 05:23:16PM -0700, Prashant Malani wrote:
> Add a separate struct for storing port data, including Type C connector
> class struct pointers and caps.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
> - No changes.
> 
> Changes in v2:
> - Removed unrequired devm_kfree() call.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 48 ++++++++++++++++---------
>  1 file changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index d444dd7422a2a..56ded09a60ffb 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -17,6 +17,13 @@
>  
>  #define DRV_NAME "cros-ec-typec"
>  
> +/* Per port data. */
> +struct cros_typec_port {
> +	struct typec_port *port;
> +	/* Initial capabilities for the port. */
> +	struct typec_capability caps;
> +};
> +
>  /* Platform-specific data for the Chrome OS EC Type C controller. */
>  struct cros_typec_data {
>  	struct device *dev;
> @@ -24,9 +31,7 @@ struct cros_typec_data {
>  	int num_ports;
>  	unsigned int cmd_ver;
>  	/* Array of ports, indexed by port number. */
> -	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
> -	/* Initial capabilities for each port. */
> -	struct typec_capability *caps[EC_USB_PD_MAX_PORTS];
> +	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
>  	struct notifier_block nb;
>  };
>  
> @@ -76,14 +81,25 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
>  	return 0;
>  }
>  
> +static void cros_unregister_ports(struct cros_typec_data *typec)
> +{
> +	int i;
> +
> +	for (i = 0; i < typec->num_ports; i++) {
> +		if (!typec->ports[i])
> +			continue;
> +		typec_unregister_port(typec->ports[i]->port);
> +	}
> +}
> +
>  static int cros_typec_init_ports(struct cros_typec_data *typec)
>  {
>  	struct device *dev = typec->dev;
>  	struct typec_capability *cap;
>  	struct fwnode_handle *fwnode;
> +	struct cros_typec_port *cros_port;
>  	const char *port_prop;
>  	int ret;
> -	int i;
>  	int nports;
>  	u32 port_num = 0;
>  
> @@ -115,22 +131,23 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  
>  		dev_dbg(dev, "Registering port %d\n", port_num);
>  
> -		cap = devm_kzalloc(dev, sizeof(*cap), GFP_KERNEL);
> -		if (!cap) {
> +		cros_port = devm_kzalloc(dev, sizeof(*cros_port), GFP_KERNEL);
> +		if (!cros_port) {
>  			ret = -ENOMEM;
>  			goto unregister_ports;
>  		}
>  
> -		typec->caps[port_num] = cap;
> +		typec->ports[port_num] = cros_port;
> +		cap = &cros_port->caps;
>  
>  		ret = cros_typec_parse_port_props(cap, fwnode, dev);
>  		if (ret < 0)
>  			goto unregister_ports;
>  
> -		typec->ports[port_num] = typec_register_port(dev, cap);
> -		if (IS_ERR(typec->ports[port_num])) {
> +		cros_port->port = typec_register_port(dev, cap);
> +		if (IS_ERR(cros_port->port)) {
>  			dev_err(dev, "Failed to register port %d\n", port_num);
> -			ret = PTR_ERR(typec->ports[port_num]);
> +			ret = PTR_ERR(cros_port->port);
>  			goto unregister_ports;
>  		}
>  	}
> @@ -138,8 +155,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  	return 0;
>  
>  unregister_ports:
> -	for (i = 0; i < typec->num_ports; i++)
> -		typec_unregister_port(typec->ports[i]);
> +	cros_unregister_ports(typec);
>  	return ret;
>  }
>  
> @@ -177,7 +193,7 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
>  static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
>  		int port_num, struct ec_response_usb_pd_control *resp)
>  {
> -	struct typec_port *port = typec->ports[port_num];
> +	struct typec_port *port = typec->ports[port_num]->port;
>  	enum typec_orientation polarity;
>  
>  	if (!resp->enabled)
> @@ -194,7 +210,7 @@ static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
>  static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
>  		int port_num, struct ec_response_usb_pd_control_v1 *resp)
>  {
> -	struct typec_port *port = typec->ports[port_num];
> +	struct typec_port *port = typec->ports[port_num]->port;
>  	enum typec_orientation polarity;
>  
>  	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
> @@ -358,9 +374,7 @@ static int cros_typec_probe(struct platform_device *pdev)
>  	return 0;
>  
>  unregister_ports:
> -	for (i = 0; i < typec->num_ports; i++)
> -		if (typec->ports[i])
> -			typec_unregister_port(typec->ports[i]);
> +	cros_unregister_ports(typec);
>  	return ret;
>  }
>  
> -- 
> 2.26.0.110.g2183baf09c-goog

thanks,

-- 
heikki
