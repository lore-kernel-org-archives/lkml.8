Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B979C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD0C20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgESNDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:03:50 -0400
Received: from 8bytes.org ([81.169.241.247]:43902 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbgESNDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:03:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D58C3386; Tue, 19 May 2020 15:03:48 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Joerg Roedel <jroedel@suse.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Tom Murphy <murphyt7@tcd.ie>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu: Fix deferred domain attachment
Date:   Tue, 19 May 2020 15:03:40 +0200
Message-Id: <20200519130340.14564-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The IOMMU core code has support for deferring the attachment of a domain
to a device. This is needed in kdump kernels where the new domain must
not be attached to a device before the device driver takes it over.

When the AMD IOMMU driver got converted to use the dma-iommu
implementation, the deferred attaching got lost. The code in
dma-iommu.c has support for deferred attaching, but it calls into
iommu_attach_device() to actually do it. But iommu_attach_device()
will check if the device should be deferred in it code-path and do
nothing, breaking deferred attachment.

Move the is_deferred_attach() check out of the attach_device path and
into iommu_group_add_device() to make deferred attaching work from the
dma-iommu code.

Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Tom Murphy <murphyt7@tcd.ie>
Cc: Robin Murphy <robin.murphy@arm.com>
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: 795bbbb9b6f8 ("iommu/dma-iommu: Handle deferred devices")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4050569188be..629d209b8e88 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -769,6 +769,15 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 	return ret;
 }
 
+static bool iommu_is_attach_deferred(struct iommu_domain *domain,
+				     struct device *dev)
+{
+	if (domain->ops->is_attach_deferred)
+		return domain->ops->is_attach_deferred(domain, dev);
+
+	return false;
+}
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
@@ -821,7 +830,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain)
+	if (group->domain  && !iommu_is_attach_deferred(group->domain, dev))
 		ret = __iommu_attach_device(group->domain, dev);
 	mutex_unlock(&group->mutex);
 	if (ret)
@@ -1893,9 +1902,6 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	int ret;
-	if ((domain->ops->is_attach_deferred != NULL) &&
-	    domain->ops->is_attach_deferred(domain, dev))
-		return 0;
 
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
@@ -1967,8 +1973,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	if ((domain->ops->is_attach_deferred != NULL) &&
-	    domain->ops->is_attach_deferred(domain, dev))
+	if (iommu_is_attach_deferred(domain, dev))
 		return;
 
 	if (unlikely(domain->ops->detach_dev == NULL))
-- 
2.25.1

