Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DE5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C54207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgFMAmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 20:42:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:1253 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgFMAl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 20:41:57 -0400
IronPort-SDR: PTVG84oH7R8pUgdLwoL4hAgxC3Ybm0PwJZch4EPXz5H17dc0chCpc8cnNBdpq0UNfKV+TMAfpy
 j0HmFmwdTmlw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 17:41:54 -0700
IronPort-SDR: /QgbcwgLugJdiuzdLc/C+vLLCwvVxA8VT9nu3tDcoZozoZ6rfniRPFuzcJHXJ3FORyAJLQbANe
 cBmRvAW6/hSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,505,1583222400"; 
   d="scan'208";a="261011241"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2020 17:41:54 -0700
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
Subject: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Date:   Fri, 12 Jun 2020 17:41:33 -0700
Message-Id: <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
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
v2:
- Update the first paragraph of the commit message (Thomas)
- Add reasons why don't decode the user instruction and don't use
  #GP error code (Thomas)
- Change get_task_mm() to current->mm (Thomas)
- Add comments on why IRQ is disabled during PASID fixup (Thomas)
- Add comment in fixup() that the function is called when #GP is from
  user (so mm is not NULL) (Dave Hansen)

 arch/x86/include/asm/iommu.h |  1 +
 arch/x86/kernel/traps.c      | 23 +++++++++++++++++++++
 drivers/iommu/intel/svm.c    | 39 ++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

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
index 4cc541051994..0f78d5cdddfe 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -59,6 +59,7 @@
 #include <asm/umip.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/iommu.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -436,6 +437,16 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
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
 
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
@@ -447,6 +458,18 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
 	int ret;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
+	/*
+	 * Perform the check for a user mode PASID exception before enable
+	 * interrupts. Doing this here ensures that the PASID MSR can be simply
+	 * accessed because the contents are known to be still associated
+	 * with the current process.
+	 */
+	if (user_mode(regs) && fixup_pasid_exception()) {
+		cond_local_irq_enable(regs);
+		return;
+	}
+
 	cond_local_irq_enable(regs);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 27dc866b8461..81fd2380c0f9 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1078,3 +1078,42 @@ void __free_pasid(struct mm_struct *mm)
 	 */
 	ioasid_free(pasid);
 }
+
+/*
+ * Apply some heuristics to see if the #GP fault was caused by a thread
+ * that hasn't had the IA32_PASID MSR initialized.  If it looks like that
+ * is the problem, try initializing the IA32_PASID MSR. If the heuristic
+ * guesses incorrectly, take one more #GP fault.
+ */
+bool __fixup_pasid_exception(void)
+{
+	u64 pasid_msr;
+	unsigned int pasid;
+
+	/*
+	 * This function is called only when this #GP was triggered from user
+	 * space. So the mm cannot be NULL.
+	 */
+	pasid = current->mm->pasid;
+	/* If the mm doesn't have a valid PASID, then can't help. */
+	if (invalid_pasid(pasid))
+		return false;
+
+	/*
+	 * Since IRQ is disabled now, the current task still owns the FPU on
+	 * this CPU and the PASID MSR can be directly accessed.
+	 *
+	 * If the MSR has a valid PASID, the #GP must be for some other reason.
+	 *
+	 * If rdmsr() is really a performance issue, a TIF_ flag may be
+	 * added to check if the thread has a valid PASID instead of rdmsr().
+	 */
+	rdmsrl(MSR_IA32_PASID, pasid_msr);
+	if (pasid_msr & MSR_IA32_PASID_VALID)
+		return false;
+
+	/* Fix up the MSR if the MSR doesn't have a valid PASID. */
+	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
+
+	return true;
+}
-- 
2.19.1

