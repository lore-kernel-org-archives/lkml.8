Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0386C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F50A20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEqQNdtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFZVYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZVYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:24:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F999C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:24:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so10015605wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFld+pvL9COhBAEZPPDCYJGhbTqDM28+9dTDeaOw7rA=;
        b=NEqQNdtdl52GO4quuoSUq6e0YDbRhE8CZakbgLkH48eFAS589Vm3KSgMbdWCGR6e97
         fd5JubDcOi7ih/d68lyGwewZec3s7OfvMSabLyPksA+ZWXCaSybje4iU9EYsoJKpB6MK
         15dK2IOZ83+9VPI+WjbvuZ8eSNta3pwoNht2FtP8n4Efb309iWcr7Nqmf73R4BMCgVVD
         bJBnMd9QyYjAJV4v7u/idt4PCynSIx4AVY+CTUbhzwkK2QwmLtZsO9wbtatNEx648gOk
         6FQglca/tyE4IrMzhJGVm1Xwdi3BA0tF/iJHHIEjArelzittmzcdtoVlvgkMHqFVEO70
         IjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFld+pvL9COhBAEZPPDCYJGhbTqDM28+9dTDeaOw7rA=;
        b=PtriwzHj7b3cocgfB4vG4xbR1ZdPm5qN6oEdYtdKRPDDNoj38mjLW1MSrZoBtDcOgm
         j32tKK1Zu6M/ZORpZpNtxIRokElXedGxUHLGV8G0Nk0zq839/E079n1PuroXQ0EUkuwk
         VoCpQ5QfYQ0Kxbote1mf2tAxI9CGaj/QowgeunKLgtw/YEkL5l3C6liOArqaRsL2WqpN
         VinOpRSg1woBMp0yH9onxcWElFn8+BiL4VUktr0wjNGSC1NbFU6Pg47+O7FKQPJaKJOC
         bSE3MZxTZUZWXChMmY5yaIv34IHpRdsZ1rovCLQExm+fgvy5p4p1rXg7TpdkZHJatkAS
         ST4Q==
X-Gm-Message-State: AOAM531BQAObHl+oCqbG9oJXhaLvEUOULTw1zLB9V+ttVOdURCUKccLt
        JRTwnZ6Xiw0+60OPb7DW8BVVK0Ha6KcHJy4DWdaFKnl6H38=
X-Google-Smtp-Source: ABdhPJz2K+Dt6QvPgW9TaRJxxB2ycTnXg5bTwN3xZ6Wd7K0rU4LpApdedbU07QYL47wgofElot4FytAHMKruFnH2mMc=
X-Received: by 2002:a1c:398b:: with SMTP id g133mr5201274wma.76.1593206689968;
 Fri, 26 Jun 2020 14:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-10-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-10-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Jun 2020 14:24:38 -0700
Message-ID: <CAP-5=fUODuF+LY6cbU4BPEcxu_YXDYg42pgRYU=yY5e47z05=g@mail.gmail.com>
Subject: Re: [PATCH 09/10] perf tools: Compute other metrics
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
> Adding computation (expr__parse call) of 'other' metric at
> the point when it needs to be resolved during the 'master'
> metric computation.
>
> Once the inner metric is computed, the result is stored and
> used if there's another usage of that metric.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/expr.c |  3 +++
>  tools/perf/util/expr.h |  1 +
>  tools/perf/util/expr.y | 20 +++++++++++++++++++-
>  3 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 32f7acac7c19..1b6d550cec5f 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -91,6 +91,7 @@ int expr__add_other(struct expr_parse_ctx *ctx, struct metric_other *other)
>
>         data_ptr->other.metric_name = other->metric_name;
>         data_ptr->other.metric_expr = other->metric_expr;
> +       data_ptr->other.counted = false;
>         data_ptr->is_other = true;
>
>         ret = hashmap__set(&ctx->ids, name, data_ptr,
> @@ -150,6 +151,8 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
>         void *scanner;
>         int ret;
>
> +       pr_debug2("parsing metric: %s\n", expr);
> +
>         ret = expr_lex_init_extra(&scanner_ctx, &scanner);
>         if (ret)
>                 return ret;
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index ed60f9227b43..f85f3941eda5 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -25,6 +25,7 @@ struct expr_parse_data {
>                 struct {
>                         const char *metric_name;
>                         const char *metric_expr;
> +                       bool counted;
>                 } other;
>         };
>  };
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 6252d9f6cfc8..cca423331f65 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -89,12 +89,30 @@ if_expr:
>  expr:    NUMBER
>         | ID                    {
>                                         struct expr_parse_data *data;
> +                                       char *lookup = $1;
> +                                       const char *name;
>
> -                                       if (expr__get_id(ctx, $1, &data) || !data) {
> +                                       if (expr__is_metric($1, &name))
> +                                               lookup = name;
> +
> +                                       if (expr__get_id(ctx, lookup, &data) || !data) {
>                                                 pr_debug("%s not found\n", $1);
>                                                 free($1);
>                                                 YYABORT;
>                                         }
> +
> +                                       pr_debug2("lookup: is_other %d, counted %d: %s\n",
> +                                                 data->is_other, data->other.counted, lookup);
> +
> +                                       if (data->is_other && !data->other.counted) {
> +                                               data->other.counted = true;
> +                                               if (expr__parse(&data->val, ctx, data->other.metric_expr, 1)) {

Ah, so this handles the problem the referenced metric isn't calculated
and calculates it - with the sharing of events this doesn't impose
extra pmu cost. Do we need to worry about detecting recursion? For
example:

"MetricName": "Foo",
"MetricExpr": "1/metric:Foo",

It seems unfortunate to have the MetricExpr calculated twice, but it
is understandable. Is it also a property that referenced/other metrics
won't be reported individually? Perhaps these are sub-metrics?

Thanks,
Ian

> +                                                       pr_debug("%s failed to count\n", $1);
> +                                                       free($1);
> +                                                       YYABORT;
> +                                               }
> +                                       }
> +
>                                         $$ = data->val;
>                                         free($1);
>                                 }
> --
> 2.25.4
>
