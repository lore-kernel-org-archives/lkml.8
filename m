Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D818C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9998207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KgTUItI/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlLIv9ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgIJJcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbgIJJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EABFC0617A5;
        Thu, 10 Sep 2020 02:22:19 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/91aGCZcbaP7R+4Sqqz65k8u5dQpq1gAeQ3j4tLn5A=;
        b=KgTUItI/det9i9znxQH3Jp5xXjGRZhoaSozaXJoAn6thPhMY7bZN9B4VSsRXWG8eyRevgf
        JA+vDg1av6AIK8rtiT6j7NKI0G6OPbtStL72pPRNNEsgRAawxI/nZIVV+HmVJize6dXKK7
        RkTElEOScMiYCOyaw+O1cCuO0Mwpkr8s1elvHR2o5FHTixemjOMhZAXQnLpVP2JtETZrlb
        6Tjt04A85m57nMEIfiuQRwZi0H2u/LaS/BwiLNBkieb19mOqXa1vBHSGxbKgmo4dfnVMTk
        w1yPfSEBW3QZJO3mVk8sgOWD+2zhOkCJ2qHc2A/wfoJNUzuH6lHE1SJZTc11JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/91aGCZcbaP7R+4Sqqz65k8u5dQpq1gAeQ3j4tLn5A=;
        b=KlLIv9cihotyJdytNjeJ1nLp+EgMrT/xXQQDFj8VIIk0xqQukBC8xKWBHCP5TLST1qFSIC
        rskvB80qeZzDKBBw==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Setup an early #VC handler
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        kernel test robot <lkp@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200908123517.GA3764@8bytes.org>
References: <20200908123517.GA3764@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973604.20229.12248123946909473767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     74d8d9d531b4cc945a9f75aa2fc21d99ca5a9fe3
Gitweb:        https://git.kernel.org/tip/74d8d9d531b4cc945a9f75aa2fc21d99ca5a9fe3
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Tue, 08 Sep 2020 14:35:17 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 10:45:24 +02:00

x86/sev-es: Setup an early #VC handler

Setup an early handler for #VC exceptions. There is no GHCB mapped
yet, so just re-use the vc_no_ghcb_handler(). It can only handle
CPUID exit-codes, but that should be enough to get the kernel through
verify_cpu() and __startup_64() until it runs on virtual addresses.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
[ boot failure Error: kernel_ident_mapping_init() failed. ]
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lkml.kernel.org/r/20200908123517.GA3764@8bytes.org
---
 arch/x86/include/asm/sev-es.h |  3 +++
 arch/x86/kernel/head64.c      | 25 ++++++++++++++++++++++++-
 arch/x86/kernel/head_64.S     | 30 ++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index 6dc5244..7175d43 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -73,4 +73,7 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
 	return (val & mask);
 }
 
+/* Early IDT entry points for #VC handler */
+extern void vc_no_ghcb(void);
+
 #endif
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4282dac..fc55cc9 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -40,6 +40,7 @@
 #include <asm/desc.h>
 #include <asm/extable.h>
 #include <asm/trapnr.h>
+#include <asm/sev-es.h>
 
 /*
  * Manage page tables very early on.
@@ -540,12 +541,34 @@ static struct desc_ptr bringup_idt_descr = {
 	.address	= 0, /* Set at runtime */
 };
 
+static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
+{
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	struct idt_data data;
+	gate_desc desc;
+
+	init_idt_data(&data, n, handler);
+	idt_init_desc(&desc, &data);
+	native_write_idt_entry(idt, n, &desc);
+#endif
+}
+
 /* This runs while still in the direct mapping */
 static void startup_64_load_idt(unsigned long physbase)
 {
 	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
+	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
+
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		void *handler;
+
+		/* VMM Communication Exception */
+		handler = fixup_pointer(vc_no_ghcb, physbase);
+		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
+	}
 
-	desc->address = (unsigned long)fixup_pointer(bringup_idt_table, physbase);
+	desc->address = (unsigned long)idt;
 	native_load_idt(desc);
 }
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3b40ec4..6e68bca 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -348,6 +348,36 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
 	jmp restore_regs_and_return_to_kernel
 SYM_CODE_END(early_idt_handler_common)
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+/*
+ * VC Exception handler used during very early boot. The
+ * early_idt_handler_array can't be used because it returns via the
+ * paravirtualized INTERRUPT_RETURN and pv-ops don't work that early.
+ *
+ * This handler will end up in the .init.text section and not be
+ * available to boot secondary CPUs.
+ */
+SYM_CODE_START_NOALIGN(vc_no_ghcb)
+	UNWIND_HINT_IRET_REGS offset=8
+
+	/* Build pt_regs */
+	PUSH_AND_CLEAR_REGS
+
+	/* Call C handler */
+	movq    %rsp, %rdi
+	movq	ORIG_RAX(%rsp), %rsi
+	call    do_vc_no_ghcb
+
+	/* Unwind pt_regs */
+	POP_REGS
+
+	/* Remove Error Code */
+	addq    $8, %rsp
+
+	/* Pure iret required here - don't use INTERRUPT_RETURN */
+	iretq
+SYM_CODE_END(vc_no_ghcb)
+#endif
 
 #define SYM_DATA_START_PAGE_ALIGNED(name)			\
 	SYM_START(name, SYM_L_GLOBAL, .balign PAGE_SIZE)
