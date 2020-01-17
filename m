Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EA8C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1297206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9fygf23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAQNgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:36:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30692 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726587AbgAQNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579268175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BXIQYnzHX8n6+tW01eTbYB3ooJ5AGH7OZQJ9hqGsZMU=;
        b=X9fygf23Ly6nug4PVHMmDNUst4GOj6gZ5ej/yGIv7SaQ4u2Hn3bW31mg/pdcqu9M5583yb
        yKg33lMQb7bwxyrRN4jvbw0hyLsXmbheRPPmXGT5ItdcoWoDcNug9+UpF7CEx4KEcR57u6
        1xP7TFDptebQ6Ju7MDSEg6hDwxg2zrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-NLi7InnQNdWBQM_RQla3YQ-1; Fri, 17 Jan 2020 08:36:12 -0500
X-MC-Unique: NLi7InnQNdWBQM_RQla3YQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 110B61800D48;
        Fri, 17 Jan 2020 13:36:10 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D416619C4F;
        Fri, 17 Jan 2020 13:36:07 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 644B711E4; Fri, 17 Jan 2020 10:36:04 -0300 (BRT)
Date:   Fri, 17 Jan 2020 10:36:04 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v6 1/2] perf parse: Refactor struct perf_evsel_config_term
Message-ID: <20200117133604.GC3323@redhat.com>
References: <20200117055251.24058-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117055251.24058-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 17, 2020 at 01:52:50PM +0800, Leo Yan escreveu:
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
> This patch fixes multiple warnings of line over 80 characters detected
> by checkpatch tool.

Thanks, applied both.
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/arch/arm/util/cs-etm.c |  2 +-
>  tools/perf/util/evsel.c           |  6 +--
>  tools/perf/util/evsel_config.h    |  4 +-
>  tools/perf/util/parse-events.c    | 62 ++++++++++++++++++++-----------
>  4 files changed, 45 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index ede040cf82ad..2898cfdf8fe1 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -226,7 +226,7 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
>  		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
>  			continue;
>  
> -		sink = term->val.drv_cfg;
> +		sink = term->val.str;
>  		snprintf(path, PATH_MAX, "sinks/%s", sink);
>  
>  		ret = perf_pmu__scan_file(pmu, path, "%x", &hash);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a69e64236120..549abd43816f 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -808,12 +808,12 @@ static void apply_config_terms(struct evsel *evsel,
>  				perf_evsel__reset_sample_bit(evsel, TIME);
>  			break;
>  		case PERF_EVSEL__CONFIG_TERM_CALLGRAPH:
> -			callgraph_buf = term->val.callgraph;
> +			callgraph_buf = term->val.str;
>  			break;
>  		case PERF_EVSEL__CONFIG_TERM_BRANCH:
> -			if (term->val.branch && strcmp(term->val.branch, "no")) {
> +			if (term->val.str && strcmp(term->val.str, "no")) {
>  				perf_evsel__set_sample_bit(evsel, BRANCH_STACK);
> -				parse_branch_str(term->val.branch,
> +				parse_branch_str(term->val.str,
>  						 &attr->branch_sample_type);
>  			} else
>  				perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> index 1f8d2fe0b66e..b4a65201e4f7 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -36,18 +36,16 @@ struct perf_evsel_config_term {
>  		u64	      period;
>  		u64	      freq;
>  		bool	      time;
> -		char	      *callgraph;
> -		char	      *drv_cfg;
>  		u64	      stack_user;
>  		int	      max_stack;
>  		bool	      inherit;
>  		bool	      overwrite;
> -		char	      *branch;
>  		unsigned long max_events;
>  		bool	      percore;
>  		bool	      aux_output;
>  		u32	      aux_sample_size;
>  		u64	      cfg_chg;
> +		char	      *str;
>  	} val;
>  	bool weak;
>  };
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index ed7c008b9c8b..f59f3c8da473 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1219,8 +1219,7 @@ static int config_attr(struct perf_event_attr *attr,
>  static int get_config_terms(struct list_head *head_config,
>  			    struct list_head *head_terms __maybe_unused)
>  {
> -#define ADD_CONFIG_TERM(__type, __name, __val)			\
> -do {								\
> +#define ADD_CONFIG_TERM(__type)					\
>  	struct perf_evsel_config_term *__t;			\
>  								\
>  	__t = zalloc(sizeof(*__t));				\
> @@ -1229,9 +1228,19 @@ do {								\
>  								\
>  	INIT_LIST_HEAD(&__t->list);				\
>  	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
> -	__t->val.__name = __val;				\
>  	__t->weak	= term->weak;				\
> -	list_add_tail(&__t->list, head_terms);			\
> +	list_add_tail(&__t->list, head_terms)
> +
> +#define ADD_CONFIG_TERM_VAL(__type, __name, __val)		\
> +do {								\
> +	ADD_CONFIG_TERM(__type);				\
> +	__t->val.__name = __val;				\
> +} while (0)
> +
> +#define ADD_CONFIG_TERM_STR(__type, __val)			\
> +do {								\
> +	ADD_CONFIG_TERM(__type);				\
> +	__t->val.str = __val;					\
>  } while (0)
>  
>  	struct parse_events_term *term;
> @@ -1239,53 +1248,62 @@ do {								\
>  	list_for_each_entry(term, head_config, list) {
>  		switch (term->type_term) {
>  		case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
> -			ADD_CONFIG_TERM(PERIOD, period, term->val.num);
> +			ADD_CONFIG_TERM_VAL(PERIOD, period, term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ:
> -			ADD_CONFIG_TERM(FREQ, freq, term->val.num);
> +			ADD_CONFIG_TERM_VAL(FREQ, freq, term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_TIME:
> -			ADD_CONFIG_TERM(TIME, time, term->val.num);
> +			ADD_CONFIG_TERM_VAL(TIME, time, term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_CALLGRAPH:
> -			ADD_CONFIG_TERM(CALLGRAPH, callgraph, term->val.str);
> +			ADD_CONFIG_TERM_STR(CALLGRAPH, term->val.str);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE:
> -			ADD_CONFIG_TERM(BRANCH, branch, term->val.str);
> +			ADD_CONFIG_TERM_STR(BRANCH, term->val.str);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_STACKSIZE:
> -			ADD_CONFIG_TERM(STACK_USER, stack_user, term->val.num);
> +			ADD_CONFIG_TERM_VAL(STACK_USER, stack_user,
> +					    term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_INHERIT:
> -			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 1 : 0);
> +			ADD_CONFIG_TERM_VAL(INHERIT, inherit,
> +					    term->val.num ? 1 : 0);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_NOINHERIT:
> -			ADD_CONFIG_TERM(INHERIT, inherit, term->val.num ? 0 : 1);
> +			ADD_CONFIG_TERM_VAL(INHERIT, inherit,
> +					    term->val.num ? 0 : 1);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_MAX_STACK:
> -			ADD_CONFIG_TERM(MAX_STACK, max_stack, term->val.num);
> +			ADD_CONFIG_TERM_VAL(MAX_STACK, max_stack,
> +					    term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_MAX_EVENTS:
> -			ADD_CONFIG_TERM(MAX_EVENTS, max_events, term->val.num);
> +			ADD_CONFIG_TERM_VAL(MAX_EVENTS, max_events,
> +					    term->val.num);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
> -			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 1 : 0);
> +			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
> +					    term->val.num ? 1 : 0);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
> -			ADD_CONFIG_TERM(OVERWRITE, overwrite, term->val.num ? 0 : 1);
> +			ADD_CONFIG_TERM_VAL(OVERWRITE, overwrite,
> +					    term->val.num ? 0 : 1);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> -			ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
> +			ADD_CONFIG_TERM_STR(DRV_CFG, term->val.str);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_PERCORE:
> -			ADD_CONFIG_TERM(PERCORE, percore,
> -					term->val.num ? true : false);
> +			ADD_CONFIG_TERM_VAL(PERCORE, percore,
> +					    term->val.num ? true : false);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
> -			ADD_CONFIG_TERM(AUX_OUTPUT, aux_output, term->val.num ? 1 : 0);
> +			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
> +					    term->val.num ? 1 : 0);
>  			break;
>  		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
> -			ADD_CONFIG_TERM(AUX_SAMPLE_SIZE, aux_sample_size, term->val.num);
> +			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
> +					    term->val.num);
>  			break;
>  		default:
>  			break;
> @@ -1322,7 +1340,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
>  	}
>  
>  	if (bits)
> -		ADD_CONFIG_TERM(CFG_CHG, cfg_chg, bits);
> +		ADD_CONFIG_TERM_VAL(CFG_CHG, cfg_chg, bits);
>  
>  #undef ADD_CONFIG_TERM
>  	return 0;
> -- 
> 2.17.1

