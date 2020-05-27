Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0A2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393D0216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbgE0IMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbgE0IMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F784C061A0F;
        Wed, 27 May 2020 01:12:08 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAU-0002g7-UQ; Wed, 27 May 2020 10:12:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0B7911C0481;
        Wed, 27 May 2020 10:12:00 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:59 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idtentry: Switch to conditional RCU handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202117.382387286@linutronix.de>
References: <20200521202117.382387286@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711983.17951.10402741424912392408.tip-bot2@tip-bot2>
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

Commit-ID:     77d7843297dfe3bbd997a46548c9cdd8047ecffe
Gitweb:        https://git.kernel.org/tip/77d7843297dfe3bbd997a46548c9cdd8047ecffe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:19 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:27 +02:00

x86/idtentry: Switch to conditional RCU handling

Switch all idtentry_enter/exit() users over to the new conditional RCU
handling scheme and make the user mode entries in #DB, #INT3 and #MCE use
the user mode idtentry functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202117.382387286@linutronix.de
---
 arch/x86/include/asm/idtentry.h | 10 ++++++----
 arch/x86/kernel/cpu/mce/core.c  |  4 ++--
 arch/x86/kernel/traps.c         | 10 +++++-----
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b3aca72..0f974e5 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -61,11 +61,12 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	idtentry_enter(regs);						\
+	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+									\
 	instrumentation_begin();					\
 	__##func (regs);						\
 	instrumentation_end();						\
-	idtentry_exit(regs);						\
+	idtentry_exit_cond_rcu(regs, rcu_exit);				\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
@@ -107,11 +108,12 @@ static __always_inline void __##func(struct pt_regs *regs,		\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	idtentry_enter(regs);						\
+	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+									\
 	instrumentation_begin();					\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
-	idtentry_exit(regs);						\
+	idtentry_exit_cond_rcu(regs, rcu_exit);				\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs,		\
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a32a7e2..c47f004 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1929,11 +1929,11 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
-	idtentry_enter(regs);
+	idtentry_enter_user(regs);
 	instrumentation_begin();
 	machine_check_vector(regs);
 	instrumentation_end();
-	idtentry_exit(regs);
+	idtentry_exit_user(regs);
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9e5d81c..f28be3e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -619,18 +619,18 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		return;
 
 	/*
-	 * idtentry_enter() uses static_branch_{,un}likely() and therefore
+	 * idtentry_enter_user() uses static_branch_{,un}likely() and therefore
 	 * can trigger INT3, hence poke_int3_handler() must be done
 	 * before. If the entry came from kernel mode, then use nmi_enter()
 	 * because the INT3 could have been hit in any context including
 	 * NMI.
 	 */
 	if (user_mode(regs)) {
-		idtentry_enter(regs);
+		idtentry_enter_user(regs);
 		instrumentation_begin();
 		do_int3_user(regs);
 		instrumentation_end();
-		idtentry_exit(regs);
+		idtentry_exit_user(regs);
 	} else {
 		nmi_enter();
 		instrumentation_begin();
@@ -877,7 +877,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 static __always_inline void exc_debug_user(struct pt_regs *regs,
 					   unsigned long dr6)
 {
-	idtentry_enter(regs);
+	idtentry_enter_user(regs);
 	clear_thread_flag(TIF_BLOCKSTEP);
 
 	/*
@@ -886,7 +886,7 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	 * User wants a sigtrap for that.
 	 */
 	handle_debug(regs, dr6, !dr6);
-	idtentry_exit(regs);
+	idtentry_exit_user(regs);
 }
 
 #ifdef CONFIG_X86_64
