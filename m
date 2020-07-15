Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8972065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0tco6Qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGOSZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgGOSZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:25:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893AAC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 11:25:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so6802695wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bYz3ytAoO3b0Y3LpdzlDntKE8haNaBP35mAEVAyO90=;
        b=W0tco6QtntMCHWP3vy1HIok4Q5laSivPaecVQmQDxTQIxVe6cNmZuxrWTvyQijWO+O
         3s1QWiYH8ffeYX66YJnivMSt1vvkXne7qOIcLkmL5oQbhyVlxCaR49kNppXnj+eCzwbo
         f01e1Gp9c3Eoavs10Nx0aGxwk4vDmhLIZoblFEkXLoRh4MiXWC2M48YDJWRWRjW25qKe
         3/WsoEsA2LcnXtS98g+kC8diVSJ1pJ5aL2mu/3G42gt9FbOfNKw8L+Ip+0Dwoy+1x0Ba
         kMV7PbiqKp8fkO+rAPy9Xa8eb87nUJ4yeeybH9Q3CaSbh8KPvdX1now/UDRZ8xi1NrN9
         d1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bYz3ytAoO3b0Y3LpdzlDntKE8haNaBP35mAEVAyO90=;
        b=mS1Xk/IozVKnkFD3umQhx5Ny2ZvW7TAH8kxBIhQHxryFCaXzXauOWg74rtmrzk6gQP
         HNUQrM06qhzd4ysujVeSPIndd6fqGa0/vNZOY13xn9KZTxhOpYUsF3lIqQxqxDtxEgt9
         totcTUSIEAiuY6aVfH61fp3CZSenoTMnIIO+Uf7NOZZsIUQpFwvqEgUvyQZyf3gtL3mn
         0cx2Z9yICiRpacXvCguVXSNIBpsAc3umnQXN38XRSXJTFUJeGvtVNKxfUtgFTYNVjrSr
         QC+GZvDc5jtPf/G5TqSh2fuAF/nLwb0N0rFKMCUibXLCIIAy+iHVq6QPmlHme2lMln6N
         bmWg==
X-Gm-Message-State: AOAM530vXhdhdbZ1R+5qCDBce+XE9N3sgaQvaV5RJ6ObhXbKyTnYnQxs
        JEglp+ubhOxOPV0AZyvn42TrYMQk779cDtGGlDwTMQ==
X-Google-Smtp-Source: ABdhPJzWBZLOodqAik7+KM+TFyH8x1Tdbrwi6N2rMvDjjZxKMlw59iCJFYCvhwfyiRKGipQbV5Edawf73kr9YbLlQBs=
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr686895wmz.124.1594837525834;
 Wed, 15 Jul 2020 11:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-12-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-12-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jul 2020 11:25:14 -0700
Message-ID: <CAP-5=fW2wknhCEQ8cPtmup6vQgWC45s9a0WJ+NsYt9Uu-Qm3Mw@mail.gmail.com>
Subject: Re: [PATCH 11/18] perf metric: Add referenced metrics to hash data
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

On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding referenced metrics to the parsing context so they
> can be resolved during the metric processing.
>
> Adding expr__add_ref function to store referenced metrics
> into parse context.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/expr.c        | 35 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/expr.h        | 13 ++++++++++++-
>  tools/perf/util/stat-shadow.c | 20 ++++++++++++++------
>  3 files changed, 61 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 91142d4c3419..6bf8a21f5c53 100644
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
> @@ -61,6 +63,7 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>         if (!data_ptr)
>                 return -ENOMEM;
>         data_ptr->val = val;
> +       data_ptr->is_ref = false;
>
>         ret = hashmap__set(&ctx->ids, id, data_ptr,
>                            (const void **)&old_key, (void **)&old_data);
> @@ -69,6 +72,38 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>         return ret;
>  }
>
> +int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
> +{
> +       struct expr_id_data *data_ptr = NULL, *old_data = NULL;
> +       char *old_key = NULL;
> +       char *name;
> +       int ret;
> +
> +       data_ptr = zalloc(sizeof(*data_ptr));
> +       if (!data_ptr)
> +               return -ENOMEM;
> +
> +       name = strdup(ref->metric_name);
> +       if (!name) {
> +               free(data_ptr);
> +               return -ENOMEM;
> +       }
> +
> +       data_ptr->ref.metric_name = ref->metric_name;
> +       data_ptr->ref.metric_expr = ref->metric_expr;

Having one owned string and one unowned makes the memory management
here somewhat complicated. Perhaps dupe both?

> +       data_ptr->is_ref = true;
> +
> +       ret = hashmap__set(&ctx->ids, name, data_ptr,
> +                          (const void **)&old_key, (void **)&old_data);
> +
> +       pr_debug2("adding ref metric %s: %s\n",
> +                 ref->metric_name, ref->metric_expr);
> +
> +       free(old_key);
> +       free(old_data);
> +       return ret;
> +}
> +
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>                  struct expr_id_data **data)
>  {
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 2462abd0ac65..d19e66915228 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -11,12 +11,22 @@
>  #include "util/hashmap.h"
>  //#endif
>
> +struct metric_ref;
> +
>  struct expr_parse_ctx {
>         struct hashmap ids;
>  };
>
>  struct expr_id_data {
> -       double  val;
> +       bool    is_ref;

nit: place at the end to avoid padding?

> +
> +       union {
> +               double  val;
> +               struct {
> +                       const char *metric_name;
> +                       const char *metric_expr;
> +               } ref;
> +       };
>  };
>
>  struct expr_scanner_ctx {
> @@ -29,6 +39,7 @@ void expr__ctx_clear(struct expr_parse_ctx *ctx);
>  void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
>  int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
>  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
> +int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>                  struct expr_id_data **data);
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index fc9ac4b4218e..e1ba6c1b916a 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -731,13 +731,14 @@ static void print_smi_cost(struct perf_stat_config *config,
>  }
>
>  static int prepare_metric(struct evsel **metric_events,
> +                         struct metric_ref *metric_refs,

nit: the plural on refs confused me at first, perhaps a comment that
this is the array of referenced metrics.

Thanks,
Ian

>                           struct expr_parse_ctx *pctx,
>                           int cpu,
>                           struct runtime_stat *st)
>  {
>         double scale;
>         char *n, *pn;
> -       int i;
> +       int i, j, ret;
>
>         expr__ctx_init(pctx);
>         for (i = 0; metric_events[i]; i++) {
> @@ -778,12 +779,19 @@ static int prepare_metric(struct evsel **metric_events,
>                         expr__add_id_val(pctx, n, avg_stats(stats)*scale);
>         }
>
> +       for (j = 0; metric_refs && metric_refs[j].metric_name; j++) {
> +               ret = expr__add_ref(pctx, &metric_refs[j]);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return i;
>  }
>
>  static void generic_metric(struct perf_stat_config *config,
>                            const char *metric_expr,
>                            struct evsel **metric_events,
> +                          struct metric_ref *metric_refs,
>                            char *name,
>                            const char *metric_name,
>                            const char *metric_unit,
> @@ -798,7 +806,7 @@ static void generic_metric(struct perf_stat_config *config,
>         int i;
>         void *ctxp = out->ctx;
>
> -       i = prepare_metric(metric_events, &pctx, cpu, st);
> +       i = prepare_metric(metric_events, metric_refs, &pctx, cpu, st);
>         if (i < 0)
>                 return;
>
> @@ -847,7 +855,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_sta
>         struct expr_parse_ctx pctx;
>         double ratio;
>
> -       if (prepare_metric(mexp->metric_events, &pctx, cpu, st) < 0)
> +       if (prepare_metric(mexp->metric_events, mexp->metric_refs, &pctx, cpu, st) < 0)
>                 return 0.;
>
>         if (expr__parse(&ratio, &pctx, mexp->metric_expr, 1))
> @@ -1064,8 +1072,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
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
> @@ -1093,7 +1101,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>                         if (num++ > 0)
>                                 out->new_line(config, ctxp);
>                         generic_metric(config, mexp->metric_expr, mexp->metric_events,
> -                                       evsel->name, mexp->metric_name,
> +                                       mexp->metric_refs, evsel->name, mexp->metric_name,
>                                         mexp->metric_unit, mexp->runtime, cpu, out, st);
>                 }
>         }
> --
> 2.25.4
>
