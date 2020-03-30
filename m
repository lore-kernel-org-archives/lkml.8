Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDF1C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C79E20757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgC3UiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:38:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:58490 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbgC3UiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:38:04 -0400
IronPort-SDR: vqszXeXo7ocMPaC3Kfm7HHfmA1dqlLG+7uNghGeuaSAYSbAy0Vg3y/rGmEoKCZabj0lbNzU6wu
 h1SQfvhd7F6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 13:38:03 -0700
IronPort-SDR: haPA83LUmCXaOVy56e3v+JFkDdVu3y6B6FE7X4vFztwvFpQv4+jjdYqzMMdB7J88eLzXyVu++Y
 Q2XhKUl3h9/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="242143895"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2020 13:38:02 -0700
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
Subject: [PATCH 6/7] x86/traps: Fix up invalid PASID
Date:   Mon, 30 Mar 2020 12:33:07 -0700
Message-Id: <1585596788-193989-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A #GP fault is generated when ENQCMD instruction is executed without
a valid PASID value programmed in. The #GP fault handler will initialize
the current thread's PASID MSR.

The following heuristic is used to avoid decoding the user instructions
to determine the precise reason for the #GP fault:
1) If the mm for the process has not been allocated a PASID, this #GP
   cannot be fixed.
2) If the PASID MSR is already initialized, then the #GP was for some
   other reason
3) Try initializing the PASID MSR and returning. If the #GP was from
   an ENQCMD this will fix it. If not, the #GP fault will be repeated
   and we will hit case "2".

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/iommu.h |  1 +
 arch/x86/kernel/traps.c      | 17 +++++++++++++++++
 drivers/iommu/intel-svm.c    | 37 ++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

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
index 6ef00eb6fbb9..369b5ba94635 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -56,6 +56,7 @@
 #include <asm/umip.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/iommu.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -488,6 +489,16 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
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
@@ -499,6 +510,12 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
 	int ret;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
+	if (user_mode(regs) && fixup_pasid_exception()) {
+		cond_local_irq_enable(regs);
+		return;
+	}
+
 	cond_local_irq_enable(regs);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index da718a49e91e..5ed39a022adb 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -759,3 +759,40 @@ void __free_pasid(struct mm_struct *mm)
 	 */
 	ioasid_free(pasid);
 }
+
+/*
+ * Fix up the PASID MSR if possible.
+ *
+ * But if the #GP was due to another reason, a second #GP might be triggered
+ * to force proper behavior.
+ */
+bool __fixup_pasid_exception(void)
+{
+	struct mm_struct *mm;
+	bool ret = true;
+	u64 pasid_msr;
+	int pasid;
+
+	mm = get_task_mm(current);
+	/* This #GP was triggered from user mode. So mm cannot be NULL. */
+	pasid = mm->context.pasid;
+	/* Ensure this process has been bound to a PASID. */
+	if (!pasid) {
+		ret = false;
+		goto out;
+	}
+
+	/* Check to see if the PASID MSR has already been set for this task. */
+	rdmsrl(MSR_IA32_PASID, pasid_msr);
+	if (pasid_msr & MSR_IA32_PASID_VALID) {
+		ret = false;
+		goto out;
+	}
+
+	/* Fix up the MSR. */
+	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
+out:
+	mmput(mm);
+
+	return ret;
+}
-- 
2.19.1

