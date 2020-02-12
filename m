Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A2FC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B082082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgBLMEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:04:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48419 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgBLMEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:04:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1qkw-0003Zu-UF; Wed, 12 Feb 2020 13:04:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8B67D1C2005;
        Wed, 12 Feb 2020 13:04:37 +0100 (CET)
Date:   Wed, 12 Feb 2020 12:04:37 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed/64: Use 32-bit (zero-extended)
 MOV for z_output_len
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200211173333.1722739-1-nivedita@alum.mit.edu>
References: <20200211173333.1722739-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <158150907715.411.11504187337643136234.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     a86255fe5258714e1f7c1bdfe95f08e4d098d450
Gitweb:        https://git.kernel.org/tip/a86255fe5258714e1f7c1bdfe95f08e4d098d450
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 11 Feb 2020 12:33:33 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 12 Feb 2020 11:15:31 +01:00

x86/boot/compressed/64: Use 32-bit (zero-extended) MOV for z_output_len

z_output_len is the size of the decompressed payload (i.e. vmlinux +
vmlinux.relocs) and is generated as an unsigned 32-bit quantity by
mkpiggy.c.

The current

  movq $z_output_len, %r9

instruction generates a sign-extended move to %r9. Using

  movl $z_output_len, %r9d

will instead zero-extend into %r9, which is appropriate for an unsigned
32-bit quantity. This is also what is already done for z_input_len, the
size of the compressed payload.

[ bp:

  Also, z_output_len cannot be a 64-bit quantity because it participates
  in:

  init_size:              .long INIT_SIZE         # kernel initialization size

  through INIT_SIZE which is a 32-bit quantity determined by the .long
  directive (vs .quad for 64-bit). Furthermore, if it really must be a
  64-bit quantity, then the insn must be MOVABS which can accommodate a
  64-bit immediate and which the toolchain does not generate automatically.
]

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200211173333.1722739-1-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d1220de..68f31c4 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -482,7 +482,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	leaq	input_data(%rip), %rdx  /* input_data */
 	movl	$z_input_len, %ecx	/* input_len */
 	movq	%rbp, %r8		/* output target address */
-	movq	$z_output_len, %r9	/* decompressed length, end of relocs */
+	movl	$z_output_len, %r9d	/* decompressed length, end of relocs */
 	call	extract_kernel		/* returns kernel location in %rax */
 	popq	%rsi
 
