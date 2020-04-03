Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A67CC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF3920BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404565AbgDCQaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:30:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:1416 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404247AbgDCQaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:30:15 -0400
IronPort-SDR: UWDWpH0VmmeHypj+rEInBNvQvdwIwbKRFPPfNleaG8tdcxkCPnuIBSFMND4TovXi4OoZQgha60
 R+dLGvSsEfcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 09:30:14 -0700
IronPort-SDR: mtB9Z/U72h3fK1newySKrzCgLSKut3MIck2MuYjW8g8tez1BwfZsAhIk/CJD1jLQVMxYuYNnv3
 TO0ywBAMzthA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="296033883"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2020 09:30:13 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Doug Covelli <dcovelli@vmware.com>
Subject: [RFC PATCH] x86/split_lock: Disable SLD if an unaware (out-of-tree) module enables VMX
Date:   Fri,  3 Apr 2020 09:30:07 -0700
Message-Id: <20200403163007.6463-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook into native CR4 writes to disable split-lock detection if CR4.VMXE
is toggled on by an SDL-unaware entity, e.g. an out-of-tree hypervisor
module.  Most/all VMX-based hypervisors blindly reflect #AC exceptions
into the guest, or don't intercept #AC in the first place.  With SLD
enabled, this results in unexpected #AC faults in the guest, leading to
crashes in the guest and other undesirable behavior.

Reported-by: "Kenneth R. Crudup" <kenny@panix.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kenneth R. Crudup <kenny@panix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Doug Covelli <dcovelli@vmware.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

A bit ugly, but on the plus side the code is largely contained to intel.c.
I think forgoing the on_all_cpus() remote kill is safe?  The reverse is
definitely not safe as native_cr4_write() is called with IRQs disabled.
There's the weird discrepancy where SLD is still reported as supported and
enabled, but I don't think anything in the kernel will notice/care?

If we wanted, this could also make the "kill" temporary, e.g. undo it if
VMX is disabled.  But, that would require per-CPU tracking of VMXE, and
going that far out of our way to support out-of-tree hypervisors seems a
bit much.

The big unknown is whether or not existing out-of-tree modules play nice
and actually route through native_cr4_write().

 arch/x86/include/asm/cpu.h   | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/common.c |  1 +
 arch/x86/kernel/cpu/intel.c  | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index ff6f3ca649b3..73c5f6478fb5 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -8,6 +8,8 @@
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
 
+#include <asm/tlbflush.h>
+
 #ifdef CONFIG_SMP
 
 extern void prefill_possible_map(void);
@@ -44,6 +46,16 @@ unsigned int x86_stepping(unsigned int sig);
 extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
 extern void switch_to_sld(unsigned long tifn);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
+extern void split_lock_kill(void);
+
+extern atomic_t cr4_vmxe_split_lock_safe;
+static inline void cr4_set_vmxe(void)
+{
+	atomic_inc(&cr4_vmxe_split_lock_safe);
+	cr4_set_bits(X86_CR4_VMXE);
+	atomic_dec(&cr4_vmxe_split_lock_safe);
+}
+extern void split_lock_cr4_write(unsigned long val);
 #else
 static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
 static inline void switch_to_sld(unsigned long tifn) {}
@@ -51,5 +63,11 @@ static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
 	return false;
 }
+static inline void split_lock_kill(void) {}
+static inline void cr4_set_vmxe(void)
+{
+	cr4_set_bits(X86_CR4_VMXE);
+}
+static inline void split_lock_cr4_write(unsigned long val) {}
 #endif
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bed0cb83fe24..a50dda8d4409 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -373,6 +373,7 @@ void native_write_cr4(unsigned long val)
 {
 	unsigned long bits_missing = 0;
 
+	split_lock_cr4_write(val);
 set_register:
 	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 9a26e972cdea..9cfe29d68457 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -46,6 +46,11 @@ enum split_lock_detect_state {
  */
 static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
 static u64 msr_test_ctrl_cache __ro_after_init;
+static bool sld_killed __read_mostly;
+
+/* Cookie that states CR4.VMXE can be enabled without killing SLD. */
+atomic_t cr4_vmxe_split_lock_safe = ATOMIC_INIT(0);
+EXPORT_SYMBOL_GPL(cr4_vmxe_split_lock_safe);
 
 /*
  * Processors which have self-snooping capability can handle conflicting
@@ -1055,7 +1060,7 @@ static void sld_update_msr(bool on)
 {
 	u64 test_ctrl_val = msr_test_ctrl_cache;
 
-	if (on)
+	if (on && !sld_killed)
 		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
 
 	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
@@ -1096,6 +1101,30 @@ void switch_to_sld(unsigned long tifn)
 	sld_update_msr(!(tifn & _TIF_SLD));
 }
 
+void split_lock_cr4_write(unsigned long val)
+{
+	/*
+	 * Out-of-tree hypervisors that aren't aware of split-lock will blindly
+	 * reflect split-lock #AC into their guests.  Kill split-lock detection
+	 * if an unaware entity enables VMX.
+	 */
+	if (!static_cpu_has(X86_FEATURE_VMX) ||
+	    !static_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) ||
+	    !(val & X86_CR4_VMXE) || atomic_read(&cr4_vmxe_split_lock_safe) ||
+	    (native_read_cr4() & X86_CR4_VMXE))
+		return;
+
+	WARN_ON_ONCE(1);
+
+	/*
+	 * No need to forcefully disable SLD on other CPUs, they'll come here
+	 * if/when they set CR4.VMXE.  Set the global kill bit to prevent
+	 * re-enabling SLD, e.g. via switch_to_sld().
+	 */
+	sld_killed = true;
+	sld_update_msr(false);
+}
+
 #define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
 
 /*
-- 
2.24.1

