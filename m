Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4CEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FCE120732
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsOMIz3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbgFRW0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgFRWZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:25:59 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A61C06174E;
        Thu, 18 Jun 2020 15:25:59 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id r1so2533635uam.6;
        Thu, 18 Jun 2020 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOfsQfqk6xnh1iTLfTAqoyruTN6lABtLlvex7Rk4Lzg=;
        b=lsOMIz3+JpwfoihFXSwZkHMEFmbhs4Qu342YopNh87yMfVGSwL51leptoSooLSwGY5
         2qOKh1AZh5H2h2GaUb0VjzneQbmvVbUIYnSlCqEolVXrLP6xeQJgi8UBfvE4NnpVBMM3
         C+j+zawJK+uxXva3MouN0UXH8UC+RUNuOnCuOpa0A+k5JuiwfCOwo3yt+3ZmKkcAd14p
         tGCOqnGIccnLWFeXfDoIQMKJJxsVE4L7DZvG0rXC7DK5PWKGkhtA6a7bdVTOlQLQPrdj
         f8/LFj2loMVsNmlnB+gt2EZ6MyZ/4bIZLxHPt5csEsXYq8X722PnoM5JFWhcjEdzzLGq
         6A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOfsQfqk6xnh1iTLfTAqoyruTN6lABtLlvex7Rk4Lzg=;
        b=Ivx69Wioc4WShIlrKYaPX2+ZNQ2zJJwiM8TJkCHBb2zgSS4taJFDUJsW37M+afNpHb
         y77YMFO9eYZErGHy/hx2gPgWavWd1G9qNMGiXowsgrf2p4IwRq5ldyTUa0QiVgnqLxFt
         d1QB20PJQ00+DFSUCpkO/fmWONJtdiQnAC3ftDfOAuLXy25lXFj4PGAcDsXgk3SOjJPi
         by96U76nXsLISVf5rzgOk/HBYWJ8WTz5e/ZVRyTqVM8imI3WTRKQLteI6Nvznq3I6MqU
         8rO7mgrHLvIeBec0FRUAXS+fKqowpD3MiGe4od29coY/G94u/b8WJFPDJ+DbqmN2YSBs
         UpdA==
X-Gm-Message-State: AOAM533pUIJXsshrId5WOUfmEDCZDO4kM/uxSZEPNf81jjNT113AGhB+
        /5neWm3rKMct6kDL5lANyf+EB040/7cbIP6zYLg=
X-Google-Smtp-Source: ABdhPJy3vY4xEr2ychPSFBX20/CmjmdawOdJkIcspH9K7mVWCHe/qCqwyNnHkm5r4olWHr+XIvucNgwpqgVitMUJWG8=
X-Received: by 2002:ab0:61d3:: with SMTP id m19mr576135uan.23.1592519158268;
 Thu, 18 Jun 2020 15:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200617162536.611386-1-jim.cromie@gmail.com> <20200617162536.611386-15-jim.cromie@gmail.com>
In-Reply-To: <20200617162536.611386-15-jim.cromie@gmail.com>
From:   jim.cromie@gmail.com
Date:   Thu, 18 Jun 2020 16:25:32 -0600
Message-ID: <CAJfuBxzLrV6aGmt6XwzT352c5-Qb6pN_tJFk7_f4wy8js6MJEA@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] dyndbg: accept query terms like file=bar and module=foo
To:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oops.  got 3 copies of 14/21, this is the good one.  with module=foo
AND file=bar

On Wed, Jun 17, 2020 at 10:26 AM Jim Cromie <jim.cromie@gmail.com> wrote:
>
> Current code expects "keyword" "arg" as 2 space separated words.
> Change to also accept "keyword=arg" form as well, and drop !(nwords%2)
> requirement.
>
> Then in rest of function, use new keyword, arg variables instead of
> word[i], word[i+1]
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  .../admin-guide/dynamic-debug-howto.rst       |  1 +
>  lib/dynamic_debug.c                           | 51 ++++++++++++-------
>  2 files changed, 33 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 6c04aea8f4cd..e5a8def45f3f 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -156,6 +156,7 @@ against.  Possible keywords are:::
>    ``line-range`` cannot contain space, e.g.
>    "1-30" is valid range but "1 - 30" is not.
>
> +  ``module=foo`` combined keyword=value form is interchangably accepted
>
>  The meanings of each keyword are:
>
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 7eb963b1bd11..e1dd96178f18 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -351,6 +351,8 @@ static int check_set(const char **dest, char *src, char *name)
>   * line <lineno>
>   * line <first-lineno>-<last-lineno> // where either may be empty
>   *
> + * Also accept combined keyword=value and keyword:value forms
> + *
>   * Only 1 of each type is allowed.
>   * Returns 0 on success, <0 on error.
>   */
> @@ -360,22 +362,33 @@ static int ddebug_parse_query(char *words[], int nwords,
>         unsigned int i;
>         int rc = 0;
>         char *fline;
> -
> -       /* check we have an even number of words */
> -       if (nwords % 2 != 0) {
> -               pr_err("expecting pairs of match-spec <value>\n");
> -               return -EINVAL;
> -       }
> +       char *keyword, *arg;
>
>         if (modname)
>                 /* support $modname.dyndbg=<multiple queries> */
>                 query->module = modname;
>
> -       for (i = 0; i < nwords; i += 2) {
> -               if (!strcmp(words[i], "func")) {
> -                       rc = check_set(&query->function, words[i+1], "func");
> -               } else if (!strcmp(words[i], "file")) {
> -                       if (check_set(&query->filename, words[i+1], "file"))
> +       for (i = 0; i < nwords; i++) {
> +               /* accept keyword=arg */
> +               vpr_info("%d w:%s\n", i, words[i]);
> +
> +               keyword = words[i];
> +               if ((arg = strchr(keyword, '='))) {
> +                       *arg++ = '\0';
> +               } else {
> +                       i++; /* next word is arg */
> +                       if (!(i < nwords)) {
> +                               pr_err("missing arg to keyword:%s\n", keyword);
> +                               return -EINVAL;
> +                       }
> +                       arg = words[i];
> +               }
> +               vpr_info("%d key:%s arg:%s\n", i, keyword, arg);
> +
> +               if (!strcmp(keyword, "func")) {
> +                       rc = check_set(&query->function, arg, "func");
> +               } else if (!strcmp(keyword, "file")) {
> +                       if (check_set(&query->filename, arg, "file"))
>                                 return -EINVAL;
>
>                         /* tail :$info is function or line-range */
> @@ -391,18 +404,18 @@ static int ddebug_parse_query(char *words[], int nwords,
>                                 if (parse_linerange(query, fline))
>                                         return -EINVAL;
>                         }
> -               } else if (!strcmp(words[i], "module")) {
> -                       rc = check_set(&query->module, words[i+1], "module");
> -               } else if (!strcmp(words[i], "format")) {
> -                       string_unescape_inplace(words[i+1], UNESCAPE_SPACE |
> +               } else if (!strcmp(keyword, "module")) {
> +                       rc = check_set(&query->module, arg, "module");
> +               } else if (!strcmp(keyword, "format")) {
> +                       string_unescape_inplace(arg, UNESCAPE_SPACE |
>                                                             UNESCAPE_OCTAL |
>                                                             UNESCAPE_SPECIAL);
> -                       rc = check_set(&query->format, words[i+1], "format");
> -               } else if (!strcmp(words[i], "line")) {
> -                       if (parse_linerange(query, words[i+1]))
> +                       rc = check_set(&query->format, arg, "format");
> +               } else if (!strcmp(keyword, "line")) {
> +                       if (parse_linerange(query, arg))
>                                 return -EINVAL;
>                 } else {
> -                       pr_err("unknown keyword \"%s\"\n", words[i]);
> +                       pr_err("unknown keyword \"%s\"\n", keyword);
>                         return -EINVAL;
>                 }
>                 if (rc)
> --
> 2.26.2
>
