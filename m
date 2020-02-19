Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09168C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8F924671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgBSQzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:55:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38822 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:55:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j4Sd2-0000GR-Kk; Wed, 19 Feb 2020 17:55:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 488A41C20C7;
        Wed, 19 Feb 2020 17:55:16 +0100 (CET)
Date:   Wed, 19 Feb 2020 16:55:16 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed/64: Remove .bss/.pgtable from bzImage
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200109150218.16544-1-nivedita@alum.mit.edu>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <158213131602.13786.16571739495363216175.tip-bot2@tip-bot2>
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

Commit-ID:     3ee372ccce4d4e7c610748d0583979d3ed3a0cf4
Gitweb:        https://git.kernel.org/tip/3ee372ccce4d4e7c610748d0583979d3ed3a0cf4
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Thu, 09 Jan 2020 10:02:17 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Feb 2020 17:28:57 +01:00

x86/boot/compressed/64: Remove .bss/.pgtable from bzImage

Commit

  5b11f1cee579 ("x86, boot: straighten out ranges to copy/zero in
  compressed/head*.S")

introduced a separate .pgtable section, splitting it out from the rest
of .bss. This section was added without the writeable flag, marking it
as read-only. This results in the linker putting the .rela.dyn section
(containing bogus dynamic relocations from head_64.o) after the .bss and
.pgtable sections.

When objcopy is used to convert compressed/vmlinux into a binary for
the bzImage:

$ objcopy  -O binary -R .note -R .comment -S arch/x86/boot/compressed/vmlinux \
		arch/x86/boot/vmlinux.bin

the .bss and .pgtable sections get materialized as ~176KiB of zero
bytes in the binary in order to place .rela.dyn at the correct location.

Fix this by marking .pgtable as writeable. This moves the .rela.dyn
section up in the ELF image layout so that .bss and .pgtable are the
last allocated sections and so don't appear in bzImage.

 [ bp: Massage commit message. ]

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200109150218.16544-1-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 68f31c4..c8ee6ef 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -645,7 +645,7 @@ SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
 /*
  * Space for page tables (not in .bss so not zeroed)
  */
-	.section ".pgtable","a",@nobits
+	.section ".pgtable","aw",@nobits
 	.balign 4096
 SYM_DATA_LOCAL(pgtable,		.fill BOOT_PGT_SIZE, 1, 0)
 
