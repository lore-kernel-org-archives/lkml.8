Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2438BC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A5220658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgCXJUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:20:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43911 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgCXJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffn-0007yI-Sv; Tue, 24 Mar 2020 10:16:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8FC0F1C0494;
        Tue, 24 Mar 2020 10:16:33 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:33 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Fix
 rcu_torture_one_read()/rcu_torture_writer() data race
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139328.28353.6353053425817942706.tip-bot2@tip-bot2>
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

Commit-ID:     202489101f2e6cee3f6dffc087a4abd5fdfcebda
Gitweb:        https://git.kernel.org/tip/202489101f2e6cee3f6dffc087a4abd5fdfcebda
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 21 Dec 2019 10:41:48 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:31 -08:00

rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race

The ->rtort_pipe_count field in the rcu_torture structure checks for
too-short grace periods, and is therefore read by rcutorture's readers
while being updated by rcutorture's writers.  This commit therefore
adds the needed READ_ONCE() and WRITE_ONCE() invocations.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely and due to this being rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5efd950..edd9746 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -375,11 +375,12 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
 {
 	int i;
 
-	i = rp->rtort_pipe_count;
+	i = READ_ONCE(rp->rtort_pipe_count);
 	if (i > RCU_TORTURE_PIPE_LEN)
 		i = RCU_TORTURE_PIPE_LEN;
 	atomic_inc(&rcu_torture_wcount[i]);
-	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
+	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
 		rp->rtort_mbtest = 0;
 		return true;
 	}
@@ -1015,7 +1016,8 @@ rcu_torture_writer(void *arg)
 			if (i > RCU_TORTURE_PIPE_LEN)
 				i = RCU_TORTURE_PIPE_LEN;
 			atomic_inc(&rcu_torture_wcount[i]);
-			old_rp->rtort_pipe_count++;
+			WRITE_ONCE(old_rp->rtort_pipe_count,
+				   old_rp->rtort_pipe_count + 1);
 			switch (synctype[torture_random(&rand) % nsynctypes]) {
 			case RTWS_DEF_FREE:
 				rcu_torture_writer_state = RTWS_DEF_FREE;
@@ -1291,7 +1293,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 		atomic_inc(&n_rcu_torture_mberror);
 	rtrsp = rcutorture_loop_extend(&readstate, trsp, rtrsp);
 	preempt_disable();
-	pipe_count = p->rtort_pipe_count;
+	pipe_count = READ_ONCE(p->rtort_pipe_count);
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
 		/* Should not happen, but... */
 		pipe_count = RCU_TORTURE_PIPE_LEN;
