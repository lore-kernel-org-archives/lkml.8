Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E201EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1FB620729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHJNYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:24:39 -0400
Received: from foss.arm.com ([217.140.110.172]:56264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgHJNYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:24:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 597ECD6E;
        Mon, 10 Aug 2020 06:24:38 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 525083F718;
        Mon, 10 Aug 2020 06:24:30 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: reduce preemption with IDLE tasks
 runable(Internet mail)
To:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
Cc:     Jiang Biao <benbjiang@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200801023248.90104-1-benbjiang@gmail.com>
 <5ed0fd46-3a3d-3c1a-5d75-03a74864e640@arm.com>
 <592F24A7-BF43-457D-AC40-DC5E35279730@tencent.com>
 <8bef1f94-f9bf-08a5-2ff3-3485d7796a96@arm.com>
 <8629CB9F-AFC8-43D6-BD14-B60A0B85ADB3@tencent.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <5f870781-1648-b4ac-6026-557dfc347109@arm.com>
Date:   Mon, 10 Aug 2020 15:24:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8629CB9F-AFC8-43D6-BD14-B60A0B85ADB3@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2020 17:52, benbjiang(蒋彪) wrote:
> Hi, 
> 
>> On Aug 6, 2020, at 9:29 PM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 03/08/2020 13:26, benbjiang(蒋彪) wrote:
>>>
>>>
>>>> On Aug 3, 2020, at 4:16 PM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 01/08/2020 04:32, Jiang Biao wrote:
>>>>> From: Jiang Biao <benbjiang@tencent.com>

[...]

>> How would you deal with se's representing taskgroups which contain
>> SCHED_IDLE and SCHED_NORMAL tasks or other taskgroups doing that?
> I’m not sure I get the point. :) How about the following patch,
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04fa8dbcfa4d..8715f03ed6d7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2994,6 +2994,9 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>                 list_add(&se->group_node, &rq->cfs_tasks);
>         }
>  #endif
> +       if (task_has_idle_policy(task_of(se)))
> +               cfs_rq->idle_nr_running++;
> +
>         cfs_rq->nr_running++;
>  }
> 
> @@ -3007,6 +3010,9 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>                 list_del_init(&se->group_node);
>         }
>  #endif
> +       if (task_has_idle_policy(task_of(se)))
> +               cfs_rq->idle_nr_running--;
> +
>         cfs_rq->nr_running--;
>  }
> 
> @@ -4527,7 +4533,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>                 return;
>  #endif
> 
> -       if (cfs_rq->nr_running > 1)
> +       if (cfs_rq->nr_running > cfs_rq->idle_nr_running + 1 &&
> +           cfs_rq->h_nr_running - cfs_rq->idle_h_nr_running > cfs_rq->idle_nr_running + 1)
>                 check_preempt_tick(cfs_rq, curr);
>  }
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 877fb08eb1b0..401090393e09 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -500,6 +500,7 @@ struct cfs_bandwidth { };
>  struct cfs_rq {
>         struct load_weight      load;
>         unsigned int            nr_running;
> +       unsigned int            idle_nr_running;
>         unsigned int            h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
>         unsigned int            idle_h_nr_running; /* SCHED_IDLE */

         /
       / |  \
      A  n0 i0
     / \
    n1 i1

I don't think this will work. E.g. the patch would prevent tick
preemption between 'A' and 'n0' on '/' as well

(3 > 1 + 1) && (4 - 2 > 1 + 1)

You also have to make sure that a SCHED_IDLE task can tick preempt
another SCHED_IDLE task.

>>> I’m not sure if it’s ok to do that, because the IDLE class seems not to be so
>>> pure that could tolerate starving.
>>
>> Not sure I understand but idle_sched_class is not the same as SCHED_IDLE
>> (policy)?
> The case is that we need tasks(low priority, called offline tasks) to utilize the
> spare cpu left by CFS SCHED_NORMAL tasks(called online tasks) without
> interfering the online tasks. 
> Offline tasks only run when there’s no runnable online tasks, and offline tasks
> never preempt online tasks.
> The SCHED_IDLE policy seems not to be abled to be qualified for that requirement,
> because it has a weight(3), even though it’s small, but it can still preempt online
> tasks considering the fairness. In that way, offline tasks of SCHED_IDLE policy
> could interfere the online tasks.

Because of this very small weight (weight=3), compared to a SCHED_NORMAL
nice 0 task (weight=1024), a SCHED_IDLE task is penalized by a huge
se->vruntime value (1024/3 higher than for a SCHED_NORMAL nice 0 task).
This should make sure it doesn't tick preempt a SCHED_NORMAL nice 0 task.

It's different when the SCHED_NORMAL task has nice 19 (weight=15) but
that's part of the CFS design.

> On the other hand, idle_sched_class seems not to be qualified either. It’s too
> simple and only used for per-cpu idle task currently.

Yeah, leave this for the rq->idle task (swapper/X).

>>> We need an absolutely low priority class that could tolerate starving, which
>>> could be used to co-locate offline tasks. But IDLE class seems to be not
>>> *low* enough, if considering the fairness of CFS, and IDLE class still has a
>>> weight.

Understood. But this (tick) preemption should happen extremely rarely,
especially if you have SCHED_NORMAL nice 0 tasks, right?
