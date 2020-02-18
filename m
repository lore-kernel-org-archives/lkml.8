Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B51CC34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DE721D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nnl03IJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgBRSmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:42:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgBRSmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jqbI93a3yxdc0ao0130GGCEXVWckV3ZL1Y/tigDybE0=; b=Nnl03IJEq5Qpcswxni7luOuStD
        tuO1aTfL02GJrMl0QJrVRVNdZw8xPwhBe1DBz2GsRg+jZkYBmIKR3OwEfPtBEIg4mF9lfq5yeZy64
        zOfxror/NH8pW7sdFQBVJsK/hadyRMiP9IyK7fZs/o6ZVjS4PRtHu1fD5ckH0bLfcQKraIU1wQR0p
        K4TIIwtyMD5j4k0WZ5fnCDtfLUSPdETDnILGv8om/KHAlypLtlBlwARtnA9xKRqs/L+XgoVS9UUkb
        215AnnAuevSpGvFQHXJM3nOMK1B5EGV6i4d/G+6YbNHFrBPFYyiVXfw0wY+qSPneOpZ5/LnCrk7/a
        e5ZwxNQA==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j47ou-000390-KX; Tue, 18 Feb 2020 18:42:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] ARM/dma-mapping: merge __dma_supported into arm_dma_supported
Date:   Tue, 18 Feb 2020 10:41:03 -0800
Message-Id: <20200218184103.35932-4-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218184103.35932-1-hch@lst.de>
References: <20200218184103.35932-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge __dma_supported into its only caller, and move the resulting
function so that it doesn't need a forward declaration.  Also mark
it static as there are no callers outside of dma-mapping.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-iommu.h |  2 --
 arch/arm/mm/dma-mapping.c        | 41 +++++++++++++-------------------
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 772f48ef84b7..86405cc81385 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -33,7 +33,5 @@ int arm_iommu_attach_device(struct device *dev,
 					struct dma_iommu_mapping *mapping);
 void arm_iommu_detach_device(struct device *dev);
 
-int arm_dma_supported(struct device *dev, u64 mask);
-
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 87aba505554a..8a8949174b1c 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -179,6 +179,23 @@ static void arm_dma_sync_single_for_device(struct device *dev,
 	__dma_page_cpu_to_dev(page, offset, size, dir);
 }
 
+/*
+ * Return whether the given device DMA address mask can be supported
+ * properly.  For example, if your device can only drive the low 24-bits
+ * during bus mastering, then you would pass 0x00ffffff as the mask
+ * to this function.
+ */
+static int arm_dma_supported(struct device *dev, u64 mask)
+{
+	unsigned long max_dma_pfn = min(max_pfn - 1, arm_dma_pfn_limit);
+
+	/*
+	 * Translate the device's DMA mask to a PFN limit.  This
+	 * PFN number includes the page which we can DMA to.
+	 */
+	return dma_to_pfn(dev, mask) >= max_dma_pfn;
+}
+
 const struct dma_map_ops arm_dma_ops = {
 	.alloc			= arm_dma_alloc,
 	.free			= arm_dma_free,
@@ -219,19 +236,6 @@ const struct dma_map_ops arm_coherent_dma_ops = {
 };
 EXPORT_SYMBOL(arm_coherent_dma_ops);
 
-static int __dma_supported(struct device *dev, u64 mask)
-{
-	unsigned long max_dma_pfn = min(max_pfn - 1, arm_dma_pfn_limit);
-
-	/*
-	 * Translate the device's DMA mask to a PFN limit.  This
-	 * PFN number includes the page which we can DMA to.
-	 */
-	if (dma_to_pfn(dev, mask) < max_dma_pfn)
-		return 0;
-	return 1;
-}
-
 static void __dma_clear_buffer(struct page *page, size_t size, int coherent_flag)
 {
 	/*
@@ -1054,17 +1058,6 @@ void arm_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 					    dir);
 }
 
-/*
- * Return whether the given device DMA address mask can be supported
- * properly.  For example, if your device can only drive the low 24-bits
- * during bus mastering, then you would pass 0x00ffffff as the mask
- * to this function.
- */
-int arm_dma_supported(struct device *dev, u64 mask)
-{
-	return __dma_supported(dev, mask);
-}
-
 static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 {
 	/*
-- 
2.24.1

