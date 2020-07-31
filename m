Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF81C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A91122EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0fE532LM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Ij9d8OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbgGaJX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732320AbgGaJXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:04 -0400
Date:   Fri, 31 Jul 2020 09:23:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VeKui5SC6W5V0dmXk4nOrzyMUmUCEv1bAJxbgITkPRM=;
        b=0fE532LMszCMmdcFlCrbs8C3Z1cN8kgoODgb7NjToGSY89eZWmF2idyTVS0OXhRJ9hTXMg
        Zc4N5nKTEz6rT2WdvIBe1uA6/M6qMAy7J1wuK+oZ/Ys1hl242CtBsnGl1cJNrJs7HCNEK8
        oQxJR0XRX16IrEc0jbGN6vPYCL6hkj/WO4DZDYrvmVQCObWPjlee9nW8a8CNnGxon+RbaM
        xqud4IslMyItQ8WkGgrAp1bBbf3wxelcdzWl1pqvRRhQHi6fNxoiOI31tG3EelwcPsPqa6
        etu7PgcTNorcehe8lYHRX/fujRgsRnwDIRNNlHiy7MieWUZycgfefoavELGtuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VeKui5SC6W5V0dmXk4nOrzyMUmUCEv1bAJxbgITkPRM=;
        b=/Ij9d8OTgqHzgey7s+PPWcjoa60MzCrggadgoPwUmz4r2yu6jzpmLPPQSeOL9qkMNSGCcJ
        a0EH2PguGrxLAIDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Add warmup and cooldown processing phases
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738049.4006.16848409473620043188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2db0bda38453f472640f4ece1e2a495cbd44f892
Gitweb:        https://git.kernel.org/tip/2db0bda38453f472640f4ece1e2a495cbd44f892
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 26 May 2020 12:34:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Add warmup and cooldown processing phases

This commit causes all the readers to start running unmeasured load
until all readers have done at least one such run (thus having warmed
up), then run the measured load, and then run unmeasured load until all
readers have completed their measured load.  This approach avoids any
thread running measured load while other readers are idle.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 234bb0e..445190b 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -100,6 +100,8 @@ static atomic_t nreaders_exp;
 // Use to wait for all threads to start.
 static atomic_t n_init;
 static atomic_t n_started;
+static atomic_t n_warmedup;
+static atomic_t n_cooleddown;
 
 // Track which experiment is currently running.
 static int exp_idx;
@@ -260,8 +262,15 @@ repeat:
 
 	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
 
-	// To prevent noise, keep interrupts disabled. This also has the
-	// effect of preventing entries into slow path for rcu_read_unlock().
+
+	// To reduce noise, do an initial cache-warming invocation, check
+	// in, and then keep warming until everyone has checked in.
+	cur_ops->readsection(loops);
+	if (!atomic_dec_return(&n_warmedup))
+		while (atomic_read_acquire(&n_warmedup))
+			cur_ops->readsection(loops);
+	// Also keep interrupts disabled.  This also has the effect
+	// of preventing entries into slow path for rcu_read_unlock().
 	local_irq_save(flags);
 	start = ktime_get_mono_fast_ns();
 
@@ -271,6 +280,11 @@ repeat:
 	local_irq_restore(flags);
 
 	rt->last_duration_ns = WARN_ON_ONCE(duration < 0) ? 0 : duration;
+	// To reduce runtime-skew noise, do maintain-load invocations until
+	// everyone is done.
+	if (!atomic_dec_return(&n_cooleddown))
+		while (atomic_read_acquire(&n_cooleddown))
+			cur_ops->readsection(loops);
 
 	if (atomic_dec_and_test(&nreaders_exp))
 		wake_up(&main_wq);
@@ -372,6 +386,8 @@ static int main_func(void *arg)
 		reset_readers();
 		atomic_set(&nreaders_exp, nreaders);
 		atomic_set(&n_started, nreaders);
+		atomic_set(&n_warmedup, nreaders);
+		atomic_set(&n_cooleddown, nreaders);
 
 		exp_idx = exp;
 
