Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66D6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86938206CD
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="olP8/3XK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgEBS33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 14:29:29 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:60677 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728252AbgEBS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 14:29:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588444167; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=wTCCAUt0Suniq1ZgWcEu4BDsjAwlKNGt6KNgUyzL/fI=; b=olP8/3XKu2dfxW3MbZzs+FKX1KCkp1fbVhvRZdnXfOBU1wY15JJqvVD5Rbmi2O1CdRs2rfmH
 cmD4Us5tyHduJGzL/M8bjJ7JjTHU61yJXXc/N1OgBiFg9myx9Pu17uxrnNBK94RKwJqoBStv
 Gqhjj1JnpV4sCOl8AM2N3nV4BSg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eadbbf6.7f3fd6b3d688-smtp-out-n03;
 Sat, 02 May 2020 18:29:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2EB8CC433D2; Sat,  2 May 2020 18:29:09 +0000 (UTC)
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EEC96C432C2;
        Sat,  2 May 2020 18:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEC96C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, saravanak@google.com,
        psodagud@codeaurora.org, pkondeti@codeaurora.org,
        Joonwoo Park <joonwoop@codeaurora.org>
Subject: [PATCH v3 1/2] timer: make deferrable cpu unbound timers really not bound to a cpu
Date:   Sat,  2 May 2020 11:28:56 -0700
Message-Id: <1588444137-18651-2-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588444137-18651-1-git-send-email-psodagud@codeaurora.org>
References: <1588444137-18651-1-git-send-email-psodagud@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonwoo Park <joonwoop@codeaurora.org>

When a deferrable work (INIT_DEFERRABLE_WORK, etc.) is queued via
queue_delayed_work() it's probably intended to run the work item on any
CPU that isn't idle. However, we queue the work to run at a later time
by starting a deferrable timer that binds to whatever CPU the work is
queued on which is same with queue_delayed_work_on(smp_processor_id())
effectively.

As a result WORK_CPU_UNBOUND work items aren't really cpu unbound now.
In fact this is perfectly fine with UP kernel and also won't affect much a
system without dyntick with SMP kernel too as every cpus run timers
periodically.  But on SMP systems with dyntick current implementation leads
deferrable timers not very scalable because the timer's base which has
queued the deferrable timer won't wake up till next non-deferrable timer
expires even though there are possible other non idle cpus are running
which are able to run expired deferrable timers.

The deferrable work is a good example of the current implementation's
victim like below.

INIT_DEFERRABLE_WORK(&dwork, fn);
CPU 0                                 CPU 1
queue_delayed_work(wq, &dwork, HZ);
    queue_delayed_work_on(WORK_CPU_UNBOUND);
        ...
	__mod_timer() -> queues timer to the
			 current cpu's timer
			 base.
	...
tick_nohz_idle_enter() -> cpu enters idle.
A second later
cpu 0 is now in idle.                 cpu 1 exits idle or wasn't in idle so
                                      now it's in active but won't
cpu 0 won't wake up till next         handle cpu unbound deferrable timer
non-deferrable timer expires.         as it's in cpu 0's timer base.

To make all cpu unbound deferrable timers are scalable, introduce a common
timer base which is only for cpu unbound deferrable timers to make those
are indeed cpu unbound so that can be scheduled by any of non idle cpus.
This common timer fixes scalability issue of delayed work and all other cpu
unbound deferrable timer using implementations.

Signed-off-by: Joonwoo Park <joonwoop@codeaurora.org>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 kernel/time/timer.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a5221ab..1bf9b49 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -220,6 +220,7 @@ static void timer_update_keys(struct work_struct *work);
 static DECLARE_WORK(timer_update_work, timer_update_keys);
 
 #ifdef CONFIG_SMP
+struct timer_base timer_base_deferrable;
 unsigned int sysctl_timer_migration = 1;
 
 DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
@@ -841,8 +842,14 @@ static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
 	 * to use the deferrable base.
 	 */
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE))
-		base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE)) {
+#ifdef CONFIG_SMP
+		base = &timer_base_deferrable;
+#endif
+		if (tflags & TIMER_PINNED)
+			base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
+	}
+
 	return base;
 }
 
@@ -854,8 +861,14 @@ static inline struct timer_base *get_timer_this_cpu_base(u32 tflags)
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
 	 * to use the deferrable base.
 	 */
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE))
-		base = this_cpu_ptr(&timer_bases[BASE_DEF]);
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE)) {
+#ifdef CONFIG_SMP
+		base = &timer_base_deferrable;
+#endif
+		if (tflags & TIMER_PINNED)
+			base = this_cpu_ptr(&timer_bases[BASE_DEF]);
+	}
+
 	return base;
 }
 
@@ -1785,8 +1798,14 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
 	__run_timers(base);
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+#ifdef CONFIG_SMP
+		if (tick_do_timer_cpu == TICK_DO_TIMER_NONE ||
+				tick_do_timer_cpu == smp_processor_id())
+			__run_timers(&timer_base_deferrable);
+#endif
+	}
 }
 
 /*
@@ -2025,6 +2044,16 @@ static void __init init_timer_cpu(int cpu)
 	}
 }
 
+#if defined(CONFIG_NO_HZ_COMMON) && defined(CONFIG_SMP)
+static void __init init_timer_deferrable_global(void)
+{
+	timer_base_deferrable.cpu = nr_cpu_ids;
+	raw_spin_lock_init(&timer_base_deferrable.lock);
+	timer_base_deferrable.clk = jiffies;
+	timer_base_init_expiry_lock(&timer_base_deferrable);
+}
+#endif
+
 static void __init init_timer_cpus(void)
 {
 	int cpu;
@@ -2036,6 +2065,9 @@ static void __init init_timer_cpus(void)
 void __init init_timers(void)
 {
 	init_timer_cpus();
+#if defined(CONFIG_NO_HZ_COMMON) && defined(CONFIG_SMP)
+	init_timer_deferrable_global();
+#endif
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
