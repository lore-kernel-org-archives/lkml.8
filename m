Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED09FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DE220656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="rT0AfRzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgFJSVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:21:52 -0400
Received: from smtp74.ord1d.emailsrvr.com ([184.106.54.74]:50356 "EHLO
        smtp74.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728776AbgFJSVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:21:51 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2020 14:21:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1591812850;
        bh=mh+Kv2YKb+dLXMp7FflSBtwzk5puxQCfhuIontc45EI=;
        h=From:To:Subject:Date:From;
        b=rT0AfRzTSNUbHS3zS7Rk3KEo0cexyz7OMDGYuC3vcjU1INxfmArSE+cMqxq8CA6k5
         cKHzpmwDbCrotKXcs3DxeaMI89StC6IU0CkvWxNzMTdiC+A50xu9pU/eedGr5YbplS
         u4L+1qqb6g4vVZlQhTuCfilzpsT4B3HJias8cYSU=
X-Auth-ID: dpreed@deepplum.com
Received: by smtp2.relay.ord1d.emailsrvr.com (Authenticated sender: dpreed-AT-deepplum.com) with ESMTPSA id DE6A04039B;
        Wed, 10 Jun 2020 14:14:08 -0400 (EDT)
X-Sender-Id: dpreed@deepplum.com
Received: from gyre.localnet ([UNAVAILABLE]. [209.6.10.161])
        (using TLSv1.2 with cipher AES256-GCM-SHA384)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 10 Jun 2020 14:14:09 -0400
From:   "David P. Reed" <dpreed@deepplum.com>
To:     dpreed@deepplum.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix undefined operation VMXOFF during reboot and crash
Date:   Wed, 10 Jun 2020 14:12:50 -0400
Message-Id: <20200610181254.2142-1-dpreed@deepplum.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 863a6ae4-a1f9-4ba7-93f9-e74dc2bfae29-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a panic/reboot occurs when CR4 has VMX enabled, a VMXOFF is
done on all CPUS, to allow the INIT IPI to function, since
INIT is suppressed when CPUs are in VMX root operation.
However, VMXOFF causes an undefined operation fault if the CPU is not
in VMX operation, that is, VMXON has not been executed, or VMXOFF
has been executed, but VMX is enabled. This fix makes the reboot
work more reliably by modifying the #UD handler to skip the VMXOFF
if VMX is enabled on the CPU and the VMXOFF is executed as part
of cpu_emergency_vmxoff().
The logic in reboot.c is also corrected, since the point of forcing
the processor out of VMX root operation is because when VMX root
operation is enabled, the processor INIT signal is always masked.
See Intel SDM section on differences between VMX Root operation and normal
operation. Thus every CPU must be forced out of VMX operation.
Since the CPU will hang rather than restart, a manual "reset" is the
only way out of this state (or if there is a BMC, it can issue a RESET
to the chip).

Signed-off-by: David P. Reed <dpreed@deepplum.com>
---
 arch/x86/include/asm/virtext.h | 24 ++++++++++++----
 arch/x86/kernel/reboot.c       | 13 ++-------
 arch/x86/kernel/traps.c        | 52 ++++++++++++++++++++++++++++++++--
 3 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 9aad0e0876fb..ea2d67191684 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -13,12 +13,16 @@
 #ifndef _ASM_X86_VIRTEX_H
 #define _ASM_X86_VIRTEX_H
 
+#include <linux/percpu.h>
+
 #include <asm/processor.h>
 
 #include <asm/vmx.h>
 #include <asm/svm.h>
 #include <asm/tlbflush.h>
 
+DECLARE_PER_CPU_READ_MOSTLY(int, doing_emergency_vmxoff);
+
 /*
  * VMX functions:
  */
@@ -33,8 +37,8 @@ static inline int cpu_has_vmx(void)
 /** Disable VMX on the current CPU
  *
  * vmxoff causes a undefined-opcode exception if vmxon was not run
- * on the CPU previously. Only call this function if you know VMX
- * is enabled.
+ * on the CPU previously. Only call this function directly if you know VMX
+ * is enabled *and* CPU is in VMX root operation.
  */
 static inline void cpu_vmxoff(void)
 {
@@ -47,17 +51,25 @@ static inline int cpu_vmx_enabled(void)
 	return __read_cr4() & X86_CR4_VMXE;
 }
 
-/** Disable VMX if it is enabled on the current CPU
+/** Force disable VMX if it is enabled on the current CPU.
+ * Note that if CPU is not in VMX root operation this
+ * VMXOFF will fault an undefined operation fault.
+ * So the 'doing_emergency_vmxoff' percpu flag is set,
+ * the trap handler for just restarts execution after
+ * the VMXOFF instruction.
  *
- * You shouldn't call this if cpu_has_vmx() returns 0.
+ * You shouldn't call this directly if cpu_has_vmx() returns 0.
  */
 static inline void __cpu_emergency_vmxoff(void)
 {
-	if (cpu_vmx_enabled())
+	if (cpu_vmx_enabled()) {
+		this_cpu_write(doing_emergency_vmxoff, 1);
 		cpu_vmxoff();
+		this_cpu_write(doing_emergency_vmxoff, 0);
+	}
 }
 
-/** Disable VMX if it is supported and enabled on the current CPU
+/** Force disable VMX if it is supported and enabled on the current CPU
  */
 static inline void cpu_emergency_vmxoff(void)
 {
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 3ca43be4f9cf..abc8b51a57c7 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -540,21 +540,14 @@ static void emergency_vmx_disable_all(void)
 	 *
 	 * For safety, we will avoid running the nmi_shootdown_cpus()
 	 * stuff unnecessarily, but we don't have a way to check
-	 * if other CPUs have VMX enabled. So we will call it only if the
-	 * CPU we are running on has VMX enabled.
-	 *
-	 * We will miss cases where VMX is not enabled on all CPUs. This
-	 * shouldn't do much harm because KVM always enable VMX on all
-	 * CPUs anyway. But we can miss it on the small window where KVM
-	 * is still enabling VMX.
+	 * if other CPUs have VMX enabled.
 	 */
-	if (cpu_has_vmx() && cpu_vmx_enabled()) {
+	if (cpu_has_vmx()) {
 		/* Disable VMX on this CPU. */
-		cpu_vmxoff();
+		cpu_emergency_vmxoff();
 
 		/* Halt and disable VMX on the other CPUs */
 		nmi_shootdown_cpus(vmxoff_nmi);
-
 	}
 }
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4cc541051994..2dcf57ef467e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
+#include <linux/percpu.h>
 
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -59,6 +60,7 @@
 #include <asm/umip.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/virtext.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -70,6 +72,8 @@
 #include <asm/proto.h>
 #endif
 
+DEFINE_PER_CPU_READ_MOSTLY(int, doing_emergency_vmxoff) = 0;
+
 DECLARE_BITMAP(system_vectors, NR_VECTORS);
 
 static inline void cond_local_irq_enable(struct pt_regs *regs)
@@ -115,6 +119,43 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
 	return 0;
 }
 
+/*
+ * Fix any unwanted undefined operation fault due to VMXOFF instruction that
+ * is needed to ensure that CPU is not in VMX root operation at time of
+ * a reboot/panic CPU reset. There is no safe and reliable way to know
+ * if a processor is in VMX root operation, other than to skip the
+ * VMXOFF. It is safe to just skip any VMXOFF that might generate this
+ * exception, when VMX operation is enabled in CR4. In the extremely
+ * rare case that a VMXOFF is erroneously executed while VMX is enabled,
+ * but VMXON has not been executed yet, the undefined opcode fault
+ * should not be missed by valid code, though it would be an error.
+ * To detect this, we could somehow restrict the instruction address
+ * to the specific use during reboot/panic.
+ */
+static int fixup_emergency_vmxoff(struct pt_regs *regs, int trapnr)
+{
+	const static u8 insn_vmxoff[3] = { 0x0f, 0x01, 0xc4 };
+	u8 ud[3];
+
+	if (trapnr != X86_TRAP_UD)
+		return 0;
+	if (!cpu_vmx_enabled())
+		return 0;
+	if (!this_cpu_read(doing_emergency_vmxoff))
+		return 0;
+
+	/* undefined instruction must be in kernel and be VMXOFF */
+	if (regs->ip < TASK_SIZE_MAX)
+		return 0;
+	if (probe_kernel_address((u8 *)regs->ip, ud))
+		return 0;
+	if (memcmp(ud, insn_vmxoff, sizeof(insn_vmxoff)))
+		return 0;
+
+	regs->ip += sizeof(insn_vmxoff);
+	return 1;
+}
+
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
@@ -193,9 +234,16 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
 	/*
 	 * WARN*()s end up here; fix them up before we call the
 	 * notifier chain.
+	 * Also, VMXOFF causes unwanted fault during reboot
+	 * if VMX is enabled, but not in VMX root operation. Fix
+	 * before calling notifier chain.
 	 */
-	if (!user_mode(regs) && fixup_bug(regs, trapnr))
-		return;
+	if (!user_mode(regs)) {
+		if (fixup_bug(regs, trapnr))
+			return;
+		if (fixup_emergency_vmxoff(regs, trapnr))
+			return;
+	}
 
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
 			NOTIFY_STOP) {
-- 
2.26.2

