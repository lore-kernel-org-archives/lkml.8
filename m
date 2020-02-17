Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B201CC34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971AE20656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgBQTjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:39:09 -0500
Received: from 8bytes.org ([81.169.241.247]:54526 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgBQTjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:39:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3973D608; Mon, 17 Feb 2020 20:39:07 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] iommu/vt-d: Remove deferred_attach_domain()
Date:   Mon, 17 Feb 2020 20:38:57 +0100
Message-Id: <20200217193858.26990-5-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217193858.26990-1-joro@8bytes.org>
References: <20200217193858.26990-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function is now only a wrapper around find_domain(). Remove the
function and call find_domain() directly at the call-sites.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 32f43695a22b..16e47ca505eb 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2539,11 +2539,6 @@ static void do_deferred_attach(struct device *dev)
 		intel_iommu_attach_device(domain, dev);
 }
 
-static struct dmar_domain *deferred_attach_domain(struct device *dev)
-{
-	return find_domain(dev);
-}
-
 static inline struct device_domain_info *
 dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
 {
@@ -3643,7 +3638,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	domain = deferred_attach_domain(dev);
+	domain = find_domain(dev);
 	if (!domain)
 		return DMA_MAPPING_ERROR;
 
@@ -3863,7 +3858,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	if (!iommu_need_mapping(dev))
 		return dma_direct_map_sg(dev, sglist, nelems, dir, attrs);
 
-	domain = deferred_attach_domain(dev);
+	domain = find_domain(dev);
 	if (!domain)
 		return 0;
 
@@ -3958,7 +3953,7 @@ bounce_map_single(struct device *dev, phys_addr_t paddr, size_t size,
 	int prot = 0;
 	int ret;
 
-	domain = deferred_attach_domain(dev);
+	domain = find_domain(dev);
 	if (WARN_ON(dir == DMA_NONE || !domain))
 		return DMA_MAPPING_ERROR;
 
-- 
2.17.1

