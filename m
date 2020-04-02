Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D319C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 04:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E1B206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 04:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="qrjpLexf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgDBEMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 00:12:15 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39065 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgDBEMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 00:12:14 -0400
Received: by mail-pj1-f68.google.com with SMTP id z3so999757pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 21:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u11SA1v5lDHbwzwkFSCh6NiqhqGABE/1UnVjTe1jwnc=;
        b=qrjpLexf3pkfUEIq4xKX44iq9xgKCxV8CV/E+vQuLEgHXzQklceVUvwLDaPeXiJYr5
         AZ4wB23rxcAcy/JTV7WkHnv01kW8PiWMyISOkQl/Vx0qiGps0OrrMOmTxKprGqOb5gqd
         UM+uOwV41+2YX3d52XKvnaF8a/uPGu8ag4XEbTZ3xD1um5MSnqsRkR4uA8roMF5HcfWm
         fWPSxqS0fZxK/bf78WhJbuWlt1oq9YF660CS2CdYEff7+AQv4p9W+TkLMR01i/jgtyzE
         +h+qZ7FSwJgqT5Nh7bTzKtXb4ArIgIwyBxJj7AcEi2FL+CuBLZ/59bN2ClUDbULn86zy
         NT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u11SA1v5lDHbwzwkFSCh6NiqhqGABE/1UnVjTe1jwnc=;
        b=BKF6vJrL25Kbrj50NQDkC0kxnSLNwC2OOH+Li3o8ONWcOWfx4iEogs0+tVMft2rsCC
         gwi/oN0krQW/MNgw6fzNa57Oe8RiZqvut1Ix4cDm7CJZCs/WvvyekiVqqfsTRDo/nme1
         aOcI4D4AI0/Lni5lA3Y6yk9Bdqz6glPfJZb8Xvvf37kz8qu1boNibjqK6N2dk40fpEc2
         yOQOUtgOauvuUNPUIzdA00tCPDS7UR83Psqf1P9MI6MVQeg11cuJOZL+RQSmtqHHgsnS
         vhKQNTy2cCBJbt1Vyj1EK5q5/x5dsOff1IqXivuqhtB3xNS8L2I7qWvoRzWPhi6SxWEg
         /0ig==
X-Gm-Message-State: AGi0PuYg9vCIhbEl8MFfayFmPcw0IH85kO/Uk2cljFY7+/UdfkCrtWPC
        GsorR0z2SD4+9Xuh4yELHv7ekg==
X-Google-Smtp-Source: APiQypKXLU201No2vEQ1RTPqbyVKExlpd1AX4SDLxnX5JUncA3ab8mryjs22/JjGJ6Cbtwx/tZsDqA==
X-Received: by 2002:a17:90b:230d:: with SMTP id mt13mr1585074pjb.164.1585800733481;
        Wed, 01 Apr 2020 21:12:13 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.teksavvy.com ([69.172.145.184])
        by smtp.googlemail.com with ESMTPSA id v25sm2571818pgl.55.2020.04.01.21.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 21:12:12 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] intel-iommu: Remove all IOVA handling code from the non-dma_ops path in the intel
Date:   Thu,  2 Apr 2020 05:12:00 +0100
Message-Id: <20200402041200.12458-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need for the non-dma_ops path to keep track of IOVAs. The
whole point of the non-dma_ops path is that it allows the IOVAs to be
handled separately. The IOVA handling code removed in this patch is
pointless.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/intel-iommu.c | 97 +++++++++++++------------------------
 1 file changed, 33 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4be549478691..b92606979914 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1911,11 +1911,6 @@ static int dmar_init_reserved_ranges(void)
 	return 0;
 }
 
-static void domain_reserve_special_ranges(struct dmar_domain *domain)
-{
-	copy_reserved_iova(&reserved_iova_list, &domain->iovad);
-}
-
 static inline int guestwidth_to_adjustwidth(int gaw)
 {
 	int agaw;
@@ -1946,7 +1941,7 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 			pr_info("iova flush queue initialization failed\n");
 	}
 
-	domain_reserve_special_ranges(domain);
+	copy_reserved_iova(&reserved_iova_list, &domain->iovad);
 
 	/* calculate AGAW */
 	if (guest_width > cap_mgaw(iommu->cap))
@@ -1996,7 +1991,8 @@ static void domain_exit(struct dmar_domain *domain)
 	domain_remove_dev_info(domain);
 
 	/* destroy iovas */
-	put_iova_domain(&domain->iovad);
+	if (domain->domain.type == IOMMU_DOMAIN_DMA)
+		put_iova_domain(&domain->iovad);
 
 	if (domain->pgd) {
 		struct page *freelist;
@@ -2793,19 +2789,9 @@ static struct dmar_domain *set_domain_for_dev(struct device *dev,
 }
 
 static int iommu_domain_identity_map(struct dmar_domain *domain,
-				     unsigned long long start,
-				     unsigned long long end)
+				     unsigned long first_vpfn,
+				     unsigned long last_vpfn)
 {
-	unsigned long first_vpfn = start >> VTD_PAGE_SHIFT;
-	unsigned long last_vpfn = end >> VTD_PAGE_SHIFT;
-
-	if (!reserve_iova(&domain->iovad, dma_to_mm_pfn(first_vpfn),
-			  dma_to_mm_pfn(last_vpfn))) {
-		pr_err("Reserving iova failed\n");
-		return -ENOMEM;
-	}
-
-	pr_debug("Mapping reserved region %llx-%llx\n", start, end);
 	/*
 	 * RMRR range might have overlap with physical memory range,
 	 * clear it first
@@ -2882,7 +2868,8 @@ static int __init si_domain_init(int hw)
 
 		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 			ret = iommu_domain_identity_map(si_domain,
-					PFN_PHYS(start_pfn), PFN_PHYS(end_pfn));
+					mm_to_dma_pfn(start_pfn),
+					mm_to_dma_pfn(end_pfn));
 			if (ret)
 				return ret;
 		}
@@ -4812,58 +4799,37 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 				       unsigned long val, void *v)
 {
 	struct memory_notify *mhp = v;
-	unsigned long long start, end;
-	unsigned long start_vpfn, last_vpfn;
+	unsigned long start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
+	unsigned long last_vpfn = mm_to_dma_pfn(mhp->start_pfn +
+			mhp->nr_pages - 1);
 
 	switch (val) {
 	case MEM_GOING_ONLINE:
-		start = mhp->start_pfn << PAGE_SHIFT;
-		end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
-		if (iommu_domain_identity_map(si_domain, start, end)) {
-			pr_warn("Failed to build identity map for [%llx-%llx]\n",
-				start, end);
+		if (iommu_domain_identity_map(si_domain, start_vpfn,
+					last_vpfn)) {
+			pr_warn("Failed to build identity map for [%lx-%lx]\n",
+				start_vpfn, last_vpfn);
 			return NOTIFY_BAD;
 		}
 		break;
 
 	case MEM_OFFLINE:
 	case MEM_CANCEL_ONLINE:
-		start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
-		last_vpfn = mm_to_dma_pfn(mhp->start_pfn + mhp->nr_pages - 1);
-		while (start_vpfn <= last_vpfn) {
-			struct iova *iova;
+		{
 			struct dmar_drhd_unit *drhd;
 			struct intel_iommu *iommu;
 			struct page *freelist;
 
-			iova = find_iova(&si_domain->iovad, start_vpfn);
-			if (iova == NULL) {
-				pr_debug("Failed get IOVA for PFN %lx\n",
-					 start_vpfn);
-				break;
-			}
-
-			iova = split_and_remove_iova(&si_domain->iovad, iova,
-						     start_vpfn, last_vpfn);
-			if (iova == NULL) {
-				pr_warn("Failed to split IOVA PFN [%lx-%lx]\n",
-					start_vpfn, last_vpfn);
-				return NOTIFY_BAD;
-			}
-
-			freelist = domain_unmap(si_domain, iova->pfn_lo,
-					       iova->pfn_hi);
+			freelist = domain_unmap(si_domain, start_vpfn,
+					last_vpfn);
 
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
 				iommu_flush_iotlb_psi(iommu, si_domain,
-					iova->pfn_lo, iova_size(iova),
+					start_vpfn, mhp->nr_pages,
 					!freelist, 0);
 			rcu_read_unlock();
 			dma_free_pagelist(freelist);
-
-			start_vpfn = iova->pfn_hi + 1;
-			free_iova_mem(iova);
 		}
 		break;
 	}
@@ -4891,8 +4857,9 @@ static void free_all_cpu_cached_iovas(unsigned int cpu)
 		for (did = 0; did < cap_ndoms(iommu->cap); did++) {
 			domain = get_iommu_domain(iommu, (u16)did);
 
-			if (!domain)
+			if (!domain || domain->domain.type != IOMMU_DOMAIN_DMA)
 				continue;
+
 			free_cpu_cached_iovas(cpu, &domain->iovad);
 		}
 	}
@@ -5321,9 +5288,6 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 {
 	int adjust_width;
 
-	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
-	domain_reserve_special_ranges(domain);
-
 	/* calculate AGAW */
 	domain->gaw = guest_width;
 	adjust_width = guestwidth_to_adjustwidth(guest_width);
@@ -5342,11 +5306,21 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	return 0;
 }
 
+static void intel_init_iova_domain(struct dmar_domain *dmar_domain)
+{
+	init_iova_domain(&dmar_domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
+	copy_reserved_iova(&reserved_iova_list, &dmar_domain->iovad);
+
+	if (!intel_iommu_strict && init_iova_flush_queue(&dmar_domain->iovad,
+				iommu_flush_iova, iova_entry_free)) {
+		pr_info("iova flush queue initialization failed\n");
+	}
+}
+
 static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
-	int ret;
 
 	switch (type) {
 	case IOMMU_DOMAIN_DMA:
@@ -5363,13 +5337,8 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 			return NULL;
 		}
 
-		if (!intel_iommu_strict && type == IOMMU_DOMAIN_DMA) {
-			ret = init_iova_flush_queue(&dmar_domain->iovad,
-						    iommu_flush_iova,
-						    iova_entry_free);
-			if (ret)
-				pr_info("iova flush queue initialization failed\n");
-		}
+		if (type == IOMMU_DOMAIN_DMA)
+			intel_init_iova_domain(dmar_domain);
 
 		domain_update_iommu_cap(dmar_domain);
 
-- 
2.20.1

