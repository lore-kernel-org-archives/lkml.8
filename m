Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE2FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14D62076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdtK86j5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgFAHWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAHWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:22:44 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9CFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 00:22:43 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id p123so4716364yba.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 00:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/XvLHb8CHrJeV+FPAoynu3y1sILbtELE3G5INRsehY=;
        b=LdtK86j5E4y6Dexk17tQq2m+DrfykpMRw/LhyEJbEjjU9xidNFdtk4Y6mwLhflm5Rq
         fV+lDnDzH36qYIjkdqsJNOGsNxLQWUvNEATjxQ1RYOcDcmNTbyQef992jRsj/SPAMby1
         Yg3EWpy5LMY2sGSWt2qLlaTvOT2FrK26mLn11Up5c3YX/6jWWGf65EcY2FONO+DrEviP
         lTX2mqaFIWX62hphlGgjp8Ah1zVrlpCL29fjGKhyzfjSD7w3cMcDvSW8aeL2uy9CCcKd
         ht0/aWKW3YtLvoOEEV+w91sb3zqHb3wVoNUbJY//QUrC1X7qrHR1weWJ4tugTnB5ktfv
         RdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/XvLHb8CHrJeV+FPAoynu3y1sILbtELE3G5INRsehY=;
        b=pQqm9Cir8XYZ3Q7b0eeQtS1SVDTuv8puKbZdndkMLFtzY2Ui7WxBI5Km27hxfRTsUw
         QfamEU9ipZM+9Q4RNEeXJXgEYD890P8xXKwZdhUIoOPCc7HuvP7KHLM3dJ+iDR3jqUSs
         mQmIrrTot2BDnYNVGDVSrJo/Hr8/COG++0gnqrvLiSfVYFc+ZNxRsMjs0yW8cBDebdbN
         H349F39qS1cvVZV09OQOotftCDdJ1ZTn7w0V9RLOBPlCDoMlE6FhS9oWIR6sKnNsZBL9
         2xzdFLP88VZC1TOlcplaSkGj5Exy7N0BgpF7AETbWisF8xTs1nbUhsjldH7z8j3WpQjW
         qFMA==
X-Gm-Message-State: AOAM531nrNu6bITx8Ldag0vCl69P5Es2qK5m1p0SB73lMgE9Nkzpf7zL
        0as9lZbxjSq4UIwYgRopLMCRX2d3usVB9lYEnVOkWA==
X-Google-Smtp-Source: ABdhPJz+PNJIPlFcdLcs66b83B5qm6YeAT/PhXW8gEasbY1NmeqpHXvtYB4kEZCl5F3E6cJRk3GwZ0Q8q3RUvdtNc/M=
X-Received: by 2002:a25:c08b:: with SMTP id c133mr32167741ybf.286.1590996162326;
 Mon, 01 Jun 2020 00:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200524224219.234847-1-jolsa@kernel.org> <20200524224219.234847-5-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-5-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 1 Jun 2020 00:22:30 -0700
Message-ID: <CAP-5=fV0Q3Y0wmZd6jeO3VFw-OJMp81zPoEts0S_Ai82VzWEOw@mail.gmail.com>
Subject: Re: [PATCH 04/14] perf tools: Add fake pmu support
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 3:42 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding the way to create pmu event without the actual
> PMU being in place. This way we can test metrics defined
> for any processors.
>
> The interface is to define fake_pmu in struct parse_events_state
> data. It will be used only in tests via special interface
> function added in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/parse-events.c | 14 ++++++++++---
>  tools/perf/util/parse-events.h |  3 ++-
>  tools/perf/util/parse-events.l |  8 ++++++--
>  tools/perf/util/parse-events.y | 37 ++++++++++++++++++++++++++++++++--
>  4 files changed, 54 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 27b8e49d690e..8304f9b6e6be 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1415,6 +1415,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>                          bool auto_merge_stats,
>                          bool use_alias)
>  {
> +       bool is_fake = parse_state->fake_pmu;
>         struct perf_event_attr attr;
>         struct perf_pmu_info info;
>         struct perf_pmu *pmu;
> @@ -1436,7 +1437,14 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>                 fprintf(stderr, "' that may result in non-fatal errors\n");
>         }
>
> -       pmu = perf_pmu__find(name);
> +       if (is_fake) {
> +               static struct perf_pmu fake_pmu = { };
> +
> +               pmu = &fake_pmu;
> +       } else {
> +               pmu = perf_pmu__find(name);
> +       }
> +
>         if (!pmu) {
>                 char *err_str;
>
> @@ -1469,7 +1477,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>                 }
>         }
>
> -       if (perf_pmu__check_alias(pmu, head_config, &info))
> +       if (!is_fake && perf_pmu__check_alias(pmu, head_config, &info))
>                 return -EINVAL;
>
>         if (verbose > 1) {
> @@ -1502,7 +1510,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>         if (pmu->default_config && get_config_chgs(pmu, head_config, &config_terms))
>                 return -ENOMEM;
>
> -       if (perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
> +       if (!is_fake && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
>                 struct evsel_config_term *pos, *tmp;
>
>                 list_for_each_entry_safe(pos, tmp, &config_terms, list) {
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index d60510e0609f..963b0ea6c448 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -126,9 +126,10 @@ struct parse_events_state {
>         int                        idx;
>         int                        nr_groups;
>         struct parse_events_error *error;
> -       struct evlist     *evlist;
> +       struct evlist             *evlist;
>         struct list_head          *terms;
>         int                        stoken;
> +       bool                       fake_pmu;
>  };
>
>  void parse_events__handle_error(struct parse_events_error *err, int idx,
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 002802e17059..56912c9641f5 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -129,12 +129,16 @@ do {                                                              \
>         yyless(0);                                              \
>  } while (0)
>
> -static int pmu_str_check(yyscan_t scanner)
> +static int pmu_str_check(yyscan_t scanner, struct parse_events_state *parse_state)
>  {
>         YYSTYPE *yylval = parse_events_get_lval(scanner);
>         char *text = parse_events_get_text(scanner);
>
>         yylval->str = strdup(text);
> +
> +       if (parse_state->fake_pmu)
> +               return PE_PMU_EVENT_FAKE;
> +
>         switch (perf_pmu__parse_check(text)) {
>                 case PMU_EVENT_SYMBOL_PREFIX:
>                         return PE_PMU_EVENT_PRE;
> @@ -376,7 +380,7 @@ r{num_raw_hex}              { return raw(yyscanner); }
>  {modifier_event}       { return str(yyscanner, PE_MODIFIER_EVENT); }
>  {bpf_object}           { if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_OBJECT); }
>  {bpf_source}           { if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_SOURCE); }
> -{name}                 { return pmu_str_check(yyscanner); }
> +{name}                 { return pmu_str_check(yyscanner, _parse_state); }
>  {name_tag}             { return str(yyscanner, PE_NAME); }
>  "/"                    { BEGIN(config); return '/'; }
>  -                      { return '-'; }
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index c4ca932d092d..d1b04b8d81ea 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -69,7 +69,7 @@ static void inc_group_count(struct list_head *list,
>  %token PE_NAME_CACHE_TYPE PE_NAME_CACHE_OP_RESULT
>  %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
>  %token PE_ERROR
> -%token PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT
> +%token PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
>  %token PE_ARRAY_ALL PE_ARRAY_RANGE
>  %token PE_DRV_CFG_TERM
>  %type <num> PE_VALUE
> @@ -87,7 +87,7 @@ static void inc_group_count(struct list_head *list,
>  %type <str> PE_MODIFIER_EVENT
>  %type <str> PE_MODIFIER_BP
>  %type <str> PE_EVENT_NAME
> -%type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT
> +%type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
>  %type <str> PE_DRV_CFG_TERM
>  %destructor { free ($$); } <str>
>  %type <term> event_term
> @@ -356,6 +356,39 @@ PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
>                 YYABORT;
>         $$ = list;
>  }
> +|
> +PE_PMU_EVENT_FAKE sep_dc
> +{
> +       struct list_head *list;
> +       int err;
> +
> +       list = alloc_list();
> +       if (!list)
> +               YYABORT;
> +
> +       err = parse_events_add_pmu(_parse_state, list, $1, NULL, false, false);
> +       free($1);
> +       if (err < 0)

nit: on error this needs:
free(list);
otherwise something like fuzz testing could go down the error path and
complain about memory leaks.

Thanks,
Ian

> +               YYABORT;
> +       $$ = list;
> +}
> +|
> +PE_PMU_EVENT_FAKE opt_pmu_config
> +{
> +       struct list_head *list;
> +       int err;
> +
> +       list = alloc_list();
> +       if (!list)
> +               YYABORT;
> +
> +       err = parse_events_add_pmu(_parse_state, list, $1, $2, false, false);
> +       free($1);
> +       parse_events_terms__delete($2);
> +       if (err < 0)
> +               YYABORT;
> +       $$ = list;
> +}
>
>  value_sym:
>  PE_VALUE_SYM_HW
> --
> 2.25.4
>
