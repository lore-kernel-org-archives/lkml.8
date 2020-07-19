Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1657C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC12B20738
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQIFI8N4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGSWcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSWcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:32:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B714BC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:32:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so23392421wmf.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Fj1lDVIZGMoKDaIte5HvaD7Io3UccGe+yTwvWULdbI=;
        b=wQIFI8N4fu4FMCv+yYVm2+HzCNsu+sXrnG7pgyqkzx6myPTl3Ae9v1IseKLRcimzYL
         MZ2KcmpCSzKE96xH9hPk0OOdLeoeZmJAsdZA5yG/GWe3sPaBNyOfNrH8jqDL53PvRkVp
         3i7z3VoVNngfzcFA6r4dRcuOuHuu0wwE/1+aCvLaHKfRH9SA5xTVCHCtACkwpCKBOYbQ
         u6RKFbZMwyGUAh+PG13/kBO9KZmDrh7n/ULp+8masRqQSPCb7QfyVbskK7CiFSDaa4WU
         b9h2PUT79Vof16ix/8nPdnX75ekfv/amwVyJwaqoECkKLaCzoFp0+SQPNO2xdUgduQiW
         pmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Fj1lDVIZGMoKDaIte5HvaD7Io3UccGe+yTwvWULdbI=;
        b=OxPaRBjtpDBgUPLOitYxhuDfZ/0IJAk8MfkWK1EITl340GJq6Sjt2DpLyBcFfPZNKu
         jY1IjG3szmfB3Mtuoz3nVp7bWHyEUOExhlGyNA4GgFlqPgNpO3UZaQMEJ1w0Uj6cRhh/
         KPLZ0sB2F3962nPop7kDh+urCEKQkldwD9BUbBpJHOWziVsi7h+pJ60yorMyFZxlQAyn
         1n8H5IPkq97IVWLdwQRmkiM9VKn2+3DgvKGkBwTWW+t/cbQb2JBqKCLx62ioGoHu5/Hj
         yi8nCT+Vjf8M3UGHi5wbXnVZyHmAuo8A+ivj8ni8Qx2cBxGsXUZdtV7N1mJEIeVK1mJ1
         AHCw==
X-Gm-Message-State: AOAM5305JZ+nsjWYj76p9syP6nLz0RZ4B4rONltuxSdaHUFdwbqYEbmi
        O1h0svMEcF/ownnBDbqT2o+Ub9f65ipjkdAZwmpSAMa7
X-Google-Smtp-Source: ABdhPJzp/nTFMHplK3/6un/PWzGvr/XmxnpM2Lzxl/9DYD5Zw2r41p9JE18UhjxXeTzJQJFjvm1k6hWVzxtNFnAKY3Q=
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr18871406wmz.124.1595197957222;
 Sun, 19 Jul 2020 15:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200719181320.785305-1-jolsa@kernel.org> <20200719181320.785305-11-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-11-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 19 Jul 2020 15:32:26 -0700
Message-ID: <CAP-5=fVQ8Bu=YroJZH-uKmhKYoiK4VqbEnDjVw8f+7dA0+6y1g@mail.gmail.com>
Subject: Re: [PATCH 10/19] perf metric: Add referenced metrics to hash data
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

On Sun, Jul 19, 2020 at 11:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding referenced metrics to the parsing context so they
> can be resolved during the metric processing.
>
> Adding expr__add_ref function to store referenced metrics
> into parse context.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/expr.c        | 54 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/expr.h        | 13 ++++++++-
>  tools/perf/util/stat-shadow.c | 20 +++++++++----
>  3 files changed, 80 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index f726211f49d4..d3997c2b4a90 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -4,10 +4,14 @@
>  #include <errno.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include "metricgroup.h"
> +#include "debug.h"
>  #include "expr.h"
>  #include "expr-bison.h"
>  #include "expr-flex.h"
>  #include <linux/kernel.h>
> +#include <linux/zalloc.h>
> +#include <ctype.h>
>
>  #ifdef PARSER_DEBUG
>  extern int expr_debug;
> @@ -63,6 +67,7 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>         if (!data_ptr)
>                 return -ENOMEM;
>         data_ptr->val = val;
> +       data_ptr->is_ref = false;
>
>         ret = hashmap__set(&ctx->ids, id, data_ptr,
>                            (const void **)&old_key, (void **)&old_data);
> @@ -73,6 +78,55 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>         return ret;
>  }
>
> +int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
> +{
> +       struct expr_id_data *data_ptr = NULL, *old_data = NULL;
> +       char *old_key = NULL;
> +       char *name, *p;
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
> +       /*
> +        * The jevents tool converts all metric expressions
> +        * to lowercase, including metric references, hence
> +        * we need to add lowercase name for metric, so it's
> +        * properly found.
> +        */
> +       for (p = name; *p; p++)
> +               *p = tolower(*p);
> +
> +       /*
> +        * Intentionally passing just const char pointers,
> +        * originally from 'struct pmu_event' object.
> +        * We don't need to change them, so there's no
> +        * need to create our own copy.
> +        */
> +       data_ptr->ref.metric_name = ref->metric_name;
> +       data_ptr->ref.metric_expr = ref->metric_expr;
> +       data_ptr->is_ref = true;
> +
> +       ret = hashmap__set(&ctx->ids, name, data_ptr,
> +                          (const void **)&old_key, (void **)&old_data);
> +       if (ret)
> +               free(data_ptr);
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
> index 2462abd0ac65..81d04ff7f857 100644
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
> +       union {
> +               double val;
> +               struct {
> +                       const char *metric_name;
> +                       const char *metric_expr;
> +               } ref;
> +       };
> +
> +       bool is_ref;
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
