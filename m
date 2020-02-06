Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD5C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0936820838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4/J9U6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBFPzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:55:18 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37284 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbgBFPzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:55:17 -0500
Received: by mail-oi1-f194.google.com with SMTP id q84so5062983oic.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEWX0npp6iSdZ2sCeEfnqok64qwFCdE1Pgq5folNH38=;
        b=o4/J9U6CRuqrlMX1DUeoOLbkmtAuF8eoo/BFZrcfeLPn7BMbWMmybeWolc+RFSgpvW
         Wrj6V0Lsn4nb7vmtF7WHKyNV19lqgdvdYy9kG+ZR3wtw1a3BhMLPD4oBqNcrAQDxgk9Q
         MWDtCgIiYPk9+V+QOVdJNo12ueK08+7XUhD1yRq71+eUn/E4XcUQn7iUa9L6ieclCJh9
         9+8KLVPLNtfiVK+k8te22AwpZ3AyV75IpYG82E3URD3gfda71z5IxfSpPjWC22+/KUb/
         RiUcwOGFROkX21vYm3Ypq2vLMnHaoV6I9aToj9VX4ZcmXy1wJha+AQO1h6KYqLKqKSCc
         WE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEWX0npp6iSdZ2sCeEfnqok64qwFCdE1Pgq5folNH38=;
        b=j7VPSxEtRys1OC+iW8g1nYPFbT9L9m+ljqpYUtAnCYgB2aTp8Tm7PNVUPO+DxNUOrh
         oTXTLPyTKMq0JzQAS2ZJLli5glGUoj9/KfkjJ3ryBfFm6IFerNOmZaWWW2Re5tvnOzfG
         Z7rotAgLUndFbk1409exTPAibwx+QXwqhixjGFlVO+V6N9Dvqn5BM7Sg4gxNjHFhgO7F
         MgTTk3u+fkKT+6Wv4WM3nuCf3aeqNUNJzYKNSyHGHsotBKRmVKrD5YvNNE3kqWhVQQKE
         JXPQ2nRGROzOZwiaGhLGetUqoyFRPeFwkHe8uFytdlVDSE7c9suMIArgyLPYjOpCkLzn
         ag6g==
X-Gm-Message-State: APjAAAUEvf/6pDB/jDxiQ7Va5gTWI4bbrtkHBt5I8o0u1GXvWU8IAV6G
        7tRo3/WQBPTzXEwKEAdwMgWFx0z/LTMhmasK4Ubc0A==
X-Google-Smtp-Source: APXvYqzY1H/IZoELjQyrGfJZ3fNmFqfmK6HRnfABAPe9Dy6N18GpmMBTMxXeNkenam//NrJBZ4rOhSQtKesCwosuFZ8=
X-Received: by 2002:aca:c7ca:: with SMTP id x193mr7390131oif.70.1581004514655;
 Thu, 06 Feb 2020 07:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20200205204333.30953-1-elver@google.com> <20200205204333.30953-2-elver@google.com>
 <20200205213302.GA2935@paulmck-ThinkPad-P72> <CANpmjNN4vyFVnMY-SmRHHf-Nci_0hAXe1HiN96OvxnTfNjKmjg@mail.gmail.com>
 <20200205220427.GC2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200205220427.GC2935@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Thu, 6 Feb 2020 16:55:03 +0100
Message-ID: <CANpmjNO7_Dp=RtfnnVTrULAKRkX_XW0h5WE+EKGt6oyL6c21kw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kcsan: Introduce ASSERT_EXCLUSIVE_* macros
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020 at 23:04, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Feb 05, 2020 at 10:48:14PM +0100, Marco Elver wrote:
> > On Wed, 5 Feb 2020 at 22:33, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Feb 05, 2020 at 09:43:32PM +0100, Marco Elver wrote:
> > > > Introduces ASSERT_EXCLUSIVE_WRITER and ASSERT_EXCLUSIVE_ACCESS, which
> > > > may be used to assert properties of synchronization logic, where
> > > > violation cannot be detected as a normal data race.
> > > >
> > > > Examples of the reports that may be generated:
> > > >
> > > >     ==================================================================
> > > >     BUG: KCSAN: data-race in test_thread / test_thread
> > > >
> > > >     write to 0xffffffffab3d1540 of 8 bytes by task 466 on cpu 2:
> > > >      test_thread+0x8d/0x111
> > > >      debugfs_write.cold+0x32/0x44
> > > >      ...
> > > >
> > > >     assert no writes to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
> > > >      test_thread+0xa3/0x111
> > > >      debugfs_write.cold+0x32/0x44
> > > >      ...
> > > >     ==================================================================
> > > >
> > > >     ==================================================================
> > > >     BUG: KCSAN: data-race in test_thread / test_thread
> > > >
> > > >     assert no accesses to 0xffffffffab3d1540 of 8 bytes by task 465 on cpu 1:
> > > >      test_thread+0xb9/0x111
> > > >      debugfs_write.cold+0x32/0x44
> > > >      ...
> > > >
> > > >     read to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
> > > >      test_thread+0x77/0x111
> > > >      debugfs_write.cold+0x32/0x44
> > > >      ...
> > > >     ==================================================================
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >
> > > > Please let me know if the names make sense, given they do not include a
> > > > KCSAN_ prefix.
> > >
> > > I am OK with this, but there might well be some bikeshedding later on.
> > > Which should not be a real problem, irritating though it might be.
> > >
> > > > The names are unique across the kernel. I wouldn't expect another macro
> > > > with the same name but different semantics to pop up any time soon. If
> > > > there is a dual use to these macros (e.g. another tool that could hook
> > > > into it), we could also move it elsewhere (include/linux/compiler.h?).
> > > >
> > > > We can also revisit the original suggestion of WRITE_ONCE_EXCLUSIVE(),
> > > > if it is something that'd be used very widely. It'd be straightforward
> > > > to add with the help of these macros, but would need to be added to
> > > > include/linux/compiler.h.
> > >
> > > A more definite use case for ASSERT_EXCLUSIVE_ACCESS() is a
> > > reference-counting algorithm where exclusive access is expected after
> > > a successful atomic_dec_and_test().  Any objection to making the
> > > docbook header use that example?  I believe that a more familiar
> > > example would help people see the point of all this.  ;-)
> >
> > Happy to update the example -- I'll send it tomorrow.
>
> Sounds great!

v2 sent: http://lkml.kernel.org/r/20200206154626.243230-1-elver@google.com

Thanks,
-- Marco

> > > I am queueing these as-is for review and testing, but please feel free
> > > to send updated versions.  Easy to do the replacement!
> >
> > Thank you!
> >
> > > And you knew that this was coming...  It looks to me that I can
> > > do something like this:
> > >
> > >         struct foo {
> > >                 int a;
> > >                 char b;
> > >                 long c;
> > >                 atomic_t refctr;
> > >         };
> > >
> > >         void do_a_foo(struct foo *fp)
> > >         {
> > >                 if (atomic_dec_and_test(&fp->refctr)) {
> > >                         ASSERT_EXCLUSIVE_ACCESS(*fp);
> > >                         safely_dispose_of(fp);
> > >                 }
> > >         }
> > >
> > > Does that work, or is it necessary to assert for each field separately?
> >
> > That works just fine, and will check for races on the whole struct.
>
> Nice!!!
>
>                                                         Thanx, Paul
>
> > Thanks,
> > -- Marco
> >
> > >                                                         Thanx, Paul
> > >
> > > > ---
> > > >  include/linux/kcsan-checks.h | 34 ++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 34 insertions(+)
> > > >
> > > > diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> > > > index 21b1d1f214ad5..1a7b51e516335 100644
> > > > --- a/include/linux/kcsan-checks.h
> > > > +++ b/include/linux/kcsan-checks.h
> > > > @@ -96,4 +96,38 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
> > > >       kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
> > > >  #endif
> > > >
> > > > +/**
> > > > + * ASSERT_EXCLUSIVE_WRITER - assert no other threads are writing @var
> > > > + *
> > > > + * Assert that there are no other threads writing @var; other readers are
> > > > + * allowed. This assertion can be used to specify properties of synchronization
> > > > + * logic, where violation cannot be detected as a normal data race.
> > > > + *
> > > > + * For example, if a per-CPU variable is only meant to be written by a single
> > > > + * CPU, but may be read from other CPUs; in this case, reads and writes must be
> > > > + * marked properly, however, if an off-CPU WRITE_ONCE() races with the owning
> > > > + * CPU's WRITE_ONCE(), would not constitute a data race but could be a harmful
> > > > + * race condition. Using this macro allows specifying this property in the code
> > > > + * and catch such bugs.
> > > > + *
> > > > + * @var variable to assert on
> > > > + */
> > > > +#define ASSERT_EXCLUSIVE_WRITER(var)                                           \
> > > > +     __kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT)
> > > > +
> > > > +/**
> > > > + * ASSERT_EXCLUSIVE_ACCESS - assert no other threads are accessing @var
> > > > + *
> > > > + * Assert that no other thread is accessing @var (no readers nor writers). This
> > > > + * assertion can be used to specify properties of synchronization logic, where
> > > > + * violation cannot be detected as a normal data race.
> > > > + *
> > > > + * For example, if a variable is not read nor written by the current thread, nor
> > > > + * should it be touched by any other threads during the current execution phase.
> > > > + *
> > > > + * @var variable to assert on
> > > > + */
> > > > +#define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
> > > > +     __kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
> > > > +
> > > >  #endif /* _LINUX_KCSAN_CHECKS_H */
> > > > --
> > > > 2.25.0.341.g760bfbb309-goog
> > > >
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200205213302.GA2935%40paulmck-ThinkPad-P72.
