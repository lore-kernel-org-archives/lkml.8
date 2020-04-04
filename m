Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9B2C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD954206F5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rve6gY3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgDDIgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:36:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36600 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDDIgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:36:48 -0400
Received: from zn.tnic (p200300EC2F1E3400040841973BDD3BB0.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:3400:408:4197:3bdd:3bb0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFEC81EC02FE;
        Sat,  4 Apr 2020 10:36:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585989407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=CT/PqwCOOhOU5Kk3/q9aEvCLz326zouwX1oOGD+3/cQ=;
        b=Rve6gY3XrADR4Ym5PU56VQnlQUakVfqA0ANcxEV1adaSouJo6juNvzJfjBMmrRsMY95oIL
        rwMe7IPTsHN/arRE8apwsps3JY5NYB8mT1ikGp1TsY4xZQeOGd5bFm0CU+CmqDC3+7GmRB
        Wrm9OwS8SsW3no0a+KESrV14DsglTi0=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/32: Remove CONFIG_DOUBLEFAULT
Date:   Sat,  4 Apr 2020 10:36:46 +0200
Message-Id: <20200404083646.8897-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Make the doublefault exception handler unconditional on 32-bit. Yes,
it is important to be able to catch #DF exceptions instead of silent
reboots. Yes, the code size increase is worth every byte. And one less
CONFIG symbol is just the cherry on top.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/Kconfig.debug                              | 9 ---------
 arch/x86/entry/entry_32.S                           | 2 --
 arch/x86/include/asm/doublefault.h                  | 2 +-
 arch/x86/include/asm/traps.h                        | 2 --
 arch/x86/kernel/Makefile                            | 4 +---
 arch/x86/kernel/dumpstack_32.c                      | 4 ----
 arch/x86/kernel/traps.c                             | 2 --
 arch/x86/mm/cpu_entry_area.c                        | 4 +---
 tools/testing/selftests/wireguard/qemu/debug.config | 1 -
 9 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 2e74690b028a..f909d3ce36e6 100644
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
index b67bae7091d7..5c9c7eee6325 100644
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
index af9a14ac8962..54a6e4a2e132 100644
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
index c26a7e1d8a2c..70bd0f356e5d 100644
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
index 3c131adb2ca9..fd497883562f 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -106,9 +106,7 @@ obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
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
index 8e3a8fedfa4d..722fd712e1cf 100644
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
index d54cffdc7cac..e85561fc0dc8 100644
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
index 56f9189bbadb..5199d8a1daf1 100644
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
index 5909e7ef2a5c..807fa7dc60b8 100644
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
-- 
2.21.0

