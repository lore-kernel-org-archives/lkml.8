Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C5EC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A68D20658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgCXJT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:19:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43923 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgCXJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffq-0007xE-9c; Tue, 24 Mar 2020 10:16:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 654A81C0481;
        Tue, 24 Mar 2020 10:16:32 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:32 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Annotation lockless accesses to
 rcu_torture_current
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139206.28353.15957833602515900228.tip-bot2@tip-bot2>
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

Commit-ID:     5396d31d3a396039502f75a128bd8064819cba61
Gitweb:        https://git.kernel.org/tip/5396d31d3a396039502f75a128bd8064819cba61
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 08 Jan 2020 19:58:13 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:31 -08:00

rcutorture: Annotation lockless accesses to rcu_torture_current

The rcutorture global variable rcu_torture_current is accessed locklessly,
so it must use the RCU pointer load/store primitives.  This commit
therefore adds several that were missed.

This data race was reported by KCSAN.  Not appropriate for backporting due
to failure being unlikely and due to this being used only by rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0b9ce9a..7e01e9a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1407,6 +1407,7 @@ rcu_torture_stats_print(void)
 	int i;
 	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
 	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+	struct rcu_torture *rtcp;
 	static unsigned long rtcv_snap = ULONG_MAX;
 	static bool splatted;
 	struct task_struct *wtp;
@@ -1423,10 +1424,10 @@ rcu_torture_stats_print(void)
 	}
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
+	rtcp = rcu_access_pointer(rcu_torture_current);
 	pr_cont("rtc: %p %s: %lu tfle: %d rta: %d rtaf: %d rtf: %d ",
-		rcu_torture_current,
-		rcu_torture_current && !rcu_stall_is_suppressed_at_boot()
-			? "ver" : "VER",
+		rtcp,
+		rtcp && !rcu_stall_is_suppressed_at_boot() ? "ver" : "VER",
 		rcu_torture_current_version,
 		list_empty(&rcu_torture_freelist),
 		atomic_read(&n_rcu_torture_alloc),
@@ -1482,7 +1483,8 @@ rcu_torture_stats_print(void)
 	if (cur_ops->stats)
 		cur_ops->stats();
 	if (rtcv_snap == rcu_torture_current_version &&
-	    rcu_torture_current != NULL && !rcu_stall_is_suppressed()) {
+	    rcu_access_pointer(rcu_torture_current) &&
+	    !rcu_stall_is_suppressed()) {
 		int __maybe_unused flags = 0;
 		unsigned long __maybe_unused gp_seq = 0;
 
