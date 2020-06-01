Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92903C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7766D20707
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgFAAqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 20:46:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:52794 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgFAAqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 20:46:54 -0400
IronPort-SDR: QjL2VCy4MmzzfZ8kFAFWAUZsDTBQGzqozM0Uy59wWLcnA1wPkzSHvDUVBkAD+ayLvLdFOippvF
 wzmuwxwLM2+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 17:46:53 -0700
IronPort-SDR: GQtx93VAMaSLCC31dmUOm3aMg7qk79+vJYaHmfTlFPXKOvfat3EauqRW7ik2Uk6IBzZz1LGR+P
 1n4PhgAmUODw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,458,1583222400"; 
   d="scan'208";a="293005929"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 31 May 2020 17:46:52 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Set U/S bit in first level page table by default
Date:   Mon,  1 Jun 2020 08:42:57 +0800
Message-Id: <20200601004257.15591-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601004257.15591-1-baolu.lu@linux.intel.com>
References: <20200601004257.15591-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using first-level translation for IOVA, currently the U/S bit in the
page table is cleared which implies DMA requests with user privilege are
blocked. As the result, following error messages might be observed when
passing through a device to user level:

DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Read] Request device [41:00.0] PASID 1 fault addr 7ecdcd000
	[fault reason 129] SM: U/S set 0 for first-level translation
	with user privilege

This fixes it by setting U/S bit in the first level page table and makes
IOVA over first level compatible with previous second-level translation.

Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
Reported-by: Xin Zeng <xin.zeng@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 5 ++---
 include/linux/intel-iommu.h | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 648a785e078a..d148712466b4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -921,7 +921,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			domain_flush_cache(domain, tmp_page, VTD_PAGE_SIZE);
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
 			if (domain_use_first_level(domain))
-				pteval |= DMA_FL_PTE_XD;
+				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				free_pgtable_page(tmp_page);
@@ -1951,7 +1951,6 @@ static inline void
 context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
 {
 	context->hi |= pasid & ((1 << 20) - 1);
-	context->hi |= (1 << 20);
 }
 
 /*
@@ -2243,7 +2242,7 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	if (domain_use_first_level(domain))
-		attr |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD;
+		attr |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD | DMA_FL_PTE_US;
 
 	if (!sg) {
 		sg_res = nr_pages;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4100bd224f5c..3e8fa1c7a1e6 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -41,6 +41,7 @@
 #define DMA_PTE_SNP		BIT_ULL(11)
 
 #define DMA_FL_PTE_PRESENT	BIT_ULL(0)
+#define DMA_FL_PTE_US		BIT_ULL(2)
 #define DMA_FL_PTE_XD		BIT_ULL(63)
 
 #define ADDR_WIDTH_5LEVEL	(57)
-- 
2.17.1

