Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB16C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC5324649
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgBMOA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:00:27 -0500
Received: from foss.arm.com ([217.140.110.172]:46972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbgBMOA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:00:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69FF91045;
        Thu, 13 Feb 2020 06:00:26 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B800D3F68F;
        Thu, 13 Feb 2020 06:00:25 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Use C99 flexible array in fwspec
Date:   Thu, 13 Feb 2020 14:00:21 +0000
Message-Id: <7364595699c37d2ef53636c8af6dcefa6602529b.1581601149.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the 1-element array was a typical pre-C99 way to implement
variable-length structures, and indeed is a fundamental construct in the
APIs of certain other popular platforms, there's no good reason for it
here (and in particular the sizeof() trick is far too "clever" for its
own good). We can just as easily implement iommu_fwspec's preallocation
behaviour using a standard flexible array member, so let's make it look
the way most readers would expect.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Before the Coccinelle police catch up with me... :)

Deliberately no fixes tag, since the original code predates
struct_size(), and it's really just a cosmetic cleanup that
shouldn't be backported anyway.

Robin.

 drivers/iommu/iommu.c | 15 ++++++++-------
 include/linux/iommu.h |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3e3528436e0b..660eea8d1d2f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2405,7 +2405,8 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	if (fwspec)
 		return ops == fwspec->ops ? 0 : -EINVAL;
 
-	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
+	/* Preallocate for the overwhelmingly common case of 1 ID */
+	fwspec = kzalloc(struct_size(fwspec, ids, 1), GFP_KERNEL);
 	if (!fwspec)
 		return -ENOMEM;
 
@@ -2432,15 +2433,15 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_free);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	size_t size;
-	int i;
+	int i, new_num;
 
 	if (!fwspec)
 		return -EINVAL;
 
-	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
-	if (size > sizeof(*fwspec)) {
-		fwspec = krealloc(fwspec, size, GFP_KERNEL);
+	new_num = fwspec->num_ids + num_ids;
+	if (new_num > 1) {
+		fwspec = krealloc(fwspec, struct_size(fwspec, ids, new_num),
+				  GFP_KERNEL);
 		if (!fwspec)
 			return -ENOMEM;
 
@@ -2450,7 +2451,7 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	for (i = 0; i < num_ids; i++)
 		fwspec->ids[fwspec->num_ids + i] = ids[i];
 
-	fwspec->num_ids += num_ids;
+	fwspec->num_ids = new_num;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d1b5f4d98569..4d1ba76c9a64 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -592,7 +592,7 @@ struct iommu_fwspec {
 	u32			flags;
 	u32			num_pasid_bits;
 	unsigned int		num_ids;
-	u32			ids[1];
+	u32			ids[];
 };
 
 /* ATS is supported */
-- 
2.23.0.dirty

