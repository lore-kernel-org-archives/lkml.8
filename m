Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E2EC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1466206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 14:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgDLOTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 10:19:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgDLOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 10:19:33 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jNdSN-0001Ww-4U; Sun, 12 Apr 2020 16:19:31 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id A99B6100E35;
        Sun, 12 Apr 2020 16:19:30 +0200 (CEST)
Date:   Sun, 12 Apr 2020 14:18:42 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.7-rc1
References: <158670111777.20085.1305752188791047060.tglx@nanos.tec.linutronix.de>
Message-ID: <158670112259.20085.6131532982985666749.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-04-12

up to:  e6f8b6c12f03: KVM: VMX: Extend VMXs #AC interceptor to handle split lock #AC in guest


A set of three patches to fix the fallout of the newly added split lock
detection feature.

They address the case where a KVM guest triggers a split lock #AC and KVM
reinjects it into the guest which is not prepared to handle it.

Adds proper sanity checks which prevent the unconditional injection into
the guest and handles the #AC on the host side in the same way as user
space detections are handled. Depending on the detection mode it either
warns and disables detection for the task or kills the task if the mode is
set to fatal.



Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      x86/split_lock: Provide handle_guest_split_lock()

Xiaoyao Li (2):
      KVM: x86: Emulate split-lock access as a write in emulator
      KVM: VMX: Extend VMXs #AC interceptor to handle split lock #AC in guest


 arch/x86/include/asm/cpu.h  |  6 ++++++
 arch/x86/kernel/cpu/intel.c | 33 ++++++++++++++++++++++++++++-----
 arch/x86/kvm/vmx/vmx.c      | 37 ++++++++++++++++++++++++++++++++++---
 arch/x86/kvm/x86.c          | 12 +++++++++++-
 4 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index ff6f3ca649b3..dd17c2da1af5 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -44,6 +44,7 @@ unsigned int x86_stepping(unsigned int sig);
 extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
+extern bool handle_guest_split_lock(unsigned long ip);
 #else
 static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
@@ -51,5 +52,10 @@ static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
 	return false;
 }
+
+static inline bool handle_guest_split_lock(unsigned long ip)
+{
+	return false;
+}
 #endif
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 9a26e972cdea..bf08d4508ecb 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -21,6 +21,7 @@
 #include <asm/elf.h>
 #include <asm/cpu_device_id.h>
 #include <asm/cmdline.h>
+#include <asm/traps.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -1066,13 +1067,10 @@ static void split_lock_init(void)
 	split_lock_verify_msr(sld_state != sld_off);
 }
 
-bool handle_user_split_lock(struct pt_regs *regs, long error_code)
+static void split_lock_warn(unsigned long ip)
 {
-	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
-		return false;
-
 	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
-			    current->comm, current->pid, regs->ip);
+			    current->comm, current->pid, ip);
 
 	/*
 	 * Disable the split lock detection for this task so it can make
@@ -1081,6 +1079,31 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 	 */
 	sld_update_msr(false);
 	set_tsk_thread_flag(current, TIF_SLD);
+}
+
+bool handle_guest_split_lock(unsigned long ip)
+{
+	if (sld_state == sld_warn) {
+		split_lock_warn(ip);
+		return true;
+	}
+
+	pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
+		     current->comm, current->pid,
+		     sld_state == sld_fatal ? "fatal" : "bogus", ip);
+
+	current->thread.error_code = 0;
+	current->thread.trap_nr = X86_TRAP_AC;
+	force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
+	return false;
+}
+EXPORT_SYMBOL_GPL(handle_guest_split_lock);
+
+bool handle_user_split_lock(struct pt_regs *regs, long error_code)
+{
+	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
+		return false;
+	split_lock_warn(regs->ip);
 	return true;
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8959514eaf0f..83050977490c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4588,6 +4588,26 @@ static int handle_machine_check(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+/*
+ * If the host has split lock detection disabled, then #AC is
+ * unconditionally injected into the guest, which is the pre split lock
+ * detection behaviour.
+ *
+ * If the host has split lock detection enabled then #AC is
+ * only injected into the guest when:
+ *  - Guest CPL == 3 (user mode)
+ *  - Guest has #AC detection enabled in CR0
+ *  - Guest EFLAGS has AC bit set
+ */
+static inline bool guest_inject_ac(struct kvm_vcpu *vcpu)
+{
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
+		return true;
+
+	return vmx_get_cpl(vcpu) == 3 && kvm_read_cr0_bits(vcpu, X86_CR0_AM) &&
+	       (kvm_get_rflags(vcpu) & X86_EFLAGS_AC);
+}
+
 static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -4653,9 +4673,6 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 		return handle_rmode_exception(vcpu, ex_no, error_code);
 
 	switch (ex_no) {
-	case AC_VECTOR:
-		kvm_queue_exception_e(vcpu, AC_VECTOR, error_code);
-		return 1;
 	case DB_VECTOR:
 		dr6 = vmcs_readl(EXIT_QUALIFICATION);
 		if (!(vcpu->guest_debug &
@@ -4684,6 +4701,20 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 		kvm_run->debug.arch.pc = vmcs_readl(GUEST_CS_BASE) + rip;
 		kvm_run->debug.arch.exception = ex_no;
 		break;
+	case AC_VECTOR:
+		if (guest_inject_ac(vcpu)) {
+			kvm_queue_exception_e(vcpu, AC_VECTOR, error_code);
+			return 1;
+		}
+
+		/*
+		 * Handle split lock. Depending on detection mode this will
+		 * either warn and disable split lock detection for this
+		 * task or force SIGBUS on it.
+		 */
+		if (handle_guest_split_lock(kvm_rip_read(vcpu)))
+			return 1;
+		fallthrough;
 	default:
 		kvm_run->exit_reason = KVM_EXIT_EXCEPTION;
 		kvm_run->ex.exception = ex_no;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 027dfd278a97..3bf2ecafd027 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5839,6 +5839,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 {
 	struct kvm_host_map map;
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+	u64 page_line_mask;
 	gpa_t gpa;
 	char *kaddr;
 	bool exchanged;
@@ -5853,7 +5854,16 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	    (gpa & PAGE_MASK) == APIC_DEFAULT_PHYS_BASE)
 		goto emul_write;
 
-	if (((gpa + bytes - 1) & PAGE_MASK) != (gpa & PAGE_MASK))
+	/*
+	 * Emulate the atomic as a straight write to avoid #AC if SLD is
+	 * enabled in the host and the access splits a cache line.
+	 */
+	if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
+		page_line_mask = ~(cache_line_size() - 1);
+	else
+		page_line_mask = PAGE_MASK;
+
+	if (((gpa + bytes - 1) & page_line_mask) != (gpa & page_line_mask))
 		goto emul_write;
 
 	if (kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), &map))

