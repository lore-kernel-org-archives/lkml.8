Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B60C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B69120656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzgZu7PP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgDVIqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:46:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49088 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725961AbgDVIqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587545205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSM2YhynE3slUTVy5GW7CvhSLhSswiDZKQZbz6/cses=;
        b=fzgZu7PPf90fv7b7lWwVaI0yBmlpkJAstfXQ0OI1WdIuxEplqJAEVI1xAH1deiEiDLJd6t
        2/iGi4GWUWY2cOqWM0LhVzmwl3R+BMbL5PEOCr+k54gFoLRpXmwQmsPNk4Wn8M6zbCwtAN
        zBs7OEO8UtrtWPzSxrHO+j/9QEDd9PY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-z_VAvBPuP02g-IazalJ9sQ-1; Wed, 22 Apr 2020 04:46:43 -0400
X-MC-Unique: z_VAvBPuP02g-IazalJ9sQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01777107ACC4;
        Wed, 22 Apr 2020 08:46:42 +0000 (UTC)
Received: from krava (unknown [10.40.196.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0AB21001DD8;
        Wed, 22 Apr 2020 08:46:38 +0000 (UTC)
Date:   Wed, 22 Apr 2020 10:46:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf record: add dummy event during system wide
 synthesis
Message-ID: <20200422084635.GF962614@krava>
References: <20200421061103.109440-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421061103.109440-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:11:03PM -0700, Ian Rogers wrote:
> During the processing of /proc during event synthesis new processes may
> start. Add a dummy event if /proc is to be processed, to capture mmaps
> for starting processes. This reuses the existing logic for
> initial-delay.
> 
> v2 fixes the dummy event configuration and a branch stack issue.

heya,
it's breaking attr tests for me:

[jolsa@krava perf]$ sudo ./perf test -v 17
17: Setup struct perf_event_attr                          :
--- start ---
test child forked, pid 1046560
running './tests/attr/test-record-graph-default'
running './tests/attr/test-record-raw'
running './tests/attr/test-record-branch-filter-any'
running './tests/attr/test-record-freq'
running './tests/attr/test-record-branch-any'
running './tests/attr/test-stat-group1'
running './tests/attr/test-record-no-samples'
running './tests/attr/test-record-graph-dwarf'
running './tests/attr/test-stat-C0'
running './tests/attr/test-stat-basic'
running './tests/attr/test-record-group'
running './tests/attr/test-record-branch-filter-k'
running './tests/attr/test-stat-group'
running './tests/attr/test-record-C0'
expected config=0, got 9
expected sample_type=391, got 455
expected disabled=1, got 0
FAILED './tests/attr/test-record-C0' - match failure
test child finished with -1
---- end ----
Setup struct perf_event_attr: FAILED!

jirka

> 
> Suggested-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c | 19 ++++++++++++++-----
>  tools/perf/util/evsel.c     |  5 ++++-
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 1ab349abe904..8d1e93351298 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -805,19 +805,28 @@ static int record__open(struct record *rec)
>  	int rc = 0;
>  
>  	/*
> -	 * For initial_delay we need to add a dummy event so that we can track
> -	 * PERF_RECORD_MMAP while we wait for the initial delay to enable the
> -	 * real events, the ones asked by the user.
> +	 * For initial_delay or system wide, we need to add a dummy event so
> +	 * that we can track PERF_RECORD_MMAP to cover the delay of waiting or
> +	 * event synthesis.
>  	 */
> -	if (opts->initial_delay) {
> +	if (opts->initial_delay || target__has_cpu(&opts->target)) {
>  		if (perf_evlist__add_dummy(evlist))
>  			return -ENOMEM;
>  
> +		/* Disable tracking of mmaps on lead event. */
>  		pos = evlist__first(evlist);
>  		pos->tracking = 0;
> +		/* Set up dummy event. */
>  		pos = evlist__last(evlist);
>  		pos->tracking = 1;
> -		pos->core.attr.enable_on_exec = 1;
> +		/*
> +		 * Enable the dummy event when the process is forked for
> +		 * initial_delay, immediately for system wide.
> +		 */
> +		if (opts->initial_delay)
> +			pos->core.attr.enable_on_exec = 1;
> +		else
> +			pos->immediate = 1;
>  	}
>  
>  	perf_evlist__config(evlist, opts, &callchain_param);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 6a571d322bb2..ca8f9533d8f9 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1163,11 +1163,14 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	}
>  
>  	/*
> +	 * A dummy event never triggers any actual counter and therefore
> +	 * cannot be used with branch_stack.
> +	 *
>  	 * For initial_delay, a dummy event is added implicitly.
>  	 * The software event will trigger -EOPNOTSUPP error out,
>  	 * if BRANCH_STACK bit is set.
>  	 */
> -	if (opts->initial_delay && is_dummy_event(evsel))
> +	if (is_dummy_event(evsel))
>  		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
>  }
>  
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 

