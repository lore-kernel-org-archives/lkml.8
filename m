Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A7BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07E92073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fMkz3cuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbgEZQY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:24:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35178 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgEZQYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Kdhc7G0MOHSHyTSs18tW/2Sp/VNPCGM39F2FG5g0xA0=; b=fMkz3cuyOKIigiaOFaLhqZGDoc
        yuG4u+ptyI23uLEzyZQYTdoNve9a/ohhhnF3SGysE8oOYoQmTiy45J++y05Sy+YRXtK2dG4DJfr7A
        VZZ72S6aevWhlSdR/o8Uha0DNmbX/ylhhmNP+5sY4Cd6qRzzxyGJgr/3FTSa8sbIcxM8roujI6FnT
        t/Iq5yNJYuMrz3j6QW5l5Fhf/1gzvJ9KW0NeWzBRCdbZ5uKA7dwA45tm5448WrvcA2zncOJBO4pC/
        1VXPu9rTYwUN+MGSNZmj6U1AtFSpCmVcgslboaIxOvOPqkpNR6BaruXhvp+8NhdfcBHD2rB9dbQmn
        eAUy2XDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdcIv-0005Tf-8K; Tue, 26 May 2020 16:19:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72A8E3062EA;
        Tue, 26 May 2020 18:19:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 55EE320FF793C; Tue, 26 May 2020 18:19:41 +0200 (CEST)
Message-ID: <20200526161907.953304789@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 May 2020 18:11:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, peterz@infradead.org
Subject: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
References: <20200526161057.531933155@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like the ttwu_queue_remote() IPI, make use of _TIF_POLLING_NRFLAG
to avoid sending IPIs to idle CPUs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   10 ++++++++++
 kernel/sched/idle.c  |    1 +
 kernel/sched/sched.h |    2 ++
 kernel/smp.c         |   16 +++++++++++++++-
 4 files changed, 28 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2296,6 +2296,16 @@ static void wake_csd_func(void *info)
 	sched_ttwu_pending();
 }
 
+void send_call_function_single_ipi(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (!set_nr_if_polling(rq->idle))
+		arch_send_call_function_single_ipi(cpu);
+	else
+		trace_sched_wake_idle_without_ipi(cpu);
+}
+
 /*
  * Queue a task on the target CPUs wake_list and wake the CPU via IPI if
  * necessary. The wakee CPU on receipt of the IPI will queue the task
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -289,6 +289,7 @@ static void do_idle(void)
 	 */
 	smp_mb__after_atomic();
 
+	flush_smp_call_function_from_idle();
 	sched_ttwu_pending();
 	schedule_idle();
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1506,6 +1506,8 @@ static inline void unregister_sched_doma
 }
 #endif
 
+extern void flush_smp_call_function_from_idle(void);
+
 #else
 
 static inline void sched_ttwu_pending(void) { }
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -135,6 +135,8 @@ static __always_inline void csd_unlock(c
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 
+extern void send_call_function_single_ipi(int cpu);
+
 /*
  * Insert a previously allocated call_single_data_t element
  * for execution on the given CPU. data must already have
@@ -178,7 +180,7 @@ static int generic_exec_single(int cpu,
 	 * equipped to do the right thing...
 	 */
 	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
-		arch_send_call_function_single_ipi(cpu);
+		send_call_function_single_ipi(cpu);
 
 	return 0;
 }
@@ -278,6 +280,18 @@ static void flush_smp_call_function_queu
 	}
 }
 
+void flush_smp_call_function_from_idle(void)
+{
+	unsigned long flags;
+
+	if (llist_empty(this_cpu_ptr(&call_single_queue)))
+		return;
+
+	local_irq_save(flags);
+	flush_smp_call_function_queue(true);
+	local_irq_restore(flags);
+}
+
 /*
  * smp_call_function_single - Run a function on a specific CPU
  * @func: The function to run. This must be fast and non-blocking.


