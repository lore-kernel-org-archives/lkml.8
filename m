Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A07C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0AB206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BG/400Pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgEDXmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:42:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35525 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728092AbgEDXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588635728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DGt5lAHTCi9AMiOj9WDZ8/F1kfuT+ne/gvQf86jelho=;
        b=BG/400Pgz6GS6iqTaQcw2PuAP00YDIVAtADlZ4onshMX1TofOBvU/NO7fe7GwKvPbGrudZ
        ZExfLT3f/Ac7XQIZCoFFWRmpWIolxYI9v/t4/RDazeTfZgmTTD/8R+CJRUKFLIv+HQJ8Gv
        6ElblC59XVazGADKSL4JjhhMNfBB/NY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-1Ey6BSMlNAOgAkwNjBLUBQ-1; Mon, 04 May 2020 19:42:06 -0400
X-MC-Unique: 1Ey6BSMlNAOgAkwNjBLUBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0644100A614;
        Mon,  4 May 2020 23:42:04 +0000 (UTC)
Received: from krava (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C49D600F5;
        Mon,  4 May 2020 23:42:02 +0000 (UTC)
Date:   Tue, 5 May 2020 01:41:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 2/2] perf stat: Report summary for interval mode
Message-ID: <20200504234159.GF1916255@krava>
References: <20200502020705.19295-1-yao.jin@linux.intel.com>
 <20200502020705.19295-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502020705.19295-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 10:07:05AM +0800, Jin Yao wrote:

SNIP

>  	init_stats(&walltime_nsecs_stats);
>  	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);
>  	print_counters(&rs, 0, NULL);
> +	walltime_nsecs_stats = walltime_nsecs_stats_bak;
>  }
>  
>  static void enable_counters(void)
> @@ -732,7 +735,14 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	 * avoid arbitrary skew, we must read all counters before closing any
>  	 * group leaders.
>  	 */
> -	read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
> +	if (!interval)
> +		read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
> +	else {
> +		stat_config.interval = 0;
> +		stat_config.summary = true;
> +		perf_evlist__copy_summary_counts(evsel_list);
> +		perf_evlist__process_summary_counts(&stat_config, evsel_list);

I think keeping the summary and copying it to evsel->count is ok,
but when we pretend to have new counts in place, could we process
it with perf_stat_process_counter function? so we keep just
1 processing code?

perhaps have some setup functions for non-interval settings?

SNIP

> +
> +	evsel->prev_raw_counts->aggr = evsel->summary_counts->aggr;
> +}
> +
> +void perf_evlist__copy_summary_counts(struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel)
> +		perf_evsel__copy_summary_counts(evsel);
> +}
> +
> +static void perf_stat_process_summary_counts(struct perf_stat_config *config,
> +					     struct evsel *evsel)
> +{
> +	struct perf_counts_values *summary = &evsel->summary_counts->aggr;

as I said earlier, why not copy all summary_counts data into 'counts'
and use the current code the process and display the result?

thanks,
jirka

> +	struct perf_stat_evsel *ps = evsel->stats;
> +	u64 *count = evsel->summary_counts->aggr.values;
> +	int i;
> +
> +	if (!config->summary || config->aggr_mode != AGGR_GLOBAL)
> +		return;
> +
> +	for (i = 0; i < 3; i++)
> +		init_stats(&ps->res_stats[i]);
> +
> +	perf_counts_values__scale(summary, config->scale,
> +				  &evsel->summary_counts->scaled);
> +
> +	for (i = 0; i < 3; i++)

SNIP

