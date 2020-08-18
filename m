Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FEAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8182075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ar1gCN2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHRKep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgHRKen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:34:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D7EC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mHn6bALr/euUa3mOQOk7fw66i+FFIoBTF7kVhAxVlYk=; b=ar1gCN2Yus0L2H9rlS1FM8cU2m
        MQoNsPLXbSqMa+JtU5UQAvXIYrJDG72QnL3VwjsADJDODfM2r13ont1Vd2UkNIPUy8pW4wOVX2CTR
        66ncCSxrwgZaeysFeWDvR9Z1n4a9B4lTJ++7IMQUQL7o7rVU5MJnI+lymzuEi54BGzdKAcly2uUlz
        V3zDQxFcVOjWI+dKEaDt0FRrpQnSoDTSPeuho8R+Dk29vonWMxcYV+GgerHWWEV6fijQuACXdmHMC
        QVNnFZXAbIZJ4mYvpYUprFsaiHuhKPOUV9pk7K4GiB/9xdus+Lpb9sH3LzY82aROktSdO099rULAu
        TeqIDD6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7ywk-0001q9-GF; Tue, 18 Aug 2020 10:34:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19298301179;
        Tue, 18 Aug 2020 12:34:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1A7C2B2C8DC8; Tue, 18 Aug 2020 12:34:24 +0200 (CEST)
Date:   Tue, 18 Aug 2020 12:34:24 +0200
From:   peterz@infradead.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, hch@lst.de,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 1/9] irq_work: Cleanup
Message-ID: <20200818103424.GQ2674@hirez.programming.kicks-ass.net>
References: <20200722150149.525408253@infradead.org>
 <20200722153017.024407984@infradead.org>
 <20200723161411.GA23103@paulmck-ThinkPad-P72>
 <20200817090325.GK2674@hirez.programming.kicks-ass.net>
 <20200817091633.GL35926@hirez.programming.kicks-ass.net>
 <20200817130005.GC23602@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817130005.GC23602@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 06:00:05AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 17, 2020 at 11:16:33AM +0200, peterz@infradead.org wrote:
> > On Mon, Aug 17, 2020 at 11:03:25AM +0200, peterz@infradead.org wrote:
> > > On Thu, Jul 23, 2020 at 09:14:11AM -0700, Paul E. McKenney wrote:
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -1287,8 +1287,6 @@ static int rcu_implicit_dynticks_qs(stru
> > > > >  		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
> > > > >  		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
> > > > >  		    (rnp->ffmask & rdp->grpmask)) {
> > > > > -			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
> > > > 
> > > > We are actually better off with the IRQ_WORK_INIT_HARD() here rather
> > > > than unconditionally at boot.
> > > 
> > > Ah, but there isn't an init_irq_work() variant that does the HARD thing.
> > 
> > Ah you meant doing:
> > 
> > 		rdp->rcu_iw = IRQ_WORK_INIT_HARD(rcu_iw_handler)
> > 
> > But then it is non-obvious how that doesn't trample state. I suppose
> > that rcu_iw_pending thing ensures that... I'll think about it.
> 
> Yes, this is what I had in mind.  And you are right, the point of the
> !rdp->rcu_iw_pending check is to prevent initialization while still
> in use.

So I checked my notes, and the plan was to replace rcu_iw_pending with
irq_work pending bit, but for that we musnt't clobber that state every
time.


