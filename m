Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8221DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE322087D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m24etRd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgHTXVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgHTXVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:21:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89681C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:21:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so28395plr.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9lkO17MTf1PvM2bYbtDswYPNjHPfse5Uqsd7G1Ozxzk=;
        b=m24etRd6WzExt6f8um++O5bWjL2daHKmMmNcjSP5uBNRsao7nI9cSn0qraidx+IxN1
         La0EJI24Idk+Cic6VbiSoRg/nXwR3LOPCwVaWXMHOOux9tvOwQ1GiDoqZj1N1PFQ4k3v
         1R8LZx83cPRGcaQrPThb0ct07lwBpSGoZkA/gT7YpoWne64MZAj4VD5+uaaEESuy7LA5
         if2BHOKzFBVZe8VrlSLEPO8+1VgB+N1nOyOp6AWfqYgaY9+hX/8UoEIGMFSzEIS4knY2
         SzPD/551umivwiXvcnUoqXXX0aJgJxV3mDTZSnV3oxy7igFgCNA8+exKSbHJNt85O3d+
         R/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9lkO17MTf1PvM2bYbtDswYPNjHPfse5Uqsd7G1Ozxzk=;
        b=WZ3lFb3BtSEa/7PBdgIeYMbq8cL9ppWsJU7TQbTBKN50YiXzNVETr8/3eT90WDX0vU
         jF2JzsHlkLTX2OmeT6W1pITwSuNwIvqPCR4xeDLaKUDZIowMKIcM9jzM5teicVDLIEMb
         PospN43Zuo+Ag80tdJmAb/uGOEQZRVyF38yy8JZwBxoDBntSrtG1j0eDULKhZij9lOYc
         F7eZc/OkFOySJtVdCX5rOAIzcHIZfteeRJSKBliQLqACb4lNdUM99SIt4Ct8vtetJcBB
         n1YwtB1MdSovbAgk/mcDWjFwoytaqFtVdexoaSDR4EzPlAXxLKASS/4LJKDwltFUV4J6
         vecw==
X-Gm-Message-State: AOAM532tQ7GX6dr6I/TSRtTPayFp1r8ahJx3u2MA41zFRYpT3NVQmm8B
        z52Y0l8TKPY+uwhexmTrKtY=
X-Google-Smtp-Source: ABdhPJzgqN56KmhgzPFP7RntFZ8QyoKQ1bgctyZhEADIYLdbA+6rN5Ib/rYIo28vPQxQLkDO9SOAsA==
X-Received: by 2002:a17:902:9009:: with SMTP id a9mr113982plp.252.1597965671040;
        Thu, 20 Aug 2020 16:21:11 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x20sm98204pgh.93.2020.08.20.16.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 16:21:10 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Cc:     hch@lst.de, linux-kernel@vger.kernel.org
Subject: [RFT][PATCH 6/7] x86/amd_gart: Avoid overflow at boundary_size
Date:   Thu, 20 Aug 2020 16:20:56 -0700
Message-Id: <20200820232056.23928-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boundary_size might be as large as ULONG_MAX, which means
that a device has no specific boundary limit. So either "+ 1"
or passing it to ALIGN() would potentially overflow.

According to kernel defines:
    #define ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
    #define ALIGN(x, a)	ALIGN_MASK(x, (typeof(x))(a) - 1)

We can simplify the logic here:
  ALIGN(boundary + 1, 1 << shift) >> shift
= ALIGN_MASK(b + 1, (1 << s) - 1) >> s
= {[b + 1 + (1 << s) - 1] & ~[(1 << s) - 1]} >> s
= [b + 1 + (1 << s) - 1] >> s
= [b + (1 << s)] >> s
= (b >> s) + 1

So fixing a potential overflow with the safer shortcut.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/amd_gart_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index e89031e9c847..7fa0bb490065 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -96,8 +96,8 @@ static unsigned long alloc_iommu(struct device *dev, int size,
 
 	base_index = ALIGN(iommu_bus_base & dma_get_seg_boundary(dev),
 			   PAGE_SIZE) >> PAGE_SHIFT;
-	boundary_size = ALIGN((u64)dma_get_seg_boundary(dev) + 1,
-			      PAGE_SIZE) >> PAGE_SHIFT;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	boundary_size = (dma_get_seg_boundary(dev) >> PAGE_SHIFT) + 1;
 
 	spin_lock_irqsave(&iommu_bitmap_lock, flags);
 	offset = iommu_area_alloc(iommu_gart_bitmap, iommu_pages, next_bit,
-- 
2.17.1

