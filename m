Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D00C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D404320637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E4Y/lUsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgCERYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:24:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38093 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCERYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:24:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id w3so44924plz.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mp5fWww43kwzuooPmGWsuVGO+tZOpFhcHE+Owcf1fPw=;
        b=E4Y/lUsmZXp9+AAsZa7Zo5SzTQ9O+aYrU5ndNRs7WiK1c8XxM2exp14Q62BFn1Venr
         djbBK0ms3ZbYweQUswq8VZGv8IkmQJfKAOH17R3IFd7GSLAKiPoGZsGuQ2RF56wnA37c
         sqxdD/b+BVBMNEXe4fDRy18jx9RD6LINy4hrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mp5fWww43kwzuooPmGWsuVGO+tZOpFhcHE+Owcf1fPw=;
        b=tWt5ZT9aGd/5P9cQ3xbYvtQYP532rJmrBUZkCjjeXeKcdcfJ3t0MjUJIy+nYYOqFq8
         v+iab5EZ/d+VmeNqfRRIDjvGolBzwLsG7YnxjMi1/mrjYRz/FSQC2fFFXn4aCAyihHuT
         eujMvDWz5zDVTV14DJnYL7sMNOvY9OhfYulvf0VUlkYTBWnEif7xQnVSlw1vfLboPWMP
         2oguhtjg5zhKDG/aJwfRTaxsItbgnaTV8bB/XQmk8TzqJF0AFYnkktjd4KkcOn7sAFMP
         VZ3WRMeRhoIUhK9roXwFlzhnudCKrtrQnqnib3bhjytFB/kgjCalBOtapcRsvYPej7Q5
         W6Zw==
X-Gm-Message-State: ANhLgQ0nRVToyELz641/7xNQPxsc7JnVx/ggYoxuz0FJyoTifX6PUZA+
        N+uhNpLx8FRIRLhFoDDyvYHGY05FTDc=
X-Google-Smtp-Source: ADFU+vt9l0oVbJ6VNPpaOLHDblo5TqyZNoJVjyz+Iu+6pL5xZpvRVmjo1V8vi6bgpHk7AmIq2Mfksg==
X-Received: by 2002:a17:90b:1983:: with SMTP id mv3mr9946768pjb.86.1583429072818;
        Thu, 05 Mar 2020 09:24:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t4sm10049060pfd.52.2020.03.05.09.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 09:24:31 -0800 (PST)
Date:   Thu, 5 Mar 2020 09:24:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, akpm@linux-foundation.org, tglx@linutronix.de,
        mpe@ellerman.id.au, surenb@google.com, ben.dooks@codethink.co.uk,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, luto@amacapital.net, wad@chromium.org,
        mark.rutland@arm.com, geert+renesas@glider.be,
        george_davis@mentor.com, sudeep.holla@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org, info@metux.net,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com
Subject: Re: [PATCH v2 1/1] sched/fair: do not preempt current task if it is
 going to call schedule()
Message-ID: <202003050921.5559A8C3@keescook>
References: <20200305095948.10873-1-cl@rock-chips.com>
 <20200305095948.10873-2-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305095948.10873-2-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 05:59:48PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> when we create a kthread with ktrhead_create_on_cpu(),the child thread
> entry is ktread.c:ktrhead() which will be preempted by the parent after
> call complete(done) while schedule() is not called yet,then the parent
> will call wait_task_inactive(child) but the child is still on the runqueue,
> so the parent will schedule_hrtimeout() for 1 jiffy,it will waste a lot of
> time,especially on startup.
> 
>   parent                             child
> ktrhead_create_on_cpu()
>   wait_fo_completion(&done) -----> ktread.c:ktrhead()
>                              |----- complete(done);--wakeup and preempted by parent
>  kthread_bind() <------------|  |-> schedule();--dequeue here
>   wait_task_inactive(child)     |
>    schedule_hrtimeout(1 jiffy) -|
> 
> So we hope the child just wakeup parent but not preempted by parent, and the
> child is going to call schedule() soon,then the parent will not call
> schedule_hrtimeout(1 jiffy) as the child is already dequeue.
> 
> The same issue for ktrhead_park()&&kthread_parkme().
> This patch can save 120ms on rk312x startup with CONFIG_HZ=300.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>

I'm not familiar with the subtleties of scheduler internals
(e.g. is there a race between the end of "schedule();" and calling
"task_clear_going_to_sched();" that effects the preemption test logic?),
so I'll leave that review to the others. But speaking to the PFA change,
it looks sane to me:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/sched.h |  5 +++++
>  kernel/kthread.c      |  4 ++++
>  kernel/sched/fair.c   | 13 +++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 04278493bf15..54bf336f5790 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1533,6 +1533,7 @@ static inline bool is_percpu_thread(void)
>  #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
>  #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
>  #define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
> +#define PFA_GOING_TO_SCHED		8	/* task is going to call schedule() */
>  
>  #define TASK_PFA_TEST(name, func)					\
>  	static inline bool task_##func(struct task_struct *p)		\
> @@ -1575,6 +1576,10 @@ TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
>  TASK_PFA_TEST(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
>  TASK_PFA_SET(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
>  
> +TASK_PFA_TEST(GOING_TO_SCHED, going_to_sched)
> +TASK_PFA_SET(GOING_TO_SCHED, going_to_sched)
> +TASK_PFA_CLEAR(GOING_TO_SCHED, going_to_sched)
> +
>  static inline void
>  current_restore_flags(unsigned long orig_flags, unsigned long flags)
>  {
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index b262f47046ca..bc96de2648f6 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -199,8 +199,10 @@ static void __kthread_parkme(struct kthread *self)
>  		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
>  			break;
>  
> +		task_set_going_to_sched(current);
>  		complete(&self->parked);
>  		schedule();
> +		task_clear_going_to_sched(current);
>  	}
>  	__set_current_state(TASK_RUNNING);
>  }
> @@ -245,8 +247,10 @@ static int kthread(void *_create)
>  	/* OK, tell user we're spawned, wait for stop or wakeup */
>  	__set_current_state(TASK_UNINTERRUPTIBLE);
>  	create->result = current;
> +	task_set_going_to_sched(current);
>  	complete(done);
>  	schedule();
> +	task_clear_going_to_sched(current);
>  
>  	ret = -EINTR;
>  	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3c8a379c357e..78666cec794a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4330,6 +4330,12 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>  			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>  		return;
>  #endif
> +	/*
> +	 * current task is going to call schedule(), do not preempt it or
> +	 * it will casue more useless contex_switch().
> +	 */
> +	if (task_going_to_sched(rq_of(cfs_rq)->curr))
> +		return;
>  
>  	if (cfs_rq->nr_running > 1)
>  		check_preempt_tick(cfs_rq, curr);
> @@ -6634,6 +6640,13 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  	if (test_tsk_need_resched(curr))
>  		return;
>  
> +	/*
> +	 * current task is going to call schedule(), do not preempt it or
> +	 * it will casue more useless contex_switch().
> +	 */
> +	if (task_going_to_sched(curr))
> +		return;
> +
>  	/* Idle tasks are by definition preempted by non-idle tasks. */
>  	if (unlikely(task_has_idle_policy(curr)) &&
>  	    likely(!task_has_idle_policy(p)))
> -- 
> 2.17.1
> 
> 
> 

-- 
Kees Cook
