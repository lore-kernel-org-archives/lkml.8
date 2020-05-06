Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4002DC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1706B2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ/j9hbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgEFUMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgEFUMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:12:32 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7D7C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:12:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c10so3565460qka.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k414qEkE1koGztu5deC7f6jgOAvDHF8T2zRYZJkJcCk=;
        b=DQ/j9hbUy+DhJjRztAg24/ym4bvqAgteqV5CxDV//h6NVv/dpm7IPBr0HE1DfJeEkc
         /1rpcK1yxRK8bgq6RtIU+65HRzBtHbERd+dVYjRUgyEEzoUaiiUsXFip1DWna9bX9REr
         7pj2lFCRQI0HnZ8s3NlZfFv9OxLX4q7ABQpe4BME6bhOfzRLuk81iMRpWVc8mRLcMdA9
         a5IXeo/sY9N1w8ha8lH3zIpdurGWsrNrDWmHhesYmlV9Q0V0L306Xx5V130Hz0B390wF
         BtZrG+265d5KlYHMswQTgQ+PvgFpDiFFtCJnmL1NvlDw0dy11WFm4OeNrVXVM4iuckNa
         JWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k414qEkE1koGztu5deC7f6jgOAvDHF8T2zRYZJkJcCk=;
        b=kLxYebU57XlqzazgBpoPa48K0lbn7JddWUWaZnOQ2aHVcrRcAz+LmkDzY7GUJOU3aQ
         rPuOfjcKeMk98VmIybfXGE5LaWZnf6DWliqzRlvUNOrgVhlwc3MvOf9db3lphf5H2NxP
         JxV+2M6qgb0DWDhwqTAEYIkFPK71rf85al3NPIrCkLLuQ4QnUphi+j5uIkxScFoOYw1T
         GZfO3ea+yd5nf+GNL9L7s72kxblpgkQWRB5wnNDLPbhJhqyN3soqDtDC/r/FvsG1GLfJ
         q/x6vIJUMaJNBoqGXAFGGVyBNv16VfAV6rXTalJNBV44jN3Ae2VWlySk3uwadYntan7G
         2pFA==
X-Gm-Message-State: AGi0PuZG9pzQSoay2zQidtUcupL+Od6vXpFwUKkZqh4hUDy3QJ8iMNRk
        79INVH9b27S9YOmeoGOQ29m/U8VzIOc=
X-Google-Smtp-Source: APiQypLMy7oXDESttfdrF1ZvwWks+sMhzxcXHrh0HUQmdvSYV3hT4nB0Aat42JHWO5pZlHRWDNu3qg==
X-Received: by 2002:a37:58c1:: with SMTP id m184mr10924577qkb.83.1588795950084;
        Wed, 06 May 2020 13:12:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c19sm2258835qtn.94.2020.05.06.13.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:12:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2464E409A3; Wed,  6 May 2020 17:12:27 -0300 (-03)
Date:   Wed, 6 May 2020 17:12:27 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/11] perf stat: extend -D,--delay option with -1
 value
Message-ID: <20200506201227.GE9893@kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <df2ffd5b-dcd6-40ea-8053-74feef07724f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df2ffd5b-dcd6-40ea-8053-74feef07724f@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 06, 2020 at 09:20:54PM +0300, Alexey Budankov escreveu:
> 
> Extend -D,--delay option with -1 value to start monitoring with
> events disabled to be enabled later by enable command provided
> via control file descriptor.
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 18 ++++++++++++++----
>  tools/perf/util/evlist.h  |  3 +++
>  tools/perf/util/stat.h    |  2 +-

You forgot to update tools/perf/Documentation/perf-stat.h

>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 9775b0905146..bda777ca0420 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -383,16 +383,26 @@ static bool print_interval_and_stop(struct perf_stat_config *config, int *times)
>  
>  static void enable_counters(void)
>  {
> -	if (stat_config.initial_delay)
> +	if (stat_config.initial_delay < 0) {
> +		pr_info(PERF_EVLIST__DISABLED_MSG);
> +		return;
> +	}
> +
> +	if (stat_config.initial_delay > 0) {
> +		pr_info(PERF_EVLIST__DISABLED_MSG);
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
> +			pr_info(PERF_EVLIST__ENABLED_MSG);
> +	}
>  }
>  
>  static void disable_counters(void)
> @@ -929,8 +939,8 @@ static struct option stat_options[] = {
>  		     "aggregate counts per thread", AGGR_THREAD),
>  	OPT_SET_UINT(0, "per-node", &stat_config.aggr_mode,
>  		     "aggregate counts per numa node", AGGR_NODE),
> -	OPT_UINTEGER('D', "delay", &stat_config.initial_delay,
> -		     "ms to wait before starting measurement after program start"),
> +	OPT_INTEGER('D', "delay", &stat_config.initial_delay,
> +		    "ms to wait before starting measurement after program start (-1: start with events disabled"),
>  	OPT_CALLBACK_NOOPT(0, "metric-only", &stat_config.metric_only, NULL,
>  			"Only print computed metrics. No raw values", enable_metric_only),
>  	OPT_BOOLEAN(0, "topdown", &topdown_run,
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 84386850c290..874ecf068ac9 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -366,6 +366,9 @@ enum evlist_ctl_cmd {
>  	CTL_CMD_ACK = 'a'
>  };
>  
> +#define PERF_EVLIST__ENABLED_MSG "Events enabled\n"
> +#define PERF_EVLIST__DISABLED_MSG "Events disabled\n"
> +
>  int perf_evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
>  int perf_evlist__finalize_ctlfd(struct evlist *evlist);
>  int perf_evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b4fdfaa7f2c0..027b9dcd902f 100644
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
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
