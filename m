Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8514C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B34620848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOQsfEMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCEOvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:51:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35507 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCEOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:51:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id 145so5528528qkl.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lXr8QyHFHX5e4o5E1cYT1QWO5kxOYAViBMEnNNRzKd4=;
        b=uOQsfEMMIEnezw+yh2X6yXI/eeep//e7c5oeCb3tQGIaPg3BWiD8M4WkguEvCuzE1I
         VoplBTsKZWDKGMiwKBtsMJFtkvNcJ/36CsMXEjvC64jJyXLIyy6CFah3GXJLpvkdYjjY
         0GfxCH88YJfmaB7aOtchS/UwHYZthXLxpw9gShGUm9sNAyuq7GJ8eAcAMqNvHrCQVFNi
         Q4lZZYIryoO1OqenUs5lqWxxKa8PGhmLaArMFnME2DJpabQortNJu/u8VnmSB8rsKTJ4
         RR1wv44CeL7uGc0MoKbkLqpIfUuaH/ymQBB5fo4SaZASHRE0CFkJqZb55lY6Pk77cNRC
         IxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lXr8QyHFHX5e4o5E1cYT1QWO5kxOYAViBMEnNNRzKd4=;
        b=oUQMUzaeNI6Z2F0p0nxNQdhQv6dPFcVbUB4tobBPBZVEOSfbFk/SDl5oPS9kknyNrd
         DsM6BqLmYUF2rtpw88/0Fcgz+2ERl+blav0PggIU9d25oyys6p+w2VViDqvLXOjVklX0
         If63tDC0E4aOakXbtQZpmist/bwnz6wXHd8CunodsJhsXPuvCw7WH+HB1AKiv1yW2ppw
         d9Fdnf5+/YOfQX0z1q26NmMN0Mqmx7SyTFQIa4sQi0xeFnZZGXPOJi6juupgdeOpxHLo
         lPKRtTHnXn3aGZjEbk5GBm0X/Wso/jir9zG++P1nNyvMMueh1jvCIPXyanfuHAlVMjcD
         qfBw==
X-Gm-Message-State: ANhLgQ3dvdz+XDPMvF78GqvvMktxn/9YAJh/0XYPhiIkwpqO6isRrwwi
        hZ5x+jAozXguf34QR4Lha+ELFr++5pI=
X-Google-Smtp-Source: ADFU+vsxWoq+GfWEDnszeXZIQouK4f9Ruu2WMnGYc3+6NRAhYiji33vf1VzSn4v5H3bV0KLSX9kR+w==
X-Received: by 2002:a05:620a:148e:: with SMTP id w14mr8584216qkj.473.1583419912052;
        Thu, 05 Mar 2020 06:51:52 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x7sm9738994qkx.110.2020.03.05.06.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:51:51 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 83DA5403AD; Thu,  5 Mar 2020 11:51:49 -0300 (-03)
Date:   Thu, 5 Mar 2020 11:51:49 -0300
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf bench futex-wake: Restore thread count default
 to online CPU count
Message-ID: <20200305145149.GB7895@kernel.org>
References: <20200305083714.9381-1-tommi.t.rantala@nokia.com>
 <20200305083714.9381-3-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305083714.9381-3-tommi.t.rantala@nokia.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 10:37:13AM +0200, Tommi Rantala escreveu:
> Since commit 3b2323c2c1c4 ("perf bench futex: Use cpumaps") the default
> number of threads the benchmark uses got changed from number of online
> CPUs to zero:
> 
>   $ perf bench futex wake
>   # Running 'futex/wake' benchmark:
>   Run summary [PID 15930]: blocking on 0 threads (at [private] futex 0x558b8ee4bfac), waking up 1 at a time.
>   [Run 1]: Wokeup 0 of 0 threads in 0.0000 ms
>   [...]
>   [Run 10]: Wokeup 0 of 0 threads in 0.0000 ms
>   Wokeup 0 of 0 threads in 0.0004 ms (+-40.82%)
> 
> Restore the old behavior by grabbing the number of online CPUs via
> cpu->nr:
> 
>   $ perf bench futex wake
>   # Running 'futex/wake' benchmark:
>   Run summary [PID 18356]: blocking on 8 threads (at [private] futex 0xb3e62c), waking up 1 at a time.
>   [Run 1]: Wokeup 8 of 8 threads in 0.0260 ms
>   [...]
>   [Run 10]: Wokeup 8 of 8 threads in 0.0270 ms
>   Wokeup 8 of 8 threads in 0.0419 ms (+-24.35%)
> 
> Fixes: 3b2323c2c1c4 ("perf bench futex: Use cpumaps")

Thanks, tested and applied.

- Arnaldo

> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  tools/perf/bench/futex-wake.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index df810096abfef..58906e9499bb0 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -43,7 +43,7 @@ static bool done = false, silent = false, fshared = false;
>  static pthread_mutex_t thread_lock;
>  static pthread_cond_t thread_parent, thread_worker;
>  static struct stats waketime_stats, wakeup_stats;
> -static unsigned int ncpus, threads_starting, nthreads = 0;
> +static unsigned int threads_starting, nthreads = 0;
>  static int futex_flag = 0;
>  
>  static const struct option options[] = {
> @@ -141,7 +141,7 @@ int bench_futex_wake(int argc, const char **argv)
>  	sigaction(SIGINT, &act, NULL);
>  
>  	if (!nthreads)
> -		nthreads = ncpus;
> +		nthreads = cpu->nr;
>  
>  	worker = calloc(nthreads, sizeof(*worker));
>  	if (!worker)
> -- 
> 2.21.1
> 

-- 

- Arnaldo
