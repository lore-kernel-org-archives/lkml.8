Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7BDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CFE2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mgp+BSNJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+gJeOfYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgIDNRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbgIDNQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:16:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBBEC061247;
        Fri,  4 Sep 2020 06:16:16 -0700 (PDT)
Date:   Fri, 04 Sep 2020 13:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lEqcVtiq12CNI45Q5LAlHGgkYF+tcahcCSYD81MRbKw=;
        b=mgp+BSNJhM3zd/LR2N01SVulFLCDMjgVM0bXQGyH8UDDqjpmew0NXrf5lY0TgFz2BKNr8U
        EtrHOm7FRjEJrOBkOq8SP77Nbdo0WOhRy0FETU1fnhZvuv5VBFj8gvJWidDRd8AmY93JYo
        z0lV4AQWf46I4Y+3amRA2NVW/IU50mZb+nGCjFrPgcQupEsnswNiTUS1uWeZS30gkXl8Es
        9U7ml5Q6TWCSEfL9cJNiMy+auTh/8EDwu6iPQRlfDnQs2ql8a2Xf3EYrMB9QFLZD9s8Y0X
        jWbewI0vhr389QwyNW+n6VpAUQTXH/+YAG5sO/T85CsG7MQ95bfs2AB61dphhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lEqcVtiq12CNI45Q5LAlHGgkYF+tcahcCSYD81MRbKw=;
        b=+gJeOfYKuHfVd9yD3rOdgmgxujZTopU9jrCRqXgMYfdIzJTzZDb/sc+KNLFg64dI5J37At
        p2S/pDM3+Yz0afAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/debug: Move cond_local_irq_enable() block into
 exc_debug_user()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902133201.094265982@infradead.org>
References: <20200902133201.094265982@infradead.org>
MIME-Version: 1.0
Message-ID: <159922536850.20229.17354659676705985027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     f0b67c39c190e19bc1604a13bcc985c4445a4b2f
Gitweb:        https://git.kernel.org/tip/f0b67c39c190e19bc1604a13bcc985c4445a4b2f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 15:25:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:12:53 +02:00

x86/debug: Move cond_local_irq_enable() block into exc_debug_user()

The cond_local_irq_enable() block, dealing with vm86 and sending
signals is only relevant for #DB-from-user, move it there.

This then reduces handle_debug() to only the notifier call, so rename
it to notify_debug().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20200902133201.094265982@infradead.org

---
 arch/x86/kernel/traps.c | 58 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 2605686..682af24 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -783,17 +783,10 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
  *
  * May run on IST stack.
  */
-static bool handle_debug(struct pt_regs *regs, unsigned long *dr6)
+
+static bool notify_debug(struct pt_regs *regs, unsigned long *dr6)
 {
 	struct task_struct *tsk = current;
-	bool icebp;
-
-	/*
-	 * If dr6 has no reason to give us about the origin of this trap,
-	 * then it's very likely the result of an icebp/int01 trap.
-	 * User wants a sigtrap for that.
-	 */
-	icebp = !*dr6;
 
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = *dr6;
@@ -801,26 +794,9 @@ static bool handle_debug(struct pt_regs *regs, unsigned long *dr6)
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)dr6, 0, SIGTRAP) == NOTIFY_STOP)
 		return true;
 
-	/* It's safe to allow irq's after DR6 has been saved */
-	cond_local_irq_enable(regs);
-
-	if (v8086_mode(regs)) {
-		handle_vm86_trap((struct kernel_vm86_regs *) regs, 0,
-				 X86_TRAP_DB);
-		goto out;
-	}
-
-	/*
-	 * Reload dr6, the notifier might have changed it.
-	 */
+	/* Reload the DR6 value, the notifier might have changed it */
 	*dr6 = tsk->thread.debugreg6;
 
-	if (*dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
-		send_sigtrap(regs, 0, get_si_code(*dr6));
-
-out:
-	cond_local_irq_disable(regs);
-
 	return false;
 }
 
@@ -864,7 +840,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	if (!dr6)
 		goto out;
 
-	if (handle_debug(regs, &dr6))
+	if (notify_debug(regs, &dr6))
 		goto out;
 
 	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
@@ -889,6 +865,8 @@ out:
 static __always_inline void exc_debug_user(struct pt_regs *regs,
 					   unsigned long dr6)
 {
+	bool icebp;
+
 	/*
 	 * If something gets miswired and we end up here for a kernel mode
 	 * #DB, we will malfunction.
@@ -907,8 +885,30 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
-	handle_debug(regs, &dr6);
+	/*
+	 * If dr6 has no reason to give us about the origin of this trap,
+	 * then it's very likely the result of an icebp/int01 trap.
+	 * User wants a sigtrap for that.
+	 */
+	icebp = !dr6;
+
+	if (notify_debug(regs, &dr6))
+		goto out;
 
+	/* It's safe to allow irq's after DR6 has been saved */
+	local_irq_enable();
+
+	if (v8086_mode(regs)) {
+		handle_vm86_trap((struct kernel_vm86_regs *)regs, 0, X86_TRAP_DB);
+		goto out_irq;
+	}
+
+	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
+		send_sigtrap(regs, 0, get_si_code(dr6));
+
+out_irq:
+	local_irq_disable();
+out:
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
 }
