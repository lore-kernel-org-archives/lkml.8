Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44ECC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37B3208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2cxsz/PD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHTHuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgHTHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:50:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D982C061383
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=p4eRIR77yIGD/mPyvDgT8xgRYIo4YZjUUfy/H+LOeA8=; b=2cxsz/PDgaS6jBYG8HNJnDuavO
        tp+Y21KrUgmfm2uLCKJ/Mm4rQtWcd5kQmZfNUmZAYRRJQoYTfxrHPW3twS9rrbeswuT2yN2+VoPgg
        Y1sm7+zSFU02iDviS6d7qZpz+VXq8aCqZ1qUSUHOGEK/9F27zhZS00hsOeb4ewHNnHkJES/+SseJB
        +8RbfnA/KRVqVJHVkYHYgVLE2zq5xMY3UdjCSqy87cjEjqMbgyFLmxAfr2smPgK66Wu3Ly58IWkOF
        tZGYONLiHCMHVx2rcpXggGLXkNWM2CElrhcj1NYBkbTu7Mruq6M8xrvMlalXIYbjjK9pNhiVx8WPc
        GZdWY92w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8fKX-0007Dc-Gt; Thu, 20 Aug 2020 07:49:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 63ECC305815;
        Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5588128B7E826; Thu, 20 Aug 2020 09:49:43 +0200 (CEST)
Message-ID: <20200820074640.342269393@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Aug 2020 09:30:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH 1/9] lockdep: Use raw_cpu_*() for per-cpu variables
References: <20200820073031.886217423@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven reported that commit a21ee6055c30 ("lockdep: Change
hardirq{s_enabled,_context} to per-cpu variables") caused trouble on
s390 because their this_cpu_*() primitives disable preemption which
then lands back tracing.

On the one hand, per-cpu ops should use preempt_*able_notrace() and
raw_local_irq_*(), on the other hand, we can trivialy use raw_cpu_*()
ops for this.

Fixes: a21ee6055c30 ("lockdep: Change hardirq{s_enabled,_context} to per-cpu variables")
Reported-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/irqflags.h |    6 +++---
 include/linux/lockdep.h  |   18 +++++++++++++-----
 kernel/locking/lockdep.c |    4 ++--
 3 files changed, 18 insertions(+), 10 deletions(-)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -53,13 +53,13 @@ DECLARE_PER_CPU(int, hardirq_context);
   extern void trace_hardirqs_off_finish(void);
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
-# define lockdep_hardirq_context()	(this_cpu_read(hardirq_context))
+# define lockdep_hardirq_context()	(raw_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
 # define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define lockdep_hardirq_enter()			\
 do {							\
-	if (this_cpu_inc_return(hardirq_context) == 1)	\
+	if (__this_cpu_inc_return(hardirq_context) == 1)\
 		current->hardirq_threaded = 0;		\
 } while (0)
 # define lockdep_hardirq_threaded()		\
@@ -68,7 +68,7 @@ do {						\
 } while (0)
 # define lockdep_hardirq_exit()			\
 do {						\
-	this_cpu_dec(hardirq_context);		\
+	__this_cpu_dec(hardirq_context);	\
 } while (0)
 # define lockdep_softirq_enter()		\
 do {						\
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -535,19 +535,27 @@ do {									\
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 
+/*
+ * The below lockdep_assert_*() macros se raw_cpu_read() to access the above
+ * per-cpu variables. This is required because this_cpu_read() will potentially
+ * call into preempt/irq-disable and that obviously isn't right. This is also
+ * correct because when IRQs are enabled, it doesn't matter if we accidentally
+ * read the value from our previous CPU.
+ */
+
 #define lockdep_assert_irqs_enabled()					\
 do {									\
-	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirqs_enabled));	\
+	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirqs_enabled));	\
 } while (0)
 
 #define lockdep_assert_irqs_disabled()					\
 do {									\
-	WARN_ON_ONCE(debug_locks && this_cpu_read(hardirqs_enabled));	\
+	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
 } while (0)
 
 #define lockdep_assert_in_irq()						\
 do {									\
-	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirq_context));	\
+	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirq_context));	\
 } while (0)
 
 #define lockdep_assert_preemption_enabled()				\
@@ -555,7 +563,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     debug_locks			&&		\
 		     (preempt_count() != 0		||		\
-		      !this_cpu_read(hardirqs_enabled)));		\
+		      !raw_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #define lockdep_assert_preemption_disabled()				\
@@ -563,7 +571,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     debug_locks			&&		\
 		     (preempt_count() == 0		&&		\
-		      this_cpu_read(hardirqs_enabled)));		\
+		      raw_cpu_read(hardirqs_enabled)));			\
 } while (0)
 
 #else
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3756,7 +3756,7 @@ void noinstr lockdep_hardirqs_on(unsigne
 
 skip_checks:
 	/* we'll do an OFF -> ON transition: */
-	this_cpu_write(hardirqs_enabled, 1);
+	__this_cpu_write(hardirqs_enabled, 1);
 	trace->hardirq_enable_ip = ip;
 	trace->hardirq_enable_event = ++trace->irq_events;
 	debug_atomic_inc(hardirqs_on_events);
@@ -3795,7 +3795,7 @@ void noinstr lockdep_hardirqs_off(unsign
 		/*
 		 * We have done an ON -> OFF transition:
 		 */
-		this_cpu_write(hardirqs_enabled, 0);
+		__this_cpu_write(hardirqs_enabled, 0);
 		trace->hardirq_disable_ip = ip;
 		trace->hardirq_disable_event = ++trace->irq_events;
 		debug_atomic_inc(hardirqs_off_events);


