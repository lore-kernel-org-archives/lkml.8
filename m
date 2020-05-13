Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7696FC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09166206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aP1SylTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgEMHJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgEMHJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:09:42 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D058C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:09:42 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id o134so2644434ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6cx1Tz3Y6FqJnvqNPsMB+UsIxEMqYlA+1IxDSZZGbKc=;
        b=aP1SylTUcn5BCMvdwllymvsJGphBoRc/ilYG+T3vDxOffu6ywXkmSSFebLIMmFeDWn
         BRj7vz+SGSOqLw1GciWI2wHh1CstH5ia/NDmuRh++PapE9HgEInMAA855aa6x76O67IK
         mvygWr7e+/OERA46xX0XlbzBJokz4uiHmuRzIQvqujbhWRFiwe4qUSiBRatjBBai7k2T
         UbwXrrOz9iKARI8BpYanqhZd572WmkX99Fd0CZMRUruskUSnz7878SZYWxuofOK6IebU
         tKps5hJ2ZzG37zQwwvJc6DHDHVzjJfUOfSJonSLzTXQ1vN9oSpnapH1Dr/O07Pst35BF
         3t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cx1Tz3Y6FqJnvqNPsMB+UsIxEMqYlA+1IxDSZZGbKc=;
        b=ruHS6IF6a1xldvabPtaytgOQmRamgg7DYgDOVSz+HltQctYS4N+T1/YVo9oZ2MxZ0C
         AlE5UCakS62fH2tmSV1gx6YL4nMLbj8djVWc0lxbIgK5GfJ+FjgOq4Kkn8AXGKPCPY6/
         FnMW+CKvXfbdeUwYXlmVJZC7pc4S56KjxjPygJC7vQhHjdUjWN/+t8NP3WiHzRZjyxpF
         x7nvvBZ+Ssk/zx6WUw+fQugiVZEgsRubEjxpjDP2IPOShDwn408U7vBNPaAifd3qXbuP
         9hL67XnZyS+ZrgR9nPijD3XCOrZsYeauoX/6sCWJpxun5TF1DoQ9MABzbBKvZvRqowEw
         Ferg==
X-Gm-Message-State: AGi0PuZljpluEDJT9UCGzhTsnMMs+ILuN1HDDy/nszXmshrv4TFr0dat
        5TGSQAkS6edrldGRZy9iwKLi9ee8cJOgQXvrbZkzsw==
X-Google-Smtp-Source: APiQypKtylbGK/oYfwYdeNJ+qgnmiU8YXMpUUf52lQm6T1C1K4ElfqEsnnZNhE/oVt6LjnpnlwNYTwqeLApxjXyOUYI=
X-Received: by 2002:a25:d688:: with SMTP id n130mr38707354ybg.324.1589353781454;
 Wed, 13 May 2020 00:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200511205307.3107775-1-jolsa@kernel.org> <20200511205307.3107775-5-jolsa@kernel.org>
In-Reply-To: <20200511205307.3107775-5-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 May 2020 00:09:30 -0700
Message-ID: <CAP-5=fVa+=4cQzw47qSGFQZfqw7Bvx85ZBTJwkHReuJbi4ZGiA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf expr: Report line number with error
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 1:54 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Display line number on when parsing custom metrics file, like:
>
>   $ cat metrics
>   // IPC
>   mine1 = inst_retired.any / cpu_clk_unhalted.thread;
>
>   krava
>   $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
>   failed to parse metrics file: ./metrics:4
>
> Please note that because the grammar is flexible on new lines,
> the syntax could be broken on the next 'not fitting' item and
> not the first wrong word, like:
>
>   $ cat metrics
>   // IPC
>   krava
>   mine1 = inst_retired.any / cpu_clk_unhalted.thread;
>   $ sudo perf stat --metrics-file ./metrics -M mine1 -a -I 1000 --metric-only
>   failed to parse metrics file: ./metrics:3

A line number is better than nothing :-) It'd be nice to be told about
broken events and more information about what's broken in the line. A
common failure is @ vs / encoding and also no-use or misuse of \\.
Perhaps expand the test coverage.

Thanks,
Ian

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/expr.c       |  5 +++++
>  tools/perf/util/expr.h        |  2 ++
>  tools/perf/util/expr.l        | 10 ++++++++++
>  tools/perf/util/expr.y        |  8 +++++---
>  tools/perf/util/metricgroup.c |  3 ++-
>  5 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index c62e122fe719..3bffcd9f8397 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -84,5 +84,10 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>                 zfree(&ctx.custom[i].name);
>                 zfree(&ctx.custom[i].expr);
>         }
> +
> +       expr__ctx_init(&ctx);
> +       ret = expr__parse_custom(&ctx, "IPC=INSTRUCTIONS / CYCLES;\n error");
> +       TEST_ASSERT_VAL("parse custom failed", ret != 0);
> +       TEST_ASSERT_VAL("parse custom count", ctx.lineno == 2);
>         return 0;
>  }
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index ef116b58a5d4..ce95dfd2ad5a 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -27,6 +27,8 @@ struct expr_parse_ctx {
>                         struct expr_parse_custom custom[EXPR_MAX];
>                 };
>         };
> +       /* Set on error for custom metrics. */
> +       int lineno;
>  };
>
>  struct expr_scanner_ctx {
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index e9b294ba09fc..718aac4316d7 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -1,6 +1,8 @@
>  %option prefix="expr_"
>  %option reentrant
>  %option bison-bridge
> +%option bison-locations
> +%option yylineno
>
>  %{
>  #include <linux/compiler.h>
> @@ -79,6 +81,13 @@ static int str(yyscan_t scanner, int token, int runtime)
>         yylval->str = normalize(yylval->str, runtime);
>         return token;
>  }
> +
> +#define YY_USER_ACTION                         \
> +do {                                           \
> +       yylloc->last_line = yylloc->first_line; \
> +       yylloc->first_line = yylineno;          \
> +} while (0);
> +
>  %}
>
>  %x custom
> @@ -101,6 +110,7 @@ all         [^;]+
>
>                 if (sctx->start_token) {
>                         sctx->start_token = 0;
> +                       yylineno = 1;
>                         return start_token;
>                 }
>         }
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 0521e48fa5e3..812d893bcd31 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -18,6 +18,7 @@
>  %parse-param { struct expr_parse_ctx *ctx }
>  %parse-param {void *scanner}
>  %lex-param {void* scanner}
> +%locations
>
>  %union {
>         double   num;
> @@ -39,12 +40,13 @@
>  %type <num> expr if_expr
>
>  %{
> -static void expr_error(double *final_val __maybe_unused,
> -                      struct expr_parse_ctx *ctx __maybe_unused,
> +static void expr_error(YYLTYPE *loc, double *final_val __maybe_unused,
> +                      struct expr_parse_ctx *ctx,
>                        void *scanner,
>                        const char *s)
>  {
> -       pr_debug("%s\n", s);
> +       pr_debug("%s, line %d\n", s, loc->last_line);
> +       ctx->lineno = loc->last_line;
>  }
>
>  static int lookup_id(struct expr_parse_ctx *ctx, char *id, double *val)
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 3b4d5bdb5ac6..36df43546e84 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -615,7 +615,8 @@ static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
>                 ret = expr__parse_custom(&ctx, buf);
>                 free(buf);
>                 if (ret) {
> -                       pr_err("failed to parse metrics file: %s\n", metrics_file);
> +                       pr_err("failed to parse metrics file: %s:%d\n",
> +                               metrics_file, ctx.lineno);
>                         return -1;
>                 }
>         }
> --
> 2.25.4
>
