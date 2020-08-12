Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33ECC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 21:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEDB20774
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 21:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnsWam0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHLVww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 17:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLVwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 17:52:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C3CC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 14:52:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so1726342pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCbQE1eRz9aMBbIfwDa2a9ZzzYzoMclcPd3bcmvTf+U=;
        b=pnsWam0Wp/0E3S6qPxrXp4AwBCUUlNg+7b/BmAs70nIi94G/xJ1JBy0fLqAMERL6Pn
         1zU/qMyuus8lX6sC6c++xSZejFAb50BuhtcTphLtDG7Vw95yTh63VXlbuVptWKLPaYjC
         SWp/VGWHGOyM+u+uIaf2s5Nrw+B0YF5rN7l4IFCxssYJsAVdAaNv+4oIJDPHPVGDd7Ml
         iDu49GJz/tnqpnRZfYUy+STnroFe1pJukhMaIN2NE9TfDNsWAJXsE8fBvZrbpQ2cAx+x
         kFKR3incgOGzXxf1A2JDAGU4jb5SHKHs8Q+RBk1JwwXR6/Xe/oh5CeGeoZ7XcPF3+4sE
         G9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCbQE1eRz9aMBbIfwDa2a9ZzzYzoMclcPd3bcmvTf+U=;
        b=J5iFt76knChFpv+nKfy0u30kXGYM5Ovieotr0LNTZ2rOagZrZ2oa+9rcGV6+l/r8j1
         gWxgVbxOiuzurE2NybwySHFG/I/poOqLTIZNLuG1yaHW2BhUqU6f5R9bD0FSU9AtaS4X
         sENLUThGdooR0UzC3KGEKslt4xqJB8CNPr/N4cDFgrEcWCP4ezrLKSFhFOkAZ5wv+4ep
         mzWbma4+vscLAQaVlja65Dh7Gsa/JX0Fq9a1w6uXQw03drDLNVgN6Yf2cl7U7Lush7fO
         d3p2yH1YMdhyDPvV28pPh+xZviFdkdyib+C90gNjaHqrNvtVkF58Ij/Eds+A2Y2uFGDQ
         imdg==
X-Gm-Message-State: AOAM532Wio/ddFOQj6XIplmRJJYta8Vwz4J82Gu1f0hGdMV+120jKcMp
        qw5tCLsUVNbvlmDNT6UgmyfxEzotq8U3xjzACvsLZ5Co/0o=
X-Google-Smtp-Source: ABdhPJxUQy0niiQlV7m3IGAUQtZ6U3ue4BBuioK9jJX1/s/4WJwaZbeIrcfZGXHw/vgnXopFF11tLZvLofQ6KwLGDiU=
X-Received: by 2002:a63:7d8:: with SMTP id 207mr1056708pgh.263.1597269170150;
 Wed, 12 Aug 2020 14:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200812173958.2307251-1-masahiroy@kernel.org> <20200812173958.2307251-2-masahiroy@kernel.org>
In-Reply-To: <20200812173958.2307251-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Aug 2020 14:52:39 -0700
Message-ID: <CAKwvOdktQgf3pT-9j5Lo3oKQ=sRdTL0XvPto9j-8NASA6fcSvw@mail.gmail.com>
Subject: Re: [PATCH 1/3] gen_compile_commands: parse only the first line of
 .*.cmd files
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:40 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> After the allmodconfig build, this script takes about 5 sec on my
> machine. Most of the run-time is consumed for needless regex matching.
>
> We know the format of .*.cmd file; the first line is the build command.
> There is no need to parse the remaining.
>
> With this optimization, now it runs in about 1 sec with the allmodconfig
> build.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Before your patch, my x86_64 allmodconfig:
$ /usr/bin/time -v ./scripts/gen_compile_commands.py
...
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:08.35
...
After:
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:02.10

So it's a nice speedup.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
small nit below:

> ---
>
>  scripts/gen_compile_commands.py | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
> index c458696ef3a7..19c7338740e7 100755
> --- a/scripts/gen_compile_commands.py
> +++ b/scripts/gen_compile_commands.py
> @@ -125,11 +125,9 @@ def main():
>              filepath = os.path.join(dirpath, filename)
>
>              with open(filepath, 'rt') as f:
> -                for line in f:
> -                    result = line_matcher.match(line)
> -                    if not result:
> -                        continue
> -
> +                line = f.readline()
> +                result = line_matcher.match(line)

If `line` is not referenced beyond the following statement, consider
combining the two statement into one:
result = line_matcher.match(f.readline())

> +                if result:
>                      try:
>                          entry = process_line(directory, dirpath,
>                                               result.group(1), result.group(2))
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
