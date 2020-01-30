Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865DEC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC502067C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frqJfbE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgA3FsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:48:08 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55317 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgA3FsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:48:04 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so830780pjz.5;
        Wed, 29 Jan 2020 21:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XoH0RfUkniLuJnauhCFjE5IH2zqdDE1G34DQoDUOnqE=;
        b=frqJfbE5yLwlFVkGlxhJjNDjm0lIOAMLJRcO3mPrGlkiDxN257Dcy+ItuctomokBT+
         d/pOxztJbcvpouu/H7DfD9jJP16GPWBgkivWoOg67TdArBtcrEGLPotyflIRynLld060
         k6JjwzWx6imTj+ZO82YaQh7p3uybw23u4XSX3Hjd+QuUapQuuWMwVGfAEaRCgRZfBddz
         EJZuYnH133gF+6T9ON3MUp7lE8i2wukpQYw2E/OPNyUVFjK7iPWqI4iH1SQ9+ySzLsIv
         HYovdcuFkw+iJ1Fk+bvpfMariiJYyao/LNZUKEhkr4TwnGOKh1jw5KgmbmUgRobqiQVK
         S4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XoH0RfUkniLuJnauhCFjE5IH2zqdDE1G34DQoDUOnqE=;
        b=bWfukq3gw6kmEeJtbt6We4y87oVgrxixMY4dlH78W2S4Kyv9BJNouMsr9kOzQnlVRy
         erIRsQH9Wm13zNvEzP4EteQDWyXVVE+4asBv4WsgV6flMdSdBG+sqIK9VyCTOxS6ukOd
         fRjbTOG3AzM9QrO7bjwMc9YEaXYjMgPFE0gfqEZt78uAIXuAQIgHSB1kPeclYpZ8LvUw
         Tc6+Isr70jnMyWYEwTxllUSbkU9f3OTYP0F09QAhxtAQyNdL5pcCc8JhH/gTRX+718xr
         DRb3Htab51B0+E7NvHtYpiecLLxem28wWAZWj5sD1yiCbSTlRlqUhmrQzQj6rdAAUZQl
         LRuA==
X-Gm-Message-State: APjAAAUqkNtz9DaxS3PBnYpxfrcy7sY/wRnKoIxVDrDrqYLGEJ/iAka6
        5MT0dXBD36FP11Lh/de2VC0=
X-Google-Smtp-Source: APXvYqyyESOFCByzFV64RJ14lD2ByRUAv9ouA7/BUL55xT7D1Lsxl/cUJexworbknI5wV88apgBlJw==
X-Received: by 2002:a17:90a:f84:: with SMTP id 4mr4055495pjz.74.1580363282931;
        Wed, 29 Jan 2020 21:48:02 -0800 (PST)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id x25sm4868990pfp.30.2020.01.29.21.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 21:48:02 -0800 (PST)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V3 3/6] USB: serial: f81232: Use devm_kzalloc
Date:   Thu, 30 Jan 2020 13:47:49 +0800
Message-Id: <20200130054752.9368-4-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
References: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kzalloc() to replace kzalloc().

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
Changelog:
v3:
	1. No change.

v2:
	1: No change.

 drivers/usb/serial/f81232.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 793d0b30e347..e080d678b0c2 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -753,7 +753,7 @@ static int f81232_port_probe(struct usb_serial_port *port)
 {
 	struct f81232_private *priv;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&port->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -769,16 +769,6 @@ static int f81232_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
-static int f81232_port_remove(struct usb_serial_port *port)
-{
-	struct f81232_private *priv;
-
-	priv = usb_get_serial_port_data(port);
-	kfree(priv);
-
-	return 0;
-}
-
 static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
 {
 	struct usb_serial_port *port = serial->port[0];
@@ -838,7 +828,6 @@ static struct usb_serial_driver f81232_device = {
 	.process_read_urb =	f81232_process_read_urb,
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
-	.port_remove =		f81232_port_remove,
 	.suspend =		f81232_suspend,
 	.resume =		f81232_resume,
 };
-- 
2.17.1

