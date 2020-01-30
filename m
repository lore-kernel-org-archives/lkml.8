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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E395C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A982067C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtQJQL1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgA3FsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:48:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38584 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgA3FsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:48:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so910258pfc.5;
        Wed, 29 Jan 2020 21:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RM4StqYp6528LuZxqUQeQTeN+yjjb6Yypxjs3dilWF4=;
        b=MtQJQL1riGhO0J3oNnkxjTOkdAw7nIV+ZEJDEd3JHw8zO6QY/7Ot+CdLuwSkWPIvxd
         fgYjHwn2xYoa6qa8z8qYjmOWEeImUE7nVlSBqSrXNmYnAEPm0mwOoFOHCOBtlwSzMC82
         MS9ZQwqBV/GSzkL7Z4bItURDxCOjoE0wXR+6W+wpcmt+CbtHNu+NzUkOyuxhVoOorcrd
         fSP4f5lvaNmR4AipWtdTFpkOklT/tVt+sDAEPEIkeSNaEQPUy6i3fYmQkdibmaTVkp3c
         uhcrDIN5NiRtAaXYo8Cp1o7evB0U5n/+j7cjnt9YasBuGrnR8dg6I/lkrWeIue9iW/s6
         7ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RM4StqYp6528LuZxqUQeQTeN+yjjb6Yypxjs3dilWF4=;
        b=G5YC5ab3oBSrDFcMuCxuqRHboL+1PJ4UYA+Pq8/RIS2oOUryT2gPytKtDMV0bFCrnZ
         LJqnXbfSywuqIAHxDh30fzk64s7nr5Pj5X4hoLjfssjMyiy+6HyqZ39VlkGUAcdjR0YT
         njt/9Wd2JrqNrWc+e3St1J+/Zo90d16tRknq5dpyrIrR54QRu8j7FlkSbmLFBYB9s3KQ
         hn0ct86QU7egLFmsuQKqdR7VQxjoNZQPvWBITh4EpDfWieUTwhuZBhhyNfypjDgG92wi
         cyOzF6d1SC2DlQWG0FAflqkevzYc2low56FTReG2Cwe+JT8ybFw+wiSpNzMf1j9me7m/
         RPfQ==
X-Gm-Message-State: APjAAAU62b21j6p2aSIvPMziBEzSqwVp+IKekAQr9TjUzJZa+xgx1vQA
        U5DQn9boKDduSpPqFdbgSBM=
X-Google-Smtp-Source: APXvYqwTWUb9YVBt9SWre6ugobNtU2BjmBbD7TafH+st/hqQdxAI+SvTl5FeIhGohZXLpYLQsEPjbA==
X-Received: by 2002:aa7:93a4:: with SMTP id x4mr3375345pff.42.1580363278593;
        Wed, 29 Jan 2020 21:47:58 -0800 (PST)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id w26sm4690392pfj.119.2020.01.29.21.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 21:47:57 -0800 (PST)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V3 1/6] USB: serial: f81232: Extract LSR handler
Date:   Thu, 30 Jan 2020 13:47:47 +0800
Message-Id: <20200130054752.9368-2-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
References: <20200130054752.9368-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract LSR handler to function that can be re-used by
F81532A/534A/535/536.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
Changelog:
v3:
	1. Change git comment for describe more information.

v2:
	1: Separate LSR handler from original combined driver. 

 drivers/usb/serial/f81232.c | 53 +++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 43fa1f0716b7..c07d376c743d 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -322,10 +322,38 @@ static void f81232_read_int_callback(struct urb *urb)
 			__func__, retval);
 }
 
+static char f81232_handle_lsr(struct usb_serial_port *port, u8 lsr)
+{
+	struct f81232_private *priv = usb_get_serial_port_data(port);
+	char tty_flag = TTY_NORMAL;
+
+	if (!(lsr & UART_LSR_BRK_ERROR_BITS))
+		return tty_flag;
+
+	if (lsr & UART_LSR_BI) {
+		tty_flag = TTY_BREAK;
+		port->icount.brk++;
+		usb_serial_handle_break(port);
+	} else if (lsr & UART_LSR_PE) {
+		tty_flag = TTY_PARITY;
+		port->icount.parity++;
+	} else if (lsr & UART_LSR_FE) {
+		tty_flag = TTY_FRAME;
+		port->icount.frame++;
+	}
+
+	if (lsr & UART_LSR_OE) {
+		port->icount.overrun++;
+		schedule_work(&priv->lsr_work);
+		tty_insert_flip_char(&port->port, 0, TTY_OVERRUN);
+	}
+
+	return tty_flag;
+}
+
 static void f81232_process_read_urb(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
-	struct f81232_private *priv = usb_get_serial_port_data(port);
 	unsigned char *data = urb->transfer_buffer;
 	char tty_flag;
 	unsigned int i;
@@ -341,29 +369,8 @@ static void f81232_process_read_urb(struct urb *urb)
 	/* bulk-in data: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]... */
 
 	for (i = 0; i < urb->actual_length; i += 2) {
-		tty_flag = TTY_NORMAL;
 		lsr = data[i];
-
-		if (lsr & UART_LSR_BRK_ERROR_BITS) {
-			if (lsr & UART_LSR_BI) {
-				tty_flag = TTY_BREAK;
-				port->icount.brk++;
-				usb_serial_handle_break(port);
-			} else if (lsr & UART_LSR_PE) {
-				tty_flag = TTY_PARITY;
-				port->icount.parity++;
-			} else if (lsr & UART_LSR_FE) {
-				tty_flag = TTY_FRAME;
-				port->icount.frame++;
-			}
-
-			if (lsr & UART_LSR_OE) {
-				port->icount.overrun++;
-				schedule_work(&priv->lsr_work);
-				tty_insert_flip_char(&port->port, 0,
-						TTY_OVERRUN);
-			}
-		}
+		tty_flag = f81232_handle_lsr(port, lsr);
 
 		if (port->port.console && port->sysrq) {
 			if (usb_serial_handle_sysrq_char(port, data[i + 1]))
-- 
2.17.1

