Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9652C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBFB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClpaWwes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgAQNeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:34:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20117 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbgAQNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579268059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LzXXWC16J/bkAvB2AvgILmvmigCWBLJYsCNp/VkJW+4=;
        b=ClpaWwesuTSp69HWFKj0t6vi4bRY5WXhNMxYDRcF49Hh0jdPfAdYqdWzxmb9a7ngTSw21O
        Qo8MDZZzpi5/kB4PsUPNyK0/2dixc986dCsXkhYHy7fZzijVnfTdpljVuAKeQDzwtfUiLz
        ruJC6wT9bT+Kv33YlwHjtIYiZtsMzSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-bOCTjrhlNKW8N1yvIRASHA-1; Fri, 17 Jan 2020 08:34:15 -0500
X-MC-Unique: bOCTjrhlNKW8N1yvIRASHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7935107ACCC;
        Fri, 17 Jan 2020 13:34:13 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AF335C545;
        Fri, 17 Jan 2020 13:34:12 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 3ABB611E4; Fri, 17 Jan 2020 10:34:09 -0300 (BRT)
Date:   Fri, 17 Jan 2020 10:34:09 -0300
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
Subject: Re: [PATCH v6 2/2] perf parse: Copy string to perf_evsel_config_term
Message-ID: <20200117133409.GB3323@redhat.com>
References: <20200117055251.24058-1-leo.yan@linaro.org>
 <20200117055251.24058-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117055251.24058-2-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 17, 2020 at 01:52:51PM +0800, Leo Yan escreveu:
> perf with CoreSight fails to record trace data with command:
> 
>   perf record -e cs_etm/@tmc_etr0/u --per-thread ls
>   failed to set sink "" on event cs_etm/@tmc_etr0/u with 21 (Is a
>   directory)/perf/
> 
> This failure is root caused with the commit 1dc925568f01 ("perf
> parse: Add a deep delete for parse event terms").
> 
> The log shows, cs_etm fails to parse the sink attribution; cs_etm event
> relies on the event configuration to pass sink name, but the event
> specific configuration data cannot be passed properly with flow:
> 
>   get_config_terms()
>     ADD_CONFIG_TERM(DRV_CFG, term->val.str);
>       __t->val.str = term->val.str;
>         `> __t->val.str is assigned to term->val.str;
> 
>   parse_events_terms__purge()
>     parse_events_term__delete()
>       zfree(&term->val.str);
>         `> term->val.str is freed and assigned to NULL pointer;
> 
>   cs_etm_set_sink_attr()
>     sink = __t->val.str;
>       `> sink string has been freed.
> 
> To fix this issue, in the function get_config_terms(), this patch
> changes to use strdup() for allocation a new duplicate string rather
> than directly assignment string pointer.
> 
> This patch addes a new field 'free_str' in the data structure
> perf_evsel_config_term; 'free_str' is set to true when the union is used
> as a string pointer; thus it can tell perf_evsel__free_config_terms() to
> free the string.
> 
> Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/evsel.c        | 2 ++
>  tools/perf/util/evsel_config.h | 1 +
>  tools/perf/util/parse-events.c | 7 ++++++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 549abd43816f..6fe9e28180e5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1265,6 +1265,8 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
>  
>  	list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
>  		list_del_init(&term->list);
> +		if (term->free_str)
> +			free(term->val.str);

I'm replacing this with zfree, so that we can catch possible bugs where
term gets used after freed, just like you do below, in ADD_CONFIG_TERM_STR()

Thanks,

>  		free(term);
>  	}
>  }
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
> index b4a65201e4f7..e026ab67b008 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -32,6 +32,7 @@ enum evsel_term_type {
>  struct perf_evsel_config_term {
>  	struct list_head      list;
>  	enum evsel_term_type  type;
> +	bool		      free_str;
>  	union {
>  		u64	      period;
>  		u64	      freq;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index f59f3c8da473..c01ba6f8fdad 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1240,7 +1240,12 @@ do {								\
>  #define ADD_CONFIG_TERM_STR(__type, __val)			\
>  do {								\
>  	ADD_CONFIG_TERM(__type);				\
> -	__t->val.str = __val;					\
> +	__t->val.str = strdup(__val);				\
> +	if (!__t->val.str) {					\
> +		zfree(&__t);					\
> +		return -ENOMEM;					\
> +	}							\
> +	__t->free_str = true;					\
>  } while (0)
>  
>  	struct parse_events_term *term;
> -- 
> 2.17.1

