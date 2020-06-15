Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA7AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731B2207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgFOT2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgFOT2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:28:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E6CC05BD43;
        Mon, 15 Jun 2020 12:28:16 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jkumD-0002wk-OX; Mon, 15 Jun 2020 21:28:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2123B1C00ED;
        Mon, 15 Jun 2020 21:28:13 +0200 (CEST)
Date:   Mon, 15 Jun 2020 19:28:12 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/asm: Unify __ASSEMBLY__ blocks
Cc:     Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200604133204.7636-1-bp@alien8.de>
References: <20200604133204.7636-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <159224929288.16989.16009858447868087390.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     28b60197b573cd0b2d8f0ded56a5441c6147af14
Gitweb:        https://git.kernel.org/tip/28b60197b573cd0b2d8f0ded56a5441c6147af14
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 04 Jun 2020 12:50:44 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Jun 2020 19:29:36 +02:00

x86/asm: Unify __ASSEMBLY__ blocks

Merge the two ifndef __ASSEMBLY__ blocks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200604133204.7636-1-bp@alien8.de
---
 arch/x86/include/asm/asm.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 0f63585..5c15f95 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -144,7 +144,7 @@
 	_ASM_PTR (entry);					\
 	.popsection
 
-#else
+#else /* ! __ASSEMBLY__ */
 # define _EXPAND_EXTABLE_HANDLE(x) #x
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
 	" .pushsection \"__ex_table\",\"a\"\n"			\
@@ -164,9 +164,7 @@
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
 /* For C file, we already have NOKPROBE_SYMBOL macro */
-#endif
 
-#ifndef __ASSEMBLY__
 /*
  * This output constraint should be used for any inline asm which has a "call"
  * instruction.  Otherwise the asm may be inserted before the frame pointer
@@ -175,6 +173,6 @@
  */
 register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
-#endif
+#endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_ASM_H */
