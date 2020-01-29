Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9C1C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4772063A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgA2F5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:57:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:55027 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgA2F4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:56:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 21:56:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,376,1574150400"; 
   d="scan'208";a="252500717"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2020 21:56:53 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/3] iommu/uapi: Use unified UAPI version
Date:   Tue, 28 Jan 2020 22:02:03 -0800
Message-Id: <1580277724-66994-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse UAPI version for each UAPI data structure.
This is to avoid supporting multiple version combinations, simplify
support model as we bump up the versions.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 drivers/iommu/intel-svm.c   | 2 +-
 drivers/iommu/iommu.c       | 3 ++-
 include/uapi/linux/iommu.h  | 9 +++------
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b3778e86dc32..b17b338ada34 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5763,8 +5763,9 @@ static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
 	int ret = 0;
 	u64 size;
 
+	/* Support current or older UAPI versions */
 	if (!inv_info || !dmar_domain ||
-		inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+		inv_info->version > IOMMU_UAPI_VERSION)
 		return -EINVAL;
 
 	if (!dev || !dev_is_pci(dev))
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 7a87d2e2e0ad..c756b43e959c 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -239,7 +239,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain,
 	if (WARN_ON(!iommu) || !data)
 		return -EINVAL;
 
-	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
+	if (data->version > IOMMU_UAPI_VERSION ||
 	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
 		return -EINVAL;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fdd40756dbc1..7dd51c5d2ba1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1094,7 +1094,8 @@ int iommu_page_response(struct device *dev,
 	if (!param || !param->fault_param)
 		return -EINVAL;
 
-	if (msg->version != IOMMU_PAGE_RESP_VERSION_1 ||
+	/* Support current or older UAPI versions */
+	if (msg->version > IOMMU_UAPI_VERSION ||
 	    msg->flags & ~IOMMU_PAGE_RESP_PASID_VALID)
 		return -EINVAL;
 
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 65a26c2519ee..5e410761dfa3 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -183,7 +183,7 @@ enum iommu_page_response_code {
 
 /**
  * struct iommu_page_response - Generic page response information
- * @version: API version of this structure
+ * @version: IOMMU_UAPI_VERSION
  * @flags: encodes whether the corresponding fields are valid
  *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
  * @pasid: Process Address Space ID
@@ -191,7 +191,6 @@ enum iommu_page_response_code {
  * @code: response code from &enum iommu_page_response_code
  */
 struct iommu_page_response {
-#define IOMMU_PAGE_RESP_VERSION_1	1
 	__u32	version;
 #define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
 	__u32	flags;
@@ -266,7 +265,7 @@ struct iommu_inv_pasid_info {
 /**
  * struct iommu_cache_invalidate_info - First level/stage invalidation
  *     information
- * @version: API version of this structure
+ * @version: IOMMU_UAPI_VERSION
  * @cache: bitfield that allows to select which caches to invalidate
  * @granularity: defines the lowest granularity used for the invalidation:
  *     domain > PASID > addr
@@ -294,7 +293,6 @@ struct iommu_inv_pasid_info {
  * must support the used granularity.
  */
 struct iommu_cache_invalidate_info {
-#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
 	__u32	version;
 /* IOMMU paging structure cache */
 #define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
@@ -338,7 +336,7 @@ struct iommu_gpasid_bind_data_vtd {
 					 IOMMU_SVA_VTD_GPASID_PWT)
 /**
  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
- * @version:	Version of this data structure
+ * @version:	IOMMU_UAPI_VERSION
  * @format:	PASID table entry format
  * @flags:	Additional information on guest bind request
  * @gpgd:	Guest page directory base of the guest mm to bind
@@ -355,7 +353,6 @@ struct iommu_gpasid_bind_data_vtd {
  * PASID to host PASID based on this bind data.
  */
 struct iommu_gpasid_bind_data {
-#define IOMMU_GPASID_BIND_VERSION_1	1
 	__u32 version;
 #define IOMMU_PASID_FORMAT_INTEL_VTD	1
 	__u32 format;
-- 
2.7.4

