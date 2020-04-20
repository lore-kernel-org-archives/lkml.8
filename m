Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484EFC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24501206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpsGlv//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDTJFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:05:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25535 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbgDTJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587373538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3jN0EW6WMAdqDs9jGBK08UEDNd80uljOnIKIYUrofCI=;
        b=gpsGlv//IuyexZHO+US1eF3ysjgYhYwNUtTOVLFYDf37n/cPE0hHqc9Aahdxmmng2OU9A2
        eJJnMBHAYJPMyLighnPIItrhNETIlM9YkeSsZjf2btwAHFO0YktMh2Zbsmu5j9srr1sBeM
        TL1+EoDqdAHXQH86bG3LEJt/Tl0QWPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-MLdBaXaWO6utL8H7m2QNMQ-1; Mon, 20 Apr 2020 05:05:33 -0400
X-MC-Unique: MLdBaXaWO6utL8H7m2QNMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B980818C35A2;
        Mon, 20 Apr 2020 09:05:31 +0000 (UTC)
Received: from krava (ovpn-115-153.ams2.redhat.com [10.36.115.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C97E31001B0B;
        Mon, 20 Apr 2020 09:05:28 +0000 (UTC)
Date:   Mon, 20 Apr 2020 11:05:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] perf bench: Fix div-by-zero if runtime is zero
Message-ID: <20200420090526.GF718574@krava>
References: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
 <20200417132330.119407-4-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417132330.119407-4-tommi.t.rantala@nokia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 04:23:29PM +0300, Tommi Rantala wrote:
> Fix div-by-zero if runtime is zero:
> 
>   $ perf bench futex hash --runtime=0
>   # Running 'futex/hash' benchmark:
>   Run summary [PID 12090]: 4 threads, each operating on 1024 [private] futexes for 0 secs.
>   Floating point exception (core dumped)
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/bench/epoll-wait.c    | 3 ++-
>  tools/perf/bench/futex-hash.c    | 3 ++-
>  tools/perf/bench/futex-lock-pi.c | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> index f938c585d512..cf797362675b 100644
> --- a/tools/perf/bench/epoll-wait.c
> +++ b/tools/perf/bench/epoll-wait.c
> @@ -519,7 +519,8 @@ int bench_epoll_wait(int argc, const char **argv)
>  		qsort(worker, nthreads, sizeof(struct worker), cmpworker);
>  
>  	for (i = 0; i < nthreads; i++) {
> -		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
> +		unsigned long t = bench__runtime.tv_sec > 0 ?
> +			worker[i].ops / bench__runtime.tv_sec : 0;
>  
>  		update_stats(&throughput_stats, t);
>  
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> index 65eebe06c04d..915bf3da7ce2 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -205,7 +205,8 @@ int bench_futex_hash(int argc, const char **argv)
>  	pthread_mutex_destroy(&thread_lock);
>  
>  	for (i = 0; i < nthreads; i++) {
> -		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
> +		unsigned long t = bench__runtime.tv_sec > 0 ?
> +			worker[i].ops / bench__runtime.tv_sec : 0;
>  		update_stats(&throughput_stats, t);
>  		if (!silent) {
>  			if (nfutexes == 1)
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> index 89fd8f325f38..bb25d8beb3b8 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -211,7 +211,8 @@ int bench_futex_lock_pi(int argc, const char **argv)
>  	pthread_mutex_destroy(&thread_lock);
>  
>  	for (i = 0; i < nthreads; i++) {
> -		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
> +		unsigned long t = bench__runtime.tv_sec > 0 ?
> +			worker[i].ops / bench__runtime.tv_sec : 0;
>  
>  		update_stats(&throughput_stats, t);
>  		if (!silent)
> -- 
> 2.25.2
> 

