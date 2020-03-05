Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D774C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF9A20848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCELzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:55:08 -0500
Received: from foss.arm.com ([217.140.110.172]:47696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgCELzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:55:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E9EA31B;
        Thu,  5 Mar 2020 03:55:08 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69CD03F6C4;
        Thu,  5 Mar 2020 03:55:06 -0800 (PST)
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380
 enqueue_task_fair+0x328/0x440
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200228163545.GA18662@vingu-book>
 <be45b190-d96c-1893-3ef0-f574eb595256@de.ibm.com>
 <49a2ebb7-c80b-9e2b-4482-7f9ff938417d@de.ibm.com>
 <ad0f263a-6837-e793-5761-fda3264fd8ad@de.ibm.com>
 <CAKfTPtCX4padfJm8aLrP9+b5KVgp-ff76=teu7MzMZJBYrc-7w@mail.gmail.com>
 <CAKfTPtD9b6o=B6jkbWNjfAw9e1UjT9Z07vxdsVfikEQdeCtfPw@mail.gmail.com>
 <2108173c-beaa-6b84-1bc3-8f575fb95954@de.ibm.com>
 <7be92e79-731b-220d-b187-d38bde80ad16@arm.com>
 <805cbe05-2424-7d74-5e11-37712c189eb6@de.ibm.com>
 <f28bc5ac-87fa-2494-29db-ff7d98b7372a@de.ibm.com>
 <20200305093003.GA32088@vingu-book>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b582bd06-cac3-bc5d-3b26-68d15e36454f@arm.com>
Date:   Thu, 5 Mar 2020 12:54:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305093003.GA32088@vingu-book>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2020 10:30, Vincent Guittot wrote:
> Le mercredi 04 mars 2020 à 20:59:33 (+0100), Christian Borntraeger a écrit :
>>
>> On 04.03.20 20:38, Christian Borntraeger wrote:
>>>
>>> On 04.03.20 20:19, Dietmar Eggemann wrote:

[...]

> Could you try to add the patch below on top of dietmar's one so we will have the status of
> each level of the hierarchy ?
> The 1st level seems ok but something wrong happens while walking the hierarchy
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69fc30db7440..9ccde775e02e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5331,14 +5331,17 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  
>         if (rq->tmp_alone_branch != &rq->leaf_cfs_rq_list) {
>                 char path[64];
> +               se = &p->se;
>  
> -               cfs_rq = cfs_rq_of(&p->se);
> +               for_each_sched_entity(se) {
> +                       cfs_rq = cfs_rq_of(se);
>  
> -               sched_trace_cfs_rq_path(cfs_rq, path, 64);
> +                       sched_trace_cfs_rq_path(cfs_rq, path, 64);
>  
> -               printk("CPU%d path=%s on_list=%d nr_running=%d p=[%s %d]\n",
> -                      cpu_of(rq), path, cfs_rq->on_list, cfs_rq->nr_running,
> +                       printk("CPU%d path=%s on_list=%d nr_running=%d throttled=%d p=[%s %d]\n",
> +                      cpu_of(rq), path, cfs_rq->on_list, cfs_rq->nr_running, cfs_rq_throttled(cfs_rq),
>                        p->comm, p->pid);
> +               }
>         }
>  
>         assert_list_leaf_cfs_rq(rq);

Yeah, that's better.

The fact that the task 'CPU 1/KVM' in
'machine-qemu\x2d16\x2dtest14.scope' hit the assert only tells us that
some list_[add|\del]_leaf_cfs_rq on CPU62 before left
rq->tmp_alone_branch != rq->leaf_cfs_rq_list.

I see that cgroup-v2 is used here.

>> [   25.680326] CPU62 path=/machine.slice/machine-test.slice/machine-qemu\x2d16\x2dtest14. on_list=1 nr_running=1 p=[CPU 1/KVM 2543]
>> [   25.680334] ------------[ cut here ]------------
>> [   25.680335] rq->tmp_alone_branch != &rq->leaf_cfs_rq_list
>> [   25.680351] WARNING: CPU: 61 PID: 2535 at kernel/sched/fair.c:380 enqueue_task_fair+0x3f6/0x4a8

[...]
