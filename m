Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60CFC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4022068F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ULWS32i+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i4FZg/SC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgGXIdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgGXIdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F3AC0619D3;
        Fri, 24 Jul 2020 01:33:40 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IGW+7RnTRcW+DWd0UWS51KRGrN8/LUwdiWEm8cxWDJQ=;
        b=ULWS32i+TlDouJaJU9OyvzX0Ttab49EsmSls1RjaVOGgTDTKFtpm3+wzHDzp3GSc5sRZlo
        l8L0w6JG2r501QZA8rz7OXzmHTZj8ARnLK3If1Ynms/krLdiAWwatr1gAOfBP0qq7b9WGW
        G9x07AchUoxyZ02+DGyaemBNL3daIqwmpMmhY1idj9ezM747fILLJG0Cq1FYOXC+pOrsvu
        wPu2s1vqYI67vHxRlaI9xCNjGT8Fwn+Fii0NTmCgEzf3farAa6c6SOhs+f0XJzDgNXqNUT
        pJH4Rb+RpTcgjotjAdnGyFXnWTNYl0gHj1iYjgW7ObJKccMg1pnh72dqPXK5ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IGW+7RnTRcW+DWd0UWS51KRGrN8/LUwdiWEm8cxWDJQ=;
        b=i4FZg/SC12cQ+rjS2UoqFh+SyUtt4fcG/NwXPIMu/tUDFhPA1rb6aFuyAUcEeTkMCK/WRh
        D55Ka+CWTqHpzxDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched: Remove sched_set_*() return value
Cc:     axboe@kernel.dk, daniel.lezcano@linaro.org, sudeep.holla@arm.com,
        airlied@redhat.com, broonie@kernel.org, paulmck@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557961798.4006.15689979081053412317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     8b700983de82f79e05b2c1136d6513ea4c9b22c4
Gitweb:        https://git.kernel.org/tip/8b700983de82f79e05b2c1136d6513ea4c9b22c4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 22 Apr 2020 13:10:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:26 +02:00

sched: Remove sched_set_*() return value

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
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c    |  4 +---
 drivers/firmware/psci/psci_checker.c  |  3 +--
 drivers/gpu/drm/msm/msm_drv.c         |  5 +----
 drivers/platform/chrome/cros_ec_spi.c |  7 +++----
 include/linux/sched.h                 |  6 +++---
 kernel/rcu/rcutorture.c               |  5 +----
 kernel/sched/core.c                   | 12 ++++++------
 7 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 140fd98..280615e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -6020,9 +6020,7 @@ int drbd_ack_receiver(struct drbd_thread *thi)
 	int expect   = header_size;
 	bool ping_timeout_active = false;
 
-	rv = sched_set_fifo_low(current);
-	if (rv < 0)
-		drbd_err(connection, "drbd_ack_receiver: ERROR set priority, ret=%d\n", rv);
+	sched_set_fifo_low(current);
 
 	while (get_t_state(thi) == RUNNING) {
 		drbd_thread_current_set_cpu(thi);
diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index a5279a4..6fff482 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -281,8 +281,7 @@ static int suspend_test_thread(void *arg)
 	wait_for_completion(&suspend_threads_started);
 
 	/* Set maximum priority to preempt all other threads on this CPU. */
-	if (sched_set_fifo(current))
-		pr_warn("Failed to set suspend thread scheduler on CPU %d\n", cpu);
+	sched_set_fifo(current);
 
 	dev = this_cpu_read(cpuidle_devices);
 	drv = cpuidle_get_cpu_driver(dev);
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 89a8b9c..556cca3 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -509,10 +509,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 			goto err_msm_uninit;
 		}
 
-		ret = sched_set_fifo(priv->event_thread[i].thread);
-		if (ret)
-			dev_warn(dev, "event_thread set priority failed:%d\n",
-				 ret);
+		sched_set_fifo(priv->event_thread[i].thread);
 	}
 
 	ret = drm_vblank_init(ddev, priv->num_crtcs);
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index c20a43a..d092603 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -725,10 +725,9 @@ static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
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
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b792b8f..ae76644 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1653,9 +1653,9 @@ extern int idle_cpu(int cpu);
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
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bbc3c8a..b4c1146 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -893,10 +893,7 @@ static int rcu_torture_boost(void *arg)
 	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
 
 	/* Set real-time priority. */
-	if (sched_set_fifo_low(current) < 0) {
-		VERBOSE_TOROUT_STRING("rcu_torture_boost RT prio failed!");
-		n_rcu_torture_boost_rterror++;
-	}
+	sched_set_fifo_low(current);
 
 	init_rcu_head_on_stack(&rbi.rcu);
 	/* Each pass through the following loop does one boost-test cycle. */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f882d3d..41d3778 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5183,30 +5183,30 @@ int sched_setscheduler_nocheck(struct task_struct *p, int policy,
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
 
