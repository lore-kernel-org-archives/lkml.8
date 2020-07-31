Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E75C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7607522CAD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SdUcGqbi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z3Jqso4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbgGaJXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbgGaJXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:04 -0400
Date:   Fri, 31 Jul 2020 09:23:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mi9zTcmttHJ0P6cjHhXxuHD5Qxkz3MpJ0pgh0GZKNa8=;
        b=SdUcGqbiaPO4YAbP+hR9aFUIvYNzEnwLH+g7BJHWY0xCs7FMhhPlBDQ+rxhWf1OE8HndKm
        tfL42LDPa9EbQNqKqmmnvshBQ5njCB1uiLQLgCxmJz6VjAO238tmB0a7hf42ZvelxwZcV6
        y9p49Ky6Exq+nlzGPYmUJ+jen6xeY/k9CNNBU1gI8DDNMA+dIUcjDiHa1wyFjLpad85Xpr
        3MFHHE1LMkwIadFD/sNwqhn8Rk7bR4TQutV0Swt/ULzW+RajVJnju4Sa7Tt6DWZzq/P0lL
        ZWSVGTrB8ScpM1tdj+UTDn5SsLu5XTm/lp/mdSisWwzz/iTOTeku4syUYyPZ1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mi9zTcmttHJ0P6cjHhXxuHD5Qxkz3MpJ0pgh0GZKNa8=;
        b=Z3Jqso4N2gpChExxV1WNQv7Oah8S75ZeIh/mHHRUnG/M+1wYSG+h5swYfco4sTZvme4mpw
        riGn7lQP2lLZoQBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Tune reader measurement interval
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738237.4006.14483338208842342834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b864f89ff61492f56b4e8c6713a5efec6540a0e2
Gitweb:        https://git.kernel.org/tip/b864f89ff61492f56b4e8c6713a5efec6540a0e2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 26 May 2020 10:57:34 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Tune reader measurement interval

This commit moves a printk() out of the measurement interval, converts
a atomic_dec()/atomic_read() pair to atomic_dec_and_test(), and adds
a smp_mb__before_atomic() to avoid potential wake/wait hangs.  These
changes have the added benefit of reducing the number of loops required
for amortizing loop overhead for CONFIG_PREEMPT=n RCU measurements from
1,000,000 to 10,000.  This reduction in turn shortens the test, reducing
the probability of interference.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 0a900f3..8815ccf 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -252,15 +252,16 @@ repeat:
 	// Make sure that the CPU is affinitized appropriately during testing.
 	WARN_ON_ONCE(smp_processor_id() != me);
 
+	smp_mb__before_atomic();
 	atomic_dec(&rt->start);
 
+	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
+
 	// To prevent noise, keep interrupts disabled. This also has the
 	// effect of preventing entries into slow path for rcu_read_unlock().
 	local_irq_save(flags);
 	start = ktime_get_mono_fast_ns();
 
-	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
-
 	cur_ops->readsection(loops);
 
 	duration = ktime_get_mono_fast_ns() - start;
@@ -268,14 +269,12 @@ repeat:
 
 	rt->last_duration_ns = WARN_ON_ONCE(duration < 0) ? 0 : duration;
 
-	atomic_dec(&nreaders_exp);
+	if (atomic_dec_and_test(&nreaders_exp))
+		wake_up(&main_wq);
 
 	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d ended, (readers remaining=%d)",
 			me, exp_idx, atomic_read(&nreaders_exp));
 
-	if (!atomic_read(&nreaders_exp))
-		wake_up(&main_wq);
-
 	if (!torture_must_stop())
 		goto repeat;
 end:
