Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F662C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F3920724
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389609AbgF3Pkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:40:39 -0400
Received: from foss.arm.com ([217.140.110.172]:36818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389589AbgF3Pkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:40:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04B0430E;
        Tue, 30 Jun 2020 08:40:38 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 570AF3F71E;
        Tue, 30 Jun 2020 08:40:36 -0700 (PDT)
Date:   Tue, 30 Jun 2020 16:40:34 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200630154033.5r6zi7ajgag7jlec@e107158-lin.cambridge.arm.com>
References: <20200629162633.8800-1-qais.yousef@arm.com>
 <20200629162633.8800-3-qais.yousef@arm.com>
 <87366dnfaq.derkling@matbug.net>
 <20200630094623.hnlqtgavauqlsuyd@e107158-lin.cambridge.arm.com>
 <87zh8kmwlt.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zh8kmwlt.derkling@matbug.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick

On 06/30/20 16:55, Patrick Bellasi wrote:
> 
> Hi Qais,
> sorry for commenting on v5 with a v6 already posted, but...
> ... I cannot keep up with your re-spinning rate ;)

I classified that as a nit really and doesn't affect correctness. We have
different subjective view on what is better here. I did all the work in the
past 2 weeks and I think as the author of this patch I have the right to keep
my preference on subjective matters. I did consider your feedback and didn't
ignore it and improved the naming and added a comment to make sure there's no
confusion.

We could nitpick the best name forever, but is it really that important?

I really don't see any added value for one approach or another here to start
a long debate about it.

The comments were small enough that I didn't see any controversy that
warrants holding the patches longer. I agreed with your proposal to use
uc_se->active and clarified why your other suggestions don't hold.

You pointed that uclamp_is_enabled() confused you; and I responded that I'll
change the name. Sorry for not being explicit about answering the below, but
I thought my answer implied that I don't prefer it.

> 
> >> Thus, perhaps we can just use the same pattern used by the
> >> sched_numa_balancing static key:
> >> 
> >>   $ git grep sched_numa_balancing
> >>   kernel/sched/core.c:DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> >>   kernel/sched/core.c:            static_branch_enable(&sched_numa_balancing);
> >>   kernel/sched/core.c:            static_branch_disable(&sched_numa_balancing);
> >>   kernel/sched/core.c:    int state = static_branch_likely(&sched_numa_balancing);
> >>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
> >>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
> >>   kernel/sched/fair.c:    if (!static_branch_likely(&sched_numa_balancing))
> >>   kernel/sched/fair.c:    if (static_branch_unlikely(&sched_numa_balancing))
> >>   kernel/sched/sched.h:extern struct static_key_false sched_numa_balancing;
> >> 
> >> IOW: unconditionally define sched_uclamp_used as non static in core.c,
> >> and use it directly on schedutil too.
> 
> So, what about this instead of adding the (renamed) method above?

I am sorry there's no written rule that says one should do it in a specific
way. And AFAIK both way are implemented in the kernel. I appreciate your
suggestion but as the person who did all the hard work, I think my preference
matters here too.

And actually with my approach when uclamp is not compiled in there's no need to
define an extra variable; and since uclamp_is_used() is defined as false for
!CONFIG_UCLAMP_TASK, it'll help with DCE, so less likely to end up with dead
code that'll never run in the final binary.

Thanks a lot for all of your comments and feedback anyway!

--
Qais Yousef
