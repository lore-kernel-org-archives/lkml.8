Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0F8C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC0E20732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4WRCbzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBXSTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:19:47 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46882 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBXSTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:19:47 -0500
Received: by mail-yw1-f68.google.com with SMTP id z141so5621757ywd.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwMd85HDX5SvxneOefTVO3Pm2UjSWW7Q8lu4YFXwuVc=;
        b=T4WRCbzKak+JI+nr9i6w3iixDwOSrddin5REOzOyfPUPMbKcpYL6CYlC0TdwNEMMwN
         ldeHn1GZRtkqpWkq1Q51tt2S0xBE6yA0tKuHPYj9MsU+SJb2O+SYGytAzGstWBp18rRZ
         Bg7cXTVAVmoCrPUH10MhhgEd416+GPaXMr1fxGFekDJMwdLtmtjHF+AIb7STeNWCTCQ0
         zuy+iUAKoIm8xQJGLl2afhoWfH6zHiD40F5SuOKBdBPkfyHZQdg0kzd9mvPO4rE8mf1a
         1OaX5bV4dTLpDDtbC7c5kbrz4QzaWC8lQQWJOZLDVYQHW/JZc5Ft+gsQqlIxYPyY+pl5
         WGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwMd85HDX5SvxneOefTVO3Pm2UjSWW7Q8lu4YFXwuVc=;
        b=a0N3vhBv9n40JKMmBxtMdZwx/Vv9AlAekwdWUWKaWQz46d2I1WfA6275dgjbe5tOFx
         LJFNT++KWhBTtK1zaTpT83hKFAAENBLtmpbRI28UvnYyQCMu+wWtB3PUhyKDZ+5NaWkV
         7Do/+PI/SSIXddSNeM2d09vCk20e7IFFdsji11pF3UzzWnh6p/PWJ41uuWwHDQWqpMX/
         xWStgX6YyxRAIGg7tusHEkHo8m2XWKLGnj3o38sZF94dBvVFOEu+8xetuYjY4zYmEoBQ
         xeQdRPUaHPy6doh8JHJ2jSlaV2XAvM3Bl35iHa53Qbjs+QWYnoK2Fe3vS5r10uEQx6X7
         l2SQ==
X-Gm-Message-State: APjAAAX4yDdNW8MErctB4a7pWHpLFQJZVP75iRqk6Kyp+m6fnUeqAXHq
        1FdCFbbByP+oV3PrDTvuS0qK1mpfMzgcI8C8x1EGMg==
X-Google-Smtp-Source: APXvYqxgmhGtuZmFaQOm1brAqN93tbmj5fGcVuylwLk+loBLTXSw3FWf2xhAcnshCvcM+cKvcUKWOAzNAMiXy4UC3HY=
X-Received: by 2002:a81:a452:: with SMTP id b79mr41515761ywh.389.1582568384978;
 Mon, 24 Feb 2020 10:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20200223193456.25291-1-nick.desaulniers@gmail.com>
 <CAP-5=fU=+uYZDb2uSFO8CTJ-Ange4Nxh4mmsOC1MS=Tedois9g@mail.gmail.com> <dad75d5a7aa443e39dc20972d80ee83c@AcuMS.aculab.com>
In-Reply-To: <dad75d5a7aa443e39dc20972d80ee83c@AcuMS.aculab.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 24 Feb 2020 10:19:33 -0800
Message-ID: <CAP-5=fXO+YMO9asspqYdvXATZONCbBYMGbdVNU_3+W3BdeunGg@mail.gmail.com>
Subject: Re: [PATCH] perf: fix -Wstring-compare
To:     David Laight <David.Laight@aculab.com>
Cc:     Nick Desaulniers <nick.desaulniers@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Mon, Feb 24, 2020 at 8:03 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Ian Rogers
> > Sent: 24 February 2020 05:56
> > On Sun, Feb 23, 2020 at 11:35 AM Nick Desaulniers
> > <nick.desaulniers@gmail.com> wrote:
> > >
> > > Clang warns:
> > >
> > > util/block-info.c:298:18: error: result of comparison against a string
> > > literal is unspecified (use an explicit string comparison function
> > > instead) [-Werror,-Wstring-compare]
> > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > >                         ^  ~~~~~~~~~~~~~~~
> > > util/block-info.c:298:51: error: result of comparison against a string
> > > literal is unspecified (use an explicit string comparison function
> > > instead) [-Werror,-Wstring-compare]
> > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > >                                                          ^  ~~~~~~~~~~~~~~~
> > > util/block-info.c:298:18: error: result of comparison against a string
> > > literal is unspecified (use an explicit string
> > > comparison function instead) [-Werror,-Wstring-compare]
> > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > >                         ^  ~~~~~~~~~~~~~~~
> > > util/block-info.c:298:51: error: result of comparison against a string
> > > literal is unspecified (use an explicit string comparison function
> > > instead) [-Werror,-Wstring-compare]
> > >         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> > >                                                          ^  ~~~~~~~~~~~~~~~
> > > util/map.c:434:15: error: result of comparison against a string literal
> > > is unspecified (use an explicit string comparison function instead)
> > > [-Werror,-Wstring-compare]
> > >                 if (srcline != SRCLINE_UNKNOWN)
> > >                             ^  ~~~~~~~~~~~~~~~
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/900
> > > Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> > > ---
> > > Note: was generated off of mainline; can rebase on -next if it doesn't
> > > apply cleanly.

Reviewed-by: Ian Rogers <irogers@google.com>

> > Looks good to me. Some more context:
> > https://clang.llvm.org/docs/DiagnosticsReference.html#wstring-compare
> > The spec says:
> > J.1 Unspecified behavior
> > The following are unspecified:
> > .. Whether two string literals result in distinct arrays (6.4.5).
>
> Just change the (probable):
> #define SRCLINE_UNKNOWN "unknown"
> with
> static const char SRC_LINE_UNKNOWN[] = "unk";
>
>         David


The SRCLINE_UNKNOWN is used to convey information. Having multiple
distinct pointers (static) would mean the compiler could likely remove
all comparisons as the compiler could prove that pointer is never
returned by a function - ie comparisons are either known to be true
(!=) or false (==).

Thanks,
Ian

> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
