Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6709CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372ED207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qjnjRs2+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="92NBN8gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHNL4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:56:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:56:27 -0400
Message-Id: <20200814115512.159981360@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597406183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=b3BKm8yhBbQVG+TzOiflH3sN/J1SNlSJUU3Y+l6Ir4Y=;
        b=qjnjRs2+LM/0CLtvVY5vZ4xH9cGiyLTzdmh2zonUXiKBzVVd+vjiTCOI6TXmAo/XHJ7waF
        AIYi1y+qeQJxC53nbTe8sCpn+IOx6L/TbCSk7c1GhZKRPNmaxPQiFMNFGv0oKm0Ou40EGv
        176qkoi0FqBe4bL4Ew1w619VYJJpZ4cPwKV7Rks9gXiPqZINIkMe1bAma80SJhkpGrW9lt
        puFsvgaF2aF9TjUAz+Q9FAa3BWdI3TbcyCQBqBNEVBLbt4lQ1UHG6osWtj3JapDu7Z6pd0
        pNJjWxn+vAPLObXzulPRCYpuAssOBaiXuN5Bdnb38eP3xh2liPA0y113mpPuCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597406183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=b3BKm8yhBbQVG+TzOiflH3sN/J1SNlSJUU3Y+l6Ir4Y=;
        b=92NBN8gyaytuu6P+jog8FagY2q1AW5M4vpjzO4JXhwMnRowTVFgB+tkrDvGVASU9fj8pYS
        5bZBU0PRystwgpAw==
Date:   Fri, 14 Aug 2020 12:19:35 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org
Subject: [patch 2/2] timekeeping: Provide multi-timestamp accessor to NMI safe
 timekeeper
References: <20200814101933.574326079@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename="printk_Change_timestamp_to_triplet_as_mono_boot_and_real.patch"
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk wants to store various timestamps (MONOTONIC, REALTIME, BOOTTIME) to
make correlation of dmesg from several systems easier.

Provide an interface to retrieve all three timestamps in one go.

There are some caveats:

1) Boot time and late sleep time injection

  Boot time is a racy access on 32bit systems if the sleep time injection
  happens late during resume and not in timekeeping_resume(). That could be
  avoided by expanding struct tk_read_base with boot offset for 32bit and
  adding more overhead to the update. As this is a hard to observe once per
  resume event which can be filtered with reasonable effort using the
  accurate mono/real timestamps, it's probably not worth the trouble.

  Aside of that it might be possible on 32 and 64 bit to observe the
  following when the sleep time injection happens late:

  CPU 0				         CPU 1
  timekeeping_resume()
  ktime_get_fast_timestamps()
    mono, real = __ktime_get_real_fast()
  					 inject_sleep_time()
  					   update boot offset
  	boot = mono + bootoffset;
  
  That means that boot time already has the sleep time adjustment, but
  real time does not. On the next readout both are in sync again.
  
  Preventing this for 64bit is not really feasible without destroying the
  careful cache layout of the timekeeper because the sequence count and
  struct tk_read_base would then need two cache lines instead of one.

2) Suspend/resume timestamps

   Access to the time keeper clock source is disabled accross the innermost
   steps of suspend/resume. The accessors still work, but the timestamps
   are frozen until time keeping is resumed which happens very early.

   For regular suspend/resume there is no observable difference vs. sched
   clock, but it might affect some of the nasty low level debug printks.

   OTOH, access to sched clock is not guaranteed accross suspend/resume on
   all systems either so it depends on the hardware in use.

   If that turns out to be a real problem then this could be mitigated by
   using sched clock in a similar way as during early boot. But it's not as
   trivial as on early boot because it needs some careful protection
   against the clock monotonic timestamp jumping backwards on resume.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/timekeeping.h |   15 ++++++++
 kernel/time/timekeeping.c   |   76 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 80 insertions(+), 11 deletions(-)

--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -222,6 +222,18 @@ extern bool timekeeping_rtc_skipresume(v
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
+/*
+ * struct ktime_timestanps - Simultaneous mono/boot/real timestamps
+ * @mono:	Monotonic timestamp
+ * @boot:	Boottime timestamp
+ * @real:	Realtime timestamp
+ */
+struct ktime_timestamps {
+	u64		mono;
+	u64		boot;
+	u64		real;
+};
+
 /**
  * struct system_time_snapshot - simultaneous raw/real time capture with
  *				 counter value
@@ -280,6 +292,9 @@ extern int get_device_system_crosststamp
  */
 extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 
+/* NMI safe mono/boot/realtime timestamps */
+extern void ktime_get_fast_timestamps(struct ktime_timestamps *snap);
+
 /*
  * Persistent clock related interfaces
  */
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -527,29 +527,29 @@ u64 notrace ktime_get_boot_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
 
-
 /*
  * See comment for __ktime_get_fast_ns() vs. timestamp ordering
  */
-static __always_inline u64 __ktime_get_real_fast_ns(struct tk_fast *tkf)
+static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 {
 	struct tk_read_base *tkr;
+	u64 basem, baser, delta;
 	unsigned int seq;
-	u64 now;
 
 	do {
 		seq = raw_read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
-		now = ktime_to_ns(tkr->base_real);
+		basem = ktime_to_ns(tkr->base);
+		baser = ktime_to_ns(tkr->base_real);
 
-		now += timekeeping_delta_to_ns(tkr,
-				clocksource_delta(
-					tk_clock_read(tkr),
-					tkr->cycle_last,
-					tkr->mask));
+		delta = timekeeping_delta_to_ns(tkr,
+				clocksource_delta(tk_clock_read(tkr),
+				tkr->cycle_last, tkr->mask));
 	} while (read_seqcount_retry(&tkf->seq, seq));
 
-	return now;
+	if (mono)
+		*mono = basem + delta;
+	return baser + delta;
 }
 
 /**
@@ -557,11 +557,65 @@ static __always_inline u64 __ktime_get_r
  */
 u64 ktime_get_real_fast_ns(void)
 {
-	return __ktime_get_real_fast_ns(&tk_fast_mono);
+	return __ktime_get_real_fast(&tk_fast_mono, NULL);
 }
 EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
 
 /**
+ * ktime_get_fast_timestamps: - NMI safe timestamps
+ * @snapshot:	Pointer to timestamp storage
+ *
+ * Stores clock monotonic, boottime and realtime timestamps.
+ *
+ * Boot time is a racy access on 32bit systems if the sleep time injection
+ * happens late during resume and not in timekeeping_resume(). That could
+ * be avoided by expanding struct tk_read_base with boot offset for 32bit
+ * and adding more overhead to the update. As this is a hard to observe
+ * once per resume event which can be filtered with reasonable effort using
+ * the accurate mono/real timestamps, it's probably not worth the trouble.
+ *
+ * Aside of that it might be possible on 32 and 64 bit to observe the
+ * following when the sleep time injection happens late:
+ *
+ * CPU 0				CPU 1
+ * timekeeping_resume()
+ * ktime_get_fast_timestamps()
+ *	mono, real = __ktime_get_real_fast()
+ *					inject_sleep_time()
+ *					   update boot offset
+ *	boot = mono + bootoffset;
+ *
+ * That means that boot time already has the sleep time adjustment, but
+ * real time does not. On the next readout both are in sync again.
+ *
+ * Preventing this for 64bit is not really feasible without destroying the
+ * careful cache layout of the timekeeper because the sequence count and
+ * struct tk_read_base would then need two cache lines instead of one.
+ *
+ * Access to the time keeper clock source is disabled accross the innermost
+ * steps of suspend/resume. The accessors still work, but the timestamps
+ * are frozen until time keeping is resumed which happens very early.
+ *
+ * For regular suspend/resume there is no observable difference vs. sched
+ * clock, but it might affect some of the nasty low level debug printks.
+ *
+ * OTOH, access to sched clock is not guaranteed accross suspend/resume on
+ * all systems either so it depends on the hardware in use.
+ *
+ * If that turns out to be a real problem then this could be mitigated by
+ * using sched clock in a similar way as during early boot. But it's not as
+ * trivial as on early boot because it needs some careful protection
+ * against the clock monotonic timestamp jumping backwards on resume.
+ */
+void ktime_get_fast_timestamps(struct ktime_timestamps *snapshot)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+
+	snapshot->real = __ktime_get_real_fast(&tk_fast_mono, &snapshot->mono);
+	snapshot->boot = snapshot->mono + ktime_to_ns(data_race(tk->offs_boot));
+}
+
+/**
  * halt_fast_timekeeper - Prevent fast timekeeper from accessing clocksource.
  * @tk: Timekeeper to snapshot.
  *

