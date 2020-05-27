Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86695C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E931207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbgE0LyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbgE0Lx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:53:26 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D5C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:53:26 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 802793C3; Wed, 27 May 2020 13:53:23 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        jroedel@suse.de
Subject: [PATCH 02/10] iommu/amd: Unexport get_dev_data()
Date:   Wed, 27 May 2020 13:53:05 +0200
Message-Id: <20200527115313.7426-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This function is internal to the AMD IOMMU driver and only exported
because the amd_iommu_v2 modules calls it. But the reason it is called
from there could better be handled by amd_iommu_is_attach_deferred().
So unexport get_dev_data() and use amd_iommu_is_attach_deferred()
instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/amd_iommu_proto.h |  3 ++-
 drivers/iommu/amd/iommu.c           |  9 +++++----
 drivers/iommu/amd/iommu_v2.c        | 10 ++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_proto.h b/drivers/iommu/amd/amd_iommu_proto.h
index 92c2ba6468a0..1c6c12c11368 100644
--- a/drivers/iommu/amd/amd_iommu_proto.h
+++ b/drivers/iommu/amd/amd_iommu_proto.h
@@ -92,5 +92,6 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 }
 
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
-extern struct iommu_dev_data *get_dev_data(struct device *dev);
+extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
+					 struct device *dev);
 #endif /* _ASM_X86_AMD_IOMMU_PROTO_H  */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 39155f550f18..8368f6b9c17f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -280,11 +280,10 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
 	return dev_data;
 }
 
-struct iommu_dev_data *get_dev_data(struct device *dev)
+static struct iommu_dev_data *get_dev_data(struct device *dev)
 {
 	return dev->archdata.iommu;
 }
-EXPORT_SYMBOL(get_dev_data);
 
 /*
 * Find or create an IOMMU group for a acpihid device.
@@ -2706,12 +2705,14 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	list_add_tail(&region->list, head);
 }
 
-static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
-					 struct device *dev)
+bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
+				  struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev->archdata.iommu;
+
 	return dev_data->defer_attach;
 }
+EXPORT_SYMBOL_GPL(amd_iommu_is_attach_deferred);
 
 static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index d6d85debd01b..9b6e038150c1 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -517,13 +517,12 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 	struct amd_iommu_fault *iommu_fault;
 	struct pasid_state *pasid_state;
 	struct device_state *dev_state;
+	struct pci_dev *pdev = NULL;
 	unsigned long flags;
 	struct fault *fault;
 	bool finish;
 	u16 tag, devid;
 	int ret;
-	struct iommu_dev_data *dev_data;
-	struct pci_dev *pdev = NULL;
 
 	iommu_fault = data;
 	tag         = iommu_fault->tag & 0x1ff;
@@ -534,12 +533,11 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 					   devid & 0xff);
 	if (!pdev)
 		return -ENODEV;
-	dev_data = get_dev_data(&pdev->dev);
 
-	/* In kdump kernel pci dev is not initialized yet -> send INVALID */
 	ret = NOTIFY_DONE;
-	if (translation_pre_enabled(amd_iommu_rlookup_table[devid])
-		&& dev_data->defer_attach) {
+
+	/* In kdump kernel pci dev is not initialized yet -> send INVALID */
+	if (amd_iommu_is_attach_deferred(NULL, &pdev->dev)) {
 		amd_iommu_complete_ppr(pdev, iommu_fault->pasid,
 				       PPR_INVALID, tag);
 		goto out;
-- 
2.17.1

