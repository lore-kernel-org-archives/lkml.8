Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B6DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3452067D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0ozwMR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGNVLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgGNVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:11:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6013C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:11:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so158680wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojcSMWBtY7u+CjYmd74/kAQvI15WEU4Or6gUCK1Km7c=;
        b=h0ozwMR4QdnFXPq1Eu/IUUzZ0vyn7dQxLbSiWTziJlLaF3dCyg/VrvDHq+vOqYXpZR
         E0xbrcWB3caHPhvKlu8r7nvrWoxREXCfvrQNEzOyzVz7HXUewi9VQVmH1CXqe4YZT0oN
         8NRFykyriZsaK3qRz8BSD0bTVvlXnKwCy5aKy2hmn1c0WoibHONdBQMYwZQiNkydPc8T
         C8l8n26NJFq88nuwY6I5FwdFafGWqRgjPoH78Hb6e42PjHUvsNnzEPlU9bFSQwEafp3Y
         yzOagwRq5tCTOHaI3zQA3Rli60dRAen82kCON3zK35oKQH3y7WRJf9TLUGL8xJ6vGx3j
         MB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojcSMWBtY7u+CjYmd74/kAQvI15WEU4Or6gUCK1Km7c=;
        b=fXK6iUlH8jWryPyZqUi+s1dZX6sm6RUUe4XJmXn/jYJis2qPBI9vN35AWDdzS/nkoA
         VgiHaimnc3tZXUshZJpXoBuK1+/okXKG5u7vtesow+IDIsOIJF2ZMREB0Wu3giv06xzY
         8XOEp/g17uhxALN5IaYFyxoLwm3sX4s4vZycYZFpPeKjfjG3Rax6Qo40OmHYq1E6F56m
         aXdON7o59tYZ5Jmy3CWBA8+aKeDO5FZzT1tSIWnZEFYQC5DbnSGkxoIOEBA7OQcTqxvd
         MRiYaySKy+UbI5S764GvugyUwvKKhNTXYebiGTyR+M+EOlyU9qu34YXZN+z0JCtsvC5l
         dhGA==
X-Gm-Message-State: AOAM531e0FOOYO7x6cxFwedIdVe+bjx2Mb38ty05ftLcAS0aYlpIZY25
        k0qbVBwTVE6/XUFpIaUdoH5Swbo+Ez1iebP0bTa40ynYBQtrFg==
X-Google-Smtp-Source: ABdhPJxuX9pwd0xWMYRj3bvfJIjBk0P17xVA3/LSF6gQdhDLAgqFZbGf6JeDKtKGQRNiHuDQ7BPC26nJeRGuyLtHNhw=
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr7655356wrt.119.1594761073310;
 Tue, 14 Jul 2020 14:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-8-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-8-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jul 2020 14:11:02 -0700
Message-ID: <CAP-5=fUdSGvd9DYoFM5eGU8itjER=AYXcL33vDWDMTP3GZfZJg@mail.gmail.com>
Subject: Re: [PATCH 07/18] perf metric: Add add_metric function
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
> Decouple metric adding login into add_metric function,

s/login/logging/ ?

> so it can be used from other places in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 42 ++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 72552608ff7d..9a168f3df7a4 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -634,18 +634,11 @@ static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *
>         return NULL;
>  }
>
> -static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> -                                  struct strbuf *events,
> -                                  struct list_head *group_list,
> -                                  struct pmu_events_map *map)
> +static int add_metric(struct list_head *group_list,
> +                     struct pmu_event *pe,
> +                     bool metric_no_group)
>  {
> -       struct pmu_event *pe;
> -       struct egroup *eg;
> -       int ret;
> -
> -       pe = find_metric(metric, map);
> -       if (!pe)
> -               return -EINVAL;
> +       int ret = 0;
>
>         pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>
> @@ -654,8 +647,6 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                                                 pe,
>                                                 metric_no_group,
>                                                 1);
> -               if (ret)
> -                       return ret;
>         } else {
>                 int j, count;
>
> @@ -666,14 +657,33 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                  * those events to group_list.
>                  */
>
> -               for (j = 0; j < count; j++) {
> +               for (j = 0; j < count && !ret; j++) {
>                         ret = __metricgroup__add_metric(
>                                 group_list, pe,
>                                 metric_no_group, j);
> -                       if (ret)
> -                               return ret;
>                 }
>         }
> +
> +       return ret;
> +}
> +
> +static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> +                                  struct strbuf *events,
> +                                  struct list_head *group_list,
> +                                  struct pmu_events_map *map)
> +{
> +       struct pmu_event *pe;
> +       struct egroup *eg;
> +       int ret;
> +
> +       pe = find_metric(metric, map);
> +       if (!pe)
> +               return -EINVAL;
> +
> +       ret = add_metric(group_list, pe, metric_no_group);
> +       if (ret)
> +               return ret;
> +
>         list_for_each_entry(eg, group_list, nd) {
>                 if (events->len > 0)
>                         strbuf_addf(events, ",");
> --
> 2.25.4
>
