Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9B3C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0094F206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TcK3+pf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgCPCjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:39:47 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:30765 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730439AbgCPCjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:39:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584326383; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=cH+2p7cVtn7b3/CDSyuVcyqtKo2XSY7tvfF/+90W7EQ=; b=TcK3+pf3W0la9rrvaaR9YpWCpSigpuLkFwvLWSai+q1abTYpMkwfCT+N3vjmKGriIvpXJhsD
 U6/legJJfuCBIFfapTWzwc45JdEHNBI8pQ8d6u22DYZgklLFins2UvKRQ5tG/60GPETddNKL
 L4SWerewLrFwPowMLmzQBao44pg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6ee6e3.7f69d5158d18-smtp-out-n01;
 Mon, 16 Mar 2020 02:39:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24000C6473C; Mon, 16 Mar 2020 02:39:30 +0000 (UTC)
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2D73C3855F;
        Mon, 16 Mar 2020 02:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2D73C3855F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, saravanak@google.com,
        tsoni@codeaurora.org, tj@kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH 2/2] sched: Add a check for cpu unbound deferrable timers
Date:   Sun, 15 Mar 2020 19:39:10 -0700
Message-Id: <1584326350-30275-3-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584326350-30275-1-git-send-email-psodagud@codeaurora.org>
References: <1584326350-30275-1-git-send-email-psodagud@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for cpu unbound deferrable timer expiry and raise
softirq for handling the expired timers so that the CPU can
process the cpu unbound deferrable times as early as possible
when a cpu tries to enter/exit idle loop.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 include/linux/timer.h    |  3 +++
 kernel/time/tick-sched.c |  6 ++++++
 kernel/time/timer.c      | 29 ++++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 1e6650e..25a1837 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -172,6 +172,9 @@ extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
 extern int timer_reduce(struct timer_list *timer, unsigned long expires);
+#ifdef CONFIG_SMP
+extern bool check_pending_deferrable_timers(int cpu);
+#endif
 
 /*
  * The jiffies value which is added to now, when there is no timer
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a792d21..fe0836a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/irq_work.h>
 #include <linux/posix-timers.h>
+#include <linux/timer.h>
 #include <linux/context_tracking.h>
 #include <linux/mm.h>
 
@@ -948,6 +949,11 @@ static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
 	ktime_t expires;
 	int cpu = smp_processor_id();
 
+#ifdef CONFIG_SMP
+	if (check_pending_deferrable_timers(cpu))
+		raise_softirq_irqoff(TIMER_SOFTIRQ);
+#endif
+
 	/*
 	 * If tick_nohz_get_sleep_length() ran tick_nohz_next_event(), the
 	 * tick timer expiration time is known already.
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a63ca77..3b0aac3 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -221,6 +221,7 @@ static DECLARE_WORK(timer_update_work, timer_update_keys);
 
 #ifdef CONFIG_SMP
 struct timer_base timer_base_deferrable;
+static atomic_t deferrable_pending;
 unsigned int sysctl_timer_migration = 1;
 
 DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
@@ -1609,6 +1610,31 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+
+#ifdef CONFIG_SMP
+/*
+ * check_pending_deferrable_timers - Check for unbound deferrable timer expiry
+ * @cpu - Current CPU
+ *
+ * The function checks whether any global deferrable pending timers
+ * are exipired or not. This function does not check cpu bounded
+ * diferrable pending timers expiry.
+ *
+ * The function returns true when a cpu unbounded deferrable timer is expired.
+ */
+bool check_pending_deferrable_timers(int cpu)
+{
+	if (cpu == tick_do_timer_cpu ||
+		tick_do_timer_cpu == TICK_DO_TIMER_NONE) {
+		if (time_after_eq(jiffies, timer_base_deferrable.clk)
+			&& !atomic_cmpxchg(&deferrable_pending, 0, 1)) {
+			return true;
+		}
+	}
+	return false;
+}
+#endif
+
 /**
  * get_next_timer_interrupt - return the time (clock mono) of the next timer
  * @basej:	base time jiffies
@@ -1799,7 +1825,8 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
-		if (tick_do_timer_cpu == TICK_DO_TIMER_NONE ||
+		if ((atomic_cmpxchg(&deferrable_pending, 1, 0) &&
+				tick_do_timer_cpu == TICK_DO_TIMER_NONE) ||
 				tick_do_timer_cpu == smp_processor_id())
 			__run_timers(&timer_base_deferrable);
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
