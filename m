Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6EAC433ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C138D2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgGWRTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:19:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:65337 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgGWRS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:18:59 -0400
IronPort-SDR: kZeC23CbNRUZu4iFDGGvVB7dIzT8e2HPeL5/IORbtWCZX+ciD9OndIGX/xJ+z/3wsHdHbcE6Jh
 0aRVgrhi7wUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="151880960"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="151880960"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:18:55 -0700
IronPort-SDR: ExcwVTzxLEuD/HVlpZ1q0sbjaxqlTodJYNPsAp2vhjmjli8oXw3xdb2pQuJ288T/CU0MlaMi31
 P/sQ8bRgrSKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="462933854"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2020 10:18:55 -0700
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
Subject: [PATCH v6 4/6] iommu/uapi: Rename uapi functions
Date:   Thu, 23 Jul 2020 10:25:38 -0700
Message-Id: <1595525140-23899-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595525140-23899-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1595525140-23899-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User APIs such as iommu_sva_unbind_gpasid() may also be used by the
kernel. Since we introduced user pointer to the UAPI functions,
in-kernel callers cannot share the same APIs. In-kernel callers are also
trusted, there is no need to validate the data.

This patch renames all UAPI functions with iommu_uapi_ prefix such that
is clear to the intended callers.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 18 +++++++++---------
 include/linux/iommu.h | 31 ++++++++++++++++---------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b6858adc4f17..3a913ce94a3d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1950,35 +1950,35 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
-int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
-			   struct iommu_cache_invalidate_info *inv_info)
+int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct device *dev,
+				struct iommu_cache_invalidate_info *inv_info)
 {
 	if (unlikely(!domain->ops->cache_invalidate))
 		return -ENODEV;
 
 	return domain->ops->cache_invalidate(domain, dev, inv_info);
 }
-EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
+EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
 
-int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-			   struct device *dev, struct iommu_gpasid_bind_data *data)
+int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+			       struct device *dev, struct iommu_gpasid_bind_data *data)
 {
 	if (unlikely(!domain->ops->sva_bind_gpasid))
 		return -ENODEV;
 
 	return domain->ops->sva_bind_gpasid(domain, dev, data);
 }
-EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
+EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
 
-int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid)
+int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+				 ioasid_t pasid)
 {
 	if (unlikely(!domain->ops->sva_unbind_gpasid))
 		return -ENODEV;
 
 	return domain->ops->sva_unbind_gpasid(dev, pasid);
 }
-EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
+EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
 
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5f0b7859d2eb..2dcc1a33f6dc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -430,13 +430,13 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
-extern int iommu_cache_invalidate(struct iommu_domain *domain,
-				  struct device *dev,
-				  struct iommu_cache_invalidate_info *inv_info);
-extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-		struct device *dev, struct iommu_gpasid_bind_data *data);
-extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-				struct device *dev, ioasid_t pasid);
+extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
+				       struct device *dev,
+				       struct iommu_cache_invalidate_info *inv_info);
+extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+				      struct device *dev, struct iommu_gpasid_bind_data *data);
+extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
+					struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -1054,21 +1054,22 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return IOMMU_PASID_INVALID;
 }
 
-static inline int
-iommu_cache_invalidate(struct iommu_domain *domain,
-		       struct device *dev,
-		       struct iommu_cache_invalidate_info *inv_info)
+static inline int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
+					      struct device *dev,
+					      struct iommu_cache_invalidate_info *inv_info)
 {
 	return -ENODEV;
 }
-static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-				struct device *dev, struct iommu_gpasid_bind_data *data)
+
+static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+					     struct device *dev,
+					     struct iommu_gpasid_bind_data *data)
 {
 	return -ENODEV;
 }
 
-static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-					   struct device *dev, int pasid)
+static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
+					       struct device *dev, int pasid)
 {
 	return -ENODEV;
 }
-- 
2.7.4

