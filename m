Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91FFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 23:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8233120B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 23:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgFZXVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 19:21:34 -0400
Received: from foss.arm.com ([217.140.110.172]:35274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgFZXVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 19:21:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E531A30E;
        Fri, 26 Jun 2020 16:21:32 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 427353F73C;
        Fri, 26 Jun 2020 16:21:31 -0700 (PDT)
References: <20200625154352.24767-1-qais.yousef@arm.com> <20200625154352.24767-3-qais.yousef@arm.com> <87bll6ngrr.derkling@matbug.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] sched/uclamp: Protect uclamp fast path code with static key
In-reply-to: <87bll6ngrr.derkling@matbug.net>
Date:   Sat, 27 Jun 2020 00:21:29 +0100
Message-ID: <jhja70ph0qu.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/06/20 13:38, Patrick Bellasi wrote:
> On Thu, Jun 25, 2020 at 17:43:52 +0200, Qais Yousef <qais.yousef@arm.com> wrote...
>> @@ -994,9 +1013,16 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>>      lockdep_assert_held(&rq->lock);
>>
>>      bucket = &uc_rq->bucket[uc_se->bucket_id];
>> -	SCHED_WARN_ON(!bucket->tasks);
>> -	if (likely(bucket->tasks))
>> -		bucket->tasks--;
>> +
>> +	/*
>> +	 * This could happen if sched_uclamp_used was enabled while the
>> +	 * current task was running, hence we could end up with unbalanced call
>> +	 * to uclamp_rq_dec_id().
>> +	 */
>> +	if (unlikely(!bucket->tasks))
>> +		return;
>> +
>> +	bucket->tasks--;
>>      uc_se->active = false;
>
> In this chunk you are indeed changing the code.
>
> Are we sure there are not issues with patterns like:
>
>   enqueue(taskA)
>   // uclamp gets enabled
>   enqueue(taskB)
>   dequeue(taskA)
>   // bucket->tasks is now 0
>   dequeue(taskB)
>
> TaskB has been enqueued with with uclamp enabled, thus it
> has got uc_se->active=True and enforced its clamp value at RQ level.
>
> But with your change above we don't reset that anymore.
>

Harumph indeed...

> As per my previous proposal: why not just removing the SCHED_WARN_ON?
> That's the only real problem in the code above, since now we are not
> more granted to have balanced inc/dec.
>

The SCHED_WARN_ON is gone, were you thinking of something else?
