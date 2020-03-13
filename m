Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC618C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CC6206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCMRrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:47:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47702 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMRrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:47:17 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jCoOx-00017r-77; Fri, 13 Mar 2020 18:47:15 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/9] timekeeping: Split jiffies seqlock
Date:   Fri, 13 Mar 2020 18:46:54 +0100
Message-Id: <20200313174701.148376-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313174701.148376-1-bigeasy@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

seqlock consists of a sequence counter and a spinlock_t which is used to
serialize the writers. spinlock_t is substituted by a "sleeping" spinlock
on PREEMPT_RT enabled kernels which breaks the usage in the timekeeping
code as the writers are executed in hard interrupt and therefore
non-preemptible context even on PREEMPT_RT.

The spinlock in seqlock cannot be unconditionally replaced by a
raw_spinlock_t as many seqlock users have nesting spinlock sections or
other code which is not suitable to run in truly atomic context on RT.

Instead of providing a raw_seqlock API for a single use case, open code the
seqlock for the jiffies use case and implement it with a raw_spinlock_t and
a sequence counter.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/jiffies.c     |  7 ++++---
 kernel/time/tick-common.c | 10 ++++++----
 kernel/time/tick-sched.c  | 19 ++++++++++++-------
 kernel/time/timekeeping.c |  6 ++++--
 kernel/time/timekeeping.h |  3 ++-
 5 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index d23b434c2ca7b..eddcf49704445 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -58,7 +58,8 @@ static struct clocksource clocksource_jiffies =3D {
 	.max_cycles	=3D 10,
 };
=20
-__cacheline_aligned_in_smp DEFINE_SEQLOCK(jiffies_lock);
+__cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(jiffies_lock);
+__cacheline_aligned_in_smp seqcount_t jiffies_seq;
=20
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
@@ -67,9 +68,9 @@ u64 get_jiffies_64(void)
 	u64 ret;
=20
 	do {
-		seq =3D read_seqbegin(&jiffies_lock);
+		seq =3D read_seqcount_begin(&jiffies_seq);
 		ret =3D jiffies_64;
-	} while (read_seqretry(&jiffies_lock, seq));
+	} while (read_seqcount_retry(&jiffies_seq, seq));
 	return ret;
 }
 EXPORT_SYMBOL(get_jiffies_64);
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 7e5d3524e924d..6c9c342dd0e53 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -84,13 +84,15 @@ int tick_is_oneshot_available(void)
 static void tick_periodic(int cpu)
 {
 	if (tick_do_timer_cpu =3D=3D cpu) {
-		write_seqlock(&jiffies_lock);
+		raw_spin_lock(&jiffies_lock);
+		write_seqcount_begin(&jiffies_seq);
=20
 		/* Keep track of the next tick event */
 		tick_next_period =3D ktime_add(tick_next_period, tick_period);
=20
 		do_timer(1);
-		write_sequnlock(&jiffies_lock);
+		write_seqcount_end(&jiffies_seq);
+		raw_spin_unlock(&jiffies_lock);
 		update_wall_time();
 	}
=20
@@ -162,9 +164,9 @@ void tick_setup_periodic(struct clock_event_device *dev=
, int broadcast)
 		ktime_t next;
=20
 		do {
-			seq =3D read_seqbegin(&jiffies_lock);
+			seq =3D read_seqcount_begin(&jiffies_seq);
 			next =3D tick_next_period;
-		} while (read_seqretry(&jiffies_lock, seq));
+		} while (read_seqcount_retry(&jiffies_seq, seq));
=20
 		clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT);
=20
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a792d21cac645..4be756b88a48e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -65,7 +65,8 @@ static void tick_do_update_jiffies64(ktime_t now)
 		return;
=20
 	/* Reevaluate with jiffies_lock held */
-	write_seqlock(&jiffies_lock);
+	raw_spin_lock(&jiffies_lock);
+	write_seqcount_begin(&jiffies_seq);
=20
 	delta =3D ktime_sub(now, last_jiffies_update);
 	if (delta >=3D tick_period) {
@@ -91,10 +92,12 @@ static void tick_do_update_jiffies64(ktime_t now)
 		/* Keep the tick_next_period variable up to date */
 		tick_next_period =3D ktime_add(last_jiffies_update, tick_period);
 	} else {
-		write_sequnlock(&jiffies_lock);
+		write_seqcount_end(&jiffies_seq);
+		raw_spin_unlock(&jiffies_lock);
 		return;
 	}
-	write_sequnlock(&jiffies_lock);
+	write_seqcount_end(&jiffies_seq);
+	raw_spin_unlock(&jiffies_lock);
 	update_wall_time();
 }
=20
@@ -105,12 +108,14 @@ static ktime_t tick_init_jiffy_update(void)
 {
 	ktime_t period;
=20
-	write_seqlock(&jiffies_lock);
+	raw_spin_lock(&jiffies_lock);
+	write_seqcount_begin(&jiffies_seq);
 	/* Did we start the jiffies update yet ? */
 	if (last_jiffies_update =3D=3D 0)
 		last_jiffies_update =3D tick_next_period;
 	period =3D last_jiffies_update;
-	write_sequnlock(&jiffies_lock);
+	write_seqcount_end(&jiffies_seq);
+	raw_spin_unlock(&jiffies_lock);
 	return period;
 }
=20
@@ -676,10 +681,10 @@ static ktime_t tick_nohz_next_event(struct tick_sched=
 *ts, int cpu)
=20
 	/* Read jiffies and the time when jiffies were updated last */
 	do {
-		seq =3D read_seqbegin(&jiffies_lock);
+		seq =3D read_seqcount_begin(&jiffies_seq);
 		basemono =3D last_jiffies_update;
 		basejiff =3D jiffies;
-	} while (read_seqretry(&jiffies_lock, seq));
+	} while (read_seqcount_retry(&jiffies_seq, seq));
 	ts->last_jiffies =3D basejiff;
 	ts->timer_expires_base =3D basemono;
=20
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ca69290bee2a3..856280d2cbd4c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2397,8 +2397,10 @@ EXPORT_SYMBOL(hardpps);
  */
 void xtime_update(unsigned long ticks)
 {
-	write_seqlock(&jiffies_lock);
+	raw_spin_lock(&jiffies_lock);
+	write_seqcount_begin(&jiffies_seq);
 	do_timer(ticks);
-	write_sequnlock(&jiffies_lock);
+	write_seqcount_end(&jiffies_seq);
+	raw_spin_unlock(&jiffies_lock);
 	update_wall_time();
 }
diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
index 141ab3ab0354f..099737f6f10c7 100644
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -25,7 +25,8 @@ static inline void sched_clock_resume(void) { }
 extern void do_timer(unsigned long ticks);
 extern void update_wall_time(void);
=20
-extern seqlock_t jiffies_lock;
+extern raw_spinlock_t jiffies_lock;
+extern seqcount_t jiffies_seq;
=20
 #define CS_NAME_LEN	32
=20
--=20
2.25.1

