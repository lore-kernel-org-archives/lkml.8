Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D7CC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB6D2074D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMcFssr8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5oYoQ4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgHWIlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 04:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgHWIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 04:40:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC92C061573;
        Sun, 23 Aug 2020 01:40:59 -0700 (PDT)
Date:   Sun, 23 Aug 2020 08:40:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598172057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvVqG99cnpZd2Kn++fSn80JuL9/AT14bR315w9zAXPw=;
        b=uMcFssr8JGmznpcOnRtMmoVNVpeRuNDAV19Wj2MP2w9sYt1FbSTgmRcN5VReKsJQA4wncM
        UQdc59/SXmv/gXHpo3xSDkbIMgFaffwe56LyyOB95i1YMmWFTGhg9L4T2Jy73TMYpv5TTu
        lDes3g+SzhIcqxv54CfSJBb1pyf8ExSsfQ8MeO4FrFQGpF4rcfBQEFTnwx2Io3gB40uSwW
        InmeOd7rqGsAxRpabzZENGJ57Fy3WtOE8RqRv/PkcANElWAVtKIz2ZGJVHt0vFr4Xf5ri1
        WG2JUKNunFq2Y18sZm8PCTH+r0CIqULPsyz8CWhtC5dtmw41uX8jx6VmMk6gcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598172057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvVqG99cnpZd2Kn++fSn80JuL9/AT14bR315w9zAXPw=;
        b=N5oYoQ4FARbTZrF+j7TfNtlVoNL3UZxh5gV9mtbVonMtDcjTYq68Lw1y72RrqjorEz5YFP
        oQlI6qfvHyzgWGBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Provide multi-timestamp accessor to
 NMI safe timekeeper
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200814115512.159981360@linutronix.de>
References: <20200814115512.159981360@linutronix.de>
MIME-Version: 1.0
Message-ID: <159817205568.389.4403103773258550373.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e2d977c9f1abd1d199b412f8f83c1727808b794d
Gitweb:        https://git.kernel.org/tip/e2d977c9f1abd1d199b412f8f83c1727808b794d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 14 Aug 2020 12:19:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Aug 2020 10:38:24 +02:00

timekeeping: Provide multi-timestamp accessor to NMI safe timekeeper

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
Tested-by: Petr Mladek <pmladek@suse.com>                                                                                                                                                                                                                                      
Link: https://lore.kernel.org/r/20200814115512.159981360@linutronix.de

---
 include/linux/timekeeping.h | 15 +++++++-
 kernel/time/timekeeping.c   | 76 ++++++++++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index d5471d6..7f7e4a3 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -222,6 +222,18 @@ extern bool timekeeping_rtc_skipresume(void);
 
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
@@ -280,6 +292,9 @@ extern int get_device_system_crosststamp(
  */
 extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 
+/* NMI safe mono/boot/realtime timestamps */
+extern void ktime_get_fast_timestamps(struct ktime_timestamps *snap);
+
 /*
  * Persistent clock related interfaces
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 57d064d..ba76576 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -530,29 +530,29 @@ u64 notrace ktime_get_boot_fast_ns(void)
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
@@ -560,11 +560,65 @@ static __always_inline u64 __ktime_get_real_fast_ns(struct tk_fast *tkf)
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
