Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B499C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5024207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zEJIlQU/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ki2w1u+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgHSX0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:26:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42920 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgHSX0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:26:36 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597879594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jFsknb75P8Ohiy67kUFniJeH036W1zSyNjXPZ5JEf0=;
        b=zEJIlQU/IWvUbtZ7Cnqbc6HUGkLBmqUEnubivvwLyCvxm1jIZbJoVdOVqPuOb1zRZr2lWh
        zLaGZikeEszfP8voJw3pGMpbS2W8dTiRmmo+cRGPfkQ0jtbWbymlzAqE84Lbyxv09ZRgBW
        sqruxTa9WdVB0wD0NMLwaI9Njb+Ub4fMa/DICoCOgSezHcs9eatHzaea9mSKMtXEjk21mE
        +l3mEx66zC3svKvfweaoe03ndN7CPrAT5nYUUiB4OZZrD5Xv8LTezdVAI9lt1Mw1bMM88h
        sJu3a6kAdkVZ5B49n7WbY4/MCzq3M1BvstUdliKeLh5+W5GGXdNLANdhn/onmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597879594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jFsknb75P8Ohiy67kUFniJeH036W1zSyNjXPZ5JEf0=;
        b=ki2w1u+etBhMuluB8Q/2M0ra+WgdJg9GEDlH9/vSfcEsxBqDowYqlQb4fgOGjmnB6006rO
        ChnHTv9zlRmwHQCg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] workqueue: use pr_cont_t for cont messages
Date:   Thu, 20 Aug 2020 01:32:30 +0206
Message-Id: <20200819232632.13418-4-john.ogness@linutronix.de>
In-Reply-To: <20200819232632.13418-1-john.ogness@linutronix.de>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pr_cont_t mechanism.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/workqueue.c | 71 +++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c41c3c17b86a..472370f02001 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4645,32 +4645,34 @@ void print_worker_info(const char *log_lvl, struct task_struct *task)
 	copy_from_kernel_nofault(desc, worker->desc, sizeof(desc) - 1);
 
 	if (fn || name[0] || desc[0]) {
-		printk("%sWorkqueue: %s %ps", log_lvl, name, fn);
+		pr_cont_t c;
+
+		pr_cont_begin(&c, "%sWorkqueue: %s %ps", log_lvl, name, fn);
 		if (strcmp(name, desc))
-			pr_cont(" (%s)", desc);
-		pr_cont("\n");
+			pr_cont_append(&c, " (%s)", desc);
+		pr_cont_end(&c);
 	}
 }
 
-static void pr_cont_pool_info(struct worker_pool *pool)
+static void pr_cont_pool_info(pr_cont_t *c, struct worker_pool *pool)
 {
-	pr_cont(" cpus=%*pbl", nr_cpumask_bits, pool->attrs->cpumask);
+	pr_cont_append(c, " cpus=%*pbl", nr_cpumask_bits, pool->attrs->cpumask);
 	if (pool->node != NUMA_NO_NODE)
-		pr_cont(" node=%d", pool->node);
-	pr_cont(" flags=0x%x nice=%d", pool->flags, pool->attrs->nice);
+		pr_cont_append(c, " node=%d", pool->node);
+	pr_cont_append(c, " flags=0x%x nice=%d", pool->flags, pool->attrs->nice);
 }
 
-static void pr_cont_work(bool comma, struct work_struct *work)
+static void pr_cont_work(pr_cont_t *c, bool comma, struct work_struct *work)
 {
 	if (work->func == wq_barrier_func) {
 		struct wq_barrier *barr;
 
 		barr = container_of(work, struct wq_barrier, work);
 
-		pr_cont("%s BAR(%d)", comma ? "," : "",
+		pr_cont_append(c, "%s BAR(%d)", comma ? "," : "",
 			task_pid_nr(barr->task));
 	} else {
-		pr_cont("%s %ps", comma ? "," : "", work->func);
+		pr_cont_append(c, "%s %ps", comma ? "," : "", work->func);
 	}
 }
 
@@ -4680,14 +4682,16 @@ static void show_pwq(struct pool_workqueue *pwq)
 	struct work_struct *work;
 	struct worker *worker;
 	bool has_in_flight = false, has_pending = false;
+	pr_cont_t c;
 	int bkt;
 
-	pr_info("  pwq %d:", pool->id);
-	pr_cont_pool_info(pool);
+	pr_cont_begin(&c, KERN_INFO "  pwq %d:", pool->id);
+	pr_cont_pool_info(&c, pool);
 
-	pr_cont(" active=%d/%d refcnt=%d%s\n",
+	pr_cont_append(&c, " active=%d/%d refcnt=%d%s",
 		pwq->nr_active, pwq->max_active, pwq->refcnt,
 		!list_empty(&pwq->mayday_node) ? " MAYDAY" : "");
+	pr_cont_end(&c);
 
 	hash_for_each(pool->busy_hash, bkt, worker, hentry) {
 		if (worker->current_pwq == pwq) {
@@ -4698,20 +4702,20 @@ static void show_pwq(struct pool_workqueue *pwq)
 	if (has_in_flight) {
 		bool comma = false;
 
-		pr_info("    in-flight:");
+		pr_cont_begin(&c, KERN_INFO "    in-flight:");
 		hash_for_each(pool->busy_hash, bkt, worker, hentry) {
 			if (worker->current_pwq != pwq)
 				continue;
 
-			pr_cont("%s %d%s:%ps", comma ? "," : "",
+			pr_cont_append(&c, "%s %d%s:%ps", comma ? "," : "",
 				task_pid_nr(worker->task),
 				worker->rescue_wq ? "(RESCUER)" : "",
 				worker->current_func);
 			list_for_each_entry(work, &worker->scheduled, entry)
-				pr_cont_work(false, work);
+				pr_cont_work(&c, false, work);
 			comma = true;
 		}
-		pr_cont("\n");
+		pr_cont_end(&c);
 	}
 
 	list_for_each_entry(work, &pool->worklist, entry) {
@@ -4723,26 +4727,26 @@ static void show_pwq(struct pool_workqueue *pwq)
 	if (has_pending) {
 		bool comma = false;
 
-		pr_info("    pending:");
+		pr_cont_begin(&c, KERN_INFO "    pending:");
 		list_for_each_entry(work, &pool->worklist, entry) {
 			if (get_work_pwq(work) != pwq)
 				continue;
 
-			pr_cont_work(comma, work);
+			pr_cont_work(&c, comma, work);
 			comma = !(*work_data_bits(work) & WORK_STRUCT_LINKED);
 		}
-		pr_cont("\n");
+		pr_cont_end(&c);
 	}
 
 	if (!list_empty(&pwq->delayed_works)) {
 		bool comma = false;
 
-		pr_info("    delayed:");
+		pr_cont_begin(&c, KERN_INFO "    delayed:");
 		list_for_each_entry(work, &pwq->delayed_works, entry) {
-			pr_cont_work(comma, work);
+			pr_cont_work(&c, comma, work);
 			comma = !(*work_data_bits(work) & WORK_STRUCT_LINKED);
 		}
-		pr_cont("\n");
+		pr_cont_end(&c);
 	}
 }
 
@@ -4757,6 +4761,7 @@ void show_workqueue_state(void)
 	struct workqueue_struct *wq;
 	struct worker_pool *pool;
 	unsigned long flags;
+	pr_cont_t c;
 	int pi;
 
 	rcu_read_lock();
@@ -4800,20 +4805,20 @@ void show_workqueue_state(void)
 		if (pool->nr_workers == pool->nr_idle)
 			goto next_pool;
 
-		pr_info("pool %d:", pool->id);
-		pr_cont_pool_info(pool);
-		pr_cont(" hung=%us workers=%d",
+		pr_cont_begin(&c, KERN_INFO "pool %d:", pool->id);
+		pr_cont_pool_info(&c, pool);
+		pr_cont_append(&c, " hung=%us workers=%d",
 			jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
 			pool->nr_workers);
 		if (pool->manager)
-			pr_cont(" manager: %d",
+			pr_cont_append(&c, " manager: %d",
 				task_pid_nr(pool->manager->task));
 		list_for_each_entry(worker, &pool->idle_list, entry) {
-			pr_cont(" %s%d", first ? "idle: " : "",
+			pr_cont_append(&c, " %s%d", first ? "idle: " : "",
 				task_pid_nr(worker->task));
 			first = false;
 		}
-		pr_cont("\n");
+		pr_cont_end(&c);
 	next_pool:
 		raw_spin_unlock_irqrestore(&pool->lock, flags);
 		/*
@@ -5752,6 +5757,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	unsigned long thresh = READ_ONCE(wq_watchdog_thresh) * HZ;
 	bool lockup_detected = false;
 	struct worker_pool *pool;
+	pr_cont_t c;
 	int pi;
 
 	if (!thresh)
@@ -5785,10 +5791,11 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 		/* did we stall? */
 		if (time_after(jiffies, ts + thresh)) {
 			lockup_detected = true;
-			pr_emerg("BUG: workqueue lockup - pool");
-			pr_cont_pool_info(pool);
-			pr_cont(" stuck for %us!\n",
+			pr_cont_begin(&c, KERN_EMERG "BUG: workqueue lockup - pool");
+			pr_cont_pool_info(&c, pool);
+			pr_cont_append(&c, " stuck for %us!",
 				jiffies_to_msecs(jiffies - pool_ts) / 1000);
+			pr_cont_end(&c);
 		}
 	}
 
-- 
2.20.1

