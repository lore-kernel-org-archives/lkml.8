Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 348C5206F5
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgFMAmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 20:42:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:1255 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgFMAlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 20:41:55 -0400
IronPort-SDR: tPmAmZ62pWiRmO27ZABh391loHF1E4S8MHxdAp9rpjF8w7Yf0CgkyQJej+g8OrRQN045uRph2L
 Dh98wDUY8Vkw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 17:41:54 -0700
IronPort-SDR: y1W5s1PdoPGthqigwR6gl/wKpYbXke+DgChLCJKD3F7dEv1RVPJRBkzePrFb0Bap6FzewIHKWT
 47T+yxuCfyjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,505,1583222400"; 
   d="scan'208";a="261011236"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2020 17:41:53 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Frederic Barrat" <fbarrat@linux.ibm.com>,
        "Andrew Donnellan" <ajd@linux.ibm.com>,
        "Felix Kuehling" <Felix.Kuehling@amd.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        "amd-gfx" <amd-gfx@lists.freedesktop.org>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 11/12] x86/mmu: Allocate/free PASID
Date:   Fri, 12 Jun 2020 17:41:32 -0700
Message-Id: <1592008893-9388-12-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A PASID is allocated for an "mm" the first time any thread attaches
to an SVM capable device. Later device attachments (whether to the same
device or another SVM device) will re-use the same PASID.

The PASID is freed when the process exits (so no need to keep
reference counts on how many SVM devices are sharing the PASID).

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Define a helper free_bind() to simplify error exit code in bind_mm()
  (Thomas)
- Fix a ret error code in bind_mm() (Thomas)
- Change pasid's type from "int" to "unsigned int" to have consistent
  pasid type in iommu (Thomas)
- Simplify alloc_pasid() a bit.

 arch/x86/include/asm/iommu.h       |   2 +
 arch/x86/include/asm/mmu_context.h |  14 ++++
 drivers/iommu/intel/svm.c          | 101 +++++++++++++++++++++++++----
 3 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index bf1ed2ddc74b..ed41259fe7ac 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -26,4 +26,6 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 	return -EINVAL;
 }
 
+void __free_pasid(struct mm_struct *mm);
+
 #endif /* _ASM_X86_IOMMU_H */
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 47562147e70b..f8c91ce8c451 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -13,6 +13,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
+#include <asm/iommu.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -117,9 +118,22 @@ static inline int init_new_context(struct task_struct *tsk,
 	init_new_context_ldt(mm);
 	return 0;
 }
+
+static inline void free_pasid(struct mm_struct *mm)
+{
+	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
+		return;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return;
+
+	__free_pasid(mm);
+}
+
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
+	free_pasid(mm);
 }
 
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 4e775e12ae52..27dc866b8461 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -425,6 +425,53 @@ int intel_svm_unbind_gpasid(struct device *dev, unsigned int pasid)
 	return ret;
 }
 
+static void free_bind(struct intel_svm *svm, struct intel_svm_dev *sdev,
+		      bool new_pasid)
+{
+	if (new_pasid)
+		ioasid_free(svm->pasid);
+	kfree(svm);
+	kfree(sdev);
+}
+
+/*
+ * If this mm already has a PASID, use it. Otherwise allocate a new one.
+ * Let the caller know if a new PASID is allocated via 'new_pasid'.
+ */
+static int alloc_pasid(struct intel_svm *svm, struct mm_struct *mm,
+		       unsigned int pasid_max, bool *new_pasid,
+		       unsigned int flags)
+{
+	unsigned int pasid;
+
+	*new_pasid = false;
+
+	/*
+	 * Reuse the PASID if the mm already has a PASID and not a private
+	 * PASID is requested.
+	 */
+	if (mm && mm->pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
+		/*
+		 * Once a PASID is allocated for this mm, the PASID
+		 * stays with the mm until the mm is dropped. Reuse
+		 * the PASID which has been already allocated for the
+		 * mm instead of allocating a new one.
+		 */
+		ioasid_set_data(mm->pasid, svm);
+
+		return mm->pasid;
+	}
+
+	/* Allocate a new pasid. Do not use PASID 0, reserved for init PASID. */
+	pasid = ioasid_alloc(NULL, PASID_MIN, pasid_max - 1, svm);
+	if (pasid != INVALID_IOASID) {
+		/* A new pasid is allocated. */
+		*new_pasid = true;
+	}
+
+	return pasid;
+}
+
 /* Caller must hold pasid_mutex, mm reference */
 static int
 intel_svm_bind_mm(struct device *dev, unsigned int flags,
@@ -518,6 +565,8 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 	init_rcu_head(&sdev->rcu);
 
 	if (!svm) {
+		bool new_pasid;
+
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm) {
 			ret = -ENOMEM;
@@ -529,12 +578,9 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (pasid_max > intel_pasid_max_id)
 			pasid_max = intel_pasid_max_id;
 
-		/* Do not use PASID 0, reserved for RID to PASID */
-		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
-					  pasid_max - 1, svm);
+		svm->pasid = alloc_pasid(svm, mm, pasid_max, &new_pasid, flags);
 		if (svm->pasid == INVALID_IOASID) {
-			kfree(svm);
-			kfree(sdev);
+			free_bind(svm, sdev, new_pasid);
 			ret = -ENOSPC;
 			goto out;
 		}
@@ -547,9 +593,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				ioasid_free(svm->pasid);
-				kfree(svm);
-				kfree(sdev);
+				free_bind(svm, sdev, new_pasid);
 				goto out;
 			}
 		}
@@ -565,12 +609,18 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			ioasid_free(svm->pasid);
-			kfree(svm);
-			kfree(sdev);
+			free_bind(svm, sdev, new_pasid);
 			goto out;
 		}
 
+		if (mm && new_pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
+			/*
+			 * Track the new pasid in the mm. The pasid will be
+			 * freed at process exit. Don't track requested
+			 * private PASID in the mm.
+			 */
+			mm->pasid = svm->pasid;
+		}
 		list_add_tail(&svm->list, &global_svm_list);
 	} else {
 		/*
@@ -640,7 +690,8 @@ static int intel_svm_unbind_mm(struct device *dev, unsigned int pasid)
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-				ioasid_free(svm->pasid);
+				/* Clear data in the pasid. */
+				ioasid_set_data(pasid, NULL);
 				if (svm->mm)
 					mmu_notifier_unregister(&svm->notifier, svm->mm);
 				list_del(&svm->list);
@@ -1001,3 +1052,29 @@ unsigned int intel_svm_get_pasid(struct iommu_sva *sva)
 
 	return pasid;
 }
+
+/*
+ * An invalid pasid is either 0 (init PASID value) or bigger than max PASID
+ * (PASID_MAX - 1).
+ */
+static bool invalid_pasid(unsigned int pasid)
+{
+	return (pasid == INIT_PASID) || (pasid >= PASID_MAX);
+}
+
+/* On process exit free the PASID (if one was allocated). */
+void __free_pasid(struct mm_struct *mm)
+{
+	unsigned int pasid = mm->pasid;
+
+	/* No need to free invalid pasid. */
+	if (invalid_pasid(pasid))
+		return;
+
+	/*
+	 * Since the pasid is not bound to any svm by now, there is no race
+	 * here with binding/unbinding and no need to protect the free
+	 * operation by pasid_mutex.
+	 */
+	ioasid_free(pasid);
+}
-- 
2.19.1

