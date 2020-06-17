Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D17C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EB020734
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgFQOPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:15:39 -0400
Received: from foss.arm.com ([217.140.110.172]:58646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFQOPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:15:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3239B31B;
        Wed, 17 Jun 2020 07:15:38 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A08603F73C;
        Wed, 17 Jun 2020 07:15:36 -0700 (PDT)
References: <20200617121742.cpxppyi7twxmpin7@linutronix.de>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: Re: [PATCH] sched: __set_cpus_allowed_ptr(): Check cpus_mask, not cpus_ptr
In-reply-to: <20200617121742.cpxppyi7twxmpin7@linutronix.de>
Date:   Wed, 17 Jun 2020 15:15:31 +0100
Message-ID: <jhjmu51eq2k.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/06/20 13:17, Sebastian Andrzej Siewior wrote:
> From: Scott Wood <swood@redhat.com>
>
> This function is concerned with the long-term cpu mask, not the
> transitory mask the task might have while migrate disabled.  Before
> this patch, if a task was migrate disabled at the time
> __set_cpus_allowed_ptr() was called, and the new mask happened to be
> equal to the cpu that the task was running on, then the mask update
> would be lost.
>
> Signed-off-by: Scott Wood <swood@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/sched/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1637,7 +1637,7 @@ static int __set_cpus_allowed_ptr(struct
>               goto out;
>       }
>
> -	if (cpumask_equal(p->cpus_ptr, new_mask))
> +	if (cpumask_equal(&p->cpus_mask, new_mask))
>               goto out;
>
>       /*

Makes sense, but what about the rest of the checks? Further down there is

        /* Can the task run on the task's current CPU? If so, we're done */
        if (cpumask_test_cpu(task_cpu(p), new_mask))
                goto out;

If the task is currently migrate disabled and for some stupid reason it
gets affined elsewhere, we could try to move it out - which AFAICT we don't
want to do because migrate disabled. So I suppose you'd want an extra
bailout condition here when the task is migrate disabled.

ISTR in RT you do re-check the affinity and potentially move the task away
when re-enabling migration, so that should work out all fine.
