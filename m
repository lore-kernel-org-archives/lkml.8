Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60576C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE8820842
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCUPxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:53:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39017 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgCUPxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:53:53 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRY-0005Ri-04; Sat, 21 Mar 2020 16:53:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 975911C22F0;
        Sat, 21 Mar 2020 16:53:47 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:47 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] timekeeping: Split jiffies seqlock
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113242.120587764@linutronix.de>
References: <20200321113242.120587764@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480602728.28353.11719217255276618127.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e5d4d1756b07d9490a0269a9e68c1e05ee1feb9b
Gitweb:        https://git.kernel.org/tip/e5d4d1756b07d9490a0269a9e68c1e05ee1feb9b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 21 Mar 2020 12:25:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:23 +01:00

timekeeping: Split jiffies seqlock

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200321113242.120587764@linutronix.de
---
 kernel/time/jiffies.c     |  7 ++++---
 kernel/time/tick-common.c | 10 ++++++----
 kernel/time/tick-sched.c  | 19 ++++++++++++-------
 kernel/time/timekeeping.c |  6 ++++--
 kernel/time/timekeeping.h |  3 ++-
 5 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index d23b434..eddcf49 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -58,7 +58,8 @@ static struct clocksource clocksource_jiffies = {
 	.max_cycles	= 10,
 };
 
-__cacheline_aligned_in_smp DEFINE_SEQLOCK(jiffies_lock);
+__cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(jiffies_lock);
+__cacheline_aligned_in_smp seqcount_t jiffies_seq;
 
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
@@ -67,9 +68,9 @@ u64 get_jiffies_64(void)
 	u64 ret;
 
 	do {
-		seq = read_seqbegin(&jiffies_lock);
+		seq = read_seqcount_begin(&jiffies_seq);
 		ret = jiffies_64;
-	} while (read_seqretry(&jiffies_lock, seq));
+	} while (read_seqcount_retry(&jiffies_seq, seq));
 	return ret;
 }
 EXPORT_SYMBOL(get_jiffies_64);
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 7e5d352..6c9c342 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -84,13 +84,15 @@ int tick_is_oneshot_available(void)
 static void tick_periodic(int cpu)
 {
 	if (tick_do_timer_cpu == cpu) {
-		write_seqlock(&jiffies_lock);
+		raw_spin_lock(&jiffies_lock);
+		write_seqcount_begin(&jiffies_seq);
 
 		/* Keep track of the next tick event */
 		tick_next_period = ktime_add(tick_next_period, tick_period);
 
 		do_timer(1);
-		write_sequnlock(&jiffies_lock);
+		write_seqcount_end(&jiffies_seq);
+		raw_spin_unlock(&jiffies_lock);
 		update_wall_time();
 	}
 
@@ -162,9 +164,9 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 		ktime_t next;
 
 		do {
-			seq = read_seqbegin(&jiffies_lock);
+			seq = read_seqcount_begin(&jiffies_seq);
 			next = tick_next_period;
-		} while (read_seqretry(&jiffies_lock, seq));
+		} while (read_seqcount_retry(&jiffies_seq, seq));
 
 		clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT);
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a792d21..4be756b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -65,7 +65,8 @@ static void tick_do_update_jiffies64(ktime_t now)
 		return;
 
 	/* Reevaluate with jiffies_lock held */
-	write_seqlock(&jiffies_lock);
+	raw_spin_lock(&jiffies_lock);
+	write_seqcount_begin(&jiffies_seq);
 
 	delta = ktime_sub(now, last_jiffies_update);
 	if (delta >= tick_period) {
@@ -91,10 +92,12 @@ static void tick_do_update_jiffies64(ktime_t now)
 		/* Keep the tick_next_period variable up to date */
 		tick_next_period = ktime_add(last_jiffies_update, tick_period);
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
 
@@ -105,12 +108,14 @@ static ktime_t tick_init_jiffy_update(void)
 {
 	ktime_t period;
 
-	write_seqlock(&jiffies_lock);
+	raw_spin_lock(&jiffies_lock);
+	write_seqcount_begin(&jiffies_seq);
 	/* Did we start the jiffies update yet ? */
 	if (last_jiffies_update == 0)
 		last_jiffies_update = tick_next_period;
 	period = last_jiffies_update;
-	write_sequnlock(&jiffies_lock);
+	write_seqcount_end(&jiffies_seq);
+	raw_spin_unlock(&jiffies_lock);
 	return period;
 }
 
@@ -676,10 +681,10 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 
 	/* Read jiffies and the time when jiffies were updated last */
 	do {
-		seq = read_seqbegin(&jiffies_lock);
+		seq = read_seqcount_begin(&jiffies_seq);
 		basemono = last_jiffies_update;
 		basejiff = jiffies;
-	} while (read_seqretry(&jiffies_lock, seq));
+	} while (read_seqcount_retry(&jiffies_seq, seq));
 	ts->last_jiffies = basejiff;
 	ts->timer_expires_base = basemono;
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ca69290..856280d 100644
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
index 141ab3a..099737f 100644
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -25,7 +25,8 @@ static inline void sched_clock_resume(void) { }
 extern void do_timer(unsigned long ticks);
 extern void update_wall_time(void);
 
-extern seqlock_t jiffies_lock;
+extern raw_spinlock_t jiffies_lock;
+extern seqcount_t jiffies_seq;
 
 #define CS_NAME_LEN	32
 
