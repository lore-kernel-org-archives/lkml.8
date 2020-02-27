Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407A2C52D4E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BED21D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812490;
	bh=Dqe8peYwQwuHYE4wE7HzqKcEV4TelEPWey30f3hiVvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ewzUc3azvoNHq0KR4hyMgvAuWnwVk9gHzKVcW1biyin47pFTAESmD9wAHMJdHBZY0
	 Xy7Jho2WlwF5gNw/h4mc6aZ9hcHVHcysjBp+CC9Hv/b3irUKi5NuEJPymPoZvSWGkS
	 XbnafvECj00FtmhdmkH0fpKwaKfGqncP5u4s46HE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbgB0OIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:08:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732780AbgB0OID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:08:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B67F124656;
        Thu, 27 Feb 2020 14:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812482;
        bh=Dqe8peYwQwuHYE4wE7HzqKcEV4TelEPWey30f3hiVvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piNiDJA5MISFO0L1gl3TMJ8mgk9F6BB2k1+TEVWFoGK4Atkv54dCEnST2MfiFJ4pE
         fWcSQnkom840wGyCKxrtXaOzIRQ0qwSMgqHCcBoAw1RCJHRhTnmobyPMK4dT17cVKV
         879c9fYr8DnrtDKxvgyehKbV70VW1MQloZWR+IB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 5.4 035/135] usb: dwc3: gadget: Check for IOC/LST bit in TRB->ctrl fields
Date:   Thu, 27 Feb 2020 14:36:15 +0100
Message-Id: <20200227132234.268741998@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

commit 5ee858975b13a9b40db00f456989a689fdbb296c upstream.

The current code in dwc3_gadget_ep_reclaim_completed_trb() will
check for IOC/LST bit in the event->status and returns if
IOC/LST bit is set. This logic doesn't work if multiple TRBs
are queued per request and the IOC/LST bit is set on the last
TRB of that request.

Consider an example where a queued request has multiple queued
TRBs and IOC/LST bit is set only for the last TRB. In this case,
the core generates XferComplete/XferInProgress events only for
the last TRB (since IOC/LST are set only for the last TRB). As
per the logic in dwc3_gadget_ep_reclaim_completed_trb()
event->status is checked for IOC/LST bit and returns on the
first TRB. This leaves the remaining TRBs left unhandled.

Similarly, if the gadget function enqueues an unaligned request
with sglist already in it, it should fail the same way, since we
will append another TRB to something that already uses more than
one TRB.

To aviod this, this patch changes the code to check for IOC/LST
bits in TRB->ctrl instead.

At a practical level, this patch resolves USB transfer stalls seen
with adb on dwc3 based HiKey960 after functionfs gadget added
scatter-gather support around v4.20.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Yang Fei <fei.yang@intel.com>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux USB List <linux-usb@vger.kernel.org>
Cc: stable <stable@vger.kernel.org>
Tested-by: Tejas Joglekar <tejas.joglekar@synopsys.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
[jstultz: forward ported to mainline, reworded commit log, reworked
 to only check trb->ctrl as suggested by Felipe]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2426,7 +2426,8 @@ static int dwc3_gadget_ep_reclaim_comple
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if ((trb->ctrl & DWC3_TRB_CTRL_IOC) ||
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
 	return 0;


