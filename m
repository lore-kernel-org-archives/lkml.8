Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD92F2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8sqqe76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgHZLjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728727AbgHZLed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598441669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1WOJvOPEzI3eS3LALvz5dumV7why6ZGwE7Kug1NarVU=;
        b=N8sqqe765kXIz36HmVli058H8e3yIdBQ+k5eaFM4d0yN7yvQPxwJaj9VR0z0j7QT+PsZy5
        4huA33PXhS83U3jo3bcfiakKqmm3l17AZWr317YGUF+6i4AFvNCaawKGmnGd33xVRJHEEl
        AmErHaz+9IZQa2TvIeobDzO4axd0m6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-63nDM6ZKOkqIbx4XCKklsA-1; Wed, 26 Aug 2020 07:34:25 -0400
X-MC-Unique: 63nDM6ZKOkqIbx4XCKklsA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DECC81F01D;
        Wed, 26 Aug 2020 11:34:23 +0000 (UTC)
Received: from krava (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id BDC227C874;
        Wed, 26 Aug 2020 11:34:19 +0000 (UTC)
Date:   Wed, 26 Aug 2020 13:34:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/2] perf parse-events: Avoid an uninitialized read.
Message-ID: <20200826113418.GC753783@krava>
References: <20200826042910.1902374-1-irogers@google.com>
 <20200826042910.1902374-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826042910.1902374-2-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 09:29:10PM -0700, Ian Rogers wrote:
> With a fake_pmu the pmu_info isn't populated by perf_pmu__check_alias.
> In this case, don't try to copy the uninitialized values to the evsel.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/parse-events.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 9f7260e69113..3d7a48b488ed 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1533,19 +1533,23 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	evsel = __add_event(list, &parse_state->idx, &attr, true,
>  			    get_config_name(head_config), pmu,
>  			    &config_terms, auto_merge_stats, NULL);
> -	if (evsel) {
> -		evsel->unit = info.unit;
> -		evsel->scale = info.scale;
> -		evsel->per_pkg = info.per_pkg;
> -		evsel->snapshot = info.snapshot;
> -		evsel->metric_expr = info.metric_expr;
> -		evsel->metric_name = info.metric_name;
> -		evsel->pmu_name = name ? strdup(name) : NULL;
> -		evsel->use_uncore_alias = use_uncore_alias;
> -		evsel->percore = config_term_percore(&evsel->config_terms);
> -	}
> -
> -	return evsel ? 0 : -ENOMEM;
> +	if (!evsel)
> +		return -ENOMEM;
> +
> +	evsel->pmu_name = name ? strdup(name) : NULL;
> +	evsel->use_uncore_alias = use_uncore_alias;
> +	evsel->percore = config_term_percore(&evsel->config_terms);
> +
> +	if (parse_state->fake_pmu)
> +		return 0;
> +
> +	evsel->unit = info.unit;
> +	evsel->scale = info.scale;
> +	evsel->per_pkg = info.per_pkg;
> +	evsel->snapshot = info.snapshot;
> +	evsel->metric_expr = info.metric_expr;
> +	evsel->metric_name = info.metric_name;
> +	return 0;
>  }
>  
>  int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
> -- 
> 2.28.0.297.g1956fa8f8d-goog
> 

