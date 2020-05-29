Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F38C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C0206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590761123;
	bh=DAEX1BrrY5wL9k9zq0w57zLiw5vneyLFzT1YguTHKHE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ErGybIzFK4YmjBI5PXEaqy2pTVJsxghgvZ0zY4Rl2som8KGXkXv8ikp5Cg7US2jxw
	 dl0sJuh09kQRGXD+oex7DNMhyUISLl8r5g9VyTMMseQCRfsgLVU0cIZ+1sQDqBoy2W
	 BOKBq4JaV3vnXwjQUcJDmLa+JGj23a2q12FeSjB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgE2OFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgE2OFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:05:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A4E32073B;
        Fri, 29 May 2020 14:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590761121;
        bh=DAEX1BrrY5wL9k9zq0w57zLiw5vneyLFzT1YguTHKHE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DQqEnuyUJctnk4blUl2tCMAq0iNxtQ80mdI0YhsGpg5TKfH7PYcZ9KiOJgtpvn117
         68lqXlWuJjBh3742/YnAGhqU1OYnHB5sDEdbpDecQh5XyPBcFj95u7Z05fdniNp4Av
         9iZdL9HgINidUjit4y5hsG3Yb8wgR2DcTWpvGsJI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 37CA33522683; Fri, 29 May 2020 07:05:21 -0700 (PDT)
Date:   Fri, 29 May 2020 07:05:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: WARNING: suspicious RCU usage in idtentry_exit
Message-ID: <20200529140521.GA2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <000000000000840d4d05a6850c73@google.com>
 <87wo4wnpzb.fsf@nanos.tec.linutronix.de>
 <20200528161143.GF2869@paulmck-ThinkPad-P72>
 <878shbols9.fsf@nanos.tec.linutronix.de>
 <20200528204839.GR2869@paulmck-ThinkPad-P72>
 <CACT4Y+bVPSZVkWJquu5gk11ymhirsFvVFYHkexjqgBkgga379w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bVPSZVkWJquu5gk11ymhirsFvVFYHkexjqgBkgga379w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 08:20:12AM +0200, Dmitry Vyukov wrote:
> On Thu, May 28, 2020 at 10:48 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, May 28, 2020 at 10:19:02PM +0200, Thomas Gleixner wrote:
> > > Paul,
> > >
> > > "Paul E. McKenney" <paulmck@kernel.org> writes:
> > > > On Thu, May 28, 2020 at 03:33:44PM +0200, Thomas Gleixner wrote:
> > > >> syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com> writes:
> > > >> Weird. I have no idea how that thing is an EQS here.
> > > >
> > > > No argument on the "Weird" part!  ;-)
> > > >
> > > > Is this a NO_HZ_FULL=y kernel?
> > >
> > > No, it has only NO_HZ_IDLE.
> > >
> > >   https://syzkaller.appspot.com/x/.config?x=47b0740d89299c10
> >
> > OK, from the .config, another suggestion is to build the kernel
> > with CONFIG_RCU_EQS_DEBUG=y.  This still requires that this issue be
> > reproduced, but it might catch the problem earlier.
> 
> How much does it slow down execution? If we enable it on syzbot, it
> will affect all fuzzing done by syzbot always.
> It can tolerate significant slowdown and it's far from a production
> kernel (it enables KASAN, KCOV, LOCKDEP and more). But I am still
> asking because some debugging features are built without performance
> in mind at all (like let's just drop a global lock in every
> kmalloc/free, which may be too much even for a standard debug build).

It is an extra WARN_ON_ONCE() with a simple comparison, but on almost
every kernel entry/exit path.

So not something you want in production, but much lighter weight than
any of the tools you listed above.

Full disclosure:  It usually fires for new architectures or for new
timer hardware/drivers.  Which might allow you to enable it selectively.

							Thanx, Paul

> > > > If so, one possibility is that the call
> > > > to rcu_user_exit() went missing somehow.  If not, then RCU should have
> > > > been watching userspace execution.
> > > >
> > > > Again, the only thing I can think of (should this prove to be
> > > > reproducible) is the rcu_dyntick trace event.
> > >
> > > :)
> > >
> > > Thanks,
> > >
> > >         tglx
> >
> >                                                         Thanx, Paul
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200528204839.GR2869%40paulmck-ThinkPad-P72.
