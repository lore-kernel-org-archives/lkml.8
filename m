Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D758DC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BAC206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LchWkKdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbgEMG3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbgEMG3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:29:48 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69094C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:29:48 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id b8so8286076ybn.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DD2RIURlKyorw73cEnlD3AdAkZEbqPSVlGDx7N8n7mI=;
        b=LchWkKdrIeczHbSMY06bBZz3FnYLhsJY90HvzU81LINANTSehOkXFk5vS0iuVaeoPA
         GZZJyGxglVFglHz0M7th6xQHH3VIsNKatESfpxEKtI4TfztOFfEwBoMkL80MZ/f5QTiL
         ZZphrOgpxEnQgKBA0gVKzQ8tVXeDSQB5tMmXhH0QXQ6s2YLZSfj/pgK3e2gyu7QI4dYY
         ZiXJQlmXbOhDqqzVO3GalEdqsnswRlCSfSLCpMXWb3ffeQ5dP41fWr9epRQbg24Sf1Vw
         Unle5bYYHRqN/05ivnWjyDqGPsSvAKr89gHETpy+jtv1wcw6kQAiFoBiauyXGeT/xwcM
         XFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DD2RIURlKyorw73cEnlD3AdAkZEbqPSVlGDx7N8n7mI=;
        b=pNR2tX1c1iZPGW+cTTqJM8kvVhcbirmkT+LKamoxPHRdSYyUwvNIro6I546RZgeyib
         dStzwej6ntzJ65RnvIC5ICAxlNlsf8zeE6flA+MGJSIXQ69dIDrARBR7tUm+vsW9F1C1
         MKo40mN/kDrPSwVI6nmSkbv8eLYli0Fq280Cxf9GKRELln6t/NrJv1pkciNjDyFJaov9
         1pSxWwHnUVeQrafOFm0hmMq1SZWZqA23uGrDh2z2tc7xwggLFyFPvOm53lQ0x7mnYXhl
         1WHGPSAgs8xz7HAPM+fAw3vyMDTXKqipXbl3DfxIH7+1Xg4VCt8AYXhPPW6BHqRjTB7z
         mmfQ==
X-Gm-Message-State: AGi0PuZNvkPE0hG02TX9PdVoUDy8QlRIKG2cKc2it/+R3H9DW3ML9Yh9
        KkxlpfNk7m3fpPSvYesRqLaTb27SEsnAN14DmqZOUg==
X-Google-Smtp-Source: APiQypJLI4IBjgsuevwz2C1O4CEcQ1nKryo77G3FxewH2oBkNdx+/BlLRu+io5VNUqFRDHrkST2z9Rl/Oi9vS1N+pfE=
X-Received: by 2002:a25:4446:: with SMTP id r67mr39429320yba.41.1589351387228;
 Tue, 12 May 2020 23:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200513062236.854-1-irogers@google.com> <20200513062236.854-2-irogers@google.com>
In-Reply-To: <20200513062236.854-2-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 May 2020 23:29:35 -0700
Message-ID: <CAP-5=fX69L=OdJAXqnP+M0nmgqsvSbJkwu-_VU8CDMVngBMZig@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Improve pmu event metric testing
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:22 PM Ian Rogers <irogers@google.com> wrote:
>
> Break pmu-events test into 2 and add a test to verify that all pmu metric
> expressions simply parse. Try to parse all metric ids/events, failing if
> metrics for the current architecture fail to parse.
>
> Tested on power9, skylakex, haswell, broadwell, westmere, sandybridge and
> ivybridge with the patch set in place.
> May fail on other architectures if metrics are invalid. In particular s390
> is untested, but its expressions are trivial. The event encodings could
> be wrong. The other untested architectures with expressions are power8,
> cascadelakex, tremontx, skylake, jaketown, ivytown and variants of
> haswell and broadwell. For these the expression encoding is valid but
> the event encodings may not be.

Sorry, this commit message needed updating to reflect that event
parsing errors are no longer fatal. Fixed in v2:
https://lore.kernel.org/lkml/20200513062752.3681-1-irogers@google.com/T/#t

Thanks,
Ian

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c |   5 +
>  tools/perf/tests/pmu-events.c   | 158 ++++++++++++++++++++++++++++++--
>  tools/perf/tests/tests.h        |   2 +
>  3 files changed, 159 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 3471ec52ea11..8147c17c71ab 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -75,6 +75,11 @@ static struct test generic_tests[] = {
>         {
>                 .desc = "PMU events",
>                 .func = test__pmu_events,
> +               .subtest = {
> +                       .get_nr         = test__pmu_events_subtest_get_nr,
> +                       .get_desc       = test__pmu_events_subtest_get_desc,
> +               },
> +
>         },
>         {
>                 .desc = "DSO data read",
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index d64261da8bf7..c18b9ce8cace 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -8,6 +8,10 @@
>  #include <linux/zalloc.h>
>  #include "debug.h"
>  #include "../pmu-events/pmu-events.h"
> +#include "util/evlist.h"
> +#include "util/expr.h"
> +#include "util/parse-events.h"
> +#include <ctype.h>
>
>  struct perf_pmu_test_event {
>         struct pmu_event event;
> @@ -144,7 +148,7 @@ static struct pmu_events_map *__test_pmu_get_events_map(void)
>  }
>
>  /* Verify generated events from pmu-events.c is as expected */
> -static int __test_pmu_event_table(void)
> +static int test_pmu_event_table(void)
>  {
>         struct pmu_events_map *map = __test_pmu_get_events_map();
>         struct pmu_event *table;
> @@ -347,14 +351,11 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
>         return res;
>  }
>
> -int test__pmu_events(struct test *test __maybe_unused,
> -                    int subtest __maybe_unused)
> +
> +static int test_aliases(void)
>  {
>         struct perf_pmu *pmu = NULL;
>
> -       if (__test_pmu_event_table())
> -               return -1;
> -
>         while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>                 int count = 0;
>
> @@ -377,3 +378,148 @@ int test__pmu_events(struct test *test __maybe_unused,
>
>         return 0;
>  }
> +
> +static bool is_number(const char *str)
> +{
> +       size_t i;
> +
> +       for (i = 0; i < strlen(str); i++) {
> +               if (!isdigit(str[i]) && str[i] != '.')
> +                       return false;
> +       }
> +       return true;
> +}
> +
> +static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
> +{
> +       struct parse_events_error error;
> +       struct evlist *evlist;
> +       int ret;
> +
> +       /* Numbers are always valid. */
> +       if (is_number(id))
> +               return 0;
> +
> +       evlist = evlist__new();
> +       memset(&error, 0, sizeof(error));
> +       ret = parse_events(evlist, id, &error);
> +       if (ret && same_cpu) {
> +               fprintf(stderr,
> +                       "\nWARNING: Parse event failed metric '%s' id '%s' expr '%s'\n",
> +                       pe->metric_name, id, pe->metric_expr);
> +               fprintf(stderr, "Error string '%s' help '%s'\n",
> +                       error.str, error.help);
> +       } else if (ret) {
> +               pr_debug3("Parse event failed, but for an event that may not be supported by this CPU.\nid '%s' metric '%s' expr '%s'\n",
> +                       id, pe->metric_name, pe->metric_expr);
> +       }
> +       evlist__delete(evlist);
> +       free(error.str);
> +       free(error.help);
> +       free(error.first_str);
> +       free(error.first_help);
> +       /* TODO: too many metrics are broken to fail on this test currently. */
> +       return 0;
> +}
> +
> +static int test_parsing(void)
> +{
> +       struct pmu_events_map *cpus_map = perf_pmu__find_map(NULL);
> +       struct pmu_events_map *map;
> +       struct pmu_event *pe;
> +       int i, j, k;
> +       const char **ids;
> +       int idnum;
> +       int ret = 0;
> +       struct expr_parse_ctx ctx;
> +       double result;
> +
> +       i = 0;
> +       for (;;) {
> +               map = &pmu_events_map[i++];
> +               if (!map->table) {
> +                       map = NULL;
> +                       break;
> +               }
> +               j = 0;
> +               for (;;) {
> +                       pe = &map->table[j++];
> +                       if (!pe->name && !pe->metric_group && !pe->metric_name)
> +                               break;
> +                       if (!pe->metric_expr)
> +                               continue;
> +                       if (expr__find_other(pe->metric_expr, NULL,
> +                                               &ids, &idnum, 0) < 0) {
> +                               pr_debug("Parse other failed for map %s %s %s\n",
> +                                       map->cpuid, map->version, map->type);
> +                               pr_debug("On metric %s\n", pe->metric_name);
> +                               pr_debug("On expression %s\n", pe->metric_expr);
> +                               ret++;
> +                               continue;
> +                       }
> +                       expr__ctx_init(&ctx);
> +
> +                       /*
> +                        * Add all ids with a made up value. The value may
> +                        * trigger divide by zero when subtracted and so try to
> +                        * make them unique.
> +                        */
> +                       for (k = 0; k < idnum; k++)
> +                               expr__add_id(&ctx, ids[k], k + 1);
> +
> +                       for (k = 0; k < idnum; k++) {
> +                               if (check_parse_id(ids[k], map == cpus_map, pe))
> +                                       ret++;
> +                       }
> +
> +                       if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
> +                               pr_debug("Parse failed for map %s %s %s\n",
> +                                       map->cpuid, map->version, map->type);
> +                               pr_debug("On metric %s\n", pe->metric_name);
> +                               pr_debug("On expression %s\n", pe->metric_expr);
> +                               ret++;
> +                       }
> +                       for (k = 0; k < idnum; k++)
> +                               zfree(&ids[k]);
> +                       free(ids);
> +               }
> +       }
> +       return ret;
> +}
> +
> +static const struct {
> +       int (*func)(void);
> +       const char *desc;
> +} pmu_events_testcase_table[] = {
> +       {
> +               .func = test_pmu_event_table,
> +               .desc = "PMU event table sanity",
> +       },
> +       {
> +               .func = test_aliases,
> +               .desc = "PMU event map aliases",
> +       },
> +       {
> +               .func = test_parsing,
> +               .desc = "Parsing of PMU event table metrics",
> +       },
> +};
> +
> +const char *test__pmu_events_subtest_get_desc(int i)
> +{
> +       if (i < 0 || i >= (int)ARRAY_SIZE(pmu_events_testcase_table))
> +               return NULL;
> +       return pmu_events_testcase_table[i].desc;
> +}
> +
> +int test__pmu_events_subtest_get_nr(void)
> +{
> +       return (int)ARRAY_SIZE(pmu_events_testcase_table);
> +}
> +
> +int test__pmu_events(struct test *test __maybe_unused, int i)
> +{
> +       if (i < 0 || i >= (int)ARRAY_SIZE(pmu_events_testcase_table))
> +               return TEST_FAIL;
> +       return pmu_events_testcase_table[i].func();
> +}
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index d6d4ac34eeb7..8e316c30ed3c 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -50,6 +50,8 @@ int test__perf_evsel__tp_sched_test(struct test *test, int subtest);
>  int test__syscall_openat_tp_fields(struct test *test, int subtest);
>  int test__pmu(struct test *test, int subtest);
>  int test__pmu_events(struct test *test, int subtest);
> +const char *test__pmu_events_subtest_get_desc(int subtest);
> +int test__pmu_events_subtest_get_nr(void);
>  int test__attr(struct test *test, int subtest);
>  int test__dso_data(struct test *test, int subtest);
>  int test__dso_data_cache(struct test *test, int subtest);
> --
> 2.26.2.645.ge9eca65c58-goog
>
