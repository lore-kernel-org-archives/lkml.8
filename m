Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3015CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04217208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fe+AO5JP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kCrY7qKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbgGaJXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbgGaJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:07 -0400
Date:   Fri, 31 Jul 2020 09:23:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wP0faWnh87/x8O3H8Tew2erCcR7O8trsFosVe6x6pyM=;
        b=Fe+AO5JPpgh4OO+v0M7pcaGWPavAHi2v4GzUVeFKO2DsqYQAexex+WbVVom3k4oO3vryYt
        GsCaTui0EMHIiOYV/cQYciKKTS8yCFIWsGvtSV6/Gp16LxcqiBZbdt+7P9ZNv84a2k3Nrx
        oeXaXL2b/Jr3AUj1LxI5+tRxiubtK2q3hBL5TNW2Qf3JHHaJdxcUJkBmNZzl5Lk486S5qM
        ra9cKdpD7aBduZ8qYMjsMuvQKWthwyouSKOj6qQ4FbFPZwXVlp1mDs7sDVgqt3stla2uFR
        6aAFBREupiycIfgnBf+gBU9FQEMP9qqM5+tm6SZ8GLCKNy+fltJDJNvghXm0hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wP0faWnh87/x8O3H8Tew2erCcR7O8trsFosVe6x6pyM=;
        b=kCrY7qKVZek/11TXEr8qHJ0e6d1raLFVLROdiRGpMprtTFQMdvBIFa24KyG/5UXqFPdWr9
        3A666RcWFuLgPbAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Provide module parameter to specify number
 of experiments
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738514.4006.9792081131183897001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     dbf28efdae7bb51032eeb0fe1b6bd07d6f0f9b6c
Gitweb:        https://git.kernel.org/tip/dbf28efdae7bb51032eeb0fe1b6bd07d6f0f9b6c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 25 May 2020 17:22:24 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:44 -07:00

refperf: Provide module parameter to specify number of experiments

The current code uses the number of threads both to limit the number
of threads and to specify the number of experiments, but also varies
the number of threads as the experiments progress.  This commit takes
a different approach by adding an refperf.nruns module parameter that
specifies the number of experiments, and furthermore uses the same
number of threads for each experiment.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 020e55a..6324449 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -83,12 +83,6 @@ struct reader_task {
 	atomic_t start;
 	wait_queue_head_t wq;
 	u64 last_duration_ns;
-
-	// The average latency When 1..<this reader> are concurrently
-	// running an experiment. For example, if this reader_task is
-	// of index 5 in the reader_tasks array, then result is for
-	// 6 cores.
-	u64 result_avg;
 };
 
 static struct task_struct *shutdown_task;
@@ -289,12 +283,12 @@ end:
 	return 0;
 }
 
-void reset_readers(int n)
+void reset_readers(void)
 {
 	int i;
 	struct reader_task *rt;
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < nreaders; i++) {
 		rt = &(reader_tasks[i]);
 
 		rt->last_duration_ns = 0;
@@ -314,7 +308,7 @@ u64 process_durations(int n)
 	sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
 		exp_idx);
 
-	for (i = 0; i <= n && !torture_must_stop(); i++) {
+	for (i = 0; i < n && !torture_must_stop(); i++) {
 		rt = &(reader_tasks[i]);
 		sprintf(buf1, "%d: %llu\t", i, rt->last_duration_ns);
 
@@ -342,11 +336,15 @@ static int main_func(void *arg)
 	int exp, r;
 	char buf1[64];
 	char buf[512];
+	u64 *result_avg;
 
 	set_cpus_allowed_ptr(current, cpumask_of(nreaders % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 
 	VERBOSE_PERFOUT("main_func task started");
+	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
+	if (!result_avg)
+		VERBOSE_PERFOUT_ERRSTRING("out of memory");
 	atomic_inc(&n_init);
 
 	// Wait for all threads to start.
@@ -355,22 +353,24 @@ static int main_func(void *arg)
 		schedule_timeout_interruptible(holdoff * HZ);
 
 	// Start exp readers up per experiment
-	for (exp = 0; exp < nreaders && !torture_must_stop(); exp++) {
+	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
+		if (!result_avg)
+			break;
 		if (torture_must_stop())
 			goto end;
 
-		reset_readers(exp);
-		atomic_set(&nreaders_exp, exp + 1);
+		reset_readers();
+		atomic_set(&nreaders_exp, nreaders);
 
 		exp_idx = exp;
 
-		for (r = 0; r <= exp; r++) {
+		for (r = 0; r < nreaders; r++) {
 			atomic_set(&reader_tasks[r].start, 1);
 			wake_up(&reader_tasks[r].wq);
 		}
 
 		VERBOSE_PERFOUT("main_func: experiment started, waiting for %d readers",
-				exp);
+				nreaders);
 
 		wait_event(main_wq,
 			   !atomic_read(&nreaders_exp) || torture_must_stop());
@@ -380,7 +380,7 @@ static int main_func(void *arg)
 		if (torture_must_stop())
 			goto end;
 
-		reader_tasks[exp].result_avg = 1000 * process_durations(exp) / ((exp + 1) * loops);
+		result_avg[exp] = 1000 * process_durations(nreaders) / (nreaders * loops);
 	}
 
 	// Print the average of all experiments
@@ -390,12 +390,15 @@ static int main_func(void *arg)
 	strcat(buf, "\n");
 	strcat(buf, "Threads\tTime(ns)\n");
 
-	for (exp = 0; exp < nreaders; exp++) {
-		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, reader_tasks[exp].result_avg / 1000, (int)(reader_tasks[exp].result_avg % 1000));
+	for (exp = 0; exp < nruns; exp++) {
+		if (!result_avg)
+			break;
+		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(result_avg[exp] % 1000));
 		strcat(buf, buf1);
 	}
 
-	PERFOUT("%s", buf);
+	if (result_avg)
+		PERFOUT("%s", buf);
 
 	// This will shutdown everything including us.
 	if (shutdown) {
@@ -416,8 +419,8 @@ static void
 ref_perf_print_module_parms(struct ref_perf_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" PERF_FLAG
-		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d\n", perf_type, tag,
-		 verbose, shutdown, holdoff, loops, nreaders);
+		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d nruns=%d\n", perf_type, tag,
+		 verbose, shutdown, holdoff, loops, nreaders, nruns);
 }
 
 static void
