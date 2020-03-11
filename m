Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC4C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6795220671
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgCKOX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:23:26 -0400
Received: from foss.arm.com ([217.140.110.172]:50334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgCKOX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:23:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 993B831B;
        Wed, 11 Mar 2020 07:23:25 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B3013F67D;
        Wed, 11 Mar 2020 07:23:24 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:23:21 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] sched/rt: Fix pushing unfit tasks to a better CPU
Message-ID: <20200311142321.3zfyoemzvheo4omt@e107158-lin.cambridge.arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
 <20200302132721.8353-7-qais.yousef@arm.com>
 <20200311100020.63bb81e5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311100020.63bb81e5@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/20 10:00, Steven Rostedt wrote:
> On Mon,  2 Mar 2020 13:27:21 +0000
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> > +			 * Don't bother moving it if the destination CPU is
> > +			 * not running a lower priority task.
> > +			 */
> > +			if (p->prio < cpu_rq(target)->rt.highest_prio.curr) {
> > +
> > +				cpu = target;
> > +
> > +			} else if (p->prio == cpu_rq(target)->rt.highest_prio.curr) {
> > +
> > +				/*
> > +				 * If the priority is the same and the new CPU
> > +				 * is a better fit, then move, otherwise don't
> > +				 * bother here either.
> > +				 */
> > +				if (fit_target)
> > +					cpu = target;
> > +			}
> 
> BTW, A little better algorithm would be to test fit_target first:
> 
> 	target_prio = cpu_rq(target)->rt.hightest_prio.curr;
> 	if (p->prio < target_prio) {
> 		cpu = target;
> 
> 	} else if (fit_target && p->prio == target_prio) {
> 		cpu = target;
> 	}
> 
> Which can also just be a single if statement:
> 
> 	if (p->prio < target_prio ||
> 	    (fit_target && p->prio == target_prio)
> 		cpu = target;

Indeed.

We might have a better fix now if [1] goes in.

It'd fix the 'thundering herd' issue I mentioned before.
cpumask_any_and_distribute() should teach find_lowest_rq() to distribute tasks
that wakeup at the same time better. Hence fix the need to do the above.
It won't be bullet proof still, but neither the above is.

I'm sure there will be other places that can benefit from this distribution
function too.

Thanks!

--
Qais Yousef

[1] https://lore.kernel.org/lkml/20200311010113.136465-1-joshdon@google.com/
