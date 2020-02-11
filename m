Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D51C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782DF20842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgBKKwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:52:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33860 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgBKKwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:52:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B9FDF294007
Subject: Re: [PATCH v2 3/4] platform/chrome: typec: Get PD_CONTROL cmd version
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, bleung@chromium.org,
        Guenter Roeck <groeck@chromium.org>
References: <20200207203752.209296-1-pmalani@chromium.org>
 <20200207203752.209296-4-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <01d3c407-d0e6-2495-30fe-68243050fe06@collabora.com>
Date:   Tue, 11 Feb 2020 11:52:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200207203752.209296-4-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 7/2/20 21:37, Prashant Malani wrote:
> Query the EC to determine the version number of the PD_CONTROL
> command which is supported by the EC. Also store this value in the Type
> C data struct since it will be used to determine how to parse the
> response to queries for port information from the EC.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v2:
> - No changes.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 34 ++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 8374ccfe784f3b..df01ce86c7146c 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -21,6 +21,7 @@ struct cros_typec_data {
>  	struct device *dev;
>  	struct cros_ec_device *ec;
>  	int num_ports;
> +	unsigned int cmd_ver;
>  	/* Array of ports, indexed by port number. */
>  	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
>  };
> @@ -152,6 +153,31 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
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
> @@ -182,6 +208,12 @@ static int cros_typec_probe(struct platform_device *pdev)
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
> @@ -196,7 +228,7 @@ static int cros_typec_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = cros_typec_init_ports(typec);
> -	if (!ret)
> +	if (ret < 0)

Looks like this change should be in patch 2/4?

>  		return ret;
>  
>  	return 0;
> 
