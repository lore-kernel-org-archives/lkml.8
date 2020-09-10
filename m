Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A1C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7487321D79
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1aI9dYC/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="do972Aqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbgIJJha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:37:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38814 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbgIJJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:20 -0400
Date:   Thu, 10 Sep 2020 09:22:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+70YWtja6WPMVg/d2lG2PVX2t6THV+3luU+Y6CfzNko=;
        b=1aI9dYC/fLWdDSfEr89kwhXiDnT4y1/lRctb7ZSoumDc0k9FYjVKIf6Gqje3pZOD7Ectgx
        nw7FrxQnv7WudrwCKBaX21Y6I+depJm+EXq7WnGs1gdAqxe8IrH79O/SeUIBBct07SlIAH
        drlPKDkC1FJI/lgRCEISnD2KdLXbUh88tV2SI8T6713M2VyIYPB6CeeL1s+V4f/5NaBP4V
        TkAtVzBvWxbjaTNyWDqif3kt+hv4kSDdTszXV0XCVI7QThVXue9+Klb+AcnytGg4f0vX3I
        CRSfRPuSx+jwGXLkslotDG3TqzCmNH0uQWfhtQ8QMGNh6CF99bPWJDuRjLau2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+70YWtja6WPMVg/d2lG2PVX2t6THV+3luU+Y6CfzNko=;
        b=do972AqbgmoOcvwQH+oinIpTk+NXXqXY0VhBK8CkLWiHuquZIA9DCISMx9LWwdSlBJjF+X
        MdHnj559g75An/Dg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Allocate and map an IST stack for #VC handler
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-43-joro@8bytes.org>
References: <20200907131613.12703-43-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973476.20229.9157533137509962211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     02772fb9b68e6a72a5e17f994048df832fe2b15e
Gitweb:        https://git.kernel.org/tip/02772fb9b68e6a72a5e17f994048df832fe2b15e
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:43 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:19 +02:00

x86/sev-es: Allocate and map an IST stack for #VC handler

Allocate and map an IST stack and an additional fall-back stack for
the #VC handler.  The memory for the stacks is allocated only when
SEV-ES is active.

The #VC handler needs to use an IST stack because a #VC exception can be
raised from kernel space with unsafe stack, e.g. in the SYSCALL entry
path.

Since the #VC exception can be nested, the #VC handler switches back to
the interrupted stack when entered from kernel space. If switching back
is not possible, the fall-back stack is used.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-43-joro@8bytes.org
---
 arch/x86/include/asm/cpu_entry_area.h | 33 ++++++++++++++++----------
 arch/x86/include/asm/page_64_types.h  |  1 +-
 arch/x86/kernel/cpu/common.c          |  2 ++-
 arch/x86/kernel/dumpstack_64.c        |  8 ++++--
 arch/x86/kernel/sev-es.c              | 33 ++++++++++++++++++++++++++-
 5 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 8902fdb..3d52b09 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -11,25 +11,29 @@
 #ifdef CONFIG_X86_64
 
 /* Macro to enforce the same ordering and stack sizes */
-#define ESTACKS_MEMBERS(guardsize)		\
-	char	DF_stack_guard[guardsize];	\
-	char	DF_stack[EXCEPTION_STKSZ];	\
-	char	NMI_stack_guard[guardsize];	\
-	char	NMI_stack[EXCEPTION_STKSZ];	\
-	char	DB_stack_guard[guardsize];	\
-	char	DB_stack[EXCEPTION_STKSZ];	\
-	char	MCE_stack_guard[guardsize];	\
-	char	MCE_stack[EXCEPTION_STKSZ];	\
-	char	IST_top_guard[guardsize];	\
+#define ESTACKS_MEMBERS(guardsize, optional_stack_size)		\
+	char	DF_stack_guard[guardsize];			\
+	char	DF_stack[EXCEPTION_STKSZ];			\
+	char	NMI_stack_guard[guardsize];			\
+	char	NMI_stack[EXCEPTION_STKSZ];			\
+	char	DB_stack_guard[guardsize];			\
+	char	DB_stack[EXCEPTION_STKSZ];			\
+	char	MCE_stack_guard[guardsize];			\
+	char	MCE_stack[EXCEPTION_STKSZ];			\
+	char	VC_stack_guard[guardsize];			\
+	char	VC_stack[optional_stack_size];			\
+	char	VC2_stack_guard[guardsize];			\
+	char	VC2_stack[optional_stack_size];			\
+	char	IST_top_guard[guardsize];			\
 
 /* The exception stacks' physical storage. No guard pages required */
 struct exception_stacks {
-	ESTACKS_MEMBERS(0)
+	ESTACKS_MEMBERS(0, 0)
 };
 
 /* The effective cpu entry area mapping with guard pages. */
 struct cea_exception_stacks {
-	ESTACKS_MEMBERS(PAGE_SIZE)
+	ESTACKS_MEMBERS(PAGE_SIZE, EXCEPTION_STKSZ)
 };
 
 /*
@@ -40,6 +44,8 @@ enum exception_stack_ordering {
 	ESTACK_NMI,
 	ESTACK_DB,
 	ESTACK_MCE,
+	ESTACK_VC,
+	ESTACK_VC2,
 	N_EXCEPTION_STACKS
 };
 
@@ -139,4 +145,7 @@ static inline struct entry_stack *cpu_entry_stack(int cpu)
 #define __this_cpu_ist_top_va(name)					\
 	CEA_ESTACK_TOP(__this_cpu_read(cea_exception_stacks), name)
 
+#define __this_cpu_ist_bottom_va(name)					\
+	CEA_ESTACK_BOT(__this_cpu_read(cea_exception_stacks), name)
+
 #endif
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 288b065..d0c6c10 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -28,6 +28,7 @@
 #define	IST_INDEX_NMI		1
 #define	IST_INDEX_DB		2
 #define	IST_INDEX_MCE		3
+#define	IST_INDEX_VC		4
 
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c5d6f17..81fba4d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1829,6 +1829,8 @@ static inline void tss_setup_ist(struct tss_struct *tss)
 	tss->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
 	tss->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
 	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
+	/* Only mapped when SEV-ES is active */
+	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
 }
 
 #else /* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 4a94d38..c49cf59 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -24,11 +24,13 @@ static const char * const exception_stack_names[] = {
 		[ ESTACK_NMI	]	= "NMI",
 		[ ESTACK_DB	]	= "#DB",
 		[ ESTACK_MCE	]	= "#MC",
+		[ ESTACK_VC	]	= "#VC",
+		[ ESTACK_VC2	]	= "#VC2",
 };
 
 const char *stack_type_name(enum stack_type type)
 {
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
 
 	if (type == STACK_TYPE_IRQ)
 		return "IRQ";
@@ -79,6 +81,8 @@ struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
 	EPAGERANGE(NMI),
 	EPAGERANGE(DB),
 	EPAGERANGE(MCE),
+	EPAGERANGE(VC),
+	EPAGERANGE(VC2),
 };
 
 static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
@@ -88,7 +92,7 @@ static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 	struct pt_regs *regs;
 	unsigned int k;
 
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
 
 	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
 	/*
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 720b1b6..fae8145 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 
+#include <asm/cpu_entry_area.h>
 #include <asm/sev-es.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/internal.h>
@@ -37,10 +38,41 @@ static struct ghcb __initdata *boot_ghcb;
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
+
+	/* Physical storage for the per-CPU IST stack of the #VC handler */
+	char ist_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
+
+	/*
+	 * Physical storage for the per-CPU fall-back stack of the #VC handler.
+	 * The fall-back stack is used when it is not safe to switch back to the
+	 * interrupted stack in the #VC entry code.
+	 */
+	char fallback_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
 };
 
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 
+static void __init setup_vc_stacks(int cpu)
+{
+	struct sev_es_runtime_data *data;
+	struct cpu_entry_area *cea;
+	unsigned long vaddr;
+	phys_addr_t pa;
+
+	data = per_cpu(runtime_data, cpu);
+	cea  = get_cpu_entry_area(cpu);
+
+	/* Map #VC IST stack */
+	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC);
+	pa    = __pa(data->ist_stack);
+	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
+
+	/* Map VC fall-back stack */
+	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC2);
+	pa    = __pa(data->fallback_stack);
+	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
+}
+
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
@@ -249,6 +281,7 @@ void __init sev_es_init_vc_handling(void)
 	for_each_possible_cpu(cpu) {
 		alloc_runtime_data(cpu);
 		init_ghcb(cpu);
+		setup_vc_stacks(cpu);
 	}
 }
 
