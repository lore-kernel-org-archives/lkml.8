Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70779C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439F020658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEQB91Zb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgGNV24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgGNV24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:28:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D90C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:28:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so961422wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GpQ2nTVgl9VHF6JY6WDJ53QAh2uhLUNW3Mar+OyQZbM=;
        b=NEQB91ZbGya6R2upSrLKRfi8KuMsERBDit3367O8XOCDov47EWXESnNZS/Exznj1pf
         3zkhjn8Z6VvUMj1XnEVqRwadV/8SD+LVg7c0MyGGCXbTsBqn7mHT25X74BLm6E2t1BIj
         AHmmkoFL+d1MhnJ5r6By5XnwpfnPrgu9RrJQTbEF/FNkihbb2Jc2BKgo4nwzY7zqCjbH
         BSn49UCom/ygIRJ1XcW5hYZLPSmALo4CspsA/o9MDPGI/bpQwIG/vyUSRZSD4l9rkvK1
         vSbKHqhuUdsLSCoWUam5/splpzvGOyvJubzorsQVYLwPuvvPboBkYjyc0yJC6A5aVbZh
         DdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GpQ2nTVgl9VHF6JY6WDJ53QAh2uhLUNW3Mar+OyQZbM=;
        b=tmX2fk7Ju+lbshXzgK3fyFmyCY88mxA4m+Q3p5Li8c5pYSiUbz2Boyiu7ljlCYWTDY
         vLsraIznMiUg+ftAIWqeoJK1XK980q/Pa/yshHpagNwqdMLQjaVplYT3BBm5w7S7Apo6
         3xvhR973yOoURfpxmPk04ZS31YlMlN1l6i3U4JlTkijCjKpixMYJZdzXWprM3DxE6Np9
         zlCkJ6+G6u4q3hywzrKRuVmUpCsL4jCvCWywvbpSiKdxTlZIsu7KAzddo2L6Cs2ohBPT
         hI0ya0uHZZ2SWBvNm7t+5/tWs2QdmYTaAUbYPR4JmGXXfvz17w7WBHykUGm2eZynYrlb
         mQ6Q==
X-Gm-Message-State: AOAM533mggGqWaebDpkV7v//NE1xltfbu4Vmev7zSMVUzJ8LZVR/UMG/
        xDHHs+GPo9mZg/sOtWeqGMce7422Eo9NW34YZjMAotDpqg0=
X-Google-Smtp-Source: ABdhPJwpPAm74H0SvmIQNdcH3mj34EyGmIpZjHCzd/YAdJd30s4vvgXWoss0YiaRhUy3ADdkAgTEptyhGTTBKAAPsHA=
X-Received: by 2002:a1c:398b:: with SMTP id g133mr5452807wma.76.1594760748029;
 Tue, 14 Jul 2020 14:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-2-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-2-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jul 2020 14:05:36 -0700
Message-ID: <CAP-5=fW+1PxuzcPKN8iMSH3y_6qRTkiry6+gO3JpeT5kWxiOoQ@mail.gmail.com>
Subject: Re: [PATCH 01/18] perf metric: Rename expr__add_id to expr__add_val
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

On Sun, Jul 12, 2020 at 6:26 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Renaming expr__add_id to expr__add_val so we can use
> expr__add_id to actually add just id without any value
> in following changes.
>
> There's no functional change.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/expr.c       | 4 ++--
>  tools/perf/tests/pmu-events.c | 4 ++--
>  tools/perf/util/expr.c        | 2 +-
>  tools/perf/util/expr.h        | 2 +-
>  tools/perf/util/expr.y        | 2 +-
>  tools/perf/util/stat-shadow.c | 4 ++--
>  6 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index b7e5ef3007fc..d13fc1dfd5ef 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -24,8 +24,8 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>         struct expr_parse_ctx ctx;
>
>         expr__ctx_init(&ctx);
> -       expr__add_id(&ctx, strdup("FOO"), 1);
> -       expr__add_id(&ctx, strdup("BAR"), 2);
> +       expr__add_id_val(&ctx, strdup("FOO"), 1);
> +       expr__add_id_val(&ctx, strdup("BAR"), 2);
>
>         ret = test(&ctx, "1+1", 2);
>         ret |= test(&ctx, "FOO+BAR", 3);
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index b66b021476ec..eb19f9a0bc15 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -492,7 +492,7 @@ static int test_parsing(void)
>                          */
>                         k = 1;
>                         hashmap__for_each_entry((&ctx.ids), cur, bkt)
> -                               expr__add_id(&ctx, strdup(cur->key), k++);
> +                               expr__add_id_val(&ctx, strdup(cur->key), k++);
>
>                         hashmap__for_each_entry((&ctx.ids), cur, bkt) {
>                                 if (check_parse_cpu(cur->key, map == cpus_map,
> @@ -547,7 +547,7 @@ static int metric_parse_fake(const char *str)
>          */
>         i = 1;
>         hashmap__for_each_entry((&ctx.ids), cur, bkt)
> -               expr__add_id(&ctx, strdup(cur->key), i++);
> +               expr__add_id_val(&ctx, strdup(cur->key), i++);
>
>         hashmap__for_each_entry((&ctx.ids), cur, bkt) {
>                 if (check_parse_fake(cur->key)) {
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index e8f777830a23..9116a3a01eea 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -33,7 +33,7 @@ static bool key_equal(const void *key1, const void *key2,
>  }
>
>  /* Caller must make sure id is allocated */
> -int expr__add_id(struct expr_parse_ctx *ctx, const char *name, double val)
> +int expr__add_id_val(struct expr_parse_ctx *ctx, const char *name, double val)
>  {
>         double *val_ptr = NULL, *old_val = NULL;
>         char *old_key = NULL;
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 8a2c1074f90f..bb6bac836b48 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -22,7 +22,7 @@ struct expr_scanner_ctx {
>
>  void expr__ctx_init(struct expr_parse_ctx *ctx);
>  void expr__ctx_clear(struct expr_parse_ctx *ctx);
> -int expr__add_id(struct expr_parse_ctx *ctx, const char *id, double val);
> +int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
>                 const char *expr, int runtime);
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 5fcb98800f9c..b2b3420ea6ec 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -69,7 +69,7 @@ all_other: all_other other
>
>  other: ID
>  {
> -       expr__add_id(ctx, $1, 0.0);
> +       expr__add_id_val(ctx, $1, 0.0);
>  }
>  |
>  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 8fdef47005e6..fc9ac4b4218e 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -773,9 +773,9 @@ static int prepare_metric(struct evsel **metric_events,
>                         *pn = 0;
>
>                 if (metric_total)
> -                       expr__add_id(pctx, n, metric_total);
> +                       expr__add_id_val(pctx, n, metric_total);
>                 else
> -                       expr__add_id(pctx, n, avg_stats(stats)*scale);
> +                       expr__add_id_val(pctx, n, avg_stats(stats)*scale);
>         }
>
>         return i;
> --
> 2.25.4
>
