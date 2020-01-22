Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DEBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F6D20678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699137;
	bh=GEucGcrwQrno+kOd+yLphpF5a5JKjHODK4tOdIVlcto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eJvZCm4ZcDU5dTAr8K5IS8mSuLoZAulMsFbqANuseKppR42IAN1+PUR8g2cOqHXHh
	 45O/VkcOwZEoocspCvKCVMB+Y6fP/cfgjSEJifbMs0LU5Dq7TqzV0KBw46zTAZpD/Q
	 1hsH4TtMUcaSAjDep6DYWD7DFLrnHPNtztsYMj90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgAVNS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:18:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729441AbgAVNSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:18:50 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5A06205F4;
        Wed, 22 Jan 2020 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699129;
        bh=GEucGcrwQrno+kOd+yLphpF5a5JKjHODK4tOdIVlcto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQn0JdGlm4NmcT8LetH2qELFDDcHk4o2BL0c+6GGsv7FIBSVxiLyepfZhH9rZOaBf
         Lnj0WrgtcJyFXA02jCqIXV3b6U16/MwnqDe4N0Rp1CbMFgFwa0Q5VFjlsfN+Kw5bCk
         774cerD9131yLXZjC0FHzeKVyaw7bLPKHiBAF8Zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 050/222] USB: serial: io_edgeport: add missing active-port sanity check
Date:   Wed, 22 Jan 2020 10:27:16 +0100
Message-Id: <20200122092837.188355759@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 1568c58d11a7c851bd09341aeefd6a1c308ac40d upstream.

The driver receives the active port number from the device, but never
made sure that the port number was valid. This could lead to a
NULL-pointer dereference or memory corruption in case a device sends
data for an invalid port.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/io_edgeport.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1725,7 +1725,8 @@ static void edge_break(struct tty_struct
 static void process_rcvd_data(struct edgeport_serial *edge_serial,
 				unsigned char *buffer, __u16 bufferLength)
 {
-	struct device *dev = &edge_serial->serial->dev->dev;
+	struct usb_serial *serial = edge_serial->serial;
+	struct device *dev = &serial->dev->dev;
 	struct usb_serial_port *port;
 	struct edgeport_port *edge_port;
 	__u16 lastBufferLength;
@@ -1821,9 +1822,8 @@ static void process_rcvd_data(struct edg
 
 			/* spit this data back into the tty driver if this
 			   port is open */
-			if (rxLen) {
-				port = edge_serial->serial->port[
-							edge_serial->rxPort];
+			if (rxLen && edge_serial->rxPort < serial->num_ports) {
+				port = serial->port[edge_serial->rxPort];
 				edge_port = usb_get_serial_port_data(port);
 				if (edge_port && edge_port->open) {
 					dev_dbg(dev, "%s - Sending %d bytes to TTY for port %d\n",
@@ -1833,8 +1833,8 @@ static void process_rcvd_data(struct edg
 							rxLen);
 					edge_port->port->icount.rx += rxLen;
 				}
-				buffer += rxLen;
 			}
+			buffer += rxLen;
 			break;
 
 		case EXPECT_HDR3:	/* Expect 3rd byte of status header */
@@ -1869,6 +1869,8 @@ static void process_rcvd_status(struct e
 	__u8 code = edge_serial->rxStatusCode;
 
 	/* switch the port pointer to the one being currently talked about */
+	if (edge_serial->rxPort >= edge_serial->serial->num_ports)
+		return;
 	port = edge_serial->serial->port[edge_serial->rxPort];
 	edge_port = usb_get_serial_port_data(port);
 	if (edge_port == NULL) {


