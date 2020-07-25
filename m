Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C1DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27E0206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cmEn754r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgGYRad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 13:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgGYRad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 13:30:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C646CC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Oo53oqTaeKwXbhUERILnNfy1lumfPdrAoVj1eZTxRPQ=; b=cmEn754rfARYT3zAusgJHXCYzu
        +T3KUnfRskMpaNfGkuJ6+CofiYvZ+mulXQc9YLMnS9KDRS5N45hS3Cu0lOrpMULdtcjnLt7SW53dP
        2T0miagn3FmFJnatNgdBkSPormNgugX1LbGvgi7U0RJFUaprZtLKzKNTN2zQYMWR2bdZatnj4bka4
        TB6aToS1YMFqo/VpxP2+sF+Ivj1mktvhfu5jdUtSjCGvXHBJq2h7z6witMH/iZ2sQ5DA2LH4BTwij
        iYUqgUx1WpiMyHRP3XHm/GVYV0mOiTbDIh9ALnZMn+5w27II6eKTENjCLE1Wx3316o+vS0lpAT2R3
        V5/MHH7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzNzz-0001Y4-RP; Sat, 25 Jul 2020 17:30:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 533C03013E5;
        Sat, 25 Jul 2020 19:30:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 091E92B8AA3CE; Sat, 25 Jul 2020 19:30:13 +0200 (CEST)
Date:   Sat, 25 Jul 2020 19:30:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        will@kernel.org, paulmck@kernel.org, hch@lst.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 1/9] irq_work: Cleanup
Message-ID: <20200725173012.GG10769@hirez.programming.kicks-ass.net>
References: <20200722150149.525408253@infradead.org>
 <20200722153017.024407984@infradead.org>
 <20200725115828.GA1006124@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725115828.GA1006124@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 01:58:28PM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Get rid of the __call_single_node union and clean up the API a little
> > to avoid external code relying on the structure layout as much.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  drivers/gpu/drm/i915/i915_request.c |    4 ++--
> >  include/linux/irq_work.h            |   33 +++++++++++++++++++++------------
> >  include/linux/irqflags.h            |    4 ++--
> >  kernel/bpf/stackmap.c               |    2 +-
> >  kernel/irq_work.c                   |   18 +++++++++---------
> >  kernel/printk/printk.c              |    6 ++----
> >  kernel/rcu/tree.c                   |    3 +--
> >  kernel/time/tick-sched.c            |    6 ++----
> >  kernel/trace/bpf_trace.c            |    2 +-
> >  9 files changed, 41 insertions(+), 37 deletions(-)
> > 
> > --- a/drivers/gpu/drm/i915/i915_request.c
> > +++ b/drivers/gpu/drm/i915/i915_request.c
> > @@ -196,7 +196,7 @@ __notify_execute_cb(struct i915_request
> >  
> >  	llist_for_each_entry_safe(cb, cn,
> >  				  llist_del_all(&rq->execute_cb),
> > -				  work.llnode)
> > +				  work.node.llist)
> >  		fn(&cb->work);
> >  }
> >  
> > @@ -478,7 +478,7 @@ __await_execution(struct i915_request *r
> >  	 * callback first, then checking the ACTIVE bit, we serialise with
> >  	 * the completed/retired request.
> >  	 */
> > -	if (llist_add(&cb->work.llnode, &signal->execute_cb)) {
> > +	if (llist_add(&cb->work.node.llist, &signal->execute_cb)) {
> >  		if (i915_request_is_active(signal) ||
> >  		    __request_in_flight(signal))
> >  			__notify_execute_cb_imm(signal);
> 
> Hm, so I was looking at picking up some of the low risk bits (patches #1, #2, #4)
> from this series for v5.9, but the above hunk depends non-trivially on the
> linux-next DRM tree, in particular:
> 
>   1d9221e9d395: ("drm/i915: Skip signaling a signaled request")
>   3255e00edb91: ("drm/i915: Remove i915_request.lock requirement for execution callbacks")
>   etc.
> 
> We could add it sans the i915 bits, but then we'd introduce a semantic 
> conflict in linux-next which isn't nice so close to the merge window.
> 
> One solution would be to delay this into the merge window to after the 
> DRM tree gets merged by Linus. Another would be to help out Stephen 
> with the linux-next merge.
> 
> What would be your preference?

The alternative is splitting the above change out into it's own patch
and see if Chris is willing to carry that in the DRM tree. IIRC these
'new' names should already work with the current code.

They're different names for the same field in that giant union thing.
