Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF168C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5A6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCMQ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:57:58 -0400
Received: from foss.arm.com ([217.140.110.172]:33100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgCMQ56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:57:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF9A131B;
        Fri, 13 Mar 2020 09:57:57 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B19C3F534;
        Fri, 13 Mar 2020 09:57:56 -0700 (PDT)
References: <20200312165429.990-1-vincent.guittot@linaro.org> <jhjr1xwjz96.mognet@arm.com> <CAKfTPtCQZMOz9HzdiWg5g9O+W=hC5E-fiG8YVHWCcODjFRfefQ@mail.gmail.com> <jhjpndgjxxk.mognet@arm.com> <jhj4kuspgse.mognet@arm.com> <CAKfTPtD67EKA46i12FHpJQT4gTzaH=ASAyb2dhv4=owPHBRSdQ@mail.gmail.com> <CAKfTPtBZgvTBYR+kYjj9dHq8_25mG19CZmYzY5s33ijSHdLGyQ@mail.gmail.com> <jhj36acp88q.mognet@arm.com> <CAKfTPtAMmYONX+qxp1Awj+XpqkWU3ootcyv7iar7e6z5nSczpw@mail.gmail.com>
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
In-reply-to: <CAKfTPtAMmYONX+qxp1Awj+XpqkWU3ootcyv7iar7e6z5nSczpw@mail.gmail.com>
Date:   Fri, 13 Mar 2020 16:57:54 +0000
Message-ID: <jhj1rpwp4z1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 13 2020, Vincent Guittot wrote:

>> Good point on the capacity reduction vs group_is_overloaded.
>>
>> That said, can't we also reach this with migrate_task? Say the local
>
> The test has only been added for migrate_util so migrate_task is not impacted
>
>> group is entirely idle, and the busiest group has a few non-idle CPUs
>> but they all have at most 1 running task. AFAICT we would still go to
>> calculate_imbalance(), and try to balance out the number of idle CPUs.
>
> such case is handled by migrate_task when we try to even the number of
> tasks between groups
>
>>
>> If the migration_type is migrate_util, that can't happen because of this
>> change. Since we have this progressive balancing strategy (tasks -> util
>> -> load), it's a bit odd to have this "gap" in the middle where we get
>> one less possibility to trigger active balance, don't you think? That
>> is, providing I didn't say nonsense again :)
>
> Right now, I can't think of a use case that could trigger such
> situation because we use migrate_util when source is overloaded which
> means that there is at least one waiting task and we favor this task
> in priority
>

Right, what I was trying to say is that AIUI migration_type ==
migrate_task with <= 1 running task per CPU in the busiest group can
*currently* lead to a balance attempt, and thus a potential active
balance.

Consider a local group of 4 idle CPUs, and a busiest group of 3 busy 1
idle CPUs, each busy having only 1 running task. That busiest group
would be group_has_spare, so we would compute an imbalance of
(4-1) / 2 == 1 task to move. We'll proceed with the load balance, but
we'll only move things if we go through an active_balance.

My point is that if we prevent this for migrate_util, it would make
sense to prevent it for migrate_task, but it's not straightforward since
we have things like ASYM_PACKING.

>>
>> It's not a super big deal, but I think it's nice if we can maintain a
>> consistent / gradual migration policy.
>>
>> >>
>> >> > might be hard to notice in benchmarks.
