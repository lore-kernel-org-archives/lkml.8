Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A969C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33322207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ly3QVYOD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oaFqhs7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgIJJeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:34:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbgIJJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:59 -0400
Date:   Thu, 10 Sep 2020 09:22:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fgi09CCV36O0mnU0TttqOMy1b4GREEMIAXQvB2jc5KA=;
        b=ly3QVYODVuVHYwY6orRNqHzU0loOSEMYNJiIrU71vUsONVhIEo05bWVGE3w518mQ5tBOFx
        5ImM1zu1eTmRkVeWSZLyqJ2WSXXP0hGQUb4XFxPOnrezsYx6VHQ6ofYPvReEitm/JGQ9dX
        SH5U+jYo/RivHOWyNo08FaB5ocHK3dier6s/bHajRAgve+nLnOA0ujCzOEg9vsm/FT/5fA
        v4NMY8+6eDibWTFvIaUMq4uQaghTTSseMkSX2PTcH+yVUWQ/5MnygaKncbUcSa4AUpyqP8
        e/2VpRO4A0quVh8Pw0bGoY6+IiPgO6hhAhwP3kdZMfxbr8RRubb9O9Tnl2goRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fgi09CCV36O0mnU0TttqOMy1b4GREEMIAXQvB2jc5KA=;
        b=oaFqhs7aNqj5VPOF0moNmNj58X9lK7AbShLk2OM3SBdOfYh7hQP3PNnDHU1/AO6zV0LNxI
        CLB3H1K9NBRnlJBQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Add stage1 #VC handler
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-20-joro@8bytes.org>
References: <20200907131613.12703-20-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974476.20229.7969430969031957239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     29dcc60f6a19fb0aaee97bd1ae2ed8a7dc6f0cfe
Gitweb:        https://git.kernel.org/tip/29dcc60f6a19fb0aaee97bd1ae2ed8a7dc6f0cfe
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:20 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/boot/compressed/64: Add stage1 #VC handler

Add the first handler for #VC exceptions. At stage 1 there is no GHCB
yet because the kernel might still be running on the EFI page table.

The stage 1 handler is limited to the MSR-based protocol to talk to the
hypervisor and can only support CPUID exit-codes, but that is enough to
get to stage 2.

 [ bp: Zap superfluous newlines after rd/wrmsr instruction mnemonics. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-20-joro@8bytes.org
---
 arch/x86/boot/compressed/Makefile          |  1 +-
 arch/x86/boot/compressed/idt_64.c          |  4 +-
 arch/x86/boot/compressed/idt_handlers_64.S |  4 +-
 arch/x86/boot/compressed/misc.h            |  1 +-
 arch/x86/boot/compressed/sev-es.c          | 45 ++++++++++++++-
 arch/x86/include/asm/msr-index.h           |  1 +-
 arch/x86/include/asm/sev-es.h              | 37 ++++++++++++-
 arch/x86/include/asm/trapnr.h              |  1 +-
 arch/x86/kernel/sev-es-shared.c            | 66 +++++++++++++++++++++-
 9 files changed, 160 insertions(+)
 create mode 100644 arch/x86/boot/compressed/sev-es.c
 create mode 100644 arch/x86/include/asm/sev-es.h
 create mode 100644 arch/x86/kernel/sev-es-shared.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e7f3eba..38f4a52 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -88,6 +88,7 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/idt_64.o $(obj)/idt_handlers_64.o
 	vmlinux-objs-y += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
+	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev-es.o
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 5f08309..f3ca732 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -32,6 +32,10 @@ void load_stage1_idt(void)
 {
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		set_idt_entry(X86_TRAP_VC, boot_stage1_vc);
+
 	load_boot_idt(&boot_idt_desc);
 }
 
diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
index b20e575..92eb4df 100644
--- a/arch/x86/boot/compressed/idt_handlers_64.S
+++ b/arch/x86/boot/compressed/idt_handlers_64.S
@@ -70,3 +70,7 @@ SYM_FUNC_END(\name)
 	.code64
 
 EXCEPTION_HANDLER	boot_page_fault do_boot_page_fault error_code=1
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+EXCEPTION_HANDLER	boot_stage1_vc do_vc_no_ghcb error_code=1
+#endif
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 9840c82..eaa8b45 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -141,5 +141,6 @@ extern struct desc_ptr boot_idt_desc;
 
 /* IDT Entry Points */
 void boot_page_fault(void);
+void boot_stage1_vc(void);
 
 #endif /* BOOT_COMPRESSED_MISC_H */
diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
new file mode 100644
index 0000000..99c3bcd
--- /dev/null
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Encrypted Register State Support
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
+
+/*
+ * misc.h needs to be first because it knows how to include the other kernel
+ * headers in the pre-decompression code in a way that does not break
+ * compilation.
+ */
+#include "misc.h"
+
+#include <asm/sev-es.h>
+#include <asm/msr-index.h>
+#include <asm/ptrace.h>
+#include <asm/svm.h>
+
+static inline u64 sev_es_rd_ghcb_msr(void)
+{
+	unsigned long low, high;
+
+	asm volatile("rdmsr" : "=a" (low), "=d" (high) :
+			"c" (MSR_AMD64_SEV_ES_GHCB));
+
+	return ((high << 32) | low);
+}
+
+static inline void sev_es_wr_ghcb_msr(u64 val)
+{
+	u32 low, high;
+
+	low  = val & 0xffffffffUL;
+	high = val >> 32;
+
+	asm volatile("wrmsr" : : "c" (MSR_AMD64_SEV_ES_GHCB),
+			"a"(low), "d" (high) : "memory");
+}
+
+#undef __init
+#define __init
+
+/* Include code for early handlers */
+#include "../../kernel/sev-es-shared.c"
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2859ee4..da34fdb 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -466,6 +466,7 @@
 #define MSR_AMD64_IBSBRTARGET		0xc001103b
 #define MSR_AMD64_IBSOPDATA4		0xc001103d
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
+#define MSR_AMD64_SEV_ES_GHCB		0xc0010130
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
 #define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
new file mode 100644
index 0000000..48a4403
--- /dev/null
+++ b/arch/x86/include/asm/sev-es.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Encrypted Register State Support
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
+
+#ifndef __ASM_ENCRYPTED_STATE_H
+#define __ASM_ENCRYPTED_STATE_H
+
+#include <linux/types.h>
+
+#define GHCB_SEV_CPUID_REQ	0x004UL
+#define		GHCB_CPUID_REQ_EAX	0
+#define		GHCB_CPUID_REQ_EBX	1
+#define		GHCB_CPUID_REQ_ECX	2
+#define		GHCB_CPUID_REQ_EDX	3
+#define		GHCB_CPUID_REQ(fn, reg) (GHCB_SEV_CPUID_REQ | \
+					(((unsigned long)reg & 3) << 30) | \
+					(((unsigned long)fn) << 32))
+
+#define GHCB_SEV_CPUID_RESP	0x005UL
+#define GHCB_SEV_TERMINATE	0x100UL
+
+#define	GHCB_SEV_GHCB_RESP_CODE(v)	((v) & 0xfff)
+#define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
+
+void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code);
+
+static inline u64 lower_bits(u64 val, unsigned int bits)
+{
+	u64 mask = (1ULL << bits) - 1;
+
+	return (val & mask);
+}
+
+#endif
diff --git a/arch/x86/include/asm/trapnr.h b/arch/x86/include/asm/trapnr.h
index 082f456..f5d2325 100644
--- a/arch/x86/include/asm/trapnr.h
+++ b/arch/x86/include/asm/trapnr.h
@@ -26,6 +26,7 @@
 #define X86_TRAP_XF		19	/* SIMD Floating-Point Exception */
 #define X86_TRAP_VE		20	/* Virtualization Exception */
 #define X86_TRAP_CP		21	/* Control Protection Exception */
+#define X86_TRAP_VC		29	/* VMM Communication Exception */
 #define X86_TRAP_IRET		32	/* IRET Exception */
 
 #endif
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
new file mode 100644
index 0000000..0bea323
--- /dev/null
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Encrypted Register State Support
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ *
+ * This file is not compiled stand-alone. It contains code shared
+ * between the pre-decompression boot code and the running Linux kernel
+ * and is included directly into both code-bases.
+ */
+
+/*
+ * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
+ * page yet, so it only supports the MSR based communication with the
+ * hypervisor and only the CPUID exit-code.
+ */
+void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+{
+	unsigned int fn = lower_bits(regs->ax, 32);
+	unsigned long val;
+
+	/* Only CPUID is supported via MSR protocol */
+	if (exit_code != SVM_EXIT_CPUID)
+		goto fail;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+		goto fail;
+	regs->ax = val >> 32;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+		goto fail;
+	regs->bx = val >> 32;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+		goto fail;
+	regs->cx = val >> 32;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+		goto fail;
+	regs->dx = val >> 32;
+
+	/* Skip over the CPUID two-byte opcode */
+	regs->ip += 2;
+
+	return;
+
+fail:
+	sev_es_wr_ghcb_msr(GHCB_SEV_TERMINATE);
+	VMGEXIT();
+
+	/* Shouldn't get here - if we do halt the machine */
+	while (true)
+		asm volatile("hlt\n");
+}
