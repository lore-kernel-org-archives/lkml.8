Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E10C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A8520C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgFPMWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgFPMWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092ACC08C5C3;
        Tue, 16 Jun 2020 05:22:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbI-0004hw-QZ; Tue, 16 Jun 2020 14:22:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8102F1C0838;
        Tue, 16 Jun 2020 14:21:53 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:53 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Impose global limits on
 sched_attr::sched_period
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20190726161357.397880775@infradead.org>
References: <20190726161357.397880775@infradead.org>
MIME-Version: 1.0
Message-ID: <159231011330.16989.6804741545941906806.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b4098bfc5efb1fd7ecf40165132a1283aeea3500
Gitweb:        https://git.kernel.org/tip/b4098bfc5efb1fd7ecf40165132a1283aeea3500
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Jul 2019 16:54:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:04 +02:00

sched/deadline: Impose global limits on sched_attr::sched_period

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726161357.397880775@infradead.org
---
 include/linux/sched/sysctl.h |  3 +++
 kernel/sched/deadline.c      | 23 +++++++++++++++++++++--
 kernel/sysctl.c              | 14 ++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 660ac49..24be30a 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -61,6 +61,9 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
 extern unsigned int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 
+extern unsigned int sysctl_sched_dl_period_max;
+extern unsigned int sysctl_sched_dl_period_min;
+
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 504d2f5..f31964a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2635,6 +2635,14 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
 }
 
 /*
+ * Default limits for DL period; on the top end we guard against small util
+ * tasks still getting rediculous long effective runtimes, on the bottom end we
+ * guard against timer DoS.
+ */
+unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
+unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */
+
+/*
  * This function validates the new parameters of a -deadline task.
  * We ask for the deadline not being zero, and greater or equal
  * than the runtime, as well as the period of being zero or
@@ -2646,6 +2654,8 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
  */
 bool __checkparam_dl(const struct sched_attr *attr)
 {
+	u64 period, max, min;
+
 	/* special dl tasks don't actually use any parameter */
 	if (attr->sched_flags & SCHED_FLAG_SUGOV)
 		return true;
@@ -2669,12 +2679,21 @@ bool __checkparam_dl(const struct sched_attr *attr)
 	    attr->sched_period & (1ULL << 63))
 		return false;
 
+	period = attr->sched_period;
+	if (!period)
+		period = attr->sched_deadline;
+
 	/* runtime <= deadline <= period (if period != 0) */
-	if ((attr->sched_period != 0 &&
-	     attr->sched_period < attr->sched_deadline) ||
+	if (period < attr->sched_deadline ||
 	    attr->sched_deadline < attr->sched_runtime)
 		return false;
 
+	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
+	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
+
+	if (period < min || period > max)
+		return false;
+
 	return true;
 }
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index db1ce7a..4aea67d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1780,6 +1780,20 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= sched_rt_handler,
 	},
 	{
+		.procname	= "sched_deadline_period_max_us",
+		.data		= &sysctl_sched_dl_period_max,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "sched_deadline_period_min_us",
+		.data		= &sysctl_sched_dl_period_min,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
 		.procname	= "sched_rr_timeslice_ms",
 		.data		= &sysctl_sched_rr_timeslice,
 		.maxlen		= sizeof(int),
