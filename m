Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0041BC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEB6206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 16:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeCZNcMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGYQ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 12:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 12:58:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AAAC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 09:58:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so10481653wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1AEZNpaBztMl5c5aO0EUgy34z2c0VmKTZrWcBrvxC4=;
        b=JeCZNcMKVPlulgfViif2jhy42gTr5TQEkSj/aqFwNfA3asCBsR5MBx5u8Ntuec+FvC
         uCAoZ6WbrAmbVcE62w40XtqGZY8zxUqyfRa8hZiF7cIEj0psfyCWMlk1F4TUF4I8H4Dj
         x3ydwgnAWEkr67FkO325tL5urLaw0NhjfZLGp8qN2RoOQ34GGnhSxCB1TdF4sFLzSyFS
         gIRNuRn+QJDNPbED8CCkAZ01y3vngbOp5+T9zuiM7J08Lf02+xwl9xIt6OdKCcgGQC/7
         DWN8OA3ivhxRDhIHmA0FhfhhZLtBS0wk/to1B8LrE3selvrC85nVllhby39vcoJEWyeE
         EtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1AEZNpaBztMl5c5aO0EUgy34z2c0VmKTZrWcBrvxC4=;
        b=XSlgDHpPqS/ZrwkTe88oWycum61sc5B2SRdxCTj6vJdlMc83aj1kNCy5ad4xY9UwRB
         qm2EoPB8Kc/o4Dok7cvY4kCAZROWgsyNDq+/AcawYXLE8H63WZ00VUuMJwOiNKb02RTI
         FQ0g3cXQnVb6+TVUaeUNMSqd2vKnevUk9X1MQC/2c9vDf6CQ1iWwrx707RqsZI/FlD3p
         PgwL6vmH7bYteHVsCLngyOZCOfNJYhTiMP8zO/BGEfj9PGvx5cBPh4H/U1y1ozv8Bbi/
         65I7VNSR3F5A4StUE2ua8I9Bu++oSPnK3RdeRdycAmQplCfAt45LKqolGe8Qiiew/7dz
         q1pQ==
X-Gm-Message-State: AOAM530+63HxQBTs+IronNXwdI+BYO4c/PWnjWKhw/aVkr/PxkBqflRw
        8dHvAcwcG0RAvRdG92VwFbH9qxdfsu/k9ccyu2joSA==
X-Google-Smtp-Source: ABdhPJzfw5R7SJs4ZqS7aZt/3cZZ93KvMU+gDt+cdlTMOO7CMYm1WS/QIOiM5xzISf5h6gygGxquJhdS7imzSXkfbTk=
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr13904665wmh.77.1595696304309;
 Sat, 25 Jul 2020 09:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200725121959.1181869-1-jolsa@kernel.org> <20200725121959.1181869-2-jolsa@kernel.org>
In-Reply-To: <20200725121959.1181869-2-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 25 Jul 2020 09:58:13 -0700
Message-ID: <CAP-5=fUmJSZfCrP=gdYOwd2gpAgXsiSTBDwtLp=_e7a434weTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tools: Fix term parsing for raw syntax
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 5:20 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Jin Yao reported issue with possible conflict between raw
> events and term values in pmu event syntax.
>
> Currently following syntax is resolved as raw event with
> 0xead value:
>   uncore_imc_free_running/read/
>
> instead of using 'read' term from uncore_imc_free_running pmu,
> because 'read' is correct raw event syntax with 0xead value.
>
> To solve this issue we do following:
>   - check existing terms during rXXXX syntax processing
>     and make them priority in case of conflict
>   - allow pmu/r0x1234/ syntax to be able to specify conflicting
>     raw event (implemented in previous patch)
>
> Also adding automated tests for this and perf_pmu__parse_cleanup
> call to parse_events_terms, so the test gets properly cleaned up.
>
> Reported-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/parse-events.c | 37 ++++++++++++++++++++++++++++++++-
>  tools/perf/util/parse-events.c  | 23 ++++++++++++++++++++
>  tools/perf/util/parse-events.h  |  2 ++
>  tools/perf/util/parse-events.l  | 19 ++++++++++-------
>  4 files changed, 72 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 5aaddcb0058a..7f9f87a470c3 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -631,6 +631,34 @@ static int test__checkterms_simple(struct list_head *terms)
>         TEST_ASSERT_VAL("wrong val", term->val.num == 1);
>         TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "umask"));
>
> +       /*
> +        * read
> +        *
> +        * The perf_pmu__test_parse_init injects 'read' term into
> +        * perf_pmu_events_list, so 'read' is evaluated as read term
> +        * and not as raw event with 'ead' hex value.
> +        */
> +       term = list_entry(term->list.next, struct parse_events_term, list);
> +       TEST_ASSERT_VAL("wrong type term",
> +                       term->type_term == PARSE_EVENTS__TERM_TYPE_USER);
> +       TEST_ASSERT_VAL("wrong type val",
> +                       term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
> +       TEST_ASSERT_VAL("wrong val", term->val.num == 1);
> +       TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "read"));
> +
> +       /*
> +        * r0xead
> +        *
> +        * To be still able to pass 'ead' value with 'r' syntax,
> +        * we added support to parse 'r0xHEX' event.
> +        */
> +       term = list_entry(term->list.next, struct parse_events_term, list);
> +       TEST_ASSERT_VAL("wrong type term",
> +                       term->type_term == PARSE_EVENTS__TERM_TYPE_CONFIG);
> +       TEST_ASSERT_VAL("wrong type val",
> +                       term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
> +       TEST_ASSERT_VAL("wrong val", term->val.num == 0xead);
> +       TEST_ASSERT_VAL("wrong config", !term->config);
>         return 0;
>  }
>
> @@ -1781,7 +1809,7 @@ struct terms_test {
>
>  static struct terms_test test__terms[] = {
>         [0] = {
> -               .str   = "config=10,config1,config2=3,umask=1",
> +               .str   = "config=10,config1,config2=3,umask=1,read,r0xead",
>                 .check = test__checkterms_simple,
>         },
>  };
> @@ -1841,6 +1869,13 @@ static int test_term(struct terms_test *t)
>
>         INIT_LIST_HEAD(&terms);
>
> +       /*
> +        * The perf_pmu__test_parse_init prepares perf_pmu_events_list
> +        * which gets freed in parse_events_terms.
> +        */
> +       if (perf_pmu__test_parse_init())
> +               return -1;
> +
>         ret = parse_events_terms(&terms, t->str);
>         if (ret) {
>                 pr_debug("failed to parse terms '%s', err %d\n",
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index e88e4c7a2a9a..254f02a7fb0d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2019,6 +2019,27 @@ static void perf_pmu__parse_init(void)
>         perf_pmu__parse_cleanup();
>  }
>
> +int perf_pmu__test_parse_init(void)
> +{
> +       struct perf_pmu_event_symbol *list;
> +
> +       list = malloc(sizeof(*list) * 1);
> +       if (!list)
> +               return -ENOMEM;
> +
> +       list->type   = PMU_EVENT_SYMBOL;
> +       list->symbol = strdup("read");
> +
> +       if (!list->symbol) {
> +               free(list);
> +               return -ENOMEM;
> +       }
> +
> +       perf_pmu_events_list = list;
> +       perf_pmu_events_list_num = 1;
> +       return 0;
> +}

nit: It's easy to see in the test code why this is necessary, could
the function be moved there? If not perhaps add a function comment?
The test in the function name is quite load bearing.

> +
>  enum perf_pmu_event_symbol_type
>  perf_pmu__parse_check(const char *name)
>  {
> @@ -2080,6 +2101,8 @@ int parse_events_terms(struct list_head *terms, const char *str)
>         int ret;
>
>         ret = parse_events__scanner(str, &parse_state);
> +       perf_pmu__parse_cleanup();
> +
>         if (!ret) {
>                 list_splice(parse_state.terms, terms);
>                 zfree(&parse_state.terms);
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index f0010095fc8c..00cde7d2e30c 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -261,4 +261,6 @@ static inline bool is_sdt_event(char *str __maybe_unused)
>  }
>  #endif /* HAVE_LIBELF_SUPPORT */
>
> +int perf_pmu__test_parse_init(void);
> +
>  #endif /* __PERF_PARSE_EVENTS_H */
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 44c85fea5d00..3ca5fd2829ca 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -41,14 +41,6 @@ static int value(yyscan_t scanner, int base)
>         return __value(yylval, text, base, PE_VALUE);
>  }
>
> -static int raw(yyscan_t scanner)
> -{
> -       YYSTYPE *yylval = parse_events_get_lval(scanner);
> -       char *text = parse_events_get_text(scanner);
> -
> -       return __value(yylval, text + 1, 16, PE_RAW);
> -}
> -
>  static int str(yyscan_t scanner, int token)
>  {
>         YYSTYPE *yylval = parse_events_get_lval(scanner);
> @@ -72,6 +64,17 @@ static int str(yyscan_t scanner, int token)
>         return token;
>  }
>
> +static int raw(yyscan_t scanner)
> +{
> +       YYSTYPE *yylval = parse_events_get_lval(scanner);
> +       char *text = parse_events_get_text(scanner);
> +
> +       if (perf_pmu__parse_check(text) == PMU_EVENT_SYMBOL)
> +               return str(scanner, PE_NAME);
> +
> +       return __value(yylval, text + 1, 16, PE_RAW);
> +}
> +
>  static bool isbpf_suffix(char *text)
>  {
>         int len = strlen(text);
> --
> 2.25.4
>
