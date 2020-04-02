Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97635C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DA4206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLySh2PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbgDBOSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:18:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42416 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733195AbgDBOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585837088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ivTLomq0GGE2ZnSf/cAoDjz8Ksn2aKTl1ZYroXjNbOU=;
        b=gLySh2PV/OCGkaJqZ1nLSN7/p3QPmTZW4TCqmMKzP2EPJ+BXbXS+KyWLoPFXprRSTwXplk
        o0FWDl9i6dTiJvHjVBUnvIk2dasY2aHt7YICEf+Wm2NMBKQW9IAzIuBWMTrPkx34rf/GQe
        uOUYVHea5X2nQa0tOLz8uDjuFAoRJcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-KK7ZybeTMGOl9dtGxwJ4cg-1; Thu, 02 Apr 2020 10:18:04 -0400
X-MC-Unique: KK7ZybeTMGOl9dtGxwJ4cg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0105F802563;
        Thu,  2 Apr 2020 14:18:03 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 272E0391;
        Thu,  2 Apr 2020 14:18:00 +0000 (UTC)
Date:   Thu, 2 Apr 2020 16:17:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/8] perf stat: introduce control descriptors and
 --ctl-fd[-ack] options
Message-ID: <20200402141758.GP2518490@krava>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
 <98dfb3ce-dab9-3747-8748-fbf2777f69ba@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98dfb3ce-dab9-3747-8748-fbf2777f69ba@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:47:40AM +0300, Alexey Budankov wrote:
> 
> Introduce control file descriptors and --ctl-fd[-ack] options to pass
> control descriptors from command line. Extend --delay option with -1
> value to start collection in paused mode to be resumed later by resume
> command provided via control file descriptor.

could you please separate those 2 changes?  also for record change

thanks,
jirka

> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 28 ++++++++++++++++++++++++----
>  tools/perf/util/evlist.h  |  3 +++
>  tools/perf/util/stat.h    |  4 +++-
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ec053dc1e35c..0a1b79fd3f48 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -187,6 +187,8 @@ static struct perf_stat_config stat_config = {
>  	.metric_only_len	= METRIC_ONLY_LEN,
>  	.walltime_nsecs_stats	= &walltime_nsecs_stats,
>  	.big_num		= true,
> +	.ctl_fd			= -1,
> +	.ctl_fd_ack		= -1
>  };
>  
>  static inline void diff_timespec(struct timespec *r, struct timespec *a,
> @@ -373,16 +375,26 @@ static void process_interval(void)
>  
>  static void enable_counters(void)
>  {
> -	if (stat_config.initial_delay)
> +	if (stat_config.initial_delay < 0) {
> +		pr_info(PERF_EVLIST__PAUSED_MSG);
> +		return;
> +	}
> +
> +	if (stat_config.initial_delay > 0) {
> +		pr_info(PERF_EVLIST__PAUSED_MSG);
>  		usleep(stat_config.initial_delay * USEC_PER_MSEC);
> +	}
>  
>  	/*
>  	 * We need to enable counters only if:
>  	 * - we don't have tracee (attaching to task or cpu)
>  	 * - we have initial delay configured
>  	 */
> -	if (!target__none(&target) || stat_config.initial_delay)
> +	if (!target__none(&target) || stat_config.initial_delay) {
>  		evlist__enable(evsel_list);
> +		if (stat_config.initial_delay > 0)
> +			pr_info(PERF_EVLIST__RESUMED_MSG);
> +	}
>  }
>  
>  static void disable_counters(void)
> @@ -912,8 +924,8 @@ static struct option stat_options[] = {
>  		     "aggregate counts per thread", AGGR_THREAD),
>  	OPT_SET_UINT(0, "per-node", &stat_config.aggr_mode,
>  		     "aggregate counts per numa node", AGGR_NODE),
> -	OPT_UINTEGER('D', "delay", &stat_config.initial_delay,
> -		     "ms to wait before starting measurement after program start"),
> +	OPT_INTEGER('D', "delay", &stat_config.initial_delay,
> +		     "ms to wait before starting measurement after program start (-1: start paused"),
>  	OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
>  			"Only print computed metrics. No raw values", enable_metric_only),
>  	OPT_BOOLEAN(0, "topdown", &topdown_run,
> @@ -933,6 +945,10 @@ static struct option stat_options[] = {
>  		    "Use with 'percore' event qualifier to show the event "
>  		    "counts of one hardware thread by sum up total hardware "
>  		    "threads of same physical core"),
> +	OPT_INTEGER(0, "ctl-fd", &stat_config.ctl_fd,
> +		    "Listen on fd descriptor for command to control measurement ('r': resume, 'p': pause)"),
> +	OPT_INTEGER(0, "ctl-fd-ack", &stat_config.ctl_fd_ack,
> +		    "Send control command completion ('a') to fd ack descriptor"),
>  	OPT_END()
>  };
>  
> @@ -2129,6 +2145,8 @@ int cmd_stat(int argc, const char **argv)
>  	signal(SIGALRM, skip_signal);
>  	signal(SIGABRT, skip_signal);
>  
> +	perf_evlist__initialize_ctlfd(evsel_list, stat_config.ctl_fd, stat_config.ctl_fd_ack);
> +
>  	status = 0;
>  	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
>  		if (stat_config.run_count != 1 && verbose > 0)
> @@ -2148,6 +2166,8 @@ int cmd_stat(int argc, const char **argv)
>  	if (!forever && status != -1 && !interval)
>  		print_counters(NULL, argc, argv);
>  
> +	perf_evlist__finalize_ctlfd(evsel_list);
> +
>  	if (STAT_RECORD) {
>  		/*
>  		 * We synthesize the kernel mmap record just so that older tools
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index a94b2993fafc..c91368483074 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -369,6 +369,9 @@ enum evlist_ctl_cmd {
>  	CTL_CMD_ACK = 'a'
>  };
>  
> +#define PERF_EVLIST__RESUMED_MSG "Monitoring resumed\n"
> +#define PERF_EVLIST__PAUSED_MSG  "Monitoring paused\n"
> +
>  int perf_evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
>  int perf_evlist__finalize_ctlfd(struct evlist *evlist);
>  int perf_evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b4fdfaa7f2c0..0b0fa3a2cde2 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -113,7 +113,7 @@ struct perf_stat_config {
>  	FILE			*output;
>  	unsigned int		 interval;
>  	unsigned int		 timeout;
> -	unsigned int		 initial_delay;
> +	int			 initial_delay;
>  	unsigned int		 unit_width;
>  	unsigned int		 metric_only_len;
>  	int			 times;
> @@ -130,6 +130,8 @@ struct perf_stat_config {
>  	struct perf_cpu_map		*cpus_aggr_map;
>  	u64			*walltime_run;
>  	struct rblist		 metric_events;
> +	int			 ctl_fd;
> +	int			 ctl_fd_ack;
>  };
>  
>  void update_stats(struct stats *stats, u64 val);
> -- 
> 2.24.1
> 
> 

