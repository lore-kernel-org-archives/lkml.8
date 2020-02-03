Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA516C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DD820CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgBCO1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:27:19 -0500
Received: from foss.arm.com ([217.140.110.172]:53974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgBCO1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:27:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 808BB101E;
        Mon,  3 Feb 2020 06:27:18 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2311A3F68E;
        Mon,  3 Feb 2020 06:27:17 -0800 (PST)
Date:   Mon, 3 Feb 2020 14:27:14 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20200203142712.a7yvlyo2y3le5cpn@e107158-lin>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20200131100629.GC27398@codeaurora.org>
 <20200131153405.2ejp7fggqtg5dodx@e107158-lin.cambridge.arm.com>
 <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/20 07:08, Pavan Kondeti wrote:
> Thanks for the results. I see that tasks are indeed spreading on to silver.
> However it is not
> clear to me from the code how tasks would get spread. Because cpupri_find()
> never returns
> little CPU in the lowest_mask because RT task does not fit on little CPU.
> So from wake up
> path, we place the task on the previous CPU or BIG CPU. The push logic also
> has the
> RT capacity checks, so an overloaded BIG CPU may not push tasks to an idle
> (RT free) little CPU.

Okay I see what you mean.

Sorry I had to cache this back in again as it's been a while.

So yes you're right we won't force move to the little CPUs, but if we were
running there already we won't force overload the big CPU either. IIRC I didn't
see more than 2 tasks packed on a big core. But maybe I needed to try more
combination of things. The 2 tasks packed can be seen in my results. Which
I don't think it's a necessarily bad thing.

I tried to call out that in overloaded case we don't give any guarantees. I'll
expand below, but if a user asked for RT tasks to run on big cores more than
available big cores, then there's very little we can do.

If the tasks really want to be on a big core but the user is asking for more
than what the system can get, then the end result isn't the best whether we
pack or spread. Packing might end up good if the 2 tasks aren't intensive. Or
could end up being bad if they are.

Similarly if the 2 tasks aren't computationally intensive, then spreading to
the little is bad. Most likely the request for running at a certain performance
level, is to guarantee the predictability to finish execution within a certain
window of time. But don't quote me on this :)

I don't see one right answer here. The current mechanism could certainly do
better; but it's not clear what better means without delving into system
specific details. I am open to any suggestions to improve it.

As it stands, it allows the admin to boost RT tasks and guarantee they end up
running on the correct CPU. But it doesn't protect against bad RT planning.

> Yes, we do search with in the affined CPUs. However in cpupri_find(), we
> clear
> the CPUs on which the task does not fit. so the lowest_mask always be empty
> and we return -1. There is no fallback.

The question here is: if a task has its uclamp_min set to 1024 but is affined
to the wrong type of cpus, is it a user error or a kernel failure to deal with
this case?

The default p->uclamp_min = 1024 is not the right default to use in these
systems. I am pushing for a patch [1] to allow modifying this default behavior
at runtime. AFAIU Android has always disabled max RT boosting.

The common use case that we are trying to cater for is that most of the tasks
are happy to run anywhere, but there might be few that need to be boosted and
this boost value can only be guaranteed by running on a set of CPUs, in that
case we give this guarantee.

Again I agree the logic could be improved, but I prefer to see a real use case
first where this improvement helps.

[1] https://lore.kernel.org/lkml/20191220164838.31619-1-qais.yousef@arm.com/

Cheers

--
Qais Yousef
