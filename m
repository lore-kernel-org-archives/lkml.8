Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F464C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8CD2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SR/7Oa0t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ls8q9v0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgIDNRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:17:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32982 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730206AbgIDNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:16:09 -0400
Date:   Fri, 04 Sep 2020 13:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qobBc7jugMWEn3PyjODe4q+R+sAtvov1te4L//1C8i4=;
        b=SR/7Oa0t4lX4wqSfHFE/9tNc+o8Wbrj0l5K35VAVpXNkkq+7CLw/GN3PhA1oepQfWx3Sts
        xADa5hXhgriP/dEm4zNkaEkzefy9X2sF3Khh+MD8FxGGbVpK0JTanOUxM5yRhJj7c8TWsf
        bqLqOa8MCgH2Ttxuqh0uYDJwC3j6WKbhbRbEWEU9aa4cWM8C5reQplhqW5Fl/kc3HRm12b
        TCMRoNg6CEQ7TeWELc0fywr2HzkJmex/KLnOskRlc7+HMv7auZ8In7OFu5SAawPxIDZ7xA
        zdaiPHVkmtTRB/CMbuVTADDa7PdGoHKuQ80zCFFn90JS349ecF2vdT4aqb6l2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qobBc7jugMWEn3PyjODe4q+R+sAtvov1te4L//1C8i4=;
        b=ls8q9v0sqBS6tglmMEyM92vNi4XiT1/IAtyOtaZOL4fbXMlVwsxuBkPUa0CIjsG1Saokix
        0xis/HhXYEwAoxDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/debug: Change thread.debugreg6 to thread.virtual_dr6
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902133201.415372940@infradead.org>
References: <20200902133201.415372940@infradead.org>
MIME-Version: 1.0
Message-ID: <159922536629.20229.10405853453958986161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     d53d9bc0cf783e93b374de3895145c7375e570ba
Gitweb:        https://git.kernel.org/tip/d53d9bc0cf783e93b374de3895145c7375e570ba
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 15:26:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:12:58 +02:00

x86/debug: Change thread.debugreg6 to thread.virtual_dr6

Current usage of thread.debugreg6 is convoluted at best. It starts life as
a copy of the hardware DR6 value, but then various bits are cleared and
set.

Replace this with a new variable thread.virtual_dr6 that is initialized to
0 when DR6 is read and only gains bits, at the same time the actual (on
stack) dr6 value which is read from the hardware only gets bits cleared.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20200902133201.415372940@infradead.org

---
 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/kernel/hw_breakpoint.c  | 12 +++---------
 arch/x86/kernel/kgdb.c           |  5 +++--
 arch/x86/kernel/ptrace.c         |  6 +++---
 arch/x86/kernel/traps.c          | 25 ++++++++++++++++---------
 5 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 97143d8..d8a82e6 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -517,7 +517,7 @@ struct thread_struct {
 	/* Save middle states of ptrace breakpoints */
 	struct perf_event	*ptrace_bps[HBP_NUM];
 	/* Debug status used for traps, single steps, etc... */
-	unsigned long           debugreg6;
+	unsigned long           virtual_dr6;
 	/* Keep track of the exact dr7 value set by the user */
 	unsigned long           ptrace_dr7;
 	/* Fault info: */
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index d17a1da..03aa33b 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -454,7 +454,7 @@ void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
 		t->ptrace_bps[i] = NULL;
 	}
 
-	t->debugreg6 = 0;
+	t->virtual_dr6 = 0;
 	t->ptrace_dr7 = 0;
 }
 
@@ -489,8 +489,8 @@ static int hw_breakpoint_handler(struct die_args *args)
 {
 	int i, rc = NOTIFY_STOP;
 	struct perf_event *bp;
-	unsigned long dr6;
 	unsigned long *dr6_p;
+	unsigned long dr6;
 
 	/* The DR6 value is pointed by args->err */
 	dr6_p = (unsigned long *)ERR_PTR(args->err);
@@ -504,12 +504,6 @@ static int hw_breakpoint_handler(struct die_args *args)
 	if ((dr6 & DR_TRAP_BITS) == 0)
 		return NOTIFY_DONE;
 
-	/*
-	 * Reset the DRn bits in the virtualized register value.
-	 * The ptrace trigger routine will add in whatever is needed.
-	 */
-	current->thread.debugreg6 &= ~DR_TRAP_BITS;
-
 	/* Handle all the breakpoints that were triggered */
 	for (i = 0; i < HBP_NUM; ++i) {
 		if (likely(!(dr6 & (DR_TRAP0 << i))))
@@ -554,7 +548,7 @@ static int hw_breakpoint_handler(struct die_args *args)
 	 * breakpoints (to generate signals) and b) when the system has
 	 * taken exception due to multiple causes
 	 */
-	if ((current->thread.debugreg6 & DR_TRAP_BITS) ||
+	if ((current->thread.virtual_dr6 & DR_TRAP_BITS) ||
 	    (dr6 & (~DR_TRAP_BITS)))
 		rc = NOTIFY_DONE;
 
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index c2f02f3..ff7878d 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -629,9 +629,10 @@ static void kgdb_hw_overflow_handler(struct perf_event *event,
 	struct task_struct *tsk = current;
 	int i;
 
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < 4; i++) {
 		if (breakinfo[i].enabled)
-			tsk->thread.debugreg6 |= (DR_TRAP0 << i);
+			tsk->thread.virtual_dr6 |= (DR_TRAP0 << i);
+	}
 }
 
 void kgdb_arch_late(void)
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 5f98289..bedca01 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -465,7 +465,7 @@ static void ptrace_triggered(struct perf_event *bp,
 			break;
 	}
 
-	thread->debugreg6 |= (DR_TRAP0 << i);
+	thread->virtual_dr6 |= (DR_TRAP0 << i);
 }
 
 /*
@@ -601,7 +601,7 @@ static unsigned long ptrace_get_debugreg(struct task_struct *tsk, int n)
 		if (bp)
 			val = bp->hw.info.address;
 	} else if (n == 6) {
-		val = thread->debugreg6 ^ DR6_RESERVED; /* Flip back to arch polarity */
+		val = thread->virtual_dr6 ^ DR6_RESERVED; /* Flip back to arch polarity */
 	} else if (n == 7) {
 		val = thread->ptrace_dr7;
 	}
@@ -657,7 +657,7 @@ static int ptrace_set_debugreg(struct task_struct *tsk, int n,
 	if (n < HBP_NUM) {
 		rc = ptrace_set_breakpoint_addr(tsk, n, val);
 	} else if (n == 6) {
-		thread->debugreg6 = val ^ DR6_RESERVED; /* Flip to positive polarity */
+		thread->virtual_dr6 = val ^ DR6_RESERVED; /* Flip to positive polarity */
 		rc = 0;
 	} else if (n == 7) {
 		rc = ptrace_write_dr7(tsk, val);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 114515b..df9c655 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -749,6 +749,12 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
 	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
 
 	/*
+	 * Clear the virtual DR6 value, ptrace routines will set bits here for
+	 * things we want signals for.
+	 */
+	current->thread.virtual_dr6 = 0;
+
+	/*
 	 * The SDM says "The processor clears the BTF flag when it
 	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
 	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
@@ -785,17 +791,16 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
 
 static bool notify_debug(struct pt_regs *regs, unsigned long *dr6)
 {
-	struct task_struct *tsk = current;
-
-	/* Store the virtualized DR6 value */
-	tsk->thread.debugreg6 = *dr6;
-
+	/*
+	 * Notifiers will clear bits in @dr6 to indicate the event has been
+	 * consumed - hw_breakpoint_handler(), single_stop_cont().
+	 *
+	 * Notifiers will set bits in @virtual_dr6 to indicate the desire
+	 * for signals - ptrace_triggered(), kgdb_hw_overflow_handler().
+	 */
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)dr6, 0, SIGTRAP) == NOTIFY_STOP)
 		return true;
 
-	/* Reload the DR6 value, the notifier might have changed it */
-	*dr6 = tsk->thread.debugreg6;
-
 	return false;
 }
 
@@ -853,7 +858,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 * A known way to trigger this is through QEMU's GDB stub,
 	 * which leaks #DB into the guest and causes IST recursion.
 	 */
-	if (WARN_ON_ONCE(current->thread.debugreg6 & DR_STEP))
+	if (WARN_ON_ONCE(dr6 & DR_STEP))
 		regs->flags &= ~X86_EFLAGS_TF;
 out:
 	instrumentation_end();
@@ -903,6 +908,8 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 		goto out_irq;
 	}
 
+	/* Add the virtual_dr6 bits for signals. */
+	dr6 |= current->thread.virtual_dr6;
 	if (dr6 & (DR_STEP | DR_TRAP_BITS) || icebp)
 		send_sigtrap(regs, 0, get_si_code(dr6));
 
