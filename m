Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6383CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E348207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvb7cjeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgE0Mf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgE0Mf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:35:57 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD4C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:35:57 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l20so23744200ilj.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=dLQVgKcEwQ1FC39ZISDlNHseQJ/tL1cI3JXpTq890qw=;
        b=pvb7cjeWDKOytkZ2TPXed9hLiugDbCeaDk2437LdG3m5PEn/uBcGBYN4XSOzw4Gz0T
         Q4mZc3goT6t9lC8IdtOhliTxsj+0FgOMy4EtQipU9vOLIZ55WaMb608wXjwu2tTAwUoz
         EEu9sOnfUviNS3p3JOBDurp0xeqWXXvx04UdQLtOIAXQxp7QvuBOu5WWKwbBwh2frzjF
         ifml7DlOjQqiz/AP7OD9VNNxcH1GEfiKCcGzPgC90Ruo8RoEM7KhxumKgjSySdElqO19
         Xn4ETmwkeU0umcC7gaq6sseEJuSYKrg6YVLSGbYu9MKXxjn7AciyPJy+pHYTUhT65iXr
         uCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=dLQVgKcEwQ1FC39ZISDlNHseQJ/tL1cI3JXpTq890qw=;
        b=srn9ygUGcKQqq4i4jIEImtxXK2cAhXLcylJlilYKUzucxk9SdkpTUskKOsmy9WYPL7
         Gz/HVGq/7dQIvu+c7dRQP+I/EFt0shuV1+NpSqU0zM/U6Vh9CrXcS/6Q4mSuvqZc341u
         hYo3OSfxZyTIjaFXigAZplbm2yi2p5XBWaL72cwu201kRluGi6vBWS/Bej4Z7uYJ2tRN
         AYu7Q8O6gp6IzEJJiur1ZxiBwsgc49LmH/aOSRP3oEWPPO2aqO/+gNiasjQTzGzyV5QY
         OH8bsc6Gq4CTWEBYzBO1gm8yOx7fo5omNimAd+1SHrddmCzz0ey6Fc6qPTmjcQisq4ag
         UXkA==
X-Gm-Message-State: AOAM531NmMIWcTJw9x+6uibNdAg7d2szBZC6TWqlaiGkWiGubjpSSrXs
        XeODJt/Nphuu4sjgNKckg8riAEMERa7s0/Z/NDQ=
X-Google-Smtp-Source: ABdhPJybMeSgwPMU1mb8NkgacmfH4QBoaFWkqrM5qMMFKeDW/UVIJ/yg2hiW8SQwcqd4KW/hwWeBBGBPQozrys+CK9Y=
X-Received: by 2002:a92:898e:: with SMTP id w14mr5303714ilk.212.1590582957180;
 Wed, 27 May 2020 05:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200527103236.148700-1-elver@google.com> <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
 <CA+icZUWtzu0ONUSy0E27Mq1BrdO79qNaY3Si-PDhHZyF8M4S5g@mail.gmail.com> <CAK8P3a04=mVQgSrvDhpVxQj50JEFDn_xMhYrvjmUnLYTWH3QXQ@mail.gmail.com>
In-Reply-To: <CAK8P3a04=mVQgSrvDhpVxQj50JEFDn_xMhYrvjmUnLYTWH3QXQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 27 May 2020 14:35:49 +0200
Message-ID: <CA+icZUXVSTxDYJwXLyAwZd91cjMPcPRpeAR72JKqkqa-wRNnWg@mail.gmail.com>
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

On Wed, May 27, 2020 at 2:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 27, 2020 at 1:36 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > On Wed, May 27, 2020 at 1:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, May 27, 2020 at 12:33 PM Marco Elver <elver@google.com> wrote:
> > >
> > > This gives us back 80% of the performance drop on clang, and 50%
> > > of the drop I saw with gcc, compared to current mainline.
> > >
> > > Tested-by: Arnd Bergmann <arnd@arndb.de>
> > >
> >
> > Hi Arnd,
> >
> > with "mainline" you mean Linux-next aka Linux v5.8 - not v5.7?
>
> I meant v5.7.
>
> > I have not seen __unqual_scalar_typeof(x) in compiler_types.h in Linux v5.7.
> >
> > Is there a speedup benefit also for Linux v5.7?
> > Which patches do I need?
>
> v5.7-rc is the baseline and is the fastest I currently see. On certain files,
> I saw an intermittent 10x slowdown that was already fixed earlier, now
> linux-next
> is more like 2x slowdown for me and 1.2x with this patch on top, so we're
> almost back to the speed of linux-5.7.
>

Which clang version did you use - and have you set KCSAN kconfigs -
AFAICS this needs clang-11?

- Sedat -
