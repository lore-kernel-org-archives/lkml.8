Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737A2C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7692082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMxVyHV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgA3FsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:48:21 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51861 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgA3FsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:48:05 -0500
Received: by mail-pj1-f65.google.com with SMTP id fa20so839340pjb.1;
        Wed, 29 Jan 2020 21:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L/+zfhhce+MGmNAWfBlnOWr6kzS8jMspJdiLQOshnKs=;
        b=CMxVyHV5lCpKyxnYThhtaUb68Rx1d8RT2yhJ7aafTFC0w/x/MY+RislEMMDoIitjFS
         u5HLLbABUC+tmC68/uDslAS9gZXfzFK+RSBGbEE/yuAvYQUSz8pCfqJzvrCbRIBfaRGx
         7Xt5zL9bflkjjBvdAa+gUSuNNNzTOW/nARJsFDbe9lqSy3/O8+gsmEh1QXV5Yih0uWkY
         91CcvdHsWIACtXiiXpQDkcTpUk7jQBIILbwiCRJzEFqzkR2gfsLdlJGmkirgq3U0LI9O
         VFJTlBCgWyXyuMTqzPixuHxU0JI998iaKQNhiLzBIdxxmtThzkjIYFHExvcVw7/4f7el
         445g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L/+zfhhce+MGmNAWfBlnOWr6kzS8jMspJdiLQOshnKs=;
        b=gG4FXa/hZmCI8D8hcgMhGHK/SDEA9z6fyqiwlZEmWtnvBPP4UpYbUrz1RjSF+Nfpel
         gt3Bt++l1LAuhwRIBo49WFBvECi0vC2vjACWdfj9mQHCrO2e9lz0iHVowrnIBhKbZjHU
         w9+YVDYOstqgWc+ncXkqPZ8cY2grn7BoiJVogAplc+vdkXg5HljTe0/lCG4Fnyw0lmph
         tQVfj2r/xVih5QE8f4GNbrWTnjlBdWlcwUbxG7B8KnaTyFv5wRze3drtDjZxJB/ZnPyI
         QUdszIUj6747mjW7GVFmVNYbl+ZKym7CYx3CLmkm63VGrpPHt7pj4EQ+BqC8pe+otT/k
         izqg==
X-Gm-Message-State: APjAAAXX5WlJg1R3HLbkQASDbzaPE7TH/W0qZyqVHelzWjUVM7faAKNW
        KGnREnNDCxAExt27rDhN2LM=
X-Google-Smtp-Source: APXvYqw4Z1nPu1acLeJJxhbNjn5y1Lu4JiHDYY9IdH6/ww/syNe0Y6AM6x5tcv9giDagxSB9vG9/DA==
X-Received: by 2002:a17:90b:309:: with SMTP id ay9mr3851975pjb.22.1580363285069;
        Wed, 29 Jan 2020 21:48:05 -0800 (PST)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id e1sm4983931pfl.98.2020.01.29.21.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 21:48:04 -0800 (PST)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V3 4/6] USB: serial: f81232: Add F81534A support
Date:   Thu, 30 Jan 2020 13:47:50 +0800
Message-Id: <20200130054752.9368-5-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
References: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device
and the serial port is default disabled when plugin computer.

The IC is contains devices as following:
	1. HUB (all devices is connected with this hub)
	2. GPIO/Control device. (enable serial port and control GPIOs)
	3. serial port 1 to x (2/4/8/12)

It's most same with F81232, the UART device is difference as follow:
	1. TX/RX bulk size is 128/512bytes
	2. RX bulk layout change:
		F81232: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
		F81534A:[LEN][Data.....][LSR]

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
Changelog:
v3:
	1. Add prefix f81232 to original id_table[].
	2. Change all_serial_id_table[] to combined_id_table[].
	3. Remove non-used defines.
	4. Fix typos.
	5. Change some error message more reable.
	6. Change urb->actual_length to len in f81534a_process_read_urb().
	7. Remove f81534a_port_probe() and add it to next patch.

v2:
	1: Separate LSR handler to prior patch.
	2: Use tty_insert_flip_string_fixed_char() when not a console.
	3. Remove proxy function f81232_read_urb_proxy() and change it
	   to usb-serial subdriver.
	4. Change some error message more reable.

 drivers/usb/serial/f81232.c | 128 ++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index e080d678b0c2..df197c723273 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Fintek F81232 USB to serial adaptor driver
+ * Fintek F81532A/534A/535/536 USB to 2/4/8/12 serial adaptor driver
  *
  * Copyright (C) 2012 Greg Kroah-Hartman (gregkh@linuxfoundation.org)
  * Copyright (C) 2012 Linux Foundation
@@ -21,11 +22,36 @@
 #include <linux/usb/serial.h>
 #include <linux/serial_reg.h>
 
-static const struct usb_device_id id_table[] = {
-	{ USB_DEVICE(0x1934, 0x0706) },
+#define F81232_ID		\
+	{ USB_DEVICE(0x1934, 0x0706) }	/* 1 port UART device */
+
+#define F81534A_SERIES_ID	\
+	{ USB_DEVICE(0x2c42, 0x1602) },	/* In-Box 2 port UART device */	\
+	{ USB_DEVICE(0x2c42, 0x1604) },	/* In-Box 4 port UART device */	\
+	{ USB_DEVICE(0x2c42, 0x1605) },	/* In-Box 8 port UART device */	\
+	{ USB_DEVICE(0x2c42, 0x1606) },	/* In-Box 12 port UART device */ \
+	{ USB_DEVICE(0x2c42, 0x1608) },	/* Non-Flash type */ \
+	{ USB_DEVICE(0x2c42, 0x1632) },	/* 2 port UART device */ \
+	{ USB_DEVICE(0x2c42, 0x1634) },	/* 4 port UART device */ \
+	{ USB_DEVICE(0x2c42, 0x1635) },	/* 8 port UART device */ \
+	{ USB_DEVICE(0x2c42, 0x1636) }	/* 12 port UART device */
+
+static const struct usb_device_id f81232_id_table[] = {
+	F81232_ID,
 	{ }					/* Terminating entry */
 };
-MODULE_DEVICE_TABLE(usb, id_table);
+
+static const struct usb_device_id f81534a_id_table[] = {
+	F81534A_SERIES_ID,
+	{ }					/* Terminating entry */
+};
+
+static const struct usb_device_id combined_id_table[] = {
+	F81232_ID,
+	F81534A_SERIES_ID,
+	{ }					/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(usb, combined_id_table);
 
 /* Maximum baudrate for F81232 */
 #define F81232_MAX_BAUDRATE		1500000
@@ -61,6 +87,11 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define F81232_CLK_14_77_MHZ		(BIT(1) | BIT(0))
 #define F81232_CLK_MASK			GENMASK(1, 0)
 
+#define F81534A_MODE_REG		0x107
+#define F81534A_TRIGGER_MASK		GENMASK(3, 2)
+#define F81534A_TRIGGER_MULTIPLE_4X	BIT(3)
+#define F81534A_FIFO_128BYTE		(BIT(1) | BIT(0))
+
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
@@ -383,6 +414,47 @@ static void f81232_process_read_urb(struct urb *urb)
 	tty_flip_buffer_push(&port->port);
 }
 
+static void f81534a_process_read_urb(struct urb *urb)
+{
+	struct usb_serial_port *port = urb->context;
+	unsigned char *data = urb->transfer_buffer;
+	char tty_flag;
+	unsigned int i;
+	u8 lsr;
+	u8 len;
+
+	if (urb->actual_length < 3) {
+		dev_err(&port->dev, "short message received: %d\n",
+				urb->actual_length);
+		return;
+	}
+
+	len = data[0];
+	if (len != urb->actual_length) {
+		dev_err(&port->dev, "unexpected length: %d %d\n", len,
+				urb->actual_length);
+		return;
+	}
+
+	/* bulk-in data: [LEN][Data.....][LSR] */
+	lsr = data[len - 1];
+	tty_flag = f81232_handle_lsr(port, lsr);
+
+	if (port->port.console && port->sysrq) {
+		for (i = 1; i < len - 1; ++i) {
+			if (!usb_serial_handle_sysrq_char(port, data[i])) {
+				tty_insert_flip_char(&port->port, data[i],
+						tty_flag);
+			}
+		}
+	} else {
+		tty_insert_flip_string_fixed_flag(&port->port, &data[1],
+							tty_flag, len - 2);
+	}
+
+	tty_flip_buffer_push(&port->port);
+}
+
 static void f81232_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
@@ -666,6 +738,24 @@ static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return 0;
 }
 
+static int f81534a_open(struct tty_struct *tty, struct usb_serial_port *port)
+{
+	int status;
+	u8 mask;
+	u8 val;
+
+	val = F81534A_TRIGGER_MULTIPLE_4X | F81534A_FIFO_128BYTE;
+	mask = F81534A_TRIGGER_MASK | F81534A_FIFO_128BYTE;
+
+	status = f81232_set_mask_register(port, F81534A_MODE_REG, mask, val);
+	if (status) {
+		dev_err(&port->dev, "failed to set MODE_REG: %d\n", status);
+		return status;
+	}
+
+	return f81232_open(tty, port);
+}
+
 static void f81232_close(struct usb_serial_port *port)
 {
 	struct f81232_private *port_priv = usb_get_serial_port_data(port);
@@ -810,7 +900,7 @@ static struct usb_serial_driver f81232_device = {
 		.owner =	THIS_MODULE,
 		.name =		"f81232",
 	},
-	.id_table =		id_table,
+	.id_table =		f81232_id_table,
 	.num_ports =		1,
 	.bulk_in_size =		256,
 	.bulk_out_size =	256,
@@ -832,14 +922,40 @@ static struct usb_serial_driver f81232_device = {
 	.resume =		f81232_resume,
 };
 
+static struct usb_serial_driver f81534a_device = {
+	.driver = {
+		.owner =	THIS_MODULE,
+		.name =		"f81534a",
+	},
+	.id_table =		f81534a_id_table,
+	.num_ports =		1,
+	.open =			f81534a_open,
+	.close =		f81232_close,
+	.dtr_rts =		f81232_dtr_rts,
+	.carrier_raised =	f81232_carrier_raised,
+	.get_serial =		f81232_get_serial_info,
+	.break_ctl =		f81232_break_ctl,
+	.set_termios =		f81232_set_termios,
+	.tiocmget =		f81232_tiocmget,
+	.tiocmset =		f81232_tiocmset,
+	.tiocmiwait =		usb_serial_generic_tiocmiwait,
+	.tx_empty =		f81232_tx_empty,
+	.process_read_urb =	f81534a_process_read_urb,
+	.read_int_callback =	f81232_read_int_callback,
+	.port_probe =		f81232_port_probe,
+	.suspend =		f81232_suspend,
+	.resume =		f81232_resume,
+};
+
 static struct usb_serial_driver * const serial_drivers[] = {
 	&f81232_device,
+	&f81534a_device,
 	NULL,
 };
 
-module_usb_serial_driver(serial_drivers, id_table);
+module_usb_serial_driver(serial_drivers, combined_id_table);
 
-MODULE_DESCRIPTION("Fintek F81232 USB to serial adaptor driver");
+MODULE_DESCRIPTION("Fintek F81232/532A/534A/535/536 USB to serial driver");
 MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
 MODULE_AUTHOR("Peter Hong <peter_hong@fintek.com.tw>");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

