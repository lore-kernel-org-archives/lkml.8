Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A1EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103EB20747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M6i/pD9i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOb0yIKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgGAIf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgGAIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:35:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A922FC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:35:56 -0700 (PDT)
Date:   Wed, 1 Jul 2020 10:35:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593592555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LFia8MivRxV7u9Ly6ju5ELq3Qzf1QD4CMLWdNVkzCTM=;
        b=M6i/pD9i9uXW4Ed/VrVjoYK97wsCG31H7MLC65pLZje9vH+B0vh/7I0/fWOlA0EQPJKqGF
        u0INOzb7FB2MfEUFshoyi/4RflPRIWNnfmR0iBlVB19XkAIFg9+DSdcVKy5dqVeXRqsUS0
        LKG9Ag62MFiUaIdpoqHbapFGyMDIr6lOfMvhyxcf/3H3kaY/cZlg8z1p0kVR3i6BncEVdI
        egpJkTr1YQO7+/5zqJiu7KbcQnooMSpUw+VO+w+/bX+CIyA3qjAUprhMg82FbDDjBTwuZg
        wRjVMAfIh4eXCJJrl5fC/bkCOxD/yxNuTpa8yno5V9fgzDrGyyWfnMuRkI7F5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593592555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LFia8MivRxV7u9Ly6ju5ELq3Qzf1QD4CMLWdNVkzCTM=;
        b=OOb0yIKmBEhb1K6p9Nv2perDWtgKjoQwkSjTqh7MgwDA8dYkRIYncjsNRUvyA8dTlVrfju
        ilWmid67+9b3uWBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin " <hpa@zytor.com>
Subject: [PATCH v2] x86/entry: Use should_resched() in
 idtentry_exit_cond_resched()
Message-ID: <20200701083553.fuy42cllxvx3bkzp@linutronix.de>
References: <20200630102209.1143072-1-bigeasy@linutronix.de>
 <20200630102209.1143072-2-bigeasy@linutronix.de>
 <20200630111012.GM4800@hirez.programming.kicks-ass.net>
 <20200630120059.x5p6uh4hzgqrgwuo@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200630120059.x5p6uh4hzgqrgwuo@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIF_NEED_RESCHED bit is inlined on x86 into the preemption counter.
By using should_resched(0) instead of need_resched() the same check can
be performed which uses the same variable as 'preempt_count()` which was
issued before.

Use should_resched(0) instead need_resched().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2: Use should_resched() but keep the !preempt_count() check.

 arch/x86/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index bd3f14175193c..0bb6966f62738 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -615,11 +615,11 @@ static void idtentry_exit_cond_resched(struct pt_regs=
 *regs, bool may_sched)
 	if (may_sched && !preempt_count()) {
 		/* Sanity check RCU and thread stack */
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched())
+		if (should_resched(0))
 			preempt_schedule_irq();
 	}
 	/* Covers both tracing and lockdep */
 	trace_hardirqs_on();
 }
--=20
2.27.0

