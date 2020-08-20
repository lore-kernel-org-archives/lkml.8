Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B65C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E21207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916422;
	bh=RHqDz9lR5Du0csNXTtFqx68ndUQQKIhitffvzRzCYBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r7UqhOY5w2RzQ0GIoN08TDg0gy+IXagv3+W0LJCnJoeLpxxf0bbSsNhhWsac125J6
	 0Lwr3pq4THKlAGSubbZrE+n4LhsfaEEco0o0f42SlGXtfJhlAo9jNEWakWZgkzOXqc
	 SIrkqc/Y8M1WmClQRh+64IW/IVv/yXZKPI7VbA/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgHTJkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbgHTJkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:40:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9DBC2173E;
        Thu, 20 Aug 2020 09:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916411;
        bh=RHqDz9lR5Du0csNXTtFqx68ndUQQKIhitffvzRzCYBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4fENWd6Vji4eqCwVQAPK7stbzZPZA8VnE8lchb6pnlQOhsKgJYU+QL71lw3Lk1S8
         ryWGj34JxvWwoQp7QSBUrK1tfS/t3x580st9ru54hxwKRoUuohxjS78BxOi0A8ZKzq
         nTcsM0U0VuOeyGWBUUUvHS/TkBDfUXaxjts1HjaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 118/204] USB: serial: ftdi_sio: clean up receive processing
Date:   Thu, 20 Aug 2020 11:20:15 +0200
Message-Id: <20200820091612.202744208@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit ce054039ba5e47b75a3be02a00274e52b06a6456 ]

Clean up receive processing by dropping the character pointer and
keeping the length argument unchanged throughout the function.

Also make it more apparent that sysrq processing can consume a
characters by adding an explicit continue.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 96b9e2768ac5c..33f1cca7eaa61 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2483,7 +2483,6 @@ static int ftdi_process_packet(struct usb_serial_port *port,
 		struct ftdi_private *priv, unsigned char *buf, int len)
 {
 	unsigned char status;
-	unsigned char *ch;
 	int i;
 	char flag;
 
@@ -2526,8 +2525,7 @@ static int ftdi_process_packet(struct usb_serial_port *port,
 	else
 		priv->transmit_empty = 0;
 
-	len -= 2;
-	if (!len)
+	if (len == 2)
 		return 0;	/* status only */
 
 	/*
@@ -2556,19 +2554,20 @@ static int ftdi_process_packet(struct usb_serial_port *port,
 		}
 	}
 
-	port->icount.rx += len;
-	ch = buf + 2;
+	port->icount.rx += len - 2;
 
 	if (port->port.console && port->sysrq) {
-		for (i = 0; i < len; i++, ch++) {
-			if (!usb_serial_handle_sysrq_char(port, *ch))
-				tty_insert_flip_char(&port->port, *ch, flag);
+		for (i = 2; i < len; i++) {
+			if (usb_serial_handle_sysrq_char(port, buf[i]))
+				continue;
+			tty_insert_flip_char(&port->port, buf[i], flag);
 		}
 	} else {
-		tty_insert_flip_string_fixed_flag(&port->port, ch, flag, len);
+		tty_insert_flip_string_fixed_flag(&port->port, buf + 2, flag,
+				len - 2);
 	}
 
-	return len;
+	return len - 2;
 }
 
 static void ftdi_process_read_urb(struct urb *urb)
-- 
2.25.1



