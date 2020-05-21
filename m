Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237072072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgEUPNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:13:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53284 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgEUPNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:13:07 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jbmsX-0004ep-7T; Thu, 21 May 2020 15:13:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: lpc32xx_udc: don't dereference ep pointer before null check
Date:   Thu, 21 May 2020 16:13:00 +0100
Message-Id: <20200521151300.347496-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently pointer ep is being dereferenced before it is null checked
leading to a null pointer dereference issue.  Fix this by only assigning
pointer udc once ep is known to be not null.  Also remove a debug
message that requires a valid udc which may not be possible at that
point.

Addresses-Coverity: ("Dereference before null check")
Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index cb997b82c008..7aefd6b5597b 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -1614,17 +1614,17 @@ static int lpc32xx_ep_enable(struct usb_ep *_ep,
 			     const struct usb_endpoint_descriptor *desc)
 {
 	struct lpc32xx_ep *ep = container_of(_ep, struct lpc32xx_ep, ep);
-	struct lpc32xx_udc *udc = ep->udc;
+	struct lpc32xx_udc *udc;
 	u16 maxpacket;
 	u32 tmp;
 	unsigned long flags;
 
 	/* Verify EP data */
 	if ((!_ep) || (!ep) || (!desc) ||
-	    (desc->bDescriptorType != USB_DT_ENDPOINT)) {
-		dev_dbg(udc->dev, "bad ep or descriptor\n");
+	    (desc->bDescriptorType != USB_DT_ENDPOINT))
 		return -EINVAL;
-	}
+
+	udc = ep->udc;
 	maxpacket = usb_endpoint_maxp(desc);
 	if ((maxpacket == 0) || (maxpacket > ep->maxpacket)) {
 		dev_dbg(udc->dev, "bad ep descriptor's packet size\n");
@@ -1872,7 +1872,7 @@ static int lpc32xx_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 static int lpc32xx_ep_set_halt(struct usb_ep *_ep, int value)
 {
 	struct lpc32xx_ep *ep = container_of(_ep, struct lpc32xx_ep, ep);
-	struct lpc32xx_udc *udc = ep->udc;
+	struct lpc32xx_udc *udc;
 	unsigned long flags;
 
 	if ((!ep) || (ep->hwep_num <= 1))
@@ -1882,6 +1882,7 @@ static int lpc32xx_ep_set_halt(struct usb_ep *_ep, int value)
 	if (ep->is_in)
 		return -EAGAIN;
 
+	udc = ep->udc;
 	spin_lock_irqsave(&udc->lock, flags);
 
 	if (value == 1) {
-- 
2.25.1

