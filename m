Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1E6C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662D62465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgANRIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:08:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34254 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:08:00 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A309E28BCD9
Subject: Re: [PATCH v5 1/2] platform: chrome: Add cros-usbpd-notify driver
To:     Prashant Malani <pmalani@chromium.org>, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
References: <20200114031056.44502-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b39666db-38e4-c131-bfbb-077a53a8ef69@collabora.com>
Date:   Tue, 14 Jan 2020 18:07:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200114031056.44502-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 14/1/20 4:10, Prashant Malani wrote:
> From: Jon Flatley <jflat@chromium.org>
> 
> ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
> related events. The existing cros-usbpd-charger driver relies on these
> events without ever actually receiving them on ACPI platforms. This is
> because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
> ACPI driver that offers firmware updates to USB-C chargers.
> 
> Introduce a new platform driver under cros-ec, the ChromeOS embedded
> controller, that handles these PD events and dispatches them
> appropriately over a notifier chain to all drivers that use them.
> 
> On platforms that don't have the ACPI device defined, the driver gets
> instantiated for ECs which support the EC_FEATURE_USB_PD feature bit,
> and the notification events will get delivered using the MKBP event
> handling mechanism.
> 
> Co-Developed-by: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Jon Flatley <jflat@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v5(pmalani@chromium.org):
> - Split the driver into platform and ACPI variants, each enclosed by
>   CONFIG_OF and CONFIG_ACPI #ifdefs respectively.
> - Updated the copyright year to 2020.
> - Reworded the commit message and Kconfig description to incorporate
>   the modified driver structure.
> 
> Changes in v4(pmalani@chromium.org):
> - No code changes, but added new version so that versioning is
>   consistent with the next patch in the series.
> 
> Changes in v3 (pmalani@chromium.org):
> - Renamed driver and files from "cros_ec_pd_notify" to
>   "cros_usbpd_notify" to be more consistent with other naming.
> - Moved the change to include cros-usbpd-notify in the charger MFD
>   into a separate follow-on patch.
> 
> Changes in v2 (pmalani@chromium.org):
> - Removed dependency on DT entry; instead, we will instantiate
>   the driver on detecting EC_FEATURE_USB_PD for non-ACPI platforms.
> - Modified the cros-ec-pd-notify device to be an mfd_cell under
>   usbpdcharger for non-ACPI platforms. Altered the platform_probe() call
>   to derive the cros EC structs appropriately.
> - Replaced "usbpd_notify" with "pd_notify" in functions and structures.
> - Addressed comments from upstream maintainer.
> 
>  drivers/platform/chrome/Kconfig               |  10 ++
>  drivers/platform/chrome/Makefile              |   1 +
>  drivers/platform/chrome/cros_usbpd_notify.c   | 153 ++++++++++++++++++
>  .../linux/platform_data/cros_usbpd_notify.h   |  17 ++
>  4 files changed, 181 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_usbpd_notify.c
>  create mode 100644 include/linux/platform_data/cros_usbpd_notify.h
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 5f57282a28da0..89df6c991089d 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -226,6 +226,16 @@ config CROS_USBPD_LOGGER
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_usbpd_logger.
>  
> +config CROS_USBPD_NOTIFY
> +	tristate "ChromeOS Type-C power delivery event notifier"
> +	depends on CROS_EC
> +	help
> +	  If you say Y here, you get support for Type-C PD event notifications
> +	  from the ChromeOS EC. On ACPI platorms this driver will bind to the
> +	  GOOG0003 ACPI device, and on platforms which don't have this device it
> +	  will get initialized on ECs which support the feature
> +	  EC_FEATURE_USB_PD.
> +
>  source "drivers/platform/chrome/wilco_ec/Kconfig"
>  
>  endif # CHROMEOS_PLATFORMS
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index aacd5920d8a18..f6465f8ef0b5e 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -22,5 +22,6 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorhub.o
>  obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
>  obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
> +obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
>  
>  obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
> new file mode 100644
> index 0000000000000..1c4f690bd7746
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 Google LLC
> + *
> + * This driver serves as the receiver of cros_ec PD host events.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_usbpd_notify.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +
> +#define DRV_NAME "cros-usbpd-notify"
> +#define ACPI_DRV_NAME "GOOG0003"
> +
> +static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
> +
> +/**
> + * cros_usbpd_register_notify - Register a notifier callback for PD events.
> + * @nb: Notifier block pointer to register
> + *
> + * On ACPI platforms this corresponds to host events on the ECPD
> + * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp events
> + * for USB PD events.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cros_usbpd_register_notify(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(
> +			&cros_usbpd_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(cros_usbpd_register_notify);
> +
> +
> +/**
> + * cros_usbpd_unregister_notify - Unregister notifier callback for PD events.
> + * @nb: Notifier block pointer to unregister
> + *
> + * Unregister a notifier callback that was previously registered with
> + * cros_usbpd_register_notify().
> + */
> +void cros_usbpd_unregister_notify(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&cros_usbpd_notifier_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
> +
> +#ifdef CONFIG_ACPI
> +
> +static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
> +{
> +	return 0;
> +}
> +
> +static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
> +{
> +	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
> +}
> +
> +static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
> +	{ ACPI_DRV_NAME, 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, cros_usbpd_acpi_device_ids);
Ops, there is a build error here, please make sure to build the driver before
sending.

s/cros_usbpd_acpi_device_ids/cros_usbpd_notify_acpi_device_ids/

Apart from this I'm getting build errors with my defconfig which has CONFIG_ACPI
and CONFIG_OF enabled.

Another problem that I have with this driver is that actually there is no user
for it. I'd really prefer have this included on a series that also introduces
the user of this notifier. If you are only testing the ACPI case you can focus
first on this use case and we add later the OF case (maybe is an easy way to
proceed).

Thanks,
 Enric

> +
> +static struct acpi_driver cros_usbpd_notify_acpi_driver = {
> +	.name = DRV_NAME,
> +	.class = DRV_NAME,
> +	.ids = cros_usbpd_notify_acpi_device_ids,
> +	.ops = {
> +		.add = cros_usbpd_notify_add_acpi,
> +		.notify = cros_usbpd_notify_acpi,
> +	},
> +};
> +module_acpi_driver(cros_usbpd_notify_acpi_driver);
> +
> +#endif /* CONFIG_ACPI */
> +
> +#ifdef CONFIG_OF
> +
> +static int cros_usbpd_notify_plat(struct notifier_block *nb,
> +		unsigned long queued_during_suspend, void *data)
> +{
> +	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
> +	u32 host_event = cros_ec_get_host_event(ec_dev);
> +
> +	if (!host_event)
> +		return NOTIFY_BAD;
> +
> +	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> +		blocking_notifier_call_chain(&cros_usbpd_notifier_list,
> +				host_event, NULL);
> +		return NOTIFY_OK;
> +	}
> +	return NOTIFY_DONE;
> +}
> +
> +static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
> +	struct notifier_block *nb;
> +	int ret;
> +
> +	nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
> +	if (!nb)
> +		return -ENOMEM;
> +
> +	nb->notifier_call = cros_usbpd_notify_plat;
> +	dev_set_drvdata(dev, nb);
> +
> +	ret = blocking_notifier_chain_register(&ecdev->ec_dev->event_notifier,
> +						nb);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register notifier\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
> +	struct notifier_block *nb =
> +		(struct notifier_block *)dev_get_drvdata(dev);
> +
> +	blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier,
> +			nb);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cros_usbpd_notify_plat_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +	},
> +	.probe = cros_usbpd_notify_probe_plat,
> +	.remove = cros_usbpd_notify_remove_plat,
> +};
> +module_platform_driver(cros_usbpd_notify_plat_driver);
> +
> +#endif /* CONFIG_OF */
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
> +MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/include/linux/platform_data/cros_usbpd_notify.h
> new file mode 100644
> index 0000000000000..4f2791722b6d3
> --- /dev/null
> +++ b/include/linux/platform_data/cros_usbpd_notify.h
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChromeOS EC Power Delivery Notifier Driver
> + *
> + * Copyright 2020 Google LLC
> + */
> +
> +#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> +#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> +
> +#include <linux/notifier.h>
> +
> +int cros_usbpd_register_notify(struct notifier_block *nb);
> +
> +void cros_usbpd_unregister_notify(struct notifier_block *nb);
> +
> +#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
> 
