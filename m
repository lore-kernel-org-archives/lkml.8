Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0C4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3ABB208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgGaTU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:20:56 -0400
Received: from foss.arm.com ([217.140.110.172]:36324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbgGaTUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:20:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA5EFD6E;
        Fri, 31 Jul 2020 12:20:52 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B9D23F71F;
        Fri, 31 Jul 2020 12:20:51 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/3] sched: Document arch_scale_*_capacity()
Date:   Fri, 31 Jul 2020 20:20:14 +0100
Message-Id: <20200731192016.7484-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731192016.7484-1-valentin.schneider@arm.com>
References: <20200731192016.7484-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather that hide their purpose in some dark, damp corner of Documentation/,
add some documentation to the default implementations.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/topology.h | 10 ++++++++++
 kernel/sched/sched.h           | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 764222d637b7..820511289857 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -217,6 +217,16 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 #endif	/* !CONFIG_SMP */
 
 #ifndef arch_scale_cpu_capacity
+/**
+ * arch_scale_cpu_capacity - get the capacity scale factor of a given CPU.
+ * @cpu: the CPU in question.
+ *
+ * Return: the CPU scale factor normalized against SCHED_CAPACITY_SCALE, i.e.
+ *
+ *             max_perf(cpu)
+ *      ----------------------------- * SCHED_CAPACITY_SCALE
+ *      max(max_perf(c) : c \in CPUs)
+ */
 static __always_inline
 unsigned long arch_scale_cpu_capacity(int cpu)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 296efd30d8c9..3fd283892761 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2049,6 +2049,16 @@ void arch_scale_freq_tick(void)
 #endif
 
 #ifndef arch_scale_freq_capacity
+/**
+ * arch_scale_freq_capacity - get the frequency scale factor of a given CPU.
+ * @cpu: the CPU in question.
+ *
+ * Return: the frequency scale factor normalized against SCHED_CAPACITY_SCALE, i.e.
+ *
+ *     f_curr
+ *     ------ * SCHED_CAPACITY_SCALE
+ *     f_max
+ */
 static __always_inline
 unsigned long arch_scale_freq_capacity(int cpu)
 {
-- 
2.27.0

