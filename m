Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAF9C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAEF20C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hDVrIMFK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6EcgC3A5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbgIJJcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:32:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38878 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbgIJJX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:23:56 -0400
Date:   Thu, 10 Sep 2020 09:22:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=559eYn0+zGFrJgaT6n4suexnrRJnXvuMct+n0omTPzE=;
        b=hDVrIMFKl+85Mi1nS5WTzmEF8sVgv7vXxnPoQlToRhVGKrNyXyxw2Z43huKjkPZvqKjdrq
        3RQYEpKPVgrEGEckypJc/3Gx63Igjq3eCwyzJt0Is+xK6QmX50+QZYpjJDkWrzOCoYZYl9
        DyEH3QyGvwfbZzHnntQqbXJReP1Zfpz5bUgiZVP4nZBfp+bk3FjoGLBH5SQiSNS0ybf8Yq
        MWpfUY0dbM3whcBD62MJPLRq3VVURF59d1GO4DCD2uL8HeVXnwsfix2UozomseXfV7rCMc
        d2lIXRILr3AdS98aUr3yyPSITBlR6OF113V4sasTr1G23grGzqu1XDf7WRUNjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=559eYn0+zGFrJgaT6n4suexnrRJnXvuMct+n0omTPzE=;
        b=6EcgC3A5MQ/L3vAPpMeohqTg8joNblCSLKuw2Ubil9ou6Rxb+Rxz3cnVAArLpF5/udu3Te
        7yipl89hidgD77Ag==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/traps: Move pf error codes to <asm/trap_pf.h>
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-7-joro@8bytes.org>
References: <20200907131613.12703-7-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972975027.20229.5656739170408401125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     05a2fdf3230306daee1def019b8f52cd06bd2e48
Gitweb:        https://git.kernel.org/tip/05a2fdf3230306daee1def019b8f52cd06bd2e48
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:07 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:24 +02:00

x86/traps: Move pf error codes to <asm/trap_pf.h>

Move the definition of the x86 page-fault error code bits to a new
header file asm/trap_pf.h. This makes it easier to include them into
pre-decompression boot code. No functional changes.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-7-joro@8bytes.org
---
 arch/x86/include/asm/trap_pf.h | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/traps.h   | 19 +------------------
 2 files changed, 25 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/include/asm/trap_pf.h

diff --git a/arch/x86/include/asm/trap_pf.h b/arch/x86/include/asm/trap_pf.h
new file mode 100644
index 0000000..305bc12
--- /dev/null
+++ b/arch/x86/include/asm/trap_pf.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_TRAP_PF_H
+#define _ASM_X86_TRAP_PF_H
+
+/*
+ * Page fault error code bits:
+ *
+ *   bit 0 ==	 0: no page found	1: protection fault
+ *   bit 1 ==	 0: read access		1: write access
+ *   bit 2 ==	 0: kernel-mode access	1: user-mode access
+ *   bit 3 ==				1: use of reserved bit detected
+ *   bit 4 ==				1: fault was an instruction fetch
+ *   bit 5 ==				1: protection keys block access
+ */
+enum x86_pf_error_code {
+	X86_PF_PROT	=		1 << 0,
+	X86_PF_WRITE	=		1 << 1,
+	X86_PF_USER	=		1 << 2,
+	X86_PF_RSVD	=		1 << 3,
+	X86_PF_INSTR	=		1 << 4,
+	X86_PF_PK	=		1 << 5,
+};
+
+#endif /* _ASM_X86_TRAP_PF_H */
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 714b1a3..6a30835 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -8,6 +8,7 @@
 #include <asm/debugreg.h>
 #include <asm/idtentry.h>
 #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
+#include <asm/trap_pf.h>
 
 #ifdef CONFIG_X86_64
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
@@ -41,22 +42,4 @@ void __noreturn handle_stack_overflow(const char *message,
 				      unsigned long fault_address);
 #endif
 
-/*
- * Page fault error code bits:
- *
- *   bit 0 ==	 0: no page found	1: protection fault
- *   bit 1 ==	 0: read access		1: write access
- *   bit 2 ==	 0: kernel-mode access	1: user-mode access
- *   bit 3 ==				1: use of reserved bit detected
- *   bit 4 ==				1: fault was an instruction fetch
- *   bit 5 ==				1: protection keys block access
- */
-enum x86_pf_error_code {
-	X86_PF_PROT	=		1 << 0,
-	X86_PF_WRITE	=		1 << 1,
-	X86_PF_USER	=		1 << 2,
-	X86_PF_RSVD	=		1 << 3,
-	X86_PF_INSTR	=		1 << 4,
-	X86_PF_PK	=		1 << 5,
-};
 #endif /* _ASM_X86_TRAPS_H */
