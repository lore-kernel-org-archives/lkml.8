Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245DFC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 05:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E565B20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 05:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMtEDPiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgBXFzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 00:55:52 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42992 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBXFzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 00:55:52 -0500
Received: by mail-yw1-f65.google.com with SMTP id b81so4716391ywe.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 21:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b50opdvh9jm466J7F1sa7QuBxXpc5U92ofilJPUB76Y=;
        b=vMtEDPiRSrn97MCHsZemUW67l00xqKMpFOP9SgWcFfp44cStOUr2x0NzA0emhvsCYg
         FNnOQEgL81YSrQgR5UTLu9GPE8m+x7vdAdn4OdQwEKh2Rec+ABhVqw8evDVswTmR9e7f
         mgKI1y+DYHmsUuAVT7jZ+cCmNMJeA6hSlRaFi8SCxke72cCBuRxr75yoMbsULSc2D55q
         7kw7tzqBXKYpctw0tp3CJycVHF6a9/PMtBNLKqheJvosiDwo3pJeAILgbV5domqx2zuz
         uQoTGk8r8MzZwtbm/YA0vyQNzWqA1XLGDf8xXO4sJq0JwH2dzmwBy3uBfISBo8vmBslJ
         wTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b50opdvh9jm466J7F1sa7QuBxXpc5U92ofilJPUB76Y=;
        b=fsBIF1n92yseSstOkWmGjEEAQNrx9rrbMLydTM6fNrHHjShEQqA7iqrJnMDtg+4F7M
         OvLzbNxwsRfy69i6JCNnCx4RulXU0Wwphk4/1YA2tKazKbHJ5O2hRxtOK4bOSDIH0xaP
         Sm9I1NTphHIPof/2TouAMIGjBXgt/HbcHUnCT+jEgxr74PS2lLAdC42uUE5jEajZXcmO
         OtUmI4PJd6SgMEBp80dHsE/xdj8/w/XLFdHqnYloIdzSITaXlO4ajdTc7NahF2ONpLV0
         xxnx8PI82W2kFAdQp6KA7nPQvxlJE4jeaR96/3kSfKabdLftwlJR6DMuliRZMOXEirTk
         SYwg==
X-Gm-Message-State: APjAAAVzPizLG10Oo6Dr7K2qoDRgNf0PtONUiQqP5La/RkxHCRE9Gkir
        /CZcQ9OF5Opoyivx3qbJl1i/q+0RP8W9wZcioANLZA==
X-Google-Smtp-Source: APXvYqxabSe5rPAZitg5sJI5qQ/hSYzpn3zQO4NtyD/+V21iKie11xz27+r16q+QO9vJFj/BZkcqHGeBf5ceBJ8ruJk=
X-Received: by 2002:a81:3694:: with SMTP id d142mr39726193ywa.392.1582523749424;
 Sun, 23 Feb 2020 21:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20200223193456.25291-1-nick.desaulniers@gmail.com>
In-Reply-To: <20200223193456.25291-1-nick.desaulniers@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 23 Feb 2020 21:55:38 -0800
Message-ID: <CAP-5=fU=+uYZDb2uSFO8CTJ-Ange4Nxh4mmsOC1MS=Tedois9g@mail.gmail.com>
Subject: Re: [PATCH] perf: fix -Wstring-compare
To:     Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Sun, Feb 23, 2020 at 11:35 AM Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
>
> Clang warns:
>
> util/block-info.c:298:18: error: result of comparison against a string
> literal is unspecified (use an explicit string comparison function
> instead) [-Werror,-Wstring-compare]
>         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
>                         ^  ~~~~~~~~~~~~~~~
> util/block-info.c:298:51: error: result of comparison against a string
> literal is unspecified (use an explicit string comparison function
> instead) [-Werror,-Wstring-compare]
>         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
>                                                          ^  ~~~~~~~~~~~~~~~
> util/block-info.c:298:18: error: result of comparison against a string
> literal is unspecified (use an explicit string
> comparison function instead) [-Werror,-Wstring-compare]
>         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
>                         ^  ~~~~~~~~~~~~~~~
> util/block-info.c:298:51: error: result of comparison against a string
> literal is unspecified (use an explicit string comparison function
> instead) [-Werror,-Wstring-compare]
>         if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
>                                                          ^  ~~~~~~~~~~~~~~~
> util/map.c:434:15: error: result of comparison against a string literal
> is unspecified (use an explicit string comparison function instead)
> [-Werror,-Wstring-compare]
>                 if (srcline != SRCLINE_UNKNOWN)
>                             ^  ~~~~~~~~~~~~~~~
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/900
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
> Note: was generated off of mainline; can rebase on -next if it doesn't
> apply cleanly.

Looks good to me. Some more context:
https://clang.llvm.org/docs/DiagnosticsReference.html#wstring-compare
The spec says:
J.1 Unspecified behavior
The following are unspecified:
.. Whether two string literals result in distinct arrays (6.4.5).

>  tools/perf/builtin-diff.c    | 3 ++-
>  tools/perf/util/block-info.c | 3 ++-
>  tools/perf/util/map.c        | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index f8b6ae557d8b..c03c36fde7e2 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1312,7 +1312,8 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
>         end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
>                                 he->ms.sym);
>
> -       if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> +       if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0) &&
> +           (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)) {
>                 scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
>                           start_line, end_line, block_he->diff.cycles);
>         } else {
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index c4b030bf6ec2..fbbb6d640dad 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -295,7 +295,8 @@ static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>         end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
>                                 he->ms.sym);
>
> -       if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> +       if ((strncmp(start_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0) &&
> +           (strncmp(end_line, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)) {
>                 scnprintf(buf, sizeof(buf), "[%s -> %s]",
>                           start_line, end_line);
>         } else {
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index a08ca276098e..95428511300d 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -431,7 +431,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
>
>         if (map && map->dso) {
>                 char *srcline = map__srcline(map, addr, NULL);
> -               if (srcline != SRCLINE_UNKNOWN)
> +               if (strncmp(srcline, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)
>                         ret = fprintf(fp, "%s%s", prefix, srcline);
>                 free_srcline(srcline);
>         }
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200223193456.25291-1-nick.desaulniers%40gmail.com.
