Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6CEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8F520724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCMMmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:42:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53284 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgCMMmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:42:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D97262970C5
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 2/3] platform/chrome: notify: Amend ACPI driver to plat
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     furquan@chromium.org, Benson Leung <bleung@chromium.org>
References: <20200312100809.21153-1-pmalani@chromium.org>
 <20200312100809.21153-3-pmalani@chromium.org>
Message-ID: <5f873d6f-5d30-758f-48e4-513b86b39378@collabora.com>
Date:   Fri, 13 Mar 2020 13:42:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312100809.21153-3-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 12/3/20 11:08, Prashant Malani wrote:
> Convert the ACPI driver into the equivalent platform driver, with the
> same ACPI match table as before. This allows the device driver to access
> the parent platform EC device and its cros_ec_device struct, which will
> be required to communicate with the EC to pull PD Host event information
> from it.
> 
> Also change the ACPI driver name to "cros-usbpd-notify-acpi" so that
> there is no confusion between it and the "regular" platform driver on
> platforms that have both CONFIG_ACPI and CONFIG_OF enabled.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_usbpd_notify.c | 82 ++++++++++++++++++---
>  1 file changed, 70 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
> index edcb346024b07..d2dbf7017e29c 100644
> --- a/drivers/platform/chrome/cros_usbpd_notify.c
> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> @@ -12,6 +12,7 @@
>  #include <linux/platform_device.h>
>  
>  #define DRV_NAME "cros-usbpd-notify"
> +#define DRV_NAME_PLAT_ACPI "cros-usbpd-notify-acpi"
>  #define ACPI_DRV_NAME "GOOG0003"
>  
>  static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
> @@ -54,14 +55,72 @@ EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
>  
>  #ifdef CONFIG_ACPI
>  
> -static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
> +static void cros_usbpd_notify_acpi(acpi_handle device, u32 event, void *data)
>  {
> +	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> +}
> +
> +static int cros_usbpd_notify_probe_acpi(struct platform_device *pdev)
> +{
> +	struct cros_usbpd_notify_data *pdnotify;
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev;
> +	struct cros_ec_device *ec_dev;
> +	acpi_status status;
> +
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev) {

I still missing some bits of the ACPI devices but is this possible?

The ACPI probe only will be called if there is a match so an ACPI device, I guess.

> +		dev_err(dev, "No ACPI device found.\n");
> +		return -ENODEV;
> +	}
> +
> +	pdnotify = devm_kzalloc(dev, sizeof(*pdnotify), GFP_KERNEL);
> +	if (!pdnotify)
> +		return -ENOMEM;
> +
> +	/* Get the EC device pointer needed to talk to the EC. */
> +	ec_dev = dev_get_drvdata(dev->parent);
> +	if (!ec_dev) {
> +		/*
> +		 * We continue even for older devices which don't have the
> +		 * correct device heirarchy, namely, GOOG0003 is a child
> +		 * of GOOG0004.
> +		 */
> +		dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");

I'm not sure this is correctly handled, see below ...


> +	}
> +
> +	pdnotify->dev = dev;
> +	pdnotify->ec = ec_dev;

If !ec_dev you'll assign a NULL pointer to pdnotify->ec. On the cases that
GOOG0003 is not a child of GOOG0004 I suspect you will get a NULL dereference
later in some other part of the code?

> +
> +	status = acpi_install_notify_handler(adev->handle,
> +					     ACPI_ALL_NOTIFY,
> +					     cros_usbpd_notify_acpi,
> +					     pdnotify);
> +	if (ACPI_FAILURE(status)) {
> +		dev_warn(dev, "Failed to register notify handler %08x\n",
> +			 status);
> +		return -EINVAL;
> +	}
> +
> +	dev_info(dev, "Chrome EC PD notify device registered.\n");
> +

This is only noise to the kernel log, remove it.

>  	return 0;
>  }
>  
> -static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
> +static int cros_usbpd_notify_remove_acpi(struct platform_device *pdev)
>  {
> -	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	if (!adev) {
> +		dev_err(dev, "No ACPI device found.\n");

Is this possible?

> +		return -ENODEV;
> +	}
> +
> +	acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
> +				   cros_usbpd_notify_acpi);
> +
> +	return 0;
>  }
>  
>  static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
> @@ -70,14 +129,13 @@ static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, cros_usbpd_notify_acpi_device_ids);
>  
> -static struct acpi_driver cros_usbpd_notify_acpi_driver = {
> -	.name = DRV_NAME,
> -	.class = DRV_NAME,
> -	.ids = cros_usbpd_notify_acpi_device_ids,
> -	.ops = {
> -		.add = cros_usbpd_notify_add_acpi,
> -		.notify = cros_usbpd_notify_acpi,
> +static struct platform_driver cros_usbpd_notify_acpi_driver = {

Nice, so it is converted to a platform_driver, now. This makes me think again if
we could just use a single platform_driver and register the acpi notifier in the
ACPI match case and use the non-acpi notifier on the OF case.

> +	.driver = {
> +		.name = DRV_NAME_PLAT_ACPI,
> +		.acpi_match_table = cros_usbpd_notify_acpi_device_ids,
>  	},
> +	.probe = cros_usbpd_notify_probe_acpi,
> +	.remove = cros_usbpd_notify_remove_acpi,
>  };
>  
>  #endif /* CONFIG_ACPI */
> @@ -159,7 +217,7 @@ static int __init cros_usbpd_notify_init(void)
>  		return ret;
>  
>  #ifdef CONFIG_ACPI
> -	acpi_bus_register_driver(&cros_usbpd_notify_acpi_driver);
> +	platform_driver_register(&cros_usbpd_notify_acpi_driver);
>  #endif
>  	return 0;
>  }
> @@ -167,7 +225,7 @@ static int __init cros_usbpd_notify_init(void)
>  static void __exit cros_usbpd_notify_exit(void)
>  {
>  #ifdef CONFIG_ACPI
> -	acpi_bus_unregister_driver(&cros_usbpd_notify_acpi_driver);
> +	platform_driver_unregister(&cros_usbpd_notify_acpi_driver);
>  #endif
>  	platform_driver_unregister(&cros_usbpd_notify_plat_driver);
>  }
> 
