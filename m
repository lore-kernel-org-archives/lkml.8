Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93ECC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C9B22200
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGNKwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:52:44 -0400
Received: from ms-10.1blu.de ([178.254.4.101]:58174 "EHLO ms-10.1blu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgGNKwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:52:43 -0400
Received: from [78.43.71.214] (helo=marius.fritz.box)
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <mail@mariuszachmann.de>)
        id 1jvIY7-0004mQ-De; Tue, 14 Jul 2020 12:52:35 +0200
From:   Marius Zachmann <mail@mariuszachmann.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Marius Zachmann <mail@mariuszachmann.de>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: corsair-cpro: Change to hid driver
Date:   Tue, 14 Jul 2020 12:52:30 +0200
Message-Id: <20200714105230.3126-1-mail@mariuszachmann.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Con-Id: 241080
X-Con-U: 0-mail
X-Originating-IP: 78.43.71.214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found a project which uses hidraw to communicate with the device.
Because I do not want to break any existing userspace code, I
changed this to a hid driver, so hidraw can still be used.
Do I need to include the hid maintainers for the undo in hid-quirks?

Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
---
 drivers/hid/hid-quirks.c     |   2 -
 drivers/hwmon/Kconfig        |   4 +-
 drivers/hwmon/corsair-cpro.c | 114 ++++++++++++++++++++++++++---------
 3 files changed, 86 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 7b7bc7737c53..ca8b5c261c7c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -699,8 +699,6 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AXENTIA, USB_DEVICE_ID_AXENTIA_FM_RADIO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CIDC, 0x0103) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, 0x0c10) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, 0x1d00) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI470X) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI4713) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM109) },
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 8b046a5dfa40..c603d8c8e3d2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -441,7 +441,7 @@ config SENSORS_BT1_PVT_ALARMS

 config SENSORS_CORSAIR_CPRO
 	tristate "Corsair Commander Pro controller"
-	depends on USB
+	depends on HID
 	help
 	  If you say yes here you get support for the Corsair Commander Pro
 	  controller.
@@ -1716,7 +1716,7 @@ config SENSORS_ADS7871

 config SENSORS_AMC6821
 	tristate "Texas Instruments AMC6821"
-	depends on I2C
+	depends on I2C
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  AMC6821 hardware monitoring chips.
diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index fe625190e3a1..4310ee5aca24 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -5,13 +5,14 @@
  */

 #include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/hid.h>
 #include <linux/hwmon.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/usb.h>

 #define USB_VENDOR_ID_CORSAIR			0x1b1c
 #define USB_PRODUCT_ID_CORSAIR_COMMANDERPRO	0x0c10
@@ -62,7 +63,8 @@
 #define NUM_TEMP_SENSORS	4

 struct ccp_device {
-	struct usb_device *udev;
+	struct hid_device *hdev;
+	struct completion wait_input_report;
 	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
 	u8 *buffer;
 	int pwm[6];
@@ -75,7 +77,7 @@ struct ccp_device {
 /* send command, check for error in response, response in ccp->buffer */
 static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2, u8 byte3)
 {
-	int actual_length;
+	unsigned long t;
 	int ret;

 	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
@@ -84,26 +86,39 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
 	ccp->buffer[2] = byte2;
 	ccp->buffer[3] = byte3;

-	ret = usb_bulk_msg(ccp->udev, usb_sndintpipe(ccp->udev, 2), ccp->buffer, OUT_BUFFER_SIZE,
-			   &actual_length, 1000);
-	if (ret)
-		return ret;
+	reinit_completion(&ccp->wait_input_report);

-	/* response needs to be received every time */
-	ret = usb_bulk_msg(ccp->udev, usb_rcvintpipe(ccp->udev, 1), ccp->buffer, IN_BUFFER_SIZE,
-			   &actual_length, 1000);
-	if (ret)
+	ret = hid_hw_output_report(ccp->hdev, ccp->buffer, OUT_BUFFER_SIZE);
+	if (ret < 0)
 		return ret;

+	t = wait_for_completion_timeout(&ccp->wait_input_report, msecs_to_jiffies(300));
+	if (!t)
+		return -ETIMEDOUT;
+
 	/* first byte of response is error code */
 	if (ccp->buffer[0] != 0x00) {
-		dev_dbg(&ccp->udev->dev, "device response error: %d", ccp->buffer[0]);
+		hid_dbg(ccp->hdev, "device response error: %d", ccp->buffer[0]);
 		return -EIO;
 	}

 	return 0;
 }

+static int ccp_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
+{
+	struct ccp_device *ccp = hid_get_drvdata(hdev);
+
+	/* only copy buffer when requested */
+	if (completion_done(&ccp->wait_input_report))
+		return 0;
+
+	memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
+	complete(&ccp->wait_input_report);
+
+	return 0;
+}
+
 /* requests and returns single data values depending on channel */
 static int get_data(struct ccp_device *ccp, int command, int channel)
 {
@@ -437,57 +452,96 @@ static int get_temp_cnct(struct ccp_device *ccp)
 	return 0;
 }

-static int ccp_probe(struct usb_interface *intf, const struct usb_device_id *id)
+static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct device *hwmon_dev;
 	struct ccp_device *ccp;
 	int ret;

-	ccp = devm_kzalloc(&intf->dev, sizeof(*ccp), GFP_KERNEL);
+	ccp = devm_kzalloc(&hdev->dev, sizeof(*ccp), GFP_KERNEL);
 	if (!ccp)
 		return -ENOMEM;

-	ccp->buffer = devm_kmalloc(&intf->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
+	ccp->buffer = devm_kmalloc(&hdev->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
 	if (!ccp->buffer)
 		return -ENOMEM;

+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_open(hdev);
+	if (ret)
+		goto out_hw_stop;
+
+	ccp->hdev = hdev;
+	hid_set_drvdata(hdev, ccp);
 	mutex_init(&ccp->mutex);
+	init_completion(&ccp->wait_input_report);

-	ccp->udev = interface_to_usbdev(intf);
+	hid_device_io_start(hdev);

 	/* temp and fan connection status only updates when device is powered on */
 	ret = get_temp_cnct(ccp);
 	if (ret)
-		return ret;
+		goto out_hw_close;

 	ret = get_fan_cnct(ccp);
 	if (ret)
-		return ret;
-
-	hwmon_dev = devm_hwmon_device_register_with_info(&intf->dev, "corsaircpro", ccp,
+		goto out_hw_close;
+	hwmon_dev = devm_hwmon_device_register_with_info(&hdev->dev, "corsaircpro", ccp,
 							 &ccp_chip_info, 0);
+	if (IS_ERR(hwmon_dev)) {
+		ret = PTR_ERR(hwmon_dev);
+		goto out_hw_close;
+	}
+
+	return 0;

-	return PTR_ERR_OR_ZERO(hwmon_dev);
+out_hw_close:
+	hid_hw_close(hdev);
+out_hw_stop:
+	hid_hw_stop(hdev);
+	return ret;
 }

-static void ccp_disconnect(struct usb_interface *intf)
+static void ccp_remove(struct hid_device *hdev)
 {
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
 }

-static const struct usb_device_id ccp_devices[] = {
-	{ USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_COMMANDERPRO) },
-	{ USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_1000D) },
+static const struct hid_device_id ccp_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_COMMANDERPRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_1000D) },
 	{ }
 };

-static struct usb_driver ccp_driver = {
+static struct hid_driver ccp_driver = {
 	.name = "corsair-cpro",
+	.id_table = ccp_devices,
 	.probe = ccp_probe,
-	.disconnect = ccp_disconnect,
-	.id_table = ccp_devices
+	.remove = ccp_remove,
+	.raw_event = ccp_raw_event,
 };

-MODULE_DEVICE_TABLE(usb, ccp_devices);
+MODULE_DEVICE_TABLE(hid, ccp_devices);
 MODULE_LICENSE("GPL");

-module_usb_driver(ccp_driver);
+static int __init ccp_init(void)
+{
+	return hid_register_driver(&ccp_driver);
+}
+
+static void __exit ccp_exit(void)
+{
+	hid_unregister_driver(&ccp_driver);
+}
+
+/* make sure, it is loaded after hid */
+late_initcall(ccp_init);
+module_exit(ccp_exit);
--
2.27.0
