Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98158C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682AD20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926896;
	bh=uPeGqQXkvY7c5Sqc18JCLPAOGTvavRRRr4EheBmcF8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W0oEXsO7fC1HHa8YPc9JwUJ54kAfUwzF3rbHFmNRy+UvyErc215OKHlfNZ3iOdfUZ
	 f1rOUOEnEa/addz+zzj3X8khp1x9YHmzG2nyeOFO3BBz7wFkVrdlMjbYDzAKRv1KA1
	 pBUZfQrz+R0F/OFpziNBNzpsLIesSQtHhb/kcX2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgHTMez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgHTJsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:48:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A98D2173E;
        Thu, 20 Aug 2020 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916914;
        bh=uPeGqQXkvY7c5Sqc18JCLPAOGTvavRRRr4EheBmcF8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6h3D9SdSKfh9N8mxr9KSlipbeVWOukTw0DwaieA1EIm1Y7i0i+G4VETXfDNeDroS
         xlREJaA6pcJun3SqDotaItZPHmMOrK01bn4rSrMOEuO234MS2+e3Gy92MCdNhZMshV
         ficsrojkan6WqRUd5clTCseLh1LzMR1yV4+hB7Sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 091/152] USB: serial: ftdi_sio: fix break and sysrq handling
Date:   Thu, 20 Aug 2020 11:20:58 +0200
Message-Id: <20200820091558.394549455@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 733fff67941dad64b8a630450b8372b1873edc41 ]

Only the last NUL in a packet should be flagged as a break character,
for example, to avoid dropping unrelated characters when IGNBRK is set.

Also make sysrq work by consuming the break character instead of having
it immediately cancel the sysrq request, and by not processing it
prematurely to avoid triggering a sysrq based on an unrelated character
received in the same packet (which was received *before* the break).

Note that the break flag can be left set also for a packet received
immediately following a break and that and an ending NUL in such a
packet will continue to be reported as a break as there's no good way to
tell it apart from an actual break.

Tested on FT232R and FT232H.

Fixes: 72fda3ca6fc1 ("USB: serial: ftd_sio: implement sysrq handling on break")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 33f1cca7eaa61..07b146d7033a6 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2483,6 +2483,7 @@ static int ftdi_process_packet(struct usb_serial_port *port,
 		struct ftdi_private *priv, unsigned char *buf, int len)
 {
 	unsigned char status;
+	bool brkint = false;
 	int i;
 	char flag;
 
@@ -2534,13 +2535,17 @@ static int ftdi_process_packet(struct usb_serial_port *port,
 	 */
 	flag = TTY_NORMAL;
 	if (buf[1] & FTDI_RS_ERR_MASK) {
-		/* Break takes precedence over parity, which takes precedence
-		 * over framing errors */
-		if (buf[1] & FTDI_RS_BI) {
-			flag = TTY_BREAK;
+		/*
+		 * Break takes precedence over parity, which takes precedence
+		 * over framing errors. Note that break is only associated
+		 * with the last character in the buffer and only when it's a
+		 * NUL.
+		 */
+		if (buf[1] & FTDI_RS_BI && buf[len - 1] == '\0') {
 			port->icount.brk++;
-			usb_serial_handle_break(port);
-		} else if (buf[1] & FTDI_RS_PE) {
+			brkint = true;
+		}
+		if (buf[1] & FTDI_RS_PE) {
 			flag = TTY_PARITY;
 			port->icount.parity++;
 		} else if (buf[1] & FTDI_RS_FE) {
@@ -2556,8 +2561,13 @@ static int ftdi_process_packet(struct usb_serial_port *port,
 
 	port->icount.rx += len - 2;
 
-	if (port->port.console && port->sysrq) {
+	if (brkint || (port->port.console && port->sysrq)) {
 		for (i = 2; i < len; i++) {
+			if (brkint && i == len - 1) {
+				if (usb_serial_handle_break(port))
+					return len - 3;
+				flag = TTY_BREAK;
+			}
 			if (usb_serial_handle_sysrq_char(port, buf[i]))
 				continue;
 			tty_insert_flip_char(&port->port, buf[i], flag);
-- 
2.25.1



