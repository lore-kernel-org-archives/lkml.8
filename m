Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5523CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3388220707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgAaPeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:34:11 -0500
Received: from foss.arm.com ([217.140.110.172]:36836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728860AbgAaPeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:34:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94DD4FEC;
        Fri, 31 Jan 2020 07:34:10 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B493F67D;
        Fri, 31 Jan 2020 07:34:09 -0800 (PST)
Date:   Fri, 31 Jan 2020 15:34:06 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20200131153405.2ejp7fggqtg5dodx@e107158-lin.cambridge.arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20200131100629.GC27398@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200131100629.GC27398@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan

On 01/31/20 15:36, Pavan Kondeti wrote:
> Hi Qais,
> 
> On Wed, Oct 09, 2019 at 11:46:11AM +0100, Qais Yousef wrote:

[...]

> > 
> > For RT we don't have a per task utilization signal and we lack any
> > information in general about what performance requirement the RT task
> > needs. But with the introduction of uclamp, RT tasks can now control
> > that by setting uclamp_min to guarantee a minimum performance point.

[...]

> > ---
> > 
> > Changes in v2:
> > 	- Use cpupri_find() to check the fitness of the task instead of
> > 	  sprinkling find_lowest_rq() with several checks of
> > 	  rt_task_fits_capacity().
> > 
> > 	  The selected implementation opted to pass the fitness function as an
> > 	  argument rather than call rt_task_fits_capacity() capacity which is
> > 	  a cleaner to keep the logical separation of the 2 modules; but it
> > 	  means the compiler has less room to optimize rt_task_fits_capacity()
> > 	  out when it's a constant value.
> > 
> > The logic is not perfect. For example if a 'small' task is occupying a big CPU
> > and another big task wakes up; we won't force migrate the small task to clear
> > the big cpu for the big task that woke up.
> > 
> > IOW, the logic is best effort and can't give hard guarantees. But improves the
> > current situation where a task can randomly end up on any CPU regardless of
> > what it needs. ie: without this patch an RT task can wake up on a big or small
> > CPU, but with this it will always wake up on a big CPU (assuming the big CPUs
> > aren't overloaded) - hence provide a consistent performance.

[...]

> I understand that RT tasks run on BIG cores by default when uclamp is enabled.
> Can you tell what happens when we have more runnable RT tasks than the BIG
> CPUs? Do they get packed on the BIG CPUs or eventually silver CPUs pull those
> tasks? Since rt_task_fits_capacity() is considered during wakeup, push and
> pull, the tasks may get packed on BIG forever. Is my understanding correct?

I left up the relevant part from the commit message and my 'cover-letter' above
that should contain answers to your question.

In short, the logic is best effort and isn't a hard guarantee. When the system
is overloaded we'll still spread, and a task that needs a big core might end up
on a little one. But AFAIU with RT, if you really want guarantees you need to
do some planning otherwise there are no guarantees in general that your task
will get what it needs.

But I understand your question is for the general purpose case. I've hacked my
notebook to run a few tests for you

	https://gist.github.com/qais-yousef/cfe7487e3b43c3c06a152da31ae09101

Look at the diagrams in "Test {1, 2, 3} Results". I spawned 6 tasks which match
the 6 cores on the Juno I ran on. Based on Linus' master from a couple of days.

Note on Juno cores 1 and 2 are the big cors. 'b_*' and 'l_*' are the task names
which are remnants from my previous testing where I spawned different numbers
of big and small tasks.

I repeat the same tests 3 times to demonstrate the repeatability. The logic
causes 2 tasks to run on a big CPU, but there's spreading. IMO on a general
purpose system this is a good behavior. On a real time system that needs better
guarantee then there's no alternative to doing proper RT planning.

In the last test I just spawn 2 tasks which end up on the right CPUs, 1 and 2.
On system like Android my observations has been that there are very little
concurrent RT tasks active at the same time. So if there are some tasks in the
system that do want to be on the big CPU, they most likely to get that
guarantee. Without this patch what you get is completely random.

> 
> Also what happens for the case where RT tasks are pinned to silver but with
> default uclamp value i.e p.uclamp.min=1024 ? They may all get queued on a
> single silver and other silvers may not help since the task does not fit
> there. In practice, we may not use this setup. Just wanted to know if this
> behavior is intentional or not.

I'm not sure I understand your question.

If the RT tasks are affined to a set of CPUs, then we'll only search in these
CPUs. I expect the logic not to change with this patch. If you have a use case
that you think that breaks with this patch, can you please share the details
so I can reproduce?

I just ran several tests spawning 4 tasks affined to the little cores and
I indeed see them spreading on the littles.

Cheers

--
Qais Yousef
