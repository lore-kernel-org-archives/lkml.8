Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30BEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E4920899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGBXL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:11:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:47238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgGBXLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E973BAD3A;
        Thu,  2 Jul 2020 23:11:18 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 2D8A4604BB; Fri,  3 Jul 2020 01:11:18 +0200 (CEST)
Date:   Fri, 3 Jul 2020 01:11:18 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        peterz@infradead.org, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200702231118.gjgbi64c55gf7fvf@lion.mk-sys.cz>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702213627.GF3183@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 10:36:27PM +0100, Mel Gorman wrote:
> 
> It builds, not booted, it's for discussion but maybe Dave is feeling brave!
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ca5db40392d4..52c73598b18a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2592,9 +2592,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	}
>  
>  #ifdef CONFIG_SMP
> -	p->sched_contributes_to_load = !!task_contributes_to_load(p);
> -	p->state = TASK_WAKING;
> -
>  	/*
>  	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
>  	 * possible to, falsely, observe p->on_cpu == 0.
> @@ -2650,6 +2647,13 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	 */
>  	smp_cond_load_acquire(&p->on_cpu, !VAL);
>  
> +	/*
> +	 * p is off the cpu and pi_lock is held to p->state is stable
> +	 * for calculating whether it contributes to load.
> +	 */
> +	p->sched_contributes_to_load = !!task_contributes_to_load(p);
> +	p->state = TASK_WAKING;
> +
>  	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
>  	if (task_cpu(p) != cpu) {
>  		wake_flags |= WF_MIGRATED;
> 
> -- 

I felt brave but something is probably wrong: I tried to boot three
times and all three attempts crashed during boot, all three in scheduler
related functions:

  set_next_entity()
  check_preempt_wakeup()
  finish_task_switch()

I left my USB-to-serial adapter in the office but I'll try again
tomorrow on a test machine with serial console.

Michal
