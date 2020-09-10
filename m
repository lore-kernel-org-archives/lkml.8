Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE107C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D72E20C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PVSKCUpG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g00rlTSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgIJJbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbgIJJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17B2C0617AB;
        Thu, 10 Sep 2020 02:22:20 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EsAEaxQcfMykCCgzeZIxtb2g345dmR2OX7KSezQw0dM=;
        b=PVSKCUpGQ1r6z0GB3BqnNXGouS9HGO4ivrn+Gcb6psT4rySTqr6rZ7HOsfmJKjF1SoPo/Z
        XBdqf81l1CP/lVHalGWkdEw4ZHLYB4Ette6c1T0a+53sLHN60JF41ycPylpmpdMjHzjJRU
        JST1y0H3UmB6n+s/ScuUq4szjM/zWio/VWRG1WHGg9ndp08xyejAaPfvqrAYBZvMSwJ5nZ
        0V6hZINEBs9T3lRvq6Krx3PMChZAQbwfFHVwGAgFvryzzpUu6qA57kMWxc81hwKmm9hcEu
        r8Wv8TMO9A3b9xCcV7iuZJKsFu298v3+cp3PrlnQlK8kADyYc2OcKxi7OLIfZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EsAEaxQcfMykCCgzeZIxtb2g345dmR2OX7KSezQw0dM=;
        b=g00rlTSQjly2O9ruPCz/Fnf9KEfKvcfl7wNSPMYf4tywVO/OHeaAbxlqBeig7de1ZIaPZC
        HQH+ecfHOxw+JzBw==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/head/64: Install a CPU bringup IDT
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-34-joro@8bytes.org>
References: <20200907131613.12703-34-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973867.20229.1265262773282852755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     f5963ba7a45fc6ff298a34976064354be437e1d8
Gitweb:        https://git.kernel.org/tip/f5963ba7a45fc6ff298a34976064354be437e1d8
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:34 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 22:18:38 +02:00

x86/head/64: Install a CPU bringup IDT

Add a separate bringup IDT for the CPU bringup code that will be used
until the kernel switches to the idt_table. There are two reasons for a
separate IDT:

	1) When the idt_table is set up and the secondary CPUs are
	   booted, it contains entries (e.g. IST entries) which
	   require certain CPU state to be set up. This includes a
	   working TSS (for IST), MSR_GS_BASE (for stack protector) or
	   CR4.FSGSBASE (for paranoid_entry) path. By using a
	   dedicated IDT for early boot this state need not to be set
	   up early.

	2) The idt_table is static to idt.c, so any function
	   using/modifying must be in idt.c too. That means that all
	   compiler driven instrumentation like tracing or KASAN is
	   also active in this code. But during early CPU bringup the
	   environment is not set up for this instrumentation to work
	   correctly.

To avoid all of these hassles and make early exception handling robust,
use a dedicated bringup IDT.

The IDT is loaded two times, first on the boot CPU while the kernel is
still running on direct mapped addresses, and again later after the
switch to kernel addresses has happened. The second IDT load happens on
the boot and secondary CPUs.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-34-joro@8bytes.org
---
 arch/x86/include/asm/setup.h |  1 +-
 arch/x86/kernel/head64.c     | 39 +++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/head_64.S    |  5 ++++-
 3 files changed, 45 insertions(+)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 5c2fd05..4b3ca5a 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -50,6 +50,7 @@ extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp
 extern unsigned long __startup_secondary_64(void);
 extern void startup_64_setup_env(unsigned long physbase);
 extern int early_make_pgtable(unsigned long address);
+extern void early_setup_idt(void);
 
 #ifdef CONFIG_X86_INTEL_MID
 extern void x86_intel_mid_early_setup(void);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8c82be4..7bfd5c2 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -36,6 +36,8 @@
 #include <asm/microcode.h>
 #include <asm/kasan.h>
 #include <asm/fixmap.h>
+#include <asm/realmode.h>
+#include <asm/desc.h>
 
 /*
  * Manage page tables very early on.
@@ -509,6 +511,41 @@ void __init x86_64_start_reservations(char *real_mode_data)
 }
 
 /*
+ * Data structures and code used for IDT setup in head_64.S. The bringup-IDT is
+ * used until the idt_table takes over. On the boot CPU this happens in
+ * x86_64_start_kernel(), on secondary CPUs in start_secondary(). In both cases
+ * this happens in the functions called from head_64.S.
+ *
+ * The idt_table can't be used that early because all the code modifying it is
+ * in idt.c and can be instrumented by tracing or KASAN, which both don't work
+ * during early CPU bringup. Also the idt_table has the runtime vectors
+ * configured which require certain CPU state to be setup already (like TSS),
+ * which also hasn't happened yet in early CPU bringup.
+ */
+static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
+
+static struct desc_ptr bringup_idt_descr = {
+	.size		= (NUM_EXCEPTION_VECTORS * sizeof(gate_desc)) - 1,
+	.address	= 0, /* Set at runtime */
+};
+
+/* This runs while still in the direct mapping */
+static void startup_64_load_idt(unsigned long physbase)
+{
+	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
+
+	desc->address = (unsigned long)fixup_pointer(bringup_idt_table, physbase);
+	native_load_idt(desc);
+}
+
+/* This is used when running on kernel addresses */
+void early_setup_idt(void)
+{
+	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
+	native_load_idt(&bringup_idt_descr);
+}
+
+/*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
 void __head startup_64_setup_env(unsigned long physbase)
@@ -521,4 +558,6 @@ void __head startup_64_setup_env(unsigned long physbase)
 	asm volatile("movl %%eax, %%ds\n"
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
+
+	startup_64_load_idt(physbase);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 83050c9..1de09b5 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -198,6 +198,11 @@ SYM_CODE_START(secondary_startup_64)
 	 */
 	movq initial_stack(%rip), %rsp
 
+	/* Setup and Load IDT */
+	pushq	%rsi
+	call	early_setup_idt
+	popq	%rsi
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
