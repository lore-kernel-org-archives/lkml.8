Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB1BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495A720720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgF2U7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731239AbgF2TNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:01 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB69C00E3F2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:11:50 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:ddd:9277:6399:6268])
        by albert.telenet-ops.be with bizsmtp
        id x0Bn220091qNRsK060BnaB; Mon, 29 Jun 2020 14:11:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jpsdX-0001l7-Hw; Mon, 29 Jun 2020 14:11:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jpsdX-0006G0-Ex; Mon, 29 Jun 2020 14:11:47 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Joerg Roedel <joro@8bytes.org>, Maxime Ripard <maxime@cerno.tech>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] iommu: SUN50I_IOMMU should depend on HAS_DMA
Date:   Mon, 29 Jun 2020 14:11:46 +0200
Message-Id: <20200629121146.24011-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If NO_DMA=y (e.g. Sun-3 all{mod,yes}-config):

    drivers/iommu/dma-iommu.o: In function `iommu_dma_mmap':
    dma-iommu.c:(.text+0x92e): undefined reference to `dma_pgprot'

IOMMU_DMA must not be selected, unless HAS_DMA=y.

Hence fix this by making SUN50I_IOMMU depend on HAS_DMA.

Fixes: 4100b8c229b32835 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6dc49ed8377a5c12..b0f308cb7f7c2fc2 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -305,6 +305,7 @@ config ROCKCHIP_IOMMU
 
 config SUN50I_IOMMU
 	bool "Allwinner H6 IOMMU Support"
+	depends on HAS_DMA
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select ARM_DMA_USE_IOMMU
 	select IOMMU_API
-- 
2.17.1

