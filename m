Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047ABC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49F3206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lohMryqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgCPCjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:39:41 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:33100 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729732AbgCPCjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:39:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584326379; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=mPjSOAAISsRliq2VLzmgTh06wcN/t/nm1+SNy/k/yvA=; b=lohMryqCqKU52mkFy24+v6zN0LmPJ5lbiBQLqEGbJHEh6DVuHvXwdPQUEab+l8L0WAEAPLrg
 3w9A42Ppzi+6GhGgOo89tmS7JlJr68FoZV2UHQ971GRsShmffQIrusMK+HzQsRoWv7d562rJ
 oN8hqRxg6r8SLPZtdDzZHVF3lq0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6ee6df.7fc4bb3504c8-smtp-out-n01;
 Mon, 16 Mar 2020 02:39:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33906C49493; Mon, 16 Mar 2020 02:39:25 +0000 (UTC)
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECF01C3855F;
        Mon, 16 Mar 2020 02:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECF01C3855F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, saravanak@google.com,
        tsoni@codeaurora.org, tj@kernel.org,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH 1/2] timer: make deferrable cpu unbound timers really not bound to a cpu
Date:   Sun, 15 Mar 2020 19:39:09 -0700
Message-Id: <1584326350-30275-2-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584326350-30275-1-git-send-email-psodagud@codeaurora.org>
References: <1584326350-30275-1-git-send-email-psodagud@codeaurora.org>
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
 kernel/time/timer.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4820823..a63ca77 100644
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
 
@@ -1784,8 +1797,12 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
 	__run_timers(base);
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+		if (tick_do_timer_cpu == TICK_DO_TIMER_NONE ||
+				tick_do_timer_cpu == smp_processor_id())
+			__run_timers(&timer_base_deferrable);
+	}
 }
 
 /*
@@ -2022,6 +2039,14 @@ static void __init init_timer_cpu(int cpu)
 	}
 }
 
+static void __init init_timer_deferrable_global(void)
+{
+	timer_base_deferrable.cpu = nr_cpu_ids;
+	raw_spin_lock_init(&timer_base_deferrable.lock);
+	timer_base_deferrable.clk = jiffies;
+	timer_base_init_expiry_lock(&timer_base_deferrable);
+}
+
 static void __init init_timer_cpus(void)
 {
 	int cpu;
@@ -2033,6 +2058,7 @@ static void __init init_timer_cpus(void)
 void __init init_timers(void)
 {
 	init_timer_cpus();
+	init_timer_deferrable_global();
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
