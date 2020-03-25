Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E67C2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EC62076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCYXLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:11:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:3368 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbgCYXLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:11:25 -0400
IronPort-SDR: acbVRKwsqd8jjsA9EcdrrR8Z76lv2zO9wLhxDUlzpu7AsHe/wW63YnlJ54DnlVaT4SDqb2zMd1
 qspXUvnG0HqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 16:11:24 -0700
IronPort-SDR: q1SfkvZ/eKjh21PLtsAMc9gjXTkvpsc68UU2/mRAJlJVCfyeGhTw56vpaYrL2GVtkx0J0w0q4z
 OlX+tXSt+WwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="236083689"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2020 16:11:24 -0700
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
Subject: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Date:   Wed, 25 Mar 2020 16:17:05 -0700
Message-Id: <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a single UAPI version to govern the user-kernel data structures
makes compatibility check straightforward. On the contrary, supporting
combinations of multiple versions of the data can be a nightmare to
maintain.

This patch defines a unified UAPI version to be used for compatibility
checks between user and kernel.

---
v2: Rewrite extension rules to disallow adding new members. Use padding
    and union extensions only.
---

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lkml.org/lkml/2020/2/3/1126
---
 include/uapi/linux/iommu.h | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index d7bcbc5f79b0..25dba9198d7f 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -8,6 +8,59 @@
 
 #include <linux/types.h>
 
+/**
+ * Current version of the IOMMU user API. This is intended for query
+ * between user and kernel to determine compatible data structures.
+ *
+ * UAPI version can be bumped up with the following rules:
+ * 1. All data structures passed between user and kernel space share
+ *    the same version number. i.e. any extension to any structure
+ *    results in version number increment.
+ *
+ * 2. Data structures are open to extension but closed to modification.
+ *    Extensions are allowed in two places:
+ *    - the padding bytes with a flag bit for each new member
+ *    - new union members at the end of each structure
+ *
+ *    No new members can be added after padding bytes are exhausted.
+ *    The reason is that the union size can change when new members are
+ *    added, having new member at the end would break backward
+ *    compatibility. Expansion of the union would move the new member
+ *    to different offset between versions.
+ *
+ *    Flag bits can be added without size change but existing ones
+ *    cannot be altered.
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

