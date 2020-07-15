Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E97CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B7F20656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DuVK/jNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGOSEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgGOSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:04:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C33C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 11:04:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so3742418wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yU1NdFtVvnE8gwYBk/JwBnZSjJWPPEjHJPEnH/7xEiI=;
        b=DuVK/jNt4ok+WDqZjXF0cgEob6lrTmDamu+pN0/DsMfBuU+KOnBMJFO0vQnxa16rTd
         lBDvht1LSZMzevu8hIjjsh+avrvagi1Lexi6ih0130lOQ7RCebtQ6cHiNOi6b6e5DiHQ
         7u9oGWajmsvWUXmsTdVzocNmeyD3JpPMSKeVKvL6xSEn/fdtvMW0GraVsmgfaoWY1QJp
         7jQPBvBfg/Vol9YPCO2V3QtMUrnbbcr9t6lQnwz35+5QIZ+jxKJkCvuhcKIqU6julfNx
         GQW9HlV2CV0mbVLA26a68+rwj8fTx0WKhrZAxlEITMcT1vGsabOwTsO3YoTtWoTm/XkU
         3dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yU1NdFtVvnE8gwYBk/JwBnZSjJWPPEjHJPEnH/7xEiI=;
        b=REo7S+FaXc/um9dvmO2g/mwjgqs1qo12hD8XOKH+yIMDt5QhoumPG2w0QLdqI4s4pq
         MeOa8codFd4H8nRCld72rNe6Gpv1hv0uE1/0Wntcei545+e5GX+Mvd6vk0N/phYwDhtw
         91RzZESYwitWPndECxiSjfqZQP6M1O0I77pjf89762XsH4oWSGRT6qChbFLBEzuaHAyI
         5tkAdnJ2108z/wHf6qT/qM6O+yTsp4OkBX93xRgW9UdzTsl4LqO2dgv5jOm2obewWKhz
         j0Se0BB1wawXCqmwwpjdukc1h7yht9PdHH72FmAxpmwPrYMbkeQtS20Rp1piQsFtiZpk
         Jggg==
X-Gm-Message-State: AOAM530l0l9bHYVMBlldcAEAGAhGjbY8H7jop/IbEcQfNGy+dqMZL4Ke
        y3uOW08IdZm20D6Ob6u/26ZCsTZpvoAr2nodeYAJcvrE
X-Google-Smtp-Source: ABdhPJys6YkIy7yE+iDPZhDtEw/uVaas+aJ3C2vLTmspshoaUFjb1W18eBaHqAqgul7gt7DBUWpq3jc0oyOty2e4OAc=
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr582438wrn.48.1594836259670;
 Wed, 15 Jul 2020 11:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-19-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-19-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jul 2020 11:04:08 -0700
Message-ID: <CAP-5=fW6OyM1UPZ0HmxjJbHTiag+mCAWd70WO+DJFtBTjsxFHg@mail.gmail.com>
Subject: Re: [PATCH 18/18] perf metric: Rename group_list to list
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
> Following the previous change that rename egroup
> to metric, there's no reason to call the list
> 'group_list' anymore, renaming it to list.

List doesn't seem to be adding information beyond the data type. I
would prefer something like metric_list as it gives a clue what's in
the list. It's a shame we can't have templated lists, if we did then
my data type argument would apply and so maybe output_list would add
information. Probably to save space metric_list is best.

Thanks,
Ian

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/metricgroup.c | 45 +++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 9b880a5fb52b..0645ac1031fe 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -613,7 +613,7 @@ int __weak arch_get_runtimeparam(void)
>         return 1;
>  }
>
> -static int __add_metric(struct list_head *group_list,
> +static int __add_metric(struct list_head *list,
>                         struct pmu_event *pe,
>                         bool metric_no_group,
>                         int runtime,
> @@ -691,13 +691,13 @@ static int __add_metric(struct list_head *group_list,
>         if (m->refs_cnt)
>                 return 0;
>
> -       if (list_empty(group_list))
> -               list_add(&m->nd, group_list);
> +       if (list_empty(list))
> +               list_add(&m->nd, list);
>         else {
>                 struct list_head *pos;
>
>                 /* Place the largest groups at the front. */
> -               list_for_each_prev(pos, group_list) {
> +               list_for_each_prev(pos, list) {
>                         struct metric *old = list_entry(pos, struct metric, nd);
>
>                         if (hashmap__size(&m->pctx.ids) <=
> @@ -775,7 +775,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
>         return p->id ? 0 : -ENOMEM;
>  }
>
> -static int add_metric(struct list_head *group_list,
> +static int add_metric(struct list_head *list,
>                       struct pmu_event *pe,
>                       bool metric_no_group,
>                       struct metric **mp,
> @@ -783,7 +783,7 @@ static int add_metric(struct list_head *group_list,
>
>  static int resolve_metric(struct metric *m,
>                           bool metric_no_group,
> -                         struct list_head *group_list,
> +                         struct list_head *list,
>                           struct pmu_events_map *map)
>  {
>         struct hashmap_entry *cur;
> @@ -814,7 +814,7 @@ static int resolve_metric(struct metric *m,
>                         expr__del_id(&m->pctx, cur->key);
>
>                         /* ... and it gets resolved to the parent context. */
> -                       ret = add_metric(group_list, pe, metric_no_group, &m, parent);
> +                       ret = add_metric(list, pe, metric_no_group, &m, parent);
>                         if (ret)
>                                 return ret;
>
> @@ -829,7 +829,7 @@ static int resolve_metric(struct metric *m,
>         return 0;
>  }
>
> -static int add_metric(struct list_head *group_list,
> +static int add_metric(struct list_head *list,
>                       struct pmu_event *pe,
>                       bool metric_no_group,
>                       struct metric **m,
> @@ -840,7 +840,7 @@ static int add_metric(struct list_head *group_list,
>         pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>
>         if (!strstr(pe->metric_expr, "?")) {
> -               ret = __add_metric(group_list, pe, metric_no_group, 1, m, parent);
> +               ret = __add_metric(list, pe, metric_no_group, 1, m, parent);
>         } else {
>                 int j, count;
>
> @@ -848,11 +848,11 @@ static int add_metric(struct list_head *group_list,
>
>                 /* This loop is added to create multiple
>                  * events depend on count value and add
> -                * those events to group_list.
> +                * those events to list.
>                  */
>
>                 for (j = 0; j < count && !ret; j++) {
> -                       ret = __add_metric(group_list, pe, metric_no_group, j, m, parent);
> +                       ret = __add_metric(list, pe, metric_no_group, j, m, parent);
>                 }
>         }
>
> @@ -861,7 +861,7 @@ static int add_metric(struct list_head *group_list,
>
>  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                                    struct strbuf *events,
> -                                  struct list_head *group_list,
> +                                  struct list_head *list,
>                                    struct pmu_events_map *map)
>
>  {
> @@ -873,7 +873,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>         if (!pe)
>                 return -EINVAL;
>
> -       ret = add_metric(group_list, pe, metric_no_group, &m, NULL);
> +       ret = add_metric(list, pe, metric_no_group, &m, NULL);
>         if (ret)
>                 return ret;
>
> @@ -881,8 +881,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>          * Process any possible referenced metrics
>          * included in the expression.
>          */
> -       ret = resolve_metric(m, metric_no_group,
> -                            group_list, map);
> +       ret = resolve_metric(m, metric_no_group, list, map);
>         if (ret)
>                 return ret;
>
> @@ -905,7 +904,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>
>  static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>                                         struct strbuf *events,
> -                                       struct list_head *group_list,
> +                                       struct list_head *mlist,
>                                         struct pmu_events_map *map)
>  {
>         char *llist, *nlist, *p;
> @@ -921,7 +920,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>
>         while ((p = strsep(&llist, ",")) != NULL) {
>                 ret = metricgroup__add_metric(p, metric_no_group, events,
> -                                             group_list, map);
> +                                             mlist, map);
>                 if (ret == -EINVAL) {
>                         fprintf(stderr, "Cannot find metric or group `%s'\n",
>                                         p);
> @@ -955,11 +954,11 @@ static void metric__free_recursion(struct metric *metric)
>         }
>  }
>
> -static void metricgroup__free_metrics(struct list_head *group_list)
> +static void metricgroup__free_metrics(struct list_head *list)
>  {
>         struct metric *m, *tmp;
>
> -       list_for_each_entry_safe (m, tmp, group_list, nd) {
> +       list_for_each_entry_safe (m, tmp, list, nd) {
>                 metric__free_recursion(m);
>                 metric__free_refs(m);
>                 expr__ctx_clear(&m->pctx);
> @@ -977,13 +976,13 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  {
>         struct parse_events_error parse_error;
>         struct strbuf extra_events;
> -       LIST_HEAD(group_list);
> +       LIST_HEAD(list);
>         int ret;
>
>         if (metric_events->nr_entries == 0)
>                 metricgroup__rblist_init(metric_events);
>         ret = metricgroup__add_metric_list(str, metric_no_group,
> -                                          &extra_events, &group_list, map);
> +                                          &extra_events, &list, map);
>         if (ret)
>                 return ret;
>         pr_debug("adding %s\n", extra_events.buf);
> @@ -994,10 +993,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>                 goto out;
>         }
>         strbuf_release(&extra_events);
> -       ret = metricgroup__setup_events(&group_list, metric_no_merge,
> +       ret = metricgroup__setup_events(&list, metric_no_merge,
>                                         perf_evlist, metric_events);
>  out:
> -       metricgroup__free_metrics(&group_list);
> +       metricgroup__free_metrics(&list);
>         return ret;
>  }
>
> --
> 2.25.4
>
