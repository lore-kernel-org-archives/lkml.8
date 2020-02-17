Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D78C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4027F20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgBQTjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:39:10 -0500
Received: from 8bytes.org ([81.169.241.247]:54520 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbgBQTjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:39:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 106255BB; Mon, 17 Feb 2020 20:39:07 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iommu/vt-d: Do deferred attachment in iommu_need_mapping()
Date:   Mon, 17 Feb 2020 20:38:56 +0100
Message-Id: <20200217193858.26990-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217193858.26990-1-joro@8bytes.org>
References: <20200217193858.26990-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The attachment of deferred devices needs to happen before the check
whether the device is identity mapped or not. Otherwise the check will
return wrong results, cause warnings boot failures in kdump kernels, like

	WARNING: CPU: 0 PID: 318 at ../drivers/iommu/intel-iommu.c:592 domain_get_iommu+0x61/0x70

	[...]

	 Call Trace:
	  __intel_map_single+0x55/0x190
	  intel_alloc_coherent+0xac/0x110
	  dmam_alloc_attrs+0x50/0xa0
	  ahci_port_start+0xfb/0x1f0 [libahci]
	  ata_host_start.part.39+0x104/0x1e0 [libata]

With the earlier check the kdump boot succeeds and a crashdump is written.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 42cdcce1602e..32f43695a22b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2541,9 +2541,6 @@ static void do_deferred_attach(struct device *dev)
 
 static struct dmar_domain *deferred_attach_domain(struct device *dev)
 {
-	if (unlikely(attach_deferred(dev)))
-		do_deferred_attach(dev);
-
 	return find_domain(dev);
 }
 
@@ -3595,6 +3592,9 @@ static bool iommu_need_mapping(struct device *dev)
 	if (iommu_dummy(dev))
 		return false;
 
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
+
 	ret = identity_mapping(dev);
 	if (ret) {
 		u64 dma_mask = *dev->dma_mask;
-- 
2.17.1

