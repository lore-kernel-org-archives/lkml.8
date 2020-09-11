Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4B3C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B38221F1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgIKMWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:22:49 -0400
Received: from foss.arm.com ([217.140.110.172]:33072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgIKMRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:17:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D73E113E;
        Fri, 11 Sep 2020 05:17:10 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575903F68F;
        Fri, 11 Sep 2020 05:17:09 -0700 (PDT)
References: <20200911081745.214686199@infradead.org> <20200911082536.470013100@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com
Subject: Re: [PATCH 1/2] sched: Fix balance_callback()
In-reply-to: <20200911082536.470013100@infradead.org>
Date:   Fri, 11 Sep 2020 13:17:02 +0100
Message-ID: <jhjsgbo5wzl.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/09/20 09:17, Peter Zijlstra wrote:
> The intent of balance_callback() has always been to delay executing
> balancing operations until the end of the current rq->lock section.
> This is because balance operations must often drop rq->lock, and that
> isn't safe in general.
>
> However, as noted by Scott, there were a few holes in that scheme;
> balance_callback() was called after rq->lock was dropped, which means
> another CPU can interleave and touch the callback list.
>

So that can be say __schedule() tail racing with some setprio; what's the
worst that can (currently) happen here? Something like say two consecutive
enqueuing of push_rt_tasks() to the callback list?

> Rework code to call the balance callbacks before dropping rq->lock
> where possible, and otherwise splice the balance list onto a local
> stack.
>
> This guarantees that the balance list must be empty when we take
> rq->lock. IOW, we'll only ever run our own balance callbacks.
>

Makes sense to me.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Reported-by: Scott Wood <swood@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[...]

> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1220,6 +1220,8 @@ static inline void rq_pin_lock(struct rq
>  #ifdef CONFIG_SCHED_DEBUG
>       rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
>       rf->clock_update_flags = 0;
> +
> +	SCHED_WARN_ON(rq->balance_callback);

Clever!

>  #endif
>  }
>
