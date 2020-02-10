Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C05C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C3020714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340122;
	bh=w16WrdxQwte7W7Dx1UrCfaCKoSIdMxp1Z6eyuv/J3IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0lC3cow0kp2aLqKl4r4Pp/y5Q703MGoF7tgfHr73JXeyQOlAYZBRn5nXh6ncb5ata
	 kzOp8JRmSNGp7zGI9pV6vDaslBTbwZ6JjZG/wYEqR8wJm3ihVC+oYXdcq0FNMxygUx
	 p+9fDxPNuf8ZazGBF+LMVm9GeicWLLztOwLVRDAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgBJNIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbgBJMjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:31 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8703620733;
        Mon, 10 Feb 2020 12:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338371;
        bh=w16WrdxQwte7W7Dx1UrCfaCKoSIdMxp1Z6eyuv/J3IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/sqLvX6EVqDj9OSeP7HTn3xWcbcPOvHt3jxR/IDByZPEvOP/51prx4rZ2mNSfDtN
         cFvgHdHlijPujV1dF6IhMrlEefw+Ytfrakrt4wLlS/d36ZScuLztyMFH+3TjbYNJll
         +3k60IAcIBjZQ7ywjKOlPLGqEHeVJdLkYP4eOfSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.5 043/367] usb: dwc3: gadget: Check END_TRANSFER completion
Date:   Mon, 10 Feb 2020 04:29:16 -0800
Message-Id: <20200210122427.992022839@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit c58d8bfc77a2c7f6ff6339b58c9fca7ae6f57e70 upstream.

While the END_TRANSFER command is sent but not completed, any request
dequeue during this time will cause the driver to issue the END_TRANSFER
command. The driver needs to submit the command only once to stop the
controller from processing further. The controller may take more time to
process the same command multiple times unnecessarily. Let's add a flag
DWC3_EP_END_TRANSFER_PENDING to check for this condition.

Fixes: 3aec99154db3 ("usb: dwc3: gadget: remove DWC3_EP_END_TRANSFER_PENDING")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/core.h   |    1 +
 drivers/usb/dwc3/ep0.c    |    4 +++-
 drivers/usb/dwc3/gadget.c |    6 +++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -688,6 +688,7 @@ struct dwc3_ep {
 #define DWC3_EP_STALL		BIT(1)
 #define DWC3_EP_WEDGE		BIT(2)
 #define DWC3_EP_TRANSFER_STARTED BIT(3)
+#define DWC3_EP_END_TRANSFER_PENDING BIT(4)
 #define DWC3_EP_PENDING_REQUEST	BIT(5)
 
 	/* This last one is specific to EP0 */
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1136,8 +1136,10 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc
 	case DWC3_DEPEVT_EPCMDCMPLT:
 		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
 
-		if (cmd == DWC3_DEPCMD_ENDTRANSFER)
+		if (cmd == DWC3_DEPCMD_ENDTRANSFER) {
+			dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+		}
 		break;
 	}
 }
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2625,6 +2625,7 @@ static void dwc3_endpoint_interrupt(stru
 		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
 
 		if (cmd == DWC3_DEPCMD_ENDTRANSFER) {
+			dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
 			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 			dwc3_gadget_ep_cleanup_cancelled_requests(dep);
 		}
@@ -2683,7 +2684,8 @@ static void dwc3_stop_active_transfer(st
 	u32 cmd;
 	int ret;
 
-	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
+	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
+	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 		return;
 
 	/*
@@ -2728,6 +2730,8 @@ static void dwc3_stop_active_transfer(st
 
 	if (!interrupt)
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+	else
+		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 
 	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A)
 		udelay(100);


