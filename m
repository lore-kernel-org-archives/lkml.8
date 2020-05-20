Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B856C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0800A207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgETNnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:43:16 -0400
Received: from foss.arm.com ([217.140.110.172]:56520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgETNnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:43:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9133106F;
        Wed, 20 May 2020 06:43:13 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B68F03F52E;
        Wed, 20 May 2020 06:43:10 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] sched/deadline: Add dl_bw_capacity()
Date:   Wed, 20 May 2020 15:42:40 +0200
Message-Id: <20200520134243.19352-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520134243.19352-1-dietmar.eggemann@arm.com>
References: <20200520134243.19352-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/sched/deadline.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4ae22bfc37ae..ea7282ce484c 100644
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
-- 
2.17.1

