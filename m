Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3A7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52EE72073E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VbX5gGaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgHJW1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:27:45 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:14937 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727109AbgHJW1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:27:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597098461; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=iq9TuxnwB5kGxb5cTMsU0LE5bIkRcWS49YoceQPqScU=; b=VbX5gGaQvMT7un0M/uXuMD1DyfCsSUy0JLZNTIdy7iJqtQgHHGRkSj5IZVreZEZjWzGNxgVc
 7DD8/25H9J+v/9cIUb8RdPNHK8UeMriN5yFrWXd72YjTxgFaaFyvo12Okq+9Lsce4A05Yarx
 94HByZgEpBYHM8kC1ww1SASxoXE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f31c9ddc85a1092b0fb1673 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 Aug 2020 22:27:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 03826C433A1; Mon, 10 Aug 2020 22:27:34 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DFF9C433AF;
        Mon, 10 Aug 2020 22:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DFF9C433AF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 09/13] drm/msm: Add support to create a local pagetable
Date:   Mon, 10 Aug 2020 16:26:53 -0600
Message-Id: <20200810222657.1841322-10-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810222657.1841322-1-jcrouse@codeaurora.org>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to create a io-pgtable for use by targets that support
per-instance pagetables. In order to support per-instance pagetables the
GPU SMMU device needs to have the qcom,adreno-smmu compatible string and
split pagetables enabled.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_gpummu.c |   2 +-
 drivers/gpu/drm/msm/msm_iommu.c  | 190 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_mmu.h    |  16 ++-
 3 files changed, 205 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
index 310a31b05faa..aab121f4beb7 100644
--- a/drivers/gpu/drm/msm/msm_gpummu.c
+++ b/drivers/gpu/drm/msm/msm_gpummu.c
@@ -102,7 +102,7 @@ struct msm_mmu *msm_gpummu_new(struct device *dev, struct msm_gpu *gpu)
 	}
 
 	gpummu->gpu = gpu;
-	msm_mmu_init(&gpummu->base, dev, &funcs);
+	msm_mmu_init(&gpummu->base, dev, &funcs, MSM_MMU_GPUMMU);
 
 	return &gpummu->base;
 }
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 1b6635504069..bc04dda8a198 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -4,15 +4,201 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <linux/io-pgtable.h>
 #include "msm_drv.h"
 #include "msm_mmu.h"
 
 struct msm_iommu {
 	struct msm_mmu base;
 	struct iommu_domain *domain;
+	atomic_t pagetables;
 };
+
 #define to_msm_iommu(x) container_of(x, struct msm_iommu, base)
 
+struct msm_iommu_pagetable {
+	struct msm_mmu base;
+	struct msm_mmu *parent;
+	struct io_pgtable_ops *pgtbl_ops;
+	phys_addr_t ttbr;
+	u32 asid;
+};
+static struct msm_iommu_pagetable *to_pagetable(struct msm_mmu *mmu)
+{
+	return container_of(mmu, struct msm_iommu_pagetable, base);
+}
+
+static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
+		size_t size)
+{
+	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
+	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
+	size_t unmapped = 0;
+
+	/* Unmap the block one page at a time */
+	while (size) {
+		unmapped += ops->unmap(ops, iova, 4096, NULL);
+		iova += 4096;
+		size -= 4096;
+	}
+
+	iommu_flush_tlb_all(to_msm_iommu(pagetable->parent)->domain);
+
+	return (unmapped == size) ? 0 : -EINVAL;
+}
+
+static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
+		struct sg_table *sgt, size_t len, int prot)
+{
+	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
+	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
+	struct scatterlist *sg;
+	size_t mapped = 0;
+	u64 addr = iova;
+	unsigned int i;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		size_t size = sg->length;
+		phys_addr_t phys = sg_phys(sg);
+
+		/* Map the block one page at a time */
+		while (size) {
+			if (ops->map(ops, addr, phys, 4096, prot, GFP_KERNEL)) {
+				msm_iommu_pagetable_unmap(mmu, iova, mapped);
+				return -EINVAL;
+			}
+
+			phys += 4096;
+			addr += 4096;
+			size -= 4096;
+			mapped += 4096;
+		}
+	}
+
+	return 0;
+}
+
+static void msm_iommu_pagetable_destroy(struct msm_mmu *mmu)
+{
+	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
+	struct msm_iommu *iommu = to_msm_iommu(pagetable->parent);
+
+	/*
+	 * If this is the last attached pagetable for the parent,
+	 * disable TTBR0 in the arm-smmu driver
+	 */
+	if (atomic_dec_return(&iommu->pagetables) == 0)
+		iommu_domain_set_attr(iommu->domain,
+			DOMAIN_ATTR_PGTABLE_CFG, NULL);
+
+	free_io_pgtable_ops(pagetable->pgtbl_ops);
+	kfree(pagetable);
+}
+
+int msm_iommu_pagetable_params(struct msm_mmu *mmu,
+		phys_addr_t *ttbr, int *asid)
+{
+	struct msm_iommu_pagetable *pagetable;
+
+	if (mmu->type != MSM_MMU_IOMMU_PAGETABLE)
+		return -EINVAL;
+
+	pagetable = to_pagetable(mmu);
+
+	if (ttbr)
+		*ttbr = pagetable->ttbr;
+
+	if (asid)
+		*asid = pagetable->asid;
+
+	return 0;
+}
+
+static const struct msm_mmu_funcs pagetable_funcs = {
+		.map = msm_iommu_pagetable_map,
+		.unmap = msm_iommu_pagetable_unmap,
+		.destroy = msm_iommu_pagetable_destroy,
+};
+
+static void msm_iommu_tlb_flush_all(void *cookie)
+{
+}
+
+static void msm_iommu_tlb_flush_walk(unsigned long iova, size_t size,
+		size_t granule, void *cookie)
+{
+}
+
+static void msm_iommu_tlb_add_page(struct iommu_iotlb_gather *gather,
+		unsigned long iova, size_t granule, void *cookie)
+{
+}
+
+static const struct iommu_flush_ops null_tlb_ops = {
+	.tlb_flush_all = msm_iommu_tlb_flush_all,
+	.tlb_flush_walk = msm_iommu_tlb_flush_walk,
+	.tlb_flush_leaf = msm_iommu_tlb_flush_walk,
+	.tlb_add_page = msm_iommu_tlb_add_page,
+};
+
+struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
+{
+	struct msm_iommu *iommu = to_msm_iommu(parent);
+	static int next_asid = 16;
+	struct msm_iommu_pagetable *pagetable;
+	struct io_pgtable_cfg cfg;
+	int ret;
+
+	/* Get the pagetable configuration from the domain */
+	ret = iommu_domain_get_attr(iommu->domain,
+		DOMAIN_ATTR_PGTABLE_CFG, &cfg);
+	if (ret)
+		return ERR_PTR(ret);
+
+	pagetable = kzalloc(sizeof(*pagetable), GFP_KERNEL);
+	if (!pagetable)
+		return ERR_PTR(-ENOMEM);
+
+	msm_mmu_init(&pagetable->base, parent->dev, &pagetable_funcs,
+		MSM_MMU_IOMMU_PAGETABLE);
+
+	/* The incoming cfg will have the TTBR1 quirk enabled */
+	cfg.quirks &= ~IO_PGTABLE_QUIRK_ARM_TTBR1;
+	cfg.tlb = &null_tlb_ops;
+
+	pagetable->pgtbl_ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1,
+		&cfg, iommu->domain);
+
+	if (!pagetable->pgtbl_ops) {
+		kfree(pagetable);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * If this is the first pagetable that we've allocated, send it back to
+	 * the arm-smmu driver as a trigger to set up TTBR0
+	 */
+	if (atomic_inc_return(&iommu->pagetables) == 1) {
+		ret = iommu_domain_set_attr(iommu->domain,
+			DOMAIN_ATTR_PGTABLE_CFG, &cfg);
+		if (ret) {
+			free_io_pgtable_ops(pagetable->pgtbl_ops);
+			kfree(pagetable);
+			return ERR_PTR(ret);
+		}
+	}
+
+	/* Needed later for TLB flush */
+	pagetable->parent = parent;
+	pagetable->ttbr = cfg.arm_lpae_s1_cfg.ttbr;
+
+	pagetable->asid = next_asid;
+	next_asid = (next_asid + 1) % 255;
+	next_asid = min(16, next_asid);
+
+	return &pagetable->base;
+}
+
 static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 		unsigned long iova, int flags, void *arg)
 {
@@ -85,9 +271,11 @@ struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
 		return ERR_PTR(-ENOMEM);
 
 	iommu->domain = domain;
-	msm_mmu_init(&iommu->base, dev, &funcs);
+	msm_mmu_init(&iommu->base, dev, &funcs, MSM_MMU_IOMMU);
 	iommu_set_fault_handler(domain, msm_fault_handler, iommu);
 
+	atomic_set(&iommu->pagetables, 0);
+
 	ret = iommu_attach_device(iommu->domain, dev);
 	if (ret) {
 		kfree(iommu);
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index 3a534ee59bf6..61ade89d9e48 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -17,18 +17,26 @@ struct msm_mmu_funcs {
 	void (*destroy)(struct msm_mmu *mmu);
 };
 
+enum msm_mmu_type {
+	MSM_MMU_GPUMMU,
+	MSM_MMU_IOMMU,
+	MSM_MMU_IOMMU_PAGETABLE,
+};
+
 struct msm_mmu {
 	const struct msm_mmu_funcs *funcs;
 	struct device *dev;
 	int (*handler)(void *arg, unsigned long iova, int flags);
 	void *arg;
+	enum msm_mmu_type type;
 };
 
 static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,
-		const struct msm_mmu_funcs *funcs)
+		const struct msm_mmu_funcs *funcs, enum msm_mmu_type type)
 {
 	mmu->dev = dev;
 	mmu->funcs = funcs;
+	mmu->type = type;
 }
 
 struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain);
@@ -41,7 +49,13 @@ static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
 	mmu->handler = handler;
 }
 
+struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent);
+
 void msm_gpummu_params(struct msm_mmu *mmu, dma_addr_t *pt_base,
 		dma_addr_t *tran_error);
 
+
+int msm_iommu_pagetable_params(struct msm_mmu *mmu, phys_addr_t *ttbr,
+		int *asid);
+
 #endif /* __MSM_MMU_H__ */
-- 
2.25.1

