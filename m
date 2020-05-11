Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47501C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B452078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgEKU7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbgEKU7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3440AC061A0C;
        Mon, 11 May 2020 13:59:16 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFW6-0005eP-Jv; Mon, 11 May 2020 22:59:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E68D01C001F;
        Mon, 11 May 2020 22:59:13 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:13 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Convert ULONG_CMP_LT() to time_before()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075330.390.2075042483179383674.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3c80b4024579150ddb8ddd6fd7b110ba192aca3b
Gitweb:        https://git.kernel.org/tip/3c80b4024579150ddb8ddd6fd7b110ba192aca3b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 10 Apr 2020 15:37:12 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 07 May 2020 10:15:29 -07:00

rcutorture: Convert ULONG_CMP_LT() to time_before()

This commit converts three ULONG_CMP_LT() invocations in rcutorture to
time_before() to reflect the fact that they are comparing timestamps to
the jiffies counter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c7b7594..fc96147 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -848,7 +848,7 @@ static int rcu_torture_boost(void *arg)
 
 		/* Wait for the next test interval. */
 		oldstarttime = boost_starttime;
-		while (ULONG_CMP_LT(jiffies, oldstarttime)) {
+		while (time_before(jiffies, oldstarttime)) {
 			schedule_timeout_interruptible(oldstarttime - jiffies);
 			stutter_wait("rcu_torture_boost");
 			if (torture_must_stop())
@@ -858,7 +858,7 @@ static int rcu_torture_boost(void *arg)
 		/* Do one boost-test interval. */
 		endtime = oldstarttime + test_boost_duration * HZ;
 		call_rcu_time = jiffies;
-		while (ULONG_CMP_LT(jiffies, endtime)) {
+		while (time_before(jiffies, endtime)) {
 			/* If we don't have a callback in flight, post one. */
 			if (!smp_load_acquire(&rbi.inflight)) {
 				/* RCU core before ->inflight = 1. */
@@ -929,7 +929,7 @@ rcu_torture_fqs(void *arg)
 	VERBOSE_TOROUT_STRING("rcu_torture_fqs task started");
 	do {
 		fqs_resume_time = jiffies + fqs_stutter * HZ;
-		while (ULONG_CMP_LT(jiffies, fqs_resume_time) &&
+		while (time_before(jiffies, fqs_resume_time) &&
 		       !kthread_should_stop()) {
 			schedule_timeout_interruptible(1);
 		}
