Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38E0C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F715207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YhXUkXiH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FO7ehPKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgIJJeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:34:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38784 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbgIJJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:23:12 -0400
Date:   Thu, 10 Sep 2020 09:22:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jc040YENt8wAwdXf0H8NJIgKmrdRquDc/0agJ/RNW+c=;
        b=YhXUkXiH+hwrpUYZsR2OKNCHjyBlawAt+lIJ4yOE6jTNx9QGChiFziKOT6XXltGVwZcqXI
        Pi9BXb8+Cfx3EjHoYiQGb0vE2CVciEJukCnYy+HEqjpuNNhd09d6ASgeTqD7Xzs0BwD+hL
        OpA3FKYluC/CDyrNfNyUFx5YBKi/hvvA6zvm/fV4lV9kjvUSD5HVq//3UzT+GHHz7G5MQE
        j+rKiMP8QdtnZREugKuy0eITzqxcmODz9d/D36WQiXZILQWE4K6XkD9mc8+xdHNH+i4PuG
        1N+IbBmORWj2p/qtwG2clyy+vNSczdjbsRhNkwqsVXb5EwpYjNmBCd+LJaT1gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jc040YENt8wAwdXf0H8NJIgKmrdRquDc/0agJ/RNW+c=;
        b=FO7ehPKL5N1TxYNDkfVnOxpb30ZAm+N4rbyPSD93bdlqs1Tnh8riiTiR1lKpXmsJTr2j8S
        ewikxpVqwWycp9DQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Add page-fault handler
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-16-joro@8bytes.org>
References: <20200907131613.12703-16-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974640.20229.6242168858691706130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     8b0d3b3b41ab6f14f1ce6d4a6b1c5f60b825123f
Gitweb:        https://git.kernel.org/tip/8b0d3b3b41ab6f14f1ce6d4a6b1c5f60b825123f
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:16 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/boot/compressed/64: Add page-fault handler

Install a page-fault handler to add an identity mapping to addresses
not yet mapped. Also do some checking whether the error code is sane.

This makes non SEV-ES machines use the exception handling
infrastructure in the pre-decompressions boot code too, making it less
likely to break in the future.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-16-joro@8bytes.org
---
 arch/x86/boot/compressed/ident_map_64.c    | 39 +++++++++++++++++++++-
 arch/x86/boot/compressed/idt_64.c          |  2 +-
 arch/x86/boot/compressed/idt_handlers_64.S |  2 +-
 arch/x86/boot/compressed/misc.h            |  6 +++-
 4 files changed, 49 insertions(+)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index d9932a1..e3d980a 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -19,10 +19,13 @@
 /* No PAGE_TABLE_ISOLATION support needed either: */
 #undef CONFIG_PAGE_TABLE_ISOLATION
 
+#include "error.h"
 #include "misc.h"
 
 /* These actually do the work of building the kernel identity maps. */
 #include <linux/pgtable.h>
+#include <asm/trap_pf.h>
+#include <asm/trapnr.h>
 #include <asm/init.h>
 /* Use the static base for this part of the boot process */
 #undef __PAGE_OFFSET
@@ -160,3 +163,39 @@ void finalize_identity_maps(void)
 {
 	write_cr3(top_level_pgt);
 }
+
+static void do_pf_error(const char *msg, unsigned long error_code,
+			unsigned long address, unsigned long ip)
+{
+	error_putstr(msg);
+
+	error_putstr("\nError Code: ");
+	error_puthex(error_code);
+	error_putstr("\nCR2: 0x");
+	error_puthex(address);
+	error_putstr("\nRIP relative to _head: 0x");
+	error_puthex(ip - (unsigned long)_head);
+	error_putstr("\n");
+
+	error("Stopping.\n");
+}
+
+void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
+{
+	unsigned long address = native_read_cr2();
+
+	/*
+	 * Check for unexpected error codes. Unexpected are:
+	 *	- Faults on present pages
+	 *	- User faults
+	 *	- Reserved bits set
+	 */
+	if (error_code & (X86_PF_PROT | X86_PF_USER | X86_PF_RSVD))
+		do_pf_error("Unexpected page-fault:", error_code, address, regs->ip);
+
+	/*
+	 * Error code is sane - now identity map the 2M region around
+	 * the faulting address.
+	 */
+	add_identity_map(address & PMD_MASK, PMD_SIZE);
+}
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 082cd6b..5f08309 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -40,5 +40,7 @@ void load_stage2_idt(void)
 {
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
+	set_idt_entry(X86_TRAP_PF, boot_page_fault);
+
 	load_boot_idt(&boot_idt_desc);
 }
diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
index 36dee2f..b20e575 100644
--- a/arch/x86/boot/compressed/idt_handlers_64.S
+++ b/arch/x86/boot/compressed/idt_handlers_64.S
@@ -68,3 +68,5 @@ SYM_FUNC_END(\name)
 
 	.text
 	.code64
+
+EXCEPTION_HANDLER	boot_page_fault do_boot_page_fault error_code=1
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 98b7a1d..f0e1991 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -37,6 +37,9 @@
 #define memptr unsigned
 #endif
 
+/* boot/compressed/vmlinux start and end markers */
+extern char _head[], _end[];
+
 /* misc.c */
 extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
@@ -146,4 +149,7 @@ extern pteval_t __default_kernel_pte_mask;
 extern gate_desc boot_idt[BOOT_IDT_ENTRIES];
 extern struct desc_ptr boot_idt_desc;
 
+/* IDT Entry Points */
+void boot_page_fault(void);
+
 #endif /* BOOT_COMPRESSED_MISC_H */
