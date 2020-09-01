Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90349C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8682071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNQ0tAP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgIAUhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAUhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:37:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91DFC061244;
        Tue,  1 Sep 2020 13:37:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so3179404ljk.8;
        Tue, 01 Sep 2020 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vO5riVGJIq/jxWJeztPKNQ8H6lN7SjOM4tRFMoi/sX0=;
        b=uNQ0tAP66OlqR1Ij2+/EidCAhIAvpJ7swbdTx5QaOQ+8eT0th69s6oHoZLtVrpVjxc
         G5m4CeKKv35gSVjiHZGGuFWJS+/FDqd1XRQzEglajIhXxHUm0C9bY2sD/85y+bONhsbW
         RGvyhnR47/xFQpbjW/NTOt1J40swIfB+igHf32cNdCD2oHjfKSS47nbaXByPrF4yIUQN
         CAonnmfZTCePyoBJ+tKC1/Jms8qBzYr+SheYglWg6SRR8TP2YBU2XHmeIMQ184mBrldf
         o8gRz2CzwBM4M/F1cqZFLcr5bd/GNE0QlScob7eai/5cUdykTHZ2bGgZKsgKkwXBfXeT
         jXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vO5riVGJIq/jxWJeztPKNQ8H6lN7SjOM4tRFMoi/sX0=;
        b=SWEk97EQSvk4iyzeyE11KS/Zlp3vSaupW/nCYJCzBlGbg/EjmEtf8A/NLr8g/WV1J2
         WvglQxA2aDYDZsz3vEU2jxv81LkutC5KsIrFqRRvbQ4vpgUvvKqFHh2dY+bxqCEFpDD1
         xl+KgBPVKg2L0Ua/njUsjULfMc+93ZJlbwh8pyWrn9kivQwiEGrDZjdAy7BXeYCgucnl
         voOpkrdQta/V4rRjPUkbbM+7TPn5O5bHkLSMXOvjXegBdY2IR8HFO7XG0Gvzeto4l/T/
         i0UiKp1Wb18/AJYkraZj5027GBJ0ZzYMKI0WE+U2kZ5Vw+pwxEhWDNAJawkT2/vJpQoR
         Egyw==
X-Gm-Message-State: AOAM532VTm9ZzSxhQMQXOStUmO4iwyHOw/jq8EbWqoMXxXObbAg2ioS0
        ZG4Op8n5gI3c4q9460tgZd0=
X-Google-Smtp-Source: ABdhPJw2c3CxKYGo5eYERK/6aLmsizaDqVjFuUsaVzNVwLQF8SYg4XRTbJB4FUSfPEHROcnB+Yin1A==
X-Received: by 2002:a2e:9bc2:: with SMTP id w2mr1379211ljj.236.1598992666106;
        Tue, 01 Sep 2020 13:37:46 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id z7sm520164lfc.59.2020.09.01.13.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 13:37:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] iommu/tegra-smmu: Add locking around mapping operations
Date:   Tue,  1 Sep 2020 23:37:30 +0300
Message-Id: <20200901203730.27865-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mapping operations of the Tegra SMMU driver are subjected to a race
condition issues because SMMU Address Space isn't allocated and freed
atomically, while it should be. This patch makes the mapping operations
atomic, it fixes an accidentally released Host1x Address Space problem
which happens while running multiple graphics tests in parallel on
Tegra30, i.e. by having multiple threads racing with each other in the
Host1x's submission and completion code paths, performing IOVA mappings
and unmappings in parallel.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v5: - Replaced GFP_NOWAIT check with __GFP_ATOMIC to fix "sleep in
      atomic context" warnings, NOWAIT != ATOMIC.

v4: - Returned to use spinlock, but now using a smarter allocation
      logic that performs allocation in a sleeping context whenever
      possible.

    - Removed the stable tag because patch isn't portable as-is
      since the arguments of map/unmap() callbacks changed recently.
      Perhaps we could just ignore older kernels for now. It will be
      possible to fix older kernels with a custom patch if will be needed.

v3: - No changes. Resending for visibility.

 drivers/iommu/tegra-smmu.c | 95 +++++++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 124c8848ab7e..4853a2f8dc7b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
 
 #include <soc/tegra/ahb.h>
@@ -49,6 +50,7 @@ struct tegra_smmu_as {
 	struct iommu_domain domain;
 	struct tegra_smmu *smmu;
 	unsigned int use_count;
+	spinlock_t lock;
 	u32 *count;
 	struct page **pts;
 	struct page *pd;
@@ -308,6 +310,8 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	spin_lock_init(&as->lock);
+
 	/* setup aperture */
 	as->domain.geometry.aperture_start = 0;
 	as->domain.geometry.aperture_end = 0xffffffff;
@@ -569,19 +573,14 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 }
 
 static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
-		       dma_addr_t *dmap)
+		       dma_addr_t *dmap, struct page *page)
 {
 	unsigned int pde = iova_pd_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
 
 	if (!as->pts[pde]) {
-		struct page *page;
 		dma_addr_t dma;
 
-		page = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
-		if (!page)
-			return NULL;
-
 		dma = dma_map_page(smmu->dev, page, 0, SMMU_SIZE_PT,
 				   DMA_TO_DEVICE);
 		if (dma_mapping_error(smmu->dev, dma)) {
@@ -655,15 +654,61 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 	smmu_flush(smmu);
 }
 
-static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static struct page *as_get_pde_page(struct tegra_smmu_as *as,
+				    unsigned long iova, gfp_t gfp,
+				    unsigned long *flags)
+{
+	unsigned int pde = iova_pd_index(iova);
+	struct page *page = as->pts[pde];
+
+	/* at first check whether allocation needs to be done at all */
+	if (page)
+		return page;
+
+	/*
+	 * In order to prevent exhaustion of the atomic memory pool, we
+	 * allocate page in a sleeping context if GFP flags permit. Hence
+	 * spinlock needs to be unlocked and re-locked after allocation.
+	 */
+	if (!(gfp & __GFP_ATOMIC))
+		spin_unlock_irqrestore(&as->lock, *flags);
+
+	page = alloc_page(gfp | __GFP_DMA | __GFP_ZERO);
+
+	if (!(gfp & __GFP_ATOMIC))
+		spin_lock_irqsave(&as->lock, *flags);
+
+	/*
+	 * In a case of blocking allocation, a concurrent mapping may win
+	 * the PDE allocation. In this case the allocated page isn't needed
+	 * if allocation succeeded and the allocation failure isn't fatal.
+	 */
+	if (as->pts[pde]) {
+		if (page)
+			__free_page(page);
+
+		page = as->pts[pde];
+	}
+
+	return page;
+}
+
+static int
+__tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+		 phys_addr_t paddr, size_t size, int prot, gfp_t gfp,
+		 unsigned long *flags)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
+	struct page *page;
 	u32 pte_attrs;
 	u32 *pte;
 
-	pte = as_get_pte(as, iova, &pte_dma);
+	page = as_get_pde_page(as, iova, gfp, flags);
+	if (!page)
+		return -ENOMEM;
+
+	pte = as_get_pte(as, iova, &pte_dma, page);
 	if (!pte)
 		return -ENOMEM;
 
@@ -685,8 +730,9 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 }
 
-static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t size, struct iommu_iotlb_gather *gather)
+static size_t
+__tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+		   size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
@@ -702,6 +748,33 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
+static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&as->lock, flags);
+	ret = __tegra_smmu_map(domain, iova, paddr, size, prot, gfp, &flags);
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	return ret;
+}
+
+static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, struct iommu_iotlb_gather *gather)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&as->lock, flags);
+	size = __tegra_smmu_unmap(domain, iova, size, gather);
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	return size;
+}
+
 static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-- 
2.27.0

