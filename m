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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E53C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1E520885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osjClc5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgHTXVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbgHTXVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:21:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A42DC061385;
        Thu, 20 Aug 2020 16:21:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r4so34054pls.2;
        Thu, 20 Aug 2020 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BI+WbPuZGThU4BWLVNvoFFhzj5+C2fzEktzsEUkpSP0=;
        b=osjClc5o5IaU1MYQkGVNbuvf4kaNqPuMS/Z8yFAXjWrggp3zIrD2sKWJxXnGUGEcSi
         b2s9ctYbsjQuSy/q0qCboYOLz/n+6RYUN3gQR0KV0MlIN994QMcf70Au23ufjUQo2QdW
         CJ6mL8KL8spVxhMzDye0sZh1qMHvI4lm/h3kiSFvE/jEF2W2zCUuJ8idTgXNL+n8uZ86
         snZdL1h9yLaGvv4yQs8SR4529rXuKn4GxIlxgw1k7Zcf4xemze7VsXEuatBvO5gyWgPS
         8Yh7KVxMQawB3z5MyY4OZTrayGcXeVib0sNi1tzfQi1MjzsB7gXqnVrBQOQVOeOawF10
         ahAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BI+WbPuZGThU4BWLVNvoFFhzj5+C2fzEktzsEUkpSP0=;
        b=ZqbdjK9S/5vR6XirPhgQe/NZ7k35DLzzZ7pvjx1nrRUkEu7vjTiJVSHTOCEhLjmD3+
         7s7Ab+bInzy2r3GvOjJu2IikUvwEIFtGOT10gCFB4ejTIuDUZ1TWj45o3Cw7x1zb52kD
         5IKOcn/r2TS40BJcdHGEGWqBatFXlXqiX9jN4rmBfj1UCznpofBfZ+Z7cCDpBMOHQsj0
         hLzv/FacZcL4HE3xvJIt1pBKgpcTS0EoEj83MSsh0x25htP5WUfwqnrXMExfPnE4zUiY
         Pov94tSnqohbtDeKxUFLvb+6m54XEcZong77NWvH+jHLX+pZbtaWfn+/zzht4gQ3UW77
         2rpg==
X-Gm-Message-State: AOAM530S+jOQdtC2lT6QyioF1//YRvrFDHcCuHSYvUPN//gIfiWycdqH
        rEzphj1OTVEtLzaKIW0hlqbjVZ6V8ZgixQ==
X-Google-Smtp-Source: ABdhPJycyK3QD80zsGSZpyzwocM+tzQAXFr6THIQerLezQJp9/Y+sG2gwu3kBa2nHwctYE+o65E+rw==
X-Received: by 2002:a17:902:a50d:: with SMTP id s13mr97652plq.135.1597965659798;
        Thu, 20 Aug 2020 16:20:59 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r202sm151837pfc.127.2020.08.20.16.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 16:20:59 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     davem@davemloft.net
Cc:     hch@lst.de, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFT][PATCH 5/7] sparc: Avoid overflow at boundary_size
Date:   Thu, 20 Aug 2020 16:20:44 -0700
Message-Id: <20200820232044.23887-1-nicoleotsuka@gmail.com>
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
 arch/sparc/kernel/iommu-common.c | 9 +++------
 arch/sparc/kernel/iommu.c        | 4 ++--
 arch/sparc/kernel/pci_sun4v.c    | 4 ++--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/iommu-common.c b/arch/sparc/kernel/iommu-common.c
index 59cb16691322..843e71894d04 100644
--- a/arch/sparc/kernel/iommu-common.c
+++ b/arch/sparc/kernel/iommu-common.c
@@ -166,13 +166,10 @@ unsigned long iommu_tbl_range_alloc(struct device *dev,
 		}
 	}
 
-	if (dev)
-		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				      1 << iommu->table_shift);
-	else
-		boundary_size = ALIGN(1ULL << 32, 1 << iommu->table_shift);
+	boundary_size = dev ? dma_get_seg_boundary(dev) : U32_MAX;
 
-	boundary_size = boundary_size >> iommu->table_shift;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	boundary_size = (boundary_size >> iommu->table_shift) + 1;
 	/*
 	 * if the skip_span_boundary_check had been set during init, we set
 	 * things up so that iommu_is_span_boundary() merely checks if the
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 4ae7388b1bff..d981c37305ae 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -472,8 +472,8 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 	outs->dma_length = 0;
 
 	max_seg_size = dma_get_max_seg_size(dev);
-	seg_boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	seg_boundary_size = (dma_get_seg_boundary(dev) >> IO_PAGE_SHIFT) + 1;
 	base_shift = iommu->tbl.table_map_base >> IO_PAGE_SHIFT;
 	for_each_sg(sglist, s, nelems, i) {
 		unsigned long paddr, npages, entry, out_entry = 0, slen;
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 14b93c5564e3..233fe8a20cec 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -508,8 +508,8 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	iommu_batch_start(dev, prot, ~0UL);
 
 	max_seg_size = dma_get_max_seg_size(dev);
-	seg_boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	seg_boundary_size = (dma_get_seg_boundary(dev) >> IO_PAGE_SHIFT) + 1;
 
 	mask = *dev->dma_mask;
 	if (!iommu_use_atu(iommu, mask))
-- 
2.17.1

