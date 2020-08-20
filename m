Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B72C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A16207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHTGTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:19:31 -0400
Received: from verein.lst.de ([213.95.11.211]:40825 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgHTGTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:19:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8397268BEB; Thu, 20 Aug 2020 08:19:27 +0200 (CEST)
Date:   Thu, 20 Aug 2020 08:19:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v2 08/10] smp,irq_work: Use the new irq_work API
Message-ID: <20200820061927.GA6447@lst.de>
References: <20200818105102.926463950@infradead.org> <20200818112418.460474861@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818112418.460474861@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:51:10PM +0200, Peter Zijlstra wrote:
>  	if (blk_mq_complete_need_ipi(rq)) {
> -		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
> -		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
> +		rq->work = IRQ_WORK_INIT_HARD(__blk_mq_complete_request_remote);
> +		irq_work_queue_remote_static(rq->mq_ctx->cpu, &rq->work);

So given the caller synchronization / use once semantics does it even
make sense to split the init vs call part here?  What about:

		irq_work_queue_remote_static(&rq->work, rq->mq_ctx->cpu,
					    __blk_mq_complete_request_remote);

instead?  And btw, I'm not sure what the "static" stand for.  Maybe
irq_work_queue_remote_once?
