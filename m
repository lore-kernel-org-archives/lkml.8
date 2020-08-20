Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751DCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527D022BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ht5gtNDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgHTNqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbgHTNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:40:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC072C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7LhfTKr/6e64b8f6hHsV3cvhzdJCa8nrqjNCiRKjWo=; b=ht5gtNDT2NQZYe0CQtBrRTqED7
        rT6HAsJ5h0qOe1WgVmpqvxXibeM5KfYyR5d47CDCT7hOuJfTixAT4a7gj64V3iVbion/QGrFXQLcN
        2n6R/BNgMypzS6rssVVTrM4BtO8hG5GZFce2p+xbtUBn3IWUPK74jsMJkX17dtaaY+OZhRiasQn5p
        hJUTenjorBK8m6ByBV5ltRW3WJl5jM2y79cKdE4Iw9xAdV2lQwHwObMnkY2VX1mIyFVZDcFpwLqjo
        c2IOHzv3p09atfkzHAY36qQhOQ5mZ4n+fYofow1XetxmO93zCLwSFGEQIN6vokI7vPyGkbuFgyxvJ
        tlMrt3Ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8knT-0005Uz-GU; Thu, 20 Aug 2020 13:40:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06307302526;
        Thu, 20 Aug 2020 15:40:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1D902BE72362; Thu, 20 Aug 2020 15:40:01 +0200 (CEST)
Date:   Thu, 20 Aug 2020 15:40:01 +0200
From:   peterz@infradead.org
To:     Christoph Hellwig <hch@lst.de>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com,
        vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v2 08/10] smp,irq_work: Use the new irq_work API
Message-ID: <20200820134001.GV2674@hirez.programming.kicks-ass.net>
References: <20200818105102.926463950@infradead.org>
 <20200818112418.460474861@infradead.org>
 <20200820061927.GA6447@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820061927.GA6447@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 08:19:27AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 12:51:10PM +0200, Peter Zijlstra wrote:
> >  	if (blk_mq_complete_need_ipi(rq)) {
> > -		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
> > -		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
> > +		rq->work = IRQ_WORK_INIT_HARD(__blk_mq_complete_request_remote);
> > +		irq_work_queue_remote_static(rq->mq_ctx->cpu, &rq->work);
> 
> So given the caller synchronization / use once semantics does it even
> make sense to split the init vs call part here?  What about:
> 
> 		irq_work_queue_remote_static(&rq->work, rq->mq_ctx->cpu,
> 					    __blk_mq_complete_request_remote);
> 
> instead?  And btw, I'm not sure what the "static" stand for.  Maybe
> irq_work_queue_remote_once?

The 'static' came from static storage, but I agree that the naming is
pretty random/poor.

One argument against your proposal is that it makes it even harder to
add warnings that try and catch bad/broken usage.

Also, given Linus' email I now wonder if we still want the
irq_work_remote variant at all.


So the initial use-case was something like:

struct foo {
	struct irq_work work;
	...
};

void foo_func(struct irq_work *work)
{
	struct foo *f = container_of(work, struct foo, work);

	...
}

DEFINE_PER_CPU(struct foo, foo) = IRQ_WORK_INIT_HARD(foo_func);

void raise_foo(int cpu)
{
	irq_work_queue_remote(per_cpu_ptr(&foo, cpu), cpu);
}

Where you can, with IRQs disabled, call raise_foo(cpu) for a remote CPU
and have the guarantee that foo_func() will observe whatever you did
before calling raise_foo().

Specifically, I needed this for what is now __ttwu_queue_wakelist(),
which used to rely on smp_send_reschedule() but needed to be pulled out
of the regular scheduler IPI.

While sorting through the wreckage of me getting this horribly wrong, I
noticed that generic_smp_call_function_single_interrupt() was
unconditionally loading _2_ cachelines, one for the regular CSD llist
and one for the remote irq_work llist.

I then realized we could merge those two lists, and regain the original
intent of that IPI to only touch one line.

At that point I could build the above, but then I realized that since I
already had a mixed type list, I could put the ttwu entries on it as
well, which is cheaper than doing the above.


Anyway, tl;dr, what do we actually want? Do we favour the embedded
irq_work variant over smp_call_function_single_asyn() ?

There's a few subtle differences, where smp_call_function_single_async()
will directly call @func when @cpu == smp_processor_id(),
irq_work_remote will give you WARN -- since irq_work to the local CPU is
defined as a self-IPI, which isn't implemented on all architectures and
is a distinctly different behaviour.

That said, most (if not all) users seem to actually only care about
running things on another CPU, so that seems to not matter (much).



