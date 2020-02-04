Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AB7C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DFD2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="A0XINnLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBDPtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:49:16 -0500
Received: from dougal.metanate.com ([90.155.101.14]:30752 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727311AbgBDPtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:49:16 -0500
X-Greylist: delayed 1165 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Feb 2020 10:49:16 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OvOkKA8YrVohxNFd6lUTWVLJe0uQSPQYn+QRHOVtyyg=; b=A0XINnLprZlnob0BQI7yIkZXrD
        6BmMJ+A9vN6KR/V+r/RVNTpKxjZ9Uoo9JKQKPQqhoR/VRLpCUPcdjjR/IIxImfkQ7U6NkdveRJH9Z
        gU4Lziw/cgQe9/KnV7CIl4n3Jii2nXs+dcXi5S0q5hBgTqE7zaksrO+ZEJ/dLDCDpsUfaDrASTC+L
        N1Zt6uoZzS3yESED2vZgW5GvgA0AHfhFfrA5tCOItSDD7bOr4CaDorGP2ynnZz3gzIHadS1NJ97jy
        l7zTHytXkeYjD4fcrA8XG08FfM7XjitHYtbFVIIHlw/fNWajkG7HfaprM/ypGmwb6m7cSqeEzL84W
        HuuKav6Q==;
Received: from dougal.metanate.com ([192.168.88.1] helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1iz095-0002mK-9X; Tue, 04 Feb 2020 15:29:47 +0000
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>, John Keeping <john@metanate.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:DESIGNWARE USB2 DRD IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] usb: dwc2: Implement set_selfpowered()
Date:   Tue,  4 Feb 2020 15:29:33 +0000
Message-Id: <20200204152933.2216615-1-john@metanate.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dwc2 always reports as self-powered in response to a device status
request.  Implement the set_selfpowered() operations so that the gadget
can report as bus-powered when appropriate.

This is modelled on the dwc3 implementation.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/dwc2/gadget.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 2717f4401b97..76c0a5242175 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1646,7 +1646,8 @@ static int dwc2_hsotg_process_req_status(struct dwc2_hsotg *hsotg,
 
 	switch (ctrl->bRequestType & USB_RECIP_MASK) {
 	case USB_RECIP_DEVICE:
-		status = 1 << USB_DEVICE_SELF_POWERED;
+		status = hsotg->gadget.is_selfpowered <<
+			 USB_DEVICE_SELF_POWERED;
 		status |= hsotg->remote_wakeup_allowed <<
 			  USB_DEVICE_REMOTE_WAKEUP;
 		reply = cpu_to_le16(status);
@@ -4530,6 +4531,26 @@ static int dwc2_hsotg_gadget_getframe(struct usb_gadget *gadget)
 	return dwc2_hsotg_read_frameno(to_hsotg(gadget));
 }
 
+/**
+ * dwc2_hsotg_set_selfpowered - set if device is self/bus powered
+ * @gadget: The usb gadget state
+ * @is_selfpowered: Whether the device is self-powered
+ *
+ * Set if the device is self or bus powered.
+ */
+static int dwc2_hsotg_set_selfpowered(struct usb_gadget *gadget,
+				      int is_selfpowered)
+{
+	struct dwc2_hsotg *hsotg = to_hsotg(gadget);
+	unsigned long flags;
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	gadget->is_selfpowered = !!is_selfpowered;
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	return 0;
+}
+
 /**
  * dwc2_hsotg_pullup - connect/disconnect the USB PHY
  * @gadget: The usb gadget state
@@ -4621,6 +4642,7 @@ static int dwc2_hsotg_vbus_draw(struct usb_gadget *gadget, unsigned int mA)
 
 static const struct usb_gadget_ops dwc2_hsotg_gadget_ops = {
 	.get_frame	= dwc2_hsotg_gadget_getframe,
+	.set_selfpowered	= dwc2_hsotg_set_selfpowered,
 	.udc_start		= dwc2_hsotg_udc_start,
 	.udc_stop		= dwc2_hsotg_udc_stop,
 	.pullup                 = dwc2_hsotg_pullup,
-- 
2.25.0

