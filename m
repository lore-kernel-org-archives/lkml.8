Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC333C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD17420838
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCYXL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:11:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:3368 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgCYXL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:11:26 -0400
IronPort-SDR: oYh1NAl4pzjbPRjHimL+xxwg7hnwKIJXwq/fBGc+rm/6Mq180ty85zjvi91Eb8rnF4W4Bxi0wz
 Dkpnom6/3Mig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 16:11:25 -0700
IronPort-SDR: 0JhoBzWNGABgRwjt/Yz2DNVfBwqniP12x6oT0GKNf8CgrEOGDaQ4JrlGTd9uCiFfTPHnIvzF6A
 QOVX6pcb0y5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="236083698"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2020 16:11:25 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 3/3] iommu/uapi: Add helper function for size lookup
Date:   Wed, 25 Mar 2020 16:17:07 -0700
Message-Id: <1585178227-17061-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
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

---
v2: Clarify size lookup array extension rules, backfill -EINVAL
    if new version introduce new union members.
---

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  6 +++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c476b58e0ffb..e91ced212653 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1724,6 +1724,78 @@ int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
 
+
+/**
+ * Maintain a UAPI version to user data structure size lookup for each
+ * API function types we support. e.g. bind guest pasid, cache invalidation.
+ * As data structures being extended with new members, offsetofend() is
+ * used to identify the size. In case of adding a new member to a union,
+ * offsetofend() applies to the largest member which may not be the newest.
+ *
+ * When new types are introduced with new versions, the new types for older
+ * version must be filled with -EINVAL.
+ *
+ * The table below documents UAPI revision history with the name of the
+ * newest member of each data structure. The largest member of a union was
+ * used for the initial version of each type.
+ *
+ * +--------------+---------------+
+ * | Type /       |       V1      |
+ * | UAPI Version |               |
+ * +==============+===============+
+ * | BIND_GPASID  |       vtd     |
+ * +--------------+---------------+
+ * | CACHE_INVAL  |  addr_info    |
+ * +--------------+---------------+
+ * | PAGE_RESP    |  code         |
+ * +--------------+---------------+
+ *
+ * Examples of future extensions:
+ * V2 addes new member to the union
+ * +--------------+---------------+---------------+
+ * | Type /       |       V1      |      V2       |
+ * | UAPI Version |               |               |
+ * +==============+===============+===============+
+ * | BIND_GPASID  |       vtd     |      smmu_v3  |
+ * +--------------+---------------+---------------+
+ * | CACHE_INVAL  |  addr_info    |     new_info  |
+ * +--------------+---------------+---------------+
+ * | PAGE_RESP    |  code         |     N/A       |
+ * +--------------+---------------+---------------+
+ *
+ * V3 introduces a new UAPI data type: NEW_TYPE but with no new members
+ * added to the existing types.
+ * +--------------+---------------+---------------+---------------+
+ * | Type /       |       V1      |      V2       |      V3       |
+ * | UAPI Version |               |               |               |
+ * +==============+===============+===============+===============+
+ * | BIND_GPASID  |       vtd     |      smmu_v3  |       N/A     |
+ * +--------------+---------------+---------------+---------------+
+ * | CACHE_INVAL  |  addr_info    |    new_info   |       N/A     |
+ * +--------------+---------------+---------------+---------------+
+ * | PAGE_RESP    |  code         |    N/A        |       N/A     |
+ * +--------------+---------------+---------------+---------------+
+ * | NEW_TYPE     |  -EINVAL      |     -EINVAL   | largest_member|
+ * +--------------+---------------+---------------+---------------+
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
+	if (type >= NR_IOMMU_UAPI_TYPE || version > IOMMU_UAPI_VERSION)
+		return -EINVAL;
+
+	return iommu_uapi_data_size[type][version - 1];
+}
+EXPORT_SYMBOL_GPL(iommu_uapi_get_data_size);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d1b5f4d98569..4908919a98f1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -510,6 +510,7 @@ extern int iommu_report_device_fault(struct device *dev,
 				     struct iommu_fault_event *evt);
 extern int iommu_page_response(struct device *dev,
 			       struct iommu_page_response *msg);
+extern int iommu_uapi_get_data_size(int type, int version);
 
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
@@ -897,6 +898,11 @@ static inline int iommu_page_response(struct device *dev,
 	return -ENODEV;
 }
 
+static inline int iommu_uapi_get_data_size(int type, int version)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_group_id(struct iommu_group *group)
 {
 	return -ENODEV;
-- 
2.7.4

