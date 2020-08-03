Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BCCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBB820678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgHCIQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:16:50 -0400
Received: from foss.arm.com ([217.140.110.172]:53810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgHCIQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:16:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAEF5D6E;
        Mon,  3 Aug 2020 01:16:49 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D98573F718;
        Mon,  3 Aug 2020 01:16:38 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched/fair: reduce preemption with IDLE tasks runable
To:     Jiang Biao <benbjiang@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, Jiang Biao <benbjiang@tencent.com>
References: <20200801023248.90104-1-benbjiang@gmail.com>
Message-ID: <5ed0fd46-3a3d-3c1a-5d75-03a74864e640@arm.com>
Date:   Mon, 3 Aug 2020 10:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200801023248.90104-1-benbjiang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2020 04:32, Jiang Biao wrote:
> From: Jiang Biao <benbjiang@tencent.com>
> 
> No need to preempt when there are only one runable CFS task with
> other IDLE tasks on runqueue. The only one CFS task would always
> be picked in that case.
> 
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04fa8dbcfa4d..8fb80636b010 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4527,7 +4527,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>  		return;
>  #endif
>  
> -	if (cfs_rq->nr_running > 1)
> +	if (cfs_rq->nr_running > cfs_rq.idle_h_nr_running + 1)

cfs_rq is a pointer.

>  		check_preempt_tick(cfs_rq, curr);
>  }

You can't compare cfs_rq->nr_running with cfs_rq->idle_h_nr_running!

There is a difference between cfs_rq->h_nr_running and
cfs_rq->nr_running. The '_h_' stands for hierarchical.

The former gives you hierarchical task accounting whereas the latter is
the number of sched entities (representing tasks or taskgroups) enqueued
in cfs_rq.

In entity_tick(), cfs_rq->nr_running has to be used for the condition to
call check_preempt_tick(). We want to check if curr has to be preempted
by __pick_first_entity(cfs_rq) on this cfs_rq.

entity_tick() is called for each sched entity (and so for each
cfs_rq_of(se)) of the task group hierarchy (e.g. task p running in
taskgroup /A/B : se(p) -> se(A/B) -> se(A)).
