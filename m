Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE50EC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9050206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262610;
	bh=efmr60Q+tTsBSdsqbbZSjKIsNeDJ0Uo8QYxLKTI0cSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v5cbQkOpEhjE0/e3lJpcByNStvsLouotycmk85fRoUyvDpRPVo5xJ35pTVI3ihxd0
	 6rBRinR5bBJzc40fs6Q02bh6ZVF/teSM6QjGia+ckMpIgKsb7oEitOonmu/9o/AWc8
	 OOw4bJYsoDWMwZzzsCEUV9w8q1xm5sy+5pqEy7rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgGTP7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732102AbgGTP7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 865ED22BEF;
        Mon, 20 Jul 2020 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260740;
        bh=efmr60Q+tTsBSdsqbbZSjKIsNeDJ0Uo8QYxLKTI0cSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDf7ejz3dYa6+WDwDa3Keg2fWW3xXNCi4fKDdqnEgJKH8jFVcTxflw2TvYoy7Gart
         doUkhx1SkaGLb1BDYISD9MecjTrp/cvyEDM1ysivPzK5o4p3TiJWshICC7set0V9+C
         kV8/HpoJHBEGSDJRTNlavIIcDqcrSbi8TByzN2dU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 079/215] bus: ti-sysc: Detect EDMA and set quirk flags for tptc
Date:   Mon, 20 Jul 2020 17:36:01 +0200
Message-Id: <20200720152823.969262451@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 25bfaaa73c7d26a6e897559c510d7daff5e9d22d ]

In order to probe EDMA with ti-sysc interconnect target module and with
device tree data, we need to properly detect EDMA and set the flags for
SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY for tptc.

We have these flags currently set for am4 and dra7, but not for am335x.
Let's set them for all the SoCs as the tptc module should behave the
same for all of them. It's likely that am335x was never tested to idle
EDMA tptc.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 1d31304fdd7c5..d0b75e7d5e50f 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1311,6 +1311,10 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_MODULE_QUIRK_SGX),
 	SYSC_QUIRK("rtc", 0, 0x74, 0x78, -ENODEV, 0x4eb01908, 0xffff00f0,
 		   SYSC_MODULE_QUIRK_RTC_UNLOCK),
+	SYSC_QUIRK("tptc", 0, 0, 0x10, -ENODEV, 0x40006c00, 0xffffefff,
+		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
+	SYSC_QUIRK("tptc", 0, 0, -ENODEV, -ENODEV, 0x40007c00, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
 	SYSC_QUIRK("usb_otg_hs", 0, 0x400, 0x404, 0x408, 0x00000050,
 		   0xffffffff, SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_SWSUP_MSTANDBY),
 	SYSC_QUIRK("usb_otg_hs", 0, 0, 0x10, -ENODEV, 0x4ea2080d, 0xffffffff,
@@ -1377,6 +1381,7 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("spinlock", 0, 0, 0x10, -ENODEV, 0x50020000, 0xffffffff, 0),
 	SYSC_QUIRK("rng", 0, 0x1fe0, 0x1fe4, -ENODEV, 0x00000020, 0xffffffff, 0),
 	SYSC_QUIRK("timer32k", 0, 0, 0x4, -ENODEV, 0x00000060, 0xffffffff, 0),
+	SYSC_QUIRK("tpcc", 0, 0, -ENODEV, -ENODEV, 0x40014c00, 0xffffffff, 0),
 	SYSC_QUIRK("usbhstll", 0, 0, 0x10, 0x14, 0x00000004, 0xffffffff, 0),
 	SYSC_QUIRK("usbhstll", 0, 0, 0x10, 0x14, 0x00000008, 0xffffffff, 0),
 	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, 0x14, 0x50700100, 0xffffffff, 0),
-- 
2.25.1



