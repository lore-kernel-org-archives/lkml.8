Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49301C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADCF2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbgEKU74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731921AbgEKU7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF68BC061A0E;
        Mon, 11 May 2020 13:59:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWT-0005mm-8p; Mon, 11 May 2020 22:59:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3D4E61C04CC;
        Mon, 11 May 2020 22:59:26 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:26 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add Kconfig option to mediate smp_mb() vs. IPI
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076608.390.17677066133129942133.tip-bot2@tip-bot2>
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

Commit-ID:     9ae58d7bd11f1fc4c96389df11751f8593d8bd33
Gitweb:        https://git.kernel.org/tip/9ae58d7bd11f1fc4c96389df11751f8593d8bd33
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 18 Mar 2020 17:16:37 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:52 -07:00

rcu-tasks: Add Kconfig option to mediate smp_mb() vs. IPI

This commit provides a new TASKS_TRACE_RCU_READ_MB Kconfig option that
enables use of read-side memory barriers by both rcu_read_lock_trace()
and rcu_read_unlock_trace() when the are executed with the
current->trc_reader_special.b.need_mb flag set.  This flag is currently
never set.  Doing that is the subject of a later commit.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h |  3 ++-
 kernel/rcu/Kconfig             | 18 ++++++++++++++++++
 kernel/rcu/tasks.h             |  3 ++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index c42b365..4c25a41 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -50,7 +50,8 @@ static inline void rcu_read_lock_trace(void)
 	struct task_struct *t = current;
 
 	WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
-	if (t->trc_reader_special.b.need_mb)
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
+	    t->trc_reader_special.b.need_mb)
 		smp_mb(); // Pairs with update-side barriers
 	rcu_lock_acquire(&rcu_trace_lock_map);
 }
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index cb1d18e..0ebe15a 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -234,4 +234,22 @@ config RCU_NOCB_CPU
 	  Say Y here if you want to help to debug reduced OS jitter.
 	  Say N here if you are unsure.
 
+config TASKS_TRACE_RCU_READ_MB
+	bool "Tasks Trace RCU readers use memory barriers in user and idle"
+	depends on RCU_EXPERT
+	default PREEMPT_RT || NR_CPUS < 8
+	help
+	  Use this option to further reduce the number of IPIs sent
+	  to CPUs executing in userspace or idle during tasks trace
+	  RCU grace periods.  Given that a reasonable setting of
+	  the rcupdate.rcu_task_ipi_delay kernel boot parameter
+	  eliminates such IPIs for many workloads, proper setting
+	  of this Kconfig option is important mostly for aggressive
+	  real-time installations and for battery-powered devices,
+	  hence the default chosen above.
+
+	  Say Y here if you hate IPIs.
+	  Say N here if you hate read-side memory barriers.
+	  Take the default if you are unsure.
+
 endmenu # "RCU Subsystem"
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4857450..4147857 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -734,7 +734,8 @@ void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
 	int nq = t->trc_reader_special.b.need_qs;
 
-	if (t->trc_reader_special.b.need_mb)
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
+	    t->trc_reader_special.b.need_mb)
 		smp_mb(); // Pairs with update-side barriers.
 	// Update .need_qs before ->trc_reader_nesting for irq/NMI handlers.
 	if (nq)
