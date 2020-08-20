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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646D1207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpsfXubP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgHTXUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgHTXUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:20:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603D2C061385;
        Thu, 20 Aug 2020 16:20:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nv17so121174pjb.3;
        Thu, 20 Aug 2020 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZXOK8pT3fKKSH66fLd/ANhE16k3B7ecJU+M0aFuQDuk=;
        b=qpsfXubPDJihER5wJZOPYs+cWT7z853AUN308jcd1qrMwVVN1ppn2JPnhxap5VBAwC
         lO23Wq+2ue+gXY2jpb42ihcMtxSb79Z4g0/jPfAcW5+oIzBs4mkidh2bX1kLpvL9Tdw2
         57ENo9u32rzCcyFF8Bz10C0Ke6Kw9PA7yrelf2wZHQxnELip7hm4lj/MCQbEXMSB9PAd
         R4+WlqiKm2qcIUtYXKB/UCQZya0eFTj0sZZ/3tehPG5pxAO+2EANmXnfbN58TVYfn8dJ
         fG3rGYZleODzDFe0O0ZtGqwtA4miP9PfpYSbbx6UNOCMnmy1YL0YkscGsEmVPD1XYR2Q
         ImtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZXOK8pT3fKKSH66fLd/ANhE16k3B7ecJU+M0aFuQDuk=;
        b=kMouD9cx99VntCdGz0sUNLKCw+FBFTc1Iej3mS7r66YyiXx5LV6Z+ItI4OmTVJbO1w
         /Jcx9VE4kb6rWuVv2hq2R5PgwgsuFnc38wMCOBLccYX3+o/ryoEiYLf8wWI8CstIoMDN
         JJl8sSld4J9PcIfZVD9UriCdqaP/hVri0wYKf7XRlG81nzvuUM2bjZRWwC92pxfPWokc
         tT6goJM4wR2toXvh4XE6gXzS1t/qNQOtcP5NIPbk2PzV5o9XMTgGRozqtK4hQrGbm+P6
         D6Lr1UMX91XB1yz8YFeLwDv8nnyzbCNsFcap1meR1sZdItigqV+1J12LbrFrjOn47yxF
         joLQ==
X-Gm-Message-State: AOAM530WeBHqaAPDLHVGww7RNd1Uzp/NLgcoAnaAis+UNwJIVgtroTP1
        oX2X1JK42wTJcAIWVx2kFNI=
X-Google-Smtp-Source: ABdhPJySEjy+TCN/G/DmqyuGJsN97PCqj1oguaNY4ha7qdDxbRmDjiJq/dkuaxstlk2v03hyXAB5tw==
X-Received: by 2002:a17:902:7b82:: with SMTP id w2mr118630pll.258.1597965619864;
        Thu, 20 Aug 2020 16:20:19 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x6sm107467pge.61.2020.08.20.16.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 16:20:19 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc:     hch@lst.de, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFT][PATCH 2/7] alpha: Avoid overflow at boundary_size
Date:   Thu, 20 Aug 2020 16:20:04 -0700
Message-Id: <20200820232004.23761-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boundary_size might be as large as ULONG_MAX, which means
that a device has no specific boundary limit. So "+ 1" would
potentially overflow.

Also, by following other places in the kernel, boundary_size
should align with the PAGE_SIZE before right shifting by the
PAGE_SHIFT. However, passing it to ALIGN() would potentially
overflow too.

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
 arch/alpha/kernel/pci_iommu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 81037907268d..1ef2c647bd3e 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -141,12 +141,10 @@ iommu_arena_find_pages(struct device *dev, struct pci_iommu_arena *arena,
 	unsigned long boundary_size;
 
 	base = arena->dma_base >> PAGE_SHIFT;
-	if (dev) {
-		boundary_size = dma_get_seg_boundary(dev) + 1;
-		boundary_size >>= PAGE_SHIFT;
-	} else {
-		boundary_size = 1UL << (32 - PAGE_SHIFT);
-	}
+
+	boundary_size = dev ? dma_get_seg_boundary(dev) : U32_MAX;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	boundary_size = (boundary_size >> PAGE_SHIFT) + 1;
 
 	/* Search forward for the first mask-aligned sequence of N free ptes */
 	ptes = arena->ptes;
-- 
2.17.1

