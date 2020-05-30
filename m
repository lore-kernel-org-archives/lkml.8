Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC63C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03DA208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgE3J6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgE3J5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE294C03E969;
        Sat, 30 May 2020 02:57:24 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyEz-0002ri-EM; Sat, 30 May 2020 11:57:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1AC871C032F;
        Sat, 30 May 2020 11:57:21 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:20 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry, nmi: Disable #DB
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200529213321.069223695@infradead.org>
References: <20200529213321.069223695@infradead.org>
MIME-Version: 1.0
Message-ID: <159083264093.17951.18261751071508007214.tip-bot2@tip-bot2>
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

Commit-ID:     af87e4c4d65b2008709efcfb7657551f1c62a98b
Gitweb:        https://git.kernel.org/tip/af87e4c4d65b2008709efcfb7657551f1c62a98b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 May 2020 23:27:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 10:00:07 +02:00

x86/entry, nmi: Disable #DB

Instead of playing stupid games with IST stacks, fully disallow #DB
during NMIs. There is absolutely no reason to allow them, and killing
this saves a heap of trouble.

#DB is already forbidden on noinstr and CEA, so there can't be a #DB before
this. Disabling it right after nmi_enter() ensures that the full NMI code
is protected.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200529213321.069223695@infradead.org

---
 arch/x86/kernel/nmi.c | 55 ++----------------------------------------
 1 file changed, 3 insertions(+), 52 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 1c58454..52a708e 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -478,40 +478,7 @@ enum nmi_states {
 };
 static DEFINE_PER_CPU(enum nmi_states, nmi_state);
 static DEFINE_PER_CPU(unsigned long, nmi_cr2);
-
-#ifdef CONFIG_X86_64
-/*
- * In x86_64, we need to handle breakpoint -> NMI -> breakpoint.  Without
- * some care, the inner breakpoint will clobber the outer breakpoint's
- * stack.
- *
- * If a breakpoint is being processed, and the debug stack is being
- * used, if an NMI comes in and also hits a breakpoint, the stack
- * pointer will be set to the same fixed address as the breakpoint that
- * was interrupted, causing that stack to be corrupted. To handle this
- * case, check if the stack that was interrupted is the debug stack, and
- * if so, change the IDT so that new breakpoints will use the current
- * stack and not switch to the fixed address. On return of the NMI,
- * switch back to the original IDT.
- */
-static DEFINE_PER_CPU(int, update_debug_stack);
-
-static noinstr bool is_debug_stack(unsigned long addr)
-{
-	struct cea_exception_stacks *cs = __this_cpu_read(cea_exception_stacks);
-	unsigned long top = CEA_ESTACK_TOP(cs, DB);
-	unsigned long bot = CEA_ESTACK_BOT(cs, DB1);
-
-	if (__this_cpu_read(debug_stack_usage))
-		return true;
-	/*
-	 * Note, this covers the guard page between DB and DB1 as well to
-	 * avoid two checks. But by all means @addr can never point into
-	 * the guard page.
-	 */
-	return addr >= bot && addr < top;
-}
-#endif
+static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
 DEFINE_IDTENTRY_NMI(exc_nmi)
 {
@@ -526,18 +493,7 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
 	this_cpu_write(nmi_cr2, read_cr2());
 nmi_restart:
 
-#ifdef CONFIG_X86_64
-	/*
-	 * If we interrupted a breakpoint, it is possible that
-	 * the nmi handler will have breakpoints too. We need to
-	 * change the IDT such that breakpoints that happen here
-	 * continue to use the NMI stack.
-	 */
-	if (unlikely(is_debug_stack(regs->sp))) {
-		debug_stack_set_zero();
-		this_cpu_write(update_debug_stack, 1);
-	}
-#endif
+	this_cpu_write(nmi_dr7, local_db_save());
 
 	nmi_enter();
 
@@ -548,12 +504,7 @@ nmi_restart:
 
 	nmi_exit();
 
-#ifdef CONFIG_X86_64
-	if (unlikely(this_cpu_read(update_debug_stack))) {
-		debug_stack_reset();
-		this_cpu_write(update_debug_stack, 0);
-	}
-#endif
+	local_db_restore(this_cpu_read(nmi_dr7));
 
 	if (unlikely(this_cpu_read(nmi_cr2) != read_cr2()))
 		write_cr2(this_cpu_read(nmi_cr2));
