Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF205C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01192075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502161AbgDNMlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730819AbgDNMlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:41:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D998C061A0F;
        Tue, 14 Apr 2020 05:41:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOKse-0002do-Li; Tue, 14 Apr 2020 14:41:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2F5F21C0086;
        Tue, 14 Apr 2020 14:41:32 +0200 (CEST)
Date:   Tue, 14 Apr 2020 12:41:31 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/32: Remove CONFIG_DOUBLEFAULT
Cc:     Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200404083646.8897-1-bp@alien8.de>
References: <20200404083646.8897-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158686809173.28353.11453848908665322063.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     593309423cbad0fab659a685834416cf12d8f581
Gitweb:        https://git.kernel.org/tip/593309423cbad0fab659a685834416cf12d8f581
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sat, 04 Apr 2020 01:33:05 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 14:24:05 +02:00

x86/32: Remove CONFIG_DOUBLEFAULT

Make the doublefault exception handler unconditional on 32-bit. Yes,
it is important to be able to catch #DF exceptions instead of silent
reboots. Yes, the code size increase is worth every byte. And one less
CONFIG symbol is just the cherry on top.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200404083646.8897-1-bp@alien8.de
---
 arch/x86/Kconfig.debug                              |  9 ---------
 arch/x86/entry/entry_32.S                           |  2 --
 arch/x86/include/asm/doublefault.h                  |  2 +-
 arch/x86/include/asm/traps.h                        |  2 --
 arch/x86/kernel/Makefile                            |  4 +---
 arch/x86/kernel/dumpstack_32.c                      |  4 ----
 arch/x86/kernel/traps.c                             |  2 --
 arch/x86/mm/cpu_entry_area.c                        |  4 +---
 tools/testing/selftests/wireguard/qemu/debug.config |  1 -
 9 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 2e74690..f909d3c 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -99,15 +99,6 @@ config DEBUG_WX
 
 	  If in doubt, say "Y".
 
-config DOUBLEFAULT
-	default y
-	bool "Enable doublefault exception handler" if EXPERT && X86_32
-	---help---
-	  This option allows trapping of rare doublefault exceptions that
-	  would otherwise cause a system to silently reboot. Disabling this
-	  option saves about 4k and might cause you much additional grey
-	  hair.
-
 config DEBUG_TLBFLUSH
 	bool "Set upper limit of TLB entries to flush one-by-one"
 	depends on DEBUG_KERNEL
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index b67bae7..5c9c7ee 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1536,7 +1536,6 @@ SYM_CODE_START(debug)
 	jmp	common_exception
 SYM_CODE_END(debug)
 
-#ifdef CONFIG_DOUBLEFAULT
 SYM_CODE_START(double_fault)
 1:
 	/*
@@ -1576,7 +1575,6 @@ SYM_CODE_START(double_fault)
 	hlt
 	jmp 1b
 SYM_CODE_END(double_fault)
-#endif
 
 /*
  * NMI is doubly nasty.  It can happen on the first instruction of
diff --git a/arch/x86/include/asm/doublefault.h b/arch/x86/include/asm/doublefault.h
index af9a14a..54a6e4a 100644
--- a/arch/x86/include/asm/doublefault.h
+++ b/arch/x86/include/asm/doublefault.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_DOUBLEFAULT_H
 #define _ASM_X86_DOUBLEFAULT_H
 
-#if defined(CONFIG_X86_32) && defined(CONFIG_DOUBLEFAULT)
+#ifdef CONFIG_X86_32
 extern void doublefault_init_cpu_tss(void);
 #else
 static inline void doublefault_init_cpu_tss(void)
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index c26a7e1..70bd0f3 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -69,9 +69,7 @@ dotraplinkage void do_overflow(struct pt_regs *regs, long error_code);
 dotraplinkage void do_bounds(struct pt_regs *regs, long error_code);
 dotraplinkage void do_invalid_op(struct pt_regs *regs, long error_code);
 dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
-#if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
-#endif
 dotraplinkage void do_coprocessor_segment_overrun(struct pt_regs *regs, long error_code);
 dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
 dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index ba89cab..2a7c3af 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -102,9 +102,7 @@ obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
 obj-y				+= kprobes/
 obj-$(CONFIG_MODULES)		+= module.o
-ifeq ($(CONFIG_X86_32),y)
-obj-$(CONFIG_DOUBLEFAULT)	+= doublefault_32.o
-endif
+obj-$(CONFIG_X86_32)		+= doublefault_32.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 8e3a8fe..722fd71 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -87,7 +87,6 @@ static bool in_softirq_stack(unsigned long *stack, struct stack_info *info)
 
 static bool in_doublefault_stack(unsigned long *stack, struct stack_info *info)
 {
-#ifdef CONFIG_DOUBLEFAULT
 	struct cpu_entry_area *cea = get_cpu_entry_area(raw_smp_processor_id());
 	struct doublefault_stack *ss = &cea->doublefault_stack;
 
@@ -103,9 +102,6 @@ static bool in_doublefault_stack(unsigned long *stack, struct stack_info *info)
 	info->next_sp	= (unsigned long *)this_cpu_read(cpu_tss_rw.x86_tss.sp);
 
 	return true;
-#else
-	return false;
-#endif
 }
 
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d54cffd..e85561f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -326,7 +326,6 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 }
 #endif
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 /*
  * Runs on an IST stack for x86_64 and on a special task stack for x86_32.
  *
@@ -450,7 +449,6 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 	die("double fault", regs, error_code);
 	panic("Machine halted.");
 }
-#endif
 
 dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 {
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 56f9189..5199d8a 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -17,7 +17,7 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_stacks);
 DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exception_stacks);
 #endif
 
-#if defined(CONFIG_X86_32) && defined(CONFIG_DOUBLEFAULT)
+#ifdef CONFIG_X86_32
 DECLARE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack);
 #endif
 
@@ -114,12 +114,10 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 #else
 static inline void percpu_setup_exception_stacks(unsigned int cpu)
 {
-#ifdef CONFIG_DOUBLEFAULT
 	struct cpu_entry_area *cea = get_cpu_entry_area(cpu);
 
 	cea_map_percpu_pages(&cea->doublefault_stack,
 			     &per_cpu(doublefault_stack, cpu), 1, PAGE_KERNEL);
-#endif
 }
 #endif
 
diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/testing/selftests/wireguard/qemu/debug.config
index 5909e7e..807fa7d 100644
--- a/tools/testing/selftests/wireguard/qemu/debug.config
+++ b/tools/testing/selftests/wireguard/qemu/debug.config
@@ -58,7 +58,6 @@ CONFIG_RCU_EQS_DEBUG=y
 CONFIG_USER_STACKTRACE_SUPPORT=y
 CONFIG_DEBUG_SG=y
 CONFIG_DEBUG_NOTIFIERS=y
-CONFIG_DOUBLEFAULT=y
 CONFIG_X86_DEBUG_FPU=y
 CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_DEBUG_PAGEALLOC=y
