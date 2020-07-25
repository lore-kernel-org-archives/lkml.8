Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5493DC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 22:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3303C2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 22:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595714873;
	bh=AlMyIIkUYdkMEf9k/MgUwkj3Brxoh7KvszXwKDV1774=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=oG6befAFh22Hn5ynQhhYOMLOn06pRt5Y37L4Q/MYRWebl60TtdAGFXqRm5oE/GfLo
	 yUiUhEhveP04NdzEOK18z1InH6upvf/QIelmjlB1ht+zLTvvcAFT2erh+PCaBle/EW
	 6MJhdKYegXu5BNiYDkmND9KdnCbHIxj5+K4jcN+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGYWHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 18:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgGYWHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 18:07:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 758AC20663;
        Sat, 25 Jul 2020 22:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595714870;
        bh=AlMyIIkUYdkMEf9k/MgUwkj3Brxoh7KvszXwKDV1774=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=efq8CSlTgBFCRntwHutc9xUTzBypUSo8HSNxGPySj1yWeFPRQKWzPe6cjctCFMOR4
         Pv0cTU1pqBF22dVZkp28B6x7WLs6AuE3XXslgX8/zDzijVD0zkM0Lg9e5pCpOMdA1/
         O6W0mUCe7XGXx4ZrutPB/7RzyhddqagNsXpv3aqc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 427EE3522767; Sat, 25 Jul 2020 15:07:50 -0700 (PDT)
Date:   Sat, 25 Jul 2020 15:07:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcsan: Add option to allow watcher interruptions
Message-ID: <20200725220750.GC9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200220141551.166537-1-elver@google.com>
 <20200220185855.GY2935@paulmck-ThinkPad-P72>
 <20200220213317.GA35033@google.com>
 <20200725145623.GZ9247@paulmck-ThinkPad-P72>
 <CANpmjNPhuvrhRHAiuv2Zju1VNSe7dO0aaYn+1TB99OF2Hv0S_A@mail.gmail.com>
 <20200725174430.GH10769@hirez.programming.kicks-ass.net>
 <20200725193909.GB9247@paulmck-ThinkPad-P72>
 <20200725201013.GZ119549@hirez.programming.kicks-ass.net>
 <20200725202131.GM43129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725202131.GM43129@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 10:21:31PM +0200, peterz@infradead.org wrote:
> On Sat, Jul 25, 2020 at 10:10:13PM +0200, peterz@infradead.org wrote:
> > On Sat, Jul 25, 2020 at 12:39:09PM -0700, Paul E. McKenney wrote:
> 
> > > This gets me the following for __rcu_read_lock():
> > > 
> > > 00000000000000e0 <__rcu_read_lock>:
> > >       e0:	48 8b 14 25 00 00 00 	mov    0x0,%rdx
> > >       e7:	00 
> > >       e8:	8b 82 e0 02 00 00    	mov    0x2e0(%rdx),%eax
> > >       ee:	83 c0 01             	add    $0x1,%eax
> > >       f1:	89 82 e0 02 00 00    	mov    %eax,0x2e0(%rdx)
> > >       f7:	c3                   	retq   
> > >       f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
> > >       ff:	00 
> > > 
> > > One might hope for a dec instruction, but this isn't bad.  We do lose
> > > a few instructions compared to the C-language case due to differences
> > > in address calculation:
> > > 
> > > 00000000000000e0 <__rcu_read_lock>:
> > >       e0:	48 8b 04 25 00 00 00 	mov    0x0,%rax
> > >       e7:	00 
> > >       e8:	83 80 e0 02 00 00 01 	addl   $0x1,0x2e0(%rax)
> > >       ef:	c3                   	retq   
> > 
> > Shees, that's daft... I think this is one of the cases where GCC is
> > perhaps overly cautious when presented with 'volatile'.
> > 
> > It has a history of generating excessively crap code around volatile,
> > and while it has improved somewhat, this seems to show there's still
> > room for improvement...
> > 
> > I suppose this is the point where we go bug a friendly compiler person.

Sounds very good!  Do you have someone specific in mind?

> Having had a play with godbolt.org, it seems clang isn't affected by
> this particular flavour of crazy, but GCC does indeed refuse to fuse the
> address calculation and the addition.

So there is hope, then!

And even GCC's current state is an improvement.  Last I messed with this,
the ACCESS_ONCE()++ approach generated a load, a register increment,
and a store.

Do you still have the godbolt.org URLs?  I would be happy to file
a bugzilla.

							Thanx, Paul
