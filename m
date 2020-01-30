Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29627C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CFB214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409747;
	bh=UNYeffwflkB4nlDCvZj9SMgwFmgILprKumpSGTZkwe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zTByy5UZ0n+d4D2EBC+l1RqJ5WoZEEuxaJHkPenFKPS++TZ36+uJeNwFivRMVptmb
	 yvpMvM0kko/q9liEQ3sWIKJPJqEmxOZf5T2vM9eFbji+nI9kEGovebjb6jQPedfqPw
	 0VdkxuKKYyl167L9xE4nG0sQ3q7P/DofUloJ6bRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgA3Sm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730367AbgA3SmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:42:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB1F20702;
        Thu, 30 Jan 2020 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409740;
        bh=UNYeffwflkB4nlDCvZj9SMgwFmgILprKumpSGTZkwe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HA3IROycZ/53/dc3Ma6CSa1RHJfLp/bhUP5qku8J6GOnQ0S3x3bj32iJAGbLu9/iz
         gI4e5Rv7rWxupMHGdYUacQMi97B7hV5nxrlbIPLGo16WTIXhoORm2pXoU2if/Gn5lG
         FbKALHHzR72Yp+Q5XmxFqauH4tfnSUFIywvCbXVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 007/110] USB: serial: ir-usb: fix link-speed handling
Date:   Thu, 30 Jan 2020 19:37:43 +0100
Message-Id: <20200130183615.018296729@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 17a0184ca17e288decdca8b2841531e34d49285f upstream.

Commit e0d795e4f36c ("usb: irda: cleanup on ir-usb module") added a USB
IrDA header with common defines, but mistakingly switched to using the
class-descriptor baud-rate bitmask values for the outbound header.

This broke link-speed handling for rates above 9600 baud, but a device
would also be able to operate at the default 9600 baud until a
link-speed request was issued (e.g. using the TCGETS ioctl).

Fixes: e0d795e4f36c ("usb: irda: cleanup on ir-usb module")
Cc: stable <stable@vger.kernel.org>     # 2.6.27
Cc: Felipe Balbi <balbi@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ir-usb.c |   20 ++++++++++----------
 include/linux/usb/irda.h    |   13 ++++++++++++-
 2 files changed, 22 insertions(+), 11 deletions(-)

--- a/drivers/usb/serial/ir-usb.c
+++ b/drivers/usb/serial/ir-usb.c
@@ -335,34 +335,34 @@ static void ir_set_termios(struct tty_st
 
 	switch (baud) {
 	case 2400:
-		ir_baud = USB_IRDA_BR_2400;
+		ir_baud = USB_IRDA_LS_2400;
 		break;
 	case 9600:
-		ir_baud = USB_IRDA_BR_9600;
+		ir_baud = USB_IRDA_LS_9600;
 		break;
 	case 19200:
-		ir_baud = USB_IRDA_BR_19200;
+		ir_baud = USB_IRDA_LS_19200;
 		break;
 	case 38400:
-		ir_baud = USB_IRDA_BR_38400;
+		ir_baud = USB_IRDA_LS_38400;
 		break;
 	case 57600:
-		ir_baud = USB_IRDA_BR_57600;
+		ir_baud = USB_IRDA_LS_57600;
 		break;
 	case 115200:
-		ir_baud = USB_IRDA_BR_115200;
+		ir_baud = USB_IRDA_LS_115200;
 		break;
 	case 576000:
-		ir_baud = USB_IRDA_BR_576000;
+		ir_baud = USB_IRDA_LS_576000;
 		break;
 	case 1152000:
-		ir_baud = USB_IRDA_BR_1152000;
+		ir_baud = USB_IRDA_LS_1152000;
 		break;
 	case 4000000:
-		ir_baud = USB_IRDA_BR_4000000;
+		ir_baud = USB_IRDA_LS_4000000;
 		break;
 	default:
-		ir_baud = USB_IRDA_BR_9600;
+		ir_baud = USB_IRDA_LS_9600;
 		baud = 9600;
 	}
 
--- a/include/linux/usb/irda.h
+++ b/include/linux/usb/irda.h
@@ -119,11 +119,22 @@ struct usb_irda_cs_descriptor {
  * 6 - 115200 bps
  * 7 - 576000 bps
  * 8 - 1.152 Mbps
- * 9 - 5 mbps
+ * 9 - 4 Mbps
  * 10..15 - Reserved
  */
 #define USB_IRDA_STATUS_LINK_SPEED	0x0f
 
+#define USB_IRDA_LS_NO_CHANGE		0
+#define USB_IRDA_LS_2400		1
+#define USB_IRDA_LS_9600		2
+#define USB_IRDA_LS_19200		3
+#define USB_IRDA_LS_38400		4
+#define USB_IRDA_LS_57600		5
+#define USB_IRDA_LS_115200		6
+#define USB_IRDA_LS_576000		7
+#define USB_IRDA_LS_1152000		8
+#define USB_IRDA_LS_4000000		9
+
 /* The following is a 4-bit value used only for
  * outbound header:
  *


