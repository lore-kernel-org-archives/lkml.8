Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1C3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A692072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650629;
	bh=28N0YSDdInyo9NOOCTtQ2JysgmVncp+LnW70DxnQkSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aztXve47uefEpFsZKaj8UyMtIEdP4yDOfwm/dQSQay2lsOR8HzV1yjMFf48FMG3q0
	 HgnNpf+FRNhMmf9EADiofulB805H/dVgCPt2YGoBRRZNoIJbRxydOTVeDKnh/7UIyt
	 ouNuWaJCP0rFSNfzN4gjmjJdTKAMDUDwdzD9K2uA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgHQHu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgHQHuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:20 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA93520772;
        Mon, 17 Aug 2020 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=28N0YSDdInyo9NOOCTtQ2JysgmVncp+LnW70DxnQkSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTHbQZR3NTdGVJ0kLKvtj0XTCYs+GARSPxgYkniWc8YJp6NcmplPWRhfN9J+xFqWD
         NTkDmZ904Qx9CGr3FPFB+Pgof7RG4UBWYkKTssQ2So1/V/qT8zapzUv7ZiF1bl1seo
         YPK/07KKY7n3N70w62pg82YKm6Q80odv846Z0dQ8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuL-00Bfbv-Tw; Mon, 17 Aug 2020 09:50:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH 02/16] iommu: hisilicon: remove default iommu_map_sg handler
Date:   Mon, 17 Aug 2020 09:50:01 +0200
Message-Id: <d1935aa28fd49ed2195043906699388c56070c03.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code there is just a copy of the default iommu sg
handler. Well, callback fops was removed, as all iommu
drivers are doing the same.

Fixes: d88e61faad52 ("iommu: Remove the ->map_sg indirection")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi_smmu_lpae.c | 42 -----------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi_smmu_lpae.c b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
index 0ccd5c9ffeb1..c5c266fb1c0b 100644
--- a/drivers/staging/hikey9xx/hisi_smmu_lpae.c
+++ b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
@@ -720,48 +720,7 @@ static size_t hisi_smmu_unmap_tile_lpae(struct iommu_domain *domain,
 		unsigned long iova, size_t size)
 {
 	return hisi_smmu_unmap_lpae(domain, iova, size);
-}
 
-size_t hisi_iommu_map_sg_lpae(struct iommu_domain *domain, unsigned long iova,
-			 struct scatterlist *sg, unsigned int nents, int prot)
-{
-	struct scatterlist *s;
-	size_t mapped = 0;
-	unsigned int i, min_pagesz;
-	int ret;
-
-	if (domain->ops->pgsize_bitmap == 0UL)
-		return 0;
-
-	min_pagesz = (unsigned int)1 << __ffs(domain->ops->pgsize_bitmap);
-
-	for_each_sg(sg, s, nents, i) {
-		phys_addr_t phys = page_to_phys(sg_page(s)) + s->offset;
-
-		/*
-		 * We are mapping on IOMMU page boundaries, so offset within
-		 * the page must be 0. However, the IOMMU may support pages
-		 * smaller than PAGE_SIZE, so s->offset may still represent
-		 * an offset of that boundary within the CPU page.
-		 */
-		if (!IS_ALIGNED(s->offset, min_pagesz))
-			goto out_err;
-
-		ret = hisi_smmu_map_lpae(domain, iova + mapped, phys,
-					(size_t)s->length, prot);
-		if (ret)
-			goto out_err;
-
-		mapped += s->length;
-	}
-
-	return mapped;
-
-out_err:
-	/* undo mappings already done */
-	hisi_smmu_unmap_lpae(domain, iova, mapped);
-
-	return 0;
 }
 
 static struct iommu_ops hisi_smmu_ops = {
@@ -769,7 +728,6 @@ static struct iommu_ops hisi_smmu_ops = {
 	.domain_free	= hisi_smmu_domain_free_lpae,
 	.map		= hisi_smmu_map_lpae,
 	.unmap		= hisi_smmu_unmap_lpae,
-	.map_sg     = hisi_iommu_map_sg_lpae,
 	.attach_dev = hisi_attach_dev_lpae,
 	.detach_dev = hisi_detach_dev_lpae,
 	.iova_to_phys	= hisi_smmu_iova_to_phys_lpae,
-- 
2.26.2

