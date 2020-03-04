Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98462C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED93214DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwOATE78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbgCDDiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:38:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46814 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387488AbgCDDh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:37:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id w12so219810pll.13;
        Tue, 03 Mar 2020 19:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oPj1/0rT7Md1Gue88lTMInwpdQSYf3PU3c+RNK/VLOM=;
        b=BwOATE784iILokw6e3P2XjBrzSJrXyMW0EMWn6rzRO83MdeAeI2VJVk/tNnT2RE4ab
         nOIoJOtgsLcTvFFaBIFCUibmqR8xVQhVLKrxknAzozPGl2H0IiHnYDJVO3paDk743wZS
         MR4xqTlwLC4CUcJ/zFKL9Lu0fclGf3eyjb5YxDdTpFQ14i1FyajA1TyzvowifabnyHbY
         EGI4X8qo2tBUIzcRO001pzjRjdy+ImMMns+yqd5Qq6eHRY6cAO0RpYlUHWbBlLMcbLLk
         QmaXGCSeM3jHy+TtDfepiba6zME6bk6YYEUhSbtgw7+Tk7j59pShevB455t05cZdNRKC
         qbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oPj1/0rT7Md1Gue88lTMInwpdQSYf3PU3c+RNK/VLOM=;
        b=rgYyEe6LFVPvJNB4RI5yXKSPHfNo4beW19Lmp2732GAA2isOMFf9/GFcYlFDCY2ezZ
         fUYbSGIGvukZ9pC3m98Z1dAoUXiy72d3V3fQM4wV86YTREIlk12cPAXe6tTGhHqkNQ4I
         OUw0yjBIlvunByQkf2LRmKgOweS2RBS9J1aHCoJ5QQ0B5ttkb621Hubjx9cujrbes9uZ
         ZD4561IJgkc6wlmXJwMM+tzzxQYI/Fg9iMIlEt9L2X1Ovsc3G1FvY+GsQkAG136fF9Be
         HQ6fnn2f1d5N8c8C/64hpB6n/17pIilHy+OZ5kyRuaNFpnLz7DaBFIsmifCsMBLCU6H2
         AZdA==
X-Gm-Message-State: ANhLgQ3mEjUWupn/Y6guTYcFwZ/Oece38W1aJCzB7hVkeb3ZR5UAPZke
        kLaHPJyOwudMFq7hBr7ZXuNuknsb
X-Google-Smtp-Source: ADFU+vtJ8WnnoQEUIx7OYvuNNP1j1UD+SWUfkkxGRZEubj7rXBMvrjnvClZth982Wgo2SR/d5S4oJw==
X-Received: by 2002:a17:902:8c98:: with SMTP id t24mr1103515plo.51.1583293076890;
        Tue, 03 Mar 2020 19:37:56 -0800 (PST)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id a71sm10789835pfa.117.2020.03.03.19.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 19:37:56 -0800 (PST)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V4 1/1] USB: serial: f81232: Add generator for F81534A
Date:   Wed,  4 Mar 2020 11:37:51 +0800
Message-Id: <20200304033751.8662-1-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
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
v4:
	1. Remove unused define.
	2. Remove usb_translate_errors() in f81534a_ctrl_set_register()
	   with short transfer.
	3. Replace dev_warn() with dev_err() in f81534a_ctrl_enable_all_ports()
	4. Disable & remove all usb serial port device when disconnect().

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

 drivers/usb/serial/f81232.c | 131 +++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index d27876e64e9d..de625587c957 100644
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
@@ -101,6 +111,9 @@ MODULE_DEVICE_TABLE(usb, combined_id_table);
 #define F81534A_GPIO_MODE1_OUTPUT	BIT(1)
 #define F81534A_GPIO_MODE0_OUTPUT	BIT(0)
 
+#define F81534A_CTRL_CMD_ENABLE_PORT	0x116
+
+
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
@@ -848,6 +861,88 @@ static void f81232_lsr_worker(struct work_struct *work)
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
+			status = -EIO;
+			continue;
+		}
+
+		status = 0;
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
+static int f81534a_ctrl_enable_all_ports(struct usb_interface *intf, bool en)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	unsigned char enable[2] = {0};
+	int status;
+
+	/*
+	 * Enable all available serial ports, define as following:
+	 * bit 15	: Reset behavior (when HUB got soft reset)
+	 *			0: maintain all serial port enabled state.
+	 *			1: disable all serial port.
+	 * bit 0~11	: Serial port enable bit.
+	 */
+	if (en) {
+		enable[0] = 0xff;
+		enable[1] = 0x8f;
+	}
+
+	status = f81534a_ctrl_set_register(dev, F81534A_CTRL_CMD_ENABLE_PORT,
+			sizeof(enable), enable);
+	if (status)
+		dev_err(&dev->dev, "failed to enable ports: %d\n", status);
+
+	return status;
+}
+
+static int f81534a_ctrl_probe(struct usb_interface *intf,
+				const struct usb_device_id *id)
+{
+
+	return f81534a_ctrl_enable_all_ports(intf, true);
+}
+
+static void f81534a_ctrl_disconnect(struct usb_interface *intf)
+{
+	f81534a_ctrl_enable_all_ports(intf, false);
+}
+
+static int f81534a_ctrl_resume(struct usb_interface *intf)
+{
+	return f81534a_ctrl_enable_all_ports(intf, true);
+}
+
 static int f81232_port_probe(struct usb_serial_port *port)
 {
 	struct f81232_private *priv;
@@ -975,7 +1070,41 @@ static struct usb_serial_driver * const serial_drivers[] = {
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

