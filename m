Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429AFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A112070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGXVqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgGXVqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:46:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B965B206E3;
        Fri, 24 Jul 2020 21:46:21 +0000 (UTC)
Date:   Fri, 24 Jul 2020 17:46:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peterz@infradead.org
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, sfr@canb.auug.org.au
Subject: Re: [PATCH] sched,tracing: Convert to sched_set_fifo()
Message-ID: <20200724174618.7487ee7c@oasis.local.home>
In-Reply-To: <20200724213911.GX119549@hirez.programming.kicks-ass.net>
References: <202006192249.AYnVBGCH%lkp@intel.com>
        <20200709124505.GT597537@hirez.programming.kicks-ass.net>
        <20200709115818.36a956a4@oasis.local.home>
        <20200720214918.GM5523@worktop.programming.kicks-ass.net>
        <20200724213911.GX119549@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 23:39:11 +0200
peterz@infradead.org wrote:

> On Mon, Jul 20, 2020 at 11:49:18PM +0200, Peter Zijlstra wrote:
> > Steve, would this work for you, or would you prefer renaming the
> > parameters as well?  
> 
> Steve mentioned he's like to have the parameters changes after all.
> How's this then?
> 
> ---
> Subject: sched,tracing: Convert to sched_set_fifo()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon, 20 Jul 2020 23:49:18 +0200
> 
> One module user of sched_setscheduler() was overlooked and is
> obviously causing build failures.
> 
> Convert ring_buffer_benchmark to use sched_set_fifo_low() when fifo==1
> and sched_set_fifo() when fifo==2. This is a bit of an abuse, but it
> makes the thing 'work' again.
> 
> Specifically, it enables all combinations that were previously
> possible:
> 
>   producer higher than consumer
>   consumer higher than producer
> 
> Fixes: 616d91b68cd5 ("sched: Remove sched_setscheduler*() EXPORTs")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/trace/ring_buffer_benchmark.c |   48 ++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 25 deletions(-)
> 
> --- a/kernel/trace/ring_buffer_benchmark.c
> +++ b/kernel/trace/ring_buffer_benchmark.c
> @@ -45,8 +45,8 @@ MODULE_PARM_DESC(write_iteration, "# of
>  static int producer_nice = MAX_NICE;
>  static int consumer_nice = MAX_NICE;
>  
> -static int producer_fifo = -1;
> -static int consumer_fifo = -1;
> +static int producer_fifo = 0;
> +static int consumer_fifo = 0;

The initialization of zero for static variables isn't needed.

>  
>  module_param(producer_nice, int, 0644);
>  MODULE_PARM_DESC(producer_nice, "nice prio for producer");
> @@ -55,10 +55,10 @@ module_param(consumer_nice, int, 0644);
>  MODULE_PARM_DESC(consumer_nice, "nice prio for consumer");
>  
>  module_param(producer_fifo, int, 0644);
> -MODULE_PARM_DESC(producer_fifo, "fifo prio for producer");
> +MODULE_PARM_DESC(producer_fifo, "use fifo for producer: 0 - disabled, 1 - low prio, 2 - fifo");
>  
>  module_param(consumer_fifo, int, 0644);
> -MODULE_PARM_DESC(consumer_fifo, "fifo prio for consumer");
> +MODULE_PARM_DESC(consumer_fifo, "use fifo for consumer: 0 - disabled, 1 - low prio, 2 - fifo");
>  
>  static int read_events;
>  
> @@ -303,22 +303,22 @@ static void ring_buffer_producer(void)
>  		trace_printk("ERROR!\n");
>  
>  	if (!disable_reader) {
> -		if (consumer_fifo < 0)
> -			trace_printk("Running Consumer at nice: %d\n",
> -				     consumer_nice);
> -		else
> +		if (consumer_fifo)
>  			trace_printk("Running Consumer at SCHED_FIFO %d\n",
>  				     consumer_fifo);

Can we change the above to:

			trace_printk("Running Consumer at SCHED_FIFO %s\n",
					consumer_fifo == 1 ? "low" : "high");

> +		else
> +			trace_printk("Running Consumer at nice: %d\n",
> +				     consumer_nice);
>  	}
> -	if (producer_fifo < 0)
> -		trace_printk("Running Producer at nice: %d\n",
> -			     producer_nice);
> -	else
> +	if (producer_fifo)
>  		trace_printk("Running Producer at SCHED_FIFO %d\n",
>  			     producer_fifo);

Same here.

> +	else
> +		trace_printk("Running Producer at nice: %d\n",
> +			     producer_nice);
>  
>  	/* Let the user know that the test is running at low priority */
> -	if (producer_fifo < 0 && consumer_fifo < 0 &&
> +	if (!producer_fifo && !consumer_fifo &&
>  	    producer_nice == MAX_NICE && consumer_nice == MAX_NICE)
>  		trace_printk("WARNING!!! This test is running at lowest priority.\n");
>  
> @@ -455,21 +455,19 @@ static int __init ring_buffer_benchmark_
>  	 * Run them as low-prio background tasks by default:
>  	 */
>  	if (!disable_reader) {
> -		if (consumer_fifo >= 0) {
> -			struct sched_param param = {
> -				.sched_priority = consumer_fifo
> -			};
> -			sched_setscheduler(consumer, SCHED_FIFO, &param);
> -		} else
> +		if (consumer_fifo == 2)

Let's make this be:

		if (consumer_fifo > 1)

Then if someone sends in 3 it doesn't go low again.

> +			sched_set_fifo(consumer);
> +		else if (consumer_fifo == 1)
> +			sched_set_fifo_low(consumer);
> +		else
>  			set_user_nice(consumer, consumer_nice);
>  	}
>  
> -	if (producer_fifo >= 0) {
> -		struct sched_param param = {
> -			.sched_priority = producer_fifo
> -		};
> -		sched_setscheduler(producer, SCHED_FIFO, &param);
> -	} else
> +	if (producer_fifo == 2)

Same here.

-- Steve

> +		sched_set_fifo(producer);
> +	else if (producer_fifo == 1)
> +		sched_set_fifo_low(producer);
> +	else
>  		set_user_nice(producer, producer_nice);
>  
>  	return 0;

