Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16A5C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B89207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NqBj4uIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgA2DxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:53:08 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:43655 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgA2DxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:53:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580269986; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=8Yfsu70kjW1KcreCoB/LC/iySnJRGXuVvHJxxjEM3Uk=; b=NqBj4uIhKgTEwAztJ9UWdKalB5/CwwqeTtsDE5k+9IwXX9tLQ6ao5dkzjZYXBOahWFMMgE64
 HElDGtsrQ8xHcgn9rJIMOYZ9XaCTxRmhl4mhvrgAndkvmCOvpldxumKlezKSCmjlVS6fDrp7
 hUZCH34T6GZomx2LzCLP92n4qlg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3101a1.7f5f243f0650-smtp-out-n02;
 Wed, 29 Jan 2020 03:53:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B3899C4479C; Wed, 29 Jan 2020 03:53:05 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03B47C43383;
        Wed, 29 Jan 2020 03:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03B47C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 29 Jan 2020 09:22:58 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH v3 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
Message-ID: <20200129035258.GB27398@codeaurora.org>
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-2-valentin.schneider@arm.com>
 <20200128062245.GA27398@codeaurora.org>
 <1ed322d6-0325-ecac-cc68-326a14b8c1dd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed322d6-0325-ecac-cc68-326a14b8c1dd@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:30:26AM +0000, Valentin Schneider wrote:
> Hi Pavan,
> 
> On 28/01/2020 06:22, Pavan Kondeti wrote:
> > Hi Valentin,
> > 
> > On Sun, Jan 26, 2020 at 08:09:32PM +0000, Valentin Schneider wrote:
> >>  
> >> +static inline int check_cpu_capacity(struct rq *rq, struct sched_domain *sd);
> >> +
> >> +/*
> >> + * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
> >> + * the task fits. If no CPU is big enough, but there are idle ones, try to
> >> + * maximize capacity.
> >> + */
> >> +static int select_idle_capacity(struct task_struct *p, int target)
> >> +{
> >> +	unsigned long best_cap = 0;
> >> +	struct sched_domain *sd;
> >> +	struct cpumask *cpus;
> >> +	int best_cpu = -1;
> >> +	struct rq *rq;
> >> +	int cpu;
> >> +
> >> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))
> >> +		return -1;
> >> +
> >> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
> >> +	if (!sd)
> >> +		return -1;
> >> +
> >> +	sync_entity_load_avg(&p->se);
> >> +
> >> +	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> >> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >> +
> >> +	for_each_cpu_wrap(cpu, cpus, target) {
> >> +		rq = cpu_rq(cpu);
> >> +
> >> +		if (!available_idle_cpu(cpu))
> >> +			continue;
> >> +		if (task_fits_capacity(p, rq->cpu_capacity))
> >> +			return cpu;
> > 
> > I have couple of questions.
> > 
> > (1) Any particular reason for not checking sched_idle_cpu() as a backup
> > for the case where all eligible CPUs are busy? select_idle_cpu() does
> > that.
> > 
> 
> No particular reason other than we didn't consider it, I think. I don't see
> any harm in folding it in, I'll do that for v4. I am curious however; are
> you folks making use of SCHED_IDLE? AFAIA Android isn't making use of it
> yet, though Viresh paved the way for that to happen.
> 

We are not using SCHED_IDLE in product setups. I am told Android may use it
for background tasks in future. I am not completely sure though. I asked it
because select_idle_cpu() is using it.

> > (2) Assuming all CPUs are busy, we return -1 from here and end up
> > calling select_idle_cpu(). The traversal in select_idle_cpu() may be
> > waste in cases where sd_llc == sd_asym_cpucapacity . For example SDM845.
> > Should we worry about this?
> > 
> 
> Before v3, since we didn't have the fallback CPU selection within
> select_idle_capacity(), we would need the fall-through to select_idle_cpu()
> (we could've skipped an idle CPU just because its capacity wasn't high
> enough).
> 
> That's not the case anymore, so indeed we may be able to bail out of
> select_idle_sibling() right after select_idle_capacity() (or after the
> prev / recent_used_cpu checks). Our only requirement here is that sd_llc
> remains a subset of sd_asym_cpucapacity.
> 
> So far for Arm topologies we can have:
> - sd_llc < sd_asym_cpucapacity (e.g. legacy big.LITTLE like Juno)
> - sd_llc == sd_asym_cpucapacity (e.g. DynamIQ like SDM845)
> 
> I'm slightly worried about sd_llc > sd_asym_cpucapacity ever being an
> actual thing - I don't believe it makes much sense, but that's not stopping
> anyone.
> 
> AFAIA we (Arm) *currently* don't allow that with big.LITTLE or DynamIQ, nor
> do I think it can happen with the default scheduler topology where MC is
> the last possible level we can have as sd_llc.
> 
> So it *might* be a safe assumption - and I can still add a SCHED_WARN_ON().

Agreed.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
