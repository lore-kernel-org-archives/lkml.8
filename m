Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEEFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9414021941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EQ9Lwn/Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jF8skJ7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbgIJJbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbgIJJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA17EC0617AA;
        Thu, 10 Sep 2020 02:22:19 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrcMYv8uNpPGoQYgmAkKa2O1+w5fJZwc1/WU9lgubwM=;
        b=EQ9Lwn/YQn7jrg7AiHyHeIhbt4RqzZ+zyQSi6TQoVYDSBVjv3ydvCIZfI4qMGAgSNWI9eQ
        7Lj31GOAPXOxYa551b96+W1NMZhHllsBIgExWp26AeZKQIf0wUvy6Degstw/7832Nuw2Jr
        H4xvPjezruHfNfsAgxraHm+YNeXSuiWfA6v2ROmwuunChJKjwsW+Nc3HOe34fPUmo3WMv1
        7Db6Z+0NwEUIt7tUZdLerWFZQbsMrIvd179xADgXoEI1WQoJ/8sCWvzMnXkN2zjREleOUh
        RvGX6nzhWm/ZTt28ZwSCsOZza62bcyISHheyg5jLFxmmS0Gdz/eWoLmziCW7bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrcMYv8uNpPGoQYgmAkKa2O1+w5fJZwc1/WU9lgubwM=;
        b=jF8skJ7hJibEwZ5gRTSsQjYGMzOH4pX6wTN8Ud4Y+SLiKxdPQKuWvw9deWB6u+HHgULRSa
        PSBKVPRdePIXTyCA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/head/64: Move early exception dispatch to C code
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-36-joro@8bytes.org>
References: <20200907131613.12703-36-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973769.20229.14679873688706409863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     4b47cdbda6f1ad73b08dc7d497bac12b8f26ae0d
Gitweb:        https://git.kernel.org/tip/4b47cdbda6f1ad73b08dc7d497bac12b8f26ae0d
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:36 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 22:49:18 +02:00

x86/head/64: Move early exception dispatch to C code

Move the assembly coded dispatch between page-faults and all other
exceptions to C code to make it easier to maintain and extend.

Also change the return-type of early_make_pgtable() to bool and make it
static.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-36-joro@8bytes.org
---
 arch/x86/include/asm/pgtable.h |  2 +-
 arch/x86/include/asm/setup.h   |  4 +++-
 arch/x86/kernel/head64.c       | 19 +++++++++++++++----
 arch/x86/kernel/head_64.S      | 11 +----------
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b836138..7b8f212 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -28,7 +28,7 @@
 #include <asm-generic/pgtable_uffd.h>
 
 extern pgd_t early_top_pgt[PTRS_PER_PGD];
-int __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
+bool __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
 
 void ptdump_walk_pgd_level(struct seq_file *m, struct mm_struct *mm);
 void ptdump_walk_pgd_level_debugfs(struct seq_file *m, struct mm_struct *mm,
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 4b3ca5a..7d7a064 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -39,6 +39,8 @@ void vsmp_init(void);
 static inline void vsmp_init(void) { }
 #endif
 
+struct pt_regs;
+
 void setup_bios_corruption_check(void);
 void early_platform_quirks(void);
 
@@ -49,8 +51,8 @@ extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
 extern unsigned long __startup_secondary_64(void);
 extern void startup_64_setup_env(unsigned long physbase);
-extern int early_make_pgtable(unsigned long address);
 extern void early_setup_idt(void);
+extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
 #ifdef CONFIG_X86_INTEL_MID
 extern void x86_intel_mid_early_setup(void);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 7bfd5c2..4282dac 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -38,6 +38,8 @@
 #include <asm/fixmap.h>
 #include <asm/realmode.h>
 #include <asm/desc.h>
+#include <asm/extable.h>
+#include <asm/trapnr.h>
 
 /*
  * Manage page tables very early on.
@@ -317,7 +319,7 @@ static void __init reset_early_page_tables(void)
 }
 
 /* Create a new PMD entry */
-int __init __early_make_pgtable(unsigned long address, pmdval_t pmd)
+bool __init __early_make_pgtable(unsigned long address, pmdval_t pmd)
 {
 	unsigned long physaddr = address - __PAGE_OFFSET;
 	pgdval_t pgd, *pgd_p;
@@ -327,7 +329,7 @@ int __init __early_make_pgtable(unsigned long address, pmdval_t pmd)
 
 	/* Invalid address or early pgt is done ?  */
 	if (physaddr >= MAXMEM || read_cr3_pa() != __pa_nodebug(early_top_pgt))
-		return -1;
+		return false;
 
 again:
 	pgd_p = &early_top_pgt[pgd_index(address)].pgd;
@@ -384,10 +386,10 @@ again:
 	}
 	pmd_p[pmd_index(address)] = pmd;
 
-	return 0;
+	return true;
 }
 
-int __init early_make_pgtable(unsigned long address)
+static bool __init early_make_pgtable(unsigned long address)
 {
 	unsigned long physaddr = address - __PAGE_OFFSET;
 	pmdval_t pmd;
@@ -397,6 +399,15 @@ int __init early_make_pgtable(unsigned long address)
 	return __early_make_pgtable(address, pmd);
 }
 
+void __init do_early_exception(struct pt_regs *regs, int trapnr)
+{
+	if (trapnr == X86_TRAP_PF &&
+	    early_make_pgtable(native_read_cr2()))
+		return;
+
+	early_fixup_exception(regs, trapnr);
+}
+
 /* Don't add a printk in there. printk relies on the PDA which is not initialized 
    yet. */
 static void __init clear_bss(void)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 1de09b5..3b40ec4 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -341,18 +341,9 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
 	pushq %r15				/* pt_regs->r15 */
 	UNWIND_HINT_REGS
 
-	cmpq $14,%rsi		/* Page fault? */
-	jnz 10f
-	GET_CR2_INTO(%rdi)	/* can clobber %rax if pv */
-	call early_make_pgtable
-	andl %eax,%eax
-	jz 20f			/* All good */
-
-10:
 	movq %rsp,%rdi		/* RDI = pt_regs; RSI is already trapnr */
-	call early_fixup_exception
+	call do_early_exception
 
-20:
 	decl early_recursion_flag(%rip)
 	jmp restore_regs_and_return_to_kernel
 SYM_CODE_END(early_idt_handler_common)
