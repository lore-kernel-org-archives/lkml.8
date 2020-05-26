Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3204520704
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qv7XCj5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbgEZQTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgEZQTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:19:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDD4C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BI6kOUm1kTWbgsede43M5iDgQbECI8s3sR4lM3RHDAU=; b=Qv7XCj5Q2L9YeOsObYPcDmZPId
        B7JXMxVA2bpcZHNy00o08iyn72ZdZ1PdVQUoSaVzNuwahC3uCem5TsHr/mdwbDLOGZS/g65/4J+Ck
        QN8GmJU0FBTeCdfqN+IOP+klcGJGK6eRME6D9gaJCclpVJFhRgEy+K7nVO23kxCfTRm692vxHw+yz
        CBeywOB1xOau0CtbSOhrGel1PhfN7nJI2cFqpMKL+B44rQBB5zbljnk2KP+rw96w6skfE40ABFM5b
        25h55i8AHt0RfgdHortOgz6YQiluPD331W+Zzfa609EyFdDdiBY3x0i54WSWkw8Kr6zKUz3svOvKJ
        raKwUFJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdcIq-0000Em-5L; Tue, 26 May 2020 16:19:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DA26306151;
        Tue, 26 May 2020 18:19:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4551920962E2A; Tue, 26 May 2020 18:19:41 +0200 (CEST)
Message-ID: <20200526161907.778543557@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 May 2020 18:10:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, peterz@infradead.org
Subject: [RFC][PATCH 1/7] sched: Fix smp_call_function_single_async() usage for ILB
References: <20200526161057.531933155@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
got smp_call_function_single_async() subtly wrong. Even though it will
return -EBUSY when trying to re-use a csd, that condition is not
atomic and still requires external serialization.

The change in kick_ilb() got this wrong.

While on first reading kick_ilb() has an atomic test-and-set that
appears to serialize the use, the matching 'release' is not in the
right place to actually guarantee this serialization.

Rework the nohz_idle_balance() trigger so that the release is in the
IPI callback and thus guarantees the required serialization for the
CSD.

Fixes: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h      |    4 +
 include/linux/sched/idle.h |   55 ++++++++++++++++++
 kernel/sched/core.c        |  132 +++++++++------------------------------------
 kernel/sched/fair.c        |   18 ++----
 kernel/sched/idle.c        |    3 -
 kernel/sched/sched.h       |    2 
 kernel/smp.c               |    7 ++
 7 files changed, 102 insertions(+), 119 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -637,41 +568,25 @@ void wake_up_nohz_cpu(int cpu)
 		wake_up_idle_cpu(cpu);
 }
 
-static inline bool got_nohz_idle_kick(void)
+static void nohz_csd_func(void *info)
 {
-	int cpu = smp_processor_id();
-
-	if (!(atomic_read(nohz_flags(cpu)) & NOHZ_KICK_MASK))
-		return false;
-
-	if (idle_cpu(cpu) && !need_resched())
-		return true;
+	struct rq *rq = info;
+	int cpu = cpu_of(rq);
+	unsigned int flags;
 
 	/*
-	 * We can't run Idle Load Balance on this CPU for this time so we
-	 * cancel it and clear NOHZ_BALANCE_KICK
+	 * Release the rq::nohz_csd.
 	 */
-	atomic_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
-	return false;
-}
-
-static void nohz_csd_func(void *info)
-{
-	struct rq *rq = info;
+	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
+	WARN_ON(!(flags & NOHZ_KICK_MASK));
 
-	if (got_nohz_idle_kick()) {
-		rq->idle_balance = 1;
+	rq->idle_balance = idle_cpu(cpu);
+	if (rq->idle_balance && !need_resched()) {
+		rq->nohz_idle_balance = flags;
 		raise_softirq_irqoff(SCHED_SOFTIRQ);
 	}
 }
 
-#else /* CONFIG_NO_HZ_COMMON */
-
-static inline bool got_nohz_idle_kick(void)
-{
-	return false;
-}
-
 #endif /* CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10024,6 +10024,10 @@ static void kick_ilb(unsigned int flags)
 	if (ilb_cpu >= nr_cpu_ids)
 		return;
 
+	/*
+	 * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
+	 * the first flag owns it; cleared by nohz_csd_func().
+	 */
 	flags = atomic_fetch_or(flags, nohz_flags(ilb_cpu));
 	if (flags & NOHZ_KICK_MASK)
 		return;
@@ -10371,20 +10375,14 @@ static bool _nohz_idle_balance(struct rq
  */
 static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 {
-	int this_cpu = this_rq->cpu;
-	unsigned int flags;
+	unsigned int flags = this_rq->nohz_idle_balance;
 
-	if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
+	if (!flags)
 		return false;
 
-	if (idle != CPU_IDLE) {
-		atomic_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
-		return false;
-	}
+	this_rq->nohz_idle_balance = 0;
 
-	/* could be _relaxed() */
-	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
-	if (!(flags & NOHZ_KICK_MASK))
+	if (idle != CPU_IDLE)
 		return false;
 
 	_nohz_idle_balance(this_rq, flags, idle);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -951,6 +951,7 @@ struct rq {
 
 	struct callback_head	*balance_callback;
 
+	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
 
 	unsigned long		misfit_task_load;


