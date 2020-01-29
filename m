Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595AEC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 08:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA1120720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 08:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgA2IQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 03:16:41 -0500
Received: from foss.arm.com ([217.140.110.172]:37986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgA2IQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 03:16:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3264F328;
        Wed, 29 Jan 2020 00:16:40 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FC113F52E;
        Wed, 29 Jan 2020 00:20:16 -0800 (PST)
Date:   Wed, 29 Jan 2020 08:16:36 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH v3 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
Message-ID: <20200129081633.3ezb7ucq5kkojkhg@e107158-lin>
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-2-valentin.schneider@arm.com>
 <20200128062245.GA27398@codeaurora.org>
 <1ed322d6-0325-ecac-cc68-326a14b8c1dd@arm.com>
 <20200129035258.GB27398@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200129035258.GB27398@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29/20 09:22, Pavan Kondeti wrote:
> On Tue, Jan 28, 2020 at 11:30:26AM +0000, Valentin Schneider wrote:
> > Hi Pavan,
> > 
> > On 28/01/2020 06:22, Pavan Kondeti wrote:
> > > Hi Valentin,
> > > 
> > > On Sun, Jan 26, 2020 at 08:09:32PM +0000, Valentin Schneider wrote:
> > >>  
> > >> +static inline int check_cpu_capacity(struct rq *rq, struct sched_domain *sd);
> > >> +
> > >> +/*
> > >> + * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
> > >> + * the task fits. If no CPU is big enough, but there are idle ones, try to
> > >> + * maximize capacity.
> > >> + */
> > >> +static int select_idle_capacity(struct task_struct *p, int target)
> > >> +{
> > >> +	unsigned long best_cap = 0;
> > >> +	struct sched_domain *sd;
> > >> +	struct cpumask *cpus;
> > >> +	int best_cpu = -1;
> > >> +	struct rq *rq;
> > >> +	int cpu;
> > >> +
> > >> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))
> > >> +		return -1;
> > >> +
> > >> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
> > >> +	if (!sd)
> > >> +		return -1;
> > >> +
> > >> +	sync_entity_load_avg(&p->se);
> > >> +
> > >> +	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> > >> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> > >> +
> > >> +	for_each_cpu_wrap(cpu, cpus, target) {
> > >> +		rq = cpu_rq(cpu);
> > >> +
> > >> +		if (!available_idle_cpu(cpu))
> > >> +			continue;
> > >> +		if (task_fits_capacity(p, rq->cpu_capacity))
> > >> +			return cpu;
> > > 
> > > I have couple of questions.
> > > 
> > > (1) Any particular reason for not checking sched_idle_cpu() as a backup
> > > for the case where all eligible CPUs are busy? select_idle_cpu() does
> > > that.
> > > 
> > 
> > No particular reason other than we didn't consider it, I think. I don't see
> > any harm in folding it in, I'll do that for v4. I am curious however; are
> > you folks making use of SCHED_IDLE? AFAIA Android isn't making use of it
> > yet, though Viresh paved the way for that to happen.
> > 
> 
> We are not using SCHED_IDLE in product setups. I am told Android may use it
> for background tasks in future. I am not completely sure though. I asked it
> because select_idle_cpu() is using it.

I believe Viresh intention when he pushed for the support was allowing this use
case.

FWIW, I had a patch locally to implement this but waiting on latency_nice
attribute to go in [1] before I attempt to upstream it.

The design goals I had in mind:

	1. If there are multiple energy efficient CPUs we can select, select
	   the idle one.
	2. If latency nice is set and the most energy efficient CPU is not
	   idle, then fallback to the most energy efficient idle CPU.

Android use case needs EAS path support before it can be useful to it.

[1] https://lore.kernel.org/lkml/20190919144259.vpuv7hvtqon4qgrv@e107158-lin.cambridge.arm.com/

--
Qais Yousef
