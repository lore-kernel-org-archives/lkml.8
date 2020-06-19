Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC00C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B5C20776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbgFSON5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:13:57 -0400
Received: from foss.arm.com ([217.140.110.172]:33514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgFSONy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:13:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 594A32B;
        Fri, 19 Jun 2020 07:13:53 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADF553F73C;
        Fri, 19 Jun 2020 07:13:51 -0700 (PDT)
Date:   Fri, 19 Jun 2020 15:13:49 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200619141348.5o5iqomwe6lofgiu@e107158-lin.cambridge.arm.com>
References: <20200618195525.7889-1-qais.yousef@arm.com>
 <20200618195525.7889-3-qais.yousef@arm.com>
 <jhjwo43cpfl.mognet@arm.com>
 <20200619125148.y4cq3hwllgozbutq@e107158-lin.cambridge.arm.com>
 <jhjsgerchmn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhjsgerchmn.mognet@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/20 14:25, Valentin Schneider wrote:
> 
> On 19/06/20 13:51, Qais Yousef wrote:
> > On 06/19/20 11:36, Valentin Schneider wrote:
> >>
> >> On 18/06/20 20:55, Qais Yousef wrote:
> >> > There is a report that when uclamp is enabled, a netperf UDP test
> >> > regresses compared to a kernel compiled without uclamp.
> >> >
> >> > https://lore.kernel.org/lkml/20200529100806.GA3070@suse.de/
> >> >
> >>
> >> ISTR the perennial form for those is: https://lkml.kernel.org/r/<message-id>
> >
> > The link is correct permalinnk from lore and contains the message-id as Peter
> > likes and he has accepted this form before.
> >
> 
> I think the objections I remember were on using lkml.org rather than
> lkml.kernel.org. Sorry!
> 
> > If you look closely you'll see that what you suggest is just moving 'lkml' to
> > replace lore in the dns name and put an /r/. I don't see a need to enforce one
> > form over the other as the one I used is much easier to get.
> >
> 
> My assumption would be that while lore may fade (it hasn't been there for
> that long, who knows what will come next), lkml.kernel.org ought to be
> perennial. Keyword here being "assumption".
> 
> > If Peter really insists I'll be happy to change.
> >
> > [...]
> >
> >> > +	 * This could happen if sched_uclamp_unused was disabled while the
> >> > +	 * current task was running, hence we could end up with unbalanced call
> >> > +	 * to uclamp_rq_dec_id().
> >> > +	 */
> >> > +	if (unlikely(!bucket->tasks))
> >> > +		return;
> >>
> >> I'm slightly worried about silent returns for cases like these, can we try
> >> to cook something up to preserve the previous SCHED_WARN_ON()? Say,
> >> something like the horrendous below - alternatively might be feasible with
> >> with some clever p->on_rq flag.
> >
> > I am really against extra churn and debug code to detect an impossible case
> > that is not really tricky for reviewers to discern. Outside of enqueue/dequeue
> > path, it's only used in update_uclamp_active(). It is quite easy to see that
> > it's impossible, except for the legit case now when we have a static key
> > changing when a task is running.
> >
> 
> Providing it isn't too much of a head scratcher (and admittedly what I am
> suggesting is borderline here), I believe it is worthwhile to add debug
> helps in what is assumed to be impossible cases - even more so in this case
> seeing as it had been deemed worth to check previously. We've been proved
> wrong on the "impossible" nature of some things before.
> 
> We have a few of those checks strewn over the scheduler code, so it's not
> like we would be starting a new trend.

I am sorry I am still not bought in. I think the parts you're talking about are
in the lockless part of the scheduler which are really hard to debug as several
cpus could be traversing these data from different code paths. But here this is
just extra churn.

If an imbalance has happend this means either:

	1. enqueue/dequeue_task() is imablanced itself
	2. uclamp_update_active() calls dec without inc.

If 1 happened we have more reasons to be worried about. For 2 the function
takes task_rq_lock() and does dec/inc in obvious way.

So I don't see any reason to add new info in task_struct and sprinkle #ifdefs
to protect against something that I can't see we can't reason correctly about
now.

We don't use pr_debug() in scheduler (I guess no computer would have booted
with that on), otherwise that would have been a good candidate for one, yes.
But we can't do that.

Thanks

--
Qais Yousef
