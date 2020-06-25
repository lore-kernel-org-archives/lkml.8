Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DCEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CC020781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404579AbgFYLyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404364AbgFYLxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9773C0613ED;
        Thu, 25 Jun 2020 04:53:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1joQRh-0005sR-FK; Thu, 25 Jun 2020 13:53:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 268D71C047D;
        Thu, 25 Jun 2020 13:53:33 +0200 (CEST)
Date:   Thu, 25 Jun 2020 11:53:32 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Fixup bad_iret vs noinstr
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200618144801.760070502@infradead.org>
References: <20200618144801.760070502@infradead.org>
MIME-Version: 1.0
Message-ID: <159308601294.16989.6717371293673263499.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     e3a9e681adb779b39565a28b3252c3be1033f994
Gitweb:        https://git.kernel.org/tip/e3a9e681adb779b39565a28b3252c3be1033f994
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 17 Jun 2020 18:21:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Jun 2020 13:45:39 +02:00

x86/entry: Fixup bad_iret vs noinstr

vmlinux.o: warning: objtool: fixup_bad_iret()+0x8e: call to memcpy() leaves .noinstr.text section

Worse, when KASAN there is no telling what memcpy() actually is. Force
the use of __memcpy() which is our assmebly implementation.

Reported-by: Marco Elver <elver@google.com>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200618144801.760070502@infradead.org
---
 arch/x86/kernel/traps.c  | 6 +++---
 arch/x86/lib/memcpy_64.S | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index af75109..a7d1570 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -690,13 +690,13 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
 
 	/* Copy the IRET target to the temporary storage. */
-	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
+	__memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
 
 	/* Copy the remainder of the stack from the current stack. */
-	memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
+	__memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
 
 	/* Update the entry stack */
-	memcpy(new_stack, &tmp, sizeof(tmp));
+	__memcpy(new_stack, &tmp, sizeof(tmp));
 
 	BUG_ON(!user_mode(&new_stack->regs));
 	return new_stack;
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 56b243b..bbcc05b 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -8,6 +8,8 @@
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
 
+.pushsection .noinstr.text, "ax"
+
 /*
  * We build a jump to memcpy_orig by default which gets NOPped out on
  * the majority of x86 CPUs which set REP_GOOD. In addition, CPUs which
@@ -184,6 +186,8 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
 	retq
 SYM_FUNC_END(memcpy_orig)
 
+.popsection
+
 #ifndef CONFIG_UML
 
 MCSAFE_TEST_CTL
