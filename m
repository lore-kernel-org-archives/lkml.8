Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E298C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F169222CAE
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h8C//oYN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iey89HPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbgGaJXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732364AbgGaJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:09 -0400
Date:   Fri, 31 Jul 2020 09:23:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187388;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9f7+HADjGZgioR/2hriGc2ulFhMoHyxqxAyB3AwFWks=;
        b=h8C//oYNG4qZIAIynr+Qlub+9RxY69xVhmXGk7DQS3TnbBJgORofKdnMy6G4cUk8K4Ibiq
        TzPKdmOwqL0kAo5b3NnjJxqRIQXMFCEfFCvWEGVmNQHNZlCz9TlEGZVjLt5GAjmJ/Brx5P
        QCPXRDsoikzDd7GgWK14zPIHlnwbF42EIemGSu/dYd9FM+Tf+IaqM1UE7frtDjKi5AWVpO
        gKaoOb+/hrikm0xJw10A5BHpWqGoSSjCRUmudW61qMWz+bZPmiIeFJbPGz5UQPzVcp24GR
        CRA0FW1CaBJMf95W6XA7hdoVkBaBjEUmQAHHCE9hsWba8yqjeR0IAg+d9cE8jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187388;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9f7+HADjGZgioR/2hriGc2ulFhMoHyxqxAyB3AwFWks=;
        b=Iey89HPXVy8anXBgxNY8QVKZPeUcugSQVnH3KgbyVgADSnlFarWNgtplMI5UjMNcA+D3wr
        E9+H8NOwlTNP8BDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Add holdoff parameter to allow CPUs to come online
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738776.4006.4993083960474428810.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     777a54c908ec69fa0eccab54068a49ecda38ffde
Gitweb:        https://git.kernel.org/tip/777a54c908ec69fa0eccab54068a49ecda38ffde
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 25 May 2020 14:16:44 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:44 -07:00

refperf: Add holdoff parameter to allow CPUs to come online

This commit adds an rcuperf module parameter named "holdoff" that
defaults to 10 seconds if refperf is built in and to zero otherwise.
The assumption is that all the CPUs are online by the time that the
modprobe and insmod commands are going to do anything, and that normal
systems will have all the CPUs online within ten seconds.

Larger systems may take many tens of seconds or even minutes to get
to this point, hence this being a module parameter instead of being a
hard-coded constant.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 6116153..4d686fd 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -57,7 +57,10 @@ MODULE_PARM_DESC(perf_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
 
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 
-// Number of loops per experiment, all readers execute an operation concurrently
+// Wait until there are multiple CPUs before starting test.
+torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_PERF_TEST) ? 10 : 0,
+	      "Holdoff time before test start (s)");
+// Number of loops per experiment, all readers execute operations concurrently.
 torture_param(long, loops, 10000000, "Number of loops per experiment.");
 
 #ifdef MODULE
@@ -248,6 +251,8 @@ ref_perf_reader(void *arg)
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 	atomic_inc(&n_init);
+	if (holdoff)
+		schedule_timeout_interruptible(holdoff * HZ);
 repeat:
 	VERBOSE_PERFOUT("ref_perf_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
 
@@ -357,6 +362,8 @@ static int main_func(void *arg)
 
 	// Wait for all threads to start.
 	wait_event(main_wq, atomic_read(&n_init) == (nreaders + 1));
+	if (holdoff)
+		schedule_timeout_interruptible(holdoff * HZ);
 
 	// Start exp readers up per experiment
 	for (exp = 0; exp < nreaders && !torture_must_stop(); exp++) {
@@ -420,8 +427,8 @@ static void
 ref_perf_print_module_parms(struct ref_perf_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" PERF_FLAG
-		 "--- %s:  verbose=%d shutdown=%d loops=%ld\n", perf_type, tag,
-		 verbose, shutdown, loops);
+		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld\n", perf_type, tag,
+		 verbose, shutdown, holdoff, loops);
 }
 
 static void
