Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3CAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C17208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jFnyFRjk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fesh6YZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbgGaJ1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:27:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732327AbgGaJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:03 -0400
Date:   Fri, 31 Jul 2020 09:23:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187382;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zrpGvZKM1tQegdpmgKQPrlybx4PTppNxw8pHVGku/TA=;
        b=jFnyFRjk7ZvogheB8qtrIL6BpHsW6HJpnROypZ7olnY0LYkb71HTbg5ho1hzimw0DtpxW3
        wK4s/68uaG07SXJZBO2RSSe7je0OUk/36U/ugsQqti9fHZhsdMpVlRwR2vn0Q6fdK3z8TO
        eAaOuK2c0RObTCfprOvKEOk1X7vqJVSxkb20ZX94FXYMNp4jw8YjsQbzCfm+cV5kUmEPDe
        4NatH2quxctaJxvVq4KGzsi9sGpmDNB2ga8S0nfvQuuRByDBY80J4rrTtNMQ415H+50H+f
        yhe+Xs0M6Xtl93sQaqhpfHGJUWfzKREmGT9ODvKzDWo5YdmrxmX5G78sL2HnwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187382;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zrpGvZKM1tQegdpmgKQPrlybx4PTppNxw8pHVGku/TA=;
        b=fesh6YZLwKC4FXe7JV6lgPNEwg+7r6nzFknHknJqxLjcZk4sDn1o4OMQlUgNaWH3BvyrJD
        M155H2ozWVs6u9Aw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Convert reader_task structure's "start" field to int
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738172.4006.3842250807190896491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     af2789db13b8dc38d16e969f8c11b9468be42d46
Gitweb:        https://git.kernel.org/tip/af2789db13b8dc38d16e969f8c11b9468be42d46
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 26 May 2020 11:22:03 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Convert reader_task structure's "start" field to int

This commit converts the reader_task structure's "start" field to int
in order to demote a full barrier to an smp_load_acquire() and also to
simplify the code a bit.  While in the area, and to enlist the compiler's
help in ensuring that nothing was missed, the field's name was changed
to start_reader.

Also while in the area, change the main_func() store to use
smp_store_release() to further fortify against wait/wake races.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 8815ccf..2fd3ed1 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -80,7 +80,7 @@ torture_param(bool, shutdown, REFPERF_SHUTDOWN,
 
 struct reader_task {
 	struct task_struct *task;
-	atomic_t start;
+	int start_reader;
 	wait_queue_head_t wq;
 	u64 last_duration_ns;
 };
@@ -243,7 +243,7 @@ repeat:
 	VERBOSE_PERFOUT("ref_perf_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
 
 	// Wait for signal that this reader can start.
-	wait_event(rt->wq, (atomic_read(&nreaders_exp) && atomic_read(&rt->start)) ||
+	wait_event(rt->wq, (atomic_read(&nreaders_exp) && smp_load_acquire(&rt->start_reader)) ||
 			   torture_must_stop());
 
 	if (torture_must_stop())
@@ -252,8 +252,7 @@ repeat:
 	// Make sure that the CPU is affinitized appropriately during testing.
 	WARN_ON_ONCE(smp_processor_id() != me);
 
-	smp_mb__before_atomic();
-	atomic_dec(&rt->start);
+	WRITE_ONCE(rt->start_reader, 0);
 
 	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
 
@@ -372,7 +371,7 @@ static int main_func(void *arg)
 		exp_idx = exp;
 
 		for (r = 0; r < nreaders; r++) {
-			atomic_set(&reader_tasks[r].start, 1);
+			smp_store_release(&reader_tasks[r].start_reader, 1);
 			wake_up(&reader_tasks[r].wq);
 		}
 
