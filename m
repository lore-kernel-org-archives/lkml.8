Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB46AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4BEA2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgEFQDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:03:11 -0400
Received: from foss.arm.com ([217.140.110.172]:40174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgEFQDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:03:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F30BFD6E;
        Wed,  6 May 2020 09:03:04 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A133F68F;
        Wed,  6 May 2020 09:03:03 -0700 (PDT)
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ> <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com> <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ> <20200505142711.GA12952@vingu-book> <jhjftcd1hmx.mognet@arm.com> <CAKfTPtCM7mE7a63rXB4cG5gHn03ArjTB1ZBje=qEWOGR9mj67g@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peng Liu <iwtbavbm@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
In-reply-to: <CAKfTPtCM7mE7a63rXB4cG5gHn03ArjTB1ZBje=qEWOGR9mj67g@mail.gmail.com>
Date:   Wed, 06 May 2020 17:02:56 +0100
Message-ID: <jhjv9l9yrtb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/05/20 14:45, Vincent Guittot wrote:
>> But then we may skip an update if we goto abort, no? Imagine we have just
>> NOHZ_STATS_KICK, so we don't call any rebalance_domains(), and then as we
>> go through the last NOHZ CPU in the loop we hit need_resched(). We would
>> end in the abort part without any update to nohz.next_balance, despite
>> having accumulated relevant data in the local next_balance variable.
>
> Yes but on the other end, the last CPU has not been able to run the
> rebalance_domain so we must not move  nohz.next_balance otherwise it
> will have to wait for at least another full period
> In fact, I think that we have a problem with current implementation
> because if we abort because  local cpu because busy we might end up
> skipping idle load balance for a lot of idle CPUs
>
> As an example, imagine that we have 10 idle CPUs with the same
> rq->next_balance which equal nohz.next_balance.  _nohz_idle_balance
> starts on CPU0, it processes idle lb for CPU1 but then has to abort
> because of need_resched. If we update nohz.next_balance like
> currently, the next idle load balance  will happen after a full
> balance interval whereas we still have 8 CPUs waiting for running an
> idle load balance.
>
> My proposal also fixes this problem
>

That's a very good point; so with NOHZ_BALANCE_KICK we can reduce
nohz.next_balance via rebalance_domains(), and otherwise we would only
increase it if we go through a complete for_each_cpu() loop in
_nohz_idle_balance().

That said, if for some reason we keep bailing out of the loop, we won't
push nohz.next_balance forward and thus may repeatedly nohz-balance only
the first few CPUs in the NOHZ mask. I think that can happen if we have
say 2 tasks pinned to a single rq, in that case nohz_balancer_kick() will
kick a NOHZ balance whenever now >= nohz.next_balance.
