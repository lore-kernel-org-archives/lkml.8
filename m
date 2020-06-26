Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C826C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E819920707
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TtEzEQ2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgFZUFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:05:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27813 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgFZUEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:04:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593201888; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=MYgenQyiQdZQEyqFDQ5odU+4+VgfI1wyx+54cF7dHG0=; b=TtEzEQ2i72iX3iKI/4nIu3KURCfz+7vq1Jdem8OVoD+O4/COfDXEZ/rrQKLLvPsusdw+vtAa
 MRDWyr3Ncr57PYN1PKFn4f89yO58DsMMP8zoIA7cWOC3Wt855LpOtOFEZokqT3acEuR/BVWI
 XOjZpa0y2KOLdqRCU8wcz8tMAdE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-east-1.postgun.com with SMTP id
 5ef654ce356bcc26abeca3c6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 20:04:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 32472C433C8; Fri, 26 Jun 2020 20:04:29 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2270CC4339C;
        Fri, 26 Jun 2020 20:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2270CC4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        iommu@lists.linux-foundation.org,
        John Stultz <john.stultz@linaro.org>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] drm/msm: Add support to create a local pagetable
Date:   Fri, 26 Jun 2020 14:04:12 -0600
Message-Id: <20200626200414.14382-5-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626200414.14382-1-jcrouse@codeaurora.org>
References: <20200626200414.14382-1-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to create a io-pgtable for use by targets that support
per-instance pagetables.  In order to support per-instance pagetables the
GPU SMMU device needs to have the qcom,adreno-smmu compatible string and
split pagetables and auxiliary domains need to be supported and enabled.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_gpummu.c |   2 +-
 drivers/gpu/drm/msm/msm_iommu.c  | 180 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_mmu.h    |  16 ++-
 3 files changed, 195 insertions(+), 3 deletions(-)

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
index 1b6635504069..f455c597f76d 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -4,15 +4,192 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <linux/io-pgtable.h>
 #include "msm_drv.h"
 #include "msm_mmu.h"
 
 struct msm_iommu {
 	struct msm_mmu base;
 	struct iommu_domain *domain;
+	struct iommu_domain *aux_domain;
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
+
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
+			if (ops->map(ops, addr, phys, 4096, prot)) {
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
+
+	free_io_pgtable_ops(pagetable->pgtbl_ops);
+	kfree(pagetable);
+}
+
+/*
+ * Given a parent device, create and return an aux domain. This will enable the
+ * TTBR0 region
+ */
+static struct iommu_domain *msm_iommu_get_aux_domain(struct msm_mmu *parent)
+{
+	struct msm_iommu *iommu = to_msm_iommu(parent);
+	struct iommu_domain *domain;
+	int ret;
+
+	if (iommu->aux_domain)
+		return iommu->aux_domain;
+
+	if (!iommu_dev_has_feature(parent->dev, IOMMU_DEV_FEAT_AUX))
+		return ERR_PTR(-ENODEV);
+
+	domain = iommu_domain_alloc(&platform_bus_type);
+	if (!domain)
+		return ERR_PTR(-ENODEV);
+
+	ret = iommu_aux_attach_device(domain, parent->dev);
+	if (ret) {
+		iommu_domain_free(domain);
+		return ERR_PTR(ret);
+	}
+
+	iommu->aux_domain = domain;
+	return domain;
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
+struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
+{
+	static int next_asid = 16;
+	struct msm_iommu_pagetable *pagetable;
+	struct iommu_domain *aux_domain;
+	struct io_pgtable_cfg cfg;
+	int ret;
+
+	/* Make sure that the parent has a aux domain attached */
+	aux_domain = msm_iommu_get_aux_domain(parent);
+	if (IS_ERR(aux_domain))
+		return ERR_CAST(aux_domain);
+
+	/* Get the pagetable configuration from the aux domain */
+	ret = iommu_domain_get_attr(aux_domain, DOMAIN_ATTR_PGTABLE_CFG, &cfg);
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
+	cfg.tlb = NULL;
+
+	pagetable->pgtbl_ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1,
+		&cfg, aux_domain);
+
+	if (!pagetable->pgtbl_ops) {
+		kfree(pagetable);
+		return ERR_PTR(-ENOMEM);
+	}
+
+
+	/* Needed later for TLB flush */
+	pagetable->parent = parent;
+	pagetable->ttbr = cfg.arm_lpae_s1_cfg.ttbr;
+
+	pagetable->asid = next_asid;
+	next_asid = (next_asid + 1)  % 255;
+	if (next_asid < 16)
+		next_asid = 16;
+
+	return &pagetable->base;
+}
+
 static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 		unsigned long iova, int flags, void *arg)
 {
@@ -40,6 +217,7 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	if (iova & BIT_ULL(48))
 		iova |= GENMASK_ULL(63, 49);
 
+
 	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
 	WARN_ON(!ret);
 
@@ -85,7 +263,7 @@ struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
 		return ERR_PTR(-ENOMEM);
 
 	iommu->domain = domain;
-	msm_mmu_init(&iommu->base, dev, &funcs);
+	msm_mmu_init(&iommu->base, dev, &funcs, MSM_MMU_IOMMU);
 	iommu_set_fault_handler(domain, msm_fault_handler, iommu);
 
 	ret = iommu_attach_device(iommu->domain, dev);
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
2.17.1

