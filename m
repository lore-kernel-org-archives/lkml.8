Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C874DC34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F7020578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgBQTjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:39:09 -0500
Received: from 8bytes.org ([81.169.241.247]:54508 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgBQTjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:39:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BE1CF28C; Mon, 17 Feb 2020 20:39:06 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] iommu/vt-d: Add attach_deferred() helper
Date:   Mon, 17 Feb 2020 20:38:54 +0100
Message-Id: <20200217193858.26990-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217193858.26990-1-joro@8bytes.org>
References: <20200217193858.26990-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Implement a helper function to check whether a device's attach process
is deferred.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9dc37672bf89..80f2332a5466 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -762,6 +762,11 @@ static int iommu_dummy(struct device *dev)
 	return dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO;
 }
 
+static bool attach_deferred(struct device *dev)
+{
+	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
+}
+
 /**
  * is_downstream_to_pci_bridge - test if a device belongs to the PCI
  *				 sub-hierarchy of a candidate PCI-PCI bridge
@@ -2510,8 +2515,7 @@ struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
 
-	if (unlikely(dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO ||
-		     dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO))
+	if (unlikely(attach_deferred(dev) || iommu_dummy(dev)))
 		return NULL;
 
 	if (dev_is_pci(dev))
@@ -2527,7 +2531,7 @@ struct dmar_domain *find_domain(struct device *dev)
 
 static struct dmar_domain *deferred_attach_domain(struct device *dev)
 {
-	if (unlikely(dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO)) {
+	if (unlikely(attach_deferred(dev))) {
 		struct iommu_domain *domain;
 
 		dev->archdata.iommu = NULL;
@@ -6133,7 +6137,7 @@ intel_iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
 					   struct device *dev)
 {
-	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
+	return attach_deferred(dev);
 }
 
 static int
-- 
2.17.1

