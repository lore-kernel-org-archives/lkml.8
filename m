Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5ECC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76701206F7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgDIVkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:40:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42244 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDIVko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:40:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 287EA297BA7
Subject: Re: [PATCH 3/3] platform/chrome: typec: Register port partner
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, Jon Flatley <jflat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200407010940.155490-1-pmalani@chromium.org>
 <20200407010940.155490-4-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <6ad18c9b-6c51-e08a-fb45-d97c9722a693@collabora.com>
Date:   Thu, 9 Apr 2020 23:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407010940.155490-4-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for your patch.

On 7/4/20 3:09, Prashant Malani wrote:
> Register (and unregister) the port partner when a connect (and
> disconnect) is detected.
> 
> Co-developed-by: Jon Flatley <jflat@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 47 +++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 1955e1dfebc6d..e7d4d6ccccca6 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -22,6 +22,9 @@ struct cros_typec_port {
>  	struct typec_port *port;
>  	/* Initial capabilities for the port. */
>  	struct typec_capability caps;
> +	struct typec_partner *partner;
> +	/* Port partner PD identity info. */
> +	struct usb_pd_identity p_identity;
>  };
>  
>  /* Platform-specific data for the Chrome OS EC Type C controller. */
> @@ -191,6 +194,29 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
>  	return ret;
>  }
>  
> +static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
> +				  bool pd_en)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +	struct typec_partner_desc p_desc = {
> +		.usb_pd = pd_en,
> +	};
> +
> +	/*
> +	 * Fill an initial PD identity, which will then be updated with info
> +	 * from the EC.
> +	 */
> +	p_desc.identity = &port->p_identity;
> +
> +	port->partner = typec_register_partner(port->port, &p_desc);
> +	if (IS_ERR_OR_NULL(port->partner)) {
> +		port->partner = NULL;
> +		return PTR_ERR(port->partner);

This is always returning PTR_ERR(NULL) that yields 0, that's not what you want.
A static checker warning will be triggered.


> +	}
> +
> +	return 0;
> +}
> +
>  static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
>  		int port_num, struct ec_response_usb_pd_control *resp)
>  {
> @@ -213,6 +239,8 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
>  {
>  	struct typec_port *port = typec->ports[port_num]->port;
>  	enum typec_orientation polarity;
> +	bool pd_en;
> +	int ret;
>  
>  	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
>  		polarity = TYPEC_ORIENTATION_NONE;
> @@ -227,6 +255,25 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
>  			TYPEC_SOURCE : TYPEC_SINK);
>  	typec_set_vconn_role(port, resp->role & PD_CTRL_RESP_ROLE_VCONN ?
>  			TYPEC_SOURCE : TYPEC_SINK);
> +
> +	/* Register/remove partners when a connect/disconnect occurs. */
> +	if (resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED) {
> +		if (typec->ports[port_num]->partner)
> +			return;
> +
> +		pd_en = resp->enabled & PD_CTRL_RESP_ENABLED_PD_CAPABLE;
> +		ret = cros_typec_add_partner(typec, port_num, pd_en);
> +		if (!ret)
> +			dev_warn(typec->dev,
> +				 "Failed to register partner on port: %d\n",
> +				 port_num);
> +	} else {
> +		if (!typec->ports[port_num]->partner)
> +			return;
> +
> +		typec_unregister_partner(typec->ports[port_num]->partner);
> +		typec->ports[port_num]->partner = NULL;
> +	}
>  }
>  
>  static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> 
