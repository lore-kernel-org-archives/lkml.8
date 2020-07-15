Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AC9C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833192065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmjPpZ9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGORk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGORky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:40:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8686EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:40:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so3935002wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5dAbehsONAnf555F6gUEG/pckD1sIKjgptiB9KxRXw=;
        b=qmjPpZ9tA0RveGWwAZzwymhGlqja9OPvpWMHTpwSp6BxnLkJ4tEBBJ8cD3i8KVrZBy
         6cylbdwmw/A+/tKPLeKhV7hdpmNx2RxUmVtdy/lEm5Ga533p/qS/B7P76S0RCOUoharX
         EQzlNhowv0IREjvsmqGO7wL9d6zIZSWp6SpWqwIWqH0vrJwIkvPqV7sp5cNBZJekk5K1
         L7zruLM5Lk65GY15c6CDNn3tfzh2TliWxxpCjwyCGagdjuYnDKNC1SDLhyWdjwJHWmQ0
         VMFFH+2Z6M1LPJEx9g14OdCxsuABJmnvKqjthHguPyB6edFAUXCtvvyv6JFTSuzScGiG
         5Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5dAbehsONAnf555F6gUEG/pckD1sIKjgptiB9KxRXw=;
        b=XQOQVwuFIbFCQTcpB1OrhcHAB9URfRvUvdEdCTdSv6y1p5SZYZxMY0m/NikkpQAltI
         rAxcZviqAC57h1Fl1z/mfGVnlX7mdFshdBiG519TjJDAnrfp3tkD6Xg0Kt5xCLSjOb76
         hVB5VERfXfMYVm30szxxW3w3XIFcnhHTbx9v2DNrODa0x+LUGO910NFzUM6iTjvp5fBR
         KQVxztQYn48keGTLbrAt5Eyo7jUcMqn3PE0I2mKL/FAt6DnhpFl2a4Ip6YVjT04wCXPI
         GYb6RUq+2cdKHN38fni0GTkRY51Qb7Wr8B/hr6Df+KffVRvSHoJaLs1TpZ7DTabmrG+4
         5Png==
X-Gm-Message-State: AOAM5327Iet0WP/R9lHvCJZs4jzUAJbE2q2n+tbhsdMWgqLgP+6FaOKb
        bKvd1hH37qIQbd3SpG+r28ADWbfaFrk0WLLJ1wrfQeya/0RyWA==
X-Google-Smtp-Source: ABdhPJwfbFF2XmyJA9h3zQko5IagYXwHq06XlTvDBBB+OyeXg8CfzhooBOb8HvzTlMgxLGPKyHOuqz7940aFIPwGq1Y=
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr493594wmf.87.1594834852908;
 Wed, 15 Jul 2020 10:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-17-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-17-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jul 2020 10:40:41 -0700
Message-ID: <CAP-5=fUdUKmsGMxsyxxZCzmwRAumLmj6LgGrXWe7APPZRRC=WA@mail.gmail.com>
Subject: Re: [PATCH 16/18] perf metric: Add recursion check when processing
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

On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Keeping the stack of nested metrics via 'struct expr_id' objecs

s/objecs/objects/

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
> ---
>  tools/perf/tests/parse-metric.c |  27 ++++++++-
>  tools/perf/util/expr.c          |   2 +
>  tools/perf/util/expr.h          |   9 ++-
>  tools/perf/util/metricgroup.c   | 101 +++++++++++++++++++++++++++++---
>  4 files changed, 128 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index b50e2a3f3b73..238a805edd55 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -57,6 +57,14 @@ static struct pmu_event pme_test[] = {
>         .metric_expr    = "d_ratio(DCache_L2_All_Miss, DCache_L2_All)",
>         .metric_name    = "DCache_L2_Misses",
>  },
> +{
> +       .metric_expr    = "IPC + M2",
> +       .metric_name    = "M1",
> +},
> +{
> +       .metric_expr    = "IPC + M1",
> +       .metric_name    = "M2",
> +},
>  };

Perhaps add a test on simple recursion too:
{
  .metric_expr = "1/M1",
  .metric_name = "M1",
}

>  static struct pmu_events_map map = {
> @@ -139,8 +147,8 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
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
> @@ -264,11 +272,26 @@ static int test_dcache_l2(void)
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
> index 2784df38f8c2..d23d8897bc61 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -45,6 +45,8 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
>         if (!data_ptr)
>                 return -ENOMEM;
>
> +       data_ptr->parent = ctx->parent;
> +
>         ret = hashmap__set(&ctx->ids, id, data_ptr,
>                            (const void **)&old_key, (void **)&old_data);
>         free(old_key);
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index b6d1fba64eaa..e5fdeab928c7 100644
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
> @@ -27,6 +33,7 @@ struct expr_id_data {
>                         const char *metric_expr;
>                         bool counted;
>                 } ref;
> +               struct expr_id  *parent;
>         };
>  };
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 66f25362702d..69ec20dd737b 100644
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
> @@ -109,6 +110,8 @@ struct metric_ref_node {
>         struct list_head list;
>  };
>
> +#define RECURSION_ID_MAX 100
> +
>  struct egroup {
>         struct list_head nd;
>         struct expr_parse_ctx pctx;
> @@ -119,6 +122,11 @@ struct egroup {
>         int refs_cnt;
>         int runtime;
>         bool has_constraint;
> +
> +       struct {
> +               struct expr_id  id[RECURSION_ID_MAX];
> +               int             cnt;
> +       } recursion;
>  };

Rather than place this in the egroup why not pass a "visited" array to
add metric. This would be more in keeping with Tarjan's algorithm
(although the SCC isn't needed in this case):
https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm

Thanks,
Ian


>
>  /**
> @@ -609,7 +617,8 @@ static int __add_metric(struct list_head *group_list,
>                         struct pmu_event *pe,
>                         bool metric_no_group,
>                         int runtime,
> -                       struct egroup **egp)
> +                       struct egroup **egp,
> +                       struct expr_id *parent)
>  {
>         struct metric_ref_node *ref;
>         struct egroup *eg;
> @@ -619,7 +628,7 @@ static int __add_metric(struct list_head *group_list,
>                  * We got in here for the master group,
>                  * allocate it and put it on the list.
>                  */
> -               eg = malloc(sizeof(*eg));
> +               eg = zalloc(sizeof(*eg));
>                 if (!eg)
>                         return -ENOMEM;
>
> @@ -632,6 +641,16 @@ static int __add_metric(struct list_head *group_list,
>                 INIT_LIST_HEAD(&eg->refs);
>                 eg->refs_cnt = 0;
>                 *egp = eg;
> +
> +               /* Initialize first recursion exr id with base name. */
> +               parent = &eg->recursion.id[0];
> +               eg->recursion.cnt = 1;
> +
> +               parent->id = strdup(pe->metric_name);
> +               if (!parent->id) {
> +                       free(eg);
> +                       return -ENOMEM;
> +               }
>         } else {
>                 /*
>                  * We got here for the referenced metric, via the
> @@ -651,6 +670,10 @@ static int __add_metric(struct list_head *group_list,
>                 eg->has_constraint |= metricgroup__has_constraint(pe);
>         }
>
> +       /* Force all found IDs in metric to have us as parent ID. */
> +       WARN_ON_ONCE(!parent);
> +       eg->pctx.parent = parent;
> +
>         /*
>          * For both the master and referenced metrics, we parse
>          * all the metric's IDs and add it to the parent context.
> @@ -707,10 +730,56 @@ static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *
>         return NULL;
>  }
>
> +static int recursion_check(struct egroup *eg, const char *id, struct expr_id **parent)
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
> +       if (eg->recursion.cnt + 1 >= RECURSION_ID_MAX) {
> +               pr_err("failed: too many nested metrics\n");
> +               return -EINVAL;
> +       }
> +
> +       p = &eg->recursion.id[eg->recursion.cnt];
> +       eg->recursion.cnt++;
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
> +                     struct expr_id *parent);
>
>  static int resolve_metric(struct egroup *eg,
>                           bool metric_no_group,
> @@ -729,18 +798,23 @@ static int resolve_metric(struct egroup *eg,
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
> +                       ret = recursion_check(eg, cur->key, &parent);
> +                       if (ret)
> +                               return ret;
> +
>                         all = false;
>                         /* The metric key itself needs to go out.. */
>                         expr__del_id(&eg->pctx, cur->key);
>
>                         /* ... and it gets resolved to the parent context. */
> -                       ret = add_metric(group_list, pe, metric_no_group, &eg);
> +                       ret = add_metric(group_list, pe, metric_no_group, &eg, parent);
>                         if (ret)
>                                 return ret;
>
> @@ -758,14 +832,15 @@ static int resolve_metric(struct egroup *eg,
>  static int add_metric(struct list_head *group_list,
>                       struct pmu_event *pe,
>                       bool metric_no_group,
> -                     struct egroup **egp)
> +                     struct egroup **egp,
> +                     struct expr_id *parent)
>  {
>         int ret = 0;
>
>         pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>
>         if (!strstr(pe->metric_expr, "?")) {
> -               ret = __add_metric(group_list, pe, metric_no_group, 1, egp);
> +               ret = __add_metric(group_list, pe, metric_no_group, 1, egp, parent);
>         } else {
>                 int j, count;
>
> @@ -777,7 +852,7 @@ static int add_metric(struct list_head *group_list,
>                  */
>
>                 for (j = 0; j < count && !ret; j++) {
> -                       ret = __add_metric(group_list, pe, metric_no_group, j, egp);
> +                       ret = __add_metric(group_list, pe, metric_no_group, j, egp, parent);
>                 }
>         }
>
> @@ -798,7 +873,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>         if (!pe)
>                 return -EINVAL;
>
> -       ret = add_metric(group_list, pe, metric_no_group, &eg);
> +       ret = add_metric(group_list, pe, metric_no_group, &eg, NULL);
>         if (ret)
>                 return ret;
>
> @@ -871,11 +946,21 @@ static void egroup__free_refs(struct egroup *egroup)
>         }
>  }
>
> +static void egroup__free_recursion(struct egroup *egroup)
> +{
> +       int i;
> +
> +       for (i = 0; i < egroup->recursion.cnt; i++) {
> +               free(egroup->recursion.id[i].id);
> +       }
> +}
> +
>  static void metricgroup__free_egroups(struct list_head *group_list)
>  {
>         struct egroup *eg, *egtmp;
>
>         list_for_each_entry_safe (eg, egtmp, group_list, nd) {
> +               egroup__free_recursion(eg);
>                 egroup__free_refs(eg);
>                 expr__ctx_clear(&eg->pctx);
>                 list_del_init(&eg->nd);
> --
> 2.25.4
>
