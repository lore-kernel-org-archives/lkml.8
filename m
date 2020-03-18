Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE8DC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3A52076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccWO6boC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgCRKkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:40:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40148 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbgCRKkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584528023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBdjH8RHRR7Z8mptXmC5pXUdosTe08Yji59vlIq8X/s=;
        b=ccWO6boCfV/1wYZDv4ZSQUB3vv1DJghOnEUekrb9EQ6lhAM6oThEpVD+l9BMk/2tmwYfjt
        S51slICuCEbLfrw6DgcYvEMqCNlUnVw11+XMRP6i5GQuxovcpH6n6SCFMYThSWpV+7OAQE
        YaJPsKJw4XftePJ8IHtruFrJFDKSBuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-oYaycwOzNQeocBb6VQrlzQ-1; Wed, 18 Mar 2020 06:40:19 -0400
X-MC-Unique: oYaycwOzNQeocBb6VQrlzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0B298010D9;
        Wed, 18 Mar 2020 10:40:16 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2DE95D9E2;
        Wed, 18 Mar 2020 10:40:13 +0000 (UTC)
Date:   Wed, 18 Mar 2020 11:40:11 +0100
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
Subject: Re: [PATCH] perf parse-events: fix memory leaks found on parse_events
Message-ID: <20200318104011.GF821557@krava>
References: <20200316041431.19607-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316041431.19607-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 09:14:31PM -0700, Ian Rogers wrote:
> Memory leaks found by applying LLVM's libfuzzer on the parse_events
> function.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/evlist.c        | 2 ++
>  tools/perf/util/parse-events.c | 2 ++
>  tools/perf/util/parse-events.y | 3 ++-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 5b9f2ca50591..6485d1438f75 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -125,8 +125,10 @@ static void perf_evlist__purge(struct perf_evlist *evlist)
>  void perf_evlist__exit(struct perf_evlist *evlist)
>  {
>  	perf_cpu_map__put(evlist->cpus);
> +	perf_cpu_map__put(evlist->all_cpus);

ugh, yes, could you please put it to separate libperf patch?

>  	perf_thread_map__put(evlist->threads);
>  	evlist->cpus = NULL;
> +	evlist->all_cpus = NULL;

there's already change adding this waiting on the list:
  https://lore.kernel.org/lkml/1583665157-349023-1-git-send-email-zhe.he@windriver.com/

>  	evlist->threads = NULL;
>  	fdarray__exit(&evlist->pollfd);
>  }
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index a14995835d85..997862224292 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1482,6 +1482,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  
>  		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
>  			list_del_init(&pos->list);
> +			if (pos->free_str)
> +				free(pos->val.str);

ack, would be nice to have  perf_evsel__free_config_terms generalized
to work directly over config terms list, so we'd have only single
cleanup function

>  			free(pos);
>  		}
>  		return -EINVAL;
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 94f8bcd83582..8212cc771667 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -44,7 +44,7 @@ static void free_list_evsel(struct list_head* list_evsel)
>  
>  	list_for_each_entry_safe(evsel, tmp, list_evsel, core.node) {
>  		list_del_init(&evsel->core.node);
> -		perf_evsel__delete(evsel);
> +		evsel__delete(evsel);

ack

>  	}
>  	free(list_evsel);
>  }
> @@ -326,6 +326,7 @@ PE_NAME opt_pmu_config
>  	}
>  	parse_events_terms__delete($2);
>  	parse_events_terms__delete(orig_terms);
> +	free(pattern);

ack

could you please send the separate change for libperf?
and synchronize with that other patch mentioned above

thanks,
jirka

