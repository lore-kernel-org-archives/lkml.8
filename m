Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2094C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD175206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t4yX+SmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGGIR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgGGIR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:17:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1663C08C5DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z/9QmofbCyD5DwD3j2tvf7epcrAmqAcJm3QH0AKhyZo=; b=t4yX+SmL0TGYLVtGACN32AShjo
        C2t16U66BxGsFUblo+zijMQvhcD1l+wL/hIKKPWACEzx0KaxghriuJtLqIaSDRCLl9tXBUM3oNT8i
        DL36ygMZDUYwQUeIJeAA8iSsarc7nHgAs0j3ISOXN2Dz3HyUOdFa7R5ZpGTIdkfXxoZw1wBFx9RYc
        A5mwpSClUw18QQOGTBjhneZpZZIMdX8eluZs2h4lCrJA423Aft/tJYAi+Iz4uUvt+MHvgZAR+wASR
        SyyQNUsUqpsHdJ3IpOkSFIm2dizLGzHoTORSdeX9sJe0R2x4op3OeDdG1FdzUHQohCHZdTojjh9Zo
        io1ewjtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsin2-0005r1-LZ; Tue, 07 Jul 2020 08:17:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E84703013E5;
        Tue,  7 Jul 2020 10:17:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91A94213C65B5; Tue,  7 Jul 2020 10:17:19 +0200 (CEST)
Date:   Tue, 7 Jul 2020 10:17:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paul.gortmaker@windriver.com, paulmck@kernel.org
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200707081719.GK4800@hirez.programming.kicks-ass.net>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
 <20200703090226.GV4800@hirez.programming.kicks-ass.net>
 <20200703104033.GK117543@hirez.programming.kicks-ass.net>
 <20200703205153.GA19901@codemonkey.org.uk>
 <20200706145952.GB597537@hirez.programming.kicks-ass.net>
 <jhj5zb08agb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj5zb08agb.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 12:56:04AM +0100, Valentin Schneider wrote:

> > @@ -2605,8 +2596,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >        *
> >        * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
> >        * __schedule().  See the comment for smp_mb__after_spinlock().
> > +	 *
> > +	 * Form a control-dep-acquire with p->on_rq == 0 above, to ensure
> > +	 * schedule()'s deactivate_task() has 'happened' and p will no longer
> > +	 * care about it's own p->state. See the comment in __schedule().
> >        */
> > -	smp_rmb();
> > +	smp_acquire__after_ctrl_dep();
> 
> Apologies for asking again, but I'm foolishly hopeful I'll someday be able
> to grok those things without half a dozen tabs open with documentation and
> Paul McKenney papers.
> 
> Do I get it right that the 'acquire' part hints this is equivalent to
> issuing a load-acquire on whatever was needed to figure out whether or not
> the take the branch (in this case, p->on_rq, amongst other things); IOW
> ensures any memory access appearing later in program order has to happen
> after the load?
> 
> That at least explains to me the load->{load,store} wording in
> smp_acquire__after_ctrl_dep().

Yes.

So the thing is that hardware MUST NOT speculate stores, or rather, if
it does, it must take extreme measures to ensure they do not become
visible in any way shape or form, since speculative stores lead to
instant OOTA problems.

Therefore we can say that branches order stores and if the branch
condition depends on a load, we get a load->store order. IOW the load
must complete before we can resolve the branch, which in turn enables
the store to become visible/happen.

If we then add an smp_rmb() to the branch to order load->load, we end up
with a load->{load,store} ordering, which is equivalent to a
load-acquire.

The reason to do it like that, is that load-aquire would otherwise
require an smp_mb(), since for many platforms that's the only barrier
that has load->store ordering.

The down-side of doing it like this, as Paul will be quick to point out,
is that the C standard doesn't recognise control dependencies and thus
the compiler would be in its right to 'optimize' our conditional away.

We're relying on the compilers not having done this in the past and
there being sufficient compiler people interested in compiling Linux to
avoid this from happening.


Anyway, this patch is basically:

	LOAD p->state		LOAD-ACQUIRE p->on_rq == 0
	MB
	STORE p->on_rq, 0	STORE p->state, TASK_WAKING

which ensures the TASK_WAKING store happens after the p->state load.
Just a wee bit complicated due to not actually adding any barriers while
adding additional ordering.

Anyway, let me now endeavour to write a coherent Changelog for this mess
:-(
