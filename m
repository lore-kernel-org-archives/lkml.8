Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F463C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579AC2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxSLi57g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgA3FsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:48:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43049 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgA3FsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:48:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so895587pfh.10;
        Wed, 29 Jan 2020 21:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pGnME5UnUSmVYH39WRYxMH/ihOy5W05BZhs06G3EBa4=;
        b=nxSLi57gFvKusz8rO/jUyE8wbgODnZnpaz04OktxEOyilqGNNxChmJDw14JKehV5gI
         9rqDYr0+O0JPlQxljPPJMo05vzjovPL0Gr5W4frf/l1oo4ED4KxPy0XgBJh5NKgLHXKN
         Cu8nmCngL3tpp72WSmBPJdrjzoDgYg8Y/RfJhy5zqHSf4j4+fvRK0NRYw9QaciyR1CrA
         HlU190Bbq7zF0EHveprSnR5KEzBVhjM5vTBme+MlAg0+T8WijSW59nBCxSjn9Sxnn6xD
         ZsFFWVvyI8QBsPhFrYQE+l9d1JbV2CgGLq2yuZ2uG4/Z+yCOYNt3j4sPm+4cMRawyLrZ
         9zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pGnME5UnUSmVYH39WRYxMH/ihOy5W05BZhs06G3EBa4=;
        b=UTCytgrVGDpLGIYoph9q40K4W09PEtKS/Bdkx/lJStM8mAweiyBhZBTlOQ46UxecWP
         mucYoTF4oXnsQIbphQRnhBWqnOF2z9PLzpFtrp/7c9yusvd6r+G6lbzshTOrEKVmH9LQ
         O2BsIgA+SBBQHO9j3klvWqo2lvXjoejyS3js6ssTgMXiKMXplUwKm3l3iQoF608ARNNM
         TaMPsetRgyc07VcIaiIvRh3GqOfFKsMC7yglRsCTMQh1/yCjBwFdlof2V274in3/qmhv
         0TQ/puDLqfGacSlahjXOyJXTAbKjvvUjjzR8AHmC6ueRE7uKNELPVxBCD0fKMiduIJhp
         CDTw==
X-Gm-Message-State: APjAAAWBh+RrxrqKJygknHKk6m15TZZQcCmscYWGl6moFyoDGwU9GHa+
        DEFMyD5zmGBA+pKc1Gov8dc=
X-Google-Smtp-Source: APXvYqz5OQQr0+Ro5uzdR+/E3kWp/tLDU8CJOh0uO4GFLt6IDOX7Wgfg6nHW0rjgl7P2FMrNqfjvig==
X-Received: by 2002:a63:484b:: with SMTP id x11mr3022258pgk.148.1580363289305;
        Wed, 29 Jan 2020 21:48:09 -0800 (PST)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id q4sm4871495pfl.175.2020.01.29.21.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 21:48:08 -0800 (PST)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V3 6/6] USB: serial: f81232: Add generator for F81534A
Date:   Thu, 30 Jan 2020 13:47:52 +0800
Message-Id: <20200130054752.9368-7-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
References: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fintek F81534A series is contains 1 HUB / 1 GPIO device / n UARTs,
but the UART is default disable and need enabled by GPIO device(2c42/16F8).

When F81534A plug to host, we can only see 1 HUB & 1 GPIO device and we
write 0x8fff to GPIO device register F81534A_CTRL_CMD_ENABLE_PORT(116h)
to enable all available serial ports.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
Changelog:
v3:
	1. Modify some define with prefix F81534A_CTRL_.
	2. Use kmemdup() in f81534a_ctrl_set_register().
	3. Not accpet with short transfers in f81534a_ctrl_set_register().
	4. Add comment in f81534a_ctrl_enable_all_ports() to describe magic
	   constants.
	5. Remove non-need usb_get_dev()/usb_put_dev().
	6. Add F81534A_CTRL_ID in MODULE_DEVICE_TABLE().

v2:
	1: Simplify the generator behavior.
	2: Change multiply MODULE_DEVICE_TABLE() to 1 only.

 drivers/usb/serial/f81232.c | 134 +++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 21410a7f3a8b..0303f94b2521 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -36,6 +36,9 @@
 	{ USB_DEVICE(0x2c42, 0x1635) },	/* 8 port UART device */ \
 	{ USB_DEVICE(0x2c42, 0x1636) }	/* 12 port UART device */
 
+#define F81534A_CTRL_ID		\
+	{ USB_DEVICE(0x2c42, 0x16f8) }	/* Global control device */
+
 static const struct usb_device_id f81232_id_table[] = {
 	F81232_ID,
 	{ }					/* Terminating entry */
@@ -46,9 +49,15 @@ static const struct usb_device_id f81534a_id_table[] = {
 	{ }					/* Terminating entry */
 };
 
+static const struct usb_device_id f81534a_ctrl_id_table[] = {
+	F81534A_CTRL_ID,
+	{ }					/* Terminating entry */
+};
+
 static const struct usb_device_id combined_id_table[] = {
 	F81232_ID,
 	F81534A_SERIES_ID,
+	F81534A_CTRL_ID,
 	{ }					/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, combined_id_table);
@@ -61,6 +70,7 @@ MODULE_DEVICE_TABLE(usb, combined_id_table);
 #define F81232_REGISTER_REQUEST		0xa0
 #define F81232_GET_REGISTER		0xc0
 #define F81232_SET_REGISTER		0x40
+#define F81534A_ACCESS_REG_RETRY	2
 
 #define SERIAL_BASE_ADDRESS		0x0120
 #define RECEIVE_BUFFER_REGISTER		(0x00 + SERIAL_BASE_ADDRESS)
@@ -92,6 +102,8 @@ MODULE_DEVICE_TABLE(usb, combined_id_table);
 #define F81534A_TRIGGER_MULTIPLE_4X	BIT(3)
 #define F81534A_FIFO_128BYTE		(BIT(1) | BIT(0))
 
+#define F81534A_MAX_PORT		12
+
 /* Serial port self GPIO control, 2bytes [control&output data][input data] */
 #define F81534A_GPIO_REG		0x10e
 #define F81534A_GPIO_MODE2_DIR		BIT(6) /* 1: input, 0: output */
@@ -101,6 +113,9 @@ MODULE_DEVICE_TABLE(usb, combined_id_table);
 #define F81534A_GPIO_MODE1_OUTPUT	BIT(1)
 #define F81534A_GPIO_MODE0_OUTPUT	BIT(0)
 
+#define F81534A_CTRL_CMD_ENABLE_PORT	0x116
+
+
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
@@ -848,6 +863,89 @@ static void f81232_lsr_worker(struct work_struct *work)
 		dev_warn(&port->dev, "read LSR failed: %d\n", status);
 }
 
+static int f81534a_ctrl_set_register(struct usb_device *dev, u16 reg, u16 size,
+					void *val)
+{
+	int retry = F81534A_ACCESS_REG_RETRY;
+	int status;
+	u8 *tmp;
+
+	tmp = kmemdup(val, size, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	while (retry--) {
+		status = usb_control_msg(dev,
+					usb_sndctrlpipe(dev, 0),
+					F81232_REGISTER_REQUEST,
+					F81232_SET_REGISTER,
+					reg,
+					0,
+					tmp,
+					size,
+					USB_CTRL_SET_TIMEOUT);
+		if (status != size) {
+			status = usb_translate_errors(status);
+			if (status == -EIO)
+				continue;
+
+			status = -EIO;
+		} else {
+			status = 0;
+		}
+
+		break;
+	}
+
+	if (status) {
+		dev_err(&dev->dev, "set ctrl reg: %x, failed status: %d\n",
+				reg, status);
+	}
+
+	kfree(tmp);
+	return status;
+}
+
+static int f81534a_ctrl_enable_all_ports(struct usb_interface *intf)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	unsigned char enable[2];
+	int status;
+
+	/*
+	 * Enable all available serial ports, define as following:
+	 * bit 15	: Reset behavior (when HUB got soft reset)
+	 *			0: maintain all serial port enabled state.
+	 *			1: disable all serial port.
+	 * bit 0~11	: Serial port enable bit.
+	 */
+	enable[0] = 0xff;
+	enable[1] = 0x8f;
+
+	status = f81534a_ctrl_set_register(dev, F81534A_CTRL_CMD_ENABLE_PORT,
+			sizeof(enable), enable);
+	if (status)
+		dev_warn(&dev->dev, "set ENABLE_PORT failed: %d\n", status);
+
+	return status;
+}
+
+static int f81534a_ctrl_probe(struct usb_interface *intf,
+				const struct usb_device_id *id)
+{
+
+	return f81534a_ctrl_enable_all_ports(intf);
+}
+
+static void f81534a_ctrl_disconnect(struct usb_interface *intf)
+{
+}
+
+static int f81534a_ctrl_resume(struct usb_interface *intf)
+{
+	return f81534a_ctrl_enable_all_ports(intf);
+}
+
 static int f81232_port_probe(struct usb_serial_port *port)
 {
 	struct f81232_private *priv;
@@ -975,7 +1073,41 @@ static struct usb_serial_driver * const serial_drivers[] = {
 	NULL,
 };
 
-module_usb_serial_driver(serial_drivers, combined_id_table);
+static struct usb_driver f81534a_ctrl_driver = {
+	.name =		"f81534a_ctrl",
+	.id_table =	f81534a_ctrl_id_table,
+	.probe =	f81534a_ctrl_probe,
+	.disconnect =	f81534a_ctrl_disconnect,
+	.resume =	f81534a_ctrl_resume,
+};
+
+static int __init f81232_init(void)
+{
+	int status;
+
+	status = usb_register_driver(&f81534a_ctrl_driver, THIS_MODULE,
+			KBUILD_MODNAME);
+	if (status)
+		return status;
+
+	status = usb_serial_register_drivers(serial_drivers, KBUILD_MODNAME,
+			combined_id_table);
+	if (status) {
+		usb_deregister(&f81534a_ctrl_driver);
+		return status;
+	}
+
+	return 0;
+}
+
+static void __exit f81232_exit(void)
+{
+	usb_serial_deregister_drivers(serial_drivers);
+	usb_deregister(&f81534a_ctrl_driver);
+}
+
+module_init(f81232_init);
+module_exit(f81232_exit);
 
 MODULE_DESCRIPTION("Fintek F81232/532A/534A/535/536 USB to serial driver");
 MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
-- 
2.17.1

