Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAE5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC7F20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCFRJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:09:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFRJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:09:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF7020658;
        Fri,  6 Mar 2020 17:09:46 +0000 (UTC)
Date:   Fri, 6 Mar 2020 12:09:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <cl@rock-chips.com>
Cc:     heiko@sntech.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        akpm@linux-foundation.org, tglx@linutronix.de, mpe@ellerman.id.au,
        surenb@google.com, ben.dooks@codethink.co.uk,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, mark.rutland@arm.com, geert+renesas@glider.be,
        george_davis@mentor.com, sudeep.holla@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org, info@metux.net,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com
Subject: Re: [PATCH v3 1/1] kthread: do not preempt current task if it is
 going to call schedule()
Message-ID: <20200306120945.6a197172@gandalf.local.home>
In-Reply-To: <20200306070133.18335-2-cl@rock-chips.com>
References: <20200306070133.18335-1-cl@rock-chips.com>
        <20200306070133.18335-2-cl@rock-chips.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Mar 2020 15:01:33 +0800
<cl@rock-chips.com> wrote:

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
> ---
>  kernel/kthread.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index b262f47046ca..bfbfa481be3a 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -199,8 +199,15 @@ static void __kthread_parkme(struct kthread *self)
>  		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
>  			break;
>  
> +		/*
> +		 * Thread is going to call schedule(), do not preempt it,
> +		 * or the caller of kthread_park() may spend more time in
> +		 * wait_task_inactive().
> +		 */
> +		preempt_disable();
>  		complete(&self->parked);

I first was concerned that this could break PREEMPT_RT, as complete() calls
spin_locks() which are turned into sleeping locks when PREEMPT_RT is
enabled. But looking at the latest PREEMPT_RT patch, it appears that it
converts the locks in complete() into raw_spin_locks (and using swake).

I don't see any other issue with this patch.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> -		schedule();
> +		schedule_preempt_disabled();
> +		preempt_enable();
>  	}
>  	__set_current_state(TASK_RUNNING);
>  }
> @@ -245,8 +252,14 @@ static int kthread(void *_create)
>  	/* OK, tell user we're spawned, wait for stop or wakeup */
>  	__set_current_state(TASK_UNINTERRUPTIBLE);
>  	create->result = current;
> +	/*
> +	 * Thread is going to call schedule(), do not preempt it,
> +	 * or the creator may spend more time in wait_task_inactive().
> +	 */
> +	preempt_disable();
>  	complete(done);
> -	schedule();
> +	schedule_preempt_disabled();
> +	preempt_enable();
>  
>  	ret = -EINTR;
>  	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {

