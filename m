Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C10C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D8C2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgBCSML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbgBCSMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:12:10 -0500
Received: from oasis.local.home (unknown [213.120.252.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8932320838;
        Mon,  3 Feb 2020 18:12:08 +0000 (UTC)
Date:   Mon, 3 Feb 2020 13:12:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20200203131203.20bf3fc3@oasis.local.home>
In-Reply-To: <20200203171745.alba7aswajhnsocj@e107158-lin>
References: <20191009104611.15363-1-qais.yousef@arm.com>
        <20200131100629.GC27398@codeaurora.org>
        <20200131153405.2ejp7fggqtg5dodx@e107158-lin.cambridge.arm.com>
        <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
        <20200203142712.a7yvlyo2y3le5cpn@e107158-lin>
        <20200203111451.0d1da58f@oasis.local.home>
        <20200203171745.alba7aswajhnsocj@e107158-lin>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2020 17:17:46 +0000
Qais Yousef <qais.yousef@arm.com> wrote:


> I'm torn about pushing a task already on a big core to a little core if it says
> it wants it (down migration).

If the "down migration" happens to a process that is lower in priority,
then that stays in line with the policy decisions of scheduling RT
tasks. That is, higher priority task take precedence over lower
priority tasks, even if that means "degrading" that lower priority task.

For example, if a high priority task wakes up on a CPU that is running
a lower priority task, and with the exception of that lower priority
task being pinned, it will boot it off the CPU. Even if the lower
priority task is pinned, it may still take over the CPU if it can't
find another CPU.


> > 
> > 4. If a little core is returned, and we schedule an RT task that
> > prefers big cores on it, we mark it overloaded.
> > 
> > 5. An RT task on a big core schedules out. Start looking at the RT
> > overloaded run queues.
> > 
> > 6. See that there's an RT task on the little core, and migrate it over.  
> 
> I think the above should depend on the fitness of the cpu we currently run on.
> I think we shouldn't down migrate, or at least investigate better down
> migration makes more sense than keeping tasks running on the correct CPU where
> they are.

Note, this only happens when a big core CPU schedules. And if you do
not have HAVE_RT_PUSH_IPI (which sends IPIs to overloaded CPUS and just
schedules), then that "down migration" happens to an RT task that isn't
even running.

You can add to the logic that you do not take over an RT task that is
pinned and can't move itself. Perhaps that may be the only change to
cpu_find(), is that it will only pick a big CPU if little CPUs are
available if the big CPU doesn't have a pinned RT task on it.

Like you said, this is best effort, and I believe this is the best
approach. The policy has always been the higher the priority of a task,
the more likely it will push other tasks away. We don't change that. If
the system administrator is overloading the big cores with RT tasks,
then this is what they get.

> 
> > Note, this will require a bit more logic as the overloaded code wasn't
> > designed for migration of running tasks, but that could be added.  
> 
> I'm wary of overloading the meaning of rt.overloaded. Maybe I can convert it to
> a bitmap so that we can encode the reason.

We can change the name to something like rt.needs_pull or whatever.

-- Steve
