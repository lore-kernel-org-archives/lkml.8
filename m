Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DF9C35E15
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E457921927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZGCX7ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgBYV3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:29:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33314 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgBYV3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:29:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so257833pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 13:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ujUpzqbtLOMFnK2x85J2zOksd9pIKrwiWoiPZU2Tngg=;
        b=XZGCX7ya5N43l4cINdtLO4xwCLE0LYTZLl84nPMiZykNGXk/wy1xP55IkR9gYcctA3
         Qix/hcO5KzHnPuiu+EeLaXXBHcIATbpdTbq9TIXvcg3ixXjAIzvH6qRtdmASA23Q8N5u
         OUS1jaUJEqCZnpeC4eH9qaiCdwwHcrSgMztlvbepV52uADPV4Hfckrs4hbBeKlAzteSY
         hyKlTUlPbFKpixU0GY3+YV1qdCehLiUGSco3lhsEDCD/exwlg53fEsyQMhRaLVR0IA7z
         T0NbeIqMmI0tBnOImo8+rgITlZWzw+U6SipWy6doO1v7zeZp8xlVcIBvcyKHai28utCs
         ff/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujUpzqbtLOMFnK2x85J2zOksd9pIKrwiWoiPZU2Tngg=;
        b=d/v/HKHS5wFE3wNGGnRQeACIh+6bOf3o9tdujhU2xoZlbuB07rqZWQ0O2NmQY3DG7Y
         CxmrfU/Dd0SepudrY7pP1EbjpEr9QQYxsZP33j2IRhoZp+1/itOF94qFK19jhxN2SeuX
         rdceA4HjdmubxOnyX+pn7wK9hfhTtujH+/soj8hB5EFEgZ1s2VMsIHO+A1VXF2ncVP6w
         NuYOmjmHDTKO8V8FSskhuqeSyCFEIePywUyvATpzGYZ/KuRlYn53z7poki8yYDKwdrEH
         jg80g9bIo/HPKXRLZ5V74q69bVA1alWh0ksmsnMU1l/3dpgK9eDTXIJ79ayRyjsNBEGW
         CFnw==
X-Gm-Message-State: APjAAAVRlpRGIz2w1788PDuN/9P8seAPlX1yKjMA29a2iozrfx3EQXXG
        /EmirZzpWz+lg2wgD+GGIymUKv1cgPXtntQLmV4dAw==
X-Google-Smtp-Source: APXvYqyAFLLg3+vafNkHgLfkBfECbSua6M0O3m6aqcEx082rSWFDuaoJ5jn0foijT/N6TRG6cwe5j4Yn+hokGTwvUDA=
X-Received: by 2002:a65:6412:: with SMTP id a18mr502177pgv.10.1582666141590;
 Tue, 25 Feb 2020 13:29:01 -0800 (PST)
MIME-Version: 1.0
References: <20200223193456.25291-1-nick.desaulniers@gmail.com>
 <CAP-5=fU=+uYZDb2uSFO8CTJ-Ange4Nxh4mmsOC1MS=Tedois9g@mail.gmail.com>
 <dad75d5a7aa443e39dc20972d80ee83c@AcuMS.aculab.com> <CAP-5=fXO+YMO9asspqYdvXATZONCbBYMGbdVNU_3+W3BdeunGg@mail.gmail.com>
 <CAKwvOdko+Qb=h_Pm=oFUnsiBg7Am9u=Z83g8cNyY1QZQS=Mh7g@mail.gmail.com> <7fe0ca3e6fb64ca59986584fffa824e6@AcuMS.aculab.com>
In-Reply-To: <7fe0ca3e6fb64ca59986584fffa824e6@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Feb 2020 13:28:50 -0800
Message-ID: <CAKwvOd=vQjs=nPdCEhY0yd8E6zx6BvMgr2EDQyNztbZf1LaTsg@mail.gmail.com>
Subject: Re: [PATCH] perf: fix -Wstring-compare
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 1:35 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Nick Desaulniers
> > Sent: 24 February 2020 22:06
> > On Mon, Feb 24, 2020 at 10:20 AM 'Ian Rogers' via Clang Built Linux
> > <clang-built-linux@googlegroups.com> wrote:
> > >
> > > On Mon, Feb 24, 2020 at 8:03 AM David Laight <David.Laight@aculab.com> wrote:
> > > >
> > > > From: Ian Rogers
> > > > > Sent: 24 February 2020 05:56
> > > > > On Sun, Feb 23, 2020 at 11:35 AM Nick Desaulniers
> > > > > <nick.desaulniers@gmail.com> wrote:
> > > > > >
> > > > > > Clang warns:
> > > > > >
> > > > > > util/block-info.c:298:18: error: result of comparison against a string
> > > > > > literal is unspecified (use an explicit string comparison function
> > > > > > instead) [-Werror,-Wstring-compare]
> > > > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > > > >                         ^  ~~~~~~~~~~~~~~~
> > > > > > util/block-info.c:298:51: error: result of comparison against a string
> > > > > > literal is unspecified (use an explicit string comparison function
> > > > > > instead) [-Werror,-Wstring-compare]
> > > > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > > > >                                                          ^  ~~~~~~~~~~~~~~~
> > > > > > util/block-info.c:298:18: error: result of comparison against a string
> > > > > > literal is unspecified (use an explicit string
> > > > > > comparison function instead) [-Werror,-Wstring-compare]
> > > > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > > > >                         ^  ~~~~~~~~~~~~~~~
> > > > > > util/block-info.c:298:51: error: result of comparison against a string
> > > > > > literal is unspecified (use an explicit string comparison function
> > > > > > instead) [-Werror,-Wstring-compare]
> > > > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > > > >                                                          ^  ~~~~~~~~~~~~~~~
> > > > > > util/map.c:434:15: error: result of comparison against a string literal
> > > > > > is unspecified (use an explicit string comparison function instead)
> > > > > > [-Werror,-Wstring-compare]
> > > > > >                 if (srcline != SRCLINE_UNKNOWN)
> > > > > >                             ^  ~~~~~~~~~~~~~~~
> > > > > >
> > > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/900
> > > > > > Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> > > > > > ---
> > > > > > Note: was generated off of mainline; can rebase on -next if it doesn't
> > > > > > apply cleanly.
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > > > Looks good to me. Some more context:
> > > > > https://clang.llvm.org/docs/DiagnosticsReference.html#wstring-compare
> > > > > The spec says:
> > > > > J.1 Unspecified behavior
> > > > > The following are unspecified:
> > > > > .. Whether two string literals result in distinct arrays (6.4.5).
> > > >
> > > > Just change the (probable):
> > > > #define SRCLINE_UNKNOWN "unknown"
> > > > with
> > > > static const char SRC_LINE_UNKNOWN[] = "unk";
> > > >
> > > >         David
> > >
> > >
> > > The SRCLINE_UNKNOWN is used to convey information. Having multiple
> > > distinct pointers (static) would mean the compiler could likely remove
> > > all comparisons as the compiler could prove that pointer is never
> > > returned by a function - ie comparisons are either known to be true
> > > (!=) or false (==).
> >
> > I wouldn't define a static string in a header.  Though I could:
> > 1. forward declare it in the header with extern linkage.
> > 2. define it in *one* .c source file.
> >
> > Thoughts on that vs the current approach?
>
> The string compares are just stupid.
> If the 'fake' strings are not printed you could use:
> #define SRCLINE_UNKNOWN ((const char *)1)
>
> Otherwise defining the strings in one of the C files is better.
> Relying on the linker to merge the strings from different compilation
> units is so broken...

Note: it looks like free_srcline() already does strcmp, so my patch
basically does a more consistent job for string comparisons.  Forward
declaring then defining in tools/perf/util/srcline.c involves changing
the function signatures and struct members to `const char*` rather
than `char*`, which is of questionable value.  I wouldn't mind
changing my patch to just use strcmp instead of strncmp, or convert
free_srcline() to use strncmp instead, if folks felt strongly about
being consistent. Otherwise I think my patch with Ian's Reviewed-by is
the best approach.
-- 
Thanks,
~Nick Desaulniers
