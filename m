Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E004EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8F7206F4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594338961;
	bh=Q0slfXxM3359P9IVqQ4zRdxcRa0D0MZbAU7aHqYR8cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wfkQ9gAeUTzVDUewvf/OK77TZYejKyt6rhQF5iznuu53eFfzjD/wbufab41S+VDRm
	 aqsqkhbEXnhZrzTan7fHjddjP9tHet51DR1KsiYLjxYk8Ubz3Gs0IFvtOtcCNzk0Ai
	 QkEAdLfwbJIi9YT/R0NhRcp3IzNMTIPyamooCB1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgGIX4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgGIX4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:56:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C337206DF;
        Thu,  9 Jul 2020 23:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594338959;
        bh=Q0slfXxM3359P9IVqQ4zRdxcRa0D0MZbAU7aHqYR8cE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIPY5HR3UyD338PpOj3xg8Jh197EbNLNLSFhZqBTcs3BNaD8ktjgSnIoqiFTtRNc1
         xfHLttMzRnjXS56xoN+6ChXJVkOBOVT2v5mPRNVpEtYwLTxZx58o/zPWQYQ2Ilu5fh
         TjsT7kAboe1OW6OTy5BXa1DC2LauLV0RHCdJeP/o=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, frederic@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH smp 1/2] smp: Add source and destination CPUs to __call_single_data
Date:   Thu,  9 Jul 2020 16:55:56 -0700
Message-Id: <20200709235557.21080-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200709235436.GA20922@paulmck-ThinkPad-P72>
References: <20200709235436.GA20922@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a destination CPU to __call_single_data, and is inspired
by an earlier commit by Peter Zijlstra.  This version adds #ifdef to
permit use by 32-bit systems and supplying the destination CPU for all
smp_call_function*() requests, not just smp_call_function_single().

If need be, 32-bit systems could be accommodated by shrinking the flags
field to 16 bits (the atomic_t variant is currently unused) and by
providing only eight bits for CPU on such systems.

It is not clear that the addition of the fields to __call_single_node
are really needed.

Link: https://lore.kernel.org/lkml/20200615164048.GC2531@hirez.programming.kicks-ass.net/
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/smp.h       | 3 +++
 include/linux/smp_types.h | 3 +++
 kernel/smp.c              | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 80d557e..9f13966 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -26,6 +26,9 @@ struct __call_single_data {
 		struct {
 			struct llist_node llist;
 			unsigned int flags;
+#ifdef CONFIG_64BIT
+			u16 src, dst;
+#endif
 		};
 	};
 	smp_call_func_t func;
diff --git a/include/linux/smp_types.h b/include/linux/smp_types.h
index 364b3ae..2e8461a 100644
--- a/include/linux/smp_types.h
+++ b/include/linux/smp_types.h
@@ -61,6 +61,9 @@ struct __call_single_node {
 		unsigned int	u_flags;
 		atomic_t	a_flags;
 	};
+#ifdef CONFIG_64BIT
+	u16 src, dst;
+#endif
 };
 
 #endif /* __LINUX_SMP_TYPES_H */
diff --git a/kernel/smp.c b/kernel/smp.c
index aa17eed..148d991 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -375,6 +375,7 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 
 	csd->func = func;
 	csd->info = info;
+	csd->dst = cpu;
 
 	err = generic_exec_single(cpu, csd);
 
@@ -540,6 +541,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd->flags |= CSD_TYPE_SYNC;
 		csd->func = func;
 		csd->info = info;
+		csd->dst = cpu;
 		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
-- 
2.9.5

