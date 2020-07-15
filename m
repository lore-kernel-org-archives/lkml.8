Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE9AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC092072D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeoNgx8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgGOAMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 20:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgGOAMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 20:12:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A631C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 17:12:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so579458wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 17:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sneM91rbI/nDHEsWP+L7URp2+UR8C8X7sfxWS1/+l7o=;
        b=IeoNgx8cdpYeAccA0uobhRHb5Z1AiDBQeDVnP2vLAatouPAyojkmncBb7SW7Rd3oMS
         +aAHajEqlfaW0Vb6OjAwVqRoMwYkZaolo7m7veropFVzLcsKps3SC4iurtswUYUMCZVh
         Js14A4U5rSyI1lW6mJFMLbw5ipdFhfabzsZWa/mGOHfMS0FLF7ME87aRI3OIIUjhjUCA
         njRY01u91xfXqoDXHZHh/KcLltem7kL0+Z5VL4WNfBz+GJWDIbq9DqRUNdkVfq4IFDrZ
         QkDxyQqMCNnFOFss2xwdpFvi3goOqWnR+ASj/7ftOurvD4H4TrBw7lFVdlH/dwBELXf8
         m6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sneM91rbI/nDHEsWP+L7URp2+UR8C8X7sfxWS1/+l7o=;
        b=FH4OkNfTI0ZJVWzGf0JAbJlxFc6ejrPCrZPNnvcGgkROilbQ5QP3g6fAwHW92Q42H8
         JmqJMYZXSlWzs3ZyJB1096wfLCv6YZZgmDT+/9z312Ji15NBzao696leNwCk55Dl1krB
         /X3K0D0xXxGcVuiIp9f0ySvIvqwJlwKvgu9YNvxwaU3J8qpwbT3JxHNcDOWYzMWD6xFB
         7Fv5oQSO76mmM3Co4kolSGohB0SZsVfQzEjMNYIoOk3QJ764t+bjLTL/M8/Q/ZLW6hze
         v8TdegH1fMwgUYuMb7YbnJxRRU55HfScNh29Ptz6PTwwPLqjpadz8w6Wnoay8m3os7jZ
         gM0w==
X-Gm-Message-State: AOAM530V84ol46gebt2qOxxUjfiMZR/SpsaSNLjcVTwY3s/E6XcOJKQS
        1pyGr5JZR2zgo0A3B1raHfm+9lQSAWE8nZzQONaIWA==
X-Google-Smtp-Source: ABdhPJzrYJ4qEvtSH6cYIMsTC+j2czH1YQqYtoKTph6QpAMMU7w68aMvKN+k3v4azq08KsmnZj8vc+4C9VAUYcDWQLU=
X-Received: by 2002:adf:82e1:: with SMTP id 88mr8104138wrc.376.1594771958519;
 Tue, 14 Jul 2020 17:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-13-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-13-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jul 2020 17:12:26 -0700
Message-ID: <CAP-5=fV-tCNpvDVs9aqOsBVCGQZej0jJ_Pki_pSmbL3g99cGqQ@mail.gmail.com>
Subject: Re: [PATCH 12/18] perf metric: Compute referenced metrics
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
> Adding computation (expr__parse call) of referenced metric at
> the point when it needs to be resolved during the 'master'
> metric computation.

Same note on wrt master:
https://www.kernel.org/doc/html/latest/process/coding-style.html?highlight=language%20master#naming

> Once the inner metric is computed, the result is stored and
> used if there's another usage of that metric.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/expr.c | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/expr.h |  3 +++
>  tools/perf/util/expr.y |  4 ++--
>  3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 6bf8a21f5c53..2784df38f8c2 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -91,6 +91,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
>
>         data_ptr->ref.metric_name = ref->metric_name;
>         data_ptr->ref.metric_expr = ref->metric_expr;
> +       data_ptr->ref.counted = false;
>         data_ptr->is_ref = true;
>
>         ret = hashmap__set(&ctx->ids, name, data_ptr,
> @@ -110,6 +111,34 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>         return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
>  }
>
> +int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
> +                    struct expr_id_data **datap)
> +{
> +       struct expr_id_data *data;
> +
> +       if (expr__get_id(ctx, id, datap) || !*datap) {
> +               pr_debug("%s not found\n", id);
> +               return -1;
> +       }
> +
> +       data = *datap;
> +
> +       pr_debug2("lookup: is_ref %d, counted %d, val %f: %s\n",
> +                 data->is_ref, data->ref.counted, data->val, id);
> +
> +       if (data->is_ref && !data->ref.counted) {
> +               data->ref.counted = true;
> +               pr_debug("processing metric: %s ENTRY\n", id);
> +               if (expr__parse(&data->val, ctx, data->ref.metric_expr, 1)) {
> +                       pr_debug("%s failed to count\n", id);
> +                       return -1;
> +               }
> +               pr_debug("processing metric: %s EXIT: %f\n", id, data->val);
> +       }
> +
> +       return 0;
> +}
> +
>  void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
>  {
>         struct expr_id_data *old_val = NULL;
> @@ -150,6 +179,8 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
>         void *scanner;
>         int ret;
>
> +       pr_debug2("parsing metric: %s\n", expr);
> +
>         ret = expr_lex_init_extra(&scanner_ctx, &scanner);
>         if (ret)
>                 return ret;
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index d19e66915228..b6d1fba64eaa 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -25,6 +25,7 @@ struct expr_id_data {
>                 struct {
>                         const char *metric_name;
>                         const char *metric_expr;
> +                       bool counted;
>                 } ref;
>         };
>  };
> @@ -42,6 +43,8 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
>  int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref);
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>                  struct expr_id_data **data);
> +int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
> +                    struct expr_id_data **datap);
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
>                 const char *expr, int runtime);
>  int expr__find_other(const char *expr, const char *one,
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 0d4f5d324be7..d34b370391c6 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -88,11 +88,11 @@ expr:         NUMBER
>         | ID                    {
>                                         struct expr_id_data *data;
>
> -                                       if (expr__get_id(ctx, $1, &data) || !data) {
> -                                               pr_debug("%s not found\n", $1);
> +                                       if (expr__resolve_id(ctx, $1, &data)) {
>                                                 free($1);
>                                                 YYABORT;
>                                         }
> +
>                                         $$ = data->val;
>                                         free($1);
>                                 }
> --
> 2.25.4
>
