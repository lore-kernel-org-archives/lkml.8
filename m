Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D697C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34903217BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgFQSYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:24:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:18901 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgFQSY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:24:28 -0400
IronPort-SDR: gjx0L7pE6+oTkJwjZ/QjzetFNXu3V5w5g0tTulhv0Rt6EUPlWZtymqMttIjzLE3DWGDcrHBK+/
 47Nbpab0WF3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 11:24:19 -0700
IronPort-SDR: F/o2axyca0ISrPq9xn00rStEHbjsKZjlWrlWYGlCYA6SflwF2+s/BMrE1Pk/Q0nrowUyekxcmn
 INNoGLbUnx9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="308874196"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga008.jf.intel.com with ESMTP; 17 Jun 2020 11:24:18 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradeed.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 13/13] x86/traps: Fix up invalid PASID
Date:   Wed, 17 Jun 2020 11:23:53 -0700
Message-Id: <1592418233-17762-14-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A #GP fault is generated when ENQCMD instruction is executed without
a valid PASID value programmed in the current thread's PASID MSR. The
#GP fault handler will initialize the MSR if a PASID has been allocated
for this process.

Decoding the user instruction is ugly and sets a bad architecture
precedent. It may not function if the faulting instruction is modified
after #GP.

Thomas suggested to provide a reason for the #GP caused by executing ENQCMD
without a valid PASID value programmed. #GP error codes are 16 bits and all
16 bits are taken. Refer to SDM Vol 3, Chapter 16.13 for details. The other
choice was to reflect the error code in an MSR. ENQCMD can also cause #GP
when loading from the source operand, so its not fully comprehending all
the reasons. Rather than special case the ENQCMD, in future Intel may
choose a different fault mechanism for such cases if recovery is needed on
#GP.

The following heuristic is used to avoid decoding the user instructions
to determine the precise reason for the #GP fault:
1) If the mm for the process has not been allocated a PASID, this #GP
   cannot be fixed.
2) If the PASID MSR is already initialized, then the #GP was for some
   other reason
3) Try initializing the PASID MSR and returning. If the #GP was from
   an ENQCMD this will fix it. If not, the #GP fault will be repeated
   and will hit case "2".

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v3:
- Check and set current->has_valid_pasid in fixup() (PeterZ)
- Add fpu__pasid_write() to update the MSR (PeterZ)
- Add ioasid_find() sanity check in fixup()

v2:
- Update the first paragraph of the commit message (Thomas)
- Add reasons why don't decode the user instruction and don't use
  #GP error code (Thomas)
- Change get_task_mm() to current->mm (Thomas)
- Add comments on why IRQ is disabled during PASID fixup (Thomas)
- Add comment in fixup() that the function is called when #GP is from
  user (so mm is not NULL) (Dave Hansen)

 arch/x86/include/asm/iommu.h |  1 +
 arch/x86/kernel/traps.c      | 14 +++++++
 drivers/iommu/intel/svm.c    | 78 ++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index ed41259fe7ac..e9365a5d6f7d 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -27,5 +27,6 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 }
 
 void __free_pasid(struct mm_struct *mm);
+bool __fixup_pasid_exception(void);
 
 #endif /* _ASM_X86_IOMMU_H */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index af75109485c2..783b2f42fe46 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -59,6 +59,7 @@
 #include <asm/umip.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/iommu.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -513,6 +514,16 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 	return GP_CANONICAL;
 }
 
+static bool fixup_pasid_exception(void)
+{
+	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
+		return false;
+	if (!static_cpu_has(X86_FEATURE_ENQCMD))
+		return false;
+
+	return __fixup_pasid_exception();
+}
+
 #define GPFSTR "general protection fault"
 
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
@@ -525,6 +536,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
 	cond_local_irq_enable(regs);
 
+	if (user_mode(regs) && fixup_pasid_exception())
+		goto exit;
+
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
 		if (user_mode(regs) && fixup_umip_exception(regs))
 			goto exit;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e3e7699863ac..ab27971dff01 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1105,3 +1105,81 @@ void __free_pasid(struct mm_struct *mm)
 	 */
 	ioasid_free(pasid);
 }
+
+/*
+ * Write the current task's PASID MSR/state. This is called only when PASID
+ * is enabled.
+ */
+static void fpu__pasid_write(unsigned int pasid)
+{
+	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
+
+	fpregs_lock();
+
+	/*
+	 * If the MSR is active and owned by the current task's FPU, it can
+	 * be directly written.
+	 *
+	 * Otherwise, write the fpstate.
+	 */
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		wrmsrl(MSR_IA32_PASID, msr_val);
+	} else {
+		struct ia32_pasid_state *ppasid_state;
+
+		ppasid_state = get_xsave_addr(&current->thread.fpu.state.xsave,
+					      XFEATURE_PASID);
+		/*
+		 * ppasid_state shouldn't be NULL because XFEATURE_PASID
+		 * is enabled.
+		 */
+		WARN_ON_ONCE(!ppasid_state);
+		ppasid_state->pasid = msr_val;
+	}
+	fpregs_unlock();
+}
+
+/*
+ * Apply some heuristics to see if the #GP fault was caused by a thread
+ * that hasn't had the IA32_PASID MSR initialized.  If it looks like that
+ * is the problem, try initializing the IA32_PASID MSR. If the heuristic
+ * guesses incorrectly, take one more #GP fault.
+ */
+bool __fixup_pasid_exception(void)
+{
+	struct intel_svm *svm;
+	struct mm_struct *mm;
+	unsigned int pasid;
+
+	/*
+	 * If the current task already has a valid PASID in the MSR,
+	 * the #GP must be for some other reason.
+	 */
+	if (current->has_valid_pasid)
+		return false;
+
+	/*
+	 * This function is called only when this #GP was triggered from user
+	 * space. So the mm cannot be NULL.
+	 */
+	mm = current->mm;
+	pasid = mm->pasid;
+
+	/*
+	 * If the PASID isn't found, cannot help.
+	 *
+	 * Don't care if the PASID is bound to the mm here. #PF will handle the
+	 * case that the MSR is fixed up by an unbound PASID.
+	 */
+	svm = ioasid_find(NULL, pasid, NULL);
+	if (IS_ERR_OR_NULL(svm))
+		return false;
+
+	/* Fix up the MSR by the PASID in the mm. */
+	fpu__pasid_write(pasid);
+
+	/* Now the current task has a valid PASID in the MSR. */
+	current->has_valid_pasid = 1;
+
+	return true;
+}
-- 
2.19.1

