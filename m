Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E2AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0A0206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbgF2VBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbgF2TM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A84BC008627
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:51:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 06A662A1309
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Add PM support
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200627045840.1314019-1-pmalani@chromium.org>
 <20200627045840.1314019-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <cf26168d-bc97-7e35-6f86-a769a36fcc4a@collabora.com>
Date:   Mon, 29 Jun 2020 12:51:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200627045840.1314019-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for the patch.

On 27/6/20 6:58, Prashant Malani wrote:
> Define basic suspend resume functions for cros-ec-typec. On suspend, we
> simply ensure that any pending port update work is completed, and on
> resume, we re-poll the port state to account for any
> changes/disconnections that might have occurred during suspend.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 34 +++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 630170fb2cbe..68f15a47450c 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -725,11 +725,45 @@ static int cros_typec_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int cros_typec_suspend(struct device *dev)

I'd prefer if you can mark these function as __maybe_unused (to avoid the
compiler warning) rather than wrapping it in a preprocessor conditional, it
makes the code a bit more simple.

> +{
> +	struct cros_typec_data *typec = dev_get_drvdata(dev);
> +
> +	cancel_work_sync(&typec->port_work);
> +
> +	return 0;
> +}
> +
> +static int cros_typec_resume(struct device *dev)

__maybe_unused ?

> +{
> +	struct cros_typec_data *typec = dev_get_drvdata(dev);
> +
> +	/* Refresh port state. */
> +	schedule_work(&typec->port_work);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops cros_typec_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(cros_typec_suspend, cros_typec_resume)
> +};
> +
> +#define DEV_PM_OPS	(&cros_typec_pm_ops)
> +
> +#else
> +
> +#define DEV_PM_OPS	NULL
> +
> +#endif /* CONFIG_PM_SLEEP */

and remove the ifdefy

> +
>  static struct platform_driver cros_typec_driver = {
>  	.driver	= {
>  		.name = DRV_NAME,
>  		.acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
>  		.of_match_table = of_match_ptr(cros_typec_of_match),
> +		.pm = DEV_PM_OPS,

		.pm = &cros_typec_pm_ops,

>  	},
>  	.probe = cros_typec_probe,
>  };
> 

Thanks,
 Enric
