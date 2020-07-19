Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655F5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B98208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORfdGJdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgGSWmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSWmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:42:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAB7C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:42:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so20506946wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InNAb5u7mYNRF2NZXJcSDpG408C3Is27+csdtIXrcwQ=;
        b=ORfdGJdovIxIlTbNSYkvJoqFnFkxMjS5bbDp+8ksHwqo80zCo0MywZ5bHNlzBdwO2a
         Hpkv4pLhJRqKXxut+f7IMpBE5P2+YY4B2tPRiT2GFK/UO6JN50l6XDIMPBAVsDUwf3mw
         XDl0pZZHqIwUTABLHipFnWB3pWOCBD/adkeVhWu4mcX0DHUJfFMRsxv3bkWUZJ1YjPZU
         PAMfvukvpwovKXEKpJPgmfqoguYPtHa0jHvirgbRLOc0D50qyhqUgAWMLpfPEUf/a+qx
         zcWO+Rx0je6oBYMsXMxrnJOzAQ2HCXi2BGDBb5KoUlwtds3uYQiAiTRj+xW6ttGHTFeu
         8WpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InNAb5u7mYNRF2NZXJcSDpG408C3Is27+csdtIXrcwQ=;
        b=ouxBQdDMNGIjYRmzIKgsE4DXM2MD2LNlqWECcVovD7yMzEDm/TxcEqNDf+OdSuyFLl
         nC6ZyYMfrxwn1vpRJCE1ZFc1EwUnUbpExFMKenLGsX+vaVCA5DATUydGtJ59lZaPPECP
         mIGp2VLsN8Igfeq9BNRPNd06w5OgBBJRGaR9piQmnAUWQeg86EmbsvTzju2E+NmV2VEU
         I5XfxvC24tmLUQj0mZwBMt2ig+xjOfO3wGwnGJifElWcA/podxqRpjOI9Tlk/YRfM245
         6e8LRc4ZqXbDVj4l9ubzjUgxagZthkLw3vv1JlFxzQNuBm/kgndvmB6hlDXU1WhjkRZt
         ETZA==
X-Gm-Message-State: AOAM5304Ca1WHOL5amZ/GGvbq0ZtWbr+nVjbObx8yHJYp+wGOWh7tIVJ
        lgUmHwmllCNCRexK512j1UifEhUFXU3nY5rR1t76cQ==
X-Google-Smtp-Source: ABdhPJx6sQUrDHyUJ6iORPD32DWs/BrywP3VeLt5EU3015H+zLMc9tpR8nay6OsnRdGQiwm58nQeECu4UAwvMn+iMF8=
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr18319081wmf.87.1595198538141;
 Sun, 19 Jul 2020 15:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200719181320.785305-1-jolsa@kernel.org> <20200719181320.785305-20-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-20-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 19 Jul 2020 15:42:06 -0700
Message-ID: <CAP-5=fXie3Vf7NwEAUPMCGP1R4SVFZr=y0z4yp1iomjqCja0Yg@mail.gmail.com>
Subject: Re: [PATCH 19/19] perf metric: Rename group_list to metric_list
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
> Following the previous change that rename egroup
> to metric, there's no reason to call the list
> 'group_list' anymore, renaming it to metric_list.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 42 +++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 9d5fff36042d..6f179b9903a0 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -639,7 +639,7 @@ int __weak arch_get_runtimeparam(void)
>         return 1;
>  }
>
> -static int __add_metric(struct list_head *group_list,
> +static int __add_metric(struct list_head *metric_list,
>                         struct pmu_event *pe,
>                         bool metric_no_group,
>                         int runtime,
> @@ -726,13 +726,13 @@ static int __add_metric(struct list_head *group_list,
>         if (m->metric_refs_cnt)
>                 return 0;
>
> -       if (list_empty(group_list))
> -               list_add(&m->nd, group_list);
> +       if (list_empty(metric_list))
> +               list_add(&m->nd, metric_list);
>         else {
>                 struct list_head *pos;
>
>                 /* Place the largest groups at the front. */
> -               list_for_each_prev(pos, group_list) {
> +               list_for_each_prev(pos, metric_list) {
>                         struct metric *old = list_entry(pos, struct metric, nd);
>
>                         if (hashmap__size(&m->pctx.ids) <=
> @@ -813,7 +813,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
>         return p->id ? 0 : -ENOMEM;
>  }
>
> -static int add_metric(struct list_head *group_list,
> +static int add_metric(struct list_head *metric_list,
>                       struct pmu_event *pe,
>                       bool metric_no_group,
>                       struct metric **mp,
> @@ -822,7 +822,7 @@ static int add_metric(struct list_head *group_list,
>
>  static int resolve_metric(struct metric *m,
>                           bool metric_no_group,
> -                         struct list_head *group_list,
> +                         struct list_head *metric_list,
>                           struct pmu_events_map *map,
>                           struct expr_ids *ids)
>  {
> @@ -854,7 +854,7 @@ static int resolve_metric(struct metric *m,
>                         expr__del_id(&m->pctx, cur->key);
>
>                         /* ... and it gets resolved to the parent context. */
> -                       ret = add_metric(group_list, pe, metric_no_group, &m, parent, ids);
> +                       ret = add_metric(metric_list, pe, metric_no_group, &m, parent, ids);
>                         if (ret)
>                                 return ret;
>
> @@ -869,7 +869,7 @@ static int resolve_metric(struct metric *m,
>         return 0;
>  }
>
> -static int add_metric(struct list_head *group_list,
> +static int add_metric(struct list_head *metric_list,
>                       struct pmu_event *pe,
>                       bool metric_no_group,
>                       struct metric **m,
> @@ -881,7 +881,7 @@ static int add_metric(struct list_head *group_list,
>         pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>
>         if (!strstr(pe->metric_expr, "?")) {
> -               ret = __add_metric(group_list, pe, metric_no_group, 1, m, parent, ids);
> +               ret = __add_metric(metric_list, pe, metric_no_group, 1, m, parent, ids);
>         } else {
>                 int j, count;
>
> @@ -889,11 +889,11 @@ static int add_metric(struct list_head *group_list,
>
>                 /* This loop is added to create multiple
>                  * events depend on count value and add
> -                * those events to group_list.
> +                * those events to metric_list.
>                  */
>
>                 for (j = 0; j < count && !ret; j++) {
> -                       ret = __add_metric(group_list, pe, metric_no_group, j, m, parent, ids);
> +                       ret = __add_metric(metric_list, pe, metric_no_group, j, m, parent, ids);
>                 }
>         }
>
> @@ -902,7 +902,7 @@ static int add_metric(struct list_head *group_list,
>
>  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                                    struct strbuf *events,
> -                                  struct list_head *group_list,
> +                                  struct list_head *metric_list,
>                                    struct pmu_events_map *map)
>
>  {
> @@ -948,14 +948,14 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                 }
>         }
>
> -       list_splice(&list, group_list);
> +       list_splice(&list, metric_list);
>         expr_ids__exit(&ids);
>         return 0;
>  }
>
>  static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>                                         struct strbuf *events,
> -                                       struct list_head *group_list,
> +                                       struct list_head *metric_list,
>                                         struct pmu_events_map *map)
>  {
>         char *llist, *nlist, *p;
> @@ -971,7 +971,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>
>         while ((p = strsep(&llist, ",")) != NULL) {
>                 ret = metricgroup__add_metric(p, metric_no_group, events,
> -                                             group_list, map);
> +                                             metric_list, map);
>                 if (ret == -EINVAL) {
>                         fprintf(stderr, "Cannot find metric or group `%s'\n",
>                                         p);
> @@ -996,11 +996,11 @@ static void metric__free_refs(struct metric *metric)
>         }
>  }
>
> -static void metricgroup__free_metrics(struct list_head *group_list)
> +static void metricgroup__free_metrics(struct list_head *metric_list)
>  {
>         struct metric *m, *tmp;
>
> -       list_for_each_entry_safe (m, tmp, group_list, nd) {
> +       list_for_each_entry_safe (m, tmp, metric_list, nd) {
>                 metric__free_refs(m);
>                 expr__ctx_clear(&m->pctx);
>                 list_del_init(&m->nd);
> @@ -1017,13 +1017,13 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  {
>         struct parse_events_error parse_error;
>         struct strbuf extra_events;
> -       LIST_HEAD(group_list);
> +       LIST_HEAD(metric_list);
>         int ret;
>
>         if (metric_events->nr_entries == 0)
>                 metricgroup__rblist_init(metric_events);
>         ret = metricgroup__add_metric_list(str, metric_no_group,
> -                                          &extra_events, &group_list, map);
> +                                          &extra_events, &metric_list, map);
>         if (ret)
>                 return ret;
>         pr_debug("adding %s\n", extra_events.buf);
> @@ -1034,10 +1034,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>                 goto out;
>         }
>         strbuf_release(&extra_events);
> -       ret = metricgroup__setup_events(&group_list, metric_no_merge,
> +       ret = metricgroup__setup_events(&metric_list, metric_no_merge,
>                                         perf_evlist, metric_events);
>  out:
> -       metricgroup__free_metrics(&group_list);
> +       metricgroup__free_metrics(&metric_list);
>         return ret;
>  }
>
> --
> 2.25.4
>
