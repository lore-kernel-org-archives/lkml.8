Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6C2C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70312074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgDIVT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:19:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42166 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgDIVTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:19:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 055ED297E47
Subject: Re: [PATCH 2/3] platform/chrome: typec: Add struct for port data
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200407010940.155490-1-pmalani@chromium.org>
 <20200407010940.155490-3-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e124df15-396b-8599-23ad-153196f6787f@collabora.com>
Date:   Thu, 9 Apr 2020 23:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407010940.155490-3-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for the patch.

On 7/4/20 3:09, Prashant Malani wrote:
> Add a separate struct for storing port data, including Type C connector
> class struct pointers and caps.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 49 ++++++++++++++++---------
>  1 file changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index cf7c2652a1d6d..1955e1dfebc6d 100644
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
> @@ -76,14 +81,26 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
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
> +		devm_kfree(typec->dev, typec->ports[i]);

This is not needed, the allocated memory is device managed, so will be freed on
removal or error.

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
> @@ -115,22 +132,23 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
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
> @@ -138,8 +156,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  	return 0;
>  
>  unregister_ports:
> -	for (i = 0; i < typec->num_ports; i++)
> -		typec_unregister_port(typec->ports[i]);
> +	cros_unregister_ports(typec);
>  	return ret;
>  }
>  
> @@ -177,7 +194,7 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
>  static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
>  		int port_num, struct ec_response_usb_pd_control *resp)
>  {
> -	struct typec_port *port = typec->ports[port_num];
> +	struct typec_port *port = typec->ports[port_num]->port;
>  	enum typec_orientation polarity;
>  
>  	if (!resp->enabled)
> @@ -194,7 +211,7 @@ static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
>  static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
>  		int port_num, struct ec_response_usb_pd_control_v1 *resp)
>  {
> -	struct typec_port *port = typec->ports[port_num];
> +	struct typec_port *port = typec->ports[port_num]->port;
>  	enum typec_orientation polarity;
>  
>  	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
> @@ -360,9 +377,7 @@ static int cros_typec_probe(struct platform_device *pdev)
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
> 
