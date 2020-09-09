Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71531C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F0A21D40
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upBkhNC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgIIFUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgIIFUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:20:38 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E670DC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 22:20:37 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id f11so942419qvw.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 22:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrPV1rE9Q8aFyvmS+tTixzz0jds55x17Dqqm+UKxJfk=;
        b=upBkhNC7/CwbfMP4grgGeEXnkcrY+L6uUNuGtg8ZkXR9wUURcKAn3g8KxYNYXGCbAq
         jV2vNLvdq+QkpIsvAb19gqCgcuie1X/DnNCMSJOFa3AMohDx2XEgXANsN2aK2L0hGkja
         cPniJ5Xf3CA9u2Sv6cqgqCf6XVLLlnMv9aey8a0Zc4oI5x/4v2Tv2a6ZhlzpBDu/h1XY
         wK1Ibqq1QogOwmuaM7N0x++nBWEO5dYt4x0eQ2CxcNW6Z8OJFs2IDaHZI8oF8PTagTnk
         s8FTymby006ZOPUna230UFFaHRpHRrS78DMzEclKul1vSuVT9nOPOB676uCRiH1nrhtf
         B1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrPV1rE9Q8aFyvmS+tTixzz0jds55x17Dqqm+UKxJfk=;
        b=Kc3AqSJG0o9MdzIIUW4bMD6+90ubx3Mu3CBGCfaPikFrt7ZjT5BizA4yn/ajE6gshl
         yTK7/UNXICj6N8i17+G5lKJgHQc68j1H/cgt3gtRf3PBEO9Jwfb7ctolDOL8FMWv2zkz
         8BQyBoPLJTYSsoTTmeSoljDZBQXOBQyJaFS/3/zKQrLWDZhlSxOpU0uz/TBk5mknCCB+
         oTyS1UwL/WXAdVrHF2Nr5ieZYN9dyKj0KrX9Vn2DxoZjAmVmgAlHScoK6Mwgqu+5SVEv
         ea3yGYgjxSeaGwXhj52vwJObVJ8qvXfG/ULKSqhbjtcxEprVuwY/fEJ4Ed8h+YTINpMk
         OxCQ==
X-Gm-Message-State: AOAM530uw60M2tYlJrqlb5k1PDjTM7Du/PzqAxb4KQCWLZQqQTWuCvKx
        BGU1oZGih0H27yXgC4zp5TkZnPskHdFyGo+4Yt7mPA==
X-Google-Smtp-Source: ABdhPJzDjgqrCI/KiyQcwWsF18jm0ArWMayWq56hghF93/4c0cHbmxhIVUmdHQKpKy8ksYmoYIBnFxFxIF1j0+JrezA=
X-Received: by 2002:a05:6214:7a1:: with SMTP id v1mr2544395qvz.19.1599628835784;
 Tue, 08 Sep 2020 22:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200905222323.1408968-1-nivedita@alum.mit.edu>
 <20200905222323.1408968-2-nivedita@alum.mit.edu> <CANpmjNMnU03M0UJiLaHPkRipDuOZht0c9S3d40ZupQVNZLR+RA@mail.gmail.com>
 <202009081021.8E5957A1F@keescook> <20200908184003.GA4164124@rani.riverdale.lan>
In-Reply-To: <20200908184003.GA4164124@rani.riverdale.lan>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Sep 2020 07:20:24 +0200
Message-ID: <CACT4Y+aCa0Y8t198GSwEFShUPuOsqFV5eP8GY_7TK8fi_pML_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] lib/string: Disable instrumentation
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 8:40 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Sep 08, 2020 at 10:21:32AM -0700, Kees Cook wrote:
> > On Tue, Sep 08, 2020 at 11:39:11AM +0200, Marco Elver wrote:
> > > On Sun, 6 Sep 2020 at 00:23, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > String functions can be useful in early boot, but using instrumented
> > > > versions can be problematic: eg on x86, some of the early boot code is
> > > > executing out of an identity mapping rather than the kernel virtual
> > > > addresses. Accessing any global variables at this point will lead to a
> > > > crash.
> > > >
> > >
> > > Ouch.
> > >
> > > We have found manifestations of bugs in lib/string.c functions, e.g.:
> > >   https://groups.google.com/forum/#!msg/syzkaller-bugs/atbKWcFqE9s/x7AtoVoBAgAJ
> > >   https://groups.google.com/forum/#!msg/syzkaller-bugs/iGBUm-FDhkM/chl05uEgBAAJ
> > >
> > > Is there any way this can be avoided?
> >
> > Agreed: I would like to keep this instrumentation; it's a common place
> > to find bugs, security issues, etc.
> >
> > --
> > Kees Cook
>
> Ok, understood. I'll revise to open-code the strscpy instead.
>
> Is instrumentation supported on x86-32? load_ucode_bsp() on 32-bit is
> called before paging is enabled, and load_ucode_bsp() itself, along with
> eg lib/earlycpio and lib/string that it uses, don't have anything to
> disable instrumentation. kcov, kasan, kcsan are unsupported already on
> 32-bit, but the others like gcov and PROFILE_ALL_BRANCHES look like they
> would just cause a crash if microcode loading is enabled.

I agree we should not disable instrumentation of such common functions.

Instead of open-coding these functions maybe we could produce both
instrumented and non-instrumented versions from the same source
implementation. Namely, place implementation in a header function with
always_inline attribute and include it from 2 source files, one with
instrumentation enabled and another with instrumentation disabled.
This way we could produce strscpy (instrumented) and __strscpy
(non-instrumented) from the same source.
