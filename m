Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A537C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ACDC20780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468107;
	bh=+kFvMppVPhbb1Jbt3yVA+kAco1Bh+AKTYk60GeSAHeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XNuLimciwV/Bxlplmz21rRDC5SOBH0H5Pn1RyNzIMmY6QaP6ivG5MI/svmF1kDYZx
	 JqOh+x7Js8X/TLbTzAOkj2ESpoDOggSP9PGol/c/cqM7Gp2QCFrkDJ6cmjOBId32U6
	 /Q/Ia8lo/UnTosQ75JoY/noD5v4AzQapdcj9J5O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbgF2WBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgF2SfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B8A3246EE;
        Mon, 29 Jun 2020 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444034;
        bh=+kFvMppVPhbb1Jbt3yVA+kAco1Bh+AKTYk60GeSAHeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfcFr44IHwtqW740QHre5TD7xZZNhGDD/D3bOUM6b7sGfuk4M0vQPdEauHkZCfm5X
         1zgsBvICU1G/1XKen09CWlNh7CIr3SJjawvxQJD2VATWvFLXwOFZlxafuXrpfCjQSf
         6nckHmlURt2swsoZzJQoKm3fUTf+TeNWUbj+VEgw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, Xin Zeng <xin.zeng@intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 142/265] iommu/vt-d: Set U/S bit in first level page table by default
Date:   Mon, 29 Jun 2020 11:16:15 -0400
Message-Id: <20200629151818.2493727-143-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 16ecf10e815d70d11d2300243f4a3b4c7c5acac7 ]

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
Link: https://lore.kernel.org/r/20200622231345.29722-3-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 5 ++---
 include/linux/intel-iommu.h | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fde7aba49b746..a0b9ea0805210 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -943,7 +943,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			domain_flush_cache(domain, tmp_page, VTD_PAGE_SIZE);
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
 			if (domain_use_first_level(domain))
-				pteval |= DMA_FL_PTE_XD;
+				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				free_pgtable_page(tmp_page);
@@ -2034,7 +2034,6 @@ static inline void
 context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
 {
 	context->hi |= pasid & ((1 << 20) - 1);
-	context->hi |= (1 << 20);
 }
 
 /*
@@ -2326,7 +2325,7 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	if (domain_use_first_level(domain))
-		attr |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD;
+		attr |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD | DMA_FL_PTE_US;
 
 	if (!sg) {
 		sg_res = nr_pages;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index de23fb95fe918..64a5335046b00 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -40,6 +40,7 @@
 #define DMA_PTE_SNP		BIT_ULL(11)
 
 #define DMA_FL_PTE_PRESENT	BIT_ULL(0)
+#define DMA_FL_PTE_US		BIT_ULL(2)
 #define DMA_FL_PTE_XD		BIT_ULL(63)
 
 #define CONTEXT_TT_MULTI_LEVEL	0
-- 
2.25.1

