Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5C0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36CE21775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbgCDSyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:54:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDSyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:54:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C52B2084E;
        Wed,  4 Mar 2020 18:54:05 +0000 (UTC)
Date:   Wed, 4 Mar 2020 13:54:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] sched/rt: cpupri_find: Implement fallback
 mechanism for !fit case
Message-ID: <20200304135404.146c56eb@gandalf.local.home>
In-Reply-To: <20200304173925.43xq4wztummxgs3x@e107158-lin.cambridge.arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
        <20200302132721.8353-2-qais.yousef@arm.com>
        <20200304112739.7b99677e@gandalf.local.home>
        <20200304173925.43xq4wztummxgs3x@e107158-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 17:39:26 +0000
Qais Yousef <qais.yousef@arm.com> wrote:

> > > +	/*
> > > +	 * If we failed to find a fitting lowest_mask, make sure we fall back
> > > +	 * to the last known unfitting lowest_mask.
> > > +	 *
> > > +	 * Note that the map of the recorded idx might have changed since then,
> > > +	 * so we must ensure to do the full dance to make sure that level still
> > > +	 * holds a valid lowest_mask.
> > > +	 *
> > > +	 * As per above, the map could have been concurrently emptied while we
> > > +	 * were busy searching for a fitting lowest_mask at the other priority
> > > +	 * levels.
> > > +	 *
> > > +	 * This rule favours honouring priority over fitting the task in the
> > > +	 * correct CPU (Capacity Awareness being the only user now).
> > > +	 * The idea is that if a higher priority task can run, then it should
> > > +	 * run even if this ends up being on unfitting CPU.
> > > +	 *
> > > +	 * The cost of this trade-off is not entirely clear and will probably
> > > +	 * be good for some workloads and bad for others.
> > > +	 *
> > > +	 * The main idea here is that if some CPUs were overcommitted, we try
> > > +	 * to spread which is what the scheduler traditionally did. Sys admins
> > > +	 * must do proper RT planning to avoid overloading the system if they
> > > +	 * really care.
> > > +	 */
> > > +	if (best_unfit_idx != -1)
> > > +		return __cpupri_find(cp, p, lowest_mask, best_unfit_idx);  
> > 
> > Hmm, this only checks the one index, which can change and then we miss
> > everything. I think we can do better. What about this:  
> 
> Hmm. I see 2 issues with this approach:
> 
> > 
> > 
> >         for (idx = 0; idx < task_pri; idx++) {
> > 		int found = -1;
> > 
> >                 if (!__cpupri_find(cp, p, lowest_mask, idx))
> >                         continue;  
> 
> 1.
> 
> __cpupri_find() could update the lowest_mask at the next iteration, so the
> fallback wouldn't be the lowest level, right?

Hmm, you may be right.

> 
> > 
> >                 if (!lowest_mask || !fitness_fn)
> >                         return 1;
> > 
> > 		/* Make sure we have one fit CPU before clearing */
> > 		for_each_cpu(cpu, lowest_mask) {
> > 			if (fitness_fn(p, cpu)) {
> > 				found = cpu;
> > 				break;
> > 			}
> > 		}
> > 
> > 		if (found == -1)
> > 			continue;  
> 
> 2.
> 
> If we fix 1, then assuming found == -1 for all level, we'll still have the
> problem that the mask is stale.
> 
> We can do a full scan again as Tao was suggestion, the 2nd one without any
> fitness check that is. But isn't this expensive?

I was hoping to try to avoid that, but it's not that expensive and will
probably seldom happen. Perhaps we should run some test cases and trace the
results to see how often that can happen.

> 
> We risk the mask being stale anyway directly after selecting it. Or a priority
> level might become the lowest level just after we dismissed it.

Sure, but that's still a better effort.

> 
> So our best effort could end up lying even if we do the right thing (TM).
> 
> > 
> >                 /* Ensure the capacity of the CPUs fit the task */
> >                 for_each_cpu(cpu, lowest_mask) {
> >                         if (cpu < found || !fitness_fn(p, cpu))
> >                                 cpumask_clear_cpu(cpu, lowest_mask);
> >                 }
> > 
> >                 return 1;
> >         }
> > 
> > This way, if nothing fits we return the untouched lowest_mask, and only
> > clear the lowest_mask bits if we found a fitness cpu.  
> 
> Because of 1, I think the lowest mask will not be the true lowest mask, no?
> Please correct me if I missed something.

No, I think you are correct.

> 
> There's another 'major' problem that I need to bring your attention to,
> find_lowest_rq() always returns the first CPU in the mask.
> 
> See discussion below for more details
> 
> 	https://lore.kernel.org/lkml/20200219140243.wfljmupcrwm2jelo@e107158-lin/
> 
> In my test because multiple tasks wakeup together they all end up going to CPU1
> (the first fitting CPU in the mask), then just to be pushed back again. Not
> necessarily to where they were running before.
> 
> Not sure if there are other situations where this could happen.
> 
> If we fix this problem then we can help reduce the effect of this raciness in
> find_lowest_rq(), and end up with less ping-ponging if tasks happen to
> wakeup/sleep at the wrong time during the scan.

Hmm, I wonder if there's a fast way of getting the next CPU from the
current cpu the task is on. Perhaps that will help in the ping ponging.

-- Steve

> 
> Or maybe there is a way to eliminate all these races with the current design?
> 
> Thanks
> 
> --
> Qais Yousef

