Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE5CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C6B20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZT1l0CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgFZVQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZVQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:16:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00843C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:16:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so10719462wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7KEnp5jDsjWssrb7n6v7Z1FsPZ5GcqX4Mtfi1TkLNE=;
        b=YZT1l0CL3FyFYzNWyBTpoBkAuzh6F4rSW3MzGlo58Dtref3IdVKnnpaREbhvYSda0n
         fztr+UNlWH9ENEtPV00AMeKHrAciqbkA1kiqaXQ0cz+L+UAqUz8i+nOWjlnvIxAZ7+x9
         WRUxduK9AQXltNu4KhdXNdf6RVqNss+6QD/liLTavLn4q4VIs88aEesLzQX1vMNZxocH
         NEr7E84dhrRZBk3tstkVc4P6HwEqclc51qFetxRWNpaOlDHSYjaZEkHesEr1azbdT9t3
         6bZOqimOkFk0tDdYvNiza3B0zkimnjn5PCD1Ex005z6seIt0QYZS0yimvtTNh6ujiGVy
         EwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7KEnp5jDsjWssrb7n6v7Z1FsPZ5GcqX4Mtfi1TkLNE=;
        b=W7dL5OpCj/tDqFc2qNUaScjOB0MbExeksSyfdN82zwrAdV0s7B8DLfJXJ+DqUl3Fd0
         tpUtbcT3gGQO6wnn1HWdYh69JKWT7Bqm/qhtgtQu7StucbC586OOX29bXV9FRI23cAGg
         yyJQWYIp1+GbtFYw/CynYCmoqwcqdueKGh18Q/DTmco+7jtyLWaAeRZErNby07fjXQxs
         JpXZl2Jz+598AAZxOaxqHIhKNZxHfgsARR/VhVjSaWsWFNKluSyAeQ/7Np1Db1e7dJqp
         qrlBt8SvPhrYPnF5+IqpPIqA/fWm7vB4OB0TK3/PA3SYWujDQLwwCJCapMBHtrmbIhDo
         GMjw==
X-Gm-Message-State: AOAM532kcUgVQdiMS5zFFfWFvX8ankWshc0gNtPbRsGtvydq9i9VoxXI
        rGIlkTZBe7Bd0KvuwW4zDE9ocn0Aedkgh3P//uwM1Q==
X-Google-Smtp-Source: ABdhPJzv3scLW4Vj8pskh2GKB2JHKrHu1KiBnNbVb0m+fgPKW1Me1E31uxspAxra83OzmL7jARZsNVf3/XtV7P06FeM=
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr5459637wrn.48.1593206201350;
 Fri, 26 Jun 2020 14:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-9-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-9-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Jun 2020 14:16:30 -0700
Message-ID: <CAP-5=fVEyyUGU4NPk0wCCYfjkSNw=SBcPy5GWXExFG-Xh0+KFg@mail.gmail.com>
Subject: Re: [PATCH 08/10] perf tools: Add other metrics to hash data
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:48 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding other metrics to the parsing context so they
> can be resolved during the metric processing.
>
> Adding expr__add_other function to store 'other' metrics
> into parse context.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/expr.c        | 35 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/expr.h        | 13 ++++++++++++-
>  tools/perf/util/stat-shadow.c | 19 +++++++++++++------
>  3 files changed, 60 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index cd73dae4588c..32f7acac7c19 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -4,6 +4,8 @@
>  #include <errno.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include "metricgroup.h"
> +#include "debug.h"
>  #include "expr.h"
>  #include "expr-bison.h"
>  #include "expr-flex.h"
> @@ -61,6 +63,7 @@ int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
>         if (!data_ptr)
>                 return -ENOMEM;
>         data_ptr->val = val;
> +       data_ptr->is_other = false;
>
>         ret = hashmap__set(&ctx->ids, name, data_ptr,
>                            (const void **)&old_key, (void **)&old_data);
> @@ -69,6 +72,38 @@ int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
>         return ret;
>  }
>
> +int expr__add_other(struct expr_parse_ctx *ctx, struct metric_other *other)
> +{
> +       struct expr_parse_data *data_ptr = NULL, *old_data = NULL;
> +       char *old_key = NULL;
> +       char *name;
> +       int ret;
> +
> +       data_ptr = malloc(sizeof(*data_ptr));
> +       if (!data_ptr)
> +               return -ENOMEM;
> +
> +       name = strdup(other->metric_name);
> +       if (!name) {
> +               free(data_ptr);
> +               return -ENOMEM;
> +       }
> +
> +       data_ptr->other.metric_name = other->metric_name;
> +       data_ptr->other.metric_expr = other->metric_expr;
> +       data_ptr->is_other = true;
> +
> +       ret = hashmap__set(&ctx->ids, name, data_ptr,
> +                          (const void **)&old_key, (void **)&old_data);
> +
> +       pr_debug2("adding other metric %s: %s\n",
> +                 other->metric_name, other->metric_expr);
> +
> +       free(old_key);
> +       free(old_data);
> +       return ret;
> +}
> +
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>                  struct expr_parse_data **data)
>  {
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index fd924bb4e5cd..ed60f9227b43 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -11,12 +11,22 @@
>  #include "util/hashmap.h"
>  //#endif
>
> +struct metric_other;
> +
>  struct expr_parse_ctx {
>         struct hashmap ids;
>  };
>
>  struct expr_parse_data {
> -       double  val;
> +       bool    is_other;
> +
> +       union {
> +               double  val;
> +               struct {
> +                       const char *metric_name;
> +                       const char *metric_expr;

It is probably worth a comment why both the metric_name and the
metric's expression are required here? The parse and other data for
the metric won't be here.

Thanks,
Ian

> +               } other;
> +       };
>  };
>
>  struct expr_scanner_ctx {
> @@ -29,6 +39,7 @@ void expr__ctx_clear(struct expr_parse_ctx *ctx);
>  void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
>  int expr__add_id(struct expr_parse_ctx *ctx, const char *name);
>  int expr__add_val(struct expr_parse_ctx *ctx, const char *id, double val);
> +int expr__add_other(struct expr_parse_ctx *ctx, struct metric_other *other);
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>                  struct expr_parse_data **data);
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 0a991016f848..434382410170 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -731,13 +731,14 @@ static void print_smi_cost(struct perf_stat_config *config,
>  }
>
>  static int prepare_metric(struct evsel **metric_events,
> +                         struct metric_other *metric_other,
>                           struct expr_parse_ctx *pctx,
>                           int cpu,
>                           struct runtime_stat *st)
>  {
>         double scale;
>         char *n, *pn;
> -       int i;
> +       int i, j;
>
>         expr__ctx_init(pctx);
>         for (i = 0; metric_events[i]; i++) {
> @@ -778,12 +779,18 @@ static int prepare_metric(struct evsel **metric_events,
>                         expr__add_val(pctx, n, avg_stats(stats)*scale);
>         }
>
> +       for (j = 0; metric_other && metric_other[j].metric_name; j++) {
> +               if (expr__add_other(pctx, &metric_other[j]))
> +                       return -ENOMEM;
> +       }
> +
>         return i;
>  }
>
>  static void generic_metric(struct perf_stat_config *config,
>                            const char *metric_expr,
>                            struct evsel **metric_events,
> +                          struct metric_other *metric_other,
>                            char *name,
>                            const char *metric_name,
>                            const char *metric_unit,
> @@ -798,7 +805,7 @@ static void generic_metric(struct perf_stat_config *config,
>         int i;
>         void *ctxp = out->ctx;
>
> -       i = prepare_metric(metric_events, &pctx, cpu, st);
> +       i = prepare_metric(metric_events, metric_other, &pctx, cpu, st);
>         if (i < 0)
>                 return;
>
> @@ -847,7 +854,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_sta
>         struct expr_parse_ctx pctx;
>         double ratio;
>
> -       if (prepare_metric(mexp->metric_events, &pctx, cpu, st) < 0)
> +       if (prepare_metric(mexp->metric_events, mexp->metric_other, &pctx, cpu, st) < 0)
>                 return 0.;
>
>         if (expr__parse(&ratio, &pctx, mexp->metric_expr, 1))
> @@ -1064,8 +1071,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>                 else
>                         print_metric(config, ctxp, NULL, NULL, name, 0);
>         } else if (evsel->metric_expr) {
> -               generic_metric(config, evsel->metric_expr, evsel->metric_events, evsel->name,
> -                               evsel->metric_name, NULL, 1, cpu, out, st);
> +               generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
> +                               evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
>         } else if (runtime_stat_n(st, STAT_NSECS, 0, cpu) != 0) {
>                 char unit = 'M';
>                 char unit_buf[10];
> @@ -1093,7 +1100,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>                         if (num++ > 0)
>                                 out->new_line(config, ctxp);
>                         generic_metric(config, mexp->metric_expr, mexp->metric_events,
> -                                       evsel->name, mexp->metric_name,
> +                                       mexp->metric_other, evsel->name, mexp->metric_name,
>                                         mexp->metric_unit, mexp->runtime, cpu, out, st);
>                 }
>         }
> --
> 2.25.4
>
