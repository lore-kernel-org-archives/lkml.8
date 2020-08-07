Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8627C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5AF20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dAvmNoqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgHGNiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHGNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:38:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF05C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BNHhg74FH0aIGNuZudrsPwpAtKO2+uyNLCH15s0iV80=; b=dAvmNoqW0EYerv/ttknI0evnMM
        1yVh8ZDVtV7XlmwNUf3V3RXlmmMgRbeqX6jarc4U05eNV2oxNFnmuBgUwVQz17GWiKAyVpQzinEuT
        zxDJYq1RYy1ZhxHCSZoQpzDH6+kf7dQ6C7KE3fu5emoyyIkHSTcAeXORuoe8ebo3G+ll2+zEHbUwa
        S9FbmOi66+RnJlnyZ1SSK5iSUOoxlUEuVeHzZ4fMxlYP8TF894gpw+A21fjuE/iyPn+CpUZ6EcdOj
        B/AXQzzzJt91zdHWDrySKHcYjUin0EgLRGl5m2Jf6klb1ulY+mzO4Mo4MTDkBKHpyJJm990NLt1qL
        Mm5dOCuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k42ZL-0003m1-0x; Fri, 07 Aug 2020 13:37:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BE1B3010D2;
        Fri,  7 Aug 2020 15:37:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9B9621451922; Fri,  7 Aug 2020 15:37:55 +0200 (CEST)
Date:   Fri, 7 Aug 2020 15:37:55 +0200
From:   peterz@infradead.org
To:     Peter Oskolkov <posk@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH 1/2 v2] rseq/membarrier: add
 MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
Message-ID: <20200807133755.GJ2674@hirez.programming.kicks-ass.net>
References: <20200806170544.382140-1-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806170544.382140-1-posk@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 10:05:43AM -0700, Peter Oskolkov wrote:
> +#ifdef CONFIG_RSEQ
> +static void membarrier_rseq_ipi(void *arg)
> +{
> +	if (current->mm != arg)  /* Not our process. */
> +		return;
> +	if (!current->rseq)  /* RSEQ not set up for the current task/thread. */
> +		return;
> +
> +	rseq_preempt(current);
> +}
> +#endif
> +
> +static int membarrier_private_restart_rseq_on_cpu(int cpu_id)
> +{
> +#ifdef CONFIG_RSEQ
> +	/* syscalls are not allowed inside rseq critical sections. */
> +	if (cpu_id == raw_smp_processor_id())
> +		return 0;
> +
> +	return smp_call_function_single(cpu_id, membarrier_rseq_ipi,
> +					current->mm, true);
> +#else
> +	return 0;
> +#endif
> +}

I'm thinking even this is a problem, we can end up sending IPIs to CPUs
outside out partition (they might be NOHZ_FULL) and that's a no-no too.

Something like so perhaps... that really limits it to CPUs that match
our mm.

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 6be66f52a2ad..bee5e98e6774 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -356,6 +356,7 @@ enum {
 
 enum {
 	MEMBARRIER_FLAG_SYNC_CORE	= (1U << 0),
+	MEMBARRIER_FLAG_RSEQ		= (1U << 1),
 };
 
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 168479a7d61b..4d9b22c2f5e2 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -27,6 +27,11 @@
 
 static void ipi_mb(void *info)
 {
+	int *flags = info;
+
+	if (flags && (*flags & MEMBARRIER_FLAG_RSEQ))
+		rseq_preempt(current);
+
 	smp_mb();	/* IPIs should be serializing but paranoid. */
 }
 
@@ -129,11 +134,11 @@ static int membarrier_global_expedited(void)
 	return 0;
 }
 
-static int membarrier_private_expedited(int flags)
+static int membarrier_private_expedited(int flags, int cpu_id)
 {
-	int cpu;
-	cpumask_var_t tmpmask;
 	struct mm_struct *mm = current->mm;
+	cpumask_var_t tmpmask;
+	int cpu;
 
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
@@ -174,6 +179,10 @@ static int membarrier_private_expedited(int flags)
 		 */
 		if (cpu == raw_smp_processor_id())
 			continue;
+
+		if (cpu_id >= 0 && cpu != cpu_id)
+			continue;
+
 		p = rcu_dereference(cpu_rq(cpu)->curr);
 		if (p && p->mm == mm)
 			__cpumask_set_cpu(cpu, tmpmask);
@@ -181,7 +190,7 @@ static int membarrier_private_expedited(int flags)
 	rcu_read_unlock();
 
 	preempt_disable();
-	smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
+	smp_call_function_many(tmpmask, ipi_mb, &flags, 1);
 	preempt_enable();
 
 	free_cpumask_var(tmpmask);
@@ -362,11 +371,13 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
 	case MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED:
 		return membarrier_register_global_expedited();
 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
-		return membarrier_private_expedited(0);
+		return membarrier_private_expedited(0, -1);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
 		return membarrier_register_private_expedited(0);
 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
-		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
+		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE, -1);
+	case MEMBERRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
+		return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, flags);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE:
 		return membarrier_register_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
 	default:
