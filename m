Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC41C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869382072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dM8oqfer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgFBT76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:59:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05900C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:59:57 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so2875041pfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDJvPNaeJdVNz7jP499BIJ/LDFB76CjtukHr7y52odE=;
        b=dM8oqfersy2dlF0L5+FKjEh6v+rLzjIIj8tW1+809sREH/F21P2GsVszFVwu3Hk8ua
         /fo6vDXKZ5TsWCW6GR2iSNws2DAzNYi8w6QxPzeTGqHoDiHo9bW8HoMQUnCqoA4WslzS
         TyIifApgTKjaWSeN0DDazjEeQbhXrTYOLGC2PoN5FtcNm12knA4+CJdIHdjo2WAutJKB
         oSZHBqKyUnNLd5q7gACUEgRySk86mWXXiNSUKJ+mfY5IeOx1W39XfHO3NYHB5LGPGfmK
         hpsAeHHnq/YFDr1PEtgAjYSfXLdRgeIzGda/iSTDGRV6+H291A84dJigCKMG1WTVyyIi
         pnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDJvPNaeJdVNz7jP499BIJ/LDFB76CjtukHr7y52odE=;
        b=nIXpAhYE5l+chKccCAIAD3PV6Vvio1oJFr0GFdiFlj4g7YBqTDpvEFWZTleRjwvFoF
         hh4XlLVTPHgA54WyqC5w9se9tp+I41MA6YnaH3CUw9scXMECisaqVPR3Dy5JOVvuz5h1
         k48bqSjEdkMX8XZhghnoRI6Ddy8xuTQ8LZgEwmSj0oEQXlAGHp86v5jeaJB/tLFrByFX
         Zc2DcDg9PYPmGWW49Qcd3PK4VdBGVCVJjMmWDfc9zBSTrf27Xocrix+zKde5/odjmkhz
         2CBhVS6lKpomPAp1jBZ/PY9+3K5sNo8VH6nGH4NYZvMfr5zBCSoikhdWxpS48Sbp8WA5
         /CPg==
X-Gm-Message-State: AOAM531RrNz+rZGSKahVZ3u4EI0wuP/431FFzX20WubgwDa8XyXo/2Ju
        dg8fAqwWbCb+Fk6lxGD+TBaKWdsuzpHrO7KeQsAqsA==
X-Google-Smtp-Source: ABdhPJxs+5yD7y5OyQNSbnCTKMWKbvypIEf4W4CdR4cIUQ9ykyiUOMXHPFeygMIKGrr6VaBqIy1y1qEQ0GPuqZNTTEk=
X-Received: by 2002:a17:90a:4e8c:: with SMTP id o12mr856663pjh.25.1591127996304;
 Tue, 02 Jun 2020 12:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com> <CAKwvOd=5_pgx2+yQt=V_6h7YKiCnVp_L4nsRhz=EzawU1Kf1zg@mail.gmail.com>
 <20200602191936.GE2604@hirez.programming.kicks-ass.net> <CANpmjNP3kAZt3kXuABVqJLAJAW0u9-=kzr-QKDLmO6V_S7qXvQ@mail.gmail.com>
 <20200602193853.GF2604@hirez.programming.kicks-ass.net>
In-Reply-To: <20200602193853.GF2604@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Jun 2020 12:59:44 -0700
Message-ID: <CAKwvOd=TZsioqoUU+xZSUMooqux6Meu54PBCxP2mbtRb3Yp5pg@mail.gmail.com>
Subject: Re: [PATCH -tip 1/2] Kconfig: Bump required compiler version of KASAN
 and UBSAN
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 12:38 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 02, 2020 at 09:25:47PM +0200, Marco Elver wrote:
> > On Tue, 2 Jun 2020 at 21:19, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Currently x86 only, but I know other arch maintainers are planning to
> > > have a hard look at their code based on our findings.
> >
> > I've already spotted a bunch of 'noinstr' outside arch/x86 e.g. in
> > kernel/{locking,rcu}, and a bunch of these functions use atomic_*, all
> > of which are __always_inline. The noinstr uses outside arch/x86 would
> > break builds on all architecture with GCC <= 7 when using sanitizers.
> > At least that's what led me to conclude we need this for all
> > architectures.
>
> True; but !x86 could, probably, get away with not fully respecting
> noinstr at this time. But that'd make a mess of things again, so my
> preference is as you did, unilaterally raise the min version for *SAN.

Fair, thought I'd ask.  (I prefer people use newer
hopefully-less-buggier-but-maybe-not-really-suprise-they're-actually-worse
tools anyways)

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
Thanks,
~Nick Desaulniers
