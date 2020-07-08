Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AD2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C47206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgGHKeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:34:18 -0400
Received: from foss.arm.com ([217.140.110.172]:59170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGHKeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:34:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11F6731B;
        Wed,  8 Jul 2020 03:34:17 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFB313F71E;
        Wed,  8 Jul 2020 03:34:15 -0700 (PDT)
References: <20200702144258.19326-1-vincent.guittot@linaro.org> <jhjh7up99ss.mognet@arm.com> <CAKfTPtCxki8E=9DqistC32xZJ4ozufb9jUOR=ro34BNNNJtJiw@mail.gmail.com> <CAKfTPtA2RNc+XYMn0z_JyCgFswkUxHTS83uN_sJ8pjU7XPE4aA@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: handle case of task_h_load() returning 0
In-reply-to: <CAKfTPtA2RNc+XYMn0z_JyCgFswkUxHTS83uN_sJ8pjU7XPE4aA@mail.gmail.com>
Date:   Wed, 08 Jul 2020 11:34:10 +0100
Message-ID: <jhjzh8a70t9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/07/20 14:30, Vincent Guittot wrote:
> On Thu, 2 Jul 2020 at 18:28, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>
>> On Thu, 2 Jul 2020 at 18:11, Valentin Schneider
>> <valentin.schneider@arm.com> wrote:
>> >
>> >
>> > On 02/07/20 15:42, Vincent Guittot wrote:
>> > > task_h_load() can return 0 in some situations like running stress-ng
>> > > mmapfork, which forks thousands of threads, in a sched group on a 224 cores
>> > > system. The load balance doesn't handle this correctly because
>> > > env->imbalance never decreases and it will stop pulling tasks only after
>> > > reaching loop_max, which can be equal to the number of running tasks of
>> > > the cfs. Make sure that imbalance will be decreased by at least 1.
>> > >
>> > > misfit task is the other feature that doesn't handle correctly such
>> > > situation although it's probably more difficult to face the problem
>> > > because of the smaller number of CPUs and running tasks on heterogenous
>> > > system.
>> > >
>> > > We can't simply ensure that task_h_load() returns at least one because it
>> > > would imply to handle underrun in other places.
>> >
>> > Nasty one, that...
>> >
>> > Random thought: isn't that the kind of thing we have scale_load() and
>> > scale_load_down() for? There's more uses of task_h_load() than I would like
>> > for this, but if we upscale its output (or introduce an upscaled variant),
>> > we could do something like:
>> >
>> > ---
>> > detach_tasks()
>> > {
>> >         long imbalance = env->imbalance;
>> >
>> >         if (env->migration_type == migrate_load)
>> >                 imbalance = scale_load(imbalance);
>> >
>> >         while (!list_empty(tasks)) {
>> >                 /* ... */
>> >                 switch (env->migration_type) {
>> >                 case migrate_load:
>> >                         load = task_h_load_upscaled(p);
>> >                         /* ... usual bits here ...*/
>> >                         lsub_positive(&env->imbalance, load);
>> >                         break;
>> >                         /* ... */
>> >                 }
>> >
>> >                 if (!scale_load_down(env->imbalance))
>> >                         break;
>> >         }
>> > }
>> > ---
>> >
>> > It's not perfect, and there's still the misfit situation to sort out -
>> > still, do you think this is something we could go towards?
>>
>> This will not work for 32bits system.
>>
>> For 64bits, I have to think a bit more if the upscale would fix all
>> cases and support propagation across a hierarchy. And in this case we
>> could also consider to make scale_load/scale_load_down a nop all the
>> time
>
> In addition that problem remains on 32bits, the problem can still
> happen after extending the scale so this current patch still makes
> sense.
>

Right, I think we'd want to have that at the very least for 32bit anyway. I
haven't done the math, but doesn't it require an obscene amount of tasks
for that to still happen on 64bit with the increased resolution?

> Then if we want to reduce the cases where task_h_load returns 0, we
> should better make scale_load_down a nop otherwise we will have to
> maintain 2 values h_load and scale_h_load across the hierarchy
>

I don't fully grasp yet how much surgery that would require, but it does
sound like something we've been meaning to do, see e.g. se_weight:

 * XXX we want to get rid of these helpers and use the full load resolution.
