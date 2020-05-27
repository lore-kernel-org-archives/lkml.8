Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4570E20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8uATb2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgE0TPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgE0TPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:15:07 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECD9C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:15:07 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j145so22775007oib.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPpomYNzZ7JQdxP/DL0TvucyrSh7m4+4U1ykvIyyU6Y=;
        b=P8uATb2ZDz1QZeHArAFQ7slPq6b7RojkwImc+bbanj1WnVrDja51C5Sy+m9gW/SdAy
         GiAVhnWu49Xf/x4rC01Jcin99KjvmBPsJVwJSCpTvIG4yVzPwgNKVA6n5bYi6F6opA99
         rdsiSp5zIH6oMVC+m+JSjzFTRQmIh8yEymzdr1W5N4bNX40Y0u51IC9sR1VcDKQFUTBB
         SgMoe93Drk0X8ESbgJXBA7n/Mo06zham61gZk5L580FLClT7diW3YFW8mwlBfAHU443w
         DxN8cST9L0Vnnwrgy1k5cvjfgsLapcLxaNjCWEuvgAuu7yr14T4rwymHmMNGf6Byf2Oc
         IgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPpomYNzZ7JQdxP/DL0TvucyrSh7m4+4U1ykvIyyU6Y=;
        b=dZZT6pRmDZNGzPIZZMzw+MK74VjE5uCWheiA5QcjQOAmdFOSkjISLh1Z+vTesajaXo
         oUJ0fvTMWdzP0Jm4XW/GCGaXJR81uVmnSc7fh1AbrIUN26ZuEbsndOl1UEevFKS4WhnM
         FA5xHZq0QIQQmw/eq2sL5v9S1F5rzozzRR81r/N+NATIwaawoNEebb/ur4pS3fMdblC7
         G6f/QfEOhTMu0PmTFWzQk1u88kUIJdGP7xt5u+S/EyG83vPW5+eFrQiHCqe3LF1s63Tx
         iGDpdp7ragsKPmWho7aFdxg7qS/3/6NDHYb9ND0qOscn7kv6LlXBYzf7Z7LZIXNX6Sxs
         Gf/w==
X-Gm-Message-State: AOAM530OAcG6FMPnp71q9Pnordov6rXZ+HYdU7mmZWx756Pr3piJaFI1
        1l5DLo5nqZO0gdrS5hFl2TIHkExHECcJORAdpWH2JQ==
X-Google-Smtp-Source: ABdhPJzIhVw8iu7aHpjiDMRAxeDVSnC+AL2W0EyXKjir/tYAuEBuuqMXsFDbJ59jB8I8lJ6HID2HMjyPnS6n9jqfjMA=
X-Received: by 2002:aca:ebc5:: with SMTP id j188mr3919306oih.70.1590606906697;
 Wed, 27 May 2020 12:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200527103236.148700-1-elver@google.com> <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
 <CA+icZUWtzu0ONUSy0E27Mq1BrdO79qNaY3Si-PDhHZyF8M4S5g@mail.gmail.com>
 <CAK8P3a04=mVQgSrvDhpVxQj50JEFDn_xMhYrvjmUnLYTWH3QXQ@mail.gmail.com>
 <CA+icZUXVSTxDYJwXLyAwZd91cjMPcPRpeAR72JKqkqa-wRNnWg@mail.gmail.com>
 <CAK8P3a3i0kPf8dRg7Ko-33hsb+LkP=P05uz2tGvg5B43O-hFvg@mail.gmail.com>
 <CA+icZUWr5xDz5ujBfsXjnDdiBuopaGE6xO5LJQP9_y=YoROb+Q@mail.gmail.com>
 <CANpmjNOtKQAB_3t1G5Da-J1k-9Dk6eQKP+xNozRbmHJXZqXGFw@mail.gmail.com>
 <CA+icZUWzPMOj+qsDz-5Z3tD-hX5gcowjBkwYyiy8SL36Jg+2Nw@mail.gmail.com>
 <CANpmjNOPcFSr2n_ro8TqhOBXOBfUY0vZtj_VT7hh3HOhJN4BqQ@mail.gmail.com> <CA+icZUVK=5agY_FPdPeRbZyn3EoUgnmPToR3iGWuCzY+KHtoAA@mail.gmail.com>
In-Reply-To: <CA+icZUVK=5agY_FPdPeRbZyn3EoUgnmPToR3iGWuCzY+KHtoAA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 27 May 2020 21:14:54 +0200
Message-ID: <CANpmjNOA2Oa=AJkKYadbvEVOaqzgD840aC5wfGGrFvDqUmjhpg@mail.gmail.com>
Subject: Re: [PATCH -tip] compiler_types.h: Optimize __unqual_scalar_typeof
 compilation time
To:     sedat.dilek@gmail.com
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

On Wed, 27 May 2020 at 21:11, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, May 27, 2020 at 3:57 PM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 27 May 2020 at 15:37, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Wed, May 27, 2020 at 3:30 PM Marco Elver <elver@google.com> wrote:
> > > >
> > > > On Wed, 27 May 2020 at 15:11, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > >
> > > > > On Wed, May 27, 2020 at 2:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > >
> > > > > > On Wed, May 27, 2020 at 2:35 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > > > On Wed, May 27, 2020 at 2:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > > On Wed, May 27, 2020 at 1:36 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > > > > > On Wed, May 27, 2020 at 1:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > > > > On Wed, May 27, 2020 at 12:33 PM Marco Elver <elver@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > This gives us back 80% of the performance drop on clang, and 50%
> > > > > > > > > > of the drop I saw with gcc, compared to current mainline.
> > > > > > > > > >
> > > > > > > > > > Tested-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Hi Arnd,
> > > > > > > > >
> > > > > > > > > with "mainline" you mean Linux-next aka Linux v5.8 - not v5.7?
> > > > > > > >
> > > > > > > > I meant v5.7.
> > > > > > > >
> > > > > > > > > I have not seen __unqual_scalar_typeof(x) in compiler_types.h in Linux v5.7.
> > > > > > > > >
> > > > > > > > > Is there a speedup benefit also for Linux v5.7?
> > > > > > > > > Which patches do I need?
> > > > > > > >
> > > > > > > > v5.7-rc is the baseline and is the fastest I currently see. On certain files,
> > > > > > > > I saw an intermittent 10x slowdown that was already fixed earlier, now
> > > > > > > > linux-next
> > > > > > > > is more like 2x slowdown for me and 1.2x with this patch on top, so we're
> > > > > > > > almost back to the speed of linux-5.7.
> > > > > > > >
> > > > > > >
> > > > > > > Which clang version did you use - and have you set KCSAN kconfigs -
> > > > > > > AFAICS this needs clang-11?
> > > > > >
> > > > > > I'm currently using clang-11, but I see the same problem with older
> > > > > > versions, and both with and without KCSAN enabled. I think the issue
> > > > > > is mostly the deep nesting of macros that leads to code bloat.
> > > > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > > With clang-10:
> > > > >
> > > > > $ scripts/diffconfig /boot/config-5.7.0-rc7-2-amd64-clang .config
> > > > >  BUILD_SALT "5.7.0-rc7-2-amd64-clang" -> "5.7.0-rc7-3-amd64-clang"
> > > > > +HAVE_ARCH_KCSAN y
> > > >
> > > > Clang 10 doesn't support KCSAN (HAVE_KCSAN_COMPILER unset).
> > > >
> > > > > With clang-11:
> > > > >
> > > > > $ scripts/diffconfig /boot/config-5.7.0-rc7-2-amd64-clang .config
> > > > >  BUILD_SALT "5.7.0-rc7-2-amd64-clang" -> "5.7.0-rc7-3-amd64-clang"
> > > > >  CLANG_VERSION 100001 -> 110000
> > > > > +CC_HAS_ASM_INLINE y
> > > > > +HAVE_ARCH_KCSAN y
> > > > > +HAVE_KCSAN_COMPILER y
> > > > > +KCSAN n
> > > > >
> > > > > Which KCSAN kconfigs did you enable?
> > > >
> > > > To clarify: as said in [1], KCSAN (or any other instrumentation) is no
> > > > longer relevant to the issue here, and the compile-time regression is
> > > > observable with most configs. The problem is due to pre-processing and
> > > > parsing, which came about due to new READ_ONCE() and the
> > > > __unqual_scalar_typeof() macro (which this patch optimizes).
> > > >
> > > > KCSAN and new ONCEs got tangled up because we first attempted to
> > > > annotate {READ,WRITE}_ONCE() with data_race(), but that turned out to
> > > > have all kinds of other issues (explanation in [2]). So we decided to
> > > > drop all the KCSAN-specific bits from ONCE, and require KCSAN to be
> > > > Clang 11. Those fixes were applied to the first version of new
> > > > {READ,WRITE}_ONCE() in -tip, which actually restored the new ONCEs to
> > > > the pre-KCSAN version (now that KCSAN can deal with them without
> > > > annotations).
> > > >
> > > > Hope this makes more sense now.
> > > >
> > > > [1] https://lore.kernel.org/lkml/CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com/
> > > > [2] https://lore.kernel.org/lkml/20200521142047.169334-1-elver@google.com/
> > > >
> > >
> > > Thanks, Marco.
> > >
> > > I pulled tip.git#locking/kcsan on top of Linux v5.7-rc7 and applied this patch.
> > > Just wanted to try KCSAN for the first time and it will also be my
> > > first building with clang-11.
> > > That's why I asked.
> >
> > In general, CONFIG_KCSAN=y and the defaults for the other KCSAN
> > options should be good. Depending on the size of your system, you
> > could also tweak KCSAN runtime performance:
> > https://lwn.net/Articles/816850/#Interacting%20with%20KCSAN%20at%20Runtime
> > -- the defaults should be good for most systems though.
> > Hope this helps. Any more questions, do let me know.
> >
>
> Which "projects" and packages do I need?
>
> I have installed:
>
> # LC_ALL=C apt-get install llvm-11 clang-11 lld-11
> --no-install-recommends -t llvm-toolchain -y
>
> # dpkg -l | grep
> 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261 | awk
> '/^ii/ {print $1 " " $2 " " $3}' | column -t
> ii  clang-11
> 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> ii  libclang-common-11-dev
> 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> ii  libclang-cpp11
> 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> ii  libclang1-11
> 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> ii  libllvm11:amd64
> 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> ii  lld-11
> 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> ii  llvm-11
> 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> ii  llvm-11-runtime
> 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
>
> Is that enough?

Just clang-11 (and its transitive dependencies) is enough. Unsure what
your installed binary is, likely "clang-11", so if you can do "make
CC=clang-11 defconfig" (and check for CONFIG_HAVE_KCSAN_COMPILER)
you're good to go.

Thanks,
-- Marco
