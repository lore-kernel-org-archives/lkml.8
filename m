Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964E9C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9FD20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9UeQctv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgBXWFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:05:50 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40333 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXWFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:05:50 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so347179pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b83M3bsEx4cU3BGUQLKP/zLTl/hQm5rCLWYZzAWmz7c=;
        b=K9UeQctvOKAr9WMKVSqSAMKdSu8dM43OR9N63pX86FvgxFPlzz5hgWYJvLG0dYy8OO
         VKNCcfrMwxDHiH/fnXUvdYN/pzdUYSHkyLss/qxlbbpzsE7gEZy2Y76wT9WzL/p3u49y
         leCrgfNvSHEK+ialeQO7sDlyjr73jNpOavW6GPIBUI2upS7pU/ihZm3EyvwVfMopTMb9
         lMW8BcaIRh+Zk3IJkgNl3/mysUk28kjcG/EudMZgYYXpuIXEOANdaqNPvpkayuFf39hB
         5E6y+omeR5/XIsNCzSDATMqYysRQ8nvoMndODW/k/6NxQmQTlL4ttwxGugUOXxzX/1x/
         zw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b83M3bsEx4cU3BGUQLKP/zLTl/hQm5rCLWYZzAWmz7c=;
        b=nkdDdfZGErmERaWEb18cXBgeYww1jllXijPIyTXvpYlw+Wq+5PnDvE9ZpoIlP8FdwL
         KHTmOkpjk/EYNgbKCFEwa4p8O1FbMB2YmBJhvPbNZZyZITFRUYYlnxl5RwwY6RNDxU3c
         XMXYr1o1STHP6ZKyBKlrjoeDMhswvXjJz16lTyUjAGww0fWxoWgWeRiKkC8KEzxCae5A
         ujI/z4a9r+EfyheMh76cMna2rY7Idjwqd9k4bItarDUPSPvOs30Uv6GMwciohE7/upMC
         JttvFHSDUFP8oyoDio1FMvIRqdj3bJS1Pe/DPVJkBF04qSB7JIZ6ktkaHMUo0VTllDaH
         LgoQ==
X-Gm-Message-State: APjAAAUsHqRaCfEuUWe2y29MVp6iDmftxFI8lUs99q9r945gLdeE7tVG
        CvzUI5JgrLliL+jtIIRaOJd87nPzQPdP4bQv/VyG7w==
X-Google-Smtp-Source: APXvYqxJgF4c13YfU1TQ9nbbybo6TwW8LL7W7uRttFsrEZNf8krkiFsi+P5fs2YtVj89LkDHzk+vUrSuKlCvcgwwMUs=
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr1391652pjk.134.1582581949080;
 Mon, 24 Feb 2020 14:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20200223193456.25291-1-nick.desaulniers@gmail.com>
 <CAP-5=fU=+uYZDb2uSFO8CTJ-Ange4Nxh4mmsOC1MS=Tedois9g@mail.gmail.com>
 <dad75d5a7aa443e39dc20972d80ee83c@AcuMS.aculab.com> <CAP-5=fXO+YMO9asspqYdvXATZONCbBYMGbdVNU_3+W3BdeunGg@mail.gmail.com>
In-Reply-To: <CAP-5=fXO+YMO9asspqYdvXATZONCbBYMGbdVNU_3+W3BdeunGg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 14:05:38 -0800
Message-ID: <CAKwvOdko+Qb=h_Pm=oFUnsiBg7Am9u=Z83g8cNyY1QZQS=Mh7g@mail.gmail.com>
Subject: Re: [PATCH] perf: fix -Wstring-compare
To:     Ian Rogers <irogers@google.com>,
        David Laight <David.Laight@aculab.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Nick Desaulniers <nick.desaulniers@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        John Keeping <john@metanate.com>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 10:20 AM 'Ian Rogers' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On Mon, Feb 24, 2020 at 8:03 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Ian Rogers
> > > Sent: 24 February 2020 05:56
> > > On Sun, Feb 23, 2020 at 11:35 AM Nick Desaulniers
> > > <nick.desaulniers@gmail.com> wrote:
> > > >
> > > > Clang warns:
> > > >
> > > > util/block-info.c:298:18: error: result of comparison against a string
> > > > literal is unspecified (use an explicit string comparison function
> > > > instead) [-Werror,-Wstring-compare]
> > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > >                         ^  ~~~~~~~~~~~~~~~
> > > > util/block-info.c:298:51: error: result of comparison against a string
> > > > literal is unspecified (use an explicit string comparison function
> > > > instead) [-Werror,-Wstring-compare]
> > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > >                                                          ^  ~~~~~~~~~~~~~~~
> > > > util/block-info.c:298:18: error: result of comparison against a string
> > > > literal is unspecified (use an explicit string
> > > > comparison function instead) [-Werror,-Wstring-compare]
> > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > >                         ^  ~~~~~~~~~~~~~~~
> > > > util/block-info.c:298:51: error: result of comparison against a string
> > > > literal is unspecified (use an explicit string comparison function
> > > > instead) [-Werror,-Wstring-compare]
> > > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > > >                                                          ^  ~~~~~~~~~~~~~~~
> > > > util/map.c:434:15: error: result of comparison against a string literal
> > > > is unspecified (use an explicit string comparison function instead)
> > > > [-Werror,-Wstring-compare]
> > > >                 if (srcline != SRCLINE_UNKNOWN)
> > > >                             ^  ~~~~~~~~~~~~~~~
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/900
> > > > Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> > > > ---
> > > > Note: was generated off of mainline; can rebase on -next if it doesn't
> > > > apply cleanly.
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> > > Looks good to me. Some more context:
> > > https://clang.llvm.org/docs/DiagnosticsReference.html#wstring-compare
> > > The spec says:
> > > J.1 Unspecified behavior
> > > The following are unspecified:
> > > .. Whether two string literals result in distinct arrays (6.4.5).
> >
> > Just change the (probable):
> > #define SRCLINE_UNKNOWN "unknown"
> > with
> > static const char SRC_LINE_UNKNOWN[] = "unk";
> >
> >         David
>
>
> The SRCLINE_UNKNOWN is used to convey information. Having multiple
> distinct pointers (static) would mean the compiler could likely remove
> all comparisons as the compiler could prove that pointer is never
> returned by a function - ie comparisons are either known to be true
> (!=) or false (==).

I wouldn't define a static string in a header.  Though I could:
1. forward declare it in the header with extern linkage.
2. define it in *one* .c source file.

Thoughts on that vs the current approach?
-- 
Thanks,
~Nick Desaulniers
