Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F60C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B7122CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qzxnn2eS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1kMLSpvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbgGaJXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732307AbgGaJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:00 -0400
Date:   Fri, 31 Jul 2020 09:22:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GtjgkXgT7rAUnsn6hTgRIQGiu6NvXZG2M6yYCol0E8k=;
        b=qzxnn2eStnXc8FdWAaMoR9oK1tFYVCG/fibcOKt4y8lgiR4IjuXq0bHPfIZ5ObN3/nEz6u
        EcqtMvlLV4GFYTv6xS18S8HyhqLBrxK7oaONIhGPlgr32N1gthJ6SM153D+pUB7ekPYbMz
        cQjyHmGAgpj6fQ8lmEDHRz/4C1ZD/EXoxPfrJt1PZgj+suGt37l3dfICCFpGBGMRoOtH+7
        RHsI16sidRIONq9cnnc10osQerexFt507EuwI0BO1EQ5QKRLoJluMsoF86sSvHBAIEwGWh
        9dhvWcu2ukT67BkZPbGJEjkMlGJ+j3jy3rBwUkTR0v514oH3KOSkaQmb2+wTlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GtjgkXgT7rAUnsn6hTgRIQGiu6NvXZG2M6yYCol0E8k=;
        b=1kMLSpvTf0KizQzo3r402epmBzR8XakGbuVZmDugC8GIM2eq758dUxDvmt6lhE7p3e0HYN
        aCALAaG6yWwfGUDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Simplify initialization-time wakeup protocol
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737857.4006.14705954945397729782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     96af8669591d740a1e2695c4d96e544409dbf896
Gitweb:        https://git.kernel.org/tip/96af8669591d740a1e2695c4d96e544409dbf896
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 27 May 2020 16:46:56 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Simplify initialization-time wakeup protocol

This commit moves the reader-launch wait loop from ref_perf_init()
to main_func(), removing one layer of wakeup and allowing slightly
faster system boot.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 2d2d227..7839237 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -369,13 +369,14 @@ static int main_func(void *arg)
 		VERBOSE_PERFOUT_ERRSTRING("out of memory");
 		errexit = true;
 	}
-	atomic_inc(&n_init);
-
-	// Wait for all threads to start.
-	wait_event(main_wq, atomic_read(&n_init) == (nreaders + 1));
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
 
+	// Wait for all threads to start.
+	atomic_inc(&n_init);
+	while (atomic_read(&n_init) < nreaders + 1)
+		schedule_timeout_uninterruptible(1);
+
 	// Start exp readers up per experiment
 	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
 		if (errexit)
@@ -565,14 +566,6 @@ ref_perf_init(void)
 	firsterr = torture_create_kthread(main_func, NULL, main_task);
 	if (firsterr)
 		goto unwind;
-	schedule_timeout_uninterruptible(1);
-
-
-	// Wait until all threads start
-	while (atomic_read(&n_init) < nreaders + 1)
-		schedule_timeout_uninterruptible(1);
-
-	wake_up(&main_wq);
 
 	torture_init_end();
 	return 0;
