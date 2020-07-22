Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66266C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A2B207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbgGVP2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGVP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:28:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE3C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:28:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 81B4C2982CB
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Unregister partner on
 error
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200715234928.3090367-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <bfe33351-fc64-81a8-4cc5-e8122a2a44e1@collabora.com>
Date:   Wed, 22 Jul 2020 17:28:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715234928.3090367-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for your patch.

On 16/7/20 1:49, Prashant Malani wrote:
> When port update is called during probe(), any error with setting the
> Type C muxes results in an errno being returned to probe(), which promptly
> returns that itself. Ensure that we unregister any registered partners
> when doing so, to prevent orphaned partners on the Type C connector
> class framework.
> 
> Move the cros_typec_add_partner() and cros_typec_remove_partner() code
> together to higher up in the file, so that they are together, and we can
> call cros_typec_remove_partner() from cros_unregister_ports().
> 
> Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Queued for 5.9

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 83 +++++++++++++------------
>  1 file changed, 42 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 0c041b79cbba..43e7cf367a07 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -140,6 +140,47 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
>  	return -ENODEV;
>  }
>  
> +static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
> +				  bool pd_en)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +	struct typec_partner_desc p_desc = {
> +		.usb_pd = pd_en,
> +	};
> +	int ret = 0;
> +
> +	/*
> +	 * Fill an initial PD identity, which will then be updated with info
> +	 * from the EC.
> +	 */
> +	p_desc.identity = &port->p_identity;
> +
> +	port->partner = typec_register_partner(port->port, &p_desc);
> +	if (IS_ERR(port->partner)) {
> +		ret = PTR_ERR(port->partner);
> +		port->partner = NULL;
> +	}
> +
> +	return ret;
> +}
> +
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
>  static void cros_unregister_ports(struct cros_typec_data *typec)
>  {
>  	int i;
> @@ -147,6 +188,7 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
>  	for (i = 0; i < typec->num_ports; i++) {
>  		if (!typec->ports[i])
>  			continue;
> +		cros_typec_remove_partner(typec, i);
>  		usb_role_switch_put(typec->ports[i]->role_sw);
>  		typec_switch_put(typec->ports[i]->ori_sw);
>  		typec_mux_put(typec->ports[i]->mux);
> @@ -285,47 +327,6 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
>  	return ret;
>  }
>  
> -static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
> -				  bool pd_en)
> -{
> -	struct cros_typec_port *port = typec->ports[port_num];
> -	struct typec_partner_desc p_desc = {
> -		.usb_pd = pd_en,
> -	};
> -	int ret = 0;
> -
> -	/*
> -	 * Fill an initial PD identity, which will then be updated with info
> -	 * from the EC.
> -	 */
> -	p_desc.identity = &port->p_identity;
> -
> -	port->partner = typec_register_partner(port->port, &p_desc);
> -	if (IS_ERR(port->partner)) {
> -		ret = PTR_ERR(port->partner);
> -		port->partner = NULL;
> -	}
> -
> -	return ret;
> -}
> -
> -static void cros_typec_remove_partner(struct cros_typec_data *typec,
> -				     int port_num)
> -{
> -	struct cros_typec_port *port = typec->ports[port_num];
> -
> -	port->state.alt = NULL;
> -	port->state.mode = TYPEC_STATE_USB;
> -	port->state.data = NULL;
> -
> -	usb_role_switch_set_role(port->role_sw, USB_ROLE_NONE);
> -	typec_switch_set(port->ori_sw, TYPEC_ORIENTATION_NONE);
> -	typec_mux_set(port->mux, &port->state);
> -
> -	typec_unregister_partner(port->partner);
> -	port->partner = NULL;
> -}
> -
>  static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
>  		int port_num, struct ec_response_usb_pd_control *resp)
>  {
> 
