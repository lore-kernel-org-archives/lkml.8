Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E99C2BA15
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F4E2137B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgC3UiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:38:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:58490 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbgC3UiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:38:02 -0400
IronPort-SDR: wIfoZEopgK+WXgnKGPQfAVvBo4pXKFarzHcZ3RsYZ9vqIJrfsQeEjh8mlJQ3yKA1rB44tP0OyP
 VTWappuNd0lQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 13:38:02 -0700
IronPort-SDR: lOeLI3VDsd31E+phTpBFTRG7fAoB5GKJIqAAfyFLNnyhxWlVvej5OTnHeQOzJ1f2DW51fhegCz
 Eo61jjwUaRig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="242143884"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2020 13:38:01 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 5/7] x86/mmu: Allocate/free PASID
Date:   Mon, 30 Mar 2020 12:33:06 -0700
Message-Id: <1585596788-193989-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PASID is shared by all threads in a process. So the logical place to keep
track of it is in the "mm". Add the field to the architecture specific
mm_context_t structure.

A PASID is allocated for an "mm" the first time any thread attaches
to an SVM capable device. Later device atatches (whether to the same
device or another SVM device) will re-use the same PASID.

The PASID is freed when the process exits (so no need to keep
reference counts on how many SVM devices are sharing the PASID).

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/iommu.h       |  2 +
 arch/x86/include/asm/mmu.h         |  4 ++
 arch/x86/include/asm/mmu_context.h | 14 +++++
 drivers/iommu/intel-svm.c          | 82 +++++++++++++++++++++++++++---
 4 files changed, 94 insertions(+), 8 deletions(-)

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
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index bdeae9291e5c..137bf51f19e6 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -50,6 +50,10 @@ typedef struct {
 	u16 pkey_allocation_map;
 	s16 execute_only_pkey;
 #endif
+
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	int pasid;
+#endif
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b538d9ddee9c..1c020c7955e6 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -13,6 +13,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
+#include <asm/iommu.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -129,9 +130,22 @@ static inline int init_new_context(struct task_struct *tsk,
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
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index d7f2a5358900..da718a49e91e 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -226,6 +226,45 @@ static LIST_HEAD(global_svm_list);
 	list_for_each_entry((sdev), &(svm)->devs, list)	\
 		if ((d) != (sdev)->dev) {} else
 
+/*
+ * If this mm already has a PASID we can use it. Otherwise allocate a new one.
+ * Let the caller know if we did an allocation via 'new_pasid'.
+ */
+static int alloc_pasid(struct intel_svm *svm, struct mm_struct *mm,
+		       int pasid_max,  bool *new_pasid, int flags)
+{
+	int pasid;
+
+	/*
+	 * Reuse the PASID if the mm already has a PASID and not a private
+	 * PASID is requested.
+	 */
+	if (mm && mm->context.pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
+		/*
+		 * Once a PASID is allocated for this mm, the PASID
+		 * stays with the mm until the mm is dropped. Reuse
+		 * the PASID which has been already allocated for the
+		 * mm instead of allocating a new one.
+		 */
+		ioasid_set_data(mm->context.pasid, svm);
+		*new_pasid = false;
+
+		return mm->context.pasid;
+	}
+
+	/*
+	 * Allocate a new pasid. Do not use PASID 0, reserved for RID to
+	 * PASID.
+	 */
+	pasid = ioasid_alloc(NULL, PASID_MIN, pasid_max - 1, svm);
+	if (pasid == INVALID_IOASID)
+		return -ENOSPC;
+
+	*new_pasid = true;
+
+	return pasid;
+}
+
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
@@ -324,6 +363,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	init_rcu_head(&sdev->rcu);
 
 	if (!svm) {
+		bool new_pasid;
+
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm) {
 			ret = -ENOMEM;
@@ -335,15 +376,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (pasid_max > intel_pasid_max_id)
 			pasid_max = intel_pasid_max_id;
 
-		/* Do not use PASID 0, reserved for RID to PASID */
-		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
-					  pasid_max - 1, svm);
-		if (svm->pasid == INVALID_IOASID) {
+		svm->pasid = alloc_pasid(svm, mm, pasid_max, &new_pasid, flags);
+		if (svm->pasid < 0) {
 			kfree(svm);
 			kfree(sdev);
-			ret = -ENOSPC;
 			goto out;
 		}
+
 		svm->notifier.ops = &intel_mmuops;
 		svm->mm = mm;
 		svm->flags = flags;
@@ -353,7 +392,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				ioasid_free(svm->pasid);
+				if (new_pasid)
+					ioasid_free(svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -371,12 +411,21 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			ioasid_free(svm->pasid);
+			if (new_pasid)
+				ioasid_free(svm->pasid);
 			kfree(svm);
 			kfree(sdev);
 			goto out;
 		}
 
+		if (mm && new_pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
+			/*
+			 * Track the new pasid in the mm. The pasid will be
+			 * freed at process exit. Don't track requested
+			 * private PASID in the mm.
+			 */
+			mm->context.pasid = svm->pasid;
+		}
 		list_add_tail(&svm->list, &global_svm_list);
 	} else {
 		/*
@@ -447,7 +496,8 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-				ioasid_free(svm->pasid);
+				/* Clear data in the pasid. */
+				ioasid_set_data(pasid, NULL);
 				if (svm->mm)
 					mmu_notifier_unregister(&svm->notifier, svm->mm);
 				list_del(&svm->list);
@@ -693,3 +743,19 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 	return IRQ_RETVAL(handled);
 }
+
+/* On process exit free the PASID (if one was allocated). */
+void __free_pasid(struct mm_struct *mm)
+{
+	int pasid = mm->context.pasid;
+
+	if (!pasid)
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

