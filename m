Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5F3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5466C206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgEOJpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbgEOJpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:45:22 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFF6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:45:22 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 428AA379; Fri, 15 May 2020 11:45:20 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH] iommu: Implement deferred domain attachment
Date:   Fri, 15 May 2020 11:45:19 +0200
Message-Id: <20200515094519.20338-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The IOMMU core code has support for deferring the attachment of a domain
to a device. This is needed in kdump kernels where the new domain must
not be attached to a device before the device driver takes it over.

But this needs support from the dma-ops code too, to actually do the
late attachment when there are DMA-API calls for the device. This got
lost in the AMD IOMMU driver after converting it to the dma-iommu code.

Do the late attachment in the dma-iommu code-path to fix the issue.

Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Tom Murphy <murphyt7@tcd.ie>
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-iommu api")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4050569188be..f54ebb964271 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1889,13 +1889,19 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
-static int __iommu_attach_device(struct iommu_domain *domain,
-				 struct device *dev)
+static bool __iommu_is_attach_deferred(struct iommu_domain *domain,
+				       struct device *dev)
+{
+	if (!domain->ops->is_attach_deferred)
+		return false;
+
+	return domain->ops->is_attach_deferred(domain, dev);
+}
+
+static int __iommu_attach_device_no_defer(struct iommu_domain *domain,
+					  struct device *dev)
 {
 	int ret;
-	if ((domain->ops->is_attach_deferred != NULL) &&
-	    domain->ops->is_attach_deferred(domain, dev))
-		return 0;
 
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
@@ -1903,9 +1909,19 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	ret = domain->ops->attach_dev(domain, dev);
 	if (!ret)
 		trace_attach_device_to_domain(dev);
+
 	return ret;
 }
 
+static int __iommu_attach_device(struct iommu_domain *domain,
+				 struct device *dev)
+{
+	if (__iommu_is_attach_deferred(domain, dev))
+		return 0;
+
+	return __iommu_attach_device_no_defer(domain, dev);
+}
+
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
@@ -2023,7 +2039,12 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
  */
 struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 {
-	return dev->iommu_group->default_domain;
+	struct iommu_domain *domain = dev->iommu_group->default_domain;
+
+	if (__iommu_is_attach_deferred(domain, dev))
+		__iommu_attach_device_no_defer(domain, dev);
+
+	return domain;
 }
 
 /*
-- 
2.25.1

