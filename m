Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74219C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA1F20FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgFPMXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgFPMWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E983C08C5C3;
        Tue, 16 Jun 2020 05:22:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbE-0004fs-Iy; Tue, 16 Jun 2020 14:21:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 59C711C0823;
        Tue, 16 Jun 2020 14:21:52 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:52 -0000
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Add dl_bw_capacity()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520134243.19352-3-dietmar.eggemann@arm.com>
References: <20200520134243.19352-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <159231011211.16989.3507232109054333136.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fc9dc698472aa460a8b3b036d9b1d0b751f12f58
Gitweb:        https://git.kernel.org/tip/fc9dc698472aa460a8b3b036d9b1d0b751f12f58
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 20 May 2020 15:42:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:05 +02:00

sched/deadline: Add dl_bw_capacity()

Capacity-aware SCHED_DEADLINE Admission Control (AC) needs root domain
(rd) CPU capacity sum.

Introduce dl_bw_capacity() which for a symmetric rd w/ a CPU capacity
of SCHED_CAPACITY_SCALE simply relies on dl_bw_cpus() to return #CPUs
multiplied by SCHED_CAPACITY_SCALE.

For an asymmetric rd or a CPU capacity < SCHED_CAPACITY_SCALE it
computes the CPU capacity sum over rd span and cpu_active_mask.

A 'XXX Fix:' comment was added to highlight that if 'rq->rd ==
def_root_domain' AC should be performed against the capacity of the
CPU the task is running on rather the rd CPU capacity sum. This
issue already exists w/o capacity awareness.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200520134243.19352-3-dietmar.eggemann@arm.com
---
 kernel/sched/deadline.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ec90265..01f474a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -69,6 +69,34 @@ static inline int dl_bw_cpus(int i)
 
 	return cpus;
 }
+
+static inline unsigned long __dl_bw_capacity(int i)
+{
+	struct root_domain *rd = cpu_rq(i)->rd;
+	unsigned long cap = 0;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
+			 "sched RCU must be held");
+
+	for_each_cpu_and(i, rd->span, cpu_active_mask)
+		cap += capacity_orig_of(i);
+
+	return cap;
+}
+
+/*
+ * XXX Fix: If 'rq->rd == def_root_domain' perform AC against capacity
+ * of the CPU the task is running on rather rd's \Sum CPU capacity.
+ */
+static inline unsigned long dl_bw_capacity(int i)
+{
+	if (!static_branch_unlikely(&sched_asym_cpucapacity) &&
+	    capacity_orig_of(i) == SCHED_CAPACITY_SCALE) {
+		return dl_bw_cpus(i) << SCHED_CAPACITY_SHIFT;
+	} else {
+		return __dl_bw_capacity(i);
+	}
+}
 #else
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -79,6 +107,11 @@ static inline int dl_bw_cpus(int i)
 {
 	return 1;
 }
+
+static inline unsigned long dl_bw_capacity(int i)
+{
+	return SCHED_CAPACITY_SCALE;
+}
 #endif
 
 static inline
