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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DC4C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168722067C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax1JbQ7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgA3FsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:48:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38835 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgA3FsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:48:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so1062359pgm.5;
        Wed, 29 Jan 2020 21:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RNIHU9mN9Ks4aq3EHKBboyo0GBYUlwX2Stua3O4Tvyo=;
        b=ax1JbQ7MvV8mimz2X2+WCD9JVHHoa9G6Fi0Zin38dhxIKnAxz31YvTlIAh4Y/LZeSq
         P0nE3viEQ1pKWEL6n8yGOfKAE12Gn7P4dKI8QEvbXsmf8z9JBlkWA5Xn/eJdpL+FmSf7
         YlyJpoGZNUAzRIa9oYX6Yprd6Kw7c+MMF9ovZrqDtu5e3CCuHewMwIplTcqUMup/KIuW
         Oz9z1R+iDRg7kCgyseF8dby7XjjFY8X9agWjsK7Z0VFnzJfwQFaEwV5TZGV9me0FmX+A
         ruTy5d4S4s+agwMuEI25h7X+TDDzur189yuTXtDWjMUBmK/IN57nlTtauNU9UbEV8N33
         Kh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RNIHU9mN9Ks4aq3EHKBboyo0GBYUlwX2Stua3O4Tvyo=;
        b=Lir1UE43A0+UnLg67I6vB5jOTtPSrQ10kTisHXjk9MYa8lCp0fiOz+OeKgDy66610E
         cx4Bv4HJBc0li6puJZ8jiUnnBFwfovCWEMhExj0leFjRnPB/7wmlz7pBtox+G4Q5PG/S
         zTvfFFYNxBUcLqKoBH2ducmRp/Xh11YZEGMVKggFDYYWvaizgYxrDvKnkoJ5yNKiUKvk
         yH0pWNHyORQ0RMw7QsR7QlLlsGYIm+Bj9hZQspz1LzODxcHP9btUmGp0JRNDhpRfT3wg
         bBhJ4souYtfYd2bJg1YYwbvjR0mRJOuyo5VQuNrI1zQ7ejyf+Q5I952jkt/Hb4xDs95N
         LrGg==
X-Gm-Message-State: APjAAAUu1rU3tA7+tsQNNWf9UV2KGuCYgRM6miVADNSfI+0eh/7KeXWW
        ZsVRQaF0zjGhfsZ6pq0IFTM=
X-Google-Smtp-Source: APXvYqxlzpL6z7P/cFa6NzQ9bfbpklq/LDHKdK9nsiWoAyiBP0BQV90J6bbaR7bduDnsf9LQ/8w8Rg==
X-Received: by 2002:a63:7145:: with SMTP id b5mr2849049pgn.409.1580363287190;
        Wed, 29 Jan 2020 21:48:07 -0800 (PST)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id b65sm4793790pgc.18.2020.01.29.21.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 21:48:06 -0800 (PST)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V3 5/6] USB: serial: f81232: Set F81534A serial port with RS232 mode
Date:   Thu, 30 Jan 2020 13:47:51 +0800
Message-Id: <20200130054752.9368-6-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
References: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device
and the serial ports are default disabled. Each port contains max 3 pins
GPIO and the 3 pins are default pull high with input mode.

When the serial port had activated (running probe()), we'll transform the
3 pins from GPIO function publicly to control Tranceiver privately use.
We'll default set to 0/0/1 for control transceiver to RS232 mode.

Otherwise, If the serial port is not active, the 3 pins is in GPIO mode
and controlled by global GPIO device with VID/PID: 2c42/16f8.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
Changelog:
v3:
	1. Add f81534a_port_probe().

v2:
	1: Add more describe in git comment message.
	2: Remove non-used gpio_mode.

 drivers/usb/serial/f81232.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index df197c723273..21410a7f3a8b 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -92,6 +92,15 @@ MODULE_DEVICE_TABLE(usb, combined_id_table);
 #define F81534A_TRIGGER_MULTIPLE_4X	BIT(3)
 #define F81534A_FIFO_128BYTE		(BIT(1) | BIT(0))
 
+/* Serial port self GPIO control, 2bytes [control&output data][input data] */
+#define F81534A_GPIO_REG		0x10e
+#define F81534A_GPIO_MODE2_DIR		BIT(6) /* 1: input, 0: output */
+#define F81534A_GPIO_MODE1_DIR		BIT(5)
+#define F81534A_GPIO_MODE0_DIR		BIT(4)
+#define F81534A_GPIO_MODE2_OUTPUT	BIT(2)
+#define F81534A_GPIO_MODE1_OUTPUT	BIT(1)
+#define F81534A_GPIO_MODE0_OUTPUT	BIT(0)
+
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
@@ -859,6 +868,19 @@ static int f81232_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
+static int f81534a_port_probe(struct usb_serial_port *port)
+{
+	int status;
+
+	/* tri-state with pull-high, default RS232 Mode */
+	status = f81232_set_register(port, F81534A_GPIO_REG,
+					F81534A_GPIO_MODE2_DIR);
+	if (status)
+		return status;
+
+	return f81232_port_probe(port);
+}
+
 static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
 {
 	struct usb_serial_port *port = serial->port[0];
@@ -942,7 +964,7 @@ static struct usb_serial_driver f81534a_device = {
 	.tx_empty =		f81232_tx_empty,
 	.process_read_urb =	f81534a_process_read_urb,
 	.read_int_callback =	f81232_read_int_callback,
-	.port_probe =		f81232_port_probe,
+	.port_probe =		f81534a_port_probe,
 	.suspend =		f81232_suspend,
 	.resume =		f81232_resume,
 };
-- 
2.17.1

