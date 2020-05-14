Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51649C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2088D2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJRMqzHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgENWIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgENWIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:08:51 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC52EC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:08:51 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id i16so69351ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fg0w/j23WIAOEbTsycZ8vzGnmdBhvdbXaaVn6uIjTKo=;
        b=ZJRMqzHDGB5OGlIstzoou3nLCpMz9POTSJjkQlG4IWS9fzn3K/KRworTOY5hI5dZuC
         yYvO53wcuWdA3ecQTMD3Y4rmLm5NL1djcrGFNgkYVAfRyJbEldtDdIwWRhAPK6rcPmwq
         eDpBJmRNmYrFmDD3ZaNS68jvkcX9BQYiqr9cyevYQCJrA+kZ0mDjUVShPp7ZObt24lCP
         ADHyQATU7bKw+8S0wCODDM+9pCociwYew/R/6A9VuD+jq1AMKMIxNLKOTQ8KuJ0JUfOY
         w9k3RuyX0o1ZnmPGhfnx2SelYo/VJjDT1WEXUveWTqqhnsDn4kzyMQD1G80TzL3135eH
         X+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fg0w/j23WIAOEbTsycZ8vzGnmdBhvdbXaaVn6uIjTKo=;
        b=XkVq73+EC1Vu3rToD2UerR8hkdBIq7xSR4QWbhVNugn3QRHLWN04wZLDf1O5vDN6sa
         QZub3U6G3nAq4drYIijRJH2qLdmSif4qcsGdXzaBs8OOw8/2AKIu1o5hVeMAIfBI8uq0
         Q6KhcZMO9TaBXROz/jiK740lWmxF7SgKQUPy2bxTcSh5z3ooPNCSwtijV/euEYHYkCLL
         U+rkirWQH61Z9Ho6fiMxB0wNND/gquyRSm7dl57A/TLiUI+w0UZyTA44k4Z2/d27Gp1K
         w9gCqHEheOHVrjemQqMAQ974QlH/vMYXb0jzqfr7BNZ7fWXSp08vq+HudnVwt5OR5EQ1
         xkWQ==
X-Gm-Message-State: AOAM533vSWKukBudlnTfZsbarQnSXfpLuD6mSgfm2RXO3HeVdjk134pz
        qMoMOLoV7BxKf6sNrEAm6+dSVUjS/ej81Uq9KZGFEg==
X-Google-Smtp-Source: ABdhPJwwZBnR2aRuYhnNNGrbGEFAxYKBtWAvvcqUH1GulgvHXh0uBeywVH2CcXXCFkHyrVFBPvomDtxmD+x+HSCNtQw=
X-Received: by 2002:a25:7cc1:: with SMTP id x184mr668358ybc.403.1589494130784;
 Thu, 14 May 2020 15:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200427061520.24905-1-nick.gasson@arm.com> <20200427061520.24905-3-nick.gasson@arm.com>
In-Reply-To: <20200427061520.24905-3-nick.gasson@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 May 2020 15:08:39 -0700
Message-ID: <CAP-5=fXaKA8P8Osbf-AryprGOU4WivMjkiHsnLmCAXdA=rP5jw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf jvmti: Do not report error when missing debug information
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:16 PM Nick Gasson <nick.gasson@arm.com> wrote:
>
> If the Java sources are compiled with -g:none to disable debug
> information the perf JVMTI plugin reports a lot of errors like:
>
>   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
>   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
>   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
>   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
>   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
>
> Instead if GetLineNumberTable returns JVMTI_ERROR_ABSENT_INFORMATION
> simply skip emitting line number information for that method. Unlike the
> previous patch these errors don't affect the jitdump generation, they
> just generate a lot of noise.
>
> Similarly for native methods which also don't have line tables.
>
> Signed-off-by: Nick Gasson <nick.gasson@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/jvmti/libjvmti.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index 50ef524b5cd4..a9a056d68416 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -41,7 +41,11 @@ do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
>         jvmtiError ret;
>
>         ret = (*jvmti)->GetLineNumberTable(jvmti, m, &nr_lines, &loc_tab);
> -       if (ret != JVMTI_ERROR_NONE) {
> +       if (ret == JVMTI_ERROR_ABSENT_INFORMATION || ret == JVMTI_ERROR_NATIVE_METHOD) {
> +               /* No debug information for this method */
> +               *nr = 0;
> +               return JVMTI_ERROR_NONE;
> +       } else if (ret != JVMTI_ERROR_NONE) {
>                 print_error(jvmti, "GetLineNumberTable", ret);
>                 return ret;
>         }
> @@ -93,6 +97,9 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>                                         /* free what was allocated for nothing */
>                                         (*jvmti)->Deallocate(jvmti, (unsigned char *)lne);
>                                         nr_total += (int)nr;
> +                               } else if (ret == JVMTI_ERROR_ABSENT_INFORMATION
> +                                          || ret == JVMTI_ERROR_NATIVE_METHOD) {
> +                                       /* No debug information for this method */
>                                 } else {
>                                         print_error(jvmti, "GetLineNumberTable", ret);
>                                 }
> @@ -262,7 +269,9 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
>         if (has_line_numbers && map && map_length) {
>                 ret = get_line_numbers(jvmti, compile_info, &line_tab, &nr_lines);
>                 if (ret != JVMTI_ERROR_NONE) {
> -                       warnx("jvmti: cannot get line table for method");
> +                       if (ret != JVMTI_ERROR_NOT_FOUND) {
> +                               warnx("jvmti: cannot get line table for method");
> +                       }
>                         nr_lines = 0;
>                 } else if (nr_lines > 0) {
>                         line_file_names = malloc(sizeof(char*) * nr_lines);
> --
> 2.26.1
>
