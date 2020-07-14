Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AE2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBEB20658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/mC/UlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGNVGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgGNVGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:06:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005FDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:06:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so174584wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JMUJfmLILJAC3wwSn7dkUj0r4rvZ4E8tu+aX4YpkZE=;
        b=Q/mC/UlDR1Elq0xd5L9jkydnt5g9mRR0i3iucnKpnRY0OUVyhkxmuS0ax7CwwHuJPe
         TbyPUZVhuGNk0DrbObtKA5lL33TmU/nHEDm7uQZAo5CJPlJeBOYFZ0OaPcGVKZkCyhpW
         trSnU3Soog1BSF1L6VWtC+KgbEku3iXUIxk/RKUh18gIdSSRGqWZGKqBSP483byfBsZk
         DyQw8o+l5fpakYQ1c1uSEkG4vljGiMVszeTJlpeWKZABViI6g4+3jTQwr+9wHGjYaZ8Q
         UZEWl6OvOVnqbQiJhVGoxk0N7YyLwOy678NRLmBTgsD0CA2K3NWDcCtuJ662FcptmYk0
         uawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JMUJfmLILJAC3wwSn7dkUj0r4rvZ4E8tu+aX4YpkZE=;
        b=McOSUjWGYZT8SmSWxzDpZ2kcbr8xTl6yBhQk0kt1YkM0QaV1pQ50OY7HVTDdsbEmBJ
         BHy6THa7eMgS1QXLQYcJ0jqjNJ9XiuMFJmxu/ym2SnDGhbe0ezvniq7UHKZyrMF3IOv3
         jz1CxvmNqzB7n047s0e8cMAj02WRF10h96ocWl8Sz+lpw6ZEo1aFUZegrO65f4g3KBSu
         RrL31WNAdWj+tepTSpOCA1TqS39aQ5qK9uZgFZZLNJC1fh/X+bfwSE5+qAe0nOJUYQEF
         mynNsJSFj0wb92Oi6EEc8Ju/kRjwToCOD++r/MC/b4adKks+C6kT8H892exatSw7nVJH
         mvYg==
X-Gm-Message-State: AOAM530SiPf7cHL1l7oosHGnrkVtEB3+fVnV/CRjF5a+uNaaFZYHSQjx
        9DAlR1pTFdXIy79NL7qEy3/+AU/aVev2FZem+1JRdA==
X-Google-Smtp-Source: ABdhPJzZM6vh0J+v1cYhXpa6uIF84ICMcvhovKgga70JYXwiTm1YOHxTTCCdt2tZOxwIx6xWx6oDv5G//QF3FNjMM8g=
X-Received: by 2002:adf:e40e:: with SMTP id g14mr8377563wrm.271.1594760794276;
 Tue, 14 Jul 2020 14:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-3-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-3-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jul 2020 14:06:23 -0700
Message-ID: <CAP-5=fU=WKHp5So8Wj+HossbjP1TL1gnvPczFQUK32eiuwP4SQ@mail.gmail.com>
Subject: Re: [PATCH 02/18] perf metric: Add struct expr_id_data to keep expr value
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
> Adding struct expr_id_data to keep expr value
> instead of just simple double pointer, so we can
> store more data for ID in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/expr.c       |  3 ++-
>  tools/perf/util/expr.c        | 22 +++++++++++-----------
>  tools/perf/util/expr.h        |  4 ++++
>  tools/perf/util/metricgroup.c |  2 +-
>  4 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index d13fc1dfd5ef..4d01051951cd 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -18,8 +18,9 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
>
>  int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  {
> +       struct expr_id_data *val_ptr;
>         const char *p;
> -       double val, *val_ptr;
> +       double val;
>         int ret;
>         struct expr_parse_ctx ctx;
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 9116a3a01eea..5d05f9765ed8 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -33,32 +33,32 @@ static bool key_equal(const void *key1, const void *key2,
>  }
>
>  /* Caller must make sure id is allocated */
> -int expr__add_id_val(struct expr_parse_ctx *ctx, const char *name, double val)
> +int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
>  {
> -       double *val_ptr = NULL, *old_val = NULL;
> +       struct expr_id_data *data_ptr = NULL, *old_data = NULL;
>         char *old_key = NULL;
>         int ret;
>
>         if (val != 0.0) {
> -               val_ptr = malloc(sizeof(double));
> -               if (!val_ptr)
> +               data_ptr = malloc(sizeof(*data_ptr));
> +               if (!data_ptr)
>                         return -ENOMEM;
> -               *val_ptr = val;
> +               data_ptr->val = val;
>         }
> -       ret = hashmap__set(&ctx->ids, name, val_ptr,
> -                          (const void **)&old_key, (void **)&old_val);
> +       ret = hashmap__set(&ctx->ids, id, data_ptr,
> +                          (const void **)&old_key, (void **)&old_data);
>         free(old_key);
> -       free(old_val);
> +       free(old_data);
>         return ret;
>  }
>
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr)
>  {
> -       double *data;
> +       struct expr_id_data *data;
>
>         if (!hashmap__find(&ctx->ids, id, (void **)&data))
>                 return -1;
> -       *val_ptr = (data == NULL) ?  0.0 : *data;
> +       *val_ptr = (data == NULL) ?  0.0 : data->val;
>         return 0;
>  }
>
> @@ -119,7 +119,7 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
>  int expr__find_other(const char *expr, const char *one,
>                      struct expr_parse_ctx *ctx, int runtime)
>  {
> -       double *old_val = NULL;
> +       struct expr_id_data *old_val = NULL;
>         char *old_key = NULL;
>         int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
>
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index bb6bac836b48..21fe5bd85718 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -15,6 +15,10 @@ struct expr_parse_ctx {
>         struct hashmap ids;
>  };
>
> +struct expr_id_data {
> +       double  val;
> +};
> +
>  struct expr_scanner_ctx {
>         int start_token;
>         int runtime;
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 82fecb5a302d..df0356ec120d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -138,7 +138,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>                                       unsigned long *evlist_used)
>  {
>         struct evsel *ev, *current_leader = NULL;
> -       double *val_ptr;
> +       struct expr_id_data *val_ptr;
>         int i = 0, matched_events = 0, events_to_match;
>         const int idnum = (int)hashmap__size(&pctx->ids);
>
> --
> 2.25.4
>
