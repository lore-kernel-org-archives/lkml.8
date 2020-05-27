Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384ADC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFD2208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0Us1PcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgE0NME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0NMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:12:03 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44692C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:12:03 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s18so11881990ioe.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/FeAxSqyr5/D9IayOmiy152xGFi7mH1sffMEBtId3Bk=;
        b=t0Us1PcWyNxdn1JrPdp5+vD+WYbygmili6YXu2i0JMaL+Fwuc5YklOrY+rh6cZJK9y
         Vqig3+tUXcQsMOtp7ZIM1uEOlsDG0hV4Kj+axEhDiq5EIl1eflRM2GocNw8bxMCZn66O
         7wWPPzpV7TJMR/lppNDCydJ5qC5GpB0p2Tur8a0pFrrDyyLKbN2ZomeULWkjq+hrAP9j
         f1zRkyJrnlRnIzYi8YE4pbGa/eO6pfFFk3nk40KRAjmCR6LzhADcEop3SnpEQUQ82ksW
         mFLpvqJCG19tbi2IsG35jz3SB8zA/jXxZ7a6EVjxZxV/MWe3V1m7PdgdGsbo5sjkHtBC
         WEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/FeAxSqyr5/D9IayOmiy152xGFi7mH1sffMEBtId3Bk=;
        b=riiYaxxepcyBS/vvXjVlw5yhY7WAXdCtKajcqyuSaXkd28cbPGEi8bxKzSBk7hqxS3
         z7Texq4puUj3/oTrWs3HHL2hTVoHpURydyXgtYRMUFh6VPZ7KVLbpehEqG6zCxsUVpdS
         OnsnA9c1c2JVlcmjz+Nf8JdbGWYXM3MH4xtr/jSabGZnef+SFRZ0LiKB7Lio//xKkLYg
         lSyAifyv948LXuTUeJEWB++ijKK7JXET0fOsONQISctEB0CMhQP2hh6KFgBj5rq0DkHQ
         TQ3hubvshpllkN5DyKk3KMGAFJ2wKmI05PNPoZEE62r/s1UA4q6Sp4ZxWCSF5eXxWI05
         sGiw==
X-Gm-Message-State: AOAM531I30Fd249PHIQEB0DJ9UwnirdB1g40IoWDAw5NW4vs1Kudrg/l
        iWXH2G4LAfzadI3L0WuUDoI4ABGQ2CZWlTw3rhI=
X-Google-Smtp-Source: ABdhPJy35toBAd5zGQBpbTUlUkcIPcdzN6VndJZn7xP0j4afqiXyeJ1EMQQYTa8wVRmiBI3YZk2lKGdd6zF6iGd+uz8=
X-Received: by 2002:a02:a494:: with SMTP id d20mr5442362jam.23.1590585111991;
 Wed, 27 May 2020 06:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200527103236.148700-1-elver@google.com> <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
 <CA+icZUWtzu0ONUSy0E27Mq1BrdO79qNaY3Si-PDhHZyF8M4S5g@mail.gmail.com>
 <CAK8P3a04=mVQgSrvDhpVxQj50JEFDn_xMhYrvjmUnLYTWH3QXQ@mail.gmail.com>
 <CA+icZUXVSTxDYJwXLyAwZd91cjMPcPRpeAR72JKqkqa-wRNnWg@mail.gmail.com> <CAK8P3a3i0kPf8dRg7Ko-33hsb+LkP=P05uz2tGvg5B43O-hFvg@mail.gmail.com>
In-Reply-To: <CAK8P3a3i0kPf8dRg7Ko-33hsb+LkP=P05uz2tGvg5B43O-hFvg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 27 May 2020 15:11:44 +0200
Message-ID: <CA+icZUWr5xDz5ujBfsXjnDdiBuopaGE6xO5LJQP9_y=YoROb+Q@mail.gmail.com>
Subject: Re: [PATCH -tip] compiler_types.h: Optimize __unqual_scalar_typeof
 compilation time
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
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

On Wed, May 27, 2020 at 2:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 27, 2020 at 2:35 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > On Wed, May 27, 2020 at 2:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, May 27, 2020 at 1:36 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > On Wed, May 27, 2020 at 1:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Wed, May 27, 2020 at 12:33 PM Marco Elver <elver@google.com> wrote:
> > > > >
> > > > > This gives us back 80% of the performance drop on clang, and 50%
> > > > > of the drop I saw with gcc, compared to current mainline.
> > > > >
> > > > > Tested-by: Arnd Bergmann <arnd@arndb.de>
> > > > >
> > > >
> > > > Hi Arnd,
> > > >
> > > > with "mainline" you mean Linux-next aka Linux v5.8 - not v5.7?
> > >
> > > I meant v5.7.
> > >
> > > > I have not seen __unqual_scalar_typeof(x) in compiler_types.h in Linux v5.7.
> > > >
> > > > Is there a speedup benefit also for Linux v5.7?
> > > > Which patches do I need?
> > >
> > > v5.7-rc is the baseline and is the fastest I currently see. On certain files,
> > > I saw an intermittent 10x slowdown that was already fixed earlier, now
> > > linux-next
> > > is more like 2x slowdown for me and 1.2x with this patch on top, so we're
> > > almost back to the speed of linux-5.7.
> > >
> >
> > Which clang version did you use - and have you set KCSAN kconfigs -
> > AFAICS this needs clang-11?
>
> I'm currently using clang-11, but I see the same problem with older
> versions, and both with and without KCSAN enabled. I think the issue
> is mostly the deep nesting of macros that leads to code bloat.
>

Thanks.

With clang-10:

$ scripts/diffconfig /boot/config-5.7.0-rc7-2-amd64-clang .config
 BUILD_SALT "5.7.0-rc7-2-amd64-clang" -> "5.7.0-rc7-3-amd64-clang"
+HAVE_ARCH_KCSAN y

With clang-11:

$ scripts/diffconfig /boot/config-5.7.0-rc7-2-amd64-clang .config
 BUILD_SALT "5.7.0-rc7-2-amd64-clang" -> "5.7.0-rc7-3-amd64-clang"
 CLANG_VERSION 100001 -> 110000
+CC_HAS_ASM_INLINE y
+HAVE_ARCH_KCSAN y
+HAVE_KCSAN_COMPILER y
+KCSAN n

Which KCSAN kconfigs did you enable?

- Sedat -
