Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFADCC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986C720637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700492;
	bh=+vGHe3JDy9xNEfZk9K6/cvGaRyAsbbjFMd+oa+5LXM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WG6mJhFz/ZmR3x6W6GGzW/xzzyXRdMO2AtSQC1KvUBLN8YhVkZrs9wPa9enK1RIqD
	 mkSdAcOGdTawt+mUf/Fjg7B12Pxl4efQ+RPDaSltR2qqlUqHBXWhS2Lix3hpy++iyb
	 dFmTNMunJvosVNo0BpIyrpDvP3VO8ZuG2f7PGdFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbgBNROv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:14:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403776AbgBNQM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:12:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77D68246AA;
        Fri, 14 Feb 2020 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696747;
        bh=+vGHe3JDy9xNEfZk9K6/cvGaRyAsbbjFMd+oa+5LXM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkUeNVweV8CTt0mqWpIo5eN89xf0bJ9kByfrMtPRjPsf3X+cP4mbWelUur/3pnw2l
         acyCu4pBxZkR9X7bojEOO7iKy6KugTZynuwWH4YzMNbp0Z0s0Dz9zT4ivsqWtcknsJ
         PKSVt97pmepYIbthILv15hS+nez31EHtoP9aCqPk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Keeping <john@metanate.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 030/252] usb: dwc2: Fix IN FIFO allocation
Date:   Fri, 14 Feb 2020 11:08:05 -0500
Message-Id: <20200214161147.15842-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Keeping <john@metanate.com>

[ Upstream commit 644139f8b64d818f6345351455f14471510879a5 ]

On chips with fewer FIFOs than endpoints (for example RK3288 which has 9
endpoints, but only 6 which are cabable of input), the DPTXFSIZN
registers above the FIFO count may return invalid values.

With logging added on startup, I see:

	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=1 sz=256
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=2 sz=128
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=3 sz=128
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=4 sz=64
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=5 sz=64
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=6 sz=32
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=7 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=8 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=9 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=10 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=11 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=12 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=13 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=14 sz=0
	dwc2 ff580000.usb: dwc2_hsotg_init_fifo: ep=15 sz=0

but:

	# cat /sys/kernel/debug/ff580000.usb/fifo
	Non-periodic FIFOs:
	RXFIFO: Size 275
	NPTXFIFO: Size 16, Start 0x00000113

	Periodic TXFIFOs:
		DPTXFIFO 1: Size 256, Start 0x00000123
		DPTXFIFO 2: Size 128, Start 0x00000223
		DPTXFIFO 3: Size 128, Start 0x000002a3
		DPTXFIFO 4: Size 64, Start 0x00000323
		DPTXFIFO 5: Size 64, Start 0x00000363
		DPTXFIFO 6: Size 32, Start 0x000003a3
		DPTXFIFO 7: Size 0, Start 0x000003e3
		DPTXFIFO 8: Size 0, Start 0x000003a3
		DPTXFIFO 9: Size 256, Start 0x00000123

so it seems that FIFO 9 is mirroring FIFO 1.

Fix the allocation by using the FIFO count instead of the endpoint count
when selecting a FIFO for an endpoint.

Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index f64d1cd08fb67..17f3e7b4d4fed 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3918,11 +3918,12 @@ static int dwc2_hsotg_ep_enable(struct usb_ep *ep,
 	 * a unique tx-fifo even if it is non-periodic.
 	 */
 	if (dir_in && hsotg->dedicated_fifos) {
+		unsigned fifo_count = dwc2_hsotg_tx_fifo_count(hsotg);
 		u32 fifo_index = 0;
 		u32 fifo_size = UINT_MAX;
 
 		size = hs_ep->ep.maxpacket * hs_ep->mc;
-		for (i = 1; i < hsotg->num_of_eps; ++i) {
+		for (i = 1; i <= fifo_count; ++i) {
 			if (hsotg->fifo_map & (1 << i))
 				continue;
 			val = dwc2_readl(hsotg, DPTXFSIZN(i));
-- 
2.20.1

