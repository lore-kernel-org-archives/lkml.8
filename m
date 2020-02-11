Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26200C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39D720870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2/994BZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgBKQII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:08:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42405 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbgBKQIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:08:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so10589609otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 08:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hnUT6qESAq7DlFLNCIERdoa2al8Z8MvMWl2WRSW1VA=;
        b=i2/994BZwHIwIUx7NGS2mlvS5svoj0DIDzS0VWKwdpZYsNoo0yXsp/8hEBQ1LDvDM5
         +ROySafKtus8buTdY9nkbs6W7kWRPtbJb9G+FUhLZC4yWB5p0wlSlc/GkJxMr2YdjvXD
         brWYt34b0qWigfFpPQtL5siLvCenik9FbkzBbn0ZTNYTJeDthenWB/NyMGeBHHgWqeib
         haiTzmwaFlZ5q5n+LHeNsPZGAkYGAvVmtkIG+YDQ4PfJWrWsjr/wQk+TI9AhnU+ZcTwP
         vKZVjH6whLAGk1ciow0cSVz2Ys67l4F/kywEfNjl+jjikR8OqMP7fPh1G9XEFn1q+vU/
         90/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hnUT6qESAq7DlFLNCIERdoa2al8Z8MvMWl2WRSW1VA=;
        b=Pt9dt8kWRq4u3W9Jhf2zFrb3oUr4G2z2ggnICXb9F1s4o+Zexo1bWYLR1XnTReF68b
         pKG/Gysxi8vSOHQERZumtZgbE9ZhR005y87WyNHENIrsj2l/tQkCdSu6pYq05RplMe7Y
         LUcQ1NjiqSnkcHi2o0vOtu+nPwzx1MJGQ9wCTlK0h0xVG4g3VYo//ulqOjxznYVe1jKe
         UqylAalOq07B+DbdSKClKLF0dDAgUJc+dZzDlSoC4esGm9zch/hFGY9TPVAmXg4lzDvq
         eLRAEKn1SKbFNz6RwGgim1pE0gajumaVZZEEtriCfW4Rqo3bWWcZC8kLPGdmUnmClVYe
         1Mig==
X-Gm-Message-State: APjAAAXruT6jrs4+yt/nz4GyOaep99YoasVKvbXWuspyayfofXlwuJBx
        +9IKjsnBfGJ46CKjaKAmJPKTZnJrDzIrGIyKh8daTg==
X-Google-Smtp-Source: APXvYqwakplkQ7nkZyMOyWSaoAiV6URYHO2AWlxQ9jMDKcGcjOFrNHIij3LwLbQPIHuIGbSaB18wbBgb5DEDdYmBSzY=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr6082544otq.17.1581437285234;
 Tue, 11 Feb 2020 08:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20200210184317.233039-1-elver@google.com> <20200210184317.233039-5-elver@google.com>
 <3963b39c-bdc9-d188-a086-f5ea443477d1@nvidia.com>
In-Reply-To: <3963b39c-bdc9-d188-a086-f5ea443477d1@nvidia.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 11 Feb 2020 17:07:53 +0100
Message-ID: <CANpmjNNJbt3HRg-CNw8w5jnfNzU0hNqd8Y-r1J9_H0o83MvO5w@mail.gmail.com>
Subject: Re: [PATCH 5/5] kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask)
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: https://lore.kernel.org/lkml/20200211160423.138870-5-elver@google.com/

On Mon, 10 Feb 2020 at 22:07, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2/10/20 10:43 AM, Marco Elver wrote:
> > This introduces ASSERT_EXCLUSIVE_BITS(var, mask).
> > ASSERT_EXCLUSIVE_BITS(var, mask) will cause KCSAN to assume that the
> > following access is safe w.r.t. data races (however, please see the
> > docbook comment for disclaimer here).
> >
> > For more context on why this was considered necessary, please see:
> >   http://lkml.kernel.org/r/1580995070-25139-1-git-send-email-cai@lca.pw
> >
> > In particular, data races between reads (that use @mask bits of an
> > access that should not be modified concurrently) and writes (that change
> > ~@mask bits not used by the read) should ordinarily be marked. After
> > marking these, we would no longer be able to detect harmful races
> > between reads to @mask bits and writes to @mask bits.
>
> I know this is "just" the commit log, but as long as I'm reviewing the
> whole thing...to make the above a little clearer, see if you like this
> revised wording:
>
> In particular, before this patch, data races between reads (that use
> @mask bits of an access that should not be modified concurrently) and
> writes (that change ~@mask bits not used by the readers) would have
> been annotated with "data_race()". However, doing so would then hide
> real problems: we would no longer be able to detect harmful races
> between reads to @mask bits and writes to @mask bits.

Thanks, applied.

> >
> > Therefore, by using ASSERT_EXCLUSIVE_BITS(var, mask), we accomplish:
> >
> >   1. No new macros introduced elsewhere; since there are numerous ways in
> >      which we can extract the same bits, a one-size-fits-all macro is
> >      less preferred.
>
> This somehow confuses me a lot. Maybe say it like this:
>
> 1. Avoid a proliferation of specific macros at the call sites: by including a
>    mask in the argument list, we can use the same macro in a wide variety of
>    call sites, regardless of which bits in a field each call site uses.
>
> ?

Thanks, I took that mostly as-is.

> >
> >   2. The existing code does not need to be modified (although READ_ONCE()
> >      may still be advisable if we cannot prove that the data race is
> >      always safe).
> >
> >   3. We catch bugs where the exclusive bits are modified concurrently.
> >
> >   4. We document properties of the current code.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Qian Cai <cai@lca.pw>
> > ---
> >  include/linux/kcsan-checks.h | 57 ++++++++++++++++++++++++++++++++----
> >  kernel/kcsan/debugfs.c       | 15 +++++++++-
> >  2 files changed, 65 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> > index 4ef5233ff3f04..eae6030cd4348 100644
> > --- a/include/linux/kcsan-checks.h
> > +++ b/include/linux/kcsan-checks.h
> > @@ -152,9 +152,9 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
> >  #endif
> >
> >  /**
> > - * ASSERT_EXCLUSIVE_WRITER - assert no other threads are writing @var
> > + * ASSERT_EXCLUSIVE_WRITER - assert no concurrent writes to @var
> >   *
> > - * Assert that there are no other threads writing @var; other readers are
> > + * Assert that there are no concurrent writes to @var; other readers are
> >   * allowed. This assertion can be used to specify properties of concurrent code,
> >   * where violation cannot be detected as a normal data race.
> >   *
> > @@ -171,11 +171,11 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
> >       __kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT)
> >
> >  /**
> > - * ASSERT_EXCLUSIVE_ACCESS - assert no other threads are accessing @var
> > + * ASSERT_EXCLUSIVE_ACCESS - assert no concurrent accesses to @var
> >   *
> > - * Assert that no other thread is accessing @var (no readers nor writers). This
> > - * assertion can be used to specify properties of concurrent code, where
> > - * violation cannot be detected as a normal data race.
> > + * Assert that there are no concurrent accesses to @var (no readers nor
> > + * writers). This assertion can be used to specify properties of concurrent
> > + * code, where violation cannot be detected as a normal data race.
> >   *
> >   * For example, in a reference-counting algorithm where exclusive access is
> >   * expected after the refcount reaches 0. We can check that this property
> > @@ -191,4 +191,49 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
> >  #define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
> >       __kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
> >
> > +/**
> > + * ASSERT_EXCLUSIVE_BITS - assert no concurrent writes to subset of bits in @var
> > + *
> > + * [Bit-granular variant of ASSERT_EXCLUSIVE_WRITER(var)]
>
>
> No need for the square brackets, unless that's some emerging convention in the
> documentation world.

Done.

>
> > + *
> > + * Assert that there are no concurrent writes to a subset of bits in @var;
> > + * concurrent readers are permitted. Concurrent writes (or reads) to ~@mask bits
> > + * are ignored. This assertion can be used to specify properties of concurrent
> > + * code, where marked accesses imply violations cannot be detected as a normal
> > + * data race.
>
>
> How about this wording:
>
> /*
>  * Assert that there are no concurrent writes to a subset of bits in @var;
>  * concurrent readers are permitted. Concurrent writes (or reads) to ~@mask bits
>  * are ignored. This assertion provides more detailed, bit-level information to
>  * the KCSAN system than most of the other (word granularity) annotations. As
>  * such, it allows KCSAN to safely overlook some bits while still continuing to
>  * check the remaining bits for unsafe access patterns.
>  *
>  * Use this if you have some bits that are read-only, and other bits that are
>  * not, within a variable.
>  */
>
> ?

I've updated it based on the information you want to convey here. I've
removed mention to KCSAN in the first paragraph, since KCSAN is an
implementation of this, but a user of the API shouldn't care too much
about that.

Hopefully it makes more sense in v2.

>
> > + *
> > + * For example, this may be used when certain bits of @var may only be modified
> > + * when holding the appropriate lock, but other bits may still be modified
> > + * concurrently. Writers, where other bits may change concurrently, could use
> > + * the assertion as follows:
> > + *
> > + *   spin_lock(&foo_lock);
> > + *   ASSERT_EXCLUSIVE_BITS(flags, FOO_MASK);
> > + *   old_flags = READ_ONCE(flags);
> > + *   new_flags = (old_flags & ~FOO_MASK) | (new_foo << FOO_SHIFT);
> > + *   if (cmpxchg(&flags, old_flags, new_flags) != old_flags) { ... }
> > + *   spin_unlock(&foo_lock);
> > + *
> > + * Readers, could use it as follows:
> > + *
> > + *   ASSERT_EXCLUSIVE_BITS(flags, FOO_MASK);
> > + *   foo = (READ_ONCE(flags) & FOO_MASK) >> FOO_SHIFT;
>
>
> In the general case (which is what this documentation covers), the
> READ_ONCE() is not required. So this should either leave it out, or
> explain that it's not necessarily required.

I've updated the example to lead to the fact you can omit the
READ_ONCE. However, I want to be very careful here, since I still
can't prove to myself no compiler will mess this up. In the general
case, we likely won't need the READ_ONCE, because you'd need a pretty
unfortunate compiler + architecture combo to mess this up for you. But
you never know.

Thanks,
-- Marco

>
> > + *
> > + * NOTE: The access that immediately follows is assumed to access the masked
> > + * bits only, and safe w.r.t. data races. While marking this access is optional
> > + * from KCSAN's point-of-view, it may still be advisable to do so, since we
> > + * cannot reason about all possible compiler optimizations when it comes to bit
> > + * manipulations (on the reader and writer side).
> > + *
> > + * @var variable to assert on
> > + * @mask only check for modifications to bits set in @mask
> > + */
> > +#define ASSERT_EXCLUSIVE_BITS(var, mask)                                       \
>
>
> This API looks good to me.
>
>
> > +     do {                                                                   \
> > +             kcsan_set_access_mask(mask);                                   \
> > +             __kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT);\
> > +             kcsan_set_access_mask(0);                                      \
> > +             kcsan_atomic_next(1);                                          \
> > +     } while (0)
> > +
> >  #endif /* _LINUX_KCSAN_CHECKS_H */
> > diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> > index 9bbba0e57c9b3..2ff1961239778 100644
> > --- a/kernel/kcsan/debugfs.c
> > +++ b/kernel/kcsan/debugfs.c
> > @@ -100,8 +100,10 @@ static noinline void microbenchmark(unsigned long iters)
> >   * debugfs file from multiple tasks to generate real conflicts and show reports.
> >   */
> >  static long test_dummy;
> > +static long test_flags;
> >  static noinline void test_thread(unsigned long iters)
> >  {
> > +     const long CHANGE_BITS = 0xff00ff00ff00ff00L;
> >       const struct kcsan_ctx ctx_save = current->kcsan_ctx;
> >       cycles_t cycles;
> >
> > @@ -109,16 +111,27 @@ static noinline void test_thread(unsigned long iters)
> >       memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
> >
> >       pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
> > +     pr_info("test_dummy@%px, test_flags@%px\n", &test_dummy, &test_flags);
> >
> >       cycles = get_cycles();
> >       while (iters--) {
> > +             /* These all should generate reports. */
> >               __kcsan_check_read(&test_dummy, sizeof(test_dummy));
> > -             __kcsan_check_write(&test_dummy, sizeof(test_dummy));
> >               ASSERT_EXCLUSIVE_WRITER(test_dummy);
> >               ASSERT_EXCLUSIVE_ACCESS(test_dummy);
> >
> > +             ASSERT_EXCLUSIVE_BITS(test_flags, ~CHANGE_BITS); /* no report */
> > +             __kcsan_check_read(&test_flags, sizeof(test_flags)); /* no report */
> > +
> > +             ASSERT_EXCLUSIVE_BITS(test_flags, CHANGE_BITS); /* report */
> > +             __kcsan_check_read(&test_flags, sizeof(test_flags)); /* no report */
> > +
> >               /* not actually instrumented */
> >               WRITE_ONCE(test_dummy, iters);  /* to observe value-change */
> > +             __kcsan_check_write(&test_dummy, sizeof(test_dummy));
> > +
> > +             test_flags ^= CHANGE_BITS; /* generate value-change */
> > +             __kcsan_check_write(&test_flags, sizeof(test_flags));
> >       }
> >       cycles = get_cycles() - cycles;
> >
> >
>
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
