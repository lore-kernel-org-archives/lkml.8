Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1FCC3F2C6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E86020866
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgCILWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:22:47 -0400
Received: from foss.arm.com ([217.140.110.172]:50790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCILWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:22:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 872241FB;
        Mon,  9 Mar 2020 04:22:46 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22F6C3F6CF;
        Mon,  9 Mar 2020 04:22:45 -0700 (PDT)
Date:   Mon, 9 Mar 2020 11:22:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>,
        Jon Masters <jcm@jonmasters.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Michal Hocko <mhocko@kernel.org>, QI Fuli <qi.fuli@fujitsu.com>
Subject: Re: [PATCH 3/3] arm64: tlb: skip tlbi broadcast
Message-ID: <20200309112242.GB2487@mbp>
References: <20200223192520.20808-1-aarcange@redhat.com>
 <20200223192520.20808-4-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223192520.20808-4-aarcange@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Sun, Feb 23, 2020 at 02:25:20PM -0500, Andrea Arcangeli wrote:
>  switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	  struct task_struct *tsk)
>  {
> -	if (prev != next)
> -		__switch_mm(next);
> +	unsigned int cpu = smp_processor_id();
> +
> +	if (!per_cpu(cpu_not_lazy_tlb, cpu)) {
> +		per_cpu(cpu_not_lazy_tlb, cpu) = true;
> +		atomic_inc(&next->context.nr_active_mm);
> +		__switch_mm(next, cpu);
> +	} else if (prev != next) {
> +		atomic_inc(&next->context.nr_active_mm);
> +		__switch_mm(next, cpu);
> +		atomic_dec(&prev->context.nr_active_mm);
> +	}

IIUC, nr_active_mm keeps track of how many instances of the current pgd
(TTBR0_EL1) are active.

> +enum tlb_flush_types tlb_flush_check(struct mm_struct *mm, unsigned int cpu)
> +{
> +	if (atomic_read(&mm->context.nr_active_mm) <= 1) {
> +		bool is_local = current->active_mm == mm &&
> +			per_cpu(cpu_not_lazy_tlb, cpu);
> +		cpumask_t *stale_cpumask = mm_cpumask(mm);
> +		unsigned int next_zero = cpumask_next_zero(-1, stale_cpumask);
> +		bool local_is_clear = false;
> +		if (next_zero < nr_cpu_ids &&
> +		    (is_local && next_zero == cpu)) {
> +			next_zero = cpumask_next_zero(next_zero, stale_cpumask);
> +			local_is_clear = true;
> +		}
> +		if (next_zero < nr_cpu_ids) {
> +			cpumask_setall(stale_cpumask);
> +			local_is_clear = false;
> +		}
> +
> +		/*
> +		 * Enforce CPU ordering between the above
> +		 * cpumask_setall(mm_cpumask) and the below
> +		 * atomic_read(nr_active_mm).
> +		 */
> +		smp_mb();
> +
> +		if (likely(atomic_read(&mm->context.nr_active_mm)) <= 1) {
> +			if (is_local) {
> +				if (!local_is_clear)
> +					cpumask_clear_cpu(cpu, stale_cpumask);
> +				return TLB_FLUSH_LOCAL;
> +			}
> +			if (atomic_read(&mm->context.nr_active_mm) == 0)
> +				return TLB_FLUSH_NO;
> +		}
> +	}
> +	return TLB_FLUSH_BROADCAST;

And this code here can assume that if nr_active_mm <= 1, no broadcast is
necessary.

One concern I have is the ordering between TTBR0_EL1 update in
cpu_do_switch_mm() and the nr_active_mm, both on a different CPU. We
only have an ISB for context synchronisation on that CPU but I don't
think the architecture guarantees any relation between sysreg access and
the memory update. We have a DSB but that's further down in switch_to().

However, what worries me more is that you can now potentially do a TLB
shootdown without clearing the intermediate (e.g. VA to pte) walk caches
from the TLB. Even if the corresponding pgd and ASID are no longer
active on other CPUs, I'm not sure it's entirely safe to free (and
re-allocate) pages belonging to a pgtable without first flushing the
TLB. All the architecture spec states is that the software must first
clear the entry followed by TLBI (the break-before-make rules).

That said, the benchmark numbers are not very encouraging. Around 1%
improvement in a single run, it can as well be noise. Also something
like hackbench may also show a slight impact on the context switch path.
Maybe with a true NUMA machine with hundreds of CPUs we may see a
difference, but it depends on how well the TLBI is implemented.

Thanks.

-- 
Catalin
