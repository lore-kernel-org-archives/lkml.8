Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A90C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9A622B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596230699;
	bh=6fS6WoCAB/9a/il66FyyY9S69DC1g+03XNy1dhsjylQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=tzaL9QG3+J5BAeMgVE/ias5go74OfIi1uU2maGGw+RsX6qo+qybxyfU5jYZPLPt1f
	 SFQB4useHgbBp5AGdhwO0DkiqWLE2k5fHaUrSc6TrpxtQLByGBpZSIXUlhhKbJ3O5u
	 D7EOdaIZ9dFBS5Mt5v26xu6g1mKmbh3cNU08TUKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgGaVY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbgGaVY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 17:24:58 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827402087C;
        Fri, 31 Jul 2020 21:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596230697;
        bh=6fS6WoCAB/9a/il66FyyY9S69DC1g+03XNy1dhsjylQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yrSee2rcqjhyFiF8+MVpPHTFv1VekHD9on3KrC9mm3AlNQ4FPdiIzVHUzL+HFYwEz
         WBABzW3rgL1L1griCUr/8BYWcjWlhlF0o+db5WZ7W6IapBHIrRhPf08D3jlJYpMpu0
         9n4FS0zBmwzFHM16VxlXaZfHUrQ9KLG5ym7qmfYk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 60F7735231D2; Fri, 31 Jul 2020 14:24:57 -0700 (PDT)
Date:   Fri, 31 Jul 2020 14:24:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        hannes@cmpxchg.org, urezki@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Raw spinlocks and memory allocation
Message-ID: <20200731212457.GS9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200730231205.GA11265@paulmck-ThinkPad-P72>
 <20200731133834.517fdfee99b7ed2239f576aa@linux-foundation.org>
 <20200731204855.GR9247@paulmck-ThinkPad-P72>
 <20200731205933.GT23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731205933.GT23808@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 09:59:33PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 31, 2020 at 01:48:55PM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 31, 2020 at 01:38:34PM -0700, Andrew Morton wrote:
> > > On Thu, 30 Jul 2020 16:12:05 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > > So, may we add a GFP_ flag that will cause kmalloc() and friends to return
> > > > NULL when they would otherwise need to acquire their non-raw spinlock?
> > > > This avoids adding any overhead to the slab-allocator fastpaths, but
> > > > allows callback invocation to reduce cache misses without having to
> > > > restructure some existing callers of call_rcu() and potential future
> > > > callers of kfree_rcu().
> > > 
> > > We have eight free gfp_t bits so that isn't a problem.
> > 
> > Whew!!!  ;-)
> > 
> > > Adding a test-n-branch to the kmalloc() fastpath may well be a concern.
> > > 
> > > Which of mm/sl?b.c are affected?
> > 
> > None of them, it turns out.  The initial patch will instead directly
> > invoke __get_free_page().  So we could just leave sl?b.c alone.
> 
> Isn't that spelled GFP_NOWAIT?

I don't think so in the current kernel, though I might be confused.

The problem we are having isn't waiting, but rather normal spinlock_t
acquisition.  This does not count as waiting in !CONFIG_PREEMPT_RT
kernels, and so there are code paths that acquire the non-raw zone_lock
in rmqueue_bulk() even in the GFP_NOWAIT case.  Because kfree_rcu()
and call_rcu() and their callers might hold raw spinlocks, acquiring a
non-raw spinlock is forbidden for them and for anything that they call,
directly or indirectly.

The reason for this restriction is that in -rt, the spin_lock(&zone->lock)
in rmqueue_bulk() can sleep.  This conversion of non-raw spinlocks
to sleeplocks is part of how -rt reduces scheduling latency.  Because
acquiring a raw spinlock disables preemption (even in -rt), acquiring
a non-raw spinlock while holding a raw spinlock gets you "scheduling
while atomic" in -rt.  And it will get you lockdep complaints in all
kernels, not just -rt, when CONFIG_PROVE_RAW_LOCK_NESTING is enabled.
And my guess is that CONFIG_PROVE_RAW_LOCK_NESTING=y will become the
default sooner rather than later.

But you are right that yet another approach might be modifying the
GFP_NOWAIT handling so that it avoided acquiring non-raw spinlocks.
However, evaluating that option requires quite a bit more knowledge of
MM than I have!  ;-)

							Thanx, Paul
