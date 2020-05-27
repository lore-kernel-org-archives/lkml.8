Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E06C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982E620899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6zV0SYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgE0TLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgE0TLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:11:21 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C95C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:11:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so27272957iog.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2Bcnmg1EgnfjTcnvj1Aw3QKP56IMZAnvcGT8sqHeRnk=;
        b=n6zV0SYa3HMIKDGtXp33/ZXS8MsjgTD4ACHyj0aXyOmMc/jDoosvG+Vs2Fjla5vTeC
         vuD/5p9wFArAflMZK+c/Poy37rQER83CqqheXAHa8CqJ/FFxA2yuhFra+6AGoCQbCOQ/
         g7gyTckVk8Be6RTfKojiaxAMYmqt9v4BsC+6mmUET4vxqmj/mIGp001qN3Co5CCXJFoo
         2lcGNdOeR/NVVQaAQLs6weCw374BOOyfZkebjloN6BJhIbQUMrgbrVoy4k/IRt/hXra7
         a+hMmgo1kICQLr5vQlQL85sB3z9iZFndTsfPVEfwznlzkwHdLx4uyNvbcjfySiy0a83u
         sNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2Bcnmg1EgnfjTcnvj1Aw3QKP56IMZAnvcGT8sqHeRnk=;
        b=Wgq1v/KgN446aPAPGANuq74i8sZNbG2uGeK5WN85vz3sQYlMJt6pheiYg6Eft5udDy
         yxnwOaKMy8uemQFI1z+84JKvXBGJ1Xu6CkeoWHujcn2hpoOcOoyi4BDxC7LC312UTcCt
         UW/tu7blEoJdyc76rWEHOvWDK6AC8g1qM21hR5ZAD+Igte5FN/4eiSLr2PcIeM9GmSLz
         fol18K8BiC4dje/6l5D3erZlEjSO3wtlkZDlv8lNJbk96svdLL9e0b5A8GbnHv3LRezW
         rprE54mwoS5zmBtgIwgD93HMsSg9V6sIRmyG50F7uv6EnPSFJZ+twNdKOFdd3ErUNtMk
         q12A==
X-Gm-Message-State: AOAM533gWeHxFhQG4Szb3TcL+7S93lw6yHvDGD3g6HvvhHmsM3jLSHTl
        zu4bV5puvti84YTCvDcmjmwzQxfpLnRUhEIRR2M=
X-Google-Smtp-Source: ABdhPJyYVLXaAGBpWy/yCXieG6KwqrOsQh9aH5uM3iOThmzN3RsV4r4RWECD0ewrYT8rdch5/0veTVDZbPwcE7UL/U8=
X-Received: by 2002:a02:5249:: with SMTP id d70mr7200470jab.121.1590606680180;
 Wed, 27 May 2020 12:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200527103236.148700-1-elver@google.com> <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
 <CA+icZUWtzu0ONUSy0E27Mq1BrdO79qNaY3Si-PDhHZyF8M4S5g@mail.gmail.com>
 <CAK8P3a04=mVQgSrvDhpVxQj50JEFDn_xMhYrvjmUnLYTWH3QXQ@mail.gmail.com>
 <CA+icZUXVSTxDYJwXLyAwZd91cjMPcPRpeAR72JKqkqa-wRNnWg@mail.gmail.com>
 <CAK8P3a3i0kPf8dRg7Ko-33hsb+LkP=P05uz2tGvg5B43O-hFvg@mail.gmail.com>
 <CA+icZUWr5xDz5ujBfsXjnDdiBuopaGE6xO5LJQP9_y=YoROb+Q@mail.gmail.com>
 <CANpmjNOtKQAB_3t1G5Da-J1k-9Dk6eQKP+xNozRbmHJXZqXGFw@mail.gmail.com>
 <CA+icZUWzPMOj+qsDz-5Z3tD-hX5gcowjBkwYyiy8SL36Jg+2Nw@mail.gmail.com> <CANpmjNOPcFSr2n_ro8TqhOBXOBfUY0vZtj_VT7hh3HOhJN4BqQ@mail.gmail.com>
In-Reply-To: <CANpmjNOPcFSr2n_ro8TqhOBXOBfUY0vZtj_VT7hh3HOhJN4BqQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 27 May 2020 21:11:13 +0200
Message-ID: <CA+icZUVK=5agY_FPdPeRbZyn3EoUgnmPToR3iGWuCzY+KHtoAA@mail.gmail.com>
Subject: Re: [PATCH -tip] compiler_types.h: Optimize __unqual_scalar_typeof
 compilation time
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:57 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 27 May 2020 at 15:37, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Wed, May 27, 2020 at 3:30 PM Marco Elver <elver@google.com> wrote:
> > >
> > > On Wed, 27 May 2020 at 15:11, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Wed, May 27, 2020 at 2:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > >
> > > > > On Wed, May 27, 2020 at 2:35 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > > On Wed, May 27, 2020 at 2:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > On Wed, May 27, 2020 at 1:36 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > > > > On Wed, May 27, 2020 at 1:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > > > On Wed, May 27, 2020 at 12:33 PM Marco Elver <elver@google.com> wrote:
> > > > > > > > >
> > > > > > > > > This gives us back 80% of the performance drop on clang, and 50%
> > > > > > > > > of the drop I saw with gcc, compared to current mainline.
> > > > > > > > >
> > > > > > > > > Tested-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > > > >
> > > > > > > >
> > > > > > > > Hi Arnd,
> > > > > > > >
> > > > > > > > with "mainline" you mean Linux-next aka Linux v5.8 - not v5.7?
> > > > > > >
> > > > > > > I meant v5.7.
> > > > > > >
> > > > > > > > I have not seen __unqual_scalar_typeof(x) in compiler_types.h in Linux v5.7.
> > > > > > > >
> > > > > > > > Is there a speedup benefit also for Linux v5.7?
> > > > > > > > Which patches do I need?
> > > > > > >
> > > > > > > v5.7-rc is the baseline and is the fastest I currently see. On certain files,
> > > > > > > I saw an intermittent 10x slowdown that was already fixed earlier, now
> > > > > > > linux-next
> > > > > > > is more like 2x slowdown for me and 1.2x with this patch on top, so we're
> > > > > > > almost back to the speed of linux-5.7.
> > > > > > >
> > > > > >
> > > > > > Which clang version did you use - and have you set KCSAN kconfigs -
> > > > > > AFAICS this needs clang-11?
> > > > >
> > > > > I'm currently using clang-11, but I see the same problem with older
> > > > > versions, and both with and without KCSAN enabled. I think the issue
> > > > > is mostly the deep nesting of macros that leads to code bloat.
> > > > >
> > > >
> > > > Thanks.
> > > >
> > > > With clang-10:
> > > >
> > > > $ scripts/diffconfig /boot/config-5.7.0-rc7-2-amd64-clang .config
> > > >  BUILD_SALT "5.7.0-rc7-2-amd64-clang" -> "5.7.0-rc7-3-amd64-clang"
> > > > +HAVE_ARCH_KCSAN y
> > >
> > > Clang 10 doesn't support KCSAN (HAVE_KCSAN_COMPILER unset).
> > >
> > > > With clang-11:
> > > >
> > > > $ scripts/diffconfig /boot/config-5.7.0-rc7-2-amd64-clang .config
> > > >  BUILD_SALT "5.7.0-rc7-2-amd64-clang" -> "5.7.0-rc7-3-amd64-clang"
> > > >  CLANG_VERSION 100001 -> 110000
> > > > +CC_HAS_ASM_INLINE y
> > > > +HAVE_ARCH_KCSAN y
> > > > +HAVE_KCSAN_COMPILER y
> > > > +KCSAN n
> > > >
> > > > Which KCSAN kconfigs did you enable?
> > >
> > > To clarify: as said in [1], KCSAN (or any other instrumentation) is no
> > > longer relevant to the issue here, and the compile-time regression is
> > > observable with most configs. The problem is due to pre-processing and
> > > parsing, which came about due to new READ_ONCE() and the
> > > __unqual_scalar_typeof() macro (which this patch optimizes).
> > >
> > > KCSAN and new ONCEs got tangled up because we first attempted to
> > > annotate {READ,WRITE}_ONCE() with data_race(), but that turned out to
> > > have all kinds of other issues (explanation in [2]). So we decided to
> > > drop all the KCSAN-specific bits from ONCE, and require KCSAN to be
> > > Clang 11. Those fixes were applied to the first version of new
> > > {READ,WRITE}_ONCE() in -tip, which actually restored the new ONCEs to
> > > the pre-KCSAN version (now that KCSAN can deal with them without
> > > annotations).
> > >
> > > Hope this makes more sense now.
> > >
> > > [1] https://lore.kernel.org/lkml/CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com/
> > > [2] https://lore.kernel.org/lkml/20200521142047.169334-1-elver@google.com/
> > >
> >
> > Thanks, Marco.
> >
> > I pulled tip.git#locking/kcsan on top of Linux v5.7-rc7 and applied this patch.
> > Just wanted to try KCSAN for the first time and it will also be my
> > first building with clang-11.
> > That's why I asked.
>
> In general, CONFIG_KCSAN=y and the defaults for the other KCSAN
> options should be good. Depending on the size of your system, you
> could also tweak KCSAN runtime performance:
> https://lwn.net/Articles/816850/#Interacting%20with%20KCSAN%20at%20Runtime
> -- the defaults should be good for most systems though.
> Hope this helps. Any more questions, do let me know.
>

Which "projects" and packages do I need?

I have installed:

# LC_ALL=C apt-get install llvm-11 clang-11 lld-11
--no-install-recommends -t llvm-toolchain -y

# dpkg -l | grep
1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261 | awk
'/^ii/ {print $1 " " $2 " " $3}' | column -t
ii  clang-11
1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
ii  libclang-common-11-dev
1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
ii  libclang-cpp11
1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
ii  libclang1-11
1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
ii  libllvm11:amd64
1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
ii  lld-11
1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
ii  llvm-11
1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
ii  llvm-11-runtime
1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261

Is that enough?

- Sedat -
