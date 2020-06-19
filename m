Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02DFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D556D20EDD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388667AbgFSSwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:52:41 -0400
Received: from foss.arm.com ([217.140.110.172]:56276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgFSSwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:52:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E13D52B;
        Fri, 19 Jun 2020 11:52:39 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4013A3F73C;
        Fri, 19 Jun 2020 11:52:38 -0700 (PDT)
References: <20200618195525.7889-1-qais.yousef@arm.com> <20200618195525.7889-3-qais.yousef@arm.com> <jhjwo43cpfl.mognet@arm.com> <20200619125148.y4cq3hwllgozbutq@e107158-lin.cambridge.arm.com> <jhjsgerchmn.mognet@arm.com> <20200619141348.5o5iqomwe6lofgiu@e107158-lin.cambridge.arm.com> <jhjr1ubccg2.mognet@arm.com> <20200619172524.y66a4hz6g6hr3thr@e107158-lin.cambridge.arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with static key
Message-ID: <jhjpn9udh2d.mognet@arm.com>
In-reply-to: <20200619172524.y66a4hz6g6hr3thr@e107158-lin.cambridge.arm.com>
Date:   Fri, 19 Jun 2020 19:52:32 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/06/20 18:25, Qais Yousef wrote:
> On 06/19/20 16:17, Valentin Schneider wrote:
>
> [...]
>
>> > But here this is
>> > just extra churn.
>> >
>> > If an imbalance has happend this means either:
>> >
>> >       1. enqueue/dequeue_task() is imablanced itself
>> >       2. uclamp_update_active() calls dec without inc.
>> >
>> > If 1 happened we have more reasons to be worried about. For 2 the function
>> > takes task_rq_lock() and does dec/inc in obvious way.
>> >
>>
>> True. I won't argue over the feasibility of the scenarios we are currently
>> aware of, my point was that if they do happen, it's nice to have debug
>> helps in the right places as the final breakage can happen much further
>> downstream.
>>
>> FWIW I don't like the diff I suggested at all, but if we can come up with a
>> cleverer scheme I think we should do it, as per the above.
>
> There's the fact as well that this whole thing is to deal with potentially
> avoid doing anything that is stricly not necessary in the fast path.
>
> keep in mind that my patch of introducing the sysctl is not accepted yet
> because it introduces such thing, but in that case it's not a debug only
> feature. CONFIG_SCHED_DEBUG do get enabled by distros because it exports a lot
> of useful info.

Sigh, true, but they really shouldn't. The whole point of having
SCHED_WARN_ON() is that it's a no-op on !SCHED_DEBUG kernels, which should
be any "production" kernel :(
