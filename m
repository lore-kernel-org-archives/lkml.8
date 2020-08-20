Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C31C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548BC20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926242;
	bh=4GW/W+1sCL7OmzGDJ9PjUYj5qsFNfoPH9Zi3JGcS6MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ePnZAl/uV2cHWN1knnGTcrXMTporsbl3M1lVEEWGFvyZAg9zAN+O7Ql6fRhP684NO
	 +dPUJAXS695/Tk0B+3new+SeKfgcEitBCHJZpzaguQWo5EvmodBd8k1UF8HbjfxIZD
	 mGuU34dpG/17hzmwaA8A+5R2MwSF5EIojIlSg8ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgHTJyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730086AbgHTJyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:54:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70FF82067C;
        Thu, 20 Aug 2020 09:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917242;
        bh=4GW/W+1sCL7OmzGDJ9PjUYj5qsFNfoPH9Zi3JGcS6MI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDNlErYau9WMihbGvmUkp2/jWVVcmC2JqRzyOfxDHXRJkJ4ZVxHRWS29alGbb1pAh
         ff0gmLDAcVkpXsNI2yEEipZM0Fz26DA6pp7GrSaFUXVsFSslUaAJAi3LvYhPWhZX/i
         l0Sx1lOQdu1coCK+3ZBLsG18KWt4wFYzo9RYr7Qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 54/92] USB: serial: ftdi_sio: make process-packet buffer unsigned
Date:   Thu, 20 Aug 2020 11:21:39 +0200
Message-Id: <20200820091540.438112785@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit ab4cc4ef6724ea588e835fc1e764c4b4407a70b7 ]

Use an unsigned type for the process-packet buffer argument and give it
a more apt name.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 3c0f38cd3a5a4..d0ae6318d6e96 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2037,12 +2037,12 @@ static int ftdi_prepare_write_buffer(struct usb_serial_port *port,
 #define FTDI_RS_ERR_MASK (FTDI_RS_BI | FTDI_RS_PE | FTDI_RS_FE | FTDI_RS_OE)
 
 static int ftdi_process_packet(struct usb_serial_port *port,
-		struct ftdi_private *priv, char *packet, int len)
+		struct ftdi_private *priv, unsigned char *buf, int len)
 {
+	unsigned char status;
+	unsigned char *ch;
 	int i;
-	char status;
 	char flag;
-	char *ch;
 
 	if (len < 2) {
 		dev_dbg(&port->dev, "malformed packet\n");
@@ -2052,7 +2052,7 @@ static int ftdi_process_packet(struct usb_serial_port *port,
 	/* Compare new line status to the old one, signal if different/
 	   N.B. packet may be processed more than once, but differences
 	   are only processed once.  */
-	status = packet[0] & FTDI_STATUS_B0_MASK;
+	status = buf[0] & FTDI_STATUS_B0_MASK;
 	if (status != priv->prev_status) {
 		char diff_status = status ^ priv->prev_status;
 
@@ -2078,7 +2078,7 @@ static int ftdi_process_packet(struct usb_serial_port *port,
 	}
 
 	/* save if the transmitter is empty or not */
-	if (packet[1] & FTDI_RS_TEMT)
+	if (buf[1] & FTDI_RS_TEMT)
 		priv->transmit_empty = 1;
 	else
 		priv->transmit_empty = 0;
@@ -2092,29 +2092,29 @@ static int ftdi_process_packet(struct usb_serial_port *port,
 	 * data payload to avoid over-reporting.
 	 */
 	flag = TTY_NORMAL;
-	if (packet[1] & FTDI_RS_ERR_MASK) {
+	if (buf[1] & FTDI_RS_ERR_MASK) {
 		/* Break takes precedence over parity, which takes precedence
 		 * over framing errors */
-		if (packet[1] & FTDI_RS_BI) {
+		if (buf[1] & FTDI_RS_BI) {
 			flag = TTY_BREAK;
 			port->icount.brk++;
 			usb_serial_handle_break(port);
-		} else if (packet[1] & FTDI_RS_PE) {
+		} else if (buf[1] & FTDI_RS_PE) {
 			flag = TTY_PARITY;
 			port->icount.parity++;
-		} else if (packet[1] & FTDI_RS_FE) {
+		} else if (buf[1] & FTDI_RS_FE) {
 			flag = TTY_FRAME;
 			port->icount.frame++;
 		}
 		/* Overrun is special, not associated with a char */
-		if (packet[1] & FTDI_RS_OE) {
+		if (buf[1] & FTDI_RS_OE) {
 			port->icount.overrun++;
 			tty_insert_flip_char(&port->port, 0, TTY_OVERRUN);
 		}
 	}
 
 	port->icount.rx += len;
-	ch = packet + 2;
+	ch = buf + 2;
 
 	if (port->port.console && port->sysrq) {
 		for (i = 0; i < len; i++, ch++) {
-- 
2.25.1



