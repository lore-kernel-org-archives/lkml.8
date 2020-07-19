Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA463C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988D0208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUhZ+Ws3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGSWkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSWkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:40:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA1FC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:40:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so23400649wmf.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6E1TD7GZNSTWV461H0sB0oCsPcWKqf+nAnS+IdR/xJE=;
        b=ZUhZ+Ws3sf/v9V2tAY4+Emm8NiZaAzf4eKSIGXQveh4fTe0VzEEB9IOk5dCeHUCGqb
         ZNNbczk3i0ERCM2QR+GMiNhjUOiX7IypqF7dgFTcYbywftVA1jzKTSp6pzR0xqLYZcUu
         MFBaPhYA2YUK62FOUUUHugtHRVmDWNNMdN/e7x72zQ3IH7xe2FWP1eNYNCPOwaf/ruEu
         g3K+nfM2rlAVIIHzlG2hB+DwadXw1AuVVhpxQJHcBvG+f/tphFMpn278CjxdenAY30rE
         suEX7G/o3FLzI8xxhCb8ey0gZVxADzxZo6EQxRNojr5Qn/W8utjZTg3objP2SHCJApkG
         oQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6E1TD7GZNSTWV461H0sB0oCsPcWKqf+nAnS+IdR/xJE=;
        b=KsVAsD4yLi7VRU3Hf9xKhYutDZ1KbjC9zIwWKLeWdlmI6OSBZX9cGWd6aPG9zaUV+k
         ymltdZyV6Pp3SqemSHyMWxmC1w900Ka13BcNI2xthnzwUZ5xr9XfC4+w4wxB3ImrPg/l
         U9gjfafM7P1qpw2ZtY9HFlyfnRpfUF7F9/tyK1j20fgf4Ov0gZYH8VijjEdQOWbKoy+E
         +NO57GQRg4TgIhcfji8C80UvC/uBfhfMp35QuOwcSe6CtWhwy6MkB2arFHDuxcFvOB9t
         +XWEn/86SnR8ihkdDteUVaDxuY5AXhmsa/GNEOHX77pyymMdW/Pw5Lv/5M6MSklpM9/6
         0Trw==
X-Gm-Message-State: AOAM5320T3PSUqXM6AncN1Ix4TqmVnDNRj/H5nJlz6tCxdA8pgN80ihB
        Z/WJLE8donJi04ExjF6FPs0YO2iVBOz2ILM50fAnrw==
X-Google-Smtp-Source: ABdhPJzBOzi88CtWO6A/2kQrK+6rmD96Znh28dXbvtvaHhdii9wadndW4UJpZkyxkKu3azmP25MERfVcA4xm+EIlajg=
X-Received: by 2002:a1c:48c5:: with SMTP id v188mr18426516wma.58.1595198437917;
 Sun, 19 Jul 2020 15:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200719181320.785305-1-jolsa@kernel.org> <20200719181320.785305-16-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-16-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 19 Jul 2020 15:40:26 -0700
Message-ID: <CAP-5=fVNoaURV=CG=H0C6XBQvzBphh=NhMjRmAoRS6Ja8H17QA@mail.gmail.com>
Subject: Re: [PATCH 15/19] perf metric: Add recursion check when processing
 nested metrics
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
> Keeping the stack of nested metrics via 'struct expr_id' objects
> and checking if we are in recursion via already processed metric.
>
> The stack is implemented as static array within the struct egroup
> with 100 entries, which should be enough nesting depth for any
> metric we have or plan to have at the moment.
>
> Adding test that simulates the recursion and checks we can
> detect it.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/parse-metric.c |  34 +++++++++-
>  tools/perf/util/expr.c          |   2 +
>  tools/perf/util/expr.h          |   9 ++-
>  tools/perf/util/metricgroup.c   | 117 +++++++++++++++++++++++++++++---
>  4 files changed, 149 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index aa4d5a9f09a8..01370ccb9ed9 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -57,6 +57,18 @@ static struct pmu_event pme_test[] = {
>         .metric_expr    = "d_ratio(dcache_l2_all_miss, dcache_l2_all)",
>         .metric_name    = "DCache_L2_Misses",
>  },
> +{
> +       .metric_expr    = "ipc + m2",
> +       .metric_name    = "M1",
> +},
> +{
> +       .metric_expr    = "ipc + m1",
> +       .metric_name    = "M2",
> +},
> +{
> +       .metric_expr    = "1/m3",
> +       .metric_name    = "M3",
> +}
>  };
>
>  static struct pmu_events_map map = {
> @@ -139,8 +151,8 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
>         err = metricgroup__parse_groups_test(evlist, &map, name,
>                                              false, false,
>                                              &metric_events);
> -
> -       TEST_ASSERT_VAL("failed to parse metric", err == 0);
> +       if (err)
> +               return err;
>
>         if (perf_evlist__alloc_stats(evlist, false))
>                 return -1;
> @@ -264,11 +276,29 @@ static int test_dcache_l2(void)
>         return 0;
>  }
>
> +static int test_recursion_fail(void)
> +{
> +       double ratio;
> +       struct value vals[] = {
> +               { .event = "inst_retired.any",        .val = 300 },
> +               { .event = "cpu_clk_unhalted.thread", .val = 200 },
> +               { 0 },
> +       };
> +
> +       TEST_ASSERT_VAL("failed to find recursion",
> +                       compute_metric("M1", vals, &ratio) == -1);
> +
> +       TEST_ASSERT_VAL("failed to find recursion",
> +                       compute_metric("M3", vals, &ratio) == -1);
> +       return 0;
> +}
> +
>  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>         TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
>         TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
>         TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
>         TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
> +       TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
>         return 0;
>  }
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index a346ca590513..53482ef53c41 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -47,6 +47,8 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
>         if (!data_ptr)
>                 return -ENOMEM;
>
> +       data_ptr->parent = ctx->parent;
> +
>         ret = hashmap__set(&ctx->ids, id, data_ptr,
>                            (const void **)&old_key, (void **)&old_data);
>         if (ret)
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 9ed208d93418..fc2b5e824a66 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -13,8 +13,14 @@
>
>  struct metric_ref;
>
> +struct expr_id {
> +       char            *id;
> +       struct expr_id  *parent;
> +};
> +
>  struct expr_parse_ctx {
> -       struct hashmap ids;
> +       struct hashmap   ids;
> +       struct expr_id  *parent;
>  };
>
>  struct expr_id_data {
> @@ -25,6 +31,7 @@ struct expr_id_data {
>                         const char *metric_expr;
>                         bool counted;
>                 } ref;
> +               struct expr_id  *parent;
>         };
>
>         bool is_ref;
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 332414d93f7a..2a45ee94fd61 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -24,6 +24,7 @@
>  #include <subcmd/parse-options.h>
>  #include <api/fs/fs.h>
>  #include "util.h"
> +#include <asm/bug.h>
>
>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
>                                          struct evsel *evsel,
> @@ -126,6 +127,28 @@ struct egroup {
>         bool has_constraint;
>  };
>
> +#define RECURSION_ID_MAX 100
> +
> +struct expr_ids {
> +       struct expr_id  id[RECURSION_ID_MAX];
> +       int             cnt;
> +};
> +
> +static struct expr_id *expr_ids__alloc(struct expr_ids *ids)
> +{
> +       if (ids->cnt >= RECURSION_ID_MAX)
> +               return NULL;
> +       return &ids->id[ids->cnt++];
> +}
> +
> +static void expr_ids__exit(struct expr_ids *ids)
> +{
> +       int i;
> +
> +       for (i = 0; i < ids->cnt; i++)
> +               free(ids->id[i].id);
> +}
> +
>  /**
>   * Find a group of events in perf_evlist that correpond to those from a parsed
>   * metric expression. Note, as find_evsel_group is called in the same order as
> @@ -620,7 +643,9 @@ static int __add_metric(struct list_head *group_list,
>                         struct pmu_event *pe,
>                         bool metric_no_group,
>                         int runtime,
> -                       struct egroup **egp)
> +                       struct egroup **egp,
> +                       struct expr_id *parent,
> +                       struct expr_ids *ids)
>  {
>         struct metric_ref_node *ref;
>         struct egroup *eg;
> @@ -630,7 +655,7 @@ static int __add_metric(struct list_head *group_list,
>                  * We got in here for the parent group,
>                  * allocate it and put it on the list.
>                  */
> -               eg = malloc(sizeof(*eg));
> +               eg = zalloc(sizeof(*eg));
>                 if (!eg)
>                         return -ENOMEM;
>
> @@ -643,6 +668,18 @@ static int __add_metric(struct list_head *group_list,
>                 INIT_LIST_HEAD(&eg->metric_refs);
>                 eg->metric_refs_cnt = 0;
>                 *egp = eg;
> +
> +               parent = expr_ids__alloc(ids);
> +               if (!parent) {
> +                       free(eg);
> +                       return -EINVAL;
> +               }
> +
> +               parent->id = strdup(pe->metric_name);
> +               if (!parent->id) {
> +                       free(eg);
> +                       return -ENOMEM;
> +               }
>         } else {
>                 /*
>                  * We got here for the referenced metric, via the
> @@ -668,6 +705,10 @@ static int __add_metric(struct list_head *group_list,
>                 eg->metric_refs_cnt++;
>         }
>
> +       /* Force all found IDs in metric to have us as parent ID. */
> +       WARN_ON_ONCE(!parent);
> +       eg->pctx.parent = parent;
> +
>         /*
>          * For both the parent and referenced metrics, we parse
>          * all the metric's IDs and add it to the parent context.
> @@ -728,15 +769,62 @@ static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *
>         return NULL;
>  }
>
> +static int recursion_check(struct egroup *eg, const char *id, struct expr_id **parent,
> +                          struct expr_ids *ids)
> +{
> +       struct expr_id_data *data;
> +       struct expr_id *p;
> +       int ret;
> +
> +       /*
> +        * We get the parent referenced by 'id' argument and
> +        * traverse through all the parent object IDs to check
> +        * if we already processed 'id', if we did, it's recursion
> +        * and we fail.
> +        */
> +       ret = expr__get_id(&eg->pctx, id, &data);
> +       if (ret)
> +               return ret;
> +
> +       p = data->parent;
> +
> +       while (p->parent) {
> +               if (!strcmp(p->id, id)) {
> +                       pr_err("failed: recursion detected for %s\n", id);
> +                       return -1;
> +               }
> +               p = p->parent;
> +       }
> +
> +       /*
> +        * If we are over the limit of static entris, the metric
> +        * is too difficult/nested to process, fail as well.
> +        */
> +       p = expr_ids__alloc(ids);
> +       if (!p) {
> +               pr_err("failed: too many nested metrics\n");
> +               return -EINVAL;
> +       }
> +
> +       p->id     = strdup(id);
> +       p->parent = data->parent;
> +       *parent   = p;
> +
> +       return p->id ? 0 : -ENOMEM;
> +}
> +
>  static int add_metric(struct list_head *group_list,
>                       struct pmu_event *pe,
>                       bool metric_no_group,
> -                     struct egroup **egp);
> +                     struct egroup **egp,
> +                     struct expr_id *parent,
> +                     struct expr_ids *ids);
>
>  static int resolve_metric(struct egroup *eg,
>                           bool metric_no_group,
>                           struct list_head *group_list,
> -                         struct pmu_events_map *map)
> +                         struct pmu_events_map *map,
> +                         struct expr_ids *ids)
>  {
>         struct hashmap_entry *cur;
>         size_t bkt;
> @@ -750,18 +838,23 @@ static int resolve_metric(struct egroup *eg,
>         do {
>                 all = true;
>                 hashmap__for_each_entry((&eg->pctx.ids), cur, bkt) {
> +                       struct expr_id *parent;
>                         struct pmu_event *pe;
>
>                         pe = find_metric(cur->key, map);
>                         if (!pe)
>                                 continue;
>
> +                       ret = recursion_check(eg, cur->key, &parent, ids);
> +                       if (ret)
> +                               return ret;
> +
>                         all = false;
>                         /* The metric key itself needs to go out.. */
>                         expr__del_id(&eg->pctx, cur->key);
>
>                         /* ... and it gets resolved to the parent context. */
> -                       ret = add_metric(group_list, pe, metric_no_group, &eg);
> +                       ret = add_metric(group_list, pe, metric_no_group, &eg, parent, ids);
>                         if (ret)
>                                 return ret;
>
> @@ -779,14 +872,16 @@ static int resolve_metric(struct egroup *eg,
>  static int add_metric(struct list_head *group_list,
>                       struct pmu_event *pe,
>                       bool metric_no_group,
> -                     struct egroup **egp)
> +                     struct egroup **egp,
> +                     struct expr_id *parent,
> +                     struct expr_ids *ids)
>  {
>         int ret = 0;
>
>         pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>
>         if (!strstr(pe->metric_expr, "?")) {
> -               ret = __add_metric(group_list, pe, metric_no_group, 1, egp);
> +               ret = __add_metric(group_list, pe, metric_no_group, 1, egp, parent, ids);
>         } else {
>                 int j, count;
>
> @@ -798,7 +893,7 @@ static int add_metric(struct list_head *group_list,
>                  */
>
>                 for (j = 0; j < count && !ret; j++) {
> -                       ret = __add_metric(group_list, pe, metric_no_group, j, egp);
> +                       ret = __add_metric(group_list, pe, metric_no_group, j, egp, parent, ids);
>                 }
>         }
>
> @@ -811,6 +906,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                                    struct pmu_events_map *map)
>
>  {
> +       struct expr_ids ids = { 0 };
>         struct pmu_event *pe;
>         struct egroup *eg;
>         LIST_HEAD(list);
> @@ -821,7 +917,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                 has_match = true;
>                 eg = NULL;
>
> -               ret = add_metric(&list, pe, metric_no_group, &eg);
> +               ret = add_metric(&list, pe, metric_no_group, &eg, NULL, &ids);
>                 if (ret)
>                         return ret;
>
> @@ -830,7 +926,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                  * included in the expression.
>                  */
>                 ret = resolve_metric(eg, metric_no_group,
> -                                    &list, map);
> +                                    &list, map, &ids);
>                 if (ret)
>                         return ret;
>         }
> @@ -853,6 +949,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>         }
>
>         list_splice(&list, group_list);
> +       expr_ids__exit(&ids);
>         return 0;
>  }
>
> --
> 2.25.4
>
