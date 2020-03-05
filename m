Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483EAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF962146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kKygSQHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCEInp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:43:45 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51876 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgCEIno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:43:44 -0500
Received: by mail-pj1-f65.google.com with SMTP id l8so2197144pjy.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 00:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qLIiVnETYMcqyHUOB6dvtW3Moz4oU4X9cKVTwd3yA8c=;
        b=kKygSQHPXYjoLnwA1ga7lbOBuQ4B3qVXZyngHi+LC2o/VaTyQJhD2EXZzU+PSc4Gea
         K9zNUJb3/BW522ytiVZy8nwiz7YBFZn0khKA7/wpVRIpczVueTClG2kIBR5cd+Hv/RAm
         g5KAEkrBoRpzRyT6cnQHxzoaMdHwGqTmk1oNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qLIiVnETYMcqyHUOB6dvtW3Moz4oU4X9cKVTwd3yA8c=;
        b=klH3eAW6vwaLW4+zpM1fXtn2zgR1Xkh+vpWU26mKvIZ9xBJ6wj66geuArPw5AesHaQ
         Ch7ilPZ0vklgP0ubeQ3ldCLxHVBwDCwjA8Ex65U2m4DZggw28w37x+fjQEEoOjOnYx94
         ryYNzIit9ihAY7ndcH2rN4C5aYMmhiaMEcIF0YMNglpijGkCX3qvhWlXRNjQbDfJbxrE
         nBqq4K/hw9UeLgxsxeaQwZWMVPtk/dFYD0ZT0HCuaokCJCWhrJOuNPQ3iSQSLi0iPUrO
         c92s2Cv+XYODynFP539ekVGfs2B1e+TkqU1Xsc3Ej7zutUVcfJvGgXBOzocPzwZtBniW
         LjXw==
X-Gm-Message-State: ANhLgQ2Cmspu5BQ1TDFpTLpMKkSG786TaFVSbwbFtkNS74Be/q2zK+Xv
        HARgS0eXsdXRJjCq4CAuWFn1pA==
X-Google-Smtp-Source: ADFU+vs0xirHyYZLefNjWviL/3XiwrLplDXNizVgNsIp9KLNwQSGoVUke+T4UGkcqzcArx8rmnRr4w==
X-Received: by 2002:a17:902:8f94:: with SMTP id z20mr7209601plo.62.1583397823273;
        Thu, 05 Mar 2020 00:43:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r125sm3807907pfc.79.2020.03.05.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 00:43:42 -0800 (PST)
Date:   Thu, 5 Mar 2020 00:43:41 -0800
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
Subject: Re: [PATCH v1 1/1] sched/fair: do not preempt current task if it is
 going to call schedule()
Message-ID: <202003050031.27889B4@keescook>
References: <20200305081611.29323-1-cl@rock-chips.com>
 <20200305081611.29323-2-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305081611.29323-2-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 04:16:11PM +0800, cl@rock-chips.com wrote:
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

Interesting improvement!

> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  arch/arm/include/asm/thread_info.h   |  1 +
>  arch/arm64/include/asm/thread_info.h |  1 +
>  include/linux/sched.h                | 15 +++++++++++++++
>  kernel/kthread.c                     |  4 ++++
>  kernel/sched/fair.c                  |  4 ++++
>  5 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index 0d0d5178e2c3..51802991ba1f 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -145,6 +145,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>  #define TIF_USING_IWMMXT	17
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>  #define TIF_RESTORE_SIGMASK	20
> +#define TIF_GOING_TO_SCHED	27	/* task is going to call schedule() */
>  
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index f0cec4160136..332786f11dc3 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -78,6 +78,7 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
>  #define TIF_SSBD		25	/* Wants SSB mitigation */
>  #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
> +#define TIF_GOING_TO_SCHED	27	/* task is going to call schedule() */
>  
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)

I don't think you want a TIF flag for this (they're used in special
places, especially in entry code, etc). Since you're only changing
"normal" C code, I would suggest a atomic_flags addition instead:

#define PFA_GOING_TO_SCHED	8
...
TASK_PFA_TEST(GOING_TO_SCHED, going_to_sched)
TASK_PFA_SET(GOING_TO_SCHED, going_to_sched)
TASK_PFA_CLEAR(GOING_TO_SCHED, going_to_sched)

(Also if you used TIF, you'd need to add the TIF to every architecture
to use it in the common scheduler code, which too much work.)

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 04278493bf15..cb9058d2cf0b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1768,6 +1768,21 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
>  	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
>  }
>  
> +static inline void set_tsk_going_to_sched(struct task_struct *tsk)
> +{
> +	set_tsk_thread_flag(tsk, TIF_GOING_TO_SCHED);
> +}
> +
> +static inline void clear_tsk_going_to_sched(struct task_struct *tsk)
> +{
> +	clear_tsk_thread_flag(tsk, TIF_GOING_TO_SCHED);
> +}
> +
> +static inline int test_tsk_going_to_sched(struct task_struct *tsk)
> +{
> +	return unlikely(test_tsk_thread_flag(tsk, TIF_GOING_TO_SCHED));
> +}

Then you can drop these wrappers since you'll have the test/set/clear
functions declared above (task_set/clear_going_to_sched(),
task_going_to_sched()) with the TASK_PFA... macros.

> +
>  /*
>   * cond_resched() and cond_resched_lock(): latency reduction via
>   * explicit rescheduling in places that are safe. The return
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index b262f47046ca..8a4e4c9cdc22 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -199,8 +199,10 @@ static void __kthread_parkme(struct kthread *self)
>  		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
>  			break;
>  
> +		set_tsk_going_to_sched(current);

task_set_going_to_sched(current);

>  		complete(&self->parked);
>  		schedule();
> +		clear_tsk_going_to_sched(current);

task_clear_going_to_sched(current);

>  	}
>  	__set_current_state(TASK_RUNNING);
>  }
> @@ -245,8 +247,10 @@ static int kthread(void *_create)
>  	/* OK, tell user we're spawned, wait for stop or wakeup */
>  	__set_current_state(TASK_UNINTERRUPTIBLE);
>  	create->result = current;
> +	set_tsk_going_to_sched(current);
>  	complete(done);
>  	schedule();
> +	clear_tsk_going_to_sched(current);

etc.

>  
>  	ret = -EINTR;
>  	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3c8a379c357e..28a308743bf8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4330,6 +4330,8 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>  			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>  		return;
>  #endif
> +	if (test_tsk_going_to_sched(rq_of(cfs_rq)->curr))
> +		return;

if (unlikely(task_going_to_sched(rq_of(cfs_rq)->curr)))
	return;

>  
>  	if (cfs_rq->nr_running > 1)
>  		check_preempt_tick(cfs_rq, curr);
> @@ -6633,6 +6635,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  	 */
>  	if (test_tsk_need_resched(curr))
>  		return;
> +	if (test_tsk_going_to_sched(curr))
> +		return;

same.

>  
>  	/* Idle tasks are by definition preempted by non-idle tasks. */
>  	if (unlikely(task_has_idle_policy(curr)) &&
> -- 
> 2.17.1
> 
> 
> 

I'd add comments above each of the "return" cases to help people
understand why the test is important.

-- 
Kees Cook
