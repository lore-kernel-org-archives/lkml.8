Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3872BC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144DB2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HHY7+2ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgHQJRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHQJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:17:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651BBC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yq/G/7azxwsTAMVI9n5yMwPxsdFTF2npCDkTU+EjKoI=; b=HHY7+2adY5BXeFqlVq8Il/j7Br
        n3v5DL8IOZjsWn8EV3VFgQbzQHTt11yLSRgXbTwfuyddobsmK0VO+OPo9E7P7ZRtgl/61NaHiRVQn
        BJUS4mx40tSS+FTp58TW4n+okabHFGwTSfzuOjNonRPnBw7UoZbMcEwqUlfFenNuTDqI4COenPq0L
        oiGuR2ivdp8hfnfL5n4YXHjmU6m+nU3McDJuDgZ5nQD54mtV5fl7RkOv7drSwhPTNDNqh3Fh0/9fN
        3vTpDcSjrUdnziYDi6nmjEYOcRjOT+vjfl4mLpPdBI2U7xbdKeYH8BLh3h5duSMAnIveY4wNZXlmf
        uVKUDylA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7bFs-0001jE-IF; Mon, 17 Aug 2020 09:17:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CEAD9301179;
        Mon, 17 Aug 2020 11:16:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FBD7200D4C2E; Mon, 17 Aug 2020 11:16:33 +0200 (CEST)
Date:   Mon, 17 Aug 2020 11:16:33 +0200
From:   peterz@infradead.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, hch@lst.de,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 1/9] irq_work: Cleanup
Message-ID: <20200817091633.GL35926@hirez.programming.kicks-ass.net>
References: <20200722150149.525408253@infradead.org>
 <20200722153017.024407984@infradead.org>
 <20200723161411.GA23103@paulmck-ThinkPad-P72>
 <20200817090325.GK2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817090325.GK2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:03:25AM +0200, peterz@infradead.org wrote:
> On Thu, Jul 23, 2020 at 09:14:11AM -0700, Paul E. McKenney wrote:
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1287,8 +1287,6 @@ static int rcu_implicit_dynticks_qs(stru
> > >  		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
> > >  		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
> > >  		    (rnp->ffmask & rdp->grpmask)) {
> > > -			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
> > 
> > We are actually better off with the IRQ_WORK_INIT_HARD() here rather
> > than unconditionally at boot.
> 
> Ah, but there isn't an init_irq_work() variant that does the HARD thing.

Ah you meant doing:

		rdp->rcu_iw = IRQ_WORK_INIT_HARD(rcu_iw_handler)

But then it is non-obvious how that doesn't trample state. I suppose
that rcu_iw_pending thing ensures that... I'll think about it.

> > The reason for this is that we get here only if a single grace
> > period extends beyond 10.5 seconds (mainline) or beyond 30 seconds
> > (many distribution kernels).  Which almost never happens.  And yes,
> > rcutree_prepare_cpu() is also invoked as each CPU that comes online,
> > not that this is all that common outside of rcutorture and boot time.  ;-)
> 
> What do you mean 'also' ? Afaict this is CPU bringup only code (initial
> and hotplug). We really don't care about code there. It's the slowest
> possible path we have in the kernel.
> 
> > > -			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
> > >  			rdp->rcu_iw_pending = true;
> > >  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
> > >  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
> 
