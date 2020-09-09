Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC64C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0FA206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgIIIFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:05:54 -0400
Received: from verein.lst.de ([213.95.11.211]:56254 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730079AbgIIIDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:03:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FC0468B02; Wed,  9 Sep 2020 10:03:37 +0200 (CEST)
Date:   Wed, 9 Sep 2020 10:03:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     peterz@infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        will@kernel.org, paulmck@kernel.org, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v2 08/10] smp,irq_work: Use the new irq_work API
Message-ID: <20200909080336.GA12376@lst.de>
References: <20200818105102.926463950@infradead.org> <20200818112418.460474861@infradead.org> <20200820061927.GA6447@lst.de> <20200820134001.GV2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820134001.GV2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 03:40:01PM +0200, peterz@infradead.org wrote:
> Anyway, tl;dr, what do we actually want? Do we favour the embedded
> irq_work variant over smp_call_function_single_asyn() ?

For blk-mq we really like an embedded structure that allows to bounce
the work to another CPU using IPIs.

> There's a few subtle differences, where smp_call_function_single_async()
> will directly call @func when @cpu == smp_processor_id(),
> irq_work_remote will give you WARN -- since irq_work to the local CPU is
> defined as a self-IPI, which isn't implemented on all architectures and
> is a distinctly different behaviour.

For the block code we handle the self case explicitly as it allows us
to optimize further and avoid an indirect call.  That being said we
don't do a preempt_disable for that any more, as completing on the
"wrong" CPU for a just migrated completion handler is at worst a
performance degration but not a functional issue.  So instead of the
warn we'd at least like an error return that allows to directly call
the completion handler.
