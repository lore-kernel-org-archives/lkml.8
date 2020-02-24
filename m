Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3618EC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C842080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgBXND0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:03:26 -0500
Received: from foss.arm.com ([217.140.110.172]:36814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbgBXND0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:03:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFF1530E;
        Mon, 24 Feb 2020 05:03:25 -0800 (PST)
Received: from [10.0.8.126] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 839543F534;
        Mon, 24 Feb 2020 05:03:24 -0800 (PST)
Subject: Re: [PATCH v2 6/6] sched/rt: Remove unnecessary assignment in
 inc/dec_rt_migration
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <20200223184001.14248-1-qais.yousef@arm.com>
 <20200223184001.14248-7-qais.yousef@arm.com>
 <a000f6b4-7548-1964-ba30-e8396c727d31@arm.com>
 <20200224123123.gbox3tcqcist7bbg@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <90e4af9c-b4e3-00bf-ebe6-5d4fe6f892aa@arm.com>
Date:   Mon, 24 Feb 2020 13:03:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224123123.gbox3tcqcist7bbg@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.20 12:31, Qais Yousef wrote:
> On 02/24/20 00:16, Dietmar Eggemann wrote:
>> On 23.02.20 19:40, Qais Yousef wrote:

[...]

>>> -	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
>>
>> IMHO, this is here to get the root rt_rq from any rt_rq (task_groups).
>> Looks like that e.g rt_nr_total is only maintained on root rt_rq's.
>>
>> Similar to CFS' &rq_of(cfs_rq)->cfs (cfs_rq_util_change()) to get root
>> cfs_rq.
>>
>> Not sure where CONFIG_RT_GROUP_SCHED=y is used but it's part of the rt
>> class implementation.
> 
> Ah I see. That was obvious.. How about the below comment?
> 
> This code is executed only if rt_entity_is_task(), I don't think this grantees
> that the rt_rq isn't for a group?

No, an rt task can run in this taskgroup (e.g. "/tg/tg1"), i.e. in
tg1->rt_rq[cpu].

The taskgroup skeleton rt_se of e.g. "/tg/tg1/tg11" would also run in
tg1->rt_rq[cpu] but for those rt_se's we bail out of [inc/dec]_rt_migration.

> 
> I need to go and unravel the layers maybe.
> 
> Thanks!
> 
> --
> Qais Yousef
> 
> -->8--
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index b35e49cdafcc..f929867215c4 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -343,6 +343,8 @@ static void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
>                 return;
> 
>         p = rt_task_of(rt_se);
> +
> +       /* get the root rt_rq if this is the rt_rq of a group */

Not sure if a comment like this will help since:

(a) the definition of rq_of_rt_rq() for the !CONFIG_RT_GROUP_SCHED case

(b) rt_rq might already be the root rt_rq in case the task runs in "/"

[...]
