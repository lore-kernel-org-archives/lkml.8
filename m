Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D761C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C7920776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oPFwgDkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgE2Ve6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2Ve5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:34:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87C0C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=x41bT3tGoDoZAOyVxHRTxu7ymt46NVZGEKO4UVWOnos=; b=oPFwgDktotSxwes8wujF7BX2H7
        Ulv1Myd/8xwu+AmVjr6Y1aP6jQLGBwc6iz3zGKumaM5P1U00CGquEktmZwOTuXGNqrm6g5uyy4T9K
        /WxmtH6w9+YCEgE5Niz0uh4OYiONhsTkLgGjTtXIN928iSjpAhtKb0J/T9g7oVxmKgh0SWvZk3rxe
        Kcd+QGHuhY8Ot2TIbXOP+T1eU7i8tsFXJBE0qjMx2uvPHhT1y6aJRuXbQmFW/snjkKIMHKByixqa2
        y9KEez2BcTEiz8P3tQMjJQXRDI0IC1KM70ZUQ02B+PI9y7I/ilEzZj3FhENU+97byoxpu733NzfF0
        jX2e+4cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeN-0000LK-6Z; Fri, 29 May 2020 21:34:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0BE12307770;
        Fri, 29 May 2020 23:34:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 474492B9B1BC4; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529213321.415774872@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: [PATCH 12/14] x86/entry: Rename trace_hardirqs_off_prepare()
References: <20200529212728.795169701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typical pattern for trace_hardirqs_off_prepare() is:

  ENTRY
    lockdep_hardirqs_off(); // because hardware
    ... do entry magic
    instrumentation_begin();
    trace_hardirqs_off_prepare();
    ... do actual work
    trace_hardirqs_on_prepare();
    lockdep_hardirqs_on_prepare();
    instrumentation_end();
    ... do exit magic
    lockdep_hardirqs_on();

which shows that it's named wrong, rename it to
trace_hardirqs_off_finish(), as it concludes the hardirq_off
transition.

Also, given that the above is the only correct order, make the
traditional all-in-one trace_hardirqs_off() follow suit.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/common.c         |    6 +++---
 arch/x86/kernel/cpu/mce/core.c  |    2 +-
 arch/x86/kernel/nmi.c           |    2 +-
 arch/x86/kernel/traps.c         |    4 ++--
 include/linux/irqflags.h        |    4 ++--
 kernel/trace/trace_preemptirq.c |   10 +++++-----
 6 files changed, 14 insertions(+), 14 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -65,7 +65,7 @@ static noinstr void enter_from_user_mode
 
 	instrumentation_begin();
 	CT_WARN_ON(state != CONTEXT_USER);
-	trace_hardirqs_off_prepare();
+	trace_hardirqs_off_finish();
 	instrumentation_end();
 }
 #else
@@ -73,7 +73,7 @@ static __always_inline void enter_from_u
 {
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	instrumentation_begin();
-	trace_hardirqs_off_prepare();
+	trace_hardirqs_off_finish();
 	instrumentation_end();
 }
 #endif
@@ -569,7 +569,7 @@ bool noinstr idtentry_enter_cond_rcu(str
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
 		instrumentation_begin();
-		trace_hardirqs_off_prepare();
+		trace_hardirqs_off_finish();
 		instrumentation_end();
 
 		return true;
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1915,7 +1915,7 @@ static __always_inline void exc_machine_
 	 * that out because it's an indirect call. Annotate it.
 	 */
 	instrumentation_begin();
-	trace_hardirqs_off_prepare();
+	trace_hardirqs_off_finish();
 	machine_check_vector(regs);
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -330,7 +330,7 @@ static noinstr void default_do_nmi(struc
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
 	instrumentation_begin();
-	trace_hardirqs_off_prepare();
+	trace_hardirqs_off_finish();
 
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -634,7 +634,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 	} else {
 		nmi_enter();
 		instrumentation_begin();
-		trace_hardirqs_off_prepare();
+		trace_hardirqs_off_finish();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
 		if (regs->flags & X86_EFLAGS_IF)
@@ -854,7 +854,7 @@ static __always_inline void exc_debug_ke
 {
 	nmi_enter();
 	instrumentation_begin();
-	trace_hardirqs_off_prepare();
+	trace_hardirqs_off_finish();
 	instrumentation_end();
 
 	/*
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -32,7 +32,7 @@
 
 #ifdef CONFIG_TRACE_IRQFLAGS
   extern void trace_hardirqs_on_prepare(void);
-  extern void trace_hardirqs_off_prepare(void);
+  extern void trace_hardirqs_off_finish(void);
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
 # define lockdep_hardirq_context(p)	((p)->hardirq_context)
@@ -101,7 +101,7 @@ do {						\
 
 #else
 # define trace_hardirqs_on_prepare()		do { } while (0)
-# define trace_hardirqs_off_prepare()		do { } while (0)
+# define trace_hardirqs_off_finish()		do { } while (0)
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
 # define lockdep_hardirq_context(p)	0
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -58,7 +58,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on);
  * and lockdep uses a staged approach which splits the lockdep hardirq
  * tracking into a RCU on and a RCU off section.
  */
-void trace_hardirqs_off_prepare(void)
+void trace_hardirqs_off_finish(void)
 {
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
@@ -68,19 +68,19 @@ void trace_hardirqs_off_prepare(void)
 	}
 
 }
-EXPORT_SYMBOL(trace_hardirqs_off_prepare);
-NOKPROBE_SYMBOL(trace_hardirqs_off_prepare);
+EXPORT_SYMBOL(trace_hardirqs_off_finish);
+NOKPROBE_SYMBOL(trace_hardirqs_off_finish);
 
 void trace_hardirqs_off(void)
 {
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
 		if (!in_nmi())
 			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
 	}
-
-	lockdep_hardirqs_off(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 NOKPROBE_SYMBOL(trace_hardirqs_off);


