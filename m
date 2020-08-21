Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC37AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B3A20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gksTdrf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgHUKVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgHUKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:21:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8680EC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1KthyYVeQG1Z3bnv0wlVVPWU8hBkSXSEYySbte/Kc5k=; b=gksTdrf1eVCOxQMJkS4ma+Mb13
        b/KJFUpWrOCg8G0SF4/Sd2aL6+/WNTaViL87MoOsKKJ7scGbXlsG3igcVy23ZPh79gvTb+/keQL9k
        V5nCSqQghaNBXd/oJF52CjlfMeXmuz24r4R+Vcq7H5yoGmNIElymytltsxFTwly62AuSWLFiAuQDU
        LW7KA5wQ+RGmlGczlijaelFGXDQStnBB1gt7jro5+nDduSgxNX19FPlo0+eNrTRJk7sJqnu0GLbZk
        8N0HvP+oju6/hr4u/RYcyYuJO8Or7xn8hRRks/npMuA6VORcda99mISuJ74A5jCNk8HbSCCzkHg5A
        fQBVjc+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k94An-0008GP-Rp; Fri, 21 Aug 2020 10:21:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CB09305815;
        Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 579552C8FF367; Fri, 21 Aug 2020 12:21:24 +0200 (CEST)
Message-ID: <20200821102052.910320981@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 11:39:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 3/8] x86/debug: Move kprobe_debug_handler() into exc_debug_kernel()
References: <20200821093912.815135402@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kprobes are on kernel text, and thus only matter for #DB-from-kernel.
Kprobes are ordered before the generic notifier, preserve that order.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/kprobes.h |    4 ++++
 arch/x86/kernel/traps.c        |   10 ++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -106,5 +106,9 @@ extern int kprobe_exceptions_notify(stru
 extern int kprobe_int3_handler(struct pt_regs *regs);
 extern int kprobe_debug_handler(struct pt_regs *regs);
 
+#else
+
+static inline int kprobe_debug_handler(struct pt_regs *regs) { return 0; }
+
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_X86_KPROBES_H */
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -806,12 +806,6 @@ static void handle_debug(struct pt_regs
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
@@ -877,8 +871,12 @@ static __always_inline void exc_debug_ke
 	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
 		dr6 &= ~DR_STEP;
 
+	if (kprobe_debug_handler(regs))
+		goto out;
+
 	handle_debug(regs, dr6, false);
 
+out:
 	instrumentation_end();
 	idtentry_exit_nmi(regs, irq_state);
 


