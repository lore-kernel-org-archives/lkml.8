Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2A6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DCA20848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgCDPS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:18:28 -0500
Received: from foss.arm.com ([217.140.110.172]:35622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgCDPS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:18:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8961F31B;
        Wed,  4 Mar 2020 07:18:27 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 055A33F6CF;
        Wed,  4 Mar 2020 07:18:25 -0800 (PST)
Date:   Wed, 4 Mar 2020 15:18:23 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tao Zhou <t1zhou@aliyun.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, t1zhou@163.com
Subject: Re: [PATCH v3 1/6] sched/rt: cpupri_find: Implement fallback
 mechanism for !fit case
Message-ID: <20200304151823.phpcz7twxzxiu3j5@e107158-lin.cambridge.arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
 <20200302132721.8353-2-qais.yousef@arm.com>
 <20200304143200.GA13200@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304143200.GA13200@geo.homenetwork>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao

On 03/04/20 22:51, Tao Zhou wrote:

[...]

> >  /**
> >   * cpupri_find - find the best (lowest-pri) CPU in the system
> >   * @cp: The cpupri context
> > @@ -62,80 +115,72 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
> >  		struct cpumask *lowest_mask,
> >  		bool (*fitness_fn)(struct task_struct *p, int cpu))
> >  {
> > -	int idx = 0;
> >  	int task_pri = convert_prio(p->prio);
> > +	int best_unfit_idx = -1;
> 
> How about using cpumask to store CPUs when the "best unfit"
> happened. So, no need to call __cpupri_find() again.

I considered the CPU mask but it's expensive.

I either have to create a percpu variable, or allocate something at every call
here. Neither of which seemed acceptable to me.

Recording the idx is simple and cheap IMO.

[...]

> > +	/*
> > +	 * If we failed to find a fitting lowest_mask, make sure we fall back
> > +	 * to the last known unfitting lowest_mask.
> > +	 *
> > +	 * Note that the map of the recorded idx might have changed since then,
> > +	 * so we must ensure to do the full dance to make sure that level still
> > +	 * holds a valid lowest_mask.
> > +	 *
> > +	 * As per above, the map could have been concurrently emptied while we
> > +	 * were busy searching for a fitting lowest_mask at the other priority
> > +	 * levels.
> > +	 *
> > +	 * This rule favours honouring priority over fitting the task in the
> > +	 * correct CPU (Capacity Awareness being the only user now).
> > +	 * The idea is that if a higher priority task can run, then it should
> > +	 * run even if this ends up being on unfitting CPU.
> > +	 *
> > +	 * The cost of this trade-off is not entirely clear and will probably
> > +	 * be good for some workloads and bad for others.
> > +	 *
> > +	 * The main idea here is that if some CPUs were overcommitted, we try
> > +	 * to spread which is what the scheduler traditionally did. Sys admins
> > +	 * must do proper RT planning to avoid overloading the system if they
> > +	 * really care.
> > +	 */
> > +	if (best_unfit_idx != -1)
> > +		return __cpupri_find(cp, p, lowest_mask, best_unfit_idx);
> > +
> 
> Even use a loop again here, i don't know.

I don't see if going through the loop twice will help here. The proces is racy,
and I think by the time we reached here we would have tried hard enough to find
the best cpu to run on?

Thanks

--
Qais Yousef
