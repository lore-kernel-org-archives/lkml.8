Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A82C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400F3206C9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kfQszv74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgICVKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:10:51 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:20350 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgICVKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:10:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599167447; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=+92L8rCs5Qj2hNgiOrOiCHxci4B2giXkbMRgaJdNbaU=; b=kfQszv74oVn0zCNr7Z4CWZJvOLeDvq5XbDSAuyKUzwDiO3St3AEN566BpLjShI95+GFtZpiJ
 6q2pc90WVL+9KmGu/IeG26EYHb5lJ28q2IiBqk5g9GkZm6nMBsyy8QrJv9OcCdSMa1rOG17B
 ObNvod5cLFZLvQjP2dMUPcZzQ9c=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f515bad25e1ee7586dd7e56 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 21:10:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D405AC43391; Thu,  3 Sep 2020 21:10:03 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87CC8C433C8;
        Thu,  3 Sep 2020 21:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87CC8C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v3] usb: dwc3: Stop active transfers before halting the controller
Date:   Thu,  3 Sep 2020 14:09:54 -0700
Message-Id: <20200903210954.24504-1-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the DWC3 databook, for a device initiated disconnect or bus reset, the
driver is required to send dependxfer commands for any pending transfers.
In addition, before the controller can move to the halted state, the SW
needs to acknowledge any pending events.  If the controller is not halted
properly, there is a chance the controller will continue accessing stale or
freed TRBs and buffers.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>

---
Changes in v3:
 - Removed DWC3_EP_ENABLED check from dwc3_gadget_stop_active_transfers()
   as dwc3_stop_active_transfer() has a check already in place.
 - Calling __dwc3_gadget_stop() which ensures that DWC3 interrupt events
   are cleared, and ep0 eps are cleared for the pullup disabled case.  Not
   required to call __dwc3_gadget_start() on pullup enable, as the
   composite driver will execute udc_start() before calling pullup().

Changes in v2:
 - Moved cleanup code to the pullup() API to differentiate between device
   disconnect and hibernation.
 - Added cleanup code to the bus reset case as well.
 - Verified the move to pullup() did not reproduce the problen using the
   same test sequence.

Verified fix by adding a check for ETIMEDOUT during the run stop call.
Shell script writing to the configfs UDC file to trigger disconnect and
connect.  Batch script to have PC execute data transfers over adb (ie adb
push)  After a few iterations, we'd run into a scenario where the
controller wasn't halted.  With the following change, no failed halts after
many iterations.
---
 drivers/usb/dwc3/ep0.c    |  2 +-
 drivers/usb/dwc3/gadget.c | 49 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 59f2e8c31bd1..456aa87e8778 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -197,7 +197,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!dep->endpoint.desc) {
+	if (!dep->endpoint.desc || !dwc->pullups_connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		ret = -ESHUTDOWN;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3ab6f118c508..73bda7eaa773 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1516,7 +1516,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 {
 	struct dwc3		*dwc = dep->dwc;
 
-	if (!dep->endpoint.desc) {
+	if (!dep->endpoint.desc || !dwc->pullups_connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		return -ESHUTDOWN;
@@ -1926,6 +1926,21 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 	return 0;
 }
 
+static void dwc3_stop_active_transfers(struct dwc3 *dwc)
+{
+	u32 epnum;
+
+	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
+		struct dwc3_ep *dep;
+
+		dep = dwc->eps[epnum];
+		if (!dep)
+			continue;
+
+		dwc3_remove_requests(dwc, dep);
+	}
+}
+
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
@@ -1971,6 +1986,8 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 	return 0;
 }
 
+static void __dwc3_gadget_stop(struct dwc3 *dwc);
+
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
@@ -1994,9 +2011,37 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		}
 	}
 
+	/*
+	 * Synchronize and disable any further event handling while controller
+	 * is being enabled/disabled.
+	 */
+	disable_irq(dwc->irq_gadget);
 	spin_lock_irqsave(&dwc->lock, flags);
+
+	/* Controller is not halted until pending events are acknowledged */
+	if (!is_on) {
+		u32 count;
+
+		/*
+		 * The databook explicitly mentions for a device-initiated
+		 * disconnect sequence, the SW needs to ensure that it ends any
+		 * active transfers.
+		 */
+		dwc3_stop_active_transfers(dwc);
+		__dwc3_gadget_stop(dwc);
+
+		count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+		count &= DWC3_GEVNTCOUNT_MASK;
+		if (count > 0) {
+			dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
+			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
+						dwc->ev_buf->length;
+		}
+	}
+
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	enable_irq(dwc->irq_gadget);
 
 	return ret;
 }
@@ -3100,6 +3145,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	}
 
 	dwc3_reset_gadget(dwc);
+	/* Stop any active/pending transfers when receiving bus reset */
+	dwc3_stop_active_transfers(dwc);
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

