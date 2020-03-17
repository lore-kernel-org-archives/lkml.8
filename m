Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042DDC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56F320663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgCQLJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:09:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:55398 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728995AbgCQLJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:09:52 -0400
IronPort-SDR: upN4Lle8p1HOnoqErtBg1gA/yI16yPnmw9SpYIGQI8dtS9jL0KclTBefYkABBFWl26Ou28JMeu
 ikB3QwrVjnCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 04:09:52 -0700
IronPort-SDR: DcubFaa8G9/CwOKUQ6thFIpoZ8Jo8KEl50diC5OSde67LgFhejYj16g5WhC20KhC/iW6SocgkM
 ZH7vkdC3zl5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="355330981"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Mar 2020 04:09:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Mar 2020 13:09:49 +0200
Date:   Tue, 17 Mar 2020 13:09:49 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v5 3/4] platform/chrome: typec: Get PD_CONTROL cmd version
Message-ID: <20200317110949.GB3015886@kuha.fi.intel.com>
References: <20200316090021.52148-1-pmalani@chromium.org>
 <20200316090021.52148-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316090021.52148-4-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:00:19AM -0700, Prashant Malani wrote:
> Query the EC to determine the version number of the PD_CONTROL
> command which is supported by the EC. Also store this value in the Type
> C data struct since it will be used to determine how to parse the
> response to queries for port information from the EC.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

In case there is v6, please consider merging this into patch 4/4. I
don't think this needs separate patch. Otherwise, FWIW:

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
> - Moved if statement check in the end of probe() from this patch to a
>   previous patch.
> 
> Changes in v2:
> - No changes.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 02e6d5cbbbf7a..9f692eb78b322 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -21,6 +21,7 @@ struct cros_typec_data {
>  	struct device *dev;
>  	struct cros_ec_device *ec;
>  	int num_ports;
> +	unsigned int cmd_ver;
>  	/* Array of ports, indexed by port number. */
>  	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
>  	/* Initial capabilities for each port. */
> @@ -171,6 +172,31 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
>  	return ret;
>  }
>  
> +static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> +{
> +	struct ec_params_get_cmd_versions_v1 req_v1;
> +	struct ec_response_get_cmd_versions resp;
> +	int ret;
> +
> +	/* We're interested in the PD control command version. */
> +	req_v1.cmd = EC_CMD_USB_PD_CONTROL;
> +	ret = cros_typec_ec_command(typec, 1, EC_CMD_GET_CMD_VERSIONS,
> +				    &req_v1, sizeof(req_v1), &resp,
> +				    sizeof(resp));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (resp.version_mask & EC_VER_MASK(1))
> +		typec->cmd_ver = 1;
> +	else
> +		typec->cmd_ver = 0;
> +
> +	dev_dbg(typec->dev, "PD Control has version mask 0x%hhx\n",
> +		typec->cmd_ver);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id cros_typec_acpi_id[] = {
>  	{ "GOOG0014", 0 },
> @@ -202,6 +228,12 @@ static int cros_typec_probe(struct platform_device *pdev)
>  	typec->ec = dev_get_drvdata(pdev->dev.parent);
>  	platform_set_drvdata(pdev, typec);
>  
> +	ret = cros_typec_get_cmd_version(typec);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get PD command version info\n");
> +		return ret;
> +	}
> +
>  	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
>  				    &resp, sizeof(resp));
>  	if (ret < 0)
> -- 
> 2.25.1.481.gfbce0eb801-goog

thanks,

-- 
heikki
