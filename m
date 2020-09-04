Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A14C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E6420829
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YhENLyAq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RUxAuZei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgIDNUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:20:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33062 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbgIDNQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:16:15 -0400
Date:   Fri, 04 Sep 2020 13:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3IxuXzTOiDsFfat8ZpZ7vkEV+rv4J2Ry7IdzjEuFX8=;
        b=YhENLyAq5iGdhAeyEt3vh+izzQHU83J8YExlcODUkecPL0IGeokzTLPXfK+07mdcVCobnc
        IOyMiNUWiL8JLsHNmb+k7vGcn/aiPQ9d5A55DEAcoN2edVqImIRL6CoxyM8vqB3nEAynFm
        BxYaGq99/u3x3uWNHMLMeGWZiBXeIX/3NrThtnChMyUZrw2EWrVF0JD8mTRBxfdMm3Z807
        ftw/8u3bgZYsnm3/Ki2J/+FP3T71DXHrpQPinetLgxnPCVMrZ9BNju07CYHAfQiJsoffMg
        3Z0nVkcrYmAwhkBvolynyAuNKfCb8Zf5vLX7Wqv0I2d/XeS1Zwt4jBja2fbRBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3IxuXzTOiDsFfat8ZpZ7vkEV+rv4J2Ry7IdzjEuFX8=;
        b=RUxAuZeigpuOG90+2REeuI1JFxuGHpbnD32grFjPnAVDaDiUH2p4YF7n5ScWbmyQ5Oj9rq
        xD2Ozz7AAcq59dCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/debug: Remove the historical junk
Cc:     Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902133201.170216274@infradead.org>
References: <20200902133201.170216274@infradead.org>
MIME-Version: 1.0
Message-ID: <159922536806.20229.4215385228775090226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     389cd0cd8b3790b555c3679da946f4aa4fba3bab
Gitweb:        https://git.kernel.org/tip/389cd0cd8b3790b555c3679da946f4aa4fba3bab
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 15:25:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:12:55 +02:00

x86/debug: Remove the historical junk

Remove the historical junk and replace it with a WARN and a comment.

The problem is that even though the kernel only uses TF single-step in
kprobes and KGDB, both of which consume the event before this, QEMU/KVM has
bugs in this area that can trigger this state so it has to be dealt with.

Suggested-by: Brian Gerst <brgerst@gmail.com>
Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20200902133201.170216274@infradead.org

---
 arch/x86/kernel/traps.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 682af24..1e89001 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -843,18 +843,19 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	if (notify_debug(regs, &dr6))
 		goto out;
 
-	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
-		/*
-		 * Historical junk that used to handle SYSENTER single-stepping.
-		 * This should be unreachable now.  If we survive for a while
-		 * without anyone hitting this warning, we'll turn this into
-		 * an oops.
-		 */
-		dr6 &= ~DR_STEP;
-		set_thread_flag(TIF_SINGLESTEP);
+	/*
+	 * The kernel doesn't use TF single-step outside of:
+	 *
+	 *  - Kprobes, consumed through kprobe_debug_handler()
+	 *  - KGDB, consumed through notify_debug()
+	 *
+	 * So if we get here with DR_STEP set, something is wonky.
+	 *
+	 * A known way to trigger this is through QEMU's GDB stub,
+	 * which leaks #DB into the guest and causes IST recursion.
+	 */
+	if (WARN_ON_ONCE(current->thread.debugreg6 & DR_STEP))
 		regs->flags &= ~X86_EFLAGS_TF;
-	}
-
 out:
 	instrumentation_end();
 	idtentry_exit_nmi(regs, irq_state);
