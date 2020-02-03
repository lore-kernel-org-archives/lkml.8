Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBEAC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11362051A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBCTDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:03:06 -0500
Received: from foss.arm.com ([217.140.110.172]:58618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgBCTDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:03:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 546AB101E;
        Mon,  3 Feb 2020 11:03:05 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04D473F52E;
        Mon,  3 Feb 2020 11:03:03 -0800 (PST)
Date:   Mon, 3 Feb 2020 19:03:01 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20200203190259.bnly7hfp3wfiteof@e107158-lin>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20200131100629.GC27398@codeaurora.org>
 <20200131153405.2ejp7fggqtg5dodx@e107158-lin.cambridge.arm.com>
 <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
 <20200203142712.a7yvlyo2y3le5cpn@e107158-lin>
 <20200203111451.0d1da58f@oasis.local.home>
 <20200203171745.alba7aswajhnsocj@e107158-lin>
 <20200203131203.20bf3fc3@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200203131203.20bf3fc3@oasis.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/20 13:12, Steven Rostedt wrote:
> On Mon, 3 Feb 2020 17:17:46 +0000
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> 
> > I'm torn about pushing a task already on a big core to a little core if it says
> > it wants it (down migration).
> 
> If the "down migration" happens to a process that is lower in priority,
> then that stays in line with the policy decisions of scheduling RT
> tasks. That is, higher priority task take precedence over lower
> priority tasks, even if that means "degrading" that lower priority task.
> 
> For example, if a high priority task wakes up on a CPU that is running
> a lower priority task, and with the exception of that lower priority
> task being pinned, it will boot it off the CPU. Even if the lower
> priority task is pinned, it may still take over the CPU if it can't
> find another CPU.

Indeed this makes sense.

> 
> 
> > > 
> > > 4. If a little core is returned, and we schedule an RT task that
> > > prefers big cores on it, we mark it overloaded.
> > > 
> > > 5. An RT task on a big core schedules out. Start looking at the RT
> > > overloaded run queues.
> > > 
> > > 6. See that there's an RT task on the little core, and migrate it over.  
> > 
> > I think the above should depend on the fitness of the cpu we currently run on.
> > I think we shouldn't down migrate, or at least investigate better down
> > migration makes more sense than keeping tasks running on the correct CPU where
> > they are.
> 
> Note, this only happens when a big core CPU schedules. And if you do
> not have HAVE_RT_PUSH_IPI (which sends IPIs to overloaded CPUS and just
> schedules), then that "down migration" happens to an RT task that isn't
> even running.

In the light of strictly adhering to priority based scheduling; yes this makes
sense. Though I still think the migration will produce worse performance, but
I can appreciate even if that was true it breaks the strict priority rule.

> 
> You can add to the logic that you do not take over an RT task that is
> pinned and can't move itself. Perhaps that may be the only change to

I get this.

> cpu_find(), is that it will only pick a big CPU if little CPUs are
> available if the big CPU doesn't have a pinned RT task on it.

But not that. Do you mind rephrasing it?

Or let me try first:

	1. Search all priority levels for a fitting CPU
	2. If failed, return the first lowest mask found
	3. If it succeeds, remove any CPU that has a pinned task in it
	4. If the lowest_mask is empty, return (2).
	5. Else return the lowest_mask with the fitting CPU(s)


Did I get it right?

The idea is not to potentially overload that CPU when this pinned task wakes
up? The task could be sleeping waiting for something interesting to poke it..?

> 
> Like you said, this is best effort, and I believe this is the best
> approach. The policy has always been the higher the priority of a task,
> the more likely it will push other tasks away. We don't change that. If
> the system administrator is overloading the big cores with RT tasks,
> then this is what they get.

Yes. I think that has always been the case with RT. It is very easy to shoot
yourself in the foot.

> 
> > 
> > > Note, this will require a bit more logic as the overloaded code wasn't
> > > designed for migration of running tasks, but that could be added.  
> > 
> > I'm wary of overloading the meaning of rt.overloaded. Maybe I can convert it to
> > a bitmap so that we can encode the reason.
> 
> We can change the name to something like rt.needs_pull or whatever.

Thanks for bringing more clarity to this.

Cheers

--
Qais Yousef
