Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C8DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6ED2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EG/u1VV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgERMro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:47:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59534 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726709AbgERMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589806062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QI2DoCSTQmt9XKvtjloRdVpvqfICFbfiGQ5z/yfchF8=;
        b=EG/u1VV8fuxk6MFxaWNAeed4z5W6vKzMk8t5EBgiqygbG1A5gb0zYddjjifDuMN963o6OL
        6kLThaeWtTixLpM7FBhCRiT3ESZfsrt3k1ewm7EOYJXnydHKhV6IDe7+UuGdarxzMTkbrv
        jqVl+EXNBv186MWD+vvYJEod5QdKdD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-ETIEU4NpOXqWqc28cxVnBw-1; Mon, 18 May 2020 08:47:38 -0400
X-MC-Unique: ETIEU4NpOXqWqc28cxVnBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20162107ACCA;
        Mon, 18 May 2020 12:47:37 +0000 (UTC)
Received: from krava (unknown [10.40.196.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 76D4A5C1B2;
        Mon, 18 May 2020 12:47:33 +0000 (UTC)
Date:   Mon, 18 May 2020 14:47:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 5/5] perf stat: Report summary for interval mode
Message-ID: <20200518124732.GE3726797@krava>
References: <20200514053638.3736-1-yao.jin@linux.intel.com>
 <20200514053638.3736-6-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514053638.3736-6-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:36:38PM +0800, Jin Yao wrote:

SNIP

>  
>  	evlist__for_each_entry(evsel_list, counter) {
>  		if (counter->err)
> @@ -394,6 +403,7 @@ static void runtime_stat_reset(struct perf_stat_config *config)
>  static void process_interval(void)
>  {
>  	struct timespec ts, rs;
> +	struct stats walltime_nsecs_stats_bak;
>  
>  	clock_gettime(CLOCK_MONOTONIC, &ts);
>  	diff_timespec(&rs, &ts, &ref_time);
> @@ -407,9 +417,11 @@ static void process_interval(void)
>  			pr_err("failed to write stat round event\n");
>  	}
>  
> +	walltime_nsecs_stats_bak = walltime_nsecs_stats;
>  	init_stats(&walltime_nsecs_stats);
>  	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);
>  	print_counters(&rs, 0, NULL);
> +	walltime_nsecs_stats = walltime_nsecs_stats_bak;

could we instead of above initialize walltime_nsecs_stats
in the condition below, like:

	init_stats(&walltime_nsecs_stats);
	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);

jirka

>  }
>  
>  static void enable_counters(void)
> @@ -765,6 +777,19 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  
>  	update_stats(&walltime_nsecs_stats, t1 - t0);
>  
> +	if (interval) {
> +		stat_config.interval = 0;
> +		stat_config.summary = true;
> +
> +		if (stat_config.aggr_mode == AGGR_GLOBAL)
> +			perf_evlist__save_aggr_prev_raw_counts(evsel_list);
> +
> +		perf_evlist__copy_prev_raw_counts(evsel_list);
> +		perf_evlist__reset_prev_raw_counts(evsel_list);
> +		runtime_stat_reset(&stat_config);
> +		perf_stat__reset_shadow_per_stat(&rt_stat);
> +	}
> +

SNIP

