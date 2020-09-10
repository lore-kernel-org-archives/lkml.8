Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31040C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFCA421582
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EMGjTAAo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="by67diFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbgIJJgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:36:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38690 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbgIJJW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:28 -0400
Date:   Thu, 10 Sep 2020 09:22:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTS37UTtC0lhNo11i8DerY4k47O2VOPT3uCPWsJb3GU=;
        b=EMGjTAAocI4ixgA74dIHzUt82TmfckmPH0ZQyxmF1x2qToQB0n52uhAnS+DvzWtoL4E5d/
        lXOwWeno2ZjfRyJodwhHVFnL/sFpRFl5VWz3mgRjDAmif7SrLLOToFcurfnOM9tveFXp9K
        dG6esvQo/4b5AisUWQ8Sau68TtQ27HMXZxyTbqagQa44blHNTxHBxRoIQYAU46p3C5jZrF
        1C2ade6pVJtxhk619B/ScwUoKgpwoO2EBKCKFiHpY2JVZclzhfxhkXkPAHQMZuoC2+yQO/
        NgynExymu+xe+l2eQ8+vnk1DMoyexjd6MePM5jDZhFpDV9bNf4X1+xKPRsFvXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTS37UTtC0lhNo11i8DerY4k47O2VOPT3uCPWsJb3GU=;
        b=by67diFKLqfcAQG3gM8Qf6zNZIjeEQabnDKjJHe3A1p7dFE0MmEoYfBiJRd4HZ+BFScivH
        vR4VsmIds+ijnzDg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Setup a GHCB-based VC
 Exception handler
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-24-joro@8bytes.org>
References: <20200907131613.12703-24-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974309.20229.16262792666530248267.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     597cfe48212a3f110ab0f918bf59791f453e65b7
Gitweb:        https://git.kernel.org/tip/597cfe48212a3f110ab0f918bf59791f453e65b7
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:24 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/boot/compressed/64: Setup a GHCB-based VC Exception handler

Install an exception handler for #VC exception that uses a GHCB. Also
add the infrastructure for handling different exit-codes by decoding
the instruction that caused the exception and error handling.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-24-joro@8bytes.org
---
 arch/x86/Kconfig                           |   1 +-
 arch/x86/boot/compressed/Makefile          |   5 +-
 arch/x86/boot/compressed/idt_64.c          |   4 +-
 arch/x86/boot/compressed/idt_handlers_64.S |   3 +-
 arch/x86/boot/compressed/misc.c            |   7 +-
 arch/x86/boot/compressed/misc.h            |   7 +-
 arch/x86/boot/compressed/sev-es.c          | 111 ++++++++++++++-
 arch/x86/include/asm/sev-es.h              |  39 +++++-
 arch/x86/include/uapi/asm/svm.h            |   1 +-
 arch/x86/kernel/sev-es-shared.c            | 154 ++++++++++++++++++++-
 10 files changed, 331 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac6..8289dd4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1521,6 +1521,7 @@ config AMD_MEM_ENCRYPT
 	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select INSTRUCTION_DECODER
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 38f4a52..c01236a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -44,6 +44,11 @@ KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 
+# sev-es.c indirectly inludes inat-table.h which is generated during
+# compilation and stored in $(objtree). Add the directory to the includes so
+# that the compiler finds it even with out-of-tree builds (make O=/some/path).
+CFLAGS_sev-es.o += -I$(objtree)/arch/x86/lib/
+
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index f3ca732..804a502 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -46,5 +46,9 @@ void load_stage2_idt(void)
 
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
+#endif
+
 	load_boot_idt(&boot_idt_desc);
 }
diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
index 92eb4df..22890e1 100644
--- a/arch/x86/boot/compressed/idt_handlers_64.S
+++ b/arch/x86/boot/compressed/idt_handlers_64.S
@@ -72,5 +72,6 @@ SYM_FUNC_END(\name)
 EXCEPTION_HANDLER	boot_page_fault do_boot_page_fault error_code=1
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-EXCEPTION_HANDLER	boot_stage1_vc do_vc_no_ghcb error_code=1
+EXCEPTION_HANDLER	boot_stage1_vc do_vc_no_ghcb		error_code=1
+EXCEPTION_HANDLER	boot_stage2_vc do_boot_stage2_vc	error_code=1
 #endif
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index e478e40..267e7f9 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -442,6 +442,13 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	parse_elf(output);
 	handle_relocations(output, output_len, virt_addr);
 	debug_putstr("done.\nBooting the kernel.\n");
+
+	/*
+	 * Flush GHCB from cache and map it encrypted again when running as
+	 * SEV-ES guest.
+	 */
+	sev_es_shutdown_ghcb();
+
 	return output;
 }
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 01c0fb3..9995c70 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -115,6 +115,12 @@ static inline void console_init(void)
 
 void set_sev_encryption_mask(void);
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+void sev_es_shutdown_ghcb(void);
+#else
+static inline void sev_es_shutdown_ghcb(void) { }
+#endif
+
 /* acpi.c */
 #ifdef CONFIG_ACPI
 acpi_physical_address get_rsdp_addr(void);
@@ -144,5 +150,6 @@ extern struct desc_ptr boot_idt_desc;
 /* IDT Entry Points */
 void boot_page_fault(void);
 void boot_stage1_vc(void);
+void boot_stage2_vc(void);
 
 #endif /* BOOT_COMPRESSED_MISC_H */
diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 99c3bcd..fa62af7 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -13,10 +13,17 @@
 #include "misc.h"
 
 #include <asm/sev-es.h>
+#include <asm/trapnr.h>
+#include <asm/trap_pf.h>
 #include <asm/msr-index.h>
 #include <asm/ptrace.h>
 #include <asm/svm.h>
 
+#include "error.h"
+
+struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
+struct ghcb *boot_ghcb;
+
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	unsigned long low, high;
@@ -38,8 +45,112 @@ static inline void sev_es_wr_ghcb_msr(u64 val)
 			"a"(low), "d" (high) : "memory");
 }
 
+static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	enum es_result ret;
+
+	memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
+
+	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
+	insn_get_length(&ctxt->insn);
+
+	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
+
+	return ret;
+}
+
+static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
+				   void *dst, char *buf, size_t size)
+{
+	memcpy(dst, buf, size);
+
+	return ES_OK;
+}
+
+static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
+				  void *src, char *buf, size_t size)
+{
+	memcpy(buf, src, size);
+
+	return ES_OK;
+}
+
 #undef __init
+#undef __pa
 #define __init
+#define __pa(x)	((unsigned long)(x))
+
+#define __BOOT_COMPRESSED
+
+/* Basic instruction decoding support needed */
+#include "../../lib/inat.c"
+#include "../../lib/insn.c"
 
 /* Include code for early handlers */
 #include "../../kernel/sev-es-shared.c"
+
+static bool early_setup_sev_es(void)
+{
+	if (!sev_es_negotiate_protocol())
+		sev_es_terminate(GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED);
+
+	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
+		return false;
+
+	/* Page is now mapped decrypted, clear it */
+	memset(&boot_ghcb_page, 0, sizeof(boot_ghcb_page));
+
+	boot_ghcb = &boot_ghcb_page;
+
+	/* Initialize lookup tables for the instruction decoder */
+	inat_init_tables();
+
+	return true;
+}
+
+void sev_es_shutdown_ghcb(void)
+{
+	if (!boot_ghcb)
+		return;
+
+	/*
+	 * GHCB Page must be flushed from the cache and mapped encrypted again.
+	 * Otherwise the running kernel will see strange cache effects when
+	 * trying to use that page.
+	 */
+	if (set_page_encrypted((unsigned long)&boot_ghcb_page))
+		error("Can't map GHCB page encrypted");
+}
+
+void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
+{
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+
+	if (!boot_ghcb && !early_setup_sev_es())
+		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+
+	vc_ghcb_invalidate(boot_ghcb);
+	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
+	if (result != ES_OK)
+		goto finish;
+
+	switch (exit_code) {
+	default:
+		result = ES_UNSUPPORTED;
+		break;
+	}
+
+finish:
+	if (result == ES_OK) {
+		vc_finish_insn(&ctxt);
+	} else if (result != ES_RETRY) {
+		/*
+		 * For now, just halt the machine. That makes debugging easier,
+		 * later we just call sev_es_terminate() here.
+		 */
+		while (true)
+			asm volatile("hlt\n");
+	}
+}
diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index 48a4403..6dc5244 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -9,7 +9,14 @@
 #define __ASM_ENCRYPTED_STATE_H
 
 #include <linux/types.h>
+#include <asm/insn.h>
 
+#define GHCB_SEV_INFO		0x001UL
+#define GHCB_SEV_INFO_REQ	0x002UL
+#define		GHCB_INFO(v)		((v) & 0xfffUL)
+#define		GHCB_PROTO_MAX(v)	(((v) >> 48) & 0xffffUL)
+#define		GHCB_PROTO_MIN(v)	(((v) >> 32) & 0xffffUL)
+#define		GHCB_PROTO_OUR		0x0001UL
 #define GHCB_SEV_CPUID_REQ	0x004UL
 #define		GHCB_CPUID_REQ_EAX	0
 #define		GHCB_CPUID_REQ_EBX	1
@@ -19,12 +26,44 @@
 					(((unsigned long)reg & 3) << 30) | \
 					(((unsigned long)fn) << 32))
 
+#define	GHCB_PROTOCOL_MAX	0x0001UL
+#define GHCB_DEFAULT_USAGE	0x0000UL
+
 #define GHCB_SEV_CPUID_RESP	0x005UL
 #define GHCB_SEV_TERMINATE	0x100UL
+#define		GHCB_SEV_TERMINATE_REASON(reason_set, reason_val)	\
+			(((((u64)reason_set) &  0x7) << 12) |		\
+			 ((((u64)reason_val) & 0xff) << 16))
+#define		GHCB_SEV_ES_REASON_GENERAL_REQUEST	0
+#define		GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED	1
 
 #define	GHCB_SEV_GHCB_RESP_CODE(v)	((v) & 0xfff)
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
 
+enum es_result {
+	ES_OK,			/* All good */
+	ES_UNSUPPORTED,		/* Requested operation not supported */
+	ES_VMM_ERROR,		/* Unexpected state from the VMM */
+	ES_DECODE_FAILED,	/* Instruction decoding failed */
+	ES_EXCEPTION,		/* Instruction caused exception */
+	ES_RETRY,		/* Retry instruction emulation */
+};
+
+struct es_fault_info {
+	unsigned long vector;
+	unsigned long error_code;
+	unsigned long cr2;
+};
+
+struct pt_regs;
+
+/* ES instruction emulation context */
+struct es_em_ctxt {
+	struct pt_regs *regs;
+	struct insn insn;
+	struct es_fault_info fi;
+};
+
 void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code);
 
 static inline u64 lower_bits(u64 val, unsigned int bits)
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 2e8a30f..c68d161 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -29,6 +29,7 @@
 #define SVM_EXIT_WRITE_DR6     0x036
 #define SVM_EXIT_WRITE_DR7     0x037
 #define SVM_EXIT_EXCP_BASE     0x040
+#define SVM_EXIT_LAST_EXCP     0x05f
 #define SVM_EXIT_INTR          0x060
 #define SVM_EXIT_NMI           0x061
 #define SVM_EXIT_SMI           0x062
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 0bea323..7ac6e6b 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -9,6 +9,118 @@
  * and is included directly into both code-bases.
  */
 
+static void sev_es_terminate(unsigned int reason)
+{
+	u64 val = GHCB_SEV_TERMINATE;
+
+	/*
+	 * Tell the hypervisor what went wrong - only reason-set 0 is
+	 * currently supported.
+	 */
+	val |= GHCB_SEV_TERMINATE_REASON(0, reason);
+
+	/* Request Guest Termination from Hypvervisor */
+	sev_es_wr_ghcb_msr(val);
+	VMGEXIT();
+
+	while (true)
+		asm volatile("hlt\n" : : : "memory");
+}
+
+static bool sev_es_negotiate_protocol(void)
+{
+	u64 val;
+
+	/* Do the GHCB protocol version negotiation */
+	sev_es_wr_ghcb_msr(GHCB_SEV_INFO_REQ);
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+
+	if (GHCB_INFO(val) != GHCB_SEV_INFO)
+		return false;
+
+	if (GHCB_PROTO_MAX(val) < GHCB_PROTO_OUR ||
+	    GHCB_PROTO_MIN(val) > GHCB_PROTO_OUR)
+		return false;
+
+	return true;
+}
+
+static void vc_ghcb_invalidate(struct ghcb *ghcb)
+{
+	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
+}
+
+static bool vc_decoding_needed(unsigned long exit_code)
+{
+	/* Exceptions don't require to decode the instruction */
+	return !(exit_code >= SVM_EXIT_EXCP_BASE &&
+		 exit_code <= SVM_EXIT_LAST_EXCP);
+}
+
+static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
+				      struct pt_regs *regs,
+				      unsigned long exit_code)
+{
+	enum es_result ret = ES_OK;
+
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->regs = regs;
+
+	if (vc_decoding_needed(exit_code))
+		ret = vc_decode_insn(ctxt);
+
+	return ret;
+}
+
+static void vc_finish_insn(struct es_em_ctxt *ctxt)
+{
+	ctxt->regs->ip += ctxt->insn.length;
+}
+
+static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+					  struct es_em_ctxt *ctxt,
+					  u64 exit_code, u64 exit_info_1,
+					  u64 exit_info_2)
+{
+	enum es_result ret;
+
+	/* Fill in protocol and format specifiers */
+	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
+	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, exit_code);
+	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
+	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if ((ghcb->save.sw_exit_info_1 & 0xffffffff) == 1) {
+		u64 info = ghcb->save.sw_exit_info_2;
+		unsigned long v;
+
+		info = ghcb->save.sw_exit_info_2;
+		v = info & SVM_EVTINJ_VEC_MASK;
+
+		/* Check if exception information from hypervisor is sane. */
+		if ((info & SVM_EVTINJ_VALID) &&
+		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
+		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
+			ctxt->fi.vector = v;
+			if (info & SVM_EVTINJ_VALID_ERR)
+				ctxt->fi.error_code = info >> 32;
+			ret = ES_EXCEPTION;
+		} else {
+			ret = ES_VMM_ERROR;
+		}
+	} else {
+		ret = ES_OK;
+	}
+
+	return ret;
+}
+
 /*
  * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
  * page yet, so it only supports the MSR based communication with the
@@ -64,3 +176,45 @@ fail:
 	while (true)
 		asm volatile("hlt\n");
 }
+
+static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
+					  void *src, char *buf,
+					  unsigned int data_size,
+					  unsigned int count,
+					  bool backwards)
+{
+	int i, b = backwards ? -1 : 1;
+	enum es_result ret = ES_OK;
+
+	for (i = 0; i < count; i++) {
+		void *s = src + (i * data_size * b);
+		char *d = buf + (i * data_size);
+
+		ret = vc_read_mem(ctxt, s, d, data_size);
+		if (ret != ES_OK)
+			break;
+	}
+
+	return ret;
+}
+
+static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
+					   void *dst, char *buf,
+					   unsigned int data_size,
+					   unsigned int count,
+					   bool backwards)
+{
+	int i, s = backwards ? -1 : 1;
+	enum es_result ret = ES_OK;
+
+	for (i = 0; i < count; i++) {
+		void *d = dst + (i * data_size * s);
+		char *b = buf + (i * data_size);
+
+		ret = vc_write_mem(ctxt, d, b, data_size);
+		if (ret != ES_OK)
+			break;
+	}
+
+	return ret;
+}
