Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7882AC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6D0218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580940269;
	bh=KqWfTx5ySZoDuTCF+SSsh/N+KCMc6OnFQZ+re0GuHYg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=RD2QYNvQUefgHI3hwPx0vVsy+XcQ36gTDWuUxBWCg7F2LbSJ+xlnaIBp7qAnUcm5s
	 TcPhj44sKXJ8qyZ6nN+t9O5GWhh5zxF6NVTYDvAtLnVj2pTRwNgicMf1VWJda/fr7q
	 9ITC9+GV2aMCScdW/BaZn50IEZTRx65PbG2IYEkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBEWE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:04:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgBEWE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:04:28 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EDBF217BA;
        Wed,  5 Feb 2020 22:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580940267;
        bh=KqWfTx5ySZoDuTCF+SSsh/N+KCMc6OnFQZ+re0GuHYg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=s9necmQ2yHVGx8d0Q95bPxQmJUlz1o8x9CP3FmXrAjo78aTc2haqu64BHYdd21570
         3unRiMhFtdKKMa8jiSExNncRxpxW/wWK4JQD1Y7s1XJ+bAD8NDlHTnAUNHvYR70AJZ
         6bLDZnNFOmyqO27snO9SxR89uxzPyO5oMw1UL+xc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0B6B135227EB; Wed,  5 Feb 2020 14:04:27 -0800 (PST)
Date:   Wed, 5 Feb 2020 14:04:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] kcsan: Introduce ASSERT_EXCLUSIVE_* macros
Message-ID: <20200205220427.GC2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200205204333.30953-1-elver@google.com>
 <20200205204333.30953-2-elver@google.com>
 <20200205213302.GA2935@paulmck-ThinkPad-P72>
 <CANpmjNN4vyFVnMY-SmRHHf-Nci_0hAXe1HiN96OvxnTfNjKmjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN4vyFVnMY-SmRHHf-Nci_0hAXe1HiN96OvxnTfNjKmjg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:48:14PM +0100, Marco Elver wrote:
> On Wed, 5 Feb 2020 at 22:33, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Feb 05, 2020 at 09:43:32PM +0100, Marco Elver wrote:
> > > Introduces ASSERT_EXCLUSIVE_WRITER and ASSERT_EXCLUSIVE_ACCESS, which
> > > may be used to assert properties of synchronization logic, where
> > > violation cannot be detected as a normal data race.
> > >
> > > Examples of the reports that may be generated:
> > >
> > >     ==================================================================
> > >     BUG: KCSAN: data-race in test_thread / test_thread
> > >
> > >     write to 0xffffffffab3d1540 of 8 bytes by task 466 on cpu 2:
> > >      test_thread+0x8d/0x111
> > >      debugfs_write.cold+0x32/0x44
> > >      ...
> > >
> > >     assert no writes to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
> > >      test_thread+0xa3/0x111
> > >      debugfs_write.cold+0x32/0x44
> > >      ...
> > >     ==================================================================
> > >
> > >     ==================================================================
> > >     BUG: KCSAN: data-race in test_thread / test_thread
> > >
> > >     assert no accesses to 0xffffffffab3d1540 of 8 bytes by task 465 on cpu 1:
> > >      test_thread+0xb9/0x111
> > >      debugfs_write.cold+0x32/0x44
> > >      ...
> > >
> > >     read to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
> > >      test_thread+0x77/0x111
> > >      debugfs_write.cold+0x32/0x44
> > >      ...
> > >     ==================================================================
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >
> > > Please let me know if the names make sense, given they do not include a
> > > KCSAN_ prefix.
> >
> > I am OK with this, but there might well be some bikeshedding later on.
> > Which should not be a real problem, irritating though it might be.
> >
> > > The names are unique across the kernel. I wouldn't expect another macro
> > > with the same name but different semantics to pop up any time soon. If
> > > there is a dual use to these macros (e.g. another tool that could hook
> > > into it), we could also move it elsewhere (include/linux/compiler.h?).
> > >
> > > We can also revisit the original suggestion of WRITE_ONCE_EXCLUSIVE(),
> > > if it is something that'd be used very widely. It'd be straightforward
> > > to add with the help of these macros, but would need to be added to
> > > include/linux/compiler.h.
> >
> > A more definite use case for ASSERT_EXCLUSIVE_ACCESS() is a
> > reference-counting algorithm where exclusive access is expected after
> > a successful atomic_dec_and_test().  Any objection to making the
> > docbook header use that example?  I believe that a more familiar
> > example would help people see the point of all this.  ;-)
> 
> Happy to update the example -- I'll send it tomorrow.

Sounds great!

> > I am queueing these as-is for review and testing, but please feel free
> > to send updated versions.  Easy to do the replacement!
> 
> Thank you!
> 
> > And you knew that this was coming...  It looks to me that I can
> > do something like this:
> >
> >         struct foo {
> >                 int a;
> >                 char b;
> >                 long c;
> >                 atomic_t refctr;
> >         };
> >
> >         void do_a_foo(struct foo *fp)
> >         {
> >                 if (atomic_dec_and_test(&fp->refctr)) {
> >                         ASSERT_EXCLUSIVE_ACCESS(*fp);
> >                         safely_dispose_of(fp);
> >                 }
> >         }
> >
> > Does that work, or is it necessary to assert for each field separately?
> 
> That works just fine, and will check for races on the whole struct.

Nice!!!

							Thanx, Paul

> Thanks,
> -- Marco
> 
> >                                                         Thanx, Paul
> >
> > > ---
> > >  include/linux/kcsan-checks.h | 34 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >
> > > diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> > > index 21b1d1f214ad5..1a7b51e516335 100644
> > > --- a/include/linux/kcsan-checks.h
> > > +++ b/include/linux/kcsan-checks.h
> > > @@ -96,4 +96,38 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
> > >       kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
> > >  #endif
> > >
> > > +/**
> > > + * ASSERT_EXCLUSIVE_WRITER - assert no other threads are writing @var
> > > + *
> > > + * Assert that there are no other threads writing @var; other readers are
> > > + * allowed. This assertion can be used to specify properties of synchronization
> > > + * logic, where violation cannot be detected as a normal data race.
> > > + *
> > > + * For example, if a per-CPU variable is only meant to be written by a single
> > > + * CPU, but may be read from other CPUs; in this case, reads and writes must be
> > > + * marked properly, however, if an off-CPU WRITE_ONCE() races with the owning
> > > + * CPU's WRITE_ONCE(), would not constitute a data race but could be a harmful
> > > + * race condition. Using this macro allows specifying this property in the code
> > > + * and catch such bugs.
> > > + *
> > > + * @var variable to assert on
> > > + */
> > > +#define ASSERT_EXCLUSIVE_WRITER(var)                                           \
> > > +     __kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT)
> > > +
> > > +/**
> > > + * ASSERT_EXCLUSIVE_ACCESS - assert no other threads are accessing @var
> > > + *
> > > + * Assert that no other thread is accessing @var (no readers nor writers). This
> > > + * assertion can be used to specify properties of synchronization logic, where
> > > + * violation cannot be detected as a normal data race.
> > > + *
> > > + * For example, if a variable is not read nor written by the current thread, nor
> > > + * should it be touched by any other threads during the current execution phase.
> > > + *
> > > + * @var variable to assert on
> > > + */
> > > +#define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
> > > +     __kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
> > > +
> > >  #endif /* _LINUX_KCSAN_CHECKS_H */
> > > --
> > > 2.25.0.341.g760bfbb309-goog
> > >
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200205213302.GA2935%40paulmck-ThinkPad-P72.
