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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3DFC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C79A2464B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdiiNJKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgA3FsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:48:03 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39165 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgA3FsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:48:01 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so857081pjr.4;
        Wed, 29 Jan 2020 21:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d2SIm3bhYZ5Yw954kj7k/SsJk8xges7EqsF+eWSvkxA=;
        b=bdiiNJKSxMT0YkQNhlu41/94uAHaM9o8M8stTDHu/07g3sUzklnZGkpx00Wgk4iLsC
         6poUW/b/eXdXX4mveA93Wb3CT7b67sYk5FOv9b5ATpo1s1DHdZd4nPkp0QgWMDobObQc
         lVel2g5GUG0BM0LdcMQB4KqlTfteCvo539UjPcuUJrotnej1YjkuoFye7G/l8ZUJ7VHr
         s6wtvqLKmj3TmqupQutezgpj5m+cF8bqCVqAMXzTL3fYoNJyNo0HaySng1NCnB6SIguu
         23YxN0WWe9ETbGMGnUrNTfWJQvQ8q+uAiDH41dBuse6jMz6Z4GqJuJ9tkjPsv+i0lW10
         PZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d2SIm3bhYZ5Yw954kj7k/SsJk8xges7EqsF+eWSvkxA=;
        b=NarLXFjIw1fBXNMjsDUiTkAfa83fmeUjRWI+Ents59e3l2iu5kkKrPdlkt91PgYIwH
         fxuQGSYWjYXGH/jFI42XGhW21hweZr07VJX2GND2Rj/1RCe2qSvIoRQXqhaMTQsDEyVV
         +fYQZoVqE9GNAYVrX/U0ywweVY2I781z4bq/X5IbMjsyYJg8OhTz7oJYiptah3wV8mCY
         bDSJDZvRRN1L3ezfVwlzs77xpEZnvvK3Pz3Cjza/SstqBn+v/OdKSd3W7E77Y7D1jRAw
         K1qtLMcGf2zo4L66HqjyyKbDVB3uR93qDQcvYuRb8kN+NGZcpy4Zc7+JLpi8Qam9ALcv
         RkfA==
X-Gm-Message-State: APjAAAVR1vSxaePmgU6Yz8ZWHDaUGSAVnwObJxIS8zxUvJO8e+xd/XCC
        lqUrPwWxKz210uPMkAfSNgM=
X-Google-Smtp-Source: APXvYqy+LGMQMX9zIimIH8jeuezSkrFoRBlJPJLR2ZTT0XTtftIuOCrTpQXdTRzjtzdjZks/T2qwfQ==
X-Received: by 2002:a17:902:e789:: with SMTP id cp9mr3125780plb.85.1580363280762;
        Wed, 29 Jan 2020 21:48:00 -0800 (PST)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id o184sm4621315pgo.62.2020.01.29.21.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 21:48:00 -0800 (PST)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V3 2/6] USB: serial: f81232: Add tx_empty function
Date:   Thu, 30 Jan 2020 13:47:48 +0800
Message-Id: <20200130054752.9368-3-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
References: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tx_empty() function for F81232. Without this, console redirection will
get garbage data.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
Changelog:
v3:
	1. Modify return true when accessing device with error.

v2:
	1: Change check tx empty from UART_LSR_TEMT | UART_LSR_THRE to
	   UART_LSR_TEMT only. 

 drivers/usb/serial/f81232.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index c07d376c743d..793d0b30e347 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -685,6 +685,20 @@ static void f81232_dtr_rts(struct usb_serial_port *port, int on)
 		f81232_set_mctrl(port, 0, TIOCM_DTR | TIOCM_RTS);
 }
 
+static bool f81232_tx_empty(struct usb_serial_port *port)
+{
+	int status;
+	u8 tmp;
+
+	status = f81232_get_register(port, LINE_STATUS_REGISTER, &tmp);
+	if (!status) {
+		if ((tmp & UART_LSR_TEMT) != UART_LSR_TEMT)
+			return false;
+	}
+
+	return true;
+}
+
 static int f81232_carrier_raised(struct usb_serial_port *port)
 {
 	u8 msr;
@@ -820,6 +834,7 @@ static struct usb_serial_driver f81232_device = {
 	.tiocmget =		f81232_tiocmget,
 	.tiocmset =		f81232_tiocmset,
 	.tiocmiwait =		usb_serial_generic_tiocmiwait,
+	.tx_empty =		f81232_tx_empty,
 	.process_read_urb =	f81232_process_read_urb,
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
-- 
2.17.1

