Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF7FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4902C20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942887;
	bh=/4RtdcU31kYJ941Dw97QJiAIdVCujAV7FIqCmS3ayak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iI2TDmilYZf/dafry5z4ICtiLpMNKYf1eiqS2eojsCaUBWlhvigzhEwFAL2zGKgpo
	 i6/aK20q92N9Dw7N50NP5IcWtuU2+Viund9I2EDxItaAyEp8218kSLFSDN4K1HUgOw
	 kacDSNVlhr7mo/74qwPMVbzWypUmfKnxnm8W8MKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgEHNBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbgEHMv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:51:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF82C24959;
        Fri,  8 May 2020 12:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942315;
        bh=/4RtdcU31kYJ941Dw97QJiAIdVCujAV7FIqCmS3ayak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsCyGKj6j/2ouRj+PapBkHwB5vD4nXIRllfpLZo+rn4BWJvAIX6INGqUPUTPDxNjo
         Lt9zY/Mj3GWflEwydppr+htMbcQIaHEcRtYJIRiv0ogJVharRI1iwDBvqsFWllPLZ4
         zoyDGqOhp1P/gOHEje3PPTKjd4Ze2IYs+q7FWMXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 06/32] usb: dwc3: gadget: Properly set maxpacket limit
Date:   Fri,  8 May 2020 14:35:19 +0200
Message-Id: <20200508123035.621451847@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123034.886699170@linuxfoundation.org>
References: <20200508123034.886699170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit d94ea5319813658ad5861d161ae16a194c2abf88 ]

Currently the calculation of max packet size limit for IN endpoints is
too restrictive. This prevents a matching of a capable hardware endpoint
during configuration. Below is the minimum recommended HW configuration
to support a particular endpoint setup from the databook:

For OUT endpoints, the databook recommended the minimum RxFIFO size to
be at least 3x MaxPacketSize + 3x setup packets size (8 bytes each) +
clock crossing margin (16 bytes).

For IN endpoints, the databook recommended the minimum TxFIFO size to be
at least 3x MaxPacketSize for endpoints that support burst. If the
endpoint doesn't support burst or when the device is operating in USB
2.0 mode, a minimum TxFIFO size of 2x MaxPacketSize is recommended.

Base on these recommendations, we can calculate the MaxPacketSize limit
of each endpoint. This patch revises the IN endpoint MaxPacketSize limit
and also sets the MaxPacketSize limit for OUT endpoints.

Reference: Databook 3.30a section 3.2.2 and 3.2.3

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.h   |  4 +++
 drivers/usb/dwc3/gadget.c | 52 ++++++++++++++++++++++++++++++---------
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e34308d64619e..d6968b90ee6bb 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -300,6 +300,10 @@
 #define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
 #define DWC3_GTXFIFOSIZ_TXFSTADDR(n)	((n) & 0xffff0000)
 
+/* Global RX Fifo Size Register */
+#define DWC31_GRXFIFOSIZ_RXFDEP(n)	((n) & 0x7fff)	/* DWC_usb31 only */
+#define DWC3_GRXFIFOSIZ_RXFDEP(n)	((n) & 0xffff)
+
 /* Global Event Size Registers */
 #define DWC3_GEVNTSIZ_INTMASK		BIT(31)
 #define DWC3_GEVNTSIZ_SIZE(n)		((n) & 0xffff)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1a6c973da4879..99f6a5aa01095 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2032,7 +2032,6 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
 	int mdwidth;
-	int kbytes;
 	int size;
 
 	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
@@ -2048,17 +2047,17 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 	/* FIFO Depth is in MDWDITH bytes. Multiply */
 	size *= mdwidth;
 
-	kbytes = size / 1024;
-	if (kbytes == 0)
-		kbytes = 1;
-
 	/*
-	 * FIFO sizes account an extra MDWIDTH * (kbytes + 1) bytes for
-	 * internal overhead. We don't really know how these are used,
-	 * but documentation say it exists.
+	 * To meet performance requirement, a minimum TxFIFO size of 3x
+	 * MaxPacketSize is recommended for endpoints that support burst and a
+	 * minimum TxFIFO size of 2x MaxPacketSize for endpoints that don't
+	 * support burst. Use those numbers and we can calculate the max packet
+	 * limit as below.
 	 */
-	size -= mdwidth * (kbytes + 1);
-	size /= kbytes;
+	if (dwc->maximum_speed >= USB_SPEED_SUPER)
+		size /= 3;
+	else
+		size /= 2;
 
 	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
 
@@ -2076,8 +2075,39 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
+	int mdwidth;
+	int size;
+
+	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
+
+	/* MDWIDTH is represented in bits, convert to bytes */
+	mdwidth /= 8;
 
-	usb_ep_set_maxpacket_limit(&dep->endpoint, 1024);
+	/* All OUT endpoints share a single RxFIFO space */
+	size = dwc3_readl(dwc->regs, DWC3_GRXFIFOSIZ(0));
+	if (dwc3_is_usb31(dwc))
+		size = DWC31_GRXFIFOSIZ_RXFDEP(size);
+	else
+		size = DWC3_GRXFIFOSIZ_RXFDEP(size);
+
+	/* FIFO depth is in MDWDITH bytes */
+	size *= mdwidth;
+
+	/*
+	 * To meet performance requirement, a minimum recommended RxFIFO size
+	 * is defined as follow:
+	 * RxFIFO size >= (3 x MaxPacketSize) +
+	 * (3 x 8 bytes setup packets size) + (16 bytes clock crossing margin)
+	 *
+	 * Then calculate the max packet limit as below.
+	 */
+	size -= (3 * 8) + 16;
+	if (size < 0)
+		size = 0;
+	else
+		size /= 3;
+
+	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
 	dep->endpoint.max_streams = 15;
 	dep->endpoint.ops = &dwc3_gadget_ep_ops;
 	list_add_tail(&dep->endpoint.ep_list,
-- 
2.20.1



