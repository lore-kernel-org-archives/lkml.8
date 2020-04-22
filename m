Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538ABC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7142173E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N26s26pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgDVLaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727837AbgDVL3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:54 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65F8C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pja6EtNKFY6TZO5unPD8RsRZYU0yKevwwnZMNby6GwU=; b=N26s26pcaI+yW+rwrQVRRHImlO
        2wOYiyfdVWU7GT3w9ATLj6e+WRjWOmjIV0T1C0d22H93iLK8mtKWodT3WwJB4qQh0f1k20Ju30EgY
        1D59GZysN0RfH+NsmZelgyN2snilbKJtWOdyGnF4KliO/JKiFLyxgVH4ZRXkGgS1cQzhkE3WlYClM
        a0zEAgaLi9HWX8RogaQ5WeHGXpF2WBisHsJCxpZrwn1mOkpA3bsd3VtSNEPPcAjBU+JPg66rwJ7Ta
        0mqu9zqBhsSNAIH8VEsVhIDTj+D24/jowH/4nEzxkmFR46LoE5cWyPBUbKdhIul2D4yORKfyxXlI2
        rIp0d/YA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0006rG-DB; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E2A630798A;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2959820195236; Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Message-Id: <20200422112832.590341262@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, axboe@kernel.dk, daniel.lezcano@linaro.org,
        sudeep.holla@arm.com, airlied@redhat.com, broonie@kernel.org,
        paulmck@kernel.org
Subject: [PATCH 23/23] sched: Remove sched_set_*() return value
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo suggested that since the new sched_set_*() functions are
implemented using the 'nocheck' variants, they really shouldn't ever
fail, so remove the return value.

Cc: axboe@kernel.dk
Cc: daniel.lezcano@linaro.org
Cc: sudeep.holla@arm.com
Cc: airlied@redhat.com
Cc: broonie@kernel.org
Cc: paulmck@kernel.org
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/block/drbd/drbd_receiver.c    |    4 +---
 drivers/firmware/psci/psci_checker.c  |    3 +--
 drivers/gpu/drm/msm/msm_drv.c         |    5 +----
 drivers/platform/chrome/cros_ec_spi.c |    7 +++----
 include/linux/sched.h                 |    6 +++---
 kernel/rcu/rcutorture.c               |    5 +----
 kernel/sched/core.c                   |   12 ++++++------
 7 files changed, 16 insertions(+), 26 deletions(-)

--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -6021,9 +6021,7 @@ int drbd_ack_receiver(struct drbd_thread
 	int expect   = header_size;
 	bool ping_timeout_active = false;
 
-	rv = sched_set_fifo_low(current);
-	if (rv < 0)
-		drbd_err(connection, "drbd_ack_receiver: ERROR set priority, ret=%d\n", rv);
+	sched_set_fifo_low(current);
 
 	while (get_t_state(thi) == RUNNING) {
 		drbd_thread_current_set_cpu(thi);
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -281,8 +281,7 @@ static int suspend_test_thread(void *arg
 	wait_for_completion(&suspend_threads_started);
 
 	/* Set maximum priority to preempt all other threads on this CPU. */
-	if (sched_set_fifo(current))
-		pr_warn("Failed to set suspend thread scheduler on CPU %d\n", cpu);
+	sched_set_fifo(current);
 
 	dev = this_cpu_read(cpuidle_devices);
 	drv = cpuidle_get_cpu_driver(dev);
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -508,10 +508,7 @@ static int msm_drm_init(struct device *d
 			goto err_msm_uninit;
 		}
 
-		ret = sched_set_fifo(priv->event_thread[i].thread);
-		if (ret)
-			dev_warn(dev, "event_thread set priority failed:%d\n",
-				 ret);
+		sched_set_fifo(priv->event_thread[i].thread);
 	}
 
 	ret = drm_vblank_init(ddev, priv->num_crtcs);
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -725,10 +725,9 @@ static int cros_ec_spi_devm_high_pri_all
 	if (err)
 		return err;
 
-	err = sched_set_fifo(ec_spi->high_pri_worker->task);
-	if (err)
-		dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
-	return err;
+	sched_set_fifo(ec_spi->high_pri_worker->task);
+
+	return 0;
 }
 
 static int cros_ec_spi_probe(struct spi_device *spi)
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1631,9 +1631,9 @@ extern int idle_cpu(int cpu);
 extern int available_idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
-extern int sched_set_fifo(struct task_struct *p);
-extern int sched_set_fifo_low(struct task_struct *p);
-extern int sched_set_normal(struct task_struct *p, int nice);
+extern void sched_set_fifo(struct task_struct *p);
+extern void sched_set_fifo_low(struct task_struct *p);
+extern void sched_set_normal(struct task_struct *p, int nice);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
 extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
 extern struct task_struct *idle_task(int cpu);
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -806,10 +806,7 @@ static int rcu_torture_boost(void *arg)
 	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
 
 	/* Set real-time priority. */
-	if (sched_set_fifo_low(current) < 0) {
-		VERBOSE_TOROUT_STRING("rcu_torture_boost RT prio failed!");
-		n_rcu_torture_boost_rterror++;
-	}
+	sched_set_fifo_low(current);
 
 	init_rcu_head_on_stack(&rbi.rcu);
 	/* Each pass through the following loop does one boost-test cycle. */
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5114,30 +5114,30 @@ int sched_setscheduler_nocheck(struct ta
  * The administrator _MUST_ configure the system, the kernel simply doesn't
  * know enough information to make a sensible choice.
  */
-int sched_set_fifo(struct task_struct *p)
+void sched_set_fifo(struct task_struct *p)
 {
 	struct sched_param sp = { .sched_priority = MAX_RT_PRIO / 2 };
-	return sched_setscheduler_nocheck(p, SCHED_FIFO, &sp);
+	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) != 0);
 }
 EXPORT_SYMBOL_GPL(sched_set_fifo);
 
 /*
  * For when you don't much care about FIFO, but want to be above SCHED_NORMAL.
  */
-int sched_set_fifo_low(struct task_struct *p)
+void sched_set_fifo_low(struct task_struct *p)
 {
 	struct sched_param sp = { .sched_priority = 1 };
-	return sched_setscheduler_nocheck(p, SCHED_FIFO, &sp);
+	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) != 0);
 }
 EXPORT_SYMBOL_GPL(sched_set_fifo_low);
 
-int sched_set_normal(struct task_struct *p, int nice)
+void sched_set_normal(struct task_struct *p, int nice)
 {
 	struct sched_attr attr = {
 		.sched_policy = SCHED_NORMAL,
 		.sched_nice = nice,
 	};
-	return sched_setattr_nocheck(p, &attr);
+	WARN_ON_ONCE(sched_setattr_nocheck(p, &attr) != 0);
 }
 EXPORT_SYMBOL_GPL(sched_set_normal);
 


