Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A7AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D65A2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="goDJz4bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFQJBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:01:47 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47770C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wlh6R0sQPmbdqr43idqW5du7F6L7VCF5q+/+WBspNAc=; b=goDJz4bPgaNGynbcncd1CBXD2/
        yjTzR6QVU92sZg5j/GKDO018cIX0cy1E1hX2nHbgdX8bEQ0V+3ZWIhGIVJmTzkR3gJoNDHDHuXvfv
        jIzBXCxrZ5cEjei6iqhNvY/GaxyrH06pRMSGf8W2rUzR9BP92u5KXwaL2TP/C6mJW6OSwP/ZIWTXp
        f7vkS+RHWzIhgfNKp1nmhPrVtJDhKxMQl8clI6dJT9PLSwvFHitQw5WUfPBZ8bmHQVV8ZgxIT1wnq
        I+dC+BPJMbwIh8FZeV6qvFpjAEVKJY7+ejRLQjgA3rwC3Aim+YvjASKgfrOH5agelcjloTcRd98Gt
        6fVC5oTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlTwD-0007YN-Qo; Wed, 17 Jun 2020 09:00:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A163300238;
        Wed, 17 Jun 2020 11:00:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19CB729E5A2EF; Wed, 17 Jun 2020 11:00:51 +0200 (CEST)
Date:   Wed, 17 Jun 2020 11:00:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, frederic@kernel.org,
        tsbogend@alpha.franken.de, axboe@kernel.dk, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, dchickles@marvell.com,
        davem@davemloft.net, kuba@kernel.org, daniel.thompson@linaro.org,
        gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 6/6] smp: Cleanup smp_call_function*()
Message-ID: <20200617090051.GF2531@hirez.programming.kicks-ass.net>
References: <20200615125654.678940605@infradead.org>
 <20200615131143.434079683@infradead.org>
 <20200617082349.GA19894@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617082349.GA19894@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:23:49AM -0700, Christoph Hellwig wrote:
> > -static DEFINE_PER_CPU(call_single_data_t, backtrace_csd);
> > +static DEFINE_PER_CPU(call_single_data_t, backtrace_csd) = CSD_INIT(handle_backtrace, NULL);
> >  static struct cpumask backtrace_csd_busy;
> 
> Besides the crazy long line: does assigning to a DEFINE_PER_CPU
> really work and initialize all the members?

Yes. The way it works is that it initializes the variable that ends up
in the .data..percpu section and that's copied when we create the
actual per-cpu things.

> > @@ -178,9 +178,7 @@ static void zpci_handle_fallback_irq(voi
> >  		if (atomic_inc_return(&cpu_data->scheduled) > 1)
> >  			continue;
> >  
> > -		cpu_data->csd.func = zpci_handle_remote_irq;
> > -		cpu_data->csd.info = &cpu_data->scheduled;
> > -		cpu_data->csd.flags = 0;
> > +		cpu_data->csd = CSD_INIT(zpci_handle_remote_irq, &cpu_data->scheduled);
> 
> This looks weird.  I'd much rather see an initialization ala INIT_WORK:
> 
> 		INIT_CSD(&cpu_data->csd, zpci_handle_remote_irq,
> 			 &cpu_data->scheduled);
> 
> Also for many smp_call_function_* users it would be trivial and actually
> lead to nicer code if the data argument went away and we'd just use
> container_of to get to the containing structure.  For the remaining
> ones we can trivially general a container strucuture that has the
> extra data pointer.

Agreed, except that won't work for things like cfd_data, csd_data and
csd_stack in smp.c. It might be possible to rework some of that, but
that's going to be further surgery.

> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -629,9 +629,7 @@ void blk_mq_force_complete_rq(struct req
> >  		shared = cpus_share_cache(cpu, ctx->cpu);
> >  
> >  	if (cpu != ctx->cpu && !shared && cpu_online(ctx->cpu)) {
> > -		rq->csd.func = __blk_mq_complete_request_remote;
> > -		rq->csd.info = rq;
> > -		rq->csd.flags = 0;
> > +		rq->csd = CSD_INIT(__blk_mq_complete_request_remote, rq);
> >  		smp_call_function_single_async(ctx->cpu, &rq->csd);
> >  	} else {
> >  		q->mq_ops->complete(rq);
> > --- a/block/blk-softirq.c
> > +++ b/block/blk-softirq.c
> > @@ -57,13 +57,8 @@ static void trigger_softirq(void *data)
> >  static int raise_blk_irq(int cpu, struct request *rq)
> >  {
> >  	if (cpu_online(cpu)) {
> > -		call_single_data_t *data = &rq->csd;
> > -
> > -		data->func = trigger_softirq;
> > -		data->info = rq;
> > -		data->flags = 0;
> > -
> > -		smp_call_function_single_async(cpu, data);
> > +		rq->csd = CSD_INIT(trigger_softirq, rq);
> > +		smp_call_function_single_async(cpu, &rq->csd);
> >  		return 0;
> >  	}
> 
> FYI, I rewrote much of the blk code in this series:
> 
> https://lore.kernel.org/linux-block/20200611064452.12353-1-hch@lst.de/T/#t
> 
> that you also were Cced on.

Yes, I know. The merge shouldn't be too difficult, but if that's landed
in a git tree meanwhile, I can try and pull that in.

> >  struct __call_single_data {
> > -	union {
> > -		struct __call_single_node node;
> > -		struct {
> > -			struct llist_node llist;
> > -			unsigned int flags;
> > -		};
> > -	};
> > +	struct __call_single_node node;
> >  	smp_call_func_t func;
> >  	void *info;
> >  };
> 
> Can we rename this to struct call_single_data without the __prefix
> and switch all the users you touch anyway away from the typedef?

That mess exists because of the alignment thing. IIRC you can't use the
sizeof() of a struct you're still declaring.
