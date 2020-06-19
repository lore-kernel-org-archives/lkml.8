Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C96C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65E220734
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405034AbgFSQq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405039AbgFSQqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:46:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFB0C061794;
        Fri, 19 Jun 2020 09:46:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmK9P-000431-5p; Fri, 19 Jun 2020 18:45:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AB8551C0478;
        Fri, 19 Jun 2020 18:45:58 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:45:58 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Setup stack correctly for efi_pe_entry
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200617131957.2507632-1-nivedita@alum.mit.edu>
References: <20200617131957.2507632-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159258515849.16989.14516745013371848128.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     41d90b0c1108d1e46c48cf79964636c553844f4c
Gitweb:        https://git.kernel.org/tip/41d90b0c1108d1e46c48cf79964636c553844f4c
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Wed, 17 Jun 2020 09:19:57 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 17 Jun 2020 15:28:58 +02:00

efi/x86: Setup stack correctly for efi_pe_entry

Commit

  17054f492dfd ("efi/x86: Implement mixed mode boot without the handover protocol")

introduced a new entry point for the EFI stub to be booted in mixed mode
on 32-bit firmware.

When entered via efi32_pe_entry, control is first transferred to
startup_32 to setup for the switch to long mode, and then the EFI stub
proper is entered via efi_pe_entry. efi_pe_entry is an MS ABI function,
and the ABI requires 32 bytes of shadow stack space to be allocated by
the caller, as well as the stack being aligned to 8 mod 16 on entry.

Allocate 40 bytes on the stack before switching to 64-bit mode when
calling efi_pe_entry to account for this.

For robustness, explicitly align boot_stack_end to 16 bytes. It is
currently implicitly aligned since .bss is cacheline-size aligned,
head_64.o is the first object file with a .bss section, and the heap and
boot sizes are aligned.

Fixes: 17054f492dfd ("efi/x86: Implement mixed mode boot without the handover protocol")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200617131957.2507632-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e821a7d..97d37f0 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -213,7 +213,6 @@ SYM_FUNC_START(startup_32)
 	 * We place all of the values on our mini stack so lret can
 	 * used to perform that far jump.
 	 */
-	pushl	$__KERNEL_CS
 	leal	startup_64(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
 	movl	efi32_boot_args(%ebp), %edi
@@ -224,11 +223,20 @@ SYM_FUNC_START(startup_32)
 	movl	efi32_boot_args+8(%ebp), %edx	// saved bootparams pointer
 	cmpl	$0, %edx
 	jnz	1f
+	/*
+	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
+	 * shadow space on the stack even if all arguments are passed in
+	 * registers. We also need an additional 8 bytes for the space that
+	 * would be occupied by the return address, and this also results in
+	 * the correct stack alignment for entry.
+	 */
+	subl	$40, %esp
 	leal	efi_pe_entry(%ebp), %eax
 	movl	%edi, %ecx			// MS calling convention
 	movl	%esi, %edx
 1:
 #endif
+	pushl	$__KERNEL_CS
 	pushl	%eax
 
 	/* Enter paged protected Mode, activating Long Mode */
@@ -784,6 +792,7 @@ SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
 
 SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
+	.balign 16
 SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
 
 /*
