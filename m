Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACD7C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4DB2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgH0PIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:08:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:30258 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgH0PHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:07:19 -0400
IronPort-SDR: VhIx9J/u5UoQ1gdkKFkomHcD0fuBFr6rXtj3yH6GFfq7VSO1xPumgI+hkXZeRXQmlv3ZaCHMSZ
 IIJyI0YKpjJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136563657"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="136563657"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 08:07:00 -0700
IronPort-SDR: 5iWFj7LdX/DYg6s2cCgFzAavsgCvohV07HFPm268lGJlNHnjGRdDLrZki56Dm8kXNb9hMbQlc0
 J2OquSTpIN3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="332212874"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2020 08:07:00 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
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
Subject: [PATCH v7 9/9] x86/mmu: Allocate/free PASID
Date:   Thu, 27 Aug 2020 08:06:34 -0700
Message-Id: <1598540794-132666-10-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A PASID is allocated for an "mm" the first time any thread binds
to an SVM capable device and is freed from the "mm" when the SVM is
unbound by the last thread. It's possible for the "mm" to have different
PASID values in different binding/unbinding SVM cycles.

The mm's PASID (non-zero for valid PASID or 0 for invalid PASID) is
propagated to per-thread PASID MSR for all threads within the mm through
through IPI, context switch, or inherit to ensure a running thread has
the right PASID MSR matching the mm's PASID.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v7:
- Don't fix up PASID in #GP. Instead, update the PASID MSR by IPI and
  context switch after PASID allocation and free. Inherit PASID from
  parent. (Andy)

Before v7:
- Allocate a PASID for the mm and free it until mm exit.

 arch/x86/include/asm/disabled-features.h |  2 +-
 arch/x86/include/asm/fpu/api.h           | 12 +++++
 arch/x86/include/asm/fpu/internal.h      |  2 +
 arch/x86/kernel/fpu/xstate.c             | 56 ++++++++++++++++++++++++
 drivers/iommu/intel/svm.c                | 28 +++++++++++-
 5 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 588d83e9da49..5861d34f9771 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -56,7 +56,7 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
+#ifdef CONFIG_IOMMU_SUPPORT
 # define DISABLE_ENQCMD	0
 #else
 # define DISABLE_ENQCMD (1 << (X86_FEATURE_ENQCMD & 31))
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index b774c52e5411..dcd9503b1098 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -62,4 +62,16 @@ extern void switch_fpu_return(void);
  */
 extern int cpu_has_xfeatures(u64 xfeatures_mask, const char **feature_name);
 
+/*
+ * Tasks that are not using SVA have mm->pasid set to zero to note that they
+ * will not have the valid bit set in MSR_IA32_PASID while they are running.
+ */
+#define PASID_DISABLED	0
+
+#ifdef CONFIG_IOMMU_SUPPORT
+/* Update current's PASID MSR/state by mm's PASID. */
+void update_pasid(void);
+#else
+static inline void update_pasid(void) { }
+#endif
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 0a460f2a3f90..2d737e02b59a 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -583,6 +583,8 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 			pkru_val = pk->pkru;
 	}
 	__write_pkru(pkru_val);
+
+	update_pasid();
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 67f1a03b9b23..556040e14f1c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1402,3 +1402,59 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
 	return 0;
 }
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
+
+#ifdef CONFIG_IOMMU_SUPPORT
+void update_pasid(void)
+{
+	u64 pasid_state;
+	u32 pasid;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return;
+
+	if (!current->mm)
+		return;
+
+	pasid = READ_ONCE(current->mm->pasid);
+	/* Set the valid bit in the PASID MSR/state only for valid pasid. */
+	pasid_state = pasid == PASID_DISABLED ?
+		      pasid : pasid | MSR_IA32_PASID_VALID;
+
+	/*
+	 * No need to hold fregs_lock() since the task's fpstate won't
+	 * be changed by others (e.g. ptrace) while the task is being
+	 * switched to or is in IPI.
+	 */
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		/* The MSR is active and can be directly updated. */
+		wrmsrl(MSR_IA32_PASID, pasid_state);
+	} else {
+		struct fpu *fpu = &current->thread.fpu;
+		struct ia32_pasid_state *ppasid_state;
+		struct xregs_state *xsave;
+
+		/*
+		 * The CPU's xstate registers are not currently active. Just
+		 * update the PASID state in the memory buffer here. The
+		 * PASID MSR will be loaded when returning to user mode.
+		 */
+		xsave = &fpu->state.xsave;
+		xsave->header.xfeatures |= XFEATURE_MASK_PASID;
+		ppasid_state = get_xsave_addr(xsave, XFEATURE_PASID);
+		if (ppasid_state) {
+			/*
+			 * Only update the task's PASID state when it's
+			 * different from the mm's pasid.
+			 */
+			if (ppasid_state->pasid != pasid_state) {
+				/*
+				 * Invalid fpregs so that xrstors will pick up
+				 * the PASID state.
+				 */
+				__fpu_invalidate_fpregs_state(fpu);
+				ppasid_state->pasid = pasid_state;
+			}
+		}
+	}
+}
+#endif /* CONFIG_IOMMU_SUPPORT */
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index fc90a079e228..60ffe083b6d6 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -19,6 +19,7 @@
 #include <linux/mm_types.h>
 #include <linux/ioasid.h>
 #include <asm/page.h>
+#include <asm/fpu/api.h>
 
 #include "pasid.h"
 
@@ -444,6 +445,24 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 	return ret;
 }
 
+static void _load_pasid(void *unused)
+{
+	update_pasid();
+}
+
+static void load_pasid(struct mm_struct *mm, u32 pasid)
+{
+	mutex_lock(&mm->context.lock);
+
+	/* Synchronize with READ_ONCE in update_pasid(). */
+	smp_store_release(&mm->pasid, pasid);
+
+	/* Update PASID MSR on all CPUs running the mm's tasks. */
+	on_each_cpu_mask(mm_cpumask(mm), _load_pasid, NULL, true);
+
+	mutex_unlock(&mm->context.lock);
+}
+
 /* Caller must hold pasid_mutex, mm reference */
 static int
 intel_svm_bind_mm(struct device *dev, unsigned int flags,
@@ -591,6 +610,10 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 		}
 
 		list_add_tail(&svm->list, &global_svm_list);
+		if (mm) {
+			/* The newly allocated pasid is loaded to the mm. */
+			load_pasid(mm, svm->pasid);
+		}
 	} else {
 		/*
 		 * Binding a new device with existing PASID, need to setup
@@ -654,8 +677,11 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 
 			if (list_empty(&svm->devs)) {
 				ioasid_free(svm->pasid);
-				if (svm->mm)
+				if (svm->mm) {
 					mmu_notifier_unregister(&svm->notifier, svm->mm);
+					/* Clear mm's pasid. */
+					load_pasid(svm->mm, PASID_DISABLED);
+				}
 				list_del(&svm->list);
 				/* We mandate that no page faults may be outstanding
 				 * for the PASID when intel_svm_unbind_mm() is called.
-- 
2.19.1

