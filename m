Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC0CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 10:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1242075F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 10:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgEXKvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 06:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgEXKvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 06:51:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B6BC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 03:51:22 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jcoDK-0002V9-Oz; Sun, 24 May 2020 12:50:42 +0200
Date:   Sun, 24 May 2020 12:50:42 +0200
From:   "Sebastian A. Siewior" <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 07/25] lockdep: Add preemption disabled assertion API
Message-ID: <20200524105042.7k3i4klu4oyhlfiv@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-8-a.darwish@linutronix.de>
 <20200522175503.GQ325280@hirez.programming.kicks-ass.net>
 <20200523145942.vjk3z6pbj6yicqa4@linutronix.de>
 <20200523224132.GD2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200523224132.GD2483@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-24 00:41:32 [+0200], Peter Zijlstra wrote:
> Because...? /me rummages around.. Ah you're proposing sticking this in
> seqcount itself and then header hell.
> 
> Moo.. ok I'll go have another look on Monday.

if you have a look on Monday you might want to start with the patch at
the bottom on top of the series. Both sched.h includes are needed also
you need to avoid write_seqcount_t_begin_nested() as static inline in
header files.

diff --git a/include/linux/flex_proportions.h b/include/linux/flex_proportions.h
index c12df59d3f5fc..c0f88f08371d7 100644
--- a/include/linux/flex_proportions.h
+++ b/include/linux/flex_proportions.h
@@ -12,6 +12,7 @@
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
 #include <linux/gfp.h>
+#include <linux/sched.h>
 
 /*
  * When maximum proportion of some event type is specified, this is the
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 54c929ea5b982..76385e599a9cb 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -702,13 +702,13 @@ do {									\
 			  "Not in hardirq as expected\n");		\
 	} while (0)
 
-/*
- * Don't define this assertion here to avoid a call-site's header file
- * dependency on sched.h task_struct current. This is needed by call
- * sites that are inline defined at header files already included by
- * sched.h.
- */
-void lockdep_assert_preemption_disabled(void);
+#define lockdep_assert_preemption_disabled() do {			\
+	WARN_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)      &&		\
+		  debug_locks                           &&		\
+		  !current->lockdep_recursion           &&		\
+		  (preempt_count() == 0 && current->hardirqs_enabled),	\
+		  "preemption not disabled as expected\n");		\
+       } while (0)
 
 #else
 # define might_lock(lock) do { } while (0)
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index eca464ecf012f..7f1261376110a 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -423,11 +423,11 @@ static inline void __write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
-static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
-{
-	lockdep_assert_preemption_disabled();
-	__write_seqcount_t_begin_nested(s, subclass);
-}
+#define write_seqcount_t_begin_nested(__s, __subclass)		\
+	do {							\
+		lockdep_assert_preemption_disabled();		\
+		__write_seqcount_t_begin_nested(__s, __subclass);\
+	} while (0)
 
 /*
  * write_seqcount_t_begin() without lockdep non-preemptibility check.
@@ -450,10 +450,7 @@ static inline void __write_seqcount_t_begin(seqcount_t *s)
  */
 #define write_seqcount_begin(s)		do_write_seqcount_begin(s)
 
-static inline void write_seqcount_t_begin(seqcount_t *s)
-{
-	write_seqcount_t_begin_nested(s, 0);
-}
+#define write_seqcount_t_begin(_s)	write_seqcount_t_begin_nested(_s, 0);
 
 /**
  * write_seqcount_end() - end a seqcount write-side critical section
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 30358ce3d8fe1..d0fd3edcdc50b 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -62,6 +62,7 @@
  * Example of use in drivers/net/loopback.c, using per_cpu containers,
  * in BH disabled context.
  */
+#include <linux/sched.h>
 #include <linux/seqlock.h>
 
 struct u64_stats_sync {
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4dae65bc65c24..ac10db66cc63f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5857,18 +5857,3 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	dump_stack();
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
-
-#ifdef CONFIG_PROVE_LOCKING
-
-void lockdep_assert_preemption_disabled(void)
-{
-	WARN_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&
-		  debug_locks				&&
-		  !current->lockdep_recursion		&&
-		  (preempt_count() == 0 && current->hardirqs_enabled),
-		  "preemption not disabled as expected\n");
-}
-EXPORT_SYMBOL_GPL(lockdep_assert_preemption_disabled);
-NOKPROBE_SYMBOL(lockdep_assert_preemption_disabled);
-
-#endif

Sebastian
