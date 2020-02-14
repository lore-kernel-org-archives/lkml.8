Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDCEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F71320873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgBNHj7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:39:59 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50319 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgBNHj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:39:59 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id C1C4DCECE1;
        Fri, 14 Feb 2020 08:49:20 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: hci_h5: btrtl: Add support for RTL8822C
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200213075140.25105-1-max.chou@realtek.com>
Date:   Fri, 14 Feb 2020 08:39:56 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, kidman@realtek.com
Content-Transfer-Encoding: 8BIT
Message-Id: <FDDB4E96-85DE-405C-907C-5B15F3218C05@holtmann.org>
References: <20200213075140.25105-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

> Add new compatible and FW loading support for RTL8822C.
> 
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
> drivers/bluetooth/Kconfig  |  2 +-
> drivers/bluetooth/btrtl.c  | 12 ++++++++++++
> drivers/bluetooth/hci_h5.c | 18 +++++++++++++++++-
> 3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index f7aa2dc1ff85..052020b07e56 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -211,7 +211,7 @@ config BT_HCIUART_RTL
> 	depends on BT_HCIUART
> 	depends on BT_HCIUART_SERDEV
> 	depends on GPIOLIB
> -	depends on ACPI
> +	depends on (ACPI || SERIAL_DEV_CTRL_TTYPORT)
> 	select BT_HCIUART_3WIRE
> 	select BT_RTL
> 	help
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 577cfa3329db..67f4bc21e7c5 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -136,6 +136,18 @@ static const struct id_table ic_id_table[] = {
> 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
> 	  .cfg_name = "rtl_bt/rtl8761a_config" },
> 
> +	/* 8822C with UART interface */
> +	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
> +			 IC_MATCH_FL_HCIBUS,
> +	  .lmp_subver = RTL_ROM_LMP_8822B,
> +	  .hci_rev = 0x000c,
> +	  .hci_ver = 0x0a,
> +	  .hci_bus = HCI_UART,
> +	  .config_needed = true,
> +	  .has_rom_version = true,
> +	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
> +	  .cfg_name = "rtl_bt/rtl8822cs_config" },
> +
> 	/* 8822C with USB interface */
> 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc),
> 	  .config_needed = false,
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 0b14547482a7..666b0c009004 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -11,6 +11,7 @@
> #include <linux/gpio/consumer.h>
> #include <linux/kernel.h>
> #include <linux/mod_devicetable.h>
> +#include <linux/of_device.h>
> #include <linux/serdev.h>
> #include <linux/skbuff.h>
> 
> @@ -786,6 +787,7 @@ static const struct hci_uart_proto h5p = {
> static int h5_serdev_probe(struct serdev_device *serdev)
> {
> 	const struct acpi_device_id *match;
> +	const void *data;
> 	struct device *dev = &serdev->dev;
> 	struct h5 *h5;
> 
> @@ -799,7 +801,11 @@ static int h5_serdev_probe(struct serdev_device *serdev)
> 	h5->serdev_hu.serdev = serdev;
> 	serdev_device_set_drvdata(serdev, h5);
> 
> -	if (has_acpi_companion(dev)) {
> +	data = of_device_get_match_data(dev);
> +	if (data)
> +		h5->vnd = (const struct h5_vnd *)data;
> +
> +	if (!data && has_acpi_companion(dev)) {
> 		match = acpi_match_device(dev->driver->acpi_match_table, dev);
> 		if (!match)
> 			return -ENODEV;

why is this change done this way?

	if (has_acpi_companion(dev)) {
		/* do the ACPI stuff */
	} else {
		/* do the OF stuff */
	}

> @@ -1003,6 +1009,15 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
> 	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
> };
> 
> +static const struct of_device_id rtl_bluetooth_of_match[] = {
> +#ifdef CONFIG_BT_HCIUART_RTL
> +	{ .compatible = "realtek,rtl8822cs-bt",
> +	  .data = (const void *)&rtl_vnd },
> +#endif
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rtl_bluetooth_of_match);
> +
> static struct serdev_device_driver h5_serdev_driver = {
> 	.probe = h5_serdev_probe,
> 	.remove = h5_serdev_remove,
> @@ -1010,6 +1025,7 @@ static struct serdev_device_driver h5_serdev_driver = {
> 		.name = "hci_uart_h5",
> 		.acpi_match_table = ACPI_PTR(h5_acpi_match),
> 		.pm = &h5_serdev_pm_ops,
> +		.of_match_table = rtl_bluetooth_of_match,
> 	},
> };

And I did post an initial bt3wire.c driver that would be a lot better and cleaner than trying to add everything to hci_h5.c.

Regards

Marcel

