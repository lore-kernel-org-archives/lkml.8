Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF32BC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861EC20B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lo5n2LqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGSVq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 17:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSVqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 17:46:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097A0C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:46:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so15941425wrp.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U15DiQpwwrkjUs3TnpndJYI5QOKyEAdlj16sEd+GPwU=;
        b=Lo5n2LqU/WaJJ1Zy9GhRri4FbP7iC/VzyAlwQlCTIhSkPaoYfYGtFzOXy5Hnhbh6X+
         PCtguRRmdGE7qpxc7iZ3Z8dV21k4rTe6s7RaS8KIbg4xYuwCIGPWTDekoanOCKXIMTT0
         PB76bRasSuaR/cN9uq1u1INrHdmcckHEjlJ0IXv9IYK7FtyntJ1BzpZ4NB95I+zkqZVD
         a/5Bc63Ra7U+9aIS8WJNA8z/FtDYtDdKx0mDEI841Jy9Rq9uvtrSWi76CKmR0/FBvWMn
         0F6g+99gETc68qJqbpXuSqBylka85akX5PJ1uwPYOAvGRidAhIliBcz2oKT5rtWe+UKC
         Z4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U15DiQpwwrkjUs3TnpndJYI5QOKyEAdlj16sEd+GPwU=;
        b=JYx7c9BF5ff1gcfpCPWWRfXeMGDgQwfMC4YBZ7jvj2YezELSKKeCgAEtDfcKmHbacw
         MRKoXJk0gXKJ0cYnCzVtQlajXd4y+cj54Kw9cIDtpicZV1YTEqp62aM2fqici6IgL8UT
         RWKKG5UzYZHlT6S+hwd93VzHfBZY4io3Vy7i6pFW+kJkM9tHWqjpMXY7yyhG7o+Jthpo
         ONhY0bVrWY7BatwpDcyW1Al5COR1wIpfH6g+bZ0FRZ4ofcRue8oXsDyjpqZlvJxIt8T7
         Vy0WHhScF4x3o/EsSgZExoFLMe0Zba34vJ7s0iW9LQMBLjAwW2h/tImoWWNvetTBNq4q
         wyRg==
X-Gm-Message-State: AOAM5316ch6FJ3Rqb2dJNykS9iMeuZHfm3HM54sQIOVCd9HtT0zxsj1Y
        3kLXKEyriytGu1rF2Sx4SzGJSs5g7ExukNMMYsJHaw==
X-Google-Smtp-Source: ABdhPJzvNyHIxThNV7RYQAZr6s5+RUe9PCDZ47rJHXP9HkSEmEgdbeGP6k1VbS0vtyiYk7+7P/aAAxZtDEdkYCgutxU=
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr18783458wrt.119.1595195183485;
 Sun, 19 Jul 2020 14:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200719181320.785305-1-jolsa@kernel.org> <20200719181320.785305-6-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-6-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 19 Jul 2020 14:46:12 -0700
Message-ID: <CAP-5=fWYOjCSruJ1=c6896zjJe-e-EMKJTrOUcoeo0fED3tk2A@mail.gmail.com>
Subject: Re: [PATCH 05/19] perf metric: Add macros for iterating map events
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

On Sun, Jul 19, 2020 at 11:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding following macros to iterate events and metric:
>   map_for_each_event(__pe, __idx, __map)
>     - iterates over all pmu_events_map events
>   map_for_each_metric(__pe, __idx, __map, __metric)
>     - iterates over all metrics that match __metric argument
>
> and use it in metricgroup__add_metric function. Macros
> will be be used from other places in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/metricgroup.c | 77 ++++++++++++++++++-----------------
>  1 file changed, 40 insertions(+), 37 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index df0356ec120d..b37008fc253c 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -614,6 +614,17 @@ static int __metricgroup__add_metric(struct list_head *group_list,
>         return 0;
>  }
>
> +#define map_for_each_event(__pe, __idx, __map)                         \
> +       for (__idx = 0, __pe = &__map->table[__idx];                    \
> +            __pe->name || __pe->metric_group || __pe->metric_name;     \
> +            __pe = &__map->table[++__idx])
> +
> +#define map_for_each_metric(__pe, __idx, __map, __metric)              \
> +       map_for_each_event(__pe, __idx, __map)                          \
> +               if (__pe->metric_expr &&                                \
> +                   (match_metric(__pe->metric_group, __metric) ||      \
> +                    match_metric(__pe->metric_name, __metric)))
> +
>  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                                    struct strbuf *events,
>                                    struct list_head *group_list,
> @@ -624,49 +635,41 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>         int i, ret;
>         bool has_match = false;
>
> -       for (i = 0; ; i++) {
> -               pe = &map->table[i];
> -
> -               if (!pe->name && !pe->metric_group && !pe->metric_name) {
> -                       /* End of pmu events. */
> -                       if (!has_match)
> -                               return -EINVAL;
> -                       break;
> -               }
> -               if (!pe->metric_expr)
> -                       continue;
> -               if (match_metric(pe->metric_group, metric) ||
> -                   match_metric(pe->metric_name, metric)) {
> -                       has_match = true;
> -                       pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> -
> -                       if (!strstr(pe->metric_expr, "?")) {
> -                               ret = __metricgroup__add_metric(group_list,
> -                                                               pe,
> -                                                               metric_no_group,
> -                                                               1);
> -                               if (ret)
> -                                       return ret;
> -                       } else {
> -                               int j, count;
> +       map_for_each_metric(pe, i, map, metric) {
> +               pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> +               has_match = true;
> +
> +               if (!strstr(pe->metric_expr, "?")) {
> +                       ret = __metricgroup__add_metric(group_list,
> +                                                       pe,
> +                                                       metric_no_group,
> +                                                       1);
> +                       if (ret)
> +                               return ret;
> +               } else {
> +                       int j, count;
>
> -                               count = arch_get_runtimeparam();
> +                       count = arch_get_runtimeparam();
>
> -                               /* This loop is added to create multiple
> -                                * events depend on count value and add
> -                                * those events to group_list.
> -                                */
> +                       /* This loop is added to create multiple
> +                        * events depend on count value and add
> +                        * those events to group_list.
> +                        */
>
> -                               for (j = 0; j < count; j++) {
> -                                       ret = __metricgroup__add_metric(
> -                                               group_list, pe,
> -                                               metric_no_group, j);
> -                                       if (ret)
> -                                               return ret;
> -                               }
> +                       for (j = 0; j < count; j++) {
> +                               ret = __metricgroup__add_metric(
> +                                       group_list, pe,
> +                                       metric_no_group, j);
> +                               if (ret)
> +                                       return ret;
>                         }
>                 }
>         }
> +
> +       /* End of pmu events. */
> +       if (!has_match)
> +               return -EINVAL;
> +
>         list_for_each_entry(eg, group_list, nd) {
>                 if (events->len > 0)
>                         strbuf_addf(events, ",");
> --
> 2.25.4
>
