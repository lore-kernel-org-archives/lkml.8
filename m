Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D405EC33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63B02063A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgA2F45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:56:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:55027 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgA2F4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:56:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 21:56:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,376,1574150400"; 
   d="scan'208";a="252500713"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2020 21:56:52 -0800
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
Subject: [PATCH 1/3] iommu/uapi: Define uapi version and capabilities
Date:   Tue, 28 Jan 2020 22:02:02 -0800
Message-Id: <1580277724-66994-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a unified UAPI version to be used for compatibility
checks between user and kernel.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/uapi/linux/iommu.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index fcafb6401430..65a26c2519ee 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -8,6 +8,54 @@
 
 #include <linux/types.h>
 
+/**
+ * Current version of the IOMMU user API. This is intended for query
+ * between user and kernel to determine compatible data structures.
+ *
+ * Having a single UAPI version to govern the user-kernel data structures
+ * makes compatibility check straightforward. On the contrary, supporting
+ * combinations of multiple versions of the data can be a nightmare.
+ *
+ * UAPI version can be bumped up with the following rules:
+ * 1. All data structures passed between user and kernel space share
+ *    the same version number. i.e. any extension to to any structure
+ *    results in version bump up.
+ *
+ * 2. Data structures are open to extension but closed to modification.
+ *    New fields must be added at the end of each data structure with
+ *    64bit alignment. Flag bits can be added without size change but
+ *    existing ones cannot be altered.
+ *
+ * 3. Versions are backward compatible.
+ *
+ * 4. Version to size lookup is supported by kernel internal API for each
+ *    API function type. @version is mandatory for new data structures
+ *    and must be at the beginning with type of __u32.
+ */
+#define IOMMU_UAPI_VERSION	1
+static inline int iommu_get_uapi_version(void)
+{
+	return IOMMU_UAPI_VERSION;
+}
+
+/*
+ * Supported UAPI features that can be reported to user space.
+ * These types represent the capability available in the kernel.
+ *
+ * REVISIT: UAPI version also implies the capabilities. Should we
+ * report them explicitly?
+ */
+enum IOMMU_UAPI_DATA_TYPES {
+	IOMMU_UAPI_BIND_GPASID,
+	IOMMU_UAPI_CACHE_INVAL,
+	IOMMU_UAPI_PAGE_RESP,
+	NR_IOMMU_UAPI_TYPE,
+};
+
+#define IOMMU_UAPI_CAP_MASK ((1 << IOMMU_UAPI_BIND_GPASID) |	\
+				(1 << IOMMU_UAPI_CACHE_INVAL) |	\
+				(1 << IOMMU_UAPI_PAGE_RESP))
+
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
 #define IOMMU_FAULT_PERM_EXEC	(1 << 2) /* exec */
-- 
2.7.4

