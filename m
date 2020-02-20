Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FB4C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4315220658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgBTQLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:11:32 -0500
Received: from foss.arm.com ([217.140.110.172]:45702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgBTQLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:11:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 216BB31B;
        Thu, 20 Feb 2020 08:11:31 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0A73F6CF;
        Thu, 20 Feb 2020 08:11:28 -0800 (PST)
Subject: Re: [PATCH v3 4/5] sched/pelt: Add a new runnable average signal
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>
References: <20200214152729.6059-5-vincent.guittot@linaro.org>
 <20200219125513.8953-1-vincent.guittot@linaro.org>
 <9fe822fc-c311-2b97-ae14-b9269dd99f1e@arm.com>
 <CAKfTPtD4kz07hikCuU2_cm67ntruopN9CdJEP+fg5L4_N=qEgg@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d9f78b94-2455-e000-82bd-c00cfb9bbc8e@arm.com>
Date:   Thu, 20 Feb 2020 16:11:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtD4kz07hikCuU2_cm67ntruopN9CdJEP+fg5L4_N=qEgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2020 14:36, Vincent Guittot wrote:
> I agree that setting by default to SCHED_CAPACITY_SCALE is too much
> for little core.
> The problem for little core can be fixed by using the cpu capacity instead
> 

So that's indeed better for big.LITTLE & co. Any reason however for not
aligning with the initialization of util_avg ?

With the default MC imbalance_pct (117), it takes 875 utilization to make
a single CPU group (with 1024 capacity) overloaded (group_is_overloaded()).
For a completely idle CPU, that means forking at least 3 tasks (512 + 256 +
128 util_avg)

With your change, it only takes 2 tasks. I know I'm being nitpicky here, but
I feel like those should be aligned, unless we have a proper argument against
it - in which case this should also appear in the changelog with so far only
mentions issues with util_avg migration, not the fork time initialization.

> @@ -796,6 +794,8 @@ void post_init_entity_util_avg(struct task_struct *p)
>                 }
>         }
> 
> +       sa->runnable_avg = cpu_scale;
> +
>         if (p->sched_class != &fair_sched_class) {
>                 /*
>                  * For !fair tasks do:
>>
>>>               sa->load_avg = scale_load_down(se->load.weight);
>>> +     }
>>>
>>>       /* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
>>>  }
