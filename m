Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B1EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDED20719
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgCQHFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:05:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:56620 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQHFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:05:20 -0400
IronPort-SDR: b8CSbeRJ6avH5t3QDaD2q6I5ZMTfOggcysQuHjn5IHT9vIo5KkjJU+O76djm1rxVPwvJKjAD6E
 qOu8dkrIrHyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 00:05:20 -0700
IronPort-SDR: euLO8sSn0WdMq6uEbXARhMqDPjY3JRm8a/aNHlhhPjjz8fpjbWpSFva1RxoMKf8OT0BFNoUnSV
 rZkghJ6qt02A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="267867327"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 00:05:17 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/5] iommu/vt-d: Refactor parameters for qi_submit_sync()
Date:   Tue, 17 Mar 2020 15:02:26 +0800
Message-Id: <20200317070229.21131-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317070229.21131-1-baolu.lu@linux.intel.com>
References: <20200317070229.21131-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current qi_submit_sync() supports single invalidation descriptor
per submission and appends wait descriptor after each submission
to poll hardware completion. This patch adjusts the parameters
of this function so that multiple descriptors per submission can
be supported.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c                | 20 ++++++++++++--------
 drivers/iommu/intel-pasid.c         |  4 ++--
 drivers/iommu/intel-svm.c           |  6 +++---
 drivers/iommu/intel_irq_remapping.c |  2 +-
 include/linux/intel-iommu.h         |  6 +++++-
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index f77dae7ba7d4..dc9f9449907c 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1224,10 +1224,14 @@ static int qi_check_fault(struct intel_iommu *iommu, int index)
 }
 
 /*
- * Submit the queued invalidation descriptor to the remapping
- * hardware unit and wait for its completion.
+ * Function to submit invalidation descriptors of all types to the queued
+ * invalidation interface(QI). Multiple descriptors can be submitted at a
+ * time, a wait descriptor will be appended to each submission to ensure
+ * hardware has completed the invalidation before return. Wait descriptors
+ * can be part of the submission but it will not be polled for completion.
  */
-int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
+int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
+		   unsigned int count, unsigned long options)
 {
 	int rc;
 	struct q_inval *qi = iommu->qi;
@@ -1317,7 +1321,7 @@ void qi_global_iec(struct intel_iommu *iommu)
 	desc.qw3 = 0;
 
 	/* should never fail */
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
@@ -1331,7 +1335,7 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
@@ -1355,7 +1359,7 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
@@ -1377,7 +1381,7 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 /* PASID-based IOTLB invalidation */
@@ -1418,7 +1422,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 				QI_EIOTLB_AM(mask);
 	}
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 /*
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 692e808e1a4e..7e50db07b277 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -370,7 +370,7 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 static void
@@ -384,7 +384,7 @@ iotlb_invalidation_with_pasid(struct intel_iommu *iommu, u16 did, u32 pasid)
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(&desc, iommu);
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 static void
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 1148f7994747..6183016f4269 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -138,7 +138,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 	}
 	desc.qw2 = 0;
 	desc.qw3 = 0;
-	qi_submit_sync(&desc, svm->iommu);
+	qi_submit_sync(svm->iommu, &desc, 1, 0);
 
 	if (sdev->dev_iotlb) {
 		desc.qw0 = QI_DEV_EIOTLB_PASID(svm->pasid) |
@@ -162,7 +162,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 		}
 		desc.qw2 = 0;
 		desc.qw3 = 0;
-		qi_submit_sync(&desc, svm->iommu);
+		qi_submit_sync(svm->iommu, &desc, 1, 0);
 	}
 }
 
@@ -644,7 +644,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 				       sizeof(req->priv_data));
 			resp.qw2 = 0;
 			resp.qw3 = 0;
-			qi_submit_sync(&resp, iommu);
+			qi_submit_sync(iommu, &resp, 1, 0);
 		}
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 81e43c1df7ec..a042f123b091 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -151,7 +151,7 @@ static int qi_flush_iec(struct intel_iommu *iommu, int index, int mask)
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	return qi_submit_sync(&desc, iommu);
+	return qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 static int modify_irte(struct irq_2_iommu *irq_iommu,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index a29b464e937b..e9190ffbd013 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -655,7 +655,11 @@ extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask);
 void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 		     unsigned long npages, bool ih);
-extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
+int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
+		   unsigned int count, unsigned long options);
+/* Options used in qi_submit_sync */
+#define QI_OPT_WAIT_DRAIN	BIT(0)	/* Wait for PRQ drain completion,
+					   spec 6.5.2.8 */
 
 extern int dmar_ir_support(void);
 
-- 
2.17.1

