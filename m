Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5632C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A0122D72
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SjufbWqH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QvZWk8xH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbgGaJXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732250AbgGaJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:08 -0400
Date:   Fri, 31 Jul 2020 09:23:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=suEVsCpuzCNHGJPRoQikdnR4MQ4iIGgoUzqKiSdZwVk=;
        b=SjufbWqH+O7uuvEAaLm8zRGVvSlftlml33+WFk54oH+lm3DNmKnhBniKR7PggJ2q29CSuC
        K0VQVU/+POzBbRJxfPxReGHTEWbMl5ZtnXalvRjB/8zs3xpMnadsbiNTxB+51mDeo/1ip1
        tDhef9oMLxL5R3Fji+UKsm1VMyHwOkmnTbRH/UdeZO4s9N2u9LdoPsVtN80thRdnCI6Ltw
        cwmdscDd7mEfUFcTDMMJhO8W1slH7UP2V9Wp2H5DYQ/dEtJg9xOqybVCuNH0+tvsBlEM5j
        bZQ2gW9z55VhVEBk9SYrKepbJoR83HC5OaEtzjXes0RHYRBPB24a5HsZqfOdDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=suEVsCpuzCNHGJPRoQikdnR4MQ4iIGgoUzqKiSdZwVk=;
        b=QvZWk8xHXAsGnHhini85RhpezQv8KrnRej3hlcF5Cxz4KDmBBPAPRY0D37CanUHUMSNdpt
        5vj9zKya4LnDJADg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Convert nreaders to a module parameter
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738579.4006.8446103432546939708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8fc28783a0c3704ea27505a25dbde8333d75380c
Gitweb:        https://git.kernel.org/tip/8fc28783a0c3704ea27505a25dbde8333d75380c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 25 May 2020 15:48:38 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:44 -07:00

refperf: Convert nreaders to a module parameter

This commit converts nreaders to a module parameter, with the default
of -1 specifying the old behavior of using 75% of the readers.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index e991d48..020e55a 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -62,6 +62,12 @@ torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_PERF_TEST) ? 10 : 0,
 	      "Holdoff time before test start (s)");
 // Number of loops per experiment, all readers execute operations concurrently.
 torture_param(long, loops, 10000000, "Number of loops per experiment.");
+// Number of readers, with -1 defaulting to about 75% of the CPUs.
+torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
+// Number of runs.
+torture_param(int, nruns, 30, "Number of experiments to run.");
+// Reader delay in nanoseconds, 0 for no delay.
+torture_param(int, readdelay, 0, "Read-side delay in nanoseconds.");
 
 #ifdef MODULE
 # define REFPERF_SHUTDOWN 0
@@ -93,7 +99,6 @@ static wait_queue_head_t main_wq;
 static int shutdown_start;
 
 static struct reader_task *reader_tasks;
-static int nreaders;
 
 // Number of readers that are part of the current experiment.
 static atomic_t nreaders_exp;
@@ -411,8 +416,8 @@ static void
 ref_perf_print_module_parms(struct ref_perf_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" PERF_FLAG
-		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld\n", perf_type, tag,
-		 verbose, shutdown, holdoff, loops);
+		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d\n", perf_type, tag,
+		 verbose, shutdown, holdoff, loops, nreaders);
 }
 
 static void
@@ -501,8 +506,9 @@ ref_perf_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
-	// Reader tasks (~75% of online CPUs).
-	nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
+	// Reader tasks (default to ~75% of online CPUs).
+	if (nreaders < 0)
+		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
 	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (!reader_tasks) {
