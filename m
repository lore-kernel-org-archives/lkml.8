Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ECCC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC80B20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbgDBNBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:01:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37717 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDBNBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:01:23 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJzSw-0004G0-3I; Thu, 02 Apr 2020 15:01:02 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 63184FFAA7;
        Thu,  2 Apr 2020 15:01:01 +0200 (CEST)
Message-Id: <20200402124205.334622628@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 02 Apr 2020 14:33:00 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 2/2] x86/kvm/vmx: Prevent split lock detection induced #AC wreckage
References: <20200402123258.895628824@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without at least minimal handling for split lock detection induced #AC, VMX
will just run into the same problem as the VMWare hypervisor, which was
reported by Kenneth.

It will inject the #AC blindly into the guest whether the guest is prepared
or not.

Add the minimal required handling for it:

  - Check guest state whether CR0.AM is enabled and EFLAGS.AC is set.  If
    so, then the #AC originated from CPL3 and the guest has is prepared to
    handle it. In this case it does not matter whether the #AC is due to a
    split lock or a regular unaligned check.

 - Invoke a minimal split lock detection handler. If the host SLD mode is
   sld_warn, then handle it in the same way as user space handling works:
   Emit a warning, disable SLD and mark the current task with TIF_SLD.
   With that resume the guest without injecting #AC.

   If the host mode is sld_fatal or sld_off, emit a warning and deliver
   the exception to user space which can crash and burn itself.

Mark the module with MOD_INFO(sld_safe, "Y") so the module loader does not
force SLD off.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Kenneth R. Crudup" <kenny@panix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/cpu.h  |    1 +
 arch/x86/kernel/cpu/intel.c |   28 +++++++++++++++++++++++-----
 arch/x86/kvm/vmx/vmx.c      |   40 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 61 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -44,6 +44,7 @@ unsigned int x86_stepping(unsigned int s
 extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
+extern bool handle_guest_split_lock(unsigned long ip);
 extern void split_lock_validate_module_text(struct module *me, void *text, void *text_end);
 #else
 static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1102,13 +1102,10 @@ static void split_lock_init(void)
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
@@ -1117,6 +1114,27 @@ bool handle_user_split_lock(struct pt_re
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
 
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -65,6 +65,7 @@
 
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
+MODULE_INFO(sld_safe, "Y");
 
 #ifdef MODULE
 static const struct x86_cpu_id vmx_cpu_id[] = {
@@ -4623,6 +4624,22 @@ static int handle_machine_check(struct k
 	return 1;
 }
 
+static bool guest_handles_ac(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * If guest has alignment checking enabled in CR0 and activated in
+	 * eflags, then the #AC originated from CPL3 and the guest is able
+	 * to handle it. It does not matter whether this is a regular or
+	 * a split lock operation induced #AC.
+	 */
+	if (vcpu->arch.cr0 & X86_CR0_AM &&
+	    vmx_get_rflags(vcpu) & X86_EFLAGS_AC)
+		return true;
+
+	/* Add guest SLD handling checks here once it's supported */
+	return false;
+}
+
 static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -4688,9 +4705,6 @@ static int handle_exception_nmi(struct k
 		return handle_rmode_exception(vcpu, ex_no, error_code);
 
 	switch (ex_no) {
-	case AC_VECTOR:
-		kvm_queue_exception_e(vcpu, AC_VECTOR, error_code);
-		return 1;
 	case DB_VECTOR:
 		dr6 = vmcs_readl(EXIT_QUALIFICATION);
 		if (!(vcpu->guest_debug &
@@ -4719,6 +4733,26 @@ static int handle_exception_nmi(struct k
 		kvm_run->debug.arch.pc = vmcs_readl(GUEST_CS_BASE) + rip;
 		kvm_run->debug.arch.exception = ex_no;
 		break;
+	case AC_VECTOR:
+		if (guest_handles_ac(vcpu)) {
+			kvm_queue_exception_e(vcpu, AC_VECTOR, error_code);
+			return 1;
+		}
+		/*
+		 * Handle #AC caused by split lock detection. If the host
+		 * mode is sld_warn, then it warns, marks current with
+		 * TIF_SLD and disables split lock detection. So the guest
+		 * can just continue.
+		 *
+		 * If the host mode is fatal, the handling code warned. Let
+		 * qemu kill itself.
+		 *
+		 * If the host mode is off, then this #AC is bonkers and
+		 * something is badly wrong. Let it fail as well.
+		 */
+		if (handle_guest_split_lock(kvm_rip_read(vcpu)))
+			return 1;
+		/* fall through */
 	default:
 		kvm_run->exit_reason = KVM_EXIT_EXCEPTION;
 		kvm_run->ex.exception = ex_no;

