Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADF0C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F4320786
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595706065;
	bh=HExWakA+miNWIPWnX/iqiAyGRgx5GHyT9HO5mLqYU+Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Ci8CH3crsTM91qEcuwDy2/zuEO4UgHn2hmK9lSrsd4ae12MKw585thSTsomHPMyBc
	 v7ztm+mw6SMTHqzCmypyj776Ek6GR6gitfqLx2EpO/L+wHLfH5qsYd0m27+gE5Po8B
	 Kv3DBnEDeb4C1fBhM1KzR5CRz8/MoSN7gNDonRpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgGYTjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 15:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgGYTjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 15:39:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25451206D8;
        Sat, 25 Jul 2020 19:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595705949;
        bh=HExWakA+miNWIPWnX/iqiAyGRgx5GHyT9HO5mLqYU+Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Wx8JwBnfEZu6V2RbKgm3EMhAXAJwA2/Qm7sPAQHwLAV6IHtYZeTab621VK43bPgaT
         5gOuwTDlbgK5/fdkjML+MOMEyoS+F/DxkfaZ2cE3I49BrIhgcphdv81z1EG05SUuEZ
         5GiPtwZN+tfnSLx7wO3dRCVynRZCKzCXH7JyVrQk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0C9343522767; Sat, 25 Jul 2020 12:39:09 -0700 (PDT)
Date:   Sat, 25 Jul 2020 12:39:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcsan: Add option to allow watcher interruptions
Message-ID: <20200725193909.GB9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200220141551.166537-1-elver@google.com>
 <20200220185855.GY2935@paulmck-ThinkPad-P72>
 <20200220213317.GA35033@google.com>
 <20200725145623.GZ9247@paulmck-ThinkPad-P72>
 <CANpmjNPhuvrhRHAiuv2Zju1VNSe7dO0aaYn+1TB99OF2Hv0S_A@mail.gmail.com>
 <20200725174430.GH10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725174430.GH10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 07:44:30PM +0200, Peter Zijlstra wrote:
> On Sat, Jul 25, 2020 at 05:17:43PM +0200, Marco Elver wrote:
> > On Sat, 25 Jul 2020 at 16:56, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Thu, Feb 20, 2020 at 10:33:17PM +0100, Marco Elver wrote:
> > > > On Thu, 20 Feb 2020, Paul E. McKenney wrote:
> > > > > On Thu, Feb 20, 2020 at 03:15:51PM +0100, Marco Elver wrote:
> > > > > > Add option to allow interrupts while a watchpoint is set up. This can be
> > > > > > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> > > > > > parameter 'kcsan.interrupt_watcher=1'.
> > [...]
> > > > > > As an example, the first data race that this found:
> > > > > >
> > > > > > write to 0xffff88806b3324b8 of 4 bytes by interrupt on cpu 0:
> > > > > >  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]
> > > > > >  __rcu_read_lock+0x3c/0x50 kernel/rcu/tree_plugin.h:373
> > [...]
> > > > > > read to 0xffff88806b3324b8 of 4 bytes by task 6131 on cpu 0:       |
> > > > > >  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]  ----+
> > [...]
> > > > > >
> > > > > > The writer is doing 'current->rcu_read_lock_nesting++'. The read is as
> > > > > > vulnerable to compiler optimizations and would therefore conclude this
> > > > > > is a valid data race.
> > > > >
> > > > > Heh!  That one is a fun one!  It is on a very hot fastpath.  READ_ONCE()
> > > > > and WRITE_ONCE() are likely to be measurable at the system level.
> > > > >
> > > > > Thoughts on other options?
> 
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index c6ea81cd41890..e0595abd50c0f 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -350,17 +350,17 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
> > > >
> > > >  static void rcu_preempt_read_enter(void)
> > > >  {
> > > > -     current->rcu_read_lock_nesting++;
> > > > +     local_inc(&current->rcu_read_lock_nesting);
> > > >  }
> > > >
> > > >  static void rcu_preempt_read_exit(void)
> > > >  {
> > > > -     current->rcu_read_lock_nesting--;
> > > > +     local_dec(&current->rcu_read_lock_nesting);
> > > >  }
> > > >
> > > >  static void rcu_preempt_depth_set(int val)
> > > >  {
> > > > -     current->rcu_read_lock_nesting = val;
> > > > +     local_set(&current->rcu_read_lock_nesting, val);
> > 
> > > I agree that this removes the data races, and that the code for x86 is
> > > quite nice, but aren't rcu_read_lock() and rcu_read_unlock() going to
> > > have heavyweight atomic operations on many CPUs?
> > >
> > > Maybe I am stuck with arch-specific code in rcu_read_lock() and
> > > rcu_preempt_read_exit().  I suppose worse things could happen.
> > 
> > Peter also mentioned to me that while local_t on x86 generates
> > reasonable code, on other architectures it's terrible. So I think
> > something else is needed, and feel free to discard the above idea.
> > With sufficient enough reasoning, how bad would a 'data_race(..)' be?
> 
> Right, so local_t it atrocious on many architectures, they fall back to
> atomic_t.
> 
> Even architectures that have optimized variants (eg. Power), they're
> quite a lot more expensive than what we actually need here.
> 
> Only architectures like x86 that have single instruction memops can
> generate anywhere near the code that we'd want here.
> 
> So the thing is, since RCU count is 0 per context (an IRQ must have an
> equal amount of rcu_read_unlock() as it has rcu_read_lock()), interrupts
> are not in fact a problem, even on load-store (RISC) architectures
> (preempt_count has the same thing).

True enough!

> So the addition/subtraction in rcu_preempt_read_{enter,exit}() doesn't
> need to be atomic vs interrupts. The only thing we really do need is
> them being single-copy-atomic.
> 
> The problem with READ/WRITE_ONCE is that if we were to use it, we'd end
> up with a load-store, even on x86, which is sub-optimal.

Agreed.

> I suppose the 'correct' code here would be something like:
> 
> 	*((volatile int *)&current->rcu_read_lock_nesting)++;
> 
> then the compiler can either do a single memop (x86 and the like) or a
> load-store that is free from tearing.

Hah!!!  That is the original ACCESS_ONCE(), isn't it?  ;-)

	ACCESS_ONCE(current->rcu_read_lock_nesting)++;

But open-coding makes sense unless a lot of other places need something
similar.  Besides, open-coding allows me to defer bikeshedding on the
name, given that there are actually two accesses.  :-/

Ah, but that gets compiler warnings:

kernel/rcu/tree_plugin.h:354:52: error: lvalue required as increment operand
  *((volatile int *)&current->rcu_read_lock_nesting)++;

Let's try the old ACCESS_ONCE().  Dialing back to v3.0:

#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))

So:
	(*(volatile int *)&(current->rcu_read_lock_nesting))++;

This gets me the following for __rcu_read_lock():

00000000000000e0 <__rcu_read_lock>:
      e0:	48 8b 14 25 00 00 00 	mov    0x0,%rdx
      e7:	00 
      e8:	8b 82 e0 02 00 00    	mov    0x2e0(%rdx),%eax
      ee:	83 c0 01             	add    $0x1,%eax
      f1:	89 82 e0 02 00 00    	mov    %eax,0x2e0(%rdx)
      f7:	c3                   	retq   
      f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
      ff:	00 

One might hope for a dec instruction, but this isn't bad.  We do lose
a few instructions compared to the C-language case due to differences
in address calculation:

00000000000000e0 <__rcu_read_lock>:
      e0:	48 8b 04 25 00 00 00 	mov    0x0,%rax
      e7:	00 
      e8:	83 80 e0 02 00 00 01 	addl   $0x1,0x2e0(%rax)
      ef:	c3                   	retq   

For the relevant portion of __rcu_read_unlock(), this gets us
the following:

00000000000027f0 <__rcu_read_unlock>:
    27f0:	48 8b 3c 25 00 00 00 	mov    0x0,%rdi
    27f7:	00 
    27f8:	53                   	push   %rbx
    27f9:	8b 87 e0 02 00 00    	mov    0x2e0(%rdi),%eax
    27ff:	8d 50 ff             	lea    -0x1(%rax),%edx
    2802:	85 c0                	test   %eax,%eax
    2804:	89 97 e0 02 00 00    	mov    %edx,0x2e0(%rdi)
    280a:	75 0a                	jne    2816 <__rcu_read_unlock+0x26>

Here we have a load-subtract-store, but given that we need to test
the value, this seems reasonable to me.  We again lose a few instructions
compared to the C-language case, and again due to address calculation:

00000000000027e0 <__rcu_read_unlock>:
    27e0:	53                   	push   %rbx
    27e1:	48 8b 3c 25 00 00 00 	mov    0x0,%rdi
    27e8:	00 
    27e9:	83 af e0 02 00 00 01 	subl   $0x1,0x2e0(%rdi)
    27f0:	75 0a                	jne    27fc <__rcu_read_unlock+0x1c>

Thoughts?

							Thanx, Paul
