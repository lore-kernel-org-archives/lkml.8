Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795DC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4C6214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUMndEeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbgCCUGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:06:18 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40485 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCUGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:06:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id o10so3851888qtr.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 12:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jEKaLTA95LrXk5siOJJk3w+e3Hyr7fPl8lCKPh+BAqc=;
        b=DUMndEeIxpM99nIo3TWkBJDrwb1cnlC6lN6/7J2b6o7Mb7bEDhVWUcJq6w4rlVxW/M
         4ggPKtcYTGDSHv6K6yEc6gIz2pI6VXkq01fdXLaNQg77MC1VYR2AHItycoDdA4j4nYr+
         VCNlRIqGeVu5EDBKzXGfTB+wz1mwtOmVnFio0JkDjSOIxNNLGlNVh2QND8uE0OllTJht
         wzEsky62hb29iOW+H6SbYD4puoNhB+QfCnh22IqyD44xdAC1qW9mEbUsHFFaZoNgRn85
         peOLaCONtY3t01zAPHIcIhxx6ZkxCrRkchPaqp1apndgEY08DxsT+fDMofDKNBB/5P84
         M/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jEKaLTA95LrXk5siOJJk3w+e3Hyr7fPl8lCKPh+BAqc=;
        b=FSgWHKfFp/PNP+i97Pifo7PRRRuyZRCzre5AMxM+sjnE22Q/qgk/rwSXgRPBeeumGC
         2LR66A9qzZzXX/80iYpFWt1AVsPIaKgxj2W6wuVqWigEP41pusyUVcu+EOc1YM4kgtkn
         CI+BtB6op5CrlLphULKW6osE/jaib3NLMEGIah8bEp9LiRpVouHoiTHcJATljTx3CpVf
         59tZhZcJO+vPr4wXVuWcXrjjZdL5jUvxshdHq7FuwDcf1vJ4je0FO5BXWl1osLYHp+xu
         IfdkAi17PucjqE6EJM4Xnvvu2PDuDb8qDoOIjBunKS0f3LLGpkV8ABRs6xdKz62Ccx5u
         Q3mw==
X-Gm-Message-State: ANhLgQ0w1n9Uuk6ywP+7nL8wALFFUheSR7azqTbeibJpnQlK3nmlXUhj
        FZnVsiLOso4mWd8i7yvm1Sk=
X-Google-Smtp-Source: ADFU+vs23NrhpkOwEFqeNRoVf7Gdd0rgyCd1PDAuVNufh/nUgUOwmVG2vzOEDWB4OWwJB6hxh6E6hA==
X-Received: by 2002:ac8:40ca:: with SMTP id f10mr6136727qtm.377.1583265974981;
        Tue, 03 Mar 2020 12:06:14 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n74sm12811814qke.63.2020.03.03.12.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:06:14 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E489A403AD; Tue,  3 Mar 2020 17:06:11 -0300 (-03)
Date:   Tue, 3 Mar 2020 17:06:11 -0300
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        John Keeping <john@metanate.com>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] perf: fix -Wstring-compare
Message-ID: <20200303200611.GB5550@kernel.org>
References: <20200223193456.25291-1-nick.desaulniers@gmail.com>
 <CAP-5=fU=+uYZDb2uSFO8CTJ-Ange4Nxh4mmsOC1MS=Tedois9g@mail.gmail.com>
 <dad75d5a7aa443e39dc20972d80ee83c@AcuMS.aculab.com>
 <CAP-5=fXO+YMO9asspqYdvXATZONCbBYMGbdVNU_3+W3BdeunGg@mail.gmail.com>
 <CAKwvOdko+Qb=h_Pm=oFUnsiBg7Am9u=Z83g8cNyY1QZQS=Mh7g@mail.gmail.com>
 <7fe0ca3e6fb64ca59986584fffa824e6@AcuMS.aculab.com>
 <CAKwvOd=vQjs=nPdCEhY0yd8E6zx6BvMgr2EDQyNztbZf1LaTsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=vQjs=nPdCEhY0yd8E6zx6BvMgr2EDQyNztbZf1LaTsg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 25, 2020 at 01:28:50PM -0800, Nick Desaulniers escreveu:
> On Tue, Feb 25, 2020 at 1:35 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Nick Desaulniers
> > > Sent: 24 February 2020 22:06
> > > On Mon, Feb 24, 2020 at 10:20 AM 'Ian Rogers' via Clang Built Linux
> > > <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > On Mon, Feb 24, 2020 at 8:03 AM David Laight <David.Laight@aculab.com> wrote:
> > > > >
> > > > > From: Ian Rogers
> > > > > > Sent: 24 February 2020 05:56
> > > > > > On Sun, Feb 23, 2020 at 11:35 AM Nick Desaulniers
> > > > > > <nick.desaulniers@gmail.com> wrote:
> > > > > > >
> > > > > > > Clang warns:
> > > > > > >
> > > > > > > util/block-info.c:298:18: error: result of comparison against a string
> > > > > > > literal is unspecified (use an explicit string comparison function
> > > > > > > instead) [-Werror,-Wstring-compare]
> > > > > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > > > > >                         ^  ~~~~~~~~~~~~~~~
> > > > > > > util/block-info.c:298:51: error: result of comparison against a string
> > > > > > > literal is unspecified (use an explicit string comparison function
> > > > > > > instead) [-Werror,-Wstring-compare]
> > > > > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > > > > >                                                          ^  ~~~~~~~~~~~~~~~
> > > > > > > util/block-info.c:298:18: error: result of comparison against a string
> > > > > > > literal is unspecified (use an explicit string
> > > > > > > comparison function instead) [-Werror,-Wstring-compare]
> > > > > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > > > > >                         ^  ~~~~~~~~~~~~~~~
> > > > > > > util/block-info.c:298:51: error: result of comparison against a string
> > > > > > > literal is unspecified (use an explicit string comparison function
> > > > > > > instead) [-Werror,-Wstring-compare]
> > > > > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > > > > >                                                          ^  ~~~~~~~~~~~~~~~
> > > > > > > util/map.c:434:15: error: result of comparison against a string literal
> > > > > > > is unspecified (use an explicit string comparison function instead)
> > > > > > > [-Werror,-Wstring-compare]
> > > > > > >                 if (srcline != SRCLINE_UNKNOWN)
> > > > > > >                             ^  ~~~~~~~~~~~~~~~
> > > > > > >
> > > > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/900
> > > > > > > Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> > > > > > > ---
> > > > > > > Note: was generated off of mainline; can rebase on -next if it doesn't
> > > > > > > apply cleanly.
> > > >
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > >
> > > > > > Looks good to me. Some more context:
> > > > > > https://clang.llvm.org/docs/DiagnosticsReference.html#wstring-compare
> > > > > > The spec says:
> > > > > > J.1 Unspecified behavior
> > > > > > The following are unspecified:
> > > > > > .. Whether two string literals result in distinct arrays (6.4.5).
> > > > >
> > > > > Just change the (probable):
> > > > > #define SRCLINE_UNKNOWN "unknown"
> > > > > with
> > > > > static const char SRC_LINE_UNKNOWN[] = "unk";
> > > > >
> > > > >         David
> > > >
> > > >
> > > > The SRCLINE_UNKNOWN is used to convey information. Having multiple
> > > > distinct pointers (static) would mean the compiler could likely remove
> > > > all comparisons as the compiler could prove that pointer is never
> > > > returned by a function - ie comparisons are either known to be true
> > > > (!=) or false (==).
> > >
> > > I wouldn't define a static string in a header.  Though I could:
> > > 1. forward declare it in the header with extern linkage.
> > > 2. define it in *one* .c source file.
> > >
> > > Thoughts on that vs the current approach?
> >
> > The string compares are just stupid.
> > If the 'fake' strings are not printed you could use:
> > #define SRCLINE_UNKNOWN ((const char *)1)
> >
> > Otherwise defining the strings in one of the C files is better.
> > Relying on the linker to merge the strings from different compilation
> > units is so broken...
> 
> Note: it looks like free_srcline() already does strcmp, so my patch
> basically does a more consistent job for string comparisons.  Forward
> declaring then defining in tools/perf/util/srcline.c involves changing
> the function signatures and struct members to `const char*` rather
> than `char*`, which is of questionable value.  I wouldn't mind
> changing my patch to just use strcmp instead of strncmp, or convert
> free_srcline() to use strncmp instead, if folks felt strongly about
> being consistent. Otherwise I think my patch with Ian's Reviewed-by is
> the best approach.

Fair enough, applying it with Ian's reviewed-by,

- Arnaldo
