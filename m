Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B24C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0277620678
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHJIzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:55:39 -0400
Received: from foss.arm.com ([217.140.110.172]:54270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgHJIzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:55:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0313A11B3;
        Mon, 10 Aug 2020 01:55:38 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 882EA3F7BB;
        Mon, 10 Aug 2020 01:55:36 -0700 (PDT)
References: <20200804105619.GE2657@hirez.programming.kicks-ass.net> <20200804193413.510651-1-joshdon@google.com> <20200810061406.GA15559@linux.vnet.ibm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: ignore cache hotness for SMT migration
In-reply-to: <20200810061406.GA15559@linux.vnet.ibm.com>
Date:   Mon, 10 Aug 2020 09:55:31 +0100
Message-ID: <jhjzh72hocc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/08/20 07:14, Srikar Dronamraju wrote:
> * Josh Don <joshdon@google.com> [2020-08-04 12:34:13]:
>
>> SMT siblings share caches, so cache hotness should be irrelevant for
>> cross-sibling migration.
>>
>> Proposed-by: Venkatesh Pallipadi <venki@google.com>
>> Signed-off-by: Josh Don <joshdon@google.com>
>> ---
>>  kernel/sched/fair.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 1a68a0536add..abdb54e2339f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7402,6 +7402,10 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>>      if (unlikely(task_has_idle_policy(p)))
>>              return 0;
>>
>> +	/* SMT siblings share cache */
>> +	if (env->sd->flags & SD_SHARE_CPUCAPACITY)
>> +		return 0;
>> +
>
> If this for retaining cache hotness, should we look at
> SD_SHARE_PKG_RESOURCES instead of SD_SHARE_CPUCAPACITY?
>

Josh's patch only targets migrating tasks between threads of the same
core - as he points out, cache hotness shouldn't matter here.

Using SD_SHARE_PKG_RESOURCES here would mean freely migrating tasks between
any CPU of an LLC domain, which is quite likely something you do *not* want
to do.

>>      /*
>>       * Buddy candidates are cache hot:
>>       */
>> --
>> 2.28.0.163.g6104cc2f0b6-goog
>>
