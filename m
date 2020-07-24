Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5B1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF9C2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="biWEXz7C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="86SfUkKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGXIez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgGXIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE82AC0619D3;
        Fri, 24 Jul 2020 01:33:42 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ICXGZ0VvsLyUxUZN8C8+30WdDsDOq10J73vuu9Ocoyk=;
        b=biWEXz7CA+kj8+tCA3cD7dnuhf/wQouGF7K4H75XE01+BoPVQ4nGotT37xzeS3mBSwqaD+
        3TdYdmshlQd/c+v0YTHJTcB9jKEKT6dEW5477ZwE8wI8VYoS1ZEWfxfEegkIsf1lqcWBEU
        5WdAvOmokeXQ75TnzFsbIlm339wlCLqFNXj6P0NfpQdX2RTXankiZI5SsOdWFn9gh09ly6
        j3ZmBXtkhl7zUqbYRsy85Lq7MW0g2yyPyKaFaXD3dbsXsBNNX+NvP5hfP3ksjXB6+lATUh
        v12Wz868IUUONFS4kyWKmoxM5Va39PJFwAJGwTwkJblEjB+H7h0CPhHcStqclg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ICXGZ0VvsLyUxUZN8C8+30WdDsDOq10J73vuu9Ocoyk=;
        b=86SfUkKsasl7GQ0UOsKp9SXfc2fr3tWB3/OEgBC/Dpq+wgrqK+HpxZGYJQJyP1/4/BV2jK
        pD672H0l51Q/QzDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,rcuperf: Convert to sched_set_fifo_low()
Cc:     paulmck@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962063.4006.10384073492002752875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     b1433395c4cc078b4382429e6d7dd1721714094f
Gitweb:        https://git.kernel.org/tip/b1433395c4cc078b4382429e6d7dd1721714094f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:24 +02:00

sched,rcuperf: Convert to sched_set_fifo_low()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively no change.

Cc: paulmck@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuperf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 16dd1e6..64249a0 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -354,7 +354,6 @@ rcu_perf_writer(void *arg)
 	int i_max;
 	long me = (long)arg;
 	struct rcu_head *rhp = NULL;
-	struct sched_param sp;
 	bool started = false, done = false, alldone = false;
 	u64 t;
 	u64 *wdp;
@@ -363,8 +362,7 @@ rcu_perf_writer(void *arg)
 	VERBOSE_PERFOUT_STRING("rcu_perf_writer task started");
 	WARN_ON(!wdpp);
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
-	sp.sched_priority = 1;
-	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
+	sched_set_fifo_low(current);
 
 	if (holdoff)
 		schedule_timeout_uninterruptible(holdoff * HZ);
@@ -420,9 +418,7 @@ retry:
 			started = true;
 		if (!done && i >= MIN_MEAS) {
 			done = true;
-			sp.sched_priority = 0;
-			sched_setscheduler_nocheck(current,
-						   SCHED_NORMAL, &sp);
+			sched_set_normal(current, 0);
 			pr_alert("%s%s rcu_perf_writer %ld has %d measurements\n",
 				 perf_type, PERF_FLAG, me, MIN_MEAS);
 			if (atomic_inc_return(&n_rcu_perf_writer_finished) >=
