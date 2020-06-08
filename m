Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04626C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA61420737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663225;
	bh=maT3ueO5p+Brv6Xev3QLw3Jto3DPNTLgNdW0r7M+weo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=md4ecFTnC70IvYDqZrdkxDL3tiI9wlwbegrYRnl/YQJmOEif0VtwZSgC1fuzUuNHo
	 73US0a+a0nOZLEzVNfv0lrjcIimNM4mAh9QEzbQBNdxqfsexyspOXXVgVY8w6vWzqK
	 H9CUBGNZ/bNnJKduXHdWb0nodWBTBinKo82UEaKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgFIAkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:32790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729236AbgFHXNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E74E20C09;
        Mon,  8 Jun 2020 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657987;
        bh=maT3ueO5p+Brv6Xev3QLw3Jto3DPNTLgNdW0r7M+weo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/FJce8okcMXjwp0mdrs2k+5nMyaHd+u2clOE6uANpRq6kBRnteWFGpQB1+r2TIYN
         0i75d9GEyZDjmyqIVzweoH8e2HPAKLXQhYpSiNu1MBUXomgKr/V6RY6nr4RgalYOsY
         +SvmiiLDmdXlqumUu6H1JZFV1gBRMqQv9HcHriVo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jack Pham <jackp@codeaurora.org>, Josh Gao <jmgao@google.com>,
        Todd Kjos <tkjos@google.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 046/606] dwc3: Remove check for HWO flag in dwc3_gadget_ep_reclaim_trb_sg()
Date:   Mon,  8 Jun 2020 19:02:51 -0400
Message-Id: <20200608231211.3363633-46-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <john.stultz@linaro.org>

commit 00e21763f2c8cab21b7befa52996d1b18bde5c42 upstream.

The check for the HWO flag in dwc3_gadget_ep_reclaim_trb_sg()
causes us to break out of the loop before we call
dwc3_gadget_ep_reclaim_completed_trb(), which is what likely
should be clearing the HWO flag.

This can cause odd behavior where we never reclaim all the trbs
in the sg list, so we never call giveback on a usb req, and that
will causes transfer stalls.

This effectively resovles the adb stalls seen on HiKey960
after userland changes started only using AIO in adbd.

Cc: YongQin Liu <yongqin.liu@linaro.org>
Cc: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: Yang Fei <fei.yang@intel.com>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: Josh Gao <jmgao@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org #4.20+
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/gadget.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index bc1cf6d0412a..7e9643d25b14 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2483,9 +2483,6 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 	for_each_sg(sg, s, pending, i) {
 		trb = &dep->trb_pool[dep->trb_dequeue];
 
-		if (trb->ctrl & DWC3_TRB_CTRL_HWO)
-			break;
-
 		req->sg = sg_next(s);
 		req->num_pending_sgs--;
 
-- 
2.25.1

