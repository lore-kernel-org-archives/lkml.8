Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0256BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D318E20829
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597235134;
	bh=UI6QttmYUs52ycmRXyjV+pRO3m48DPHMxikF/d/PHN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t0RKoieDswew1NNoZLsYpaG4ggQiBOJsCxt8EOkrk2BySrncMJNXuNhc0XXBZYqXo
	 zmlmQ87CF72mI7WoP98LXZkYfyg9W6zlIcz8Vz9dhAWmHoPIryumGIWGxjzOvJJn3w
	 tYRwNZxxXdUohpeJA46G0xasrXA12AQlg2FURH2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgHLMZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbgHLMZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:25:32 -0400
Received: from quaco.ghostprotocols.net (179.176.8.134.dynamic.adsl.gvt.net.br [179.176.8.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D5B207DA;
        Wed, 12 Aug 2020 12:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597235131;
        bh=UI6QttmYUs52ycmRXyjV+pRO3m48DPHMxikF/d/PHN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baKtVyheI3+muVcGZNmIRijpLcRQBw//J8dldbzDvqRSXv/D4ifQopjBwXlalKHH3
         NAwll8c0JHtF2sS05hM/1cH+z6PzJoe7pAczOYUjiUjxoWjDLKkq42yQeRgvrqs1Ml
         rLTBd9U/qa2Y7lXWFvZDRVlQUMBAmVrCjo7hgNMw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 396EB403C6; Wed, 12 Aug 2020 09:25:29 -0300 (-03)
Date:   Wed, 12 Aug 2020 09:25:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, kernel@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench mem: Always memset source before memcpy
Message-ID: <20200812122529.GH13995@kernel.org>
References: <20200810133404.30829-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810133404.30829-1-vincent.whitchurch@axis.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 10, 2020 at 03:34:04PM +0200, Vincent Whitchurch escreveu:
> For memcpy, the source pages are memset to zero only when --cycles is
> used.  This leads to wildly different results with or without --cycles,
> since all sources pages are likely to be mapped to the same zero page
> without explicit writes.

Thanks, applied.

- Arnaldo
 
> Before this fix:
> 
> $ export cmd="./perf stat -e LLC-loads -- ./perf bench \
>   mem memcpy -s 1024MB -l 100 -f default"
> $ $cmd
> 
>          2,935,826      LLC-loads
>        3.821677452 seconds time elapsed
> 
> $ $cmd --cycles
> 
>        217,533,436      LLC-loads
>        8.616725985 seconds time elapsed
> 
> After this fix:
> 
> $ $cmd
> 
>        214,459,686      LLC-loads
>        8.674301124 seconds time elapsed
> 
> $ $cmd --cycles
> 
>        214,758,651      LLC-loads
>        8.644480006 seconds time elapsed
> 
> Fixes: 47b5757bac03c3387c ("perf bench mem: Move boilerplate memory allocation to the infrastructure")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  tools/perf/bench/mem-functions.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index 9235b76501be..19d45c377ac1 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -223,12 +223,8 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
>  	return 0;
>  }
>  
> -static u64 do_memcpy_cycles(const struct function *r, size_t size, void *src, void *dst)
> +static void memcpy_prefault(memcpy_t fn, size_t size, void *src, void *dst)
>  {
> -	u64 cycle_start = 0ULL, cycle_end = 0ULL;
> -	memcpy_t fn = r->fn.memcpy;
> -	int i;
> -
>  	/* Make sure to always prefault zero pages even if MMAP_THRESH is crossed: */
>  	memset(src, 0, size);
>  
> @@ -237,6 +233,15 @@ static u64 do_memcpy_cycles(const struct function *r, size_t size, void *src, vo
>  	 * to not measure page fault overhead:
>  	 */
>  	fn(dst, src, size);
> +}
> +
> +static u64 do_memcpy_cycles(const struct function *r, size_t size, void *src, void *dst)
> +{
> +	u64 cycle_start = 0ULL, cycle_end = 0ULL;
> +	memcpy_t fn = r->fn.memcpy;
> +	int i;
> +
> +	memcpy_prefault(fn, size, src, dst);
>  
>  	cycle_start = get_cycles();
>  	for (i = 0; i < nr_loops; ++i)
> @@ -252,11 +257,7 @@ static double do_memcpy_gettimeofday(const struct function *r, size_t size, void
>  	memcpy_t fn = r->fn.memcpy;
>  	int i;
>  
> -	/*
> -	 * We prefault the freshly allocated memory range here,
> -	 * to not measure page fault overhead:
> -	 */
> -	fn(dst, src, size);
> +	memcpy_prefault(fn, size, src, dst);
>  
>  	BUG_ON(gettimeofday(&tv_start, NULL));
>  	for (i = 0; i < nr_loops; ++i)
> -- 
> 2.25.1
> 

-- 

- Arnaldo
