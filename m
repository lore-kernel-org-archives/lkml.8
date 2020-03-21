Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F4FC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D5620767
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584809208;
	bh=QXZ3hih49SW/eKC6b8fbzO+2xwWRjHJKDSnrNeDGG14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sSir6slRiWaBSObOFlT7V79y/mfNqRp/Lw1F1cR95UogMxun192SgbaGiB8G/ukVr
	 3dDL/wGHfxWVct0cMMcR385jDp7NaOMRQNv81WizJbuDx3IULNJNB/AKPdW1hhyphj
	 NLbT1UYvzX4gIU7nOsTtJnV3INSxZ0xOg3Xd5WXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCUQqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgCUQqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 12:46:46 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B9020732;
        Sat, 21 Mar 2020 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584809205;
        bh=QXZ3hih49SW/eKC6b8fbzO+2xwWRjHJKDSnrNeDGG14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUZCQWSF1/DW4GZCJLEg847HO6T5Rc5egzBJI7Fzez2yKIoP20OjUbqH1nttazNUK
         DNg/TRd4JW+qhyKVyUxEgtd011JN0k7sdx+bkZxzGDvM6ik7ddRImvCFQzzZxBzjCu
         HQYb9ZB+UrJClKq6UuOYwmUe7GRSr2UanSG3huQE=
Date:   Sat, 21 Mar 2020 17:46:43 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Add hrtimer context tracing bits
Message-ID: <20200321164642.GB9634@lenoir>
References: <20200321113242.534508206@linutronix.de>
 <158480602563.28353.10602717934482974041.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158480602563.28353.10602717934482974041.tip-bot2@tip-bot2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 03:53:45PM -0000, tip-bot2 for Sebastian Andrzej Siewior wrote:
> The following commit has been merged into the locking/core branch of tip:
> 
> Commit-ID:     40db173965c05a1d803451240ed41707d5bd978d
> Gitweb:        https://git.kernel.org/tip/40db173965c05a1d803451240ed41707d5bd978d
> Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate:    Sat, 21 Mar 2020 12:26:02 +01:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Sat, 21 Mar 2020 16:00:24 +01:00
> 
> lockdep: Add hrtimer context tracing bits
> 
> Set current->irq_config = 1 for hrtimers which are not marked to expire in
> hard interrupt context during hrtimer_init(). These timers will expire in
> softirq context on PREEMPT_RT.
> 
> Setting this allows lockdep to differentiate these timers. If a timer is
> marked to expire in hard interrupt context then the timer callback is not
> supposed to acquire a regular spinlock instead of a raw_spinlock in the
> expiry callback.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200321113242.534508206@linutronix.de
> ---
>  include/linux/irqflags.h | 15 +++++++++++++++
>  include/linux/sched.h    |  1 +
>  kernel/locking/lockdep.c |  2 +-
>  kernel/time/hrtimer.c    |  6 +++++-
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index fdaf286..9c17f9c 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -56,6 +56,19 @@ do {						\
>  do {						\
>  	current->softirq_context--;		\
>  } while (0)
> +
> +# define lockdep_hrtimer_enter(__hrtimer)		\
> +	  do {						\
> +		  if (!__hrtimer->is_hard)		\
> +			current->irq_config = 1;	\
> +	  } while (0)
> +
> +# define lockdep_hrtimer_exit(__hrtimer)		\
> +	  do {						\
> +		  if (!__hrtimer->is_hard)		\
> +			current->irq_config = 0;	\
> +	  } while (0)
> +
>  #else
>  # define trace_hardirqs_on()		do { } while (0)
>  # define trace_hardirqs_off()		do { } while (0)
> @@ -68,6 +81,8 @@ do {						\
>  # define trace_hardirq_exit()		do { } while (0)
>  # define lockdep_softirq_enter()	do { } while (0)
>  # define lockdep_softirq_exit()		do { } while (0)
> +# define lockdep_hrtimer_enter(__hrtimer)		do { } while (0)
> +# define lockdep_hrtimer_exit(__hrtimer)		do { } while (0)
>  #endif
>  
>  #if defined(CONFIG_IRQSOFF_TRACER) || \
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 4d3b9ec..933914c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -983,6 +983,7 @@ struct task_struct {
>  	unsigned int			softirq_enable_event;
>  	int				softirqs_enabled;
>  	int				softirq_context;
> +	int				irq_config;

There really need to be some explanation/comment/symbols to clarify
what this field is about and the meaning of the values it can take.

Thanks.
