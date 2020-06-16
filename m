Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D417FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C422082F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgFPGJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:09:45 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56204 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbgFPGJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:09:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U.l9R21_1592287779;
Received: from IT-C02ZG85SLVDL.local(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0U.l9R21_1592287779)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jun 2020 14:09:40 +0800
Subject: Re: [PATCH] sched/fair: Optimize dequeue_task_fair()
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <6f2f195aea48bc50187dfb064aa530ba132be01b.1592230286.git.rocking@linux.alibaba.com>
 <CAKfTPtACgUutP86nM6HvgQ-Hj7RdBnK+yxqg3Dr+cOZCPSoeyg@mail.gmail.com>
From:   Peng Wang <rocking@linux.alibaba.com>
Message-ID: <60d6eec1-4406-655c-c329-fc1c915a7721@linux.alibaba.com>
Date:   Tue, 16 Jun 2020 14:09:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtACgUutP86nM6HvgQ-Hj7RdBnK+yxqg3Dr+cOZCPSoeyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 11:09 PM, Vincent Guittot wrote:
> On Mon, 15 Jun 2020 at 16:20, Peng Wang <rocking@linux.alibaba.com> wrote:
>>
>> While looking at enqueue_task_fair and dequeue_task_fair, it occurred
>> to me that dequeue_task_fair can also be optimized as Vincent described
>> in commit 7d148be69e3a ("sched/fair: Optimize enqueue_task_fair()").
> 
> good point
> 
>>
>> dequeue_throttle label can ensure se not to be NULL, and se is
>> always NULL when reaching root level.
>>
>> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
>> ---
>>   kernel/sched/fair.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index cbcb2f7..e6be952 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5614,10 +5614,10 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>
>>          }
>>
>> -dequeue_throttle:
>> -       if (!se)
>> -               sub_nr_running(rq, 1);
>> +       /* At this point se is NULL and we are at root level*/
>> +       sub_nr_running(rq, 1);
>>
>> +dequeue_throttle:
>>          /* balance early to pull high priority tasks */
>>          if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>>                  rq->next_balance = jiffies;
> 
> You can move the label here because sched_idle_rq() uses
> rq->nr-running and rq->cfs.idle_h_nr_running so they will not change
> if we jump to the label before reaching root level

Yes, then we can also skip the early balance check.

> 
>> --
>> 2.9.5
>>
