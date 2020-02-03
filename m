Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D798C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA1720838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgBCRRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:17:51 -0500
Received: from foss.arm.com ([217.140.110.172]:56538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgBCRRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:17:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8348530E;
        Mon,  3 Feb 2020 09:17:50 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 344413F52E;
        Mon,  3 Feb 2020 09:17:49 -0800 (PST)
Date:   Mon, 3 Feb 2020 17:17:46 +0000
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
Message-ID: <20200203171745.alba7aswajhnsocj@e107158-lin>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20200131100629.GC27398@codeaurora.org>
 <20200131153405.2ejp7fggqtg5dodx@e107158-lin.cambridge.arm.com>
 <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
 <20200203142712.a7yvlyo2y3le5cpn@e107158-lin>
 <20200203111451.0d1da58f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200203111451.0d1da58f@oasis.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/20 11:14, Steven Rostedt wrote:
> On Mon, 3 Feb 2020 14:27:14 +0000
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> > I don't see one right answer here. The current mechanism could certainly do
> > better; but it's not clear what better means without delving into system
> > specific details. I am open to any suggestions to improve it.
> 
> The way I see this is that if there's no big cores available but little
> cores are, and the RT task has those cores in its affinity mask then
> the task most definitely should consider moving to the little core. The
> cpu_find() should return them!

I almost agree. I think the cpupri_find() could certainly do better if the task
is already running on a little core. It can fallback to the next best little
core if no bigger core is available.

I already started looking at pushing a patch to do that.

I'm torn about pushing a task already on a big core to a little core if it says
it wants it (down migration).

I guess since most tasks are fifo by default then one will starve if the other
one is a long running task (assuming same priority). But long running RT tasks
are not the common case, hence I wanted to hear about what use case this logic
hurts. I expect by default the big cores not to be over subscribed. Based on
some profiles I did at least running real Android apps I didn't see the RT
tasks were overwhelming the system.

In my view, the performance dip of sharing the big core would be less than
migrating the task to a little core momentarily then bring it back in to the
big core.

Because the following 2 big ifs must be satisfied first to starve an RT task:

	1. We need all the big cores to be overloaded first.
	2. The RT tasks on all the big cores are CPU hoggers (however we want
	   to define this)

And I think this needs more investigation.

> 
> But, what we can do is to mark the little core that's running an RT
> task on a it that prefers bigger cores, as "rt-overloaded".  This will
> add this core into the being looked at when another core schedules out
> an RT task. When that happens, the RT task on the little core will get
> pulled back to the big core.

I didn't think of using the rt-overloaded flag in this way. That would be
interesting to try.

> 
> Here's what I propose.
> 
> 1. Scheduling of an RT task that wants big cores, but has little cores
> in its affinity.
> 
> 2. Calls cpu_find() which will look to place it first on a big core, if
> there's a core that is running a task that is lower priority than
> itself.
> 
> 3. If all the big cores have RT tasks it can not preempt, look to find
> a little core.

I agree with the above.

> 
> 4. If a little core is returned, and we schedule an RT task that
> prefers big cores on it, we mark it overloaded.
> 
> 5. An RT task on a big core schedules out. Start looking at the RT
> overloaded run queues.
> 
> 6. See that there's an RT task on the little core, and migrate it over.

I think the above should depend on the fitness of the cpu we currently run on.
I think we shouldn't down migrate, or at least investigate better down
migration makes more sense than keeping tasks running on the correct CPU where
they are.

> Note, this will require a bit more logic as the overloaded code wasn't
> designed for migration of running tasks, but that could be added.

I'm wary of overloading the meaning of rt.overloaded. Maybe I can convert it to
a bitmap so that we can encode the reason.

Let me see how complicated to write something up.

Thanks!

--
Qais Yousef
