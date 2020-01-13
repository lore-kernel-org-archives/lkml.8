Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9A4C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52DA2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0GhKBL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgAMRE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:04:28 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45079 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgAMRE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:04:27 -0500
Received: by mail-qv1-f68.google.com with SMTP id l14so4305919qvu.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 09:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCYLCPHiRWh6ksrtGlcqhC567jMXoyBRG7FIiY46P9k=;
        b=s0GhKBL/eF9yyr9CWYHpUMvzHi9fizQhOAARow+yAPqgt8vBE9aOUzsqbT4FQrZuLu
         imSq2jgq9heHVhbQUxdAaaq8d/P1WdtU2dDO6NTrckuskK3im1fO6VVukIeCmsqBLWbZ
         t6wuYJGMz3bCNezQKeHS0GBRGz7qg7NVHOiVQmiDVIJF9TVCugOxiFeJ9AFlBRRnZw7a
         ZQlnS28kS+dA1tlYVKb143Z/vvnhdJex/UFD14xhHzocUcpukUxtebi9L5HQ+vtW5M3D
         kbxDYbCpFVeo83NLv2dei7UcxCs8n/yZxkFeWetWcS2TijAkSN/kToe0TeQ9CgYL1s1g
         CWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCYLCPHiRWh6ksrtGlcqhC567jMXoyBRG7FIiY46P9k=;
        b=RaU2ngqNo8/LyWjikXFND/NgonL4H5/dj8crNmgdtFYH8laTn33fOH2cFYU8QnXXA5
         8CYvaHrfqoK2oNjJztguseZSXqVd4QGfFxEW2Rp2bAIWBWNESrVEkDrcWiFBLELMunDD
         XrgxxnRJqqrLN5BQL9ZRrhRiwkUp3WukbLIjYuZUXC0uiae+BDw9azX4OWH2LQZorAWA
         nQc/yiBXdW9JSGj/uHqKwRkbfnDQUVF6f32LS4gsfa/SeLysJ2JWVJaN2+mxIJh6mlu1
         1/PPW0PePh13ACbLomCPKhwv7ycgqnvCRaAVW+t3EiIKEmWnaqACCCwqE87k9TGeu68A
         KIbQ==
X-Gm-Message-State: APjAAAVooscQsAI8DEJ81u6yh/T90MNnAc2rCpRcYk6ZRrq2p23Uc6K/
        rOMTYTWA74ZbD+iiEVb8zU0HAMUtszJMowdLTKsElw==
X-Google-Smtp-Source: APXvYqzi3bJ55+6+/FQx1vGFWyWqpTGwv7haxRMSuHolvSCUQFeuWclB/btZmbsEpjgQYMU5siJ20bJXIZOYamOr9M8=
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr12569770qvb.43.1578935065414;
 Mon, 13 Jan 2020 09:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20200113151806.17854-1-leo.yan@linaro.org>
In-Reply-To: <20200113151806.17854-1-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 13 Jan 2020 10:04:14 -0700
Message-ID: <CANLsYkyZ388z6BMf_oioPW-Th0WXDufxeSBGPxqZqD-_eFNspw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] perf parse: Refactor struct perf_evsel_config_term
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 at 08:18, Leo Yan <leo.yan@linaro.org> wrote:
>
> The struct perf_evsel_config_term::val is a union which contains
> fields 'callgraph', 'drv_cfg' and 'branch' as string pointers.  This
> leads to the complex code logic for handling every type's string
> separately, and it's hard to release string as a general way.
>
> This patch refactors the structure to add a common field 'str' in the
> 'val' union as string pointer and remove the other three fields
> 'callgraph', 'drv_cfg' and 'branch'.  Without passing field name, the
> patch simplifies the string handling with macro ADD_CONFIG_TERM_STR()
> for string pointer assignment.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/arm/util/cs-etm.c |  2 +-
>  tools/perf/util/evsel.c           |  6 ++--
>  tools/perf/util/evsel_config.h    |  4 +--
>  tools/perf/util/parse-events.c    | 53 ++++++++++++++++++-------------
>  4 files changed, 36 insertions(+), 29 deletions(-)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index ede040cf82ad..2898cfdf8fe1 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -226,7 +226,7 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
>                 if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
>                         continue;
>
> -               sink = term->val.drv_cfg;
> +               sink = term->val.str;
>                 snprintf(path, PATH_MAX, "sinks/%s", sink);
>
>                 ret = perf_pmu__scan_file(pmu, path, "%x", &hash);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a69e64236120..549abd43816f 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -808,12 +808,12 @@ static void apply_config_terms(struct evsel *evsel,
>                                 perf_evsel__reset_sample_bit(evsel, TIME);
>                         break;
>                 case PERF_EVSEL__CONFIG_TERM_CALLGRAPH:
> -                       callgraph_buf = term->val.callgraph;
> +                       callgraph_buf = term->val.str;
>                         break;
>                 case PERF_EVSEL__CONFIG_TERM_BRANCH:
> -                       if (term->val.branch && strcmp(term->val.branch, "no")) {
> +                       if (term->val.str && strcmp(term->val.str, "no")) {
>                                 perf_evsel__set_sample_bit(evsel, BRANCH_STACK);
> -                               parse_branch_str(term->val.branch,
> +                               parse_branch_str(term->val.str,
>                                                  &attr->branch_sample_type);
>                         } else
>                                 perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> index 1f8d2fe0b66e..b4a65201e4f7 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -36,18 +36,16 @@ struct perf_evsel_config_term {
>                 u64           period;
>                 u64           freq;
>                 bool          time;
> -               char          *callgraph;
> -               char          *drv_cfg;
>                 u64           stack_user;
>                 int           max_stack;
>                 bool          inherit;
>                 bool          overwrite;
> -               char          *branch;
>                 unsigned long max_events;
>                 bool          percore;
>                 bool          aux_output;
>                 u32           aux_sample_size;
>                 u64           cfg_chg;
> +               char          *str;
>         } val;
>         bool weak;
>  };
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index ed7c008b9c8b..64b394519a4c 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1219,8 +1219,7 @@ static int config_attr(struct perf_event_attr *attr,
>  static int get_config_terms(struct list_head *head_config,
>                             struct list_head *head_terms __maybe_unused)
>  {
> -#define ADD_CONFIG_TERM(__type, __name, __val)                 \
> -do {                                                           \
> +#define ADD_CONFIG_TERM(__type)                                        \
>         struct perf_evsel_config_term *__t;                     \
>                                                                 \
>         __t = zalloc(sizeof(*__t));                             \
> @@ -1229,9 +1228,19 @@ do {                                                             \
>                                                                 \
>         INIT_LIST_HEAD(&__t->list);                             \
>         __t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;   \
> -       __t->val.__name = __val;                                \
>         __t->weak       = term->weak;                           \
> -       list_add_tail(&__t->list, head_terms);                  \
> +       list_add_tail(&__t->list, head_terms)
> +
> +#define ADD_CONFIG_TERM_VAL(__type, __name, __val)             \
> +do {                                                           \
> +       ADD_CONFIG_TERM(__type);                                \
> +       __t->val.__name = __val;                                \
> +} while (0)
> +
> +#define ADD_CONFIG_TERM_STR(__type, __val)                     \
> +do {                                                           \
> +       ADD_CONFIG_TERM(__type);                                \
> +       __t->val.str = __val;                                   \
>  } while (0)
>
>         struct parse_events_term *term;
> @@ -1239,53 +1248,53 @@ do {                                                            \
>         list_for_each_entry(term, head_config, list) {
>                 switch (term->type_term) {
>                 case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> -                       ADD_CONFIG_TERM(PERIOD, period, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> -                       ADD_CONFIG_TERM(FREQ, freq, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_TIME:
> -                       ADD_CONFIG_TERM(TIME, time, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(TIME, time, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
> -                       ADD_CONFIG_TERM(CALLGRAPH, callgraph, term->val.str);
> +                       ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
> -                       ADD_CONFIG_TERM(BRANCH, branch, term->val.str);
> +                       ADD_CONFIG_TERM_STR(BRANCH, term->val.str);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
> -                       ADD_CONFIG_TERM(STACK_USER, stack_user, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(STACK_USER, stack_user, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_INHERIT:
> -                       ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 1 : 0);
> +                       ADD_CONFIG_TERM_VAL(INHERIT, inherit, term->val.num ? 1 : 0);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
> -                       ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 0 : 1);
> +                       ADD_CONFIG_TERM_VAL(INHERIT, inherit, term->val.num ? 0 : 1);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
> -                       ADD_CONFIG_TERM(MAX_STACK, max_stack, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
> -                       ADD_CONFIG_TERM(MAX_EVENTS, max_events, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events, term->val.num);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
> -                       ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 1 : 0);
> +                       ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite, term->val.num ? 1 : 0);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
> -                       ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 0 : 1);
> +                       ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite, term->val.num ? 0 : 1);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> -                       ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
> +                       ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_PERCORE:
> -                       ADD_CONFIG_TERM(PERCORE, percore,
> -                                       term->val.num ? true : false);
> +                       ADD_CONFIG_TERM_VAL(PERCORE, percore,
> +                                           term->val.num ? true : false);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
> -                       ADD_CONFIG_TERM(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
> +                       ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
> -                       ADD_CONFIG_TERM(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
> +                       ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
>                         break;
>                 default:
>                         break;
> @@ -1322,7 +1331,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
>         }
>
>         if (bits)
> -               ADD_CONFIG_TERM(CFG_CHG, cfg_chg, bits);
> +               ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits);
>
>  #undef ADD_CONFIG_TERM
>         return 0;

There are checkpatch warnings - please address them.

Mathieu

> --
> 2.17.1
>
