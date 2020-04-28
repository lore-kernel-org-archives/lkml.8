Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08575C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF4920656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgD1Qcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:32:55 -0400
Received: from foss.arm.com ([217.140.110.172]:55192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgD1Qcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:32:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D08FF30E;
        Tue, 28 Apr 2020 09:32:52 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 657223F305;
        Tue, 28 Apr 2020 09:32:51 -0700 (PDT)
References: <20200424041832.11364-1-hdanton@sina.com> <20200424043650.14940-1-hdanton@sina.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/4] sched: set new prio after checking schedule policy
In-reply-to: <20200424043650.14940-1-hdanton@sina.com>
Date:   Tue, 28 Apr 2020 17:32:45 +0100
Message-ID: <jhjh7x3sh8y.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/04/20 05:36, Hillf Danton wrote:
> Set newprio the same way as normal_prio() does after checking schedule
> policy and to MAX_PRIO -1 by default.
>
> What is also added is boundary checks for RT and fair priorities.
>
> Cc: Mike Galbraith <efault@gmx.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4768,8 +4768,7 @@ static int __sched_setscheduler(struct t
>                               const struct sched_attr *attr,
>                               bool user, bool pi)
>  {
> -	int newprio = dl_policy(attr->sched_policy) ? MAX_DL_PRIO - 1 :
> -		      MAX_RT_PRIO - 1 - attr->sched_priority;
> +	int newprio;
>       int retval, oldprio, oldpolicy = -1, queued, running;
>       int new_effective_prio, policy = attr->sched_policy;
>       const struct sched_class *prev_class;
> @@ -4800,6 +4799,26 @@ recheck:
>               return -EINVAL;
>
>       /*
> +	 * compute newprio after checking policy, see normal_prio();
> +	 * it's used in pi boost below
> +	 */
> +	if (dl_policy(policy)) {
> +		newprio = MAX_DL_PRIO - 1;
> +	}
> +	else if (rt_policy(policy)) {
> +		if (attr->sched_priority > MAX_RT_PRIO - 1)
> +			return -EINVAL;
> +		newprio = MAX_RT_PRIO - 1 - attr->sched_priority;
> +	}
> +	else if (fair_policy(policy)) {
> +		if (attr->sched_nice < MIN_NICE ||
> +		    attr->sched_nice > MAX_NICE)
> +			return -EINVAL;


We can't hit this with the syscall route, since we (silently) clamp those
values in sched_copy_attr(). setpriority() does the same. There's this
comment in sched_copy_attr() that asks whether we should clamp or return an
error; seems like the current consensus is on clamping, but then we might
want to get rid of that comment :)

> +		newprio = NICE_TO_PRIO(attr->sched_nice);

This is new, however AFAICT it doesn't change anything for CFS (or about to
be) tasks since what matters is calling check_class_changed() further
down.

> +	} else
> +		newprio = MAX_PRIO - 1;
> +
> +	/*
>        * Allow unprivileged RT tasks to decrease priority:
>        */
>       if (user && !capable(CAP_SYS_NICE)) {
