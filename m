Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBB7C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3466218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDTWza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:55:30 -0400
Received: from foss.arm.com ([217.140.110.172]:55700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgDTWz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:55:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBBC11FB;
        Mon, 20 Apr 2020 15:55:28 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66CAE3F73D;
        Mon, 20 Apr 2020 15:55:27 -0700 (PDT)
References: <cover.1587309963.git.yu.c.chen@intel.com> <7c1eab789cb4b53ec5f54644c089ce27ea14088a.1587309963.git.yu.c.chen@intel.com> <20200420183232.16b83374@gandalf.local.home>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched: Extract the task putting code from pick_next_task()
In-reply-to: <20200420183232.16b83374@gandalf.local.home>
Date:   Mon, 20 Apr 2020 23:55:21 +0100
Message-ID: <jhjwo69lqcm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(There's a v2 at cover.1587393807.git.yu.c.chen@intel.com but I think this
still applies)

On 20/04/20 23:32, Steven Rostedt wrote:
>> @@ -3904,6 +3904,28 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
>>      schedstat_inc(this_rq()->sched_count);
>>  }
>>
>> +static void finish_prev_task(struct rq *rq, struct task_struct *prev,
>> +			     struct rq_flags *rf)
>> +{
>> +	const struct sched_class *class;
>> +#ifdef CONFIG_SMP
>> +	/*
>> +	 * We must do the balancing pass before put_next_task(), such
>
> I know this is just a cut and paste move, but I'm thinking that this
> comment is wrong. Shouldn't this be "put_prev_task()" as we have no
> "put_next_task()" function.
>

Oh, I think you're right.

>
>> +	 * that when we release the rq->lock the task is in the same
>> +	 * state as before we took rq->lock.
>> +	 *
>> +	 * We can terminate the balance pass as soon as we know there is
>> +	 * a runnable task of @class priority or higher.
>> +	 */
>> +	for_class_range(class, prev->sched_class, &idle_sched_class) {
>> +		if (class->balance(rq, prev, rf))
>> +			break;
>> +	}
>> +#endif
>> +
>> +	put_prev_task(rq, prev);
>> +}
>> +
>>  /*
>>   * Pick up the highest-prio task:
>>   */
>> @@ -3937,22 +3959,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>      }
>>
>>  restart:
>> -#ifdef CONFIG_SMP
>> -	/*
>> -	 * We must do the balancing pass before put_next_task(), such
>> -	 * that when we release the rq->lock the task is in the same
>> -	 * state as before we took rq->lock.
>> -	 *
>> -	 * We can terminate the balance pass as soon as we know there is
>> -	 * a runnable task of @class priority or higher.
>> -	 */
>> -	for_class_range(class, prev->sched_class, &idle_sched_class) {
>> -		if (class->balance(rq, prev, rf))
>> -			break;
>> -	}
>> -#endif
>> -
>> -	put_prev_task(rq, prev);
>> +	finish_prev_task(rq, prev, rf);
>
> I'm not sure I like the name of this function. Perhaps
> "balance_and_put_prev_task()"? Something more in kind to what the function
> does.
>

The 'finish' thing isn't too far from the truth; it's the last thing we
need to do with the prev task (in terms of sched bookkeeping, I mean) -
and in Chen's defence ISTR Peter suggested that name.

Seeing as it's a "supercharged" put_prev_task(), I could live with the
marginally shorter "put_prev_task_balance()".

> -- Steve
>
>>
>>      for_each_class(class) {
>>              p = class->pick_next_task(rq);
