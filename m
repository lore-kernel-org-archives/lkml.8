Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F72CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC91207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvUBVP6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgFZUFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgFZUEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:04:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486EBC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:04:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so10584679wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9iScij+INx6Ii2zxgR7WLn6FdOxcA8dMusmQA4u5sY=;
        b=tvUBVP6PjUWl2uLBtAteWs3IWlbQDnwNilBs3dQXP+1lqrHxkD2lWaaujiQT5GZH4j
         zAtTK982aiVxeuauy2bEb8jQdCp+8asaSvTwDml4dcVMEcgqe4zHBp9WyrwSM1BuBMwV
         Y+edcZxacethaLifNJWB5dzd6UTU70zvd9jEdj6c7T7ZmChPCFDAihhonloAGfYmJ0r6
         jdz4nXnwGQbS1H3porL7kVhAI0UxDSBpVh8xrlYCPG4R7v4/vcT60dcYvmfJcgnD1L/R
         VFfoX7yZBf/CJzpupnr+8TPEotfvlIq4PKXY1diZquRDphcAH04MdXloX4iKK73hP5IW
         jU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9iScij+INx6Ii2zxgR7WLn6FdOxcA8dMusmQA4u5sY=;
        b=XrLw2iJ9eWqhS3dI7RKDJk70JS1sG4mbyDiG4yE06xapsFWvZ7fgTcGv3HwYtpWoSK
         v7L2fpZAoGgcyVbLp6jNy68fld16TjwccjWUyuxH3MIu/eV2xmQ6si9gachp/eITrInv
         AVF9ha36EGskoa6DBpA4k/o9sEWcHPA45ZFPyeslMkq+UMYoj9zojwkjPiY1JDcZHoHa
         Uy89Klj7+FjFuDcE/2fKs37y2OTEoLb+3T8Epm9pBlhJ+8UM1mUaxjuAZPCyxeroPZRt
         /zwdmm7UxjWgz7WRH7oMhSNKXX0V4Z324TF/VvI51yta+K2VPhaq541QyRQDGjBZHrUG
         ADUw==
X-Gm-Message-State: AOAM530ZHep+GXnsiFX8FzFWhitqF1GoXaASUlQBv+p1WBvkltpoHnkh
        AphRpz6S06daX0hTEP+7owZwmvk70fJgFSALupQ/wA==
X-Google-Smtp-Source: ABdhPJxO7soteTM7ffFtdAKnmVUUhboe1pbuWLx/y99If5suXZDvykjYXHADm8fTdew4IV9jzvdapb7V2dWjWeC2Di4=
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr5240030wrn.48.1593201892707;
 Fri, 26 Jun 2020 13:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-3-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-3-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Jun 2020 13:04:41 -0700
Message-ID: <CAP-5=fVdSmPEYMqGqCEwZXfj=-wg6sJLQ=kuPTLaPdKiAiqTvg@mail.gmail.com>
Subject: Re: [PATCH 02/10] perf tools: Add struct expr_parse_data to keep expr value
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

On Fri, Jun 26, 2020 at 12:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding struct expr_parse_data to keep expr value
> instead of just simple double pointer, so we can
> store more data for ID in following changes.

Nit, expr_parse_data sounds a bit like data that is created just at
parse time. Perhaps id_data, for data associated with an id?

Thanks,
Ian

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/expr.c       |  3 ++-
>  tools/perf/util/expr.c        | 20 ++++++++++----------
>  tools/perf/util/expr.h        |  4 ++++
>  tools/perf/util/metricgroup.c |  2 +-
>  4 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index 82aa32fcab64..e64461f1a24c 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -18,8 +18,9 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
>
>  int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  {
> +       struct expr_parse_data *val_ptr;
>         const char *p;
> -       double val, *val_ptr;
> +       double val;
>         int ret;
>         struct expr_parse_ctx ctx;
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index a02937e5f3ac..7573b21e73df 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -35,30 +35,30 @@ static bool key_equal(const void *key1, const void *key2,
>  /* Caller must make sure id is allocated */
>  int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
>  {
> -       double *val_ptr = NULL, *old_val = NULL;
> +       struct expr_parse_data *data_ptr = NULL, *old_data = NULL;
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
> +       ret = hashmap__set(&ctx->ids, name, data_ptr,
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
> +       struct expr_parse_data *data;
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
> +       struct expr_parse_data *old_val = NULL;
>         char *old_key = NULL;
>         int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
>
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 35bdc609cf55..f9f16efe76bc 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -15,6 +15,10 @@ struct expr_parse_ctx {
>         struct hashmap ids;
>  };
>
> +struct expr_parse_data {
> +       double  val;
> +};
> +
>  struct expr_scanner_ctx {
>         int start_token;
>         int runtime;
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 82fecb5a302d..85e7fa2e2707 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -138,7 +138,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>                                       unsigned long *evlist_used)
>  {
>         struct evsel *ev, *current_leader = NULL;
> -       double *val_ptr;
> +       struct expr_parse_data *val_ptr;
>         int i = 0, matched_events = 0, events_to_match;
>         const int idnum = (int)hashmap__size(&pctx->ids);
>
> --
> 2.25.4
>
