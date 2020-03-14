Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77273C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AADE2051A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O47sW7e2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCOCCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:02:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37083 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgCOCCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584237733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eqzcg40TBoSMhAurr5qREzKJZ7xEUxgoofqeeoS/NZ4=;
        b=O47sW7e2pDOW5WC8jlCEAbB6eOWrWYLaw1VbLyXqVwtacDjFsd5n56XzCeXIqbivDzLEiG
        TnW4aGtEWn9Tv7R+Th8CeE72m4IvrT3H9TbWsnYjxpGkIVGT1AQEdMwnXI9evaYuxyQREK
        /SOQ9pfHJkbfw/J9+jCJDLCA/9tk3QU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-a7j_hPgqOiu76FN7ROwQpw-1; Sat, 14 Mar 2020 09:59:34 -0400
X-MC-Unique: a7j_hPgqOiu76FN7ROwQpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C60EC18CA241;
        Sat, 14 Mar 2020 13:59:31 +0000 (UTC)
Received: from krava (ovpn-204-34.brq.redhat.com [10.40.204.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6DBA73861;
        Sat, 14 Mar 2020 13:59:27 +0000 (UTC)
Date:   Sat, 14 Mar 2020 14:59:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf parse-events: fix 3 use after frees
Message-ID: <20200314135925.GA492969@krava>
References: <20200313230249.78825-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313230249.78825-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 04:02:49PM -0700, Ian Rogers wrote:
> Reproducible with a clang asan build and then running perf test in
> particular 'Parse event definition strings'.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index a14995835d85..593b6b03785d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1449,7 +1449,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		evsel = __add_event(list, &parse_state->idx, &attr, NULL, pmu, NULL,
>  				    auto_merge_stats, NULL);
>  		if (evsel) {
> -			evsel->pmu_name = name;
> +			evsel->pmu_name = name ? strdup(name) : NULL;
>  			evsel->use_uncore_alias = use_uncore_alias;
>  			return 0;
>  		} else {
> @@ -1497,7 +1497,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		evsel->snapshot = info.snapshot;
>  		evsel->metric_expr = info.metric_expr;
>  		evsel->metric_name = info.metric_name;
> -		evsel->pmu_name = name;
> +		evsel->pmu_name = name ? strdup(name) : NULL;

so it's pmu->name pointer.. does pmu get destroyed before the evsel?
also should we free that then like below?

>  		evsel->use_uncore_alias = use_uncore_alias;
>  		evsel->percore = config_term_percore(&evsel->config_terms);
>  	}
> @@ -1547,7 +1547,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  				if (!parse_events_add_pmu(parse_state, list,
>  							  pmu->name, head,
>  							  true, true)) {
> -					pr_debug("%s -> %s/%s/\n", config,
> +					pr_debug("%s -> %s/%s/\n", str,

nice catch ;-)

>  						 pmu->name, alias->str);
>  					ok++;
>  				}
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

thanks,
jirka


---
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 816d930d774e..15ccd193483f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1287,6 +1287,7 @@ void perf_evsel__exit(struct evsel *evsel)
 	perf_thread_map__put(evsel->core.threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
+	zfree(&evsel->pmu_name);
 	perf_evsel__object.fini(evsel);
 }
 

