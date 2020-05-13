Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90692C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EA020718
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRJnt5ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgEMGub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgEMGua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:50:30 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C118BC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:50:30 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id d197so8293447ybh.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcLdh0O2W/Nn5JaiSxiYY8PcL31pGWZBc4xoz2Bs3PU=;
        b=ZRJnt5yeQGSxFjsxcZuxnLLWa1v6G+5UXVtG0xb+qjo/KxeGFhJJNe/XIR98vT2rNs
         ITnw5Rh3xNLjWjsZ5tg/7QOZzUj3LDDttCz6ySy1ZLh11yg7H8VAURK/eBjYeemncCB2
         lTy8XUiFFOR2ind5GygS7dgNlyRHXFi1M6SuDUlVo1d5ecitbi2y0Kekw4yFwK9FMGTL
         hT/oz2icoqxp6nI1jq0mg3eUqYWQGQvpzdDyIvZycscW9lwXNpsTkLs2ax8p1vx95SOs
         7dUcG9kENY7bghKkG66/+IX7KjlGTlv0LPwI52rneAknd8g+YOyPkQ8Dt2wTdi8MLlj6
         ruaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcLdh0O2W/Nn5JaiSxiYY8PcL31pGWZBc4xoz2Bs3PU=;
        b=mb7toitDI+xO1ADbTQC2AyO/0YsSsBL2UUKmVA6HA2uaRrif1EoSckMFGg5OevjWYb
         eMyFfnL7mK3zCXa1YMFbHlI8Xa+jwXR8s2ymtPvNv5F/4J1ewPC+WsvWHVzgbIuhBJ4T
         Qm/g2YF7RnJ/8/3queKgVtc46b9s/b2cHaLOkENqIj8U33m8AgQDij9LN8HViu9kil38
         0AMw4nOie5f/50niSkFM5//SaF+S0QAPFWv+aF4PLhCuIW/VzsynZdVLl2at8NdmVNGp
         KyYSa2SrasXegn3CUJywls2PrbFUt17ElZ9LlbwKowFhMRhrzjgDNpXno9ucozQNwqIy
         3CPQ==
X-Gm-Message-State: AGi0PuZ5jiqY8O/rQTJ5UNBDSubP4O1jWZJY81Y3hu+PB7GXhqyx6uOe
        MKl0YdtlrzV8b4KghxTz+N5g/eRWtUiSMtZaRi1N8w==
X-Google-Smtp-Source: APiQypIL0kTHiBcmLqwV5uExAv2r6xo0MwIgZxqEV6qr8tWgBkl0mxi41y2blGfaTjpZp+PSJN6vC/xcRFLI8qBmUmg=
X-Received: by 2002:a25:c08b:: with SMTP id c133mr39334270ybf.286.1589352629731;
 Tue, 12 May 2020 23:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200511205307.3107775-1-jolsa@kernel.org> <20200511205307.3107775-2-jolsa@kernel.org>
In-Reply-To: <20200511205307.3107775-2-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 May 2020 23:50:18 -0700
Message-ID: <CAP-5=fU_JxSRJqY0zGo1UHj2gzoAigfr=g-1fUUU8W62pB9auA@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf expr: Add parsing support for multiple expressions
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
> Adding support to parse metric difinitions in following form:

Typo on definitions.

>   NAME = EXPRESSION ;
>   NAME = EXPRESSION ;
>   ...
>
> The parsed NAME and EXPRESSION will be used in following
> changes to feed the metric code with definitions from
> custom file.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/expr.c | 13 +++++++++++++
>  tools/perf/util/expr.c  |  6 ++++++
>  tools/perf/util/expr.h  | 19 +++++++++++++++++--
>  tools/perf/util/expr.l  | 12 ++++++++++++
>  tools/perf/util/expr.y  | 13 ++++++++++++-
>  5 files changed, 60 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index f9e8e5628836..c62e122fe719 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -71,5 +71,18 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>                 zfree(&other[i]);
>         free((void *)other);
>
> +       expr__ctx_init(&ctx);
> +       ret = expr__parse_custom(&ctx, "IPC=INSTRUCTIONS / CYCLES; CPI=CYCLES / INSTRUCTIONS;");
> +       TEST_ASSERT_VAL("parse custom failed", ret == 0);
> +       TEST_ASSERT_VAL("parse custom count", ctx.num_custom == 2);
> +       TEST_ASSERT_VAL("parse custom name", !strcmp(ctx.custom[0].name, "IPC"));
> +       TEST_ASSERT_VAL("parse custom name", !strcmp(ctx.custom[1].name, "CPI"));
> +       TEST_ASSERT_VAL("parse custom expr", !strcmp(ctx.custom[0].expr, "INSTRUCTIONS / CYCLES"));
> +       TEST_ASSERT_VAL("parse custom expr", !strcmp(ctx.custom[1].expr, "CYCLES / INSTRUCTIONS"));
> +
> +       for (i = 0; i < ctx.num_custom; i++) {
> +               zfree(&ctx.custom[i].name);
> +               zfree(&ctx.custom[i].expr);
> +       }
>         return 0;
>  }
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 8b4ce704a68d..d744cb15c1d4 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -23,6 +23,7 @@ void expr__add_id(struct expr_parse_ctx *ctx, const char *name, double val)
>  void expr__ctx_init(struct expr_parse_ctx *ctx)
>  {
>         ctx->num_ids = 0;
> +       ctx->num_custom = 0;
>  }
>
>  static int
> @@ -61,6 +62,11 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr,
>         return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
>  }
>
> +int expr__parse_custom(struct expr_parse_ctx *ctx, const char *expr)
> +{
> +       return __expr__parse(NULL, ctx, expr, EXPR_CUSTOM, 0);
> +}
> +
>  static bool
>  already_seen(const char *val, const char *one, const char **other,
>              int num_other)
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 40fc452b0f2b..ef116b58a5d4 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -4,15 +4,29 @@
>
>  #define EXPR_MAX_OTHER 64
>  #define MAX_PARSE_ID EXPR_MAX_OTHER
> +#define EXPR_MAX 20

Currently deduplication of ids is done after rather than during
expression pasing, meaning hitting these limits is quite easy. This is
fixed in:
https://lore.kernel.org/lkml/20200508053629.210324-8-irogers@google.com/
But not for custom expressions being added here. I plan to rebase that
work and clone hashmap from libbpf into libapi to workaround the
dependency issue.
That patch also adds expr__ctx_clear as a convenience for cleaning up
the context, and passes the context around inside of metricgroup
rather than ids.

>  struct expr_parse_id {
>         const char *name;
>         double val;
>  };
>
> +struct expr_parse_custom {
> +       const char *name;
> +       const char *expr;
> +};
> +
>  struct expr_parse_ctx {
> -       int num_ids;
> -       struct expr_parse_id ids[MAX_PARSE_ID];
> +       union {
> +               struct {
> +                       int                      num_ids;
> +                       struct expr_parse_id     ids[MAX_PARSE_ID];
> +               };
> +               struct {
> +                       int                      num_custom;
> +                       struct expr_parse_custom custom[EXPR_MAX];
> +               };
> +       };
>  };
>
>  struct expr_scanner_ctx {
> @@ -23,6 +37,7 @@ struct expr_scanner_ctx {
>  void expr__ctx_init(struct expr_parse_ctx *ctx);
>  void expr__add_id(struct expr_parse_ctx *ctx, const char *id, double val);
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr, int runtime);
> +int expr__parse_custom(struct expr_parse_ctx *ctx, const char *expr);
>  int expr__find_other(const char *expr, const char *one, const char ***other,
>                 int *num_other, int runtime);
>
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index ceab11bea6f9..c6a930ed22e6 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -81,12 +81,15 @@ static int str(yyscan_t scanner, int token, int runtime)
>  }
>  %}
>
> +%x custom
> +
>  number         [0-9]*\.?[0-9]+
>
>  sch            [-,=]
>  spec           \\{sch}
>  sym            [0-9a-zA-Z_\.:@?]+
>  symbol         ({spec}|{sym})+
> +all            [^;]+
>
>  %%
>         struct expr_scanner_ctx *sctx = expr_get_extra(yyscanner);
> @@ -100,6 +103,12 @@ symbol             ({spec}|{sym})+
>                 }
>         }
>
> +<custom>{
> +
> +{all}          { BEGIN(INITIAL); return str(yyscanner, ALL, sctx->runtime); }
> +
> +}
> +
>  max            { return MAX; }
>  min            { return MIN; }
>  if             { return IF; }
> @@ -118,6 +127,9 @@ else                { return ELSE; }
>  "("            { return '('; }
>  ")"            { return ')'; }
>  ","            { return ','; }
> +";"            { return ';'; }
> +"="            { BEGIN(custom); return '='; }

Will this interfere with the \\= encoded in MetricExpr? Could you test with:
https://lore.kernel.org/lkml/20200513062752.3681-2-irogers@google.com/

> +\n             { }
>  .              { }
>  %%
>
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 21e82a1e11a2..0521e48fa5e3 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -24,9 +24,10 @@
>         char    *str;
>  }
>
> -%token EXPR_PARSE EXPR_OTHER EXPR_ERROR
> +%token EXPR_PARSE EXPR_OTHER EXPR_CUSTOM EXPR_ERROR
>  %token <num> NUMBER
>  %token <str> ID
> +%token <str> ALL

Missing %destructor, fix is here:
https://lore.kernel.org/lkml/20200513000318.15166-1-irogers@google.com/

Thanks,
Ian

>  %token MIN MAX IF ELSE SMT_ON
>  %left MIN MAX IF
>  %left '|'
> @@ -66,6 +67,16 @@ start:
>  EXPR_PARSE all_expr
>  |
>  EXPR_OTHER all_other
> +|
> +EXPR_CUSTOM all_custom
> +
> +all_custom: all_custom ID '=' ALL ';'
> +{
> +       ctx->custom[ctx->num_custom].name = $2;
> +       ctx->custom[ctx->num_custom].expr = $4;
> +       ctx->num_custom++;
> +}
> +|
>
>  all_other: all_other other
>  |
> --
> 2.25.4
>
