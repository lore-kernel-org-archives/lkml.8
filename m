Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587DAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D841208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pWws4TiA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oXV2k/B9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbgGaJ1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:27:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732347AbgGaJXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:06 -0400
Date:   Fri, 31 Jul 2020 09:23:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2hg/IbXXN6d3ncqczMwDUWcxmFWxt1qfDGW2D9wCm5I=;
        b=pWws4TiAeYP18g5UabXEQpLXr7DfD8ugyDtCaUYxu0tOfWvPFer/uESOHYXIy7G6lEgICS
        Gn/3AsssorMshbXN8ZH7D2TiF4xfORFZmAsejV7sQRZDl1B/+KU1MGXCDew1F/IXs/2QbQ
        eAgXFPSBWkPc+wpVUOTvabWJsjsJ9DChvSbTuhdj0t5zHiMHw+zwVvXACBjQ12xm5SpCnV
        Jq15Xe2744utb44JocJLsx7bha+x/orJFwZZ/IHGjScEnYFpEZRVIT0pSGhTNjLs7GRSXL
        hs/yvKhI5Rrw9RtLKUgRXfqdYDHb+jSq6rZIH/InWWJM6H7DjW7Me0xej2gu4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2hg/IbXXN6d3ncqczMwDUWcxmFWxt1qfDGW2D9wCm5I=;
        b=oXV2k/B9qXDjhIJRe8pGqrv9l8ypoeOP2C9GVh6K/gdJcY49G7alz7GZdeLxLOhQ/gxnZP
        4IvpmXYSXG+d7FCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Dynamically allocate experiment-summary
 output buffer
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738442.4006.8486048202456939490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f518f154ecef347777db33b7c9b0581f245159f0
Gitweb:        https://git.kernel.org/tip/f518f154ecef347777db33b7c9b0581f245159f0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 25 May 2020 17:32:56 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:44 -07:00

refperf: Dynamically allocate experiment-summary output buffer

Currently, the buffer used to accumulate the experiment-summary output
is fixed size, which will cause problems if someone decides to run
one hundred experiments.  This commit therefore dynamically allocates
this buffer.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 6324449..75b9cce 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -333,9 +333,10 @@ u64 process_durations(int n)
 // point all the timestamps are printed.
 static int main_func(void *arg)
 {
+	bool errexit = false;
 	int exp, r;
 	char buf1[64];
-	char buf[512];
+	char *buf;
 	u64 *result_avg;
 
 	set_cpus_allowed_ptr(current, cpumask_of(nreaders % nr_cpu_ids));
@@ -343,8 +344,11 @@ static int main_func(void *arg)
 
 	VERBOSE_PERFOUT("main_func task started");
 	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
-	if (!result_avg)
+	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
+	if (!result_avg || !buf) {
 		VERBOSE_PERFOUT_ERRSTRING("out of memory");
+		errexit = true;
+	}
 	atomic_inc(&n_init);
 
 	// Wait for all threads to start.
@@ -354,7 +358,7 @@ static int main_func(void *arg)
 
 	// Start exp readers up per experiment
 	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
-		if (!result_avg)
+		if (errexit)
 			break;
 		if (torture_must_stop())
 			goto end;
@@ -391,13 +395,13 @@ static int main_func(void *arg)
 	strcat(buf, "Threads\tTime(ns)\n");
 
 	for (exp = 0; exp < nruns; exp++) {
-		if (!result_avg)
+		if (errexit)
 			break;
 		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(result_avg[exp] % 1000));
 		strcat(buf, buf1);
 	}
 
-	if (result_avg)
+	if (!errexit)
 		PERFOUT("%s", buf);
 
 	// This will shutdown everything including us.
@@ -412,6 +416,8 @@ static int main_func(void *arg)
 
 end:
 	torture_kthread_stopping("main_func");
+	kfree(result_avg);
+	kfree(buf);
 	return 0;
 }
 
