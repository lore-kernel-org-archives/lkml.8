Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFCBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC9A2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZQI1/jsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgHQJDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgHQJDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:03:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C5AC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LYBZx3KQuv7ApO3hpLxpQgXwKNCku2UgvV7NAm4UvVg=; b=ZQI1/jsb0vPedK7MwW8XBDozPy
        f8oh3o6qLiZU2JSNpd+Y/kyeVdYswjIr71PR2vTkyh/1zgZoadcLVfQhDsX9swwmyF4uF5k8qKiyT
        kxS5WYNiCW6cPUWL8CHAqNATzBbYSJTF+dqW8Ij3s72fj+EmHdLbFbxeChqcAjaTuAyz8yXvschk1
        w45p5dT0C1nTepqu+QFFeTcCA7lhPI7C8MgrVaK+LE1Ud+P6pjzx+sTX1PI2YTFVbvGiLbHaCMl12
        ulFz7afU7mNXTnq5TgkoScwWQiyHJ0MxWiI9y5ck92qZuEkAqD+WHA8kou17yOhdApbtUahr+0RLS
        QcistZog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7b38-0000Tv-Ip; Mon, 17 Aug 2020 09:03:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 782F33060F2;
        Mon, 17 Aug 2020 11:03:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C569200D4C23; Mon, 17 Aug 2020 11:03:25 +0200 (CEST)
Date:   Mon, 17 Aug 2020 11:03:25 +0200
From:   peterz@infradead.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, hch@lst.de,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 1/9] irq_work: Cleanup
Message-ID: <20200817090325.GK2674@hirez.programming.kicks-ass.net>
References: <20200722150149.525408253@infradead.org>
 <20200722153017.024407984@infradead.org>
 <20200723161411.GA23103@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723161411.GA23103@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 09:14:11AM -0700, Paul E. McKenney wrote:
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1287,8 +1287,6 @@ static int rcu_implicit_dynticks_qs(stru
> >  		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
> >  		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
> >  		    (rnp->ffmask & rdp->grpmask)) {
> > -			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
> 
> We are actually better off with the IRQ_WORK_INIT_HARD() here rather
> than unconditionally at boot.

Ah, but there isn't an init_irq_work() variant that does the HARD thing.

> The reason for this is that we get here only if a single grace
> period extends beyond 10.5 seconds (mainline) or beyond 30 seconds
> (many distribution kernels).  Which almost never happens.  And yes,
> rcutree_prepare_cpu() is also invoked as each CPU that comes online,
> not that this is all that common outside of rcutorture and boot time.  ;-)

What do you mean 'also' ? Afaict this is CPU bringup only code (initial
and hotplug). We really don't care about code there. It's the slowest
possible path we have in the kernel.

> > -			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
> >  			rdp->rcu_iw_pending = true;
> >  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
> >  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);

