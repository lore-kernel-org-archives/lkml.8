Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF23C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3812075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HhzDXQ85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390969AbgDNOdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390961AbgDNOdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:33:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6F3C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CU1/U9eE+MCR8z4VtUAtwIMt+CTbqmGZVkU4VsyWiPM=; b=HhzDXQ85fxaJgUCOXb4hK69KSS
        7Ns9mPuQ03c5D0PpFotCP/DglfacGlM1G0F3TUYwcSu2tZ85ztK+Q4tNPsYgCwr3dt1IOTqRx5yFC
        rAx8vHMfXPV9YkDsBFiR76pyabwRO3nM+7LABxfEH+kfnomMFiyAJvlXCZ1rb/EPgm4YKjRKo8FYS
        tSDwXGqayGFSLLPpbqS08Nplm0FyV9kE2z21FIoCtaBVLuwyrDpcpPGqkT6T7r4BGn1xatmMd/22o
        Qm6pj3O7dA8fEwFcJIsLcSrKWTgUQy04lfujIbFDNz/03ZE26wHTlvn4XKRnaOxcnadD2YHS40CyO
        FxfjDH3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOMcQ-00025B-OM; Tue, 14 Apr 2020 14:32:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D000307016;
        Tue, 14 Apr 2020 16:32:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 573F12038BC5A; Tue, 14 Apr 2020 16:32:52 +0200 (CEST)
Date:   Tue, 14 Apr 2020 16:32:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     vpillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org
Subject: Re: [RFC PATCH 03/13] sched: Core-wide rq->lock
Message-ID: <20200414143252.GW20730@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:59:53PM +0000, vpillai wrote:
> +DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
> +
> +/*
> + * The static-key + stop-machine variable are needed such that:
> + *
> + *	spin_lock(rq_lockp(rq));
> + *	...
> + *	spin_unlock(rq_lockp(rq));
> + *
> + * ends up locking and unlocking the _same_ lock, and all CPUs
> + * always agree on what rq has what lock.
> + *
> + * XXX entirely possible to selectively enable cores, don't bother for now.
> + */
> +static int __sched_core_stopper(void *data)
> +{
> +	bool enabled = !!(unsigned long)data;
> +	int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		cpu_rq(cpu)->core_enabled = enabled;
> +
> +	return 0;
> +}
> +
> +static DEFINE_MUTEX(sched_core_mutex);
> +static int sched_core_count;
> +
> +static void __sched_core_enable(void)
> +{
> +	// XXX verify there are no cookie tasks (yet)
> +
> +	static_branch_enable(&__sched_core_enabled);
> +	stop_machine(__sched_core_stopper, (void *)true, NULL);
> +}
> +
> +static void __sched_core_disable(void)
> +{
> +	// XXX verify there are no cookie tasks (left)
> +
> +	stop_machine(__sched_core_stopper, (void *)false, NULL);
> +	static_branch_disable(&__sched_core_enabled);
> +}

> +static inline raw_spinlock_t *rq_lockp(struct rq *rq)
> +{
> +	if (sched_core_enabled(rq))
> +		return &rq->core->__lock;
> +
> +	return &rq->__lock;
> +}

While reading all this again, I realized it's not too hard to get rid of
stop-machine here.

void __raw_rq_lock(struct rq *rq)
{
	raw_spinlock_t *lock;

	for (;;) {
		lock = rq_lockp(rq);

		raw_spin_lock(lock);
		if (lock == rq_lock(rq))
			return;
		raw_spin_unlock(lock);
	}
}

void __sched_core_enable(int core, bool enable)
{
	const cpumask *smt_mask;
	int cpu, i;

	smt_mask = cpu_smt_mask(core);

	for_each_cpu(cpu, smt_mask)
		raw_spin_lock_nested(&cpu_rq(cpu)->__lock, i++);

	for_each_cpu(cpu, smt_mask)
		cpu_rq(cpu)->core_enabled = enable;

	for_each_cpu(cpu, smt_mask)
		raw_spin_unlock(&cpu_rq(cpu)->__lock);
}


