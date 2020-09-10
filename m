Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B1DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BE4221E7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1EHXsFSm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aThfM+lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgIJJhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:37:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgIJJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:21 -0400
Date:   Thu, 10 Sep 2020 09:22:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Uhv9J6Uo0Pmwi1b2tk3QSfArYjumcLr4PUdw9cEMA0=;
        b=1EHXsFSmFYb2FB/yE3GT0Fponv3vXTHgYTXpOCzWiLBfrh+G9cCvuX5HNeSWVoXyBaLuMy
        +I8G/yFZj8QrxqI8nrOaBGBJb02A/Tt2gwpwoT9cbxiaLSDO8LUwN8fbIzmYadLa6TUPa1
        WOM5vciu9pAgY4FdH3RNVCV8m/3CCXqTmY4N/JvUInk5ELzamafi53pk1MIevYY/WAnkQI
        7Va7Q/eY5jJy2HWlLXzLJ8IPnXac2fp5paVps0B31VgsF2VXfh4FZzP8LLsdd99tNuShTi
        gppdpASYuW41fPsWVUajomVHERrBI6hJAQkF3gl+jQZScGppbX/t+Cisi5FWGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Uhv9J6Uo0Pmwi1b2tk3QSfArYjumcLr4PUdw9cEMA0=;
        b=aThfM+lhALm4M42X+mXLYxrUz+D6jWyCpuqL20ie+Us8dXhI0KXFY+/w0t19lD2TUGypzz
        YnjRJppyCbl54OAg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Setup GHCB-based boot #VC handler
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200908123816.GB3764@8bytes.org>
References: <20200908123816.GB3764@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973562.20229.3871610680050581041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     1aa9aa8ee517e0443b06e816a4fd2d15f2113615
Gitweb:        https://git.kernel.org/tip/1aa9aa8ee517e0443b06e816a4fd2d15f2113615
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Tue, 08 Sep 2020 14:38:16 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:32:27 +02:00

x86/sev-es: Setup GHCB-based boot #VC handler

Add the infrastructure to handle #VC exceptions when the kernel runs on
virtual addresses and has mapped a GHCB. This handler will be used until
the runtime #VC handler takes over.

Since the handler runs very early, disable instrumentation for sev-es.c.

 [ bp: Make vc_ghcb_invalidate() __always_inline so that it can be
   inlined in noinstr functions like __sev_es_nmi_complete(). ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200908123816.GB3764@8bytes.org
---
 arch/x86/include/asm/realmode.h |   3 +-
 arch/x86/include/asm/segment.h  |   2 +-
 arch/x86/include/asm/sev-es.h   |   2 +-
 arch/x86/kernel/Makefile        |   2 +-
 arch/x86/kernel/head64.c        |   8 ++-
 arch/x86/kernel/head_64.S       |  36 ++++++++++-
 arch/x86/kernel/sev-es-shared.c |  14 ++--
 arch/x86/kernel/sev-es.c        | 116 +++++++++++++++++++++++++++++++-
 arch/x86/mm/extable.c           |   1 +-
 9 files changed, 176 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index b35030e..96118fb 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -57,6 +57,9 @@ extern unsigned char real_mode_blob_end[];
 extern unsigned long initial_code;
 extern unsigned long initial_gs;
 extern unsigned long initial_stack;
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+extern unsigned long initial_vc_handler;
+#endif
 
 extern unsigned char real_mode_blob[];
 extern unsigned char real_mode_relocs[];
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 9646c30..4e8dec3 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -230,7 +230,7 @@
 #define NUM_EXCEPTION_VECTORS		32
 
 /* Bitmask of exception vectors which push an error code on the stack: */
-#define EXCEPTION_ERRCODE_MASK		0x00027d00
+#define EXCEPTION_ERRCODE_MASK		0x20027d00
 
 #define GDT_SIZE			(GDT_ENTRIES*8)
 #define GDT_ENTRY_TLS_ENTRIES		3
diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index 7175d43..9fbeeda 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -75,5 +75,7 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
 
 /* Early IDT entry points for #VC handler */
 extern void vc_no_ghcb(void);
+extern void vc_boot_ghcb(void);
+extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
 #endif
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 23bc0f8..4a33272 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -20,6 +20,7 @@ CFLAGS_REMOVE_kvmclock.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
+CFLAGS_REMOVE_sev-es.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
@@ -27,6 +28,7 @@ KASAN_SANITIZE_dumpstack.o				:= n
 KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
+KASAN_SANITIZE_sev-es.o					:= n
 
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index fc55cc9..4199f25 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -406,6 +406,10 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
 	    early_make_pgtable(native_read_cr2()))
 		return;
 
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT) &&
+	    trapnr == X86_TRAP_VC && handle_vc_boot_ghcb(regs))
+		return;
+
 	early_fixup_exception(regs, trapnr);
 }
 
@@ -575,6 +579,10 @@ static void startup_64_load_idt(unsigned long physbase)
 /* This is used when running on kernel addresses */
 void early_setup_idt(void)
 {
+	/* VMM Communication Exception */
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		set_bringup_idt_handler(bringup_idt_table, X86_TRAP_VC, vc_boot_ghcb);
+
 	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
 	native_load_idt(&bringup_idt_descr);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 6e68bca..1a71d0d 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -281,11 +281,47 @@ SYM_CODE_START(start_cpu0)
 SYM_CODE_END(start_cpu0)
 #endif
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+/*
+ * VC Exception handler used during early boot when running on kernel
+ * addresses, but before the switch to the idt_table can be made.
+ * The early_idt_handler_array can't be used here because it calls into a lot
+ * of __init code and this handler is also used during CPU offlining/onlining.
+ * Therefore this handler ends up in the .text section so that it stays around
+ * when .init.text is freed.
+ */
+SYM_CODE_START_NOALIGN(vc_boot_ghcb)
+	UNWIND_HINT_IRET_REGS offset=8
+
+	/* Build pt_regs */
+	PUSH_AND_CLEAR_REGS
+
+	/* Call C handler */
+	movq    %rsp, %rdi
+	movq	ORIG_RAX(%rsp), %rsi
+	movq	initial_vc_handler(%rip), %rax
+	ANNOTATE_RETPOLINE_SAFE
+	call	*%rax
+
+	/* Unwind pt_regs */
+	POP_REGS
+
+	/* Remove Error Code */
+	addq    $8, %rsp
+
+	/* Pure iret required here - don't use INTERRUPT_RETURN */
+	iretq
+SYM_CODE_END(vc_boot_ghcb)
+#endif
+
 	/* Both SMP bootup and ACPI suspend change these variables */
 	__REFDATA
 	.balign	8
 SYM_DATA(initial_code,	.quad x86_64_start_kernel)
 SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
+#endif
 
 /*
  * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 1861927..53e3de0 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -9,7 +9,7 @@
  * and is included directly into both code-bases.
  */
 
-static void __maybe_unused sev_es_terminate(unsigned int reason)
+static void sev_es_terminate(unsigned int reason)
 {
 	u64 val = GHCB_SEV_TERMINATE;
 
@@ -27,7 +27,7 @@ static void __maybe_unused sev_es_terminate(unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
-static bool __maybe_unused sev_es_negotiate_protocol(void)
+static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
 
@@ -46,7 +46,7 @@ static bool __maybe_unused sev_es_negotiate_protocol(void)
 	return true;
 }
 
-static void __maybe_unused vc_ghcb_invalidate(struct ghcb *ghcb)
+static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
 {
 	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
@@ -58,9 +58,9 @@ static bool vc_decoding_needed(unsigned long exit_code)
 		 exit_code <= SVM_EXIT_LAST_EXCP);
 }
 
-static enum es_result __maybe_unused vc_init_em_ctxt(struct es_em_ctxt *ctxt,
-						     struct pt_regs *regs,
-						     unsigned long exit_code)
+static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
+				      struct pt_regs *regs,
+				      unsigned long exit_code)
 {
 	enum es_result ret = ES_OK;
 
@@ -73,7 +73,7 @@ static enum es_result __maybe_unused vc_init_em_ctxt(struct es_em_ctxt *ctxt,
 	return ret;
 }
 
-static void __maybe_unused vc_finish_insn(struct es_em_ctxt *ctxt)
+static void vc_finish_insn(struct es_em_ctxt *ctxt)
 {
 	ctxt->regs->ip += ctxt->insn.length;
 }
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 4b1d217..213a427 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -7,7 +7,9 @@
  * Author: Joerg Roedel <jroedel@suse.de>
  */
 
+#include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/kernel.h>
+#include <linux/printk.h>
 #include <linux/mm.h>
 
 #include <asm/sev-es.h>
@@ -18,6 +20,18 @@
 #include <asm/trapnr.h>
 #include <asm/svm.h>
 
+/* For early boot hypervisor communication in SEV-ES enabled guests */
+static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
+
+/*
+ * Needs to be in the .data section because we need it NULL before bss is
+ * cleared
+ */
+static struct ghcb __initdata *boot_ghcb;
+
+/* Needed in vc_early_forward_exception */
+void do_early_exception(struct pt_regs *regs, int trapnr);
+
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
@@ -161,3 +175,105 @@ fault:
 
 /* Include code shared with pre-decompression boot stage */
 #include "sev-es-shared.c"
+
+/*
+ * This function runs on the first #VC exception after the kernel
+ * switched to virtual addresses.
+ */
+static bool __init sev_es_setup_ghcb(void)
+{
+	/* First make sure the hypervisor talks a supported protocol. */
+	if (!sev_es_negotiate_protocol())
+		return false;
+
+	/*
+	 * Clear the boot_ghcb. The first exception comes in before the bss
+	 * section is cleared.
+	 */
+	memset(&boot_ghcb_page, 0, PAGE_SIZE);
+
+	/* Alright - Make the boot-ghcb public */
+	boot_ghcb = &boot_ghcb_page;
+
+	return true;
+}
+
+static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
+{
+	int trapnr = ctxt->fi.vector;
+
+	if (trapnr == X86_TRAP_PF)
+		native_write_cr2(ctxt->fi.cr2);
+
+	ctxt->regs->orig_ax = ctxt->fi.error_code;
+	do_early_exception(ctxt->regs, trapnr);
+}
+
+static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
+					 struct ghcb *ghcb,
+					 unsigned long exit_code)
+{
+	enum es_result result;
+
+	switch (exit_code) {
+	default:
+		/*
+		 * Unexpected #VC exception
+		 */
+		result = ES_UNSUPPORTED;
+	}
+
+	return result;
+}
+
+bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
+{
+	unsigned long exit_code = regs->orig_ax;
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+
+	/* Do initial setup or terminate the guest */
+	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
+		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+
+	vc_ghcb_invalidate(boot_ghcb);
+
+	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
+	if (result == ES_OK)
+		result = vc_handle_exitcode(&ctxt, boot_ghcb, exit_code);
+
+	/* Done - now check the result */
+	switch (result) {
+	case ES_OK:
+		vc_finish_insn(&ctxt);
+		break;
+	case ES_UNSUPPORTED:
+		early_printk("PANIC: Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_VMM_ERROR:
+		early_printk("PANIC: Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_DECODE_FAILED:
+		early_printk("PANIC: Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_EXCEPTION:
+		vc_early_forward_exception(&ctxt);
+		break;
+	case ES_RETRY:
+		/* Nothing to do */
+		break;
+	default:
+		BUG();
+	}
+
+	return true;
+
+fail:
+	show_regs(regs);
+
+	while (true)
+		halt();
+}
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 1d6cb07..3966749 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -5,6 +5,7 @@
 #include <xen/xen.h>
 
 #include <asm/fpu/internal.h>
+#include <asm/sev-es.h>
 #include <asm/traps.h>
 #include <asm/kdebug.h>
 
