Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A073C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D15F2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgHKQzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:55:14 -0400
Received: from foss.arm.com ([217.140.110.172]:38962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbgHKQzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:55:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9D5E31B;
        Tue, 11 Aug 2020 09:55:13 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCB0E3F22E;
        Tue, 11 Aug 2020 09:55:07 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Optimize dequeue_task_fair()
To:     Jiang Biao <benbjiang@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, Jiang Biao <benbjiang@tencent.com>
References: <20200811084310.27130-1-benbjiang@tencent.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9a2ddb2d-4c9a-a85d-cba2-0956b6d953c0@arm.com>
Date:   Tue, 11 Aug 2020 18:55:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811084310.27130-1-benbjiang@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2020 10:43, Jiang Biao wrote:
> Similar optimization as what has been done in commit,
> 7d148be69e3a(sched/fair: Optimize enqueue_task_fair())
> 
> dequeue_task_fair jumps to dequeue_throttle label when cfs_rq_of(se) is
> throttled which means that se can't be NULL. We can move the label after
> the if (!se) statement and remove the if(!se) statment as se is always
> NULL when reaching this point.
> 
> Besides, trying to keep the same pattern with enqueue_task_fair can make
> it more readable.
> 
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04fa8dbcfa4d..cbbeafdfa8b7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5618,10 +5618,10 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  
>  	}
>  
> -dequeue_throttle:
> -	if (!se)
> -		sub_nr_running(rq, 1);
> +	/* At this point se is NULL and we are at root level*/
> +	sub_nr_running(rq, 1);
>  
> +dequeue_throttle:
>  	/* balance early to pull high priority tasks */
>  	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>  		rq->next_balance = jiffies;

There is already a similar patch in master.

423d02e1463b - sched/fair: Optimize dequeue_task_fair() (2020-06-25 Peng
Wang)

