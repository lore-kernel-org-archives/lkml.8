Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741ABC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A8A2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgENMqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726037AbgENMqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:46:25 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F27C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:46:24 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9035C452; Thu, 14 May 2020 14:46:22 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, jroedel@suse.de, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 1/2] iommu/sun50i: Fix compile warnings
Date:   Thu, 14 May 2020 14:46:20 +0200
Message-Id: <20200514124621.25999-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

A few compile warnings show up when building this driver:

  CC      drivers/iommu/sun50i-iommu.o
drivers/iommu/sun50i-iommu.c: In function ‘sun50i_dte_get_page_table’:
drivers/iommu/sun50i-iommu.c:486:16: warning: unused variable ‘flags’ [-Wunused-variable]
  486 |  unsigned long flags;
      |                ^~~~~
drivers/iommu/sun50i-iommu.c: In function ‘sun50i_iommu_unmap’:
drivers/iommu/sun50i-iommu.c:559:23: warning: unused variable ‘iommu’ [-Wunused-variable]
  559 |  struct sun50i_iommu *iommu = sun50i_domain->iommu;
      |                       ^~~~~
drivers/iommu/sun50i-iommu.c: In function ‘sun50i_iommu_probe_device’:
drivers/iommu/sun50i-iommu.c:749:22: warning: unused variable ‘group’ [-Wunused-variable]
  749 |  struct iommu_group *group;
      |                      ^~~~~

Remove the unused variables.

Cc: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/sun50i-iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 989d87aa4426..a52f52eff7c8 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -483,7 +483,6 @@ static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
 				      dma_addr_t iova, gfp_t gfp)
 {
 	struct sun50i_iommu *iommu = sun50i_domain->iommu;
-	unsigned long flags;
 	u32 *page_table;
 	u32 *dte_addr;
 	u32 old_dte;
@@ -556,7 +555,6 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
 				 size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
-	struct sun50i_iommu *iommu = sun50i_domain->iommu;
 	phys_addr_t pt_phys;
 	dma_addr_t pte_dma;
 	u32 *pte_addr;
@@ -746,7 +744,6 @@ static int sun50i_iommu_attach_device(struct iommu_domain *domain,
 static struct iommu_device *sun50i_iommu_probe_device(struct device *dev)
 {
 	struct sun50i_iommu *iommu;
-	struct iommu_group *group;
 
 	iommu = sun50i_iommu_from_dev(dev);
 	if (!iommu)
-- 
2.17.1

