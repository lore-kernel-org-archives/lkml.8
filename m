Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E188C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F228E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgBYQxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:53:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53927 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:53:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6dSU-0007Y7-NC; Tue, 25 Feb 2020 17:53:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4B40D1C213B;
        Tue, 25 Feb 2020 17:53:22 +0100 (CET)
Date:   Tue, 25 Feb 2020 16:53:21 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/vmlinux: Drop unneeded linker script discard of .eh_frame
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200224232129.597160-3-nivedita@alum.mit.edu>
References: <20200224232129.597160-3-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <158264960194.28353.10560165361470246192.tip-bot2@tip-bot2>
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

Commit-ID:     6f8f0dc980028e98ae339876a8403edae4d20e39
Gitweb:        https://git.kernel.org/tip/6f8f0dc980028e98ae339876a8403edae4d20e39
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 24 Feb 2020 18:21:29 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 25 Feb 2020 14:51:29 +01:00

x86/vmlinux: Drop unneeded linker script discard of .eh_frame

Now that .eh_frame sections for the files in setup.elf and realmode.elf
are not generated anymore, the linker scripts don't need the special
output section name /DISCARD/ any more.

Remove the one in the main kernel linker script as well, since there are
no .eh_frame sections already, and fix up a comment referencing .eh_frame.

Update the comment in asm/dwarf2.h referring to .eh_frame so it continues
to make sense, as well as being more specific.

 [ bp: Touch up commit message. ]

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://lkml.kernel.org/r/20200224232129.597160-3-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/vmlinux.lds.S | 5 -----
 arch/x86/boot/setup.ld                 | 1 -
 arch/x86/include/asm/dwarf2.h          | 4 ++--
 arch/x86/kernel/vmlinux.lds.S          | 7 ++-----
 arch/x86/realmode/rm/realmode.lds.S    | 1 -
 5 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 469dcf8..508cfa6 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -73,9 +73,4 @@ SECTIONS
 #endif
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
-
-	/* Discard .eh_frame to save some space */
-	/DISCARD/ : {
-		*(.eh_frame)
-	}
 }
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 3da1c37..24c9552 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -52,7 +52,6 @@ SECTIONS
 	_end = .;
 
 	/DISCARD/	: {
-		*(.eh_frame)
 		*(.note*)
 	}
 
diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index ae391f6..f71a0cc 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -42,8 +42,8 @@
 	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
 	 * The latter we currently just discard since we don't do DWARF
 	 * unwinding at runtime.  So only the offline DWARF information is
-	 * useful to anyone.  Note we should not use this directive if
-	 * vmlinux.lds.S gets changed so it doesn't discard .eh_frame.
+	 * useful to anyone.  Note we should not use this directive if we
+	 * ever decide to enable DWARF unwinding at runtime.
 	 */
 	.cfi_sections .debug_frame
 #else
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e3296aa..5cab3a2 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -313,8 +313,8 @@ SECTIONS
 
 	. = ALIGN(8);
 	/*
-	 * .exit.text is discard at runtime, not link time, to deal with
-	 *  references from .altinstructions and .eh_frame
+	 * .exit.text is discarded at runtime, not link time, to deal with
+	 *  references from .altinstructions
 	 */
 	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
 		EXIT_TEXT
@@ -412,9 +412,6 @@ SECTIONS
 	DWARF_DEBUG
 
 	DISCARDS
-	/DISCARD/ : {
-		*(.eh_frame)
-	}
 }
 
 
diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
index 64d135d..63aa518 100644
--- a/arch/x86/realmode/rm/realmode.lds.S
+++ b/arch/x86/realmode/rm/realmode.lds.S
@@ -71,7 +71,6 @@ SECTIONS
 	/DISCARD/ : {
 		*(.note*)
 		*(.debug*)
-		*(.eh_frame*)
 	}
 
 #include "pasyms.h"
