Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D1BC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3438E2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgBMHv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:51:58 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:55997 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgBMHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:51:57 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 01D7pj4K015416, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 01D7pj4K015416
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 15:51:45 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 13 Feb 2020 15:51:45 +0800
Received: from localhost.localdomain (172.21.83.110) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 13 Feb 2020 15:51:44 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alex_lu@realsil.com.cn>, <hildawu@realtek.com>,
        <kidman@realtek.com>
Subject: [PATCH] Bluetooth: hci_h5: btrtl: Add support for RTL8822C
Date:   Thu, 13 Feb 2020 15:51:40 +0800
Message-ID: <20200213075140.25105-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.83.110]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB03.realtek.com.tw (172.21.6.96)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

Add new compatible and FW loading support for RTL8822C.

Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/Kconfig  |  2 +-
 drivers/bluetooth/btrtl.c  | 12 ++++++++++++
 drivers/bluetooth/hci_h5.c | 18 +++++++++++++++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index f7aa2dc1ff85..052020b07e56 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -211,7 +211,7 @@ config BT_HCIUART_RTL
 	depends on BT_HCIUART
 	depends on BT_HCIUART_SERDEV
 	depends on GPIOLIB
-	depends on ACPI
+	depends on (ACPI || SERIAL_DEV_CTRL_TTYPORT)
 	select BT_HCIUART_3WIRE
 	select BT_RTL
 	help
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 577cfa3329db..67f4bc21e7c5 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -136,6 +136,18 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8761a_config" },
 
+	/* 8822C with UART interface */
+	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
+			 IC_MATCH_FL_HCIBUS,
+	  .lmp_subver = RTL_ROM_LMP_8822B,
+	  .hci_rev = 0x000c,
+	  .hci_ver = 0x0a,
+	  .hci_bus = HCI_UART,
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8822cs_config" },
+
 	/* 8822C with USB interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc),
 	  .config_needed = false,
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 0b14547482a7..666b0c009004 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
 
@@ -786,6 +787,7 @@ static const struct hci_uart_proto h5p = {
 static int h5_serdev_probe(struct serdev_device *serdev)
 {
 	const struct acpi_device_id *match;
+	const void *data;
 	struct device *dev = &serdev->dev;
 	struct h5 *h5;
 
@@ -799,7 +801,11 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	h5->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, h5);
 
-	if (has_acpi_companion(dev)) {
+	data = of_device_get_match_data(dev);
+	if (data)
+		h5->vnd = (const struct h5_vnd *)data;
+
+	if (!data && has_acpi_companion(dev)) {
 		match = acpi_match_device(dev->driver->acpi_match_table, dev);
 		if (!match)
 			return -ENODEV;
@@ -1003,6 +1009,15 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
 };
 
+static const struct of_device_id rtl_bluetooth_of_match[] = {
+#ifdef CONFIG_BT_HCIUART_RTL
+	{ .compatible = "realtek,rtl8822cs-bt",
+	  .data = (const void *)&rtl_vnd },
+#endif
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rtl_bluetooth_of_match);
+
 static struct serdev_device_driver h5_serdev_driver = {
 	.probe = h5_serdev_probe,
 	.remove = h5_serdev_remove,
@@ -1010,6 +1025,7 @@ static struct serdev_device_driver h5_serdev_driver = {
 		.name = "hci_uart_h5",
 		.acpi_match_table = ACPI_PTR(h5_acpi_match),
 		.pm = &h5_serdev_pm_ops,
+		.of_match_table = rtl_bluetooth_of_match,
 	},
 };
 
-- 
2.17.1

