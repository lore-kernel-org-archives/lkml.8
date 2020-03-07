Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF95AC10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32B02070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCGGXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 01:23:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:29697 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgCGGXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 01:23:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 22:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,525,1574150400"; 
   d="scan'208";a="352915154"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2020 22:23:13 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH 2/6] iommu: Configure default domain with dev_def_domain_type
Date:   Sat,  7 Mar 2020 14:20:10 +0800
Message-Id: <20200307062014.3288-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200307062014.3288-1-baolu.lu@linux.intel.com>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With dev_def_domain_type introduced, iommu default domain framework
is now able to determine a proper default domain for a group. Let's
use this to configure a group's default domain.

If unlikely a device requires a special default domain type other
than that in use, iommu probe procedure will either allocate a new
domain according to the specified domain type, or (if the group has
other devices sitting in it) change the default domain. The vendor
iommu driver which exposes the dev_def_domain_type callback should
guarantee that there're no multiple devices belonging to a same
group requires differnt types of default domain.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 93 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3e3528436e0b..095e0bc563c4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1361,6 +1361,79 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
+/**
+ * Changes the default domain of a group
+ *
+ * @group: The group for which the default domain should be changed
+ * @type: The new default domain type
+ *
+ * The caller should hold the group->mutex before call into this function.
+ * Returns 0 on success and error code on failure.
+ */
+static int iommu_group_change_def_domain(struct iommu_group *group, int type)
+{
+	struct group_device *grp_dev, *temp;
+	struct iommu_domain *new, *old;
+	const struct iommu_ops *ops;
+	int ret = 0;
+
+	if ((type != IOMMU_DOMAIN_IDENTITY && type != IOMMU_DOMAIN_DMA) ||
+	    !group->default_domain || type == group->default_domain->type ||
+	    !group->default_domain->ops)
+		return -EINVAL;
+
+	if (group->domain != group->default_domain)
+		return -EBUSY;
+
+	iommu_group_ref_get(group);
+	old = group->default_domain;
+	ops = group->default_domain->ops;
+
+	/* Allocate a new domain of requested type. */
+	new = ops->domain_alloc(type);
+	if (!new) {
+		ret = -ENOMEM;
+		goto domain_out;
+	}
+	new->type = type;
+	new->ops = ops;
+	new->pgsize_bitmap = group->default_domain->pgsize_bitmap;
+
+	group->default_domain = new;
+	group->domain = new;
+	list_for_each_entry_safe(grp_dev, temp, &group->devices, list) {
+		struct device *dev;
+
+		dev = grp_dev->dev;
+		if (device_is_bound(dev)) {
+			ret = -EINVAL;
+			goto device_out;
+		}
+
+		iommu_group_create_direct_mappings(group, dev);
+		ret = __iommu_attach_device(group->domain, dev);
+		if (ret)
+			goto device_out;
+
+		ret = ops->add_device(dev);
+		if (ret)
+			goto device_out;
+	}
+
+	iommu_group_put(group);
+	iommu_domain_free(old);
+
+	return 0;
+
+device_out:
+	group->default_domain = old;
+	__iommu_attach_group(old, group);
+	iommu_domain_free(new);
+domain_out:
+	iommu_group_put(group);
+	return ret;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -1375,6 +1448,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_group *group;
+	int dev_def_type = 0;
 	int ret;
 
 	group = iommu_group_get(dev);
@@ -1391,20 +1465,24 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (IS_ERR(group))
 		return group;
 
+	if (ops->dev_def_domain_type)
+		dev_def_type = ops->dev_def_domain_type(dev);
+
 	/*
 	 * Try to allocate a default domain - needs support from the
 	 * IOMMU driver.
 	 */
 	if (!group->default_domain) {
 		struct iommu_domain *dom;
+		int type = dev_def_type ? : iommu_def_domain_type;
 
-		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
-		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
+		dom = __iommu_domain_alloc(dev->bus, type);
+		if (!dom && type != IOMMU_DOMAIN_DMA) {
 			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
 			if (dom) {
 				dev_warn(dev,
 					 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
-					 iommu_def_domain_type);
+					 type);
 			}
 		}
 
@@ -1418,6 +1496,15 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 					      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 					      &attr);
 		}
+	} else if (dev_def_type &&
+		   dev_def_type != group->default_domain->type) {
+		mutex_lock(&group->mutex);
+		ret = iommu_group_change_def_domain(group, dev_def_type);
+		mutex_unlock(&group->mutex);
+		if (ret) {
+			iommu_group_put(group);
+			return ERR_PTR(ret);
+		}
 	}
 
 	ret = iommu_group_add_device(group, dev);
-- 
2.17.1

