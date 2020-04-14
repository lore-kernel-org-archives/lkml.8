Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC3BC38A29
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C233220768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436704AbgDNPHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:07:21 -0400
Received: from foss.arm.com ([217.140.110.172]:57686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407297AbgDNPGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:06:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 264B5101E;
        Tue, 14 Apr 2020 08:06:49 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10E7E3F73D;
        Tue, 14 Apr 2020 08:06:46 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] cpumask: Convert cpumask_any_but() to the new random function
Date:   Tue, 14 Apr 2020 16:05:55 +0100
Message-Id: <20200414150556.10920-4-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414150556.10920-1-qais.yousef@arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask_any() and cpumask_any_and() are now truly, move the
cpumask_any_but() to behave in a similar manner.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Yury Norov <yury.norov@gmail.com>
CC: Paul Turner <pjt@google.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>
CC: Josh Don <joshdon@google.com>
CC: Pavan Kondeti <pkondeti@codeaurora.org>
CC: linux-kernel@vger.kernel.org
---
 include/linux/cpumask.h |  2 +-
 lib/cpumask.c           | 44 ++++++++++++++++++++++-------------------
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 7fb25d256043..f04e983e9dd0 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -254,10 +254,10 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 }
 
 int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
-int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 int cpumask_any(const struct cpumask *srcp);
 int cpumask_any_and(const struct cpumask *src1p, const struct cpumask *src2p);
+int cpumask_any_but(const struct cpumask *srcp, unsigned int cpu);
 
 /**
  * for_each_cpu - iterate over every cpu in a mask
diff --git a/lib/cpumask.c b/lib/cpumask.c
index bcac63e45374..0295cf5486ab 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -42,26 +42,6 @@ int cpumask_next_and(int n, const struct cpumask *src1p,
 }
 EXPORT_SYMBOL(cpumask_next_and);
 
-/**
- * cpumask_any_but - return a "random" in a cpumask, but not this one.
- * @mask: the cpumask to search
- * @cpu: the cpu to ignore.
- *
- * Often used to find any cpu but smp_processor_id() in a mask.
- * Returns >= nr_cpu_ids if no cpus set.
- */
-int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
-{
-	unsigned int i;
-
-	cpumask_check(cpu);
-	for_each_cpu(i, mask)
-		if (i != cpu)
-			break;
-	return i;
-}
-EXPORT_SYMBOL(cpumask_any_but);
-
 /**
  * cpumask_next_wrap - helper to implement for_each_cpu_wrap
  * @n: the cpu prior to the place to search
@@ -283,3 +263,27 @@ int cpumask_any(const struct cpumask *srcp)
 	return next;
 }
 EXPORT_SYMBOL(cpumask_any);
+
+/**
+ * cpumask_any_but - return a "random" in a cpumask, but not this one.
+ * @srcp: the cpumask to search
+ * @cpu: the cpu to ignore.
+ *
+ * Often used to find any cpu but smp_processor_id() in a mask.
+ * Returns >= nr_cpu_ids if no cpus set.
+ */
+int cpumask_any_but(const struct cpumask *srcp, unsigned int cpu)
+{
+	unsigned int i;
+
+	cpumask_check(cpu);
+
+	for_each_cpu(i, srcp) {
+		i = cpumask_any(srcp);
+		if (i != cpu)
+			return i;
+	}
+
+	return nr_cpu_ids;
+}
+EXPORT_SYMBOL(cpumask_any_but);
-- 
2.17.1

