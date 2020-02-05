Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6898CC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459282082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgBEOsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:48:06 -0500
Received: from foss.arm.com ([217.140.110.172]:48246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgBEOsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:48:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50F9531B;
        Wed,  5 Feb 2020 06:48:05 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F283D3F68E;
        Wed,  5 Feb 2020 06:48:03 -0800 (PST)
Date:   Wed, 5 Feb 2020 14:48:01 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20200205144801.gkmxu3h3lfczbmbk@e107158-lin.cambridge.arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20200131100629.GC27398@codeaurora.org>
 <20200131153405.2ejp7fggqtg5dodx@e107158-lin.cambridge.arm.com>
 <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
 <20200203142712.a7yvlyo2y3le5cpn@e107158-lin>
 <20200203111451.0d1da58f@oasis.local.home>
 <20200203171745.alba7aswajhnsocj@e107158-lin>
 <20200203131203.20bf3fc3@oasis.local.home>
 <20200203190259.bnly7hfp3wfiteof@e107158-lin>
 <c30eddd3-143e-03f1-6975-97f5af1d3075@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c30eddd3-143e-03f1-6975-97f5af1d3075@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/20 18:23, Dietmar Eggemann wrote:
> On 03/02/2020 20:03, Qais Yousef wrote:
> > On 02/03/20 13:12, Steven Rostedt wrote:
> >> On Mon, 3 Feb 2020 17:17:46 +0000
> >> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> [...]
> 
> > In the light of strictly adhering to priority based scheduling; yes this makes
> > sense. Though I still think the migration will produce worse performance, but
> > I can appreciate even if that was true it breaks the strict priority rule.
> > 
> >>
> >> You can add to the logic that you do not take over an RT task that is
> >> pinned and can't move itself. Perhaps that may be the only change to
> > 
> > I get this.
> > 
> >> cpu_find(), is that it will only pick a big CPU if little CPUs are
> >> available if the big CPU doesn't have a pinned RT task on it.
> > 
> > But not that. Do you mind rephrasing it?
> > 
> > Or let me try first:
> > 
> > 	1. Search all priority levels for a fitting CPU
> 
> Just so I get this right: All _lower_ prio levels than p->prio, right?

Correct, that's what I meant :)

> 
> > 	2. If failed, return the first lowest mask found
> > 	3. If it succeeds, remove any CPU that has a pinned task in it
> > 	4. If the lowest_mask is empty, return (2).
> > 	5. Else return the lowest_mask with the fitting CPU(s)
> 
> Mapping this to the 5 FIFO tasks rt-tasks of Pavan's example (all
> p->prio=89 (dflt rt-app prio), dflt min_cap=1024 max_cap=1024) on a 4
> big (Cpu Capacity=1024) 4 little (Cpu capacity < 1024) system:
> 
> You search from idx 1 to 11 [p->prio=89 eq. idx (task_pri)=12] and since
> there are no lower prior RT tasks the lowest mask of idx=1 (CFS or Idle)
> for the 5th RT task is returned.

We should basically fallback to whatever was supposed to be returned if this
patch is not applied.

	if (lower_mask) {
		// record the value of the first valid lower_mask

		if lower_mask doesn't contain a fitting CPU:
			continue searching in the next priority level
	}

	if no fitting cpu was found at any lower level:
		return the recorded first valid lower_mask

> 
> But that means that CPU capacity trumps priority?

I'm not sure how to translate 'trumps' here.

So priority has precedence over capacity. I think this is not the best option,
but it keeps the rules consistent; which is if a higher priority task is
runnable it'd be pushed to another CPU running a lower priority one if we can
find one. We'll attempt to make sure this CPU fits the capacity requirement of
the task, but if there isn't one we'll fallback to the next best thing.

I think this makes sense and will keep this fitness logic generic.

Maybe it's easier to discuss over a patch. I will post one soon hopefully.

Thanks

--
Qais Yousef
