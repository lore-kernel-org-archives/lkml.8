Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D3FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D311207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgE0Lxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgE0Lx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:53:28 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF52C08C5C4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:53:28 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5449F485; Wed, 27 May 2020 13:53:24 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        jroedel@suse.de
Subject: [PATCH 07/10] iommu/amd: Remove PD_DMA_OPS_MASK
Date:   Wed, 27 May 2020 13:53:10 +0200
Message-Id: <20200527115313.7426-8-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This is covered by IOMMU_DOMAIN_DMA from the IOMMU core code already,
so remove it.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9e0737932e0c..7c87ef78f26a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1817,15 +1817,6 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
-/*
- * little helper function to check whether a given protection domain is a
- * dma_ops domain
- */
-static bool dma_ops_domain(struct protection_domain *domain)
-{
-	return domain->flags & PD_DMA_OPS_MASK;
-}
-
 static void set_dte_entry(u16 devid, struct protection_domain *domain,
 			  struct domain_pgtable *pgtable,
 			  bool ats, bool ppr)
@@ -2408,11 +2399,9 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 	domain->domain.geometry.aperture_end   = ~0ULL;
 	domain->domain.geometry.force_aperture = true;
 
-	if (type == IOMMU_DOMAIN_DMA) {
-		if (iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
-			goto free_domain;
-		domain->flags = PD_DMA_OPS_MASK;
-	}
+	if (type == IOMMU_DOMAIN_DMA &&
+	    iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
+		goto free_domain;
 
 	return &domain->domain;
 
@@ -3024,17 +3013,18 @@ struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev)
 	if (!check_device(dev))
 		return NULL;
 
-	pdomain = get_dev_data(dev)->domain;
+	pdomain   = get_dev_data(dev)->domain;
+	io_domain = iommu_get_domain_for_dev(dev);
 	if (pdomain == NULL && get_dev_data(dev)->defer_attach) {
 		get_dev_data(dev)->defer_attach = false;
-		io_domain = iommu_get_domain_for_dev(dev);
 		pdomain = to_pdomain(io_domain);
 		attach_device(dev, pdomain);
 	}
+
 	if (pdomain == NULL)
 		return NULL;
 
-	if (!dma_ops_domain(pdomain))
+	if (io_domain->type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
 	/* Only return IOMMUv2 domains */
-- 
2.17.1

