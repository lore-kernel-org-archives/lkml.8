Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1605C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7172207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgHKJuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:50:22 -0400
Received: from foss.arm.com ([217.140.110.172]:36020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgHKJuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:50:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 327C21063;
        Tue, 11 Aug 2020 02:50:21 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F4053F22E;
        Tue, 11 Aug 2020 02:50:14 -0700 (PDT)
Subject: Re: [PATCH RFC v2] sched/fair: simplify the work when reweighting
 entity
To:     Jiang Biao <benbjiang@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, Jiang Biao <benbjiang@tencent.com>
References: <20200806161406.22629-1-benbjiang@tencent.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9149cf7c-df81-cf9d-65f7-a51d4ec76f78@arm.com>
Date:   Tue, 11 Aug 2020 11:50:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806161406.22629-1-benbjiang@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2020 18:14, Jiang Biao wrote:
> From: Jiang Biao <benbjiang@tencent.com>
> 
> If a se is on_rq when reweighting entity, all we need should be
> updating the load of cfs_rq, other dequeue/enqueue work could be
> redundant, such as,
> * nr_running--/nr_running++
> 
> Even though the following dequeue/enqueue path would never be reached
> * account_numa_dequeue/account_numa_enqueue
> * list_del/list_add from/into cfs_tasks
> but it could be a little confusing.
> 
> Simplifying the logic could be helpful to reduce a litte overhead for
> hot path, and make it cleaner and more readable.

LGTM. I guess you have to resend it w/o the RFC tag.

Maybe you can rework the patch header a little?

Something like this:

The code in reweight_entity() can be simplified.

For a sched entity on the rq, the entity accounting can be replaced by
cfs_rq instantaneous load updates currently called from within the
entity accounting.

Even though an entity on the rq can't represent a task in
reweight_entity() (a task is always dequeued before calling this
function) and so the numa task accounting and the rq->cfs_tasks list
management of the entity accounting are never called, the redundant
cfs_rq->nr_running decrement/increment will be avoided.

> 
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
> v2<-v1: 
> - Amend the commit log.
> 
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04fa8dbcfa4d..18a8fc7bd0de 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3086,7 +3086,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  		/* commit outstanding execution time */
>  		if (cfs_rq->curr == se)
>  			update_curr(cfs_rq);
> -		account_entity_dequeue(cfs_rq, se);
> +		update_load_sub(&cfs_rq->load, se->load.weight);
>  	}
>  	dequeue_load_avg(cfs_rq, se);
>  
> @@ -3102,7 +3102,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  
>  	enqueue_load_avg(cfs_rq, se);
>  	if (se->on_rq)
> -		account_entity_enqueue(cfs_rq, se);
> +		update_load_add(&cfs_rq->load, se->load.weight);
>  
>  }

