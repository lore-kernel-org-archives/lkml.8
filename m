Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06437C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D166820722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="JCcGMx5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgDTODn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729177AbgDTODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:03:42 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CCAC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:03:41 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l13so8463286qtr.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWUiiER6P7gOnYmdlQPJIJLHrN3gxXy6MD3oYjvgtIk=;
        b=JCcGMx5PM9IMPPLnBdILAo6pxf7H7wj++Q32wch4GB8+nRofxBPXeBaDcsg9Kjwctu
         c0M9sePsS5SEQ/ZT/nFBheJOlthnxN7Jcm69L4GJZdsDti/cbeX7oYesf6mvcu4WlvIn
         b3s+3pdM0SHhHNN0VM3UCqcNa0fGguTKWBYCFOeABHCtrqRsN5GOS4YS9f9DL6lyrj5j
         XbQH4TdDGidSOrLR2CAakfYveEv74w3oPEw44/dyf5tnt9iYa69aY1kTeYqzIrApDagH
         FFCfN3lOhdwPPB1G0t67dclAT2qijMrHBoHv+gOx/sXv93IpWiGAJFmEcTZD36UnCyB2
         rhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWUiiER6P7gOnYmdlQPJIJLHrN3gxXy6MD3oYjvgtIk=;
        b=mXRK8ZfqTmycPQqA47GFkj3YPw2Jzd9jEOge8O4fna0fy8WDL4x0nEgDfaVFs1cQPa
         WMtmphq+S3lCrOGq6hTRbP2/XXcRl5Rzr3N5Q/SAJHDHhqtEhJoxOpbFdnWuzaJ89ioq
         4hmZk/wSUbMHXnfNuYWJH5elXUgor0LlKNbjMWl36Ld5PmVMKsWJ5NHalUZk4xI4U8ye
         rcdQUZpR18S0QfwhSwza/JuNfssrSRfG/Cjbng/KsycRZiL4adfl2ifqls7wRDcaRk+q
         slliec4ABwA5bGNjm4LBmZjw3/6sgAXaYFwht9W22Ge+mniIkD/ZxRutOY6kOzyYzZxV
         QNEg==
X-Gm-Message-State: AGi0Pubh/K3RubixymtrYuRseUyugfpPCg18IRcirHEn1lEJLju6cRKS
        DGo6IdzO+vb+FnlXqC0JcD48yA==
X-Google-Smtp-Source: APiQypJgAoMSMQG2O6ntkjnSC5Iz0O6n44rFFOknLX9+QA6UJAUiZbe8VY5B4CQvfTmyByAxwv2zsw==
X-Received: by 2002:ac8:36ab:: with SMTP id a40mr15954602qtc.309.1587391420817;
        Mon, 20 Apr 2020 07:03:40 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id t75sm609424qke.127.2020.04.20.07.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 07:03:40 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/9] Revert "drm/msm/a6xx: Use the DMA API for GMU memory objects"
Date:   Mon, 20 Apr 2020 10:03:06 -0400
Message-Id: <20200420140313.7263-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420140313.7263-1-jonathan@marek.ca>
References: <20200420140313.7263-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a5fb8b918920c6f7706a8b5b8ea535a7f077a7f6.
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 115 +++++++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |   6 +-
 2 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index c4e71abbdd53..748cd379065f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2017-2019 The Linux Foundation. All rights reserved. */
 
 #include <linux/clk.h>
-#include <linux/dma-mapping.h>
 #include <linux/interconnect.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
@@ -921,10 +920,21 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 
 static void a6xx_gmu_memory_free(struct a6xx_gmu *gmu, struct a6xx_gmu_bo *bo)
 {
+	int count, i;
+	u64 iova;
+
 	if (IS_ERR_OR_NULL(bo))
 		return;
 
-	dma_free_wc(gmu->dev, bo->size, bo->virt, bo->iova);
+	count = bo->size >> PAGE_SHIFT;
+	iova = bo->iova;
+
+	for (i = 0; i < count; i++, iova += PAGE_SIZE) {
+		iommu_unmap(gmu->domain, iova, PAGE_SIZE);
+		__free_pages(bo->pages[i], 0);
+	}
+
+	kfree(bo->pages);
 	kfree(bo);
 }
 
@@ -932,6 +942,7 @@ static struct a6xx_gmu_bo *a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu,
 		size_t size)
 {
 	struct a6xx_gmu_bo *bo;
+	int ret, count, i;
 
 	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
 	if (!bo)
@@ -939,14 +950,86 @@ static struct a6xx_gmu_bo *a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu,
 
 	bo->size = PAGE_ALIGN(size);
 
-	bo->virt = dma_alloc_wc(gmu->dev, bo->size, &bo->iova, GFP_KERNEL);
+	count = bo->size >> PAGE_SHIFT;
 
-	if (!bo->virt) {
+	bo->pages = kcalloc(count, sizeof(struct page *), GFP_KERNEL);
+	if (!bo->pages) {
 		kfree(bo);
 		return ERR_PTR(-ENOMEM);
 	}
 
+	for (i = 0; i < count; i++) {
+		bo->pages[i] = alloc_page(GFP_KERNEL);
+		if (!bo->pages[i])
+			goto err;
+	}
+
+	bo->iova = gmu->uncached_iova_base;
+
+	for (i = 0; i < count; i++) {
+		ret = iommu_map(gmu->domain,
+			bo->iova + (PAGE_SIZE * i),
+			page_to_phys(bo->pages[i]), PAGE_SIZE,
+			IOMMU_READ | IOMMU_WRITE);
+
+		if (ret) {
+			DRM_DEV_ERROR(gmu->dev, "Unable to map GMU buffer object\n");
+
+			for (i = i - 1 ; i >= 0; i--)
+				iommu_unmap(gmu->domain,
+					bo->iova + (PAGE_SIZE * i),
+					PAGE_SIZE);
+
+			goto err;
+		}
+	}
+
+	bo->virt = vmap(bo->pages, count, VM_IOREMAP,
+		pgprot_writecombine(PAGE_KERNEL));
+	if (!bo->virt)
+		goto err;
+
+	/* Align future IOVA addresses on 1MB boundaries */
+	gmu->uncached_iova_base += ALIGN(size, SZ_1M);
+
 	return bo;
+
+err:
+	for (i = 0; i < count; i++) {
+		if (bo->pages[i])
+			__free_pages(bo->pages[i], 0);
+	}
+
+	kfree(bo->pages);
+	kfree(bo);
+
+	return ERR_PTR(-ENOMEM);
+}
+
+static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
+{
+	int ret;
+
+	/*
+	 * The GMU address space is hardcoded to treat the range
+	 * 0x60000000 - 0x80000000 as un-cached memory. All buffers shared
+	 * between the GMU and the CPU will live in this space
+	 */
+	gmu->uncached_iova_base = 0x60000000;
+
+
+	gmu->domain = iommu_domain_alloc(&platform_bus_type);
+	if (!gmu->domain)
+		return -ENODEV;
+
+	ret = iommu_attach_device(gmu->domain, gmu->dev);
+
+	if (ret) {
+		iommu_domain_free(gmu->domain);
+		gmu->domain = NULL;
+	}
+
+	return ret;
 }
 
 /* Return the 'arc-level' for the given frequency */
@@ -1206,6 +1289,10 @@ void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
 
 	a6xx_gmu_memory_free(gmu, gmu->hfi);
 
+	iommu_detach_device(gmu->domain, gmu->dev);
+
+	iommu_domain_free(gmu->domain);
+
 	free_irq(gmu->gmu_irq, gmu);
 	free_irq(gmu->hfi_irq, gmu);
 
@@ -1226,15 +1313,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 
 	gmu->dev = &pdev->dev;
 
-	/* Pass force_dma false to require the DT to set the dma region */
-	ret = of_dma_configure(gmu->dev, node, false);
-	if (ret)
-		return ret;
-
-	/* Set the mask after the of_dma_configure() */
-	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(31));
-	if (ret)
-		return ret;
+	of_dma_configure(gmu->dev, node, true);
 
 	/* Fow now, don't do anything fancy until we get our feet under us */
 	gmu->idle_level = GMU_IDLE_STATE_ACTIVE;
@@ -1246,6 +1325,11 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 	if (ret)
 		goto err_put_device;
 
+	/* Set up the IOMMU context bank */
+	ret = a6xx_gmu_memory_probe(gmu);
+	if (ret)
+		goto err_put_device;
+
 	/* Allocate memory for for the HFI queues */
 	gmu->hfi = a6xx_gmu_memory_alloc(gmu, SZ_16K);
 	if (IS_ERR(gmu->hfi))
@@ -1291,6 +1375,11 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 err_memory:
 	a6xx_gmu_memory_free(gmu, gmu->hfi);
 
+	if (gmu->domain) {
+		iommu_detach_device(gmu->domain, gmu->dev);
+
+		iommu_domain_free(gmu->domain);
+	}
 	ret = -ENODEV;
 
 err_put_device:
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 4af65a36d5ca..2af91ed7ed0c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -12,7 +12,8 @@
 struct a6xx_gmu_bo {
 	void *virt;
 	size_t size;
-	dma_addr_t iova;
+	u64 iova;
+	struct page **pages;
 };
 
 /*
@@ -48,6 +49,9 @@ struct a6xx_gmu {
 	int hfi_irq;
 	int gmu_irq;
 
+	struct iommu_domain *domain;
+	u64 uncached_iova_base;
+
 	struct device *gxpd;
 
 	int idle_level;
-- 
2.26.1

