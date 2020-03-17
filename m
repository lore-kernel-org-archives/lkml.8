Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1EAC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEB4206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OG67LfbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgCQLM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:12:57 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40239 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgCQLMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:12:51 -0400
Received: by mail-oi1-f193.google.com with SMTP id y71so21250154oia.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 04:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDIGHzM00UxgsxqOQfj1JbuGjgWmon8niln7RYiZPTE=;
        b=OG67LfbU6p92npUUiyWGbmMSPv2baB0e5HX3OaXMo5Y8Vn+mGL97wMnZWJC7Kgo5pD
         Xj7Nug6IwTxvvAPREb/JHMf3LWyDis56U7WH7/fpsJjIe91lbU6Krh4ZgAKqPyDT8zMf
         Xov9STlckBQmPuSNgoQ3MMHof1K43hbwQGKRvmXnrTtDZsfZC/zsXRQtWkiLDGq27n2q
         X9QfnwYe3uds0erMi59kmboE9FV+e4B4KwzOczuoVXHbl/xRW+hQzg/cCncZk5rkMbqG
         KYbVVMdJQ4kUPmj7CNRtYgfECYlh2Ke1zBw2M2VuvKOjDm9fBkJs3YSeLbjMDmdBWGdu
         1etA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDIGHzM00UxgsxqOQfj1JbuGjgWmon8niln7RYiZPTE=;
        b=etXjPLHgD5xJaKsHhPqiyU0omNg0pNeIW1+pmf8abnOsfUDrd/jLPaJPue16wwb4sV
         jGn9scnJqwRcvWxqyxcq+rphA0kt0z3jIt3GtlQeTabAcTlxYF8hEVxr6cx7WOA66PFe
         8IXD7CzS8zILBMvaN26XbVNHvUj6t+y6kfvAvAyOO4FU4BPOssa3/OqQtcnQ+AND3oEX
         8Cav20feNnQgJ1f3JI96lxNNM7qYWMskY1i1s22Z9DAqwV70ulRLpttmuvQWOiKYiV1s
         XmsB4itQbjAfUbjjdb92zNtDgWtjrAD12Pwp62RbOc3CSIGiOHJsY8RzCjXMaM3C1wFX
         5QRQ==
X-Gm-Message-State: ANhLgQ2w/ODYOWf+JW9zQbRHR+btd/A0IyQMJLZ4fEMquHuc1iGec25x
        6oVfW+AS3N0MX/gkHPACAGmDr1yEDWteDQxvtx0GXg==
X-Google-Smtp-Source: ADFU+vvd09trL3BOmpb1fttMWJNm9yqhbhrkhNl/wK6dprfKmFJUZUABc5PmBfuSses+FsJmjHnLsLqVhidittSshGI=
X-Received: by 2002:aca:4cd8:: with SMTP id z207mr2922845oia.155.1584443569132;
 Tue, 17 Mar 2020 04:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200309190359.GA5822@paulmck-ThinkPad-P72> <20200309190420.6100-17-paulmck@kernel.org>
 <20200313085220.GC105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <CANpmjNO-hjVfp729YOGdoiuwWjLacW+OCJ=5RnxEYGvQjfQGhA@mail.gmail.com> <20200314022210.GD105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
In-Reply-To: <20200314022210.GD105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 17 Mar 2020 12:12:36 +0100
Message-ID: <CANpmjNPu67nnaWbOtA8xntBWafDm5Ykspzj43wuSdRckLGC=UA@mail.gmail.com>
Subject: Re: [PATCH kcsan 17/32] kcsan: Introduce ASSERT_EXCLUSIVE_* macros
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Mar 2020 at 03:22, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Fri, Mar 13, 2020 at 05:15:32PM +0100, Marco Elver wrote:
> > On Fri, 13 Mar 2020 at 09:52, Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > Hi Marco,
> > >
> > > On Mon, Mar 09, 2020 at 12:04:05PM -0700, paulmck@kernel.org wrote:
> > > > From: Marco Elver <elver@google.com>
> > > >
> > > > Introduces ASSERT_EXCLUSIVE_WRITER and ASSERT_EXCLUSIVE_ACCESS, which
> > > > may be used to assert properties of synchronization logic, where
> > > > violation cannot be detected as a normal data race.
> > > >
> > > > Examples of the reports that may be generated:
> > > >
> > > >     ==================================================================
> > > >     BUG: KCSAN: assert: race in test_thread / test_thread
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
> > > >     BUG: KCSAN: assert: race in test_thread / test_thread
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
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  include/linux/kcsan-checks.h | 40 ++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 40 insertions(+)
> > > >
> > > > diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> > > > index 5dcadc2..cf69617 100644
> > > > --- a/include/linux/kcsan-checks.h
> > > > +++ b/include/linux/kcsan-checks.h
> > > > @@ -96,4 +96,44 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
> > > >       kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
> > > >  #endif
> > > >
> > > > +/**
> > > > + * ASSERT_EXCLUSIVE_WRITER - assert no other threads are writing @var
> > > > + *
> > > > + * Assert that there are no other threads writing @var; other readers are
> > > > + * allowed. This assertion can be used to specify properties of concurrent code,
> > > > + * where violation cannot be detected as a normal data race.
> > > > + *
> > >
> > > I like the idea that we can assert no other writers, however I think
> > > assertions like ASSERT_EXCLUSIVE_WRITER() are a little limited. For
> > > example, if we have the following code:
> > >
> > >         preempt_disable();
> > >         do_sth();
> > >         raw_cpu_write(var, 1);
> > >         do_sth_else();
> > >         preempt_enable();
> > >
> > > we can add the assert to detect another potential writer like:
> > >
> > >         preempt_disable();
> > >         do_sth();
> > >         ASSERT_EXCLUSIVE_WRITER(var);
> > >         raw_cpu_write(var, 1);
> > >         do_sth_else();
> > >         preempt_enable();
> > >
> > > , but, if I understand how KCSAN works correctly, it only works if the
> > > another writer happens when the ASSERT_EXCLUSIVE_WRITER(var) is called,
> > > IOW, it can only detect another writer between do_sth() and
> > > raw_cpu_write(). But our intent is to prevent other writers for the
> > > whole preemption-off section. With this assertion introduced, people may
> > > end up with code like:
> >
> > To confirm: KCSAN will detect a race if it sets up a watchpoint on
> > ASSERT_EXCLUSIVE_WRITER(var), and a concurrent write happens. Note
> > that the watchpoints aren't always set up, but only periodically
> > (discussed more below). For every watchpoint, we also inject an
> > artificial delay. Pseudo-code:
> >
> > if watchpoint for access already set up {
> >   consume watchpoint;
> > else if should set up watchpoint {
> >   setup watchpoint;
> >   udelay(...);
> >   check watchpoint consumed;
> >   release watchpoint;
> > }
> >
>
> Yes, I get this part.
>
> > >         preempt_disable();
> > >         ASSERT_EXCLUSIVE_WRITER(var);
> > >         do_sth();
> > >         ASSERT_EXCLUSIVE_WRITER(var);
> > >         raw_cpu_write(var, 1);
> > >         ASSERT_EXCLUSIVE_WRITER(var);
> > >         do_sth_else();
> > >         ASSERT_EXCLUSIVE_WRITER(var);
> > >         preempt_enable();
> > >
> > > and that is horrible...
> >
> > It is, and I would strongly discourage any such use, because it's not
> > necessary. See below.
> >
> > > So how about making a pair of annotations
> > > ASSERT_EXCLUSIVE_WRITER_BEGIN() and ASSERT_EXCLUSIVE_WRITER_END(), so
> > > that we can write code like:
> > >
> > >         preempt_disable();
> > >         ASSERT_EXCLUSIVE_WRITER_BEGIN(var);
> > >         do_sth();
> > >         raw_cpu_write(var, 1);
> > >         do_sth_else();
> > >         ASSERT_EXCLUSIVE_WRITER_END(var);
> > >         preempt_enable();
> > >
> > > ASSERT_EXCLUSIVE_WRITER_BEGIN() could be a rough version of watchpoint
> > > setting up and ASSERT_EXCLUSIVE_WRITER_END() could be watchpoint
> > > removing. So I think it's feasible.
> >
> > Keep in mind that the time from ASSERT_EXCLUSIVE_WRITER_BEGIN to END
> > might be on the order of a few nanosec, whereas KCSAN's default
> > watchpoint delay is 10s of microsec (default ~80 for tasks). That
> > means we would still have to set up a delay somewhere, and the few
> > nanosec between BEGIN and END are insignificant and don't buy us
> > anything.
> >
>
> Yeah, the delay doesn't buy us anything given the default watchpoint
> delay, and I agree even with *_{BEGIN/END}, we still need to set up a
> delay somewhere. Adding a delay makes the watchpoint live longer so that
> a problem will more likely happen, but sometimes the delay won't be
> enough, considering another writer like:
>
>         if (per_cpu(var, cpu) == 1)
>                 per_cpu(var, cpu) = 0;
>
> in this user case, percpu variable "var" is used for maintaining some
> state machine, and a CPU set a state with its own variable so that other
> CPUs can consume it. And this another writer cannot be catched by:
>
>         preempt_disable();
>         do_sth();
>         ASSERT_EXCLUSIVE_WRITER(var);
>         raw_cpu_write(var, 1);
>         do_sth_else();
>         preempt_enable();
>

Right, the example makes sense.

That is assuming there are various other expected racy reads that are
fine. If that's not true, ASSERT_EXCLUSIVE_ACCESS should be
considered.

> , no matter how long the delay is set. Another example: let's say the
> do_sth_else() above is actually an operation that queues a callback
> which writes to "var". In one version, do_sth_else() uses call_rcu(),
> which works, because preemption-off is treated as RCU read-side critical
> section, so we are fine. But if someone else changes it to queue_work()
> for some reason, the code is just broken, and KCSAN cannot detect it, no
> matter how long the delay is.
>
> To summarize, a delay is helpful to trigger a problem because it allows
> _other_ CPU/threads to run more code and do more memory accesses,
> however it's not helpful if a particular problem happens due to some
> memory effects of the current/watched CPU/thread. While *_{BEGIN/END}
> can be helpful in this case.

Makes sense.

> > Re feasibility: Right now setting up and removing watchpoints is not
> > exposed, and doing something like this would be an extremely intrusive
> > change. Because of that, without being able to quantify the actual
> > usefulness of this, and having evaluated better options (see below),
> > I'd recommend not pursuing this.
> >
> > > Thoughts?
> >
> > Firstly, what is your objective? From what I gather you want to
> > increase the probability of detecting a race with 'var'.
> >
>
> Right, I want to increase the probablity.
>
> > I agree, and have been thinking about it, but there are other options
> > that haven't been exhausted, before we go and make the interface more
> > complicated.
> >
> > == Interface design ==
> > The interface as it is right now, is intuitive and using it is hard to
> > get wrong. Demanding begin/end markers introduces complexity that will
>
> Yeah, the interface is intuitive, however it's still an extra effort to
> put those assertions, right? Which means it doesn't come for free,
> compared to other detection KCSAN can do, the developers don't need to
> put extra lines of code. Given the extra effort for developers to use
> the detect, I think we should dicuss the design thoroughly.
>
> Besides the semantics of assertions is usually "do some checking right
> now to see if things go wrong", and I don't think it quite matches the
> semantics of an exclusive writer: "in this piece of code, I'm the only
> one who can do the write".
>
> > undoubtedly result in incorrect usage, because as soon as you somehow
> > forget to end the region, you'll get tons of false positives. This may
> > be due to control-flow that was missed etc. We had a similar problem
> > with seqlocks, and getting them to work correctly with KCSAN was
> > extremely difficult, because clear begin and end markers weren't
> > always given. I imagine introducing an interface like this will
> > ultimately result in similar problems, as much as we'd like to believe
> > this won't ever happen.
> >
>
> Well, if we use *_{BEGIN,END} approach, one solution is combining them
> with sections introducing primitives (such as preemp_disable() and
> preempt_enable()), for example, we can add
>
>         #define preempt_disable_for(var)                                \
>         do {                                                            \
>                 preempt_disable();                                      \
>                 ASSERT_EXCLUSIVE_WRITER_BEGIN(var);                     \
>         }
>
>         #define preempt_enable_for(var)                                 \
>         do {                                                            \
>                 ASSERT_EXCLUSIVE_WRITER_END(var);                       \
>                 preempt_enable();                                       \
>         }
>
>         (similar for spin lock)
>
>         #define spin_lock_for(lock, var)                                \
>         do {                                                            \
>                 spin_lock(lock);                                        \
>                 ASSERT_EXCLUSIVE_WRITER_BEGIN(var);                     \
>         }
>
>         #define spin_unlock_for(lock, var)                              \
>         do {                                                            \
>                 ASSERT_EXCLUSIVE_WRITER_END(var);                       \
>                 spin_unlock(lock);                                      \
>         }
>
> I admit that I haven't thought this thoroughly, but I think this works,
> and besides primitives like above can help the reader to understand the
> questions like: what this lock/preemption-off critical sections are
> protecting?

I can't say anything about introducing even more macros. I'd say we
need at least a dozen use-cases or more and understand them, otherwise
we may end up with the wrong API that we can never take back.

> Thoughts?

Makes sense for the cases you described.

Changing KCSAN to do this is a major change. On surface, it seems like
a refactor and exporting some existing functionality, but there are
various new corner cases, because now 2 accesses don't really have to
be concurrent anymore to detect a race (and simple properties like a
thread can't race with itself need to be taken care of). The existing
ASSERT_EXCLUSIVE macros were able to leverage existing functionality
mostly as-is. So, to motivate something like this, we need at least a
dozen or so good use-cases, where careful placement of an existing
ASSERT_EXCLUSIVE would not catch what you describe.

Thanks,
-- Marco

> Regards,
> Boqun
>
> > == Improving race detection for KCSAN_ACCESS_ASSERT access types ==
> > There are several options:
> >
> > 1. Always set up a watchpoint for assert-type accesses, and ignore
> > KCSAN_SKIP_WATCH/kcsan_skip counter (see 'should_watch()'). One
> > problem with this is that it would seriously impact overall
> > performance as soon as we get a few ASSERT_EXCLUSIVE_*() in a hot path
> > somewhere. A compromise might be simply being more aggressive with
> > setting up watchpoints on assert-type accesses.
> >
> > 2. Let's say in the above example (without BEGIN/END) the total
> > duration (via udelay) of watchpoints for 'var' being set up is 4*D.
> > Why not just increase the watchpoint delay for assert-type accesses to
> > 4*D? Then, just having one ASSERT_EXCLUSIVE_WRITER(var) somewhere in
> > the region would have the same probability of catching a race.
> > (Assuming that the region's remaining execution time is on the order
> > of nanosecs.)
> >
> > I have some limited evidence that (1) is going to help, but not (2).
> > This is based on experiments trying to reproduce racy use-after-free
> > bugs that KASAN found, but with KCSAN. The problem is that it does
> > slow-down overall system performance if in a hot path like an
> > allocator. Which led me to a 3rd option.
> >
> > 3. Do option (1) but do the opposite of (2), i.e. always set up a
> > watchpoint on assert-type accesses, but *reduce* the watchpoint delay.
> >
> > I haven't yet sent a patch for any one of 1-3 because I'm hesitant
> > until we can actually show one of them would always be useful and
> > improve things. For now, the best thing is to dynamically adjust
> > udelay_{task,interrupt} and skip_watch either via Kconfig options or
> > /sys/modules/kcsan/parameters/ and not add more complexity without
> > good justification. A good stress test will also go a long way.
> >
> > There are some more (probably bad) ideas I have, but the above are the
> > best options for now.
> >
> > So, anything that somehow increases the total time that a watchpoint
> > is set up will increase the probability of detecting a race. However,
> > we're also trying to balance overall system performance, as poor
> > performance could equally affect race detection negatively (fewer
> > instructions executed, etc.). Right now any one of 1-3 might sound
> > like a decent idea, but I don't know what it will look like once we
> > have dozens of ASSERT_EXCLUSIVE_*() in places, especially if a few of
> > them are in hot paths.
> >
> > Thanks,
> > -- Marco
> >
> >
> >
> >
> >
> >
> > > Regards,
> > > Boqun
> > >
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
> > > > + * assertion can be used to specify properties of concurrent code, where
> > > > + * violation cannot be detected as a normal data race.
> > > > + *
> > > > + * For example, in a reference-counting algorithm where exclusive access is
> > > > + * expected after the refcount reaches 0. We can check that this property
> > > > + * actually holds as follows:
> > > > + *
> > > > + *   if (refcount_dec_and_test(&obj->refcnt)) {
> > > > + *           ASSERT_EXCLUSIVE_ACCESS(*obj);
> > > > + *           safely_dispose_of(obj);
> > > > + *   }
> > > > + *
> > > > + * @var variable to assert on
> > > > + */
> > > > +#define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
> > > > +     __kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
> > > > +
> > > >  #endif /* _LINUX_KCSAN_CHECKS_H */
> > > > --
> > > > 2.9.5
> > > >
