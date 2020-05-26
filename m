Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E46C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8C02086A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUmih8bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgEZNMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgEZNMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:12:39 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98346C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 06:12:39 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h7so16210991otr.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2vqEAYjxMamt8eKicI31y8Z10SrX1vFFP0/1fJj8mo=;
        b=YUmih8bKfVWWsaZbLiY47e25G4Cr42ZjylE5BuWJYAxtRu94dd/iSypjNWEbZwpbQP
         opnp34sMb6yaalrMJwFQoJzR686ehBwUOVCV1VV6TgXwVVKMefZ+4giYh3dHT+QiRaOM
         q0UM7wVHHY0TPLnApja+Qka1QqRUNhlP92PkoUavs5JEyRZSXr0ZkzqyVC6Vp3KVBT6v
         2Q0QlE8GeDSHrCh8hApAgtaHnApbvuNRwWtdrBU1sGsC0K7QzNr+d3Lc80Y2RVg8s27h
         I5OD7Wq6JjcnV+Smf4FCpG4tQGBC2n6kgfJbfKf9COiReHSAIkYhzjoV1Vd9laJQyOUN
         iYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2vqEAYjxMamt8eKicI31y8Z10SrX1vFFP0/1fJj8mo=;
        b=DkIBkpn+Kq/N2iik9ufXjFh3FavdU25VAgLKdeW4rzjWIHk8Uy/BUJOgPjhqAMk/91
         QoPYjOZ6Vn7yVjrKg7yquAi8bq79L1T24j9hor2Z+msVwi1i3l6EsoFnngZa/mBXkIf2
         MGAhDuu1PGC4IS960V/Qk5aIpzNIq0bx//XRrmTxkFD1g+Sv9PZqDdJjbkpVQNHawaFE
         6/kGK6t+U9ath8uOfAvvTUx3UOTmfUt/oxiA737qJYqKJQ8UKhGG+fTwAqrzUmWc2N+A
         AG0WZP/A9pMOH5IZ5VUvYyKCOAtOOlG+lC82WPLf0+J00pXV0Yg0SFL/GOW2uPPHG22l
         S5sA==
X-Gm-Message-State: AOAM532C5JY4KoqSs2nwT571fY/H6ilQZuU6kMTK/HvC9kniFqKbP6eg
        wEXHAdH3kxHW5et+345bNL9qdIuJC0g8J+r8l1EEXg==
X-Google-Smtp-Source: ABdhPJxlvC7QevWlbG78N5mvSiu9BmZcieCDv/cNS7OVIEG3vydG0UjFTm+rTkHGsKYZUSgjFErQjmJcenE3pLKP4bA=
X-Received: by 2002:a9d:518a:: with SMTP id y10mr840760otg.17.1590498758658;
 Tue, 26 May 2020 06:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200521142047.169334-1-elver@google.com> <20200521142047.169334-10-elver@google.com>
 <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
 <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
 <20200526120245.GB27166@willie-the-truck> <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
In-Reply-To: <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 26 May 2020 15:12:26 +0200
Message-ID: <CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com>
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement expression
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will@kernel.org>,
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

On Tue, 26 May 2020 at 14:19, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, May 26, 2020 at 2:02 PM Will Deacon <will@kernel.org> wrote:
> > On Tue, May 26, 2020 at 12:42:16PM +0200, Arnd Bergmann wrote:
> > >
> > > I find this patch only solves half the problem: it's much faster than
> > > without the
> > > patch, but still much slower than the current mainline version. As far as I'm
> > > concerned, I think the build speed regression compared to mainline is not yet
> > > acceptable, and we should try harder.
> > >
> > > I have not looked too deeply at it yet, but this is what I found from looking
> > > at a file in a randconfig build:
> > >
> > > Configuration: see https://pastebin.com/raw/R9erCwNj
> >
> > So this .config actually has KCSAN enabled. Do you still see the slowdown
> > with that disabled?
>
> Yes, enabling or disabling KCSAN seems to make no difference to
> compile speed in this config and source file, I still get the 12 seconds
> preprocessing time and 9MB file size with KCSAN disabled, possibly
> a few percent smaller/faster. I actually thought that CONFIG_FTRACE
> had a bigger impact, but disabling that also just reduces the time
> by a few percent rather than getting it down to the expected milliseconds.
>
> > Although not ideal, having a longer compiler time when
> > the compiler is being asked to perform instrumentation doesn't seem like a
> > show-stopper to me.
>
> I agree in general, but building an allyesconfig kernel is still an important
> use case that should not take twice as long after a small kernel change
> regardless of whether a new feature is used or not. (I have not actually
> compared the overall build speed for allmodconfig, as this takes a really
> long time at the moment)

Note that an 'allyesconfig' selects KASAN and not KCSAN by default.
But I think that's not relevant, since KCSAN-specific code was removed
from ONCEs. In general though, it is entirely expected that we have a
bit longer compile times when we have the instrumentation passes
enabled.

But as you pointed out, that's irrelevant, and the significant
overhead is from parsing and pre-processing. FWIW, we can probably
optimize Clang itself a bit:
https://github.com/ClangBuiltLinux/linux/issues/1032#issuecomment-633712667

Thanks,
-- Marco
