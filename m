Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A90C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734002074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PwW1KHOJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+xX5bYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgIDNTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:19:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33092 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgIDNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:16:17 -0400
Date:   Fri, 04 Sep 2020 13:16:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPUeuegM9s5BaumW9br0HIcKOpgd6ZkBzxetSxktknw=;
        b=PwW1KHOJthPbgKTGxGQWzYdguffCE+4CVTKWwQ4tb2jDleE4EvW5eCVW2P+orJxXp5d5PB
        aj8qwoZNArGmugwb0nVDNhpYOXcpRiy9HxQGXdnt/fxI4ofLl9qEq89SyuGwA0RU+oU+IW
        FXSpJ2LdVzdKc54QS8li/0QjpuHFVGqmSpZeBNPVrqNe44+snxde7iWExMiIcTcf05k6C9
        b0mxRAwqvNXAOOV2VirJYOhSSH4BbanlT/JXnKBbWe2R+1T1ko87QKu5mPqZ0hL3VyEOgr
        ZlWk0CWrGuGQBHKC0tAU7urA8MbrgUlVtUNvj0g1WYW3YAI0ltDQXkpVyqMlOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPUeuegM9s5BaumW9br0HIcKOpgd6ZkBzxetSxktknw=;
        b=F+xX5bYYt95wBjx6+iMBaH2tasAKIYQhGHdQ7iBf3fzftmq90I8QmwIIID5fxWAsmBhSq2
        YZdVCC6xMnXWbDAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/debug: Move kprobe_debug_handler() into
 exc_debug_kernel()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902133200.847465360@infradead.org>
References: <20200902133200.847465360@infradead.org>
MIME-Version: 1.0
Message-ID: <159922537030.20229.16517218547936912662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     20a6e35a948284b8ab246ed35eefc56d674ad076
Gitweb:        https://git.kernel.org/tip/20a6e35a948284b8ab246ed35eefc56d674ad076
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 15:25:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:12:52 +02:00

x86/debug: Move kprobe_debug_handler() into exc_debug_kernel()

Kprobes are on kernel text, and thus only matter for #DB-from-kernel.
Kprobes are ordered before the generic notifier, preserve that order.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200902133200.847465360@infradead.org

---
 arch/x86/include/asm/kprobes.h |  4 ++++
 arch/x86/kernel/traps.c        | 10 ++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 143bc9a..991a7ad 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -106,5 +106,9 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
 extern int kprobe_int3_handler(struct pt_regs *regs);
 extern int kprobe_debug_handler(struct pt_regs *regs);
 
+#else
+
+static inline int kprobe_debug_handler(struct pt_regs *regs) { return 0; }
+
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_X86_KPROBES_H */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9945642..9cb39d3 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -806,12 +806,6 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
 	/* Store the virtualized DR6 value */
 	tsk->thread.debugreg6 = dr6;
 
-#ifdef CONFIG_KPROBES
-	if (kprobe_debug_handler(regs)) {
-		return;
-	}
-#endif
-
 	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
 		       SIGTRAP) == NOTIFY_STOP) {
 		return;
@@ -877,8 +871,12 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
 		dr6 &= ~DR_STEP;
 
+	if (kprobe_debug_handler(regs))
+		goto out;
+
 	handle_debug(regs, dr6, false);
 
+out:
 	instrumentation_end();
 	idtentry_exit_nmi(regs, irq_state);
 
