Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83515C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DCA2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgA2F5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:57:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:55027 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgA2F4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:56:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 21:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,376,1574150400"; 
   d="scan'208";a="252500720"
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
Subject: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Date:   Tue, 28 Jan 2020 22:02:04 -0800
Message-Id: <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU UAPI can be extended in the future by adding new
fields at the end of each user data structure. Since we use
a unified UAPI version for compatibility checking, a lookup
function is needed to find the correct user data size to copy
from user.

This patch adds a helper function based on a 2D lookup with
version and type as input arguments.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
 include/linux/iommu.h |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7dd51c5d2ba1..9e5de9abebdf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1696,6 +1696,28 @@ int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
 
+
+/**
+ * Maintain a UAPI version to user data structure size lookup for each
+ * API function types we support. e.g. bind guest pasid, cache invalidation.
+ * As data structures being extended with new members, the offsetofend()
+ * will identify the new sizes.
+ */
+const static int iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
+	/* IOMMU_UAPI_BIND_GPASID */
+	{offsetofend(struct iommu_gpasid_bind_data, vtd)},
+	/* IOMMU_UAPI_CACHE_INVAL */
+	{offsetofend(struct iommu_cache_invalidate_info, addr_info)},
+	/* IOMMU_UAPI_PAGE_RESP */
+	{offsetofend(struct iommu_page_response, code)},
+};
+
+int iommu_uapi_get_data_size(int type, int version)
+{
+	return iommu_uapi_data_size[type][version - 1];
+}
+EXPORT_SYMBOL_GPL(iommu_uapi_get_data_size);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9718c109ea0a..416fe02160ba 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -500,6 +500,7 @@ extern int iommu_report_device_fault(struct device *dev,
 				     struct iommu_fault_event *evt);
 extern int iommu_page_response(struct device *dev,
 			       struct iommu_page_response *msg);
+extern int iommu_uapi_get_data_size(int type, int version);
 
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
@@ -885,6 +886,11 @@ static inline int iommu_page_response(struct device *dev,
 	return -ENODEV;
 }
 
+static int iommu_uapi_get_data_size(int type, int version)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_group_id(struct iommu_group *group)
 {
 	return -ENODEV;
-- 
2.7.4

