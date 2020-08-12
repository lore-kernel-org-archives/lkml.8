Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63326C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6A32080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597234154;
	bh=gBhTa1XmUXqnL+I+ENtHrIYjzEKTEzoi24Fs1EEN+Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nWQec8pE11AxJWfuopR9EMz4fvI91DsMX8bLCOautE5E3Joq83o3XZLXw9HuC4+1W
	 PAjEkkofZOaV7g6+mO5NTr4xw19ZusrBPFzLjkDwZ+P3pgdI8OZpENWxXJi46Kd8ww
	 UoKCqbGESDEAFkz5nTobS3ojAUHauu1rg5GOK/dY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgHLMJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgHLMJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:09:12 -0400
Received: from quaco.ghostprotocols.net (179.176.8.134.dynamic.adsl.gvt.net.br [179.176.8.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3952A207F7;
        Wed, 12 Aug 2020 12:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597234151;
        bh=gBhTa1XmUXqnL+I+ENtHrIYjzEKTEzoi24Fs1EEN+Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMSImypoizhHfSsAqKy3THXcxN00/v9P6ykexlQd9dMsh9G5P0bN9lyf6JdzZo1ka
         M/ztOEBVqbp+tIu9YZrSbPk01n2GRMqVGDrwh+nu4g8Pi9Idxk9ojl/lmDwg7b4tu8
         +kjQK7Q+n871W78FGNqlJxwcJf+LJCcRCbDp6Mjg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E1829403C6; Wed, 12 Aug 2020 09:09:08 -0300 (-03)
Date:   Wed, 12 Aug 2020 09:09:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 3/3] perf bench numa: fix benchmark names
Message-ID: <20200812120908.GC13995@kernel.org>
References: <cover.1597004831.git.agordeev@linux.ibm.com>
 <6b6f2084f132ee8e9203dc7c32f9deb209b87a68.1597004831.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b6f2084f132ee8e9203dc7c32f9deb209b87a68.1597004831.git.agordeev@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 10, 2020 at 08:22:00AM +0200, Alexander Gordeev escreveu:
> Standard benchmark names let users know the tests specifics.
> For example "2x1-bw-process" name tells that two processes
> one thread each are run and the RAM bandwidth is measured.
> 
> Several benchmarks names do not correspond to their actual
> running configuration. Fix that and also some whitespace
> and comment inconsistencies.

Looks, ok, applied.

- Arnaldo
 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  tools/perf/bench/numa.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 90639c9..3b4b63f 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -812,12 +812,12 @@ static u64 do_work(u8 *__data, long bytes, int nr, int nr_max, int loop, u64 val
>  			}
>  		}
>  	} else if (!g->p.data_backwards || (nr + loop) & 1) {
> +		/* Process data forwards: */
>  
>  		d0 = data + off;
>  		d  = data + off + 1;
>  		d1 = data + words;
>  
> -		/* Process data forwards: */
>  		for (;;) {
>  			if (unlikely(d >= d1))
>  				d = data;
> @@ -835,7 +835,6 @@ static u64 do_work(u8 *__data, long bytes, int nr, int nr_max, int loop, u64 val
>  		d  = data + off - 1;
>  		d1 = data + words;
>  
> -		/* Process data forwards: */
>  		for (;;) {
>  			if (unlikely(d < data))
>  				d = data + words-1;
> @@ -1732,12 +1731,12 @@ static int run_bench_numa(const char *name, const char **argv)
>   */
>  static const char *tests[][MAX_ARGS] = {
>     /* Basic single-stream NUMA bandwidth measurements: */
> -   { "RAM-bw-local,",	  "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
> +   { "RAM-bw-local,",     "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
>  			  "-C" ,   "0", "-M",   "0", OPT_BW_RAM },
>     { "RAM-bw-local-NOTHP,",
>  			  "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
>  			  "-C" ,   "0", "-M",   "0", OPT_BW_RAM_NOTHP },
> -   { "RAM-bw-remote,",	  "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
> +   { "RAM-bw-remote,",    "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
>  			  "-C" ,   "0", "-M",   "1", OPT_BW_RAM },
>  
>     /* 2-stream NUMA bandwidth measurements: */
> @@ -1779,24 +1778,24 @@ static int run_bench_numa(const char *name, const char **argv)
>  			  "mem",  "-p",  "8", "-t",  "1", "-P", " 512", OPT_BW_NOTHP },
>     { "16x1-bw-process,",  "mem",  "-p", "16", "-t",  "1", "-P",  "256", OPT_BW },
>  
> -   { " 4x1-bw-thread,",	  "mem",  "-p",  "1", "-t",  "4", "-T",  "256", OPT_BW },
> -   { " 8x1-bw-thread,",	  "mem",  "-p",  "1", "-t",  "8", "-T",  "256", OPT_BW },
> -   { "16x1-bw-thread,",   "mem",  "-p",  "1", "-t", "16", "-T",  "128", OPT_BW },
> -   { "32x1-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "64", OPT_BW },
> +   { " 1x4-bw-thread,",   "mem",  "-p",  "1", "-t",  "4", "-T",  "256", OPT_BW },
> +   { " 1x8-bw-thread,",   "mem",  "-p",  "1", "-t",  "8", "-T",  "256", OPT_BW },
> +   { "1x16-bw-thread,",   "mem",  "-p",  "1", "-t", "16", "-T",  "128", OPT_BW },
> +   { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "64", OPT_BW },
>  
> -   { " 2x3-bw-thread,",	  "mem",  "-p",  "2", "-t",  "3", "-P",  "512", OPT_BW },
> -   { " 4x4-bw-thread,",	  "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_BW },
> -   { " 4x6-bw-thread,",	  "mem",  "-p",  "4", "-t",  "6", "-P",  "512", OPT_BW },
> -   { " 4x8-bw-thread,",	  "mem",  "-p",  "4", "-t",  "8", "-P",  "512", OPT_BW },
> -   { " 4x8-bw-thread-NOTHP,",
> +   { " 2x3-bw-process,",  "mem",  "-p",  "2", "-t",  "3", "-P",  "512", OPT_BW },
> +   { " 4x4-bw-process,",  "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_BW },
> +   { " 4x6-bw-process,",  "mem",  "-p",  "4", "-t",  "6", "-P",  "512", OPT_BW },
> +   { " 4x8-bw-process,",  "mem",  "-p",  "4", "-t",  "8", "-P",  "512", OPT_BW },
> +   { " 4x8-bw-process-NOTHP,",
>  			  "mem",  "-p",  "4", "-t",  "8", "-P",  "512", OPT_BW_NOTHP },
> -   { " 3x3-bw-thread,",	  "mem",  "-p",  "3", "-t",  "3", "-P",  "512", OPT_BW },
> -   { " 5x5-bw-thread,",	  "mem",  "-p",  "5", "-t",  "5", "-P",  "512", OPT_BW },
> +   { " 3x3-bw-process,",  "mem",  "-p",  "3", "-t",  "3", "-P",  "512", OPT_BW },
> +   { " 5x5-bw-process,",  "mem",  "-p",  "5", "-t",  "5", "-P",  "512", OPT_BW },
>  
> -   { "2x16-bw-thread,",   "mem",  "-p",  "2", "-t", "16", "-P",  "512", OPT_BW },
> -   { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-P", "2048", OPT_BW },
> +   { "2x16-bw-process,",  "mem",  "-p",  "2", "-t", "16", "-P",  "512", OPT_BW },
> +   { "1x32-bw-process,",  "mem",  "-p",  "1", "-t", "32", "-P", "2048", OPT_BW },
>  
> -   { "numa02-bw,",	  "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW },
> +   { "numa02-bw,",        "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW },
>     { "numa02-bw-NOTHP,",  "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW_NOTHP },
>     { "numa01-bw-thread,", "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW },
>     { "numa01-bw-thread-NOTHP,",
> -- 
> 1.8.3.1
> 

-- 

- Arnaldo
