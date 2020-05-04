Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC6CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F5F206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC6caKKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgEDXvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:51:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47710 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728182AbgEDXvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588636269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CdR+TTzrR6kmaYEcFh2fDuqfwQzbdiS6f0cc5j3IfEw=;
        b=OC6caKKqNCvw6N7+2jj8hDI1ELA1ZH+K2IVqapqqFc6GCXR1ON27uq7YGdFmYBpXuln1hv
        JKNm3C5Q7oGuqERmSdoFLZ3I9lwkYt62APWdS93EaMqg7zNIlCoUfrr0RZdGlj50OcANPO
        kBalGJNyWN9zgq5PgJR/ofIKcPOSq0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-DOz1SbIqNl6y6r2MNZbr6w-1; Mon, 04 May 2020 19:51:05 -0400
X-MC-Unique: DOz1SbIqNl6y6r2MNZbr6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EB85106B24A;
        Mon,  4 May 2020 23:51:04 +0000 (UTC)
Received: from krava (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F06BC66062;
        Mon,  4 May 2020 23:51:01 +0000 (UTC)
Date:   Tue, 5 May 2020 01:50:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/2] perf evsel: Create counts for collecting summary
 data
Message-ID: <20200504235059.GG1916255@krava>
References: <20200502020705.19295-1-yao.jin@linux.intel.com>
 <20200502020705.19295-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502020705.19295-2-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 10:07:04AM +0800, Jin Yao wrote:
> It would be useful to support the overall statistics for perf-stat
> interval mode. For example, report the summary at the end of
> "perf-stat -I" output.
> 
> But since perf-stat can support many aggregation modes, such as
> --per-thread, --per-socket, -M and etc, we need a solution which
> doesn't bring much complexity.
> 
> The idea is to create new 'evsel->summary_counts' which sums up the
> counts delta per interval. Before reporting the summary, we copy the
> data from evsel->summary_counts to evsel->counts, and next we just
> follow current code.
> 
>  v2:
>  ---
>  Rebase to perf/core branch
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/evsel.c | 10 ++++++++--
>  tools/perf/util/evsel.h |  1 +
>  tools/perf/util/stat.c  | 20 ++++++++++++++++++++
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a75bcb95bf23..abc503dd6eda 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1280,22 +1280,28 @@ void evsel__delete(struct evsel *evsel)
>  void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
>  			   struct perf_counts_values *count)
>  {
> -	struct perf_counts_values tmp;
> +	struct perf_counts_values tmp, *summary;
>  
> -	if (!evsel->prev_raw_counts)
> +	if (!evsel->prev_raw_counts || !evsel->summary_counts)
>  		return;
>  
>  	if (cpu == -1) {
>  		tmp = evsel->prev_raw_counts->aggr;
>  		evsel->prev_raw_counts->aggr = *count;
> +		summary = &evsel->summary_counts->aggr;
>  	} else {
>  		tmp = *perf_counts(evsel->prev_raw_counts, cpu, thread);
>  		*perf_counts(evsel->prev_raw_counts, cpu, thread) = *count;
> +		summary = perf_counts(evsel->summary_counts, cpu, thread);

shouldn't this be enough?

		perf_counts(evsel->summary_counts, cpu, thread) = *count

without the code below.. and similar for aggr case

however I still wonder if we should count this in
perf_stat_process_counter and only for interval mode

>  	}
>  
>  	count->val = count->val - tmp.val;
>  	count->ena = count->ena - tmp.ena;
>  	count->run = count->run - tmp.run;
> +
> +	summary->val += count->val;
> +	summary->ena += count->ena;
> +	summary->run += count->run;
>  }
>  
>  void perf_counts_values__scale(struct perf_counts_values *count,
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 783246bf8d0d..430639c99d04 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -46,6 +46,7 @@ struct evsel {
>  	char			*filter;
>  	struct perf_counts	*counts;
>  	struct perf_counts	*prev_raw_counts;
> +	struct perf_counts	*summary_counts;

'sum_counts' might be better

jirka

>  	int			idx;
>  	unsigned long		max_events;
>  	unsigned long		nr_events_printed;
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 774468341851..c3fd008b4e84 100644
> --- a/tools/perf/util/stat.c

SNIP

