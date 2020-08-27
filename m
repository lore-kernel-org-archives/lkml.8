Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE05AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD625207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MFuue5Gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgH0AnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:43:25 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:61903 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgH0AnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 20:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598489002; x=1630025002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wdaK8LzRgKLMOjujhBnedCH0sIhpOP2arAJ6iiZjYQM=;
  b=MFuue5GsRBMkCqZmK/CK+AKQrkPC0916MryGxpsIxE4hY9djnt9AF7xq
   PCZNQFEO+G6TEzQiFqE5IwRE6CK686eGnUO7cNcRxhAgFcEBuzFHZ2NLS
   383C2p4dhEsKi2lNqwta18A4s+X3XGQFexkJAga1RIvuvxJDuz7AP67wo
   k=;
X-IronPort-AV: E=Sophos;i="5.76,357,1592870400"; 
   d="scan'208";a="70024348"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 27 Aug 2020 00:43:19 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id DAF8AA2097;
        Thu, 27 Aug 2020 00:43:10 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 00:43:10 +0000
Received: from u79c5a0a55de558.ant.amazon.com (10.43.160.192) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 00:43:04 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>, <mingo@kernel.org>,
        <tglx@linutronix.de>, <pjt@google.com>,
        <torvalds@linux-foundation.org>, <subhra.mazumdar@oracle.com>,
        <fweisbec@gmail.com>, <keescook@chromium.org>,
        <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, <joel@joelfernandes.org>,
        <vineethrp@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/3] sched: Allow hrticks to work with core scheduling
Date:   Thu, 27 Aug 2020 02:42:48 +0200
Message-ID: <20200827004250.4853-2-graf@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827004250.4853-1-graf@amazon.com>
References: <20200827004250.4853-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.192]
X-ClientProxiedBy: EX13D28UWC002.ant.amazon.com (10.43.162.145) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core scheduling logic bypasses the scheduling class's
pick_next_task() which starts the hrtick logic usually. Instead,
it explicitly calls set_next_task() or leaves the current task
running without any callback into the CFS scheduler.

To ensure that we still configure the hrtick timer properly when we
know which task we want to run, let's add an explicit callback to
the scheduler class which can then be triggered from the core's
pick_next_task().

With this patch, core scheduling with HRTICK enabled does see
improved responsiveness on scheduling decisions.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 kernel/sched/core.c  | 13 +++++++++++++
 kernel/sched/fair.c  |  9 +++++++++
 kernel/sched/sched.h |  4 ++++
 3 files changed, 26 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0362102fa3d2..72bf837422bf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4486,6 +4486,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			set_next_task(rq, next);
 		}
 
+#ifdef CONFIG_SCHED_HRTICK
+		/* Trigger next hrtick after task selection */
+		if (next->sched_class->hrtick_update)
+			next->sched_class->hrtick_update(rq);
+#endif
+
 		trace_printk("pick pre selected (%u %u %u): %s/%d %lx\n",
 			     rq->core->core_task_seq,
 			     rq->core->core_pick_seq,
@@ -4667,6 +4673,13 @@ next_class:;
 
 done:
 	set_next_task(rq, next);
+
+#ifdef CONFIG_SCHED_HRTICK
+	/* Trigger next hrtick after task selection */
+	if (next->sched_class->hrtick_update)
+		next->sched_class->hrtick_update(rq);
+#endif
+
 	return next;
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 435b460d3c3f..0d4ff3ab2572 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5512,6 +5512,11 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+static void hrtick_update_fair(struct rq *rq)
+{
+	hrtick_update(rq);
+}
+
 #ifdef CONFIG_SMP
 static inline unsigned long cpu_util(int cpu);
 
@@ -11391,6 +11396,10 @@ const struct sched_class fair_sched_class = {
 #ifdef CONFIG_UCLAMP_TASK
 	.uclamp_enabled		= 1,
 #endif
+
+#ifdef CONFIG_SCHED_HRTICK
+	.hrtick_update		= hrtick_update_fair,
+#endif
 };
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6445943d3215..b382e0ee0c87 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1942,6 +1942,10 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
+
+#ifdef CONFIG_SCHED_HRTICK
+	void (*hrtick_update)(struct rq *rq);
+#endif
 };
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
-- 
2.26.2




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



