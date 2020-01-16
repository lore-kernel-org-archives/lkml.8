Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6550C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F6720748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgAPOwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:52:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPOwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:52:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEBF20730;
        Thu, 16 Jan 2020 14:52:21 +0000 (UTC)
Date:   Thu, 16 Jan 2020 09:52:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, notify@kernel.org
Subject: Re: [PATCH 1/1] timer: Warn about schedule_timeout() called for
 tasks in TASK_RUNNING state
Message-ID: <20200116095220.7368a604@gandalf.local.home>
In-Reply-To: <20200116140218.1328022-1-alex.popov@linux.com>
References: <20200116140218.1328022-1-alex.popov@linux.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 17:02:18 +0300
Alexander Popov <alex.popov@linux.com> wrote:

> When we were preparing the patch 6dcd5d7a7a29c1e, we made a mistake noticed
> by Linus: schedule_timeout() was called without setting the task state to
> anything particular. It calls the scheduler, but doesn't delay anything,
> because the task stays runnable. That happens because sched_submit_work()
> does nothing for tasks in TASK_RUNNING state.
> 
> Let's add a WARN_ONCE() under CONFIG_SCHED_DEBUG to detect such kernel
> API misuse.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  kernel/time/timer.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 4820823515e9..52ad2d6ce352 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1887,6 +1887,11 @@ signed long __sched schedule_timeout(signed long timeout)
>  		}
>  	}
>  
> +#ifdef CONFIG_SCHED_DEBUG
> +	WARN_ONCE(current->state == TASK_RUNNING,
> +			"schedule_timeout for TASK_RUNNING\n");
> +#endif
> +

But this can trigger false warnings. For example, if we are waiting on
an event with a timeout:


	DEFINE_WAIT(wait);

	for (;;) {
		prepare_to_wait(&waitq, &wait, TASK_UNINTERRUPTIBLE);
		if (event)
			break;
		timeout = schedule_timeout(timeout);
		if (!timeout)
			break;
	}
	finish_wait(&waitq, &wait);


If the event happens between "prepare_to_wait" and just before
schedule_timeout(), the wait queue will set this task's state to
TASK_RUNNING, which in turn triggers your warning.

-- Steve


>  	expire = timeout + jiffies;
>  
>  	timer.task = current;

