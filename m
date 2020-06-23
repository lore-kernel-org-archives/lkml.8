Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07FDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBB12076E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbgFWQ5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:57:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:50069 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733087AbgFWQ53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:57:29 -0400
IronPort-SDR: y/xpvPA4U+KeRRZbBJ3LAKHy+kr0wVcuAbcg4DcydJ+u/zGQ6opJwL9SYRiRcLxE8Eb/Rv6oRR
 QuEV2c5Q8Edg==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="205653761"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="205653761"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 09:57:28 -0700
IronPort-SDR: 6rWLdZr1MKX8EfLVte3qQNbQid/YwBhoEz3m5KJY/1rFE3Xc29LibDl1t9Y51wu8UPYQ8YPgtV
 uCJtSU+2Q5EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="452290905"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 09:57:28 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 5/5] iommu/uapi: Support both kernel and user unbind guest PASID
Date:   Tue, 23 Jun 2020 10:03:57 -0700
Message-Id: <1592931837-58223-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest SVA unbind data can come from either kernel and user space, if a
user pointer is passed in, IOMMU driver must copy from data from user.
If the unbind data is assembled in kernel, data can be trusted and
directly used. This patch creates a wrapper for unbind gpasid such that
user pointer can be parsed and sanitized before calling into the kernel
unbind function. Common user data copy code also consolidated.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 70 ++++++++++++++++++++++++++++++++++++++-------------
 include/linux/iommu.h | 13 ++++++++--
 2 files changed, 64 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4a025c429b41..595527e4c6b7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2010,19 +2010,15 @@ int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
 
-int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
-						void __user *udata)
-{
 
-	struct iommu_gpasid_bind_data data;
+static int iommu_sva_prepare_bind_data(void __user *udata, bool bind,
+				       struct iommu_gpasid_bind_data *data)
+{
 	unsigned long minsz, maxsz;
 
-	if (unlikely(!domain->ops->sva_bind_gpasid))
-		return -ENODEV;
-
 	/* Current kernel data size is the max to be copied from user */
 	maxsz = sizeof(struct iommu_gpasid_bind_data);
-	memset((void *)&data, 0, maxsz);
+	memset((void *)data, 0, maxsz);
 
 	/*
 	 * No new spaces can be added before the variable sized union, the
@@ -2031,11 +2027,11 @@ int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
 
 	/* Copy minsz from user to get flags and argsz */
-	if (copy_from_user(&data, udata, minsz))
+	if (copy_from_user(data, udata, minsz))
 		return -EFAULT;
 
 	/* Fields before variable size union is mandatory */
-	if (data.argsz < minsz)
+	if (data->argsz < minsz)
 		return -EINVAL;
 	/*
 	 * User might be using a newer UAPI header, we shall let IOMMU vendor
@@ -2043,26 +2039,66 @@ int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	 * can be vendor specific, larger argsz could be the result of extension
 	 * for one vendor but it should not affect another vendor.
 	 */
-	if (data.argsz > maxsz)
-		data.argsz = maxsz;
+	if (data->argsz > maxsz)
+		data->argsz = maxsz;
+
+	/*
+	 * For unbind, we don't need any extra data, host PASID is included in
+	 * the minsz and that is all we need.
+	 */
+	if (!bind)
+		return 0;
 
 	/* Copy the remaining user data _after_ minsz */
-	if (copy_from_user((void *)&data + minsz, udata + minsz,
-				data.argsz - minsz))
+	if (copy_from_user((void *)data + minsz, udata + minsz,
+				data->argsz - minsz))
 		return -EFAULT;
 
+	return 0;
+}
+
+int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
+						void __user *udata)
+{
+
+	struct iommu_gpasid_bind_data data;
+	int ret;
+
+	if (unlikely(!domain->ops->sva_bind_gpasid))
+		return -ENODEV;
+
+	ret = iommu_sva_prepare_bind_data(udata, true, &data);
+	if (ret)
+		return ret;
 
 	return domain->ops->sva_bind_gpasid(domain, dev, &data);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
 
-int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid)
+int __iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+			struct iommu_gpasid_bind_data *data)
 {
 	if (unlikely(!domain->ops->sva_unbind_gpasid))
 		return -ENODEV;
 
-	return domain->ops->sva_unbind_gpasid(dev, pasid);
+	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
+}
+EXPORT_SYMBOL_GPL(__iommu_sva_unbind_gpasid);
+
+int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+			void __user *udata)
+{
+	struct iommu_gpasid_bind_data data;
+	int ret;
+
+	if (unlikely(!domain->ops->sva_bind_gpasid))
+		return -ENODEV;
+
+	ret = iommu_sva_prepare_bind_data(udata, false, &data);
+	if (ret)
+		return ret;
+
+	return __iommu_sva_unbind_gpasid(domain, dev, &data);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a688fea42ae5..2567c33dc4e8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -437,7 +437,9 @@ extern int iommu_cache_invalidate(struct iommu_domain *domain,
 extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
 				struct device *dev, void __user *udata);
 extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-				struct device *dev, ioasid_t pasid);
+				struct device *dev, void __user *udata);
+extern int __iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+				struct device *dev, struct iommu_gpasid_bind_data *data);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -1069,7 +1071,14 @@ static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
 }
 
 static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-					   struct device *dev, int pasid)
+					   struct device *dev, void __user *udata)
+{
+	return -ENODEV;
+}
+
+static inline int __iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+					struct device *dev,
+					struct iommu_gpasid_bind_data *data)
 {
 	return -ENODEV;
 }
-- 
2.7.4

