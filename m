Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0E8C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5681C2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbgEKVFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731826AbgEKU7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43970C061A0E;
        Mon, 11 May 2020 13:59:25 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWF-0005gy-0k; Mon, 11 May 2020 22:59:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 76B8A1C04E3;
        Mon, 11 May 2020 22:59:19 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:19 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Mark data-race potential for
 rcu_barrier() test statistics
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075942.390.10031929584805507102.tip-bot2@tip-bot2>
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

Commit-ID:     c9527bebb017b891d1a2bbb96217bd5225488a0e
Gitweb:        https://git.kernel.org/tip/c9527bebb017b891d1a2bbb96217bd5225488a0e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 18 Feb 2020 13:41:02 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:05:13 -07:00

rcutorture: Mark data-race potential for rcu_barrier() test statistics

The n_barrier_successes, n_barrier_attempts, and
n_rcu_torture_barrier_error variables are updated (without access
markings) by the main rcu_barrier() test kthread, and accessed (also
without access markings) by the rcu_torture_stats() kthread.  This of
course can result in KCSAN complaints.

Because the accesses are in diagnostic prints, this commit uses
data_race() to excuse the diagnostic prints from the data race.  If this
were to ever cause bogus statistics prints (for example, due to store
tearing), any misleading information would be disambiguated by the
presence or absence of an rcutorture splat.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely and due to the mild consequences of the
failure, namely a confusing rcutorture console message.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7e2ea0c..d0345d1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1456,9 +1456,9 @@ rcu_torture_stats_print(void)
 		atomic_long_read(&n_rcu_torture_timers));
 	torture_onoff_stats();
 	pr_cont("barrier: %ld/%ld:%ld\n",
-		n_barrier_successes,
-		n_barrier_attempts,
-		n_rcu_torture_barrier_error);
+		data_race(n_barrier_successes),
+		data_race(n_barrier_attempts),
+		data_race(n_rcu_torture_barrier_error));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
