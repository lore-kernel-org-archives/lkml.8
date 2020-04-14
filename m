Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D933C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F592206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406909AbgDNHwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:52:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:6964 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406887AbgDNHwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:52:24 -0400
IronPort-SDR: x/PdOuiXyhwBKAgjAtZicQUnmQKAYBSqISUxKrEAmYiZezXHbYXRfQ+6JGIMmBua/wipdOpax5
 YJl1+sLG2RXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 00:52:23 -0700
IronPort-SDR: kLNbLWDZtX/iLzL1GgNr41X3oREmhHHxrleJ+6yjOatBdph8c2WqIFTqJOjaUbR63J81G4WgMs
 5m1VCBO+whgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="363305205"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Apr 2020 00:52:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Apr 2020 10:52:19 +0300
Date:   Tue, 14 Apr 2020 10:52:19 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jon Flatley <jflat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 3/3] platform/chrome: typec: Register port partner
Message-ID: <20200414075219.GC2828150@kuha.fi.intel.com>
References: <20200410002316.202107-1-pmalani@chromium.org>
 <20200410002316.202107-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410002316.202107-4-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 05:23:17PM -0700, Prashant Malani wrote:
> Register (and unregister) the port partner when a connect (and
> disconnect) is detected.
> 
> Co-developed-by: Jon Flatley <jflat@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
> - No changes.
> 
> Changes in v2:
> - Fixed error pointer return value.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 48 +++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 56ded09a60ffb..304e0b20f279b 100644
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
> @@ -190,6 +193,30 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
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
> +	int ret = 0;
> +
> +	/*
> +	 * Fill an initial PD identity, which will then be updated with info
> +	 * from the EC.
> +	 */
> +	p_desc.identity = &port->p_identity;
> +
> +	port->partner = typec_register_partner(port->port, &p_desc);
> +	if (IS_ERR_OR_NULL(port->partner)) {
> +		ret = PTR_ERR(port->partner);
> +		port->partner = NULL;
> +	}
> +
> +	return ret;
> +}
> +
>  static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
>  		int port_num, struct ec_response_usb_pd_control *resp)
>  {
> @@ -212,6 +239,8 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
>  {
>  	struct typec_port *port = typec->ports[port_num]->port;
>  	enum typec_orientation polarity;
> +	bool pd_en;
> +	int ret;
>  
>  	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
>  		polarity = TYPEC_ORIENTATION_NONE;
> @@ -226,6 +255,25 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
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
> -- 
> 2.26.0.110.g2183baf09c-goog

thanks,

-- 
heikki
