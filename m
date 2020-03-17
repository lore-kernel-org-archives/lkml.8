Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8A8C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648C920752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgCQLKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:10:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:1480 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbgCQLKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:10:36 -0400
IronPort-SDR: 4QgzKK/1+0Z0WTZZY8dMjBTFpnVMxVmYbQnlVVcCnpaTYaM3fLUCJvfLqnDhUrP3WwCy1HZM9F
 lopsuTMCxQiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 04:10:35 -0700
IronPort-SDR: sVQKvxbQe9sOZGKHSB7RHRSk0PG1hS7mfqR62mo/5CjOwX3N5niTvK/52RBOL6q2+QqBxTSdCW
 i2gCnGIuzoIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="355331166"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Mar 2020 04:10:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Mar 2020 13:10:31 +0200
Date:   Tue, 17 Mar 2020 13:10:31 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jon Flatley <jflat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v5 4/4] platform/chrome: typec: Update port info from EC
Message-ID: <20200317111031.GC3015886@kuha.fi.intel.com>
References: <20200316090021.52148-1-pmalani@chromium.org>
 <20200316090021.52148-5-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316090021.52148-5-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:00:21AM -0700, Prashant Malani wrote:
> After registering the ports at probe, get the current port information
> from EC and update the Type C connector class ports accordingly.
> 
> Co-developed-by: Jon Flatley <jflat@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v5:
> - No changes.
> 
> Changes in v4:
> - No changes
> 
> Changes in v3:
> - No changes.
> 
> Changes in v2:
> - No changes.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 89 ++++++++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 9f692eb78b322..874269c070739 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -172,6 +172,81 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
>  	return ret;
>  }
>  
> +static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
> +		int port_num, struct ec_response_usb_pd_control *resp)
> +{
> +	struct typec_port *port = typec->ports[port_num];
> +	enum typec_orientation polarity;
> +
> +	if (!resp->enabled)
> +		polarity = TYPEC_ORIENTATION_NONE;
> +	else if (!resp->polarity)
> +		polarity = TYPEC_ORIENTATION_NORMAL;
> +	else
> +		polarity = TYPEC_ORIENTATION_REVERSE;
> +
> +	typec_set_pwr_role(port, resp->role ? TYPEC_SOURCE : TYPEC_SINK);
> +	typec_set_orientation(port, polarity);
> +}
> +
> +static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
> +		int port_num, struct ec_response_usb_pd_control_v1 *resp)
> +{
> +	struct typec_port *port = typec->ports[port_num];
> +	enum typec_orientation polarity;
> +
> +	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
> +		polarity = TYPEC_ORIENTATION_NONE;
> +	else if (!resp->polarity)
> +		polarity = TYPEC_ORIENTATION_NORMAL;
> +	else
> +		polarity = TYPEC_ORIENTATION_REVERSE;
> +	typec_set_orientation(port, polarity);
> +	typec_set_data_role(port, resp->role & PD_CTRL_RESP_ROLE_DATA ?
> +			TYPEC_HOST : TYPEC_DEVICE);
> +	typec_set_pwr_role(port, resp->role & PD_CTRL_RESP_ROLE_POWER ?
> +			TYPEC_SOURCE : TYPEC_SINK);
> +	typec_set_vconn_role(port, resp->role & PD_CTRL_RESP_ROLE_VCONN ?
> +			TYPEC_SOURCE : TYPEC_SINK);
> +}
> +
> +static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> +{
> +	struct ec_params_usb_pd_control req;
> +	struct ec_response_usb_pd_control_v1 resp;
> +	int ret;
> +
> +	if (port_num < 0 || port_num >= typec->num_ports) {
> +		dev_err(typec->dev, "cannot get status for invalid port %d\n",
> +			port_num);
> +		return -EINVAL;
> +	}
> +
> +	req.port = port_num;
> +	req.role = USB_PD_CTRL_ROLE_NO_CHANGE;
> +	req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
> +	req.swap = USB_PD_CTRL_SWAP_NONE;
> +
> +	ret = cros_typec_ec_command(typec, typec->cmd_ver,
> +				    EC_CMD_USB_PD_CONTROL, &req, sizeof(req),
> +				    &resp, sizeof(resp));
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(typec->dev, "Enabled %d: 0x%hhx\n", port_num, resp.enabled);
> +	dev_dbg(typec->dev, "Role %d: 0x%hhx\n", port_num, resp.role);
> +	dev_dbg(typec->dev, "Polarity %d: 0x%hhx\n", port_num, resp.polarity);
> +	dev_dbg(typec->dev, "State %d: %s\n", port_num, resp.state);
> +
> +	if (typec->cmd_ver == 1)
> +		cros_typec_set_port_params_v1(typec, port_num, &resp);
> +	else
> +		cros_typec_set_port_params_v0(typec, port_num,
> +			(struct ec_response_usb_pd_control *) &resp);
> +
> +	return 0;
> +}
> +
>  static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
>  {
>  	struct ec_params_get_cmd_versions_v1 req_v1;
> @@ -218,7 +293,7 @@ static int cros_typec_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct cros_typec_data *typec;
>  	struct ec_response_usb_pd_ports resp;
> -	int ret;
> +	int ret, i;
>  
>  	typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
>  	if (!typec)
> @@ -251,7 +326,19 @@ static int cros_typec_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	for (i = 0; i < typec->num_ports; i++) {
> +		ret = cros_typec_port_update(typec, i);
> +		if (ret < 0)
> +			goto unregister_ports;
> +	}
> +
>  	return 0;
> +
> +unregister_ports:
> +	for (i = 0; i < typec->num_ports; i++)
> +		if (typec->ports[i])
> +			typec_unregister_port(typec->ports[i]);
> +	return ret;
>  }
>  
>  static struct platform_driver cros_typec_driver = {
> -- 
> 2.25.1.481.gfbce0eb801-goog

thanks,

-- 
heikki
