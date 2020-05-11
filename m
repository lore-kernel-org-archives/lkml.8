Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68631C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FDC2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbgEKVEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731862AbgEKU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88476C061A0C;
        Mon, 11 May 2020 13:59:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWJ-0005ky-RU; Mon, 11 May 2020 22:59:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 565071C04E3;
        Mon, 11 May 2020 22:59:23 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:23 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add count for idle tasks on offline CPUs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076328.390.18423169439389986790.tip-bot2@tip-bot2>
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

Commit-ID:     edf3775f0ad66879796f594983163f672c4bf1a2
Gitweb:        https://git.kernel.org/tip/edf3775f0ad66879796f594983163f672c4bf1a2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 22 Mar 2020 14:09:45 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:53 -07:00

rcu-tasks: Add count for idle tasks on offline CPUs

This commit adds a counter for the number of times the quiescent state
was an idle task associated with an offline CPU, and prints this count
at the end of rcutorture runs and at stall time.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ce65883..0d1b5bf 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -729,6 +729,7 @@ static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 // heavyweight readers executing explicit memory barriers.
 unsigned long n_heavy_reader_attempts;
 unsigned long n_heavy_reader_updates;
+unsigned long n_heavy_reader_ofl_updates;
 
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
@@ -840,6 +841,8 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 		    !rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return false; // No quiescent state, do it the hard way.
 		n_heavy_reader_updates++;
+		if (ofl)
+			n_heavy_reader_ofl_updates++;
 		in_qs = true;
 	} else {
 		in_qs = likely(!t->trc_reader_nesting);
@@ -1156,7 +1159,8 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%d h:%lu/%lu", atomic_read(&trc_n_readers_need_end),
+	sprintf(buf, "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
+		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
 		data_race(n_heavy_reader_attempts));
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
