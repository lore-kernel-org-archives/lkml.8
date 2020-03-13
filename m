Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF8CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA1020746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCMPr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:47:28 -0400
Received: from foss.arm.com ([217.140.110.172]:59352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgCMPr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:47:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6A8931B;
        Fri, 13 Mar 2020 08:47:26 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 710933F6CF;
        Fri, 13 Mar 2020 08:47:25 -0700 (PDT)
References: <20200312165429.990-1-vincent.guittot@linaro.org> <jhjr1xwjz96.mognet@arm.com> <CAKfTPtCQZMOz9HzdiWg5g9O+W=hC5E-fiG8YVHWCcODjFRfefQ@mail.gmail.com> <jhjpndgjxxk.mognet@arm.com> <jhj4kuspgse.mognet@arm.com> <CAKfTPtD67EKA46i12FHpJQT4gTzaH=ASAyb2dhv4=owPHBRSdQ@mail.gmail.com> <CAKfTPtBZgvTBYR+kYjj9dHq8_25mG19CZmYzY5s33ijSHdLGyQ@mail.gmail.com>
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
Subject: Re: [PATCH] sched/fair: improve spreading of utilization
In-reply-to: <CAKfTPtBZgvTBYR+kYjj9dHq8_25mG19CZmYzY5s33ijSHdLGyQ@mail.gmail.com>
Date:   Fri, 13 Mar 2020 15:47:17 +0000
Message-ID: <jhj36acp88q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 13 2020, Vincent Guittot wrote:
>> > And with more coffee that's another Doh, ASYM_PACKING would end up as
>> > migrate_task. So this only affects the reduced capacity migration, which
>>
>> yes  ASYM_PACKING uses migrate_task and the case of reduced capacity
>> would use it too and would not be impacted by this patch. I say
>> "would" because the original rework of load balance got rid of this
>> case. I'm going to prepare a separate fix  for this
>
> After more thought, I think that we are safe for reduced capacity too
> because this is handled in the migrate_load case. In my previous
> reply, I was thinking of  the case where rq is not overloaded but cpu
> has reduced capacity which is not handled. But in such case, we don't
> have to force the migration of the task because there is still enough
> capacity otherwise rq would be overloaded and we are back to the case
> already handled
>

Good point on the capacity reduction vs group_is_overloaded.

That said, can't we also reach this with migrate_task? Say the local
group is entirely idle, and the busiest group has a few non-idle CPUs
but they all have at most 1 running task. AFAICT we would still go to
calculate_imbalance(), and try to balance out the number of idle CPUs.

If the migration_type is migrate_util, that can't happen because of this
change. Since we have this progressive balancing strategy (tasks -> util
-> load), it's a bit odd to have this "gap" in the middle where we get
one less possibility to trigger active balance, don't you think? That
is, providing I didn't say nonsense again :)

It's not a super big deal, but I think it's nice if we can maintain a
consistent / gradual migration policy.

>>
>> > might be hard to notice in benchmarks.
