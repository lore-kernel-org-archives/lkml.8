Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B19C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170EC21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ci8TgWlr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YO8n7JPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgIJJg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:36:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38890 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgIJJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:23 -0400
Date:   Thu, 10 Sep 2020 09:22:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLldjXTZlNMc1/hrmZhqBL6bfRJ44I8hUYuC803rP44=;
        b=Ci8TgWlrij/RT6a7vJZBXS4mxH/fzLgP2FGaSD1LbVBKLlhhe4QGKEOF37kxQgpVeOVjU2
        T4VEwDkL/RkQOtnTcScKUIyCkhTIKsUeT3+SUTAT+0I6zuEkhoroMUpUScr5KzgJG0jI95
        PADY569wiVvq//ii0NfBaayxsMYhIBQP32acfq/ocBEE0D1UfzXDsUgf0ijfOnTCAVigi5
        h1vRxAveyhNOoKe1y8nA5YKIOMmZMIPLyjnq7Xq8Kh7yGxwzr+jjP3XFYk/rY/ozsTR0w7
        YXKgs4VTOZ/sMGgnQaOmOZ0OW83Bb5yXdhSslxdtExuFSah5I0k7S350LYAmaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLldjXTZlNMc1/hrmZhqBL6bfRJ44I8hUYuC803rP44=;
        b=YO8n7JPQ1AFZL3dSVZigNmYAAtcPyqg9jW2WIOkKUbgsZpmGBe6lRoiMH4wD1+2tMt57Zo
        BpF41oeI/WWUTFCA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/head/64: Install startup GDT
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-30-joro@8bytes.org>
References: <20200907131613.12703-30-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974047.20229.226807625576268915.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     866b556efa1295934ed0bc20c2f208c93a873fb0
Gitweb:        https://git.kernel.org/tip/866b556efa1295934ed0bc20c2f208c93a873fb0
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 21:33:17 +02:00

x86/head/64: Install startup GDT

Handling exceptions during boot requires a working GDT. The kernel GDT
can't be used on the direct mapping, so load a startup GDT and setup
segments.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-30-joro@8bytes.org
---
 arch/x86/include/asm/setup.h |  1 +
 arch/x86/kernel/head64.c     | 33 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/head_64.S    | 14 ++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 84b645c..5c2fd05 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -48,6 +48,7 @@ extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
 extern unsigned long __startup_secondary_64(void);
+extern void startup_64_setup_env(unsigned long physbase);
 extern int early_make_pgtable(unsigned long address);
 
 #ifdef CONFIG_X86_INTEL_MID
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index cbb71c1..8c82be4 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -61,6 +61,24 @@ unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
 #endif
 
+/*
+ * GDT used on the boot CPU before switching to virtual addresses.
+ */
+static struct desc_struct startup_gdt[GDT_ENTRIES] = {
+	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
+};
+
+/*
+ * Address needs to be set at runtime because it references the startup_gdt
+ * while the kernel still uses a direct mapping.
+ */
+static struct desc_ptr startup_gdt_descr = {
+	.size = sizeof(startup_gdt),
+	.address = 0,
+};
+
 #define __head	__section(.head.text)
 
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
@@ -489,3 +507,18 @@ void __init x86_64_start_reservations(char *real_mode_data)
 
 	start_kernel();
 }
+
+/*
+ * Setup boot CPU state needed before kernel switches to virtual addresses.
+ */
+void __head startup_64_setup_env(unsigned long physbase)
+{
+	/* Load GDT */
+	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
+	native_load_gdt(&startup_gdt_descr);
+
+	/* New GDT is live - reload data segment registers */
+	asm volatile("movl %%eax, %%ds\n"
+		     "movl %%eax, %%ss\n"
+		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
+}
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 16da4ac..2b2e916 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -73,6 +73,20 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu(), similar to initial_stack below */
 	leaq	(__end_init_task - SIZEOF_PTREGS)(%rip), %rsp
 
+	leaq	_text(%rip), %rdi
+	pushq	%rsi
+	call	startup_64_setup_env
+	popq	%rsi
+
+	/* Now switch to __KERNEL_CS so IRET works reliably */
+	pushq	$__KERNEL_CS
+	leaq	.Lon_kernel_cs(%rip), %rax
+	pushq	%rax
+	lretq
+
+.Lon_kernel_cs:
+	UNWIND_HINT_EMPTY
+
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
