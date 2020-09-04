Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498A7C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179C12074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hr+jYh0O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+28Ki0TH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgIDNTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbgIDNQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:16:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A988C061249;
        Fri,  4 Sep 2020 06:16:16 -0700 (PDT)
Date:   Fri, 04 Sep 2020 13:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDm/8lwmDPTF9yn4NOZs0HVabUPkEA9sgGYYJ1ycOhw=;
        b=Hr+jYh0OLNBN6dmjVIKsFT3jsBHOUxFzyJZa41reBlevD/kVL1EJpHolvDFVRNSMSO5whn
        8IS6XwGjyuh2O23FLwyoSf3LxANb7eKi3pPh4XohV57bvPH5i1kXH99ufVD2xJZwYVBHNR
        xB12yDGXP/L4C5PnPiih3R/oKHxKPNt5q6Xw9lbnPBgPGcvH7iEQ3LoUb/lNeehSuQls+X
        3z9GeqgqVPvf/DTWBgnYD8aAtTi4UkNfm8Wft7H+W7kWBDgnMb8KeGgnvI/+xP42Aj8mLc
        WsUOK4hgECMJGUwHgySikhTDb3IaMEf3hIppD04Mq94m35Vc/tVE1kWRdwXRHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDm/8lwmDPTF9yn4NOZs0HVabUPkEA9sgGYYJ1ycOhw=;
        b=+28Ki0THbmtJzNKviYmV2ukShV9FZhyvKRTr0WEE9DSoX0pzCV9KmWBSL519LZgkP2Mw6S
        hv3zy/GxuUGs0GBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/debug: Move historical SYSENTER junk into
 exc_debug_kernel()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902133201.031099736@infradead.org>
References: <20200902133201.031099736@infradead.org>
MIME-Version: 1.0
Message-ID: <159922536893.20229.7238736483241139926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     4eb5acc39187a7ba578fbb44f7bb1965057309ae
Gitweb:        https://git.kernel.org/tip/4eb5acc39187a7ba578fbb44f7bb1965057309ae
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 15:25:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:12:53 +02:00

x86/debug: Move historical SYSENTER junk into exc_debug_kernel()

The historical SYSENTER junk is explicitly for from-kernel, so move it
to the #DB-from-kernel handler.

It is ordered after the notifier, which is important for KGDB which uses TF
single-step and needs to consume the event before that point.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20200902133201.031099736@infradead.org

---
 arch/x86/kernel/traps.c | 49 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 24e09f8..2605686 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -783,7 +783,7 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
  *
  * May run on IST stack.
  */
-static void handle_debug(struct pt_regs *regs, unsigned long dr6)
+static bool handle_debug(struct pt_regs *regs, unsigned long *dr6)
 {
 	struct task_struct *tsk = current;
 	bool icebp;
@@ -793,15 +793,13 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6)
 	 * then it's very likely the result of an icebp/int01 trap.
 	 * User wants a sigtrap for that.
 	 */
-	icebp = !dr6;
+	icebp = !*dr6;
 
 	/* Store the virtualized DR6 value */
-	tsk->thread.debugreg6 = dr6;
+	tsk->thread.debugreg6 = *dr6;
 
-	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
-		       SIGTRAP) == NOTIFY_STOP) {
-		return;
-	}
+	if (notify_die(DIE_DEBUG, "debug", regs, (long)dr6, 0, SIGTRAP) == NOTIFY_STOP)
+		return true;
 
 	/* It's safe to allow irq's after DR6 has been saved */
 	cond_local_irq_enable(regs);
@@ -815,25 +813,15 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6)
 	/*
 	 * Reload dr6, the notifier might have changed it.
 	 */
-	dr6 = tsk->thread.debugreg6;
+	*dr6 = tsk->thread.debugreg6;
 
-	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
-		/*
-		 * Historical junk that used to handle SYSENTER single-stepping.
-		 * This should be unreachable now.  If we survive for a while
-		 * without anyone hitting this warning, we'll turn this into
-		 * an oops.
-		 */
-		tsk->thread.debugreg6 &= ~DR_STEP;
-		set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
-		regs->flags &= ~X86_EFLAGS_TF;
-	}
-
-	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
-		send_sigtrap(regs, 0, get_si_code(dr6));
+	if (*dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
+		send_sigtrap(regs, 0, get_si_code(*dr6));
 
 out:
 	cond_local_irq_disable(regs);
+
+	return false;
 }
 
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
@@ -876,7 +864,20 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	if (!dr6)
 		goto out;
 
-	handle_debug(regs, dr6);
+	if (handle_debug(regs, &dr6))
+		goto out;
+
+	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
+		/*
+		 * Historical junk that used to handle SYSENTER single-stepping.
+		 * This should be unreachable now.  If we survive for a while
+		 * without anyone hitting this warning, we'll turn this into
+		 * an oops.
+		 */
+		dr6 &= ~DR_STEP;
+		set_thread_flag(TIF_SINGLESTEP);
+		regs->flags &= ~X86_EFLAGS_TF;
+	}
 
 out:
 	instrumentation_end();
@@ -906,7 +907,7 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, dr6);
+	handle_debug(regs, &dr6);
 
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
