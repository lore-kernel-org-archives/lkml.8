Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3D7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E91207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bea7jtiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbgE0HoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387505AbgE0HoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:44:22 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222C6C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 00:44:22 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b18so18514627oti.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 00:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbcumbiOybyvrNPq+S8EAFFWXxgWspgqCp4xRwbHRuI=;
        b=Bea7jtiqrCIc0QUDHNMwR2/RmhcvDSbjKzogX9URL8jhuKlzI1tMUuDG4lu1nwXb9U
         OBiy3Z8laAuU6iAzRHvTeAg8Qjj+V3GmrSyMCnW3huFjdKOVuQrHeBBOpCynX7XI2HFt
         F6glhFUfgn82+sxtWgiKD8V4N25tskGzEMWsK6V7+GoiLCh6NP/gS2T5rMrrchyG1AXB
         wHZTSxk4YieAizKmF+tWvWm3z5uYX7UYwt/cauqCI9j1JATKMHwuM6Un8Xsh8N5M3Tr9
         BjMxiOEo6JJ7snQK3FtICT63NbA0Qlm4wddox+tShoGqA786uW1HE1Tf9klGWKQRhhjv
         tVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbcumbiOybyvrNPq+S8EAFFWXxgWspgqCp4xRwbHRuI=;
        b=lq3am0oamjvLiL5/rBjqwKvOLYy+pEJtYD+42Ops139wzDt+m05rKTumMEglJzya8E
         gy3mxAlEviOjtBA/cm5TtIuRQHBD46JHHena6Z5TMftqchCSA0RyzKRuwqbpF2VnIkRU
         KVd620M26fCOVkEYFXxL54p+pw5YiEeMgZ7XTD1M/jvji31tvCLrT0sTf0EcPrQiC6xW
         UmYyQq1aGxZUAUzDcEkUTsvD7M4LBTvfY1ifMuyH69o4PCwlrEX+S8v0POrd8G3z4/dR
         6FXoXVsi5KhWPpx6EI8ghBis//fjSTyg21B6afu2S5H2WXRDGBTAxP9nJIb51WHiBUwf
         y8vA==
X-Gm-Message-State: AOAM531pkGEAy10vFqJ55wOUE8wUrLxPnXr+a1lDeKOnFt7yKbbWpeZD
        HehiyN9tlw4KoQ1evOCzCQkne1uBGw+kIbH38gA5JHe0+VI=
X-Google-Smtp-Source: ABdhPJxly1n7ae+toEEnchvPRFaQZLHYyFrCcYCS0l/Xg7lhRD3pHthm0aDMtB0QqDvmQ4FqpeTNqWOyWOHnunK6dm4=
X-Received: by 2002:a9d:27a3:: with SMTP id c32mr3972097otb.233.1590565461246;
 Wed, 27 May 2020 00:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200521142047.169334-1-elver@google.com> <20200521142047.169334-10-elver@google.com>
 <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
 <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
 <20200526120245.GB27166@willie-the-truck> <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
 <CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com>
 <20200526173312.GA30240@google.com> <CAK8P3a3ZawPnzmzx4q58--M1h=v4X-1GtQLiwL1=G6rDK8=Wpg@mail.gmail.com>
 <CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com> <20200527072248.GA9887@willie-the-truck>
In-Reply-To: <20200527072248.GA9887@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Wed, 27 May 2020 09:44:09 +0200
Message-ID: <CANpmjNO2A39XRQ9OstwKGKpZ6wQ4ebVcBNfH_ZhCTi8RG6WqYw@mail.gmail.com>
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement expression
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 at 09:22, Will Deacon <will@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 01:10:00AM +0200, Arnd Bergmann wrote:
> > On Tue, May 26, 2020 at 9:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, May 26, 2020 at 7:33 PM 'Marco Elver' via Clang Built Linux
> > > <clang-built-linux@googlegroups.com> wrote:
> > > > On Tue, 26 May 2020, Marco Elver wrote:
> > > > > On Tue, 26 May 2020 at 14:19, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > Note that an 'allyesconfig' selects KASAN and not KCSAN by default.
> > > > > But I think that's not relevant, since KCSAN-specific code was removed
> > > > > from ONCEs. In general though, it is entirely expected that we have a
> > > > > bit longer compile times when we have the instrumentation passes
> > > > > enabled.
> > > > >
> > > > > But as you pointed out, that's irrelevant, and the significant
> > > > > overhead is from parsing and pre-processing. FWIW, we can probably
> > > > > optimize Clang itself a bit:
> > > > > https://github.com/ClangBuiltLinux/linux/issues/1032#issuecomment-633712667
> > > >
> > > > Found that optimizing __unqual_scalar_typeof makes a noticeable
> > > > difference. We could use C11's _Generic if the compiler supports it (and
> > > > all supported versions of Clang certainly do).
> > > >
> > > > Could you verify if the below patch improves compile-times for you? E.g.
> > > > on fs/ocfs2/journal.c I was able to get ~40% compile-time speedup.
> > >
> > > Yes, that brings both the preprocessed size and the time to preprocess it
> > > with clang-11 back to where it is in mainline, and close to the speed with
> > > gcc-10 for this particular file.
> > >
> > > I also cross-checked with gcc-4.9 and gcc-10 and found that they do see
> > > the same increase in the preprocessor output, but it makes little difference
> > > for preprocessing performance on gcc.
> >
> > Just for reference, I've tested this against a patch I made that completely
> > shortcuts READ_ONCE() on anything but alpha (which needs the
> > read_barrier_depends()):
> >
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -224,18 +224,21 @@ void ftrace_likely_update(struct
> > ftrace_likely_data *f, int val,
> >   * atomicity or dependency ordering guarantees. Note that this may result
> >   * in tears!
> >   */
> > -#define __READ_ONCE(x) (*(const volatile __unqual_scalar_typeof(x) *)&(x))
> > +#define __READ_ONCE(x) (*(const volatile typeof(x) *)&(x))
> >
> > +#ifdef CONFIG_ALPHA /* smp_read_barrier_depends is a NOP otherwise */
> >  #define __READ_ONCE_SCALAR(x)                                          \
> >  ({                                                                     \
> >         __unqual_scalar_typeof(x) __x = __READ_ONCE(x);                 \
> >         smp_read_barrier_depends();                                     \
> > -       (typeof(x))__x;                                                 \
> > +       __x;                                                            \
> >  })
> > +#else
> > +#define __READ_ONCE_SCALAR(x) __READ_ONCE(x)
> > +#endif
>
> Nice! FWIW, I'm planning to have Alpha override __READ_ONCE_SCALAR()
> eventually, so that smp_read_barrier_depends() can disappear forever. I
> just bit off more than I can chew for 5.8 :(
>
> However, '__unqual_scalar_typeof()' is still useful for
> load-acquire/store-release on arm64, so we still need a better solution to
> the build-time regression imo. I'm not fond of picking random C11 features
> to accomplish that, but I also don't have any better ideas...

We already use _Static_assert in the kernel, so it's not the first use
of a C11 feature.

> Is there any mileage in the clever trick from Rasmus?
>
> https://lore.kernel.org/r/6cbc8ae1-8eb1-a5a0-a584-2081fca1c4aa@rasmusvillemoes.dk

Apparently that one only works with GCC 7 or newer, and is only
properly defined behaviour since C11. It also relies on multiple
_Pragma. I'd probably take the arguably much cleaner _Generic solution
over that. ;-)

I think given that Peter and Arnd already did some testing, and it
works as intended, if you don't mind, I'll send a patch for the
_Generic version. At least that'll give us a more optimized
__unqual_scalar_typeof(). Any further optimizations to READ_ONCE()
like you mentioned then become a little less urgent.

Thanks,
-- Marco
