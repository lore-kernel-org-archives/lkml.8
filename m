Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D14C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A5720734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgFPH1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:27:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:65107 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgFPH1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:27:43 -0400
IronPort-SDR: HV02BNYOTiTkinty+sF5SMQwaVTaYmlTIl1eD7Jyg9vDrG2mUVXh1tUh54yaBwkZUqRGoEFyZv
 Di7ohmvNj08A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 00:27:42 -0700
IronPort-SDR: xuPOgqbcjWIfqTyCN7fSoIG74+tUP65V+spfpDjkBfyhFT2BBB5aR1uRVe/wKZa/2FmqZt1QfN
 7epwvZ/lcs6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="382792291"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 16 Jun 2020 00:27:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 16 Jun 2020 10:27:38 +0300
Date:   Tue, 16 Jun 2020 10:27:38 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH 2/4] platform/chrome: typec: Register PD CTRL cmd v2
Message-ID: <20200616072738.GH3213128@kuha.fi.intel.com>
References: <20200528113607.120841-1-pmalani@chromium.org>
 <20200528113607.120841-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528113607.120841-3-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:36:05AM -0700, Prashant Malani wrote:
> Recognize EC_CMD_USB_PD_CONTROL command version 2. This is necessary in
> order to process Type C mux information (like DP alt mode pin
> configuration), which is needed by the Type C Connector class API to
> configure the Type C muxes correctly
> 
> While we are here, rename the struct member storing this version number
> from cmd_ver to pd_ctrl_ver, which more accurately reflects what is
> being stored.
> 
> Also, slightly change the logic for calling
> cros_typec_set_port_params_*(). Now, v0 is called when pd_ctrl_ver is 0,
> and v1 is called otherwise.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

LGTM. One nitpick bellow, but don't prepare v2 just because of that.
FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 6e79f917314b..d69a88464cef 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -37,7 +37,7 @@ struct cros_typec_data {
>  	struct device *dev;
>  	struct cros_ec_device *ec;
>  	int num_ports;
> -	unsigned int cmd_ver;
> +	unsigned int pd_ctrl_ver;
>  	/* Array of ports, indexed by port number. */
>  	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
>  	struct notifier_block nb;
> @@ -340,7 +340,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  	req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
>  	req.swap = USB_PD_CTRL_SWAP_NONE;
>  
> -	ret = cros_typec_ec_command(typec, typec->cmd_ver,
> +	ret = cros_typec_ec_command(typec, typec->pd_ctrl_ver,
>  				    EC_CMD_USB_PD_CONTROL, &req, sizeof(req),
>  				    &resp, sizeof(resp));
>  	if (ret < 0)
> @@ -351,7 +351,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  	dev_dbg(typec->dev, "Polarity %d: 0x%hhx\n", port_num, resp.polarity);
>  	dev_dbg(typec->dev, "State %d: %s\n", port_num, resp.state);
>  
> -	if (typec->cmd_ver == 1)
> +	if (typec->pd_ctrl_ver != 0)

How about:

        if (typec->pd_ctrl_ver)

>  		cros_typec_set_port_params_v1(typec, port_num, &resp);
>  	else
>  		cros_typec_set_port_params_v0(typec, port_num,
> @@ -374,13 +374,15 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (resp.version_mask & EC_VER_MASK(1))
> -		typec->cmd_ver = 1;
> +	if (resp.version_mask & EC_VER_MASK(2))
> +		typec->pd_ctrl_ver = 2;
> +	else if (resp.version_mask & EC_VER_MASK(1))
> +		typec->pd_ctrl_ver = 1;
>  	else
> -		typec->cmd_ver = 0;
> +		typec->pd_ctrl_ver = 0;
>  
>  	dev_dbg(typec->dev, "PD Control has version mask 0x%hhx\n",
> -		typec->cmd_ver);
> +		typec->pd_ctrl_ver);
>  
>  	return 0;
>  }

thanks,

-- 
heikki
