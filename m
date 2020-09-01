Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33F1C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5392078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1jAEWWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgIAWRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgIAWRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:17:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E004C061245;
        Tue,  1 Sep 2020 15:17:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so1459456pgl.3;
        Tue, 01 Sep 2020 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lJJ7V03Abw0UVLOnJIZ7fdpPykj9kG/OFLFAvUpMf7Q=;
        b=d1jAEWWOy8icND/vVRiaFSXB4NAsmPg4/p84CGOXK5ZkquCur08xxEn9w3Qg5HW4Ih
         Q0gSWJJOMlIBYMQfx+k3vV2iE2eqctfeFhszNit+BFUqWHCOGRZvKf+w7oWBOQ7qZjGJ
         R3carjvVRL1VoqsobU7Ai4fZe2WkgqC+P43wyk1NRoiNzdsSh5N+pGt8fXsZVs8y65z3
         oZPq6lbJbBe32p/VRMi11dh2YeShysKzo0sN/L1NzkTjK6fZcthpif7m5oE97odMeUUQ
         UMDAuHZLZxQ6lwIJv2Az6oePWTshK4pAuKc9lohg6OX1A1cWekU/i+5kExQnmn/u1jG8
         3+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lJJ7V03Abw0UVLOnJIZ7fdpPykj9kG/OFLFAvUpMf7Q=;
        b=ELlySgVX8ew8UheYHIrxkH/JCDtnHXH3N5VgKFvk9YlrWup1SCjq8tEVAnwQ2Xdtaz
         Mzm2JdJ0lCNIf9gMaL5Zw0tbOLjKHMo5aU7NMqEd2onhDVCY0uuTK8IM/3LrFtfDHtjj
         yzSbtTzH7KVaQ/c+cPslubOXHSqrpmuwrxPG7LaZg0GQzrA0yEGqA8IKaUvEC0Mwdu3f
         TisIXmXAOQiYmQ6u+d7/EMCSEmgW3qZdqLMEpEmZ1LI70ekdrPnh8coaGNzz7xXlCpKh
         UikGYMaUqRLnCv7d+qi0NFnEViU5uzF49zRk+V4PBbP50/urMBTkhYoHSiGIaMVu312N
         xOdw==
X-Gm-Message-State: AOAM531DHcvD5ORgqiJBoQ4UNvHuMJQjzSEagzvjAASb2Y5Gc9Hp+SVx
        RPXukETIgLqZVoBAYq+nI1M=
X-Google-Smtp-Source: ABdhPJzfNSxWnLtzXlyH14JQieBaCH5fI+LitYgbfDa0OIwWsXALFv3Wh2kOb00SOdtQ04Jd1bz+aA==
X-Received: by 2002:a63:784e:: with SMTP id t75mr3167596pgc.389.1598998642725;
        Tue, 01 Sep 2020 15:17:22 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w203sm3201356pfc.97.2020.09.01.15.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 15:17:22 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de
Cc:     sfr@canb.auug.org.au, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, linux-ia64@vger.kernel.org,
        schnelle@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org
Subject: [PATCH 1/2] dma-mapping: introduce dma_get_seg_boundary_nr_pages()
Date:   Tue,  1 Sep 2020 15:16:45 -0700
Message-Id: <20200901221646.26491-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901221646.26491-1-nicoleotsuka@gmail.com>
References: <20200901221646.26491-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found that callers of dma_get_seg_boundary mostly do an ALIGN
with page mask and then do a page shift to get number of pages:
    ALIGN(boundary + 1, 1 << shift) >> shift

However, the boundary might be as large as ULONG_MAX, which means
that a device has no specific boundary limit. So either "+ 1" or
passing it to ALIGN() would potentially overflow.

According to kernel defines:
    #define ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
    #define ALIGN(x, a)	ALIGN_MASK(x, (typeof(x))(a) - 1)

We can simplify the logic here into a helper function doing:
  ALIGN(boundary + 1, 1 << shift) >> shift
= ALIGN_MASK(b + 1, (1 << s) - 1) >> s
= {[b + 1 + (1 << s) - 1] & ~[(1 << s) - 1]} >> s
= [b + 1 + (1 << s) - 1] >> s
= [b + (1 << s)] >> s
= (b >> s) + 1

This patch introduces and applies dma_get_seg_boundary_nr_pages()
as an overflow-free helper for the dma_get_seg_boundary() callers
to get numbers of pages. It also takes care of the NULL dev case
for non-DMA API callers.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 arch/alpha/kernel/pci_iommu.c    |  7 +------
 arch/ia64/hp/common/sba_iommu.c  |  3 +--
 arch/powerpc/kernel/iommu.c      |  9 ++-------
 arch/s390/pci/pci_dma.c          |  6 ++----
 arch/sparc/kernel/iommu-common.c | 10 +++-------
 arch/sparc/kernel/iommu.c        |  3 +--
 arch/sparc/kernel/pci_sun4v.c    |  3 +--
 arch/x86/kernel/amd_gart_64.c    |  3 +--
 drivers/parisc/ccio-dma.c        |  3 +--
 drivers/parisc/sba_iommu.c       |  3 +--
 include/linux/dma-mapping.h      | 19 +++++++++++++++++++
 11 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 81037907268d..6f7de4f4e191 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -141,12 +141,7 @@ iommu_arena_find_pages(struct device *dev, struct pci_iommu_arena *arena,
 	unsigned long boundary_size;
 
 	base = arena->dma_base >> PAGE_SHIFT;
-	if (dev) {
-		boundary_size = dma_get_seg_boundary(dev) + 1;
-		boundary_size >>= PAGE_SHIFT;
-	} else {
-		boundary_size = 1UL << (32 - PAGE_SHIFT);
-	}
+	boundary_size = dma_get_seg_boundary_nr_pages(dev, PAGE_SHIFT);
 
 	/* Search forward for the first mask-aligned sequence of N free ptes */
 	ptes = arena->ptes;
diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 656a4888c300..b49b73a95067 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -485,8 +485,7 @@ sba_search_bitmap(struct ioc *ioc, struct device *dev,
 	ASSERT(((unsigned long) ioc->res_hint & (sizeof(unsigned long) - 1UL)) == 0);
 	ASSERT(res_ptr < res_end);
 
-	boundary_size = (unsigned long long)dma_get_seg_boundary(dev) + 1;
-	boundary_size = ALIGN(boundary_size, 1ULL << iovp_shift) >> iovp_shift;
+	boundary_size = dma_get_seg_boundary_nr_pages(dev, iovp_shift);
 
 	BUG_ON(ioc->ibase & ~iovp_mask);
 	shift = ioc->ibase >> iovp_shift;
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 9704f3f76e63..cbc2e62db597 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -236,15 +236,10 @@ static unsigned long iommu_range_alloc(struct device *dev,
 		}
 	}
 
-	if (dev)
-		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				      1 << tbl->it_page_shift);
-	else
-		boundary_size = ALIGN(1UL << 32, 1 << tbl->it_page_shift);
-	/* 4GB boundary for iseries_hv_alloc and iseries_hv_map */
+	boundary_size = dma_get_seg_boundary_nr_pages(dev, tbl->it_page_shift);
 
 	n = iommu_area_alloc(tbl->it_map, limit, start, npages, tbl->it_offset,
-			     boundary_size >> tbl->it_page_shift, align_mask);
+			     boundary_size, align_mask);
 	if (n == -1) {
 		if (likely(pass == 0)) {
 			/* First try the pool from the start */
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 64b1399a73f0..4a37d8f4de9d 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -261,13 +261,11 @@ static unsigned long __dma_alloc_iommu(struct device *dev,
 				       unsigned long start, int size)
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
-	unsigned long boundary_size;
 
-	boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-			      PAGE_SIZE) >> PAGE_SHIFT;
 	return iommu_area_alloc(zdev->iommu_bitmap, zdev->iommu_pages,
 				start, size, zdev->start_dma >> PAGE_SHIFT,
-				boundary_size, 0);
+				dma_get_seg_boundary_nr_pages(dev, PAGE_SHIFT),
+				0);
 }
 
 static dma_addr_t dma_alloc_address(struct device *dev, int size)
diff --git a/arch/sparc/kernel/iommu-common.c b/arch/sparc/kernel/iommu-common.c
index 59cb16691322..23ca75f09277 100644
--- a/arch/sparc/kernel/iommu-common.c
+++ b/arch/sparc/kernel/iommu-common.c
@@ -166,13 +166,6 @@ unsigned long iommu_tbl_range_alloc(struct device *dev,
 		}
 	}
 
-	if (dev)
-		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				      1 << iommu->table_shift);
-	else
-		boundary_size = ALIGN(1ULL << 32, 1 << iommu->table_shift);
-
-	boundary_size = boundary_size >> iommu->table_shift;
 	/*
 	 * if the skip_span_boundary_check had been set during init, we set
 	 * things up so that iommu_is_span_boundary() merely checks if the
@@ -181,6 +174,9 @@ unsigned long iommu_tbl_range_alloc(struct device *dev,
 	if ((iommu->flags & IOMMU_NO_SPAN_BOUND) != 0) {
 		shift = 0;
 		boundary_size = iommu->poolsize * iommu->nr_pools;
+	} else {
+		boundary_size = dma_get_seg_boundary_nr_pages(dev,
+					iommu->table_shift);
 	}
 	n = iommu_area_alloc(iommu->map, limit, start, npages, shift,
 			     boundary_size, align_mask);
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 4ae7388b1bff..c3e4e2df26a8 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -472,8 +472,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 	outs->dma_length = 0;
 
 	max_seg_size = dma_get_max_seg_size(dev);
-	seg_boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
+	seg_boundary_size = dma_get_seg_boundary_nr_pages(dev, IO_PAGE_SHIFT);
 	base_shift = iommu->tbl.table_map_base >> IO_PAGE_SHIFT;
 	for_each_sg(sglist, s, nelems, i) {
 		unsigned long paddr, npages, entry, out_entry = 0, slen;
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 14b93c5564e3..6b92dd51c002 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -508,8 +508,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	iommu_batch_start(dev, prot, ~0UL);
 
 	max_seg_size = dma_get_max_seg_size(dev);
-	seg_boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
+	seg_boundary_size = dma_get_seg_boundary_nr_pages(dev, IO_PAGE_SHIFT);
 
 	mask = *dev->dma_mask;
 	if (!iommu_use_atu(iommu, mask))
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index e89031e9c847..bccc5357bffd 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -96,8 +96,7 @@ static unsigned long alloc_iommu(struct device *dev, int size,
 
 	base_index = ALIGN(iommu_bus_base & dma_get_seg_boundary(dev),
 			   PAGE_SIZE) >> PAGE_SHIFT;
-	boundary_size = ALIGN((u64)dma_get_seg_boundary(dev) + 1,
-			      PAGE_SIZE) >> PAGE_SHIFT;
+	boundary_size = dma_get_seg_boundary_nr_pages(dev, PAGE_SHIFT);
 
 	spin_lock_irqsave(&iommu_bitmap_lock, flags);
 	offset = iommu_area_alloc(iommu_gart_bitmap, iommu_pages, next_bit,
diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index a5507f75b524..ba16b7f8f806 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -356,8 +356,7 @@ ccio_alloc_range(struct ioc *ioc, struct device *dev, size_t size)
 	** ggg sacrifices another 710 to the computer gods.
 	*/
 
-	boundary_size = ALIGN((unsigned long long)dma_get_seg_boundary(dev) + 1,
-			      1ULL << IOVP_SHIFT) >> IOVP_SHIFT;
+	boundary_size = dma_get_seg_boundary_nr_pages(dev, IOVP_SHIFT);
 
 	if (pages_needed <= 8) {
 		/*
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index d4314fba0269..959bda193b96 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -342,8 +342,7 @@ sba_search_bitmap(struct ioc *ioc, struct device *dev,
 	unsigned long shift;
 	int ret;
 
-	boundary_size = ALIGN((unsigned long long)dma_get_seg_boundary(dev) + 1,
-			      1ULL << IOVP_SHIFT) >> IOVP_SHIFT;
+	boundary_size = dma_get_seg_boundary_nr_pages(dev, IOVP_SHIFT);
 
 #if defined(ZX1_SUPPORT)
 	BUG_ON(ioc->ibase & ~IOVP_MASK);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 52635e91143b..faab0a8210b9 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -632,6 +632,25 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
 	return DMA_BIT_MASK(32);
 }
 
+/**
+ * dma_get_seg_boundary_nr_pages - return the segment boundary in "page" units
+ * @dev: device to guery the boundary for
+ * @page_shift: ilog() of the IOMMU page size
+ *
+ * Return the segment boundary in IOMMU page units (which may be different from
+ * the CPU page size) for the passed in device.
+ *
+ * If @dev is NULL a boundary of U32_MAX is assumed, this case is just for
+ * non-DMA API callers.
+ */
+static inline unsigned long dma_get_seg_boundary_nr_pages(struct device *dev,
+		unsigned int page_shift)
+{
+	if (!dev)
+		return (U32_MAX >> page_shift) + 1;
+	return (dma_get_seg_boundary(dev) >> page_shift) + 1;
+}
+
 static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 {
 	if (dev->dma_parms) {
-- 
2.17.1

