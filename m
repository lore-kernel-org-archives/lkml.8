Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C2CC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE03220768
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNnqo+bV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCSDXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:23:36 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45856 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 23:23:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id z8so621944qto.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 20:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G3jgg7jUsrwjzV0RJBqO0y67Hy+me0H+xWLnisPRBms=;
        b=SNnqo+bV83FWx0JNguQJs++jl4oSPX2fBZqqSxKq35pIWFbzQuxuZVlkIsh+jMQBa7
         sXaH62cZ5hXV6WyLOpLY1dhkscsXZ2IjEivJI9R5J3DhObmft+Fbh404Xboxnz27IBEy
         EIwzNhL1/0+En0gFGUc1msXe4wA0nKn/dxdFJUi+1t0yKZR5C3wALIXMR1HtVk52maLw
         0epYTHicdvvLD9EnI/pEN0ihQy3Z1AFkRosrI4s9qovic9iytICWSZ2266EZLZdbiscy
         evnx3jhbR449vVok73PUj6fS9plsw802zY4gp963eaIrThboGt1cx0cVDpaZaLrrBJPz
         IaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3jgg7jUsrwjzV0RJBqO0y67Hy+me0H+xWLnisPRBms=;
        b=f0qy838siNl6PzADWaMoWfOmNSUmTPxYxEIwT3yK0sdZUNvTmSTppL925H/QQ6+WAp
         ziB34yfp1czgFP0nEUMbz1rEf9fTA5EEBI6Va8ThwNrJJivioX1lZ02vPi5aQuv9JyaR
         djhGHHanBJGcoApr2ynYkCDP4Abr2uEyGHQK88ZaE+rxAAtcyy8y9RI3e4DKyNvNgO7B
         YJ8Y4AHFBFhWnb1WUSmRf+Ua1JY6QrcaEiJznCVb55EuBOfEiEVjA/dPq7sn8XMmwycP
         cp54xRvc9paf4AHmjbyz7d6dgv9MmSzsdaYiEsAy3nGur5CBJ+CHmVbKokwBj6KAAVcO
         WsfA==
X-Gm-Message-State: ANhLgQ1y0qJNdEQu4yONaVMgDJAFZFMIwfUpCR6PtVC/kEDtuta9Y0EF
        kPxxjlxxIiv7ZPVLClqYfbA=
X-Google-Smtp-Source: ADFU+vuQihjJXl0tYvIJzjsarc7WH8hJ+nSLJpvTc6STPFAO+qgwGWP9MuacMrRzmUeLGEynRv3OyA==
X-Received: by 2002:ac8:41d4:: with SMTP id o20mr890283qtm.201.1584588212920;
        Wed, 18 Mar 2020 20:23:32 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b7sm692147qkc.61.2020.03.18.20.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 20:23:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 365BC27C005A;
        Wed, 18 Mar 2020 23:23:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 18 Mar 2020 23:23:29 -0400
X-ME-Sender: <xms:sOVyXrAtF7h54i0UWXX4ulLFH8v1NTnJJdwUA6sKGBBmTK-emDNGfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefkedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeehvd
    drudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:sOVyXt2A1bQLYTtyUOMtug9KygK_DCGXkmmZzkhlhopWPw2KS3DTxA>
    <xmx:sOVyXpV1aVEObKRE9n6mhAJPdxdc_-btnKvzUYCnuGVhtUjFGG35uA>
    <xmx:sOVyXvmNet0HEsCqLWWjNa1gdMaDq0t3w7QHcVb6g12PQHMVtrJzNA>
    <xmx:seVyXrjxuIKkdAeSPGBGKPilHb3ZUzhXTEtnM5TcpAmRE_JPx5r3MdZF3GM>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 184AE3060F09;
        Wed, 18 Mar 2020 23:23:27 -0400 (EDT)
Date:   Thu, 19 Mar 2020 11:23:26 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH kcsan 17/32] kcsan: Introduce ASSERT_EXCLUSIVE_* macros
Message-ID: <20200319032326.GE105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
 <20200309190420.6100-17-paulmck@kernel.org>
 <20200313085220.GC105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <CANpmjNO-hjVfp729YOGdoiuwWjLacW+OCJ=5RnxEYGvQjfQGhA@mail.gmail.com>
 <20200314022210.GD105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <CANpmjNPu67nnaWbOtA8xntBWafDm5Ykspzj43wuSdRckLGC=UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPu67nnaWbOtA8xntBWafDm5Ykspzj43wuSdRckLGC=UA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 12:12:36PM +0100, Marco Elver wrote:
> On Sat, 14 Mar 2020 at 03:22, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Fri, Mar 13, 2020 at 05:15:32PM +0100, Marco Elver wrote:
> > > On Fri, 13 Mar 2020 at 09:52, Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > Hi Marco,
> > > >
> > > > On Mon, Mar 09, 2020 at 12:04:05PM -0700, paulmck@kernel.org wrote:
> > > > > From: Marco Elver <elver@google.com>
> > > > >
> > > > > Introduces ASSERT_EXCLUSIVE_WRITER and ASSERT_EXCLUSIVE_ACCESS, which
> > > > > may be used to assert properties of synchronization logic, where
> > > > > violation cannot be detected as a normal data race.
> > > > >
> > > > > Examples of the reports that may be generated:
> > > > >
> > > > >     ==================================================================
> > > > >     BUG: KCSAN: assert: race in test_thread / test_thread
> > > > >
> > > > >     write to 0xffffffffab3d1540 of 8 bytes by task 466 on cpu 2:
> > > > >      test_thread+0x8d/0x111
> > > > >      debugfs_write.cold+0x32/0x44
> > > > >      ...
> > > > >
> > > > >     assert no writes to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
> > > > >      test_thread+0xa3/0x111
> > > > >      debugfs_write.cold+0x32/0x44
> > > > >      ...
> > > > >     ==================================================================
> > > > >
> > > > >     ==================================================================
> > > > >     BUG: KCSAN: assert: race in test_thread / test_thread
> > > > >
> > > > >     assert no accesses to 0xffffffffab3d1540 of 8 bytes by task 465 on cpu 1:
> > > > >      test_thread+0xb9/0x111
> > > > >      debugfs_write.cold+0x32/0x44
> > > > >      ...
> > > > >
> > > > >     read to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
> > > > >      test_thread+0x77/0x111
> > > > >      debugfs_write.cold+0x32/0x44
> > > > >      ...
> > > > >     ==================================================================
> > > > >
> > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > ---
> > > > >  include/linux/kcsan-checks.h | 40 ++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 40 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> > > > > index 5dcadc2..cf69617 100644
> > > > > --- a/include/linux/kcsan-checks.h
> > > > > +++ b/include/linux/kcsan-checks.h
> > > > > @@ -96,4 +96,44 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
> > > > >       kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
> > > > >  #endif
> > > > >
> > > > > +/**
> > > > > + * ASSERT_EXCLUSIVE_WRITER - assert no other threads are writing @var
> > > > > + *
> > > > > + * Assert that there are no other threads writing @var; other readers are
> > > > > + * allowed. This assertion can be used to specify properties of concurrent code,
> > > > > + * where violation cannot be detected as a normal data race.
> > > > > + *
> > > >
> > > > I like the idea that we can assert no other writers, however I think
> > > > assertions like ASSERT_EXCLUSIVE_WRITER() are a little limited. For
> > > > example, if we have the following code:
> > > >
> > > >         preempt_disable();
> > > >         do_sth();
> > > >         raw_cpu_write(var, 1);
> > > >         do_sth_else();
> > > >         preempt_enable();
> > > >
> > > > we can add the assert to detect another potential writer like:
> > > >
> > > >         preempt_disable();
> > > >         do_sth();
> > > >         ASSERT_EXCLUSIVE_WRITER(var);
> > > >         raw_cpu_write(var, 1);
> > > >         do_sth_else();
> > > >         preempt_enable();
> > > >
> > > > , but, if I understand how KCSAN works correctly, it only works if the
> > > > another writer happens when the ASSERT_EXCLUSIVE_WRITER(var) is called,
> > > > IOW, it can only detect another writer between do_sth() and
> > > > raw_cpu_write(). But our intent is to prevent other writers for the
> > > > whole preemption-off section. With this assertion introduced, people may
> > > > end up with code like:
> > >
> > > To confirm: KCSAN will detect a race if it sets up a watchpoint on
> > > ASSERT_EXCLUSIVE_WRITER(var), and a concurrent write happens. Note
> > > that the watchpoints aren't always set up, but only periodically
> > > (discussed more below). For every watchpoint, we also inject an
> > > artificial delay. Pseudo-code:
> > >
> > > if watchpoint for access already set up {
> > >   consume watchpoint;
> > > else if should set up watchpoint {
> > >   setup watchpoint;
> > >   udelay(...);
> > >   check watchpoint consumed;
> > >   release watchpoint;
> > > }
> > >
> >
> > Yes, I get this part.
> >
> > > >         preempt_disable();
> > > >         ASSERT_EXCLUSIVE_WRITER(var);
> > > >         do_sth();
> > > >         ASSERT_EXCLUSIVE_WRITER(var);
> > > >         raw_cpu_write(var, 1);
> > > >         ASSERT_EXCLUSIVE_WRITER(var);
> > > >         do_sth_else();
> > > >         ASSERT_EXCLUSIVE_WRITER(var);
> > > >         preempt_enable();
> > > >
> > > > and that is horrible...
> > >
> > > It is, and I would strongly discourage any such use, because it's not
> > > necessary. See below.
> > >
> > > > So how about making a pair of annotations
> > > > ASSERT_EXCLUSIVE_WRITER_BEGIN() and ASSERT_EXCLUSIVE_WRITER_END(), so
> > > > that we can write code like:
> > > >
> > > >         preempt_disable();
> > > >         ASSERT_EXCLUSIVE_WRITER_BEGIN(var);
> > > >         do_sth();
> > > >         raw_cpu_write(var, 1);
> > > >         do_sth_else();
> > > >         ASSERT_EXCLUSIVE_WRITER_END(var);
> > > >         preempt_enable();
> > > >
> > > > ASSERT_EXCLUSIVE_WRITER_BEGIN() could be a rough version of watchpoint
> > > > setting up and ASSERT_EXCLUSIVE_WRITER_END() could be watchpoint
> > > > removing. So I think it's feasible.
> > >
> > > Keep in mind that the time from ASSERT_EXCLUSIVE_WRITER_BEGIN to END
> > > might be on the order of a few nanosec, whereas KCSAN's default
> > > watchpoint delay is 10s of microsec (default ~80 for tasks). That
> > > means we would still have to set up a delay somewhere, and the few
> > > nanosec between BEGIN and END are insignificant and don't buy us
> > > anything.
> > >
> >
> > Yeah, the delay doesn't buy us anything given the default watchpoint
> > delay, and I agree even with *_{BEGIN/END}, we still need to set up a
> > delay somewhere. Adding a delay makes the watchpoint live longer so that
> > a problem will more likely happen, but sometimes the delay won't be
> > enough, considering another writer like:
> >
> >         if (per_cpu(var, cpu) == 1)
> >                 per_cpu(var, cpu) = 0;
> >
> > in this user case, percpu variable "var" is used for maintaining some
> > state machine, and a CPU set a state with its own variable so that other
> > CPUs can consume it. And this another writer cannot be catched by:
> >
> >         preempt_disable();
> >         do_sth();
> >         ASSERT_EXCLUSIVE_WRITER(var);
> >         raw_cpu_write(var, 1);
> >         do_sth_else();
> >         preempt_enable();
> >
> 
> Right, the example makes sense.
> 
> That is assuming there are various other expected racy reads that are
> fine. If that's not true, ASSERT_EXCLUSIVE_ACCESS should be
> considered.
> 
> > , no matter how long the delay is set. Another example: let's say the
> > do_sth_else() above is actually an operation that queues a callback
> > which writes to "var". In one version, do_sth_else() uses call_rcu(),
> > which works, because preemption-off is treated as RCU read-side critical
> > section, so we are fine. But if someone else changes it to queue_work()
> > for some reason, the code is just broken, and KCSAN cannot detect it, no
> > matter how long the delay is.
> >
> > To summarize, a delay is helpful to trigger a problem because it allows
> > _other_ CPU/threads to run more code and do more memory accesses,
> > however it's not helpful if a particular problem happens due to some
> > memory effects of the current/watched CPU/thread. While *_{BEGIN/END}
> > can be helpful in this case.
> 
> Makes sense.
> 
> > > Re feasibility: Right now setting up and removing watchpoints is not
> > > exposed, and doing something like this would be an extremely intrusive
> > > change. Because of that, without being able to quantify the actual
> > > usefulness of this, and having evaluated better options (see below),
> > > I'd recommend not pursuing this.
> > >
> > > > Thoughts?
> > >
> > > Firstly, what is your objective? From what I gather you want to
> > > increase the probability of detecting a race with 'var'.
> > >
> >
> > Right, I want to increase the probablity.
> >
> > > I agree, and have been thinking about it, but there are other options
> > > that haven't been exhausted, before we go and make the interface more
> > > complicated.
> > >
> > > == Interface design ==
> > > The interface as it is right now, is intuitive and using it is hard to
> > > get wrong. Demanding begin/end markers introduces complexity that will
> >
> > Yeah, the interface is intuitive, however it's still an extra effort to
> > put those assertions, right? Which means it doesn't come for free,
> > compared to other detection KCSAN can do, the developers don't need to
> > put extra lines of code. Given the extra effort for developers to use
> > the detect, I think we should dicuss the design thoroughly.
> >
> > Besides the semantics of assertions is usually "do some checking right
> > now to see if things go wrong", and I don't think it quite matches the
> > semantics of an exclusive writer: "in this piece of code, I'm the only
> > one who can do the write".
> >
> > > undoubtedly result in incorrect usage, because as soon as you somehow
> > > forget to end the region, you'll get tons of false positives. This may
> > > be due to control-flow that was missed etc. We had a similar problem
> > > with seqlocks, and getting them to work correctly with KCSAN was
> > > extremely difficult, because clear begin and end markers weren't
> > > always given. I imagine introducing an interface like this will
> > > ultimately result in similar problems, as much as we'd like to believe
> > > this won't ever happen.
> > >
> >
> > Well, if we use *_{BEGIN,END} approach, one solution is combining them
> > with sections introducing primitives (such as preemp_disable() and
> > preempt_enable()), for example, we can add
> >
> >         #define preempt_disable_for(var)                                \
> >         do {                                                            \
> >                 preempt_disable();                                      \
> >                 ASSERT_EXCLUSIVE_WRITER_BEGIN(var);                     \
> >         }
> >
> >         #define preempt_enable_for(var)                                 \
> >         do {                                                            \
> >                 ASSERT_EXCLUSIVE_WRITER_END(var);                       \
> >                 preempt_enable();                                       \
> >         }
> >
> >         (similar for spin lock)
> >
> >         #define spin_lock_for(lock, var)                                \
> >         do {                                                            \
> >                 spin_lock(lock);                                        \
> >                 ASSERT_EXCLUSIVE_WRITER_BEGIN(var);                     \
> >         }
> >
> >         #define spin_unlock_for(lock, var)                              \
> >         do {                                                            \
> >                 ASSERT_EXCLUSIVE_WRITER_END(var);                       \
> >                 spin_unlock(lock);                                      \
> >         }
> >
> > I admit that I haven't thought this thoroughly, but I think this works,
> > and besides primitives like above can help the reader to understand the
> > questions like: what this lock/preemption-off critical sections are
> > protecting?
> 
> I can't say anything about introducing even more macros. I'd say we
> need at least a dozen use-cases or more and understand them, otherwise
> we may end up with the wrong API that we can never take back.
> 

Agreed, real use-cases are needed for the justification of introducing
those APIs.

> > Thoughts?
> 
> Makes sense for the cases you described.
> 
> Changing KCSAN to do this is a major change. On surface, it seems like
> a refactor and exporting some existing functionality, but there are
> various new corner cases, because now 2 accesses don't really have to
> be concurrent anymore to detect a race (and simple properties like a
> thread can't race with itself need to be taken care of). The existing
> ASSERT_EXCLUSIVE macros were able to leverage existing functionality
> mostly as-is. So, to motivate something like this, we need at least a
> dozen or so good use-cases, where careful placement of an existing
> ASSERT_EXCLUSIVE would not catch what you describe.
> 

Right, I think at this point, I'm not object to merging this into
kernel, using ASSERT_EXCLUSIVE_*() does provide more chances for us to
catch bugs. That said, I think it's better if we have some comments
describing the semantics (or the limitation) of the annotations to avoid
"mis-use"s (for example, using multiple ASSERT_EXCLUSIVE_WRITER()s for
one variables in a function). But that doesn't necessarily block the
merge of this feature, we can always do that later.

Also, I think it's worthwhile to do some experiments on the
*_{BEGIN,END} interfaces. If you're interested and have cycles to work
on this, please let me, othwerwise, I can have a look at it.

Thanks!

Regards,
Boqun


> Thanks,
> -- Marco
> 
> > Regards,
> > Boqun
> >
[...]
