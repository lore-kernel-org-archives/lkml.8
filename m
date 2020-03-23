Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57848C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271292070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHdDwcAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgCWK7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:59:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22090 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727974AbgCWK7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584961192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KiOvjRY1B4DOm2CDtGluY3HQ7dbfJlmV+cUNUxWfNwY=;
        b=HHdDwcAhO1R1D5HwBI613pvRL66UVd26FvT78OjWhBWCEkBSMhfBGNhX2oBcRFJYhwD+rl
        7J0ZWfYQ4dWmYcfCSNX2uE2RjXoMoZfXBVj+O7KrVUG2RFS1DnzXyU20OUWiKlZz0byXy6
        c5LYpk94uykERal/NXhKhC5ooND5X+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-dtCx0_2-MTaQjECBgwo9yg-1; Mon, 23 Mar 2020 06:59:49 -0400
X-MC-Unique: dtCx0_2-MTaQjECBgwo9yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C3401005514;
        Mon, 23 Mar 2020 10:59:47 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82B0D5DA81;
        Mon, 23 Mar 2020 10:59:42 +0000 (UTC)
Date:   Mon, 23 Mar 2020 11:59:39 +0100
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
Subject: Re: [PATCH v2 1/2] perf parse-events: fix memory leaks found on
 parse_events
Message-ID: <20200323105939.GE1534489@krava>
References: <20200319023101.82458-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319023101.82458-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 07:31:00PM -0700, Ian Rogers wrote:
> Memory leaks found by applying LLVM's libfuzzer on the parse_events
> function.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/parse-events.c | 2 ++
>  tools/perf/util/parse-events.y | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 593b6b03785d..1e0bec5c0846 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1482,6 +1482,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  
>  		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
>  			list_del_init(&pos->list);
> +			if (pos->free_str)
> +				free(pos->val.str);
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
>  	}
>  	free(list_evsel);
>  }
> @@ -326,6 +326,7 @@ PE_NAME opt_pmu_config
>  	}
>  	parse_events_terms__delete($2);
>  	parse_events_terms__delete(orig_terms);
> +	free(pattern);
>  	free($1);
>  	$$ = list;
>  #undef CLEANUP_YYABORT
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

