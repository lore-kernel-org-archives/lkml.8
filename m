Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BDCC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD762087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgTXBW4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgIJSxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:53:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36669 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726385AbgIJSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599763973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KkaYcC4r9CnQPKRFQbJspK1ku3ZqxcVTouDc6fHIVAg=;
        b=EgTXBW4yFKzxjxDdw8uDJb6Q4fpTvB+59k7s0Ba6ZX7EvRrCFpBswZwK0qftQftX2+w79C
        wR5VMRRSOof2Hl6ZkU6eJaEK8dTSae7fh/zvjTFGYGh9+Gzmtoqx2eqT0J3ZhMDg9pqxFR
        VXvoO4SIy1dVwlzAIlkyO0uIi1alfXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-MmffAxY7PsOXl4PCaX0n3g-1; Thu, 10 Sep 2020 14:52:51 -0400
X-MC-Unique: MmffAxY7PsOXl4PCaX0n3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D4EE80BCA1;
        Thu, 10 Sep 2020 18:52:50 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A22060BF1;
        Thu, 10 Sep 2020 18:52:50 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C252A41853FD; Thu, 10 Sep 2020 15:51:00 -0300 (-03)
Date:   Thu, 10 Sep 2020 15:51:00 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] nohz: try to avoid IPI when setting tick dependency
 for task
Message-ID: <20200910185100.GA23968@fuller.cnet>
References: <20200825184147.948670309@fuller.cnet>
 <20200825184414.486721471@fuller.cnet>
 <20200903150152.GA5353@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903150152.GA5353@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 05:01:53PM +0200, Frederic Weisbecker wrote:
> On Tue, Aug 25, 2020 at 03:41:49PM -0300, Marcelo Tosatti wrote:
> > When enabling per-CPU posix timers, an IPI to nohz_full CPUs might be
> > performed (to re-read the dependencies and possibly not re-enter
> > nohz_full on a given CPU).
> > 
> > A common case is for applications that run on nohz_full= CPUs
> > to not use POSIX timers (eg DPDK).
> > 
> > This patch optimizes tick_nohz_dep_set_task to avoid kicking
> > all nohz_full= CPUs in case the task allowed mask does not
> > intersect with nohz_full= CPU mask,
> > when going through tick_nohz_dep_set_task.
> > 
> > This reduces interruptions to nohz_full= CPUs.
> > 
> > ---
> >  kernel/time/tick-sched.c |    9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6/kernel/time/tick-sched.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/time/tick-sched.c
> > +++ linux-2.6/kernel/time/tick-sched.c
> > @@ -383,11 +383,16 @@ void tick_nohz_dep_set_task(struct task_
> >  			tick_nohz_full_kick();
> >  			preempt_enable();
> >  		} else {
> > +			unsigned long flags;
> > +
> >  			/*
> >  			 * Some future tick_nohz_full_kick_task()
> > -			 * should optimize this.
> > +			 * should further optimize this.
> >  			 */
> > -			tick_nohz_full_kick_all();
> > +			raw_spin_lock_irqsave(&tsk->pi_lock, flags);
> > +			if (cpumask_intersects(&tsk->cpus_mask, tick_nohz_full_mask))
> > +				tick_nohz_full_kick_all();
> > +			raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
> >  		}
> >  	}
> >  }
> > 
> > 
> 
> Not long ago, Peterz suggested that we simply do:
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index f0199a4ba1ad..42ce8e458013 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -357,17 +357,26 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
>  void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
>  {
>  	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {
> -		if (tsk == current) {
> -			preempt_disable();
> -			tick_nohz_full_kick();
> -			preempt_enable();
> -		} else {
> -			/*
> -			 * Some future tick_nohz_full_kick_task()
> -			 * should optimize this.
> -			 */
> -			tick_nohz_full_kick_all();
> -		}
> +		int cpu = task_cpu(tsk);
> +
> +		/*
> +		 * If the task concurrently migrates to another cpu,
> +		 * we guarantee it sees the new tick dependency upon
> +		 * schedule.
> +		 *
> +		 * set_task_cpu(p, cpu);
> +		 *   STORE p->cpu = @cpu
> +		 * __schedule() (switch to task 'p')
> +		 *   LOCK rq->lock
> +		 *   smp_mb__after_spin_lock()		STORE p->tick_dep_mask
> +		 *   tick_nohz_task_switch()		smp_mb() (atomic_fetch_or())
> +		 *      LOAD p->tick_dep_mask		LOAD p->cpu
> +		 */
> +
> +		preempt_disable();
> +		if (cpu_online(cpu))
> +			tick_nohz_full_kick_cpu(cpu);
> +		preempt_enable();
>  	}
>  }
>  EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);

This can also be used for the signal case... thanks.

