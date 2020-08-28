Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F17C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CAB20838
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qFXL1PfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgH1Wot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:44:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62301 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgH1Wor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:44:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598654686; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=7zYeKLZuM7Jqdsbun4qwTZWBNVjMkdc6/XUKOp3cAGk=; b=qFXL1PfF6KrVWlIRqnCmbuq5qKZKllu6iYO1XX9KpdP3BckfFmVG2+QajEUlh8lNOan9fphB
 wEP3ZsnBj7rCDfkHJOf8mHpvy6kxkpN89C5/ClY26mYAV150/kyI6sZfB9qztP4hMS5y7ofO
 7gg5xp6lacXo7eiX3VVa+Wf3+y4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f4988deebeeb2610602a5c4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 22:44:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7141C43391; Fri, 28 Aug 2020 22:44:45 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1D76C433CA;
        Fri, 28 Aug 2020 22:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1D76C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v2] usb: dwc3: Stop active transfers before halting the controller
Date:   Fri, 28 Aug 2020 15:44:40 -0700
Message-Id: <20200828224440.22091-1-wcheng@codeaurora.org>
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
 drivers/usb/dwc3/gadget.c | 52 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

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
index 3ab6f118c508..df8d89d6bdc9 100644
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
@@ -1926,6 +1926,24 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
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
+		if (!(dep->flags & DWC3_EP_ENABLED))
+			continue;
+
+		dwc3_remove_requests(dwc, dep);
+	}
+}
+
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
@@ -1994,9 +2012,39 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
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
+		u32 reg;
+
+		__dwc3_gadget_ep_disable(dwc->eps[0]);
+		__dwc3_gadget_ep_disable(dwc->eps[1]);
+
+		/*
+		 * The databook explicitly mentions for a device-initiated
+		 * disconnect sequence, the SW needs to ensure that it ends any
+		 * active transfers.
+		 */
+		dwc3_stop_active_transfers(dwc);
+
+		reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+		reg &= DWC3_GEVNTCOUNT_MASK;
+		if (reg > 0) {
+			dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
+			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + reg) %
+						dwc->ev_buf->length;
+		}
+	}
+
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	enable_irq(dwc->irq_gadget);
 
 	return ret;
 }
@@ -3100,6 +3148,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	}
 
 	dwc3_reset_gadget(dwc);
+	/* Stop any active/pending transfers when receiving bus reset */
+	dwc3_stop_active_transfers(dwc);
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

