Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CD1C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F36221D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599705786;
	bh=iuNJq0AMVMRY3OQGBSk/SHykix4l0ulZAZN6rJoONs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pMABAIzkFuopvHaAEZP5SOHDbrmI/TV2uyq3K34YFycqyaTlK2eNuhIp7WQj4f2Sl
	 gWsqkrcXI5m2KEtl7qS0iBRHBWoHoFjWGVDdUy7Mdofwsw+Z6T+SadhJGZZX/CX7/Z
	 QbUpqgGbdrquzjqxtaDeGoQoHJi1rJnhzwDzDAHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgIJCmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730776AbgIJCkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:40:31 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6EF721D90;
        Wed,  9 Sep 2020 23:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599692568;
        bh=iuNJq0AMVMRY3OQGBSk/SHykix4l0ulZAZN6rJoONs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NF920g3A2F9mHFsu74uctEbgu/wRHdg8qOfyRUO8pBHIFgZaNP2lJc+xkQW7B5sdd
         4YYCuViLUGDLx+bhLXVNlZexEMdWNxW6//Q7yRf6tX4pkpYJP8SDLTmo66GWExHr4n
         ulqsRJ/g36+32tQDkbhGclPSB/0HG6qlQAMQqmhQ=
Date:   Thu, 10 Sep 2020 01:02:46 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     peterz@infradead.org
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Requirements to control kernel isolation/nohz_full at runtime
Message-ID: <20200909230243.GD20541@lenoir>
References: <20200901104640.GA13814@lenoir>
 <20200907153417.GL1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907153417.GL1362448@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 05:34:17PM +0200, peterz@infradead.org wrote:
> 
> (your mailer broke and forgot to keep lines shorter than 78 chars)

I manually reordered the lines and that's indeed quite a mess :o)

> 
> On Tue, Sep 01, 2020 at 12:46:41PM +0200, Frederic Weisbecker wrote:
> 
> > == TIF_NOHZ ==
> > 
> > Need to get rid of that in order not to trigger syscall slowpath on
> > CPUs that don't want nohz_full.  Also we don't want to iterate all
> > threads and clear the flag when the last nohz_full CPU exits nohz_full
> > mode. Prefer static keys to call context tracking on archs. x86 does
> > that well.
> 
> Build on the common entry code I suppose. Then any arch that uses that
> gets to have the new features.

Yep, eventually I hope we can put all these crucial pieces on the common entry
code.

> 
> > == Proper entry code ==
> > 
> > We must make sure that a given arch never calls exception_enter() /
> > exception_exit().  This saves the previous state of context tracking
> > and switch to kernel mode (from context tracking POV) temporarily.
> > Since this state is saved on the stack, this prevents us from turning
> > off context tracking entirely on a CPU: The tracking must be done on
> > all CPUs and that takes some cycles.
> > 
> > This means that, considering early entry code (before the call to
> > context tracking upon kernel entry, and after the call to context
> > tracking upon kernel exit), we must take care of few things:
> > 
> > 1) Make sure early entry code can't trigger exceptions. Or if it does,
> > the given exception can't schedule or use RCU (unless it calls
> > rcu_nmi_enter()). Otherwise the exception must call
> > exception_enter()/exception_exit() which we don't want.
> 
> I think this is true for x86. Early entry has interrupts disabled, any
> exception that can still happen is NMI-like and will thus use
> rcu_nmi_enter().
> 
> On x86 that now includes #DB (which is also excluded due to us refusing
> to set execution breakpoints on entry code), #BP, NMI and MCE.

Perfect! That's what I assumed as well.

> 
> > 2) No call to schedule_user().
> 
> I'm not sure what that is supposed to do, but x86 doesn't appear to have
> it, so all good :-)

I think it was there in case an exception would schedule after context tracking
exit kernel but before we actually exit kernel. But we removed that (Andy probably)
when we made sure the early entry was not interruptible. Now some other archs
still use it, I'm just not sure if they do it for a good reason...

> 
> > 3) Make sure early entry code is not interruptible or
> > preempt_schedule_irq() would rely on
> > exception_entry()/exception_exit()
> 
> This is so for x86.

Perfect!

> 
> > 4) Make sure early entry code can't be traced (no call to
> > preempt_schedule_notrace()), or if it does it can't schedule
> 
> noinstr is your friend.

Right. My fear was rather on special areas that temporarily
enable tracing (instrumentation_begin()...instrumentation_end())
but those should only happen with interrupts disabled on entry code
with preempt_schedule_notrace() having no effect.

> 
> > I believe x86 does most of that well.
> 
> It does now.

Thanks a lot for confirming! I guess I can remove
exception_enter()/exit() on x86. Fortunately any issue
will be very easily spotted.

Thanks!
