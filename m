Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B026C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B77A20801
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgEJQQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:16:36 -0400
Received: from foss.arm.com ([217.140.110.172]:44344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgEJQQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:16:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 628E530E;
        Sun, 10 May 2020 09:16:35 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6343F68F;
        Sun, 10 May 2020 09:16:33 -0700 (PDT)
References: <1589115401-26391-1-git-send-email-pkondeti@codeaurora.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH] sched/debug: Fix requested task uclamp values shown in procfs
In-reply-to: <1589115401-26391-1-git-send-email-pkondeti@codeaurora.org>
Date:   Sun, 10 May 2020 17:16:28 +0100
Message-ID: <jhjblmvu5nn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/05/20 13:56, Pavankumar Kondeti wrote:
> The intention of commit 96e74ebf8d59 ("sched/debug: Add task uclamp
> values to SCHED_DEBUG procfs") was to print requested and effective
> task uclamp values. The requested values printed are read from p->uclamp,
> which holds the last effective values. Fix this by printing the values
> from p->uclamp_req.
>
> Fixes: 96e74ebf8d59 ("sched/debug: Add task uclamp values to SCHED_DEBUG procfs")
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>

Argh, Qais pointed this out to me ~ a week ago, and I left this in my todo
stack. I goofed up, sorry!

As Pavan points out, p->uclamp[foo] is just a cache of uclamp_eff_value(p,
foo) from the last time p was enqueued and runnable - what we are
interested in is indeed comparing this with the *requested* value.

I wanted to send an example along with a patch, I guess that's the kick I
needed!


My setup is a busy loop, its per-task clamps are set to (256, 768) via
sched_setattr(), and it's shoved in a cpu cgroup with uclamp settings of
(50%, 50%)

On the current master (e99332e7b4cd ("gcc-10: mark more functions __init to
avoid section mismatch warnings")), this gives me:

  $ uclamp-get $PID # via sched_getattr()
  uclamp.min=256 uclamp.max=768

  $ cat /proc/$PID/sched | grep uclamp
  uclamp.min                                   :                  256
  uclamp.max                                   :                  512
  effective uclamp.min                         :                  256
  effective uclamp.max                         :                  512

With Pavan's patch, I get:

  $ uclamp-get $PID # via sched_getattr()
  uclamp.min=256 uclamp.max=768

  $ cat /proc/$PID/sched | grep uclamp
  uclamp.min                                   :                  256
  uclamp.max                                   :                  768
  effective uclamp.min                         :                  256
  effective uclamp.max                         :                  512


Minor print nit below, otherwise:
Tested-and-reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Peter/Ingo, any chance this can go to sched/urgent? I know it's a debug
interface, but I'd rather have it land in a shape that makes sense. Again,
apologies for the goof.

> ---
>  kernel/sched/debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index a562df5..239970b 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -948,8 +948,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>       P(se.avg.util_est.enqueued);
>  #endif
>  #ifdef CONFIG_UCLAMP_TASK
> -	__PS("uclamp.min", p->uclamp[UCLAMP_MIN].value);
> -	__PS("uclamp.max", p->uclamp[UCLAMP_MAX].value);
> +	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
> +	__PS("uclamp.max", p->uclamp_req[UCLAMP_MAX].value);

While we're at it, I'd prepend this with "requested".

>       __PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
>       __PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
>  #endif
