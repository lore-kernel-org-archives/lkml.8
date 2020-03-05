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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A04C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CDE20732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/Lx6Xul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCEOxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:53:08 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42770 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCEOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:53:08 -0500
Received: by mail-qt1-f195.google.com with SMTP id r6so4293627qtt.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HRrEhEN79eJRcPS27NqKFVT1ofNhGlJsDkYPXYilXv0=;
        b=L/Lx6XuldIolthi+k2y5sow3sFv3wZlinQNwDvdkQwQcMqjzMnWtvKEzaM7lffuCfd
         2oS+hq57j/CcHdeReKRyj/6zFbRU1TewMolaAv/G7UTLX+YRtX8vOm9V5dWs82bux9on
         Prt79RBKPu8SaA/+b4MBxpB+u6Uo1iMeo5svtUlHSh3/5PQBFwcirBQV1dHdYDW3GpSj
         ANPbYgo0T5QGR7KBaDZWdTTvLRhLPQi0yNOy9FcwLeUxzG9TY4kJZTRItM6A5TsSRqe5
         14G4UsLcylL3p2QwEDYKekNn5hDhSx9kc0bJtUpfCcJjhlPWjh+qJ7Gj1hfQW5jHf0Oj
         L6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HRrEhEN79eJRcPS27NqKFVT1ofNhGlJsDkYPXYilXv0=;
        b=dOC+Eg1IAO5zj/LdrpsgMlmtof7pXqpVeAuem1/THDODPTQTdi9H0QvsrzQl878jld
         +90w9bcRMksZOWNFYpvMFIn4CpPO2QHb9k0yfGbfTrF5OMfrdVgOOfqu3rWsrvxQZG3P
         oa0F9xOMC9jFDj48yGeAT1pY0IPlbh9hwxDMBh0zdyKisAOjTMINoFDrohbQbewoxBwO
         mFKFW3664r1JmhzzA/F2TRSyTX9RR8xNd7SNSUBrgfmGOBnuoAVNDZJ+waSjI/v50hcA
         zq1OvM9PahIUAL6JR8A5xlHeobzW2MceuiwcaShElxCXtd65IgBRRxXQmn2jnERfqKdp
         UsGQ==
X-Gm-Message-State: ANhLgQ0GS18PhBrK83ELoqVEEcgsiR3LS6EMrhifcT072aGAAG/jyvi3
        fD53Bb4N7RP/ies7lx00tRE=
X-Google-Smtp-Source: ADFU+vtKdkIn8+gnmqWAltQ5uXueBcDgJNW61sDDfN6g+Xp0BN+lUEXdcO9U891Lpqqdn6VXOcbf5A==
X-Received: by 2002:ac8:7511:: with SMTP id u17mr7325946qtq.316.1583419986708;
        Thu, 05 Mar 2020 06:53:06 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o16sm15915918qke.35.2020.03.05.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:53:06 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 47390403AD; Thu,  5 Mar 2020 11:53:04 -0300 (-03)
Date:   Thu, 5 Mar 2020 11:53:04 -0300
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf bench: Clear struct sigaction before
 sigaction() syscall
Message-ID: <20200305145304.GC7895@kernel.org>
References: <20200305083714.9381-1-tommi.t.rantala@nokia.com>
 <20200305083714.9381-4-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305083714.9381-4-tommi.t.rantala@nokia.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 10:37:14AM +0200, Tommi Rantala escreveu:
> Avoid garbage in sigaction structs used in sigaction() syscalls.
> Valgrind is complaining about it.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  tools/perf/bench/epoll-ctl.c           | 1 +
>  tools/perf/bench/epoll-wait.c          | 1 +
>  tools/perf/bench/futex-hash.c          | 1 +
>  tools/perf/bench/futex-lock-pi.c       | 1 +
>  tools/perf/bench/futex-requeue.c       | 1 +
>  tools/perf/bench/futex-wake-parallel.c | 1 +
>  tools/perf/bench/futex-wake.c          | 1 +
>  7 files changed, 7 insertions(+)
> 
> diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
> index bb617e5688412..63e2520017d81 100644
> --- a/tools/perf/bench/epoll-ctl.c
> +++ b/tools/perf/bench/epoll-ctl.c
> @@ -313,6 +313,7 @@ int bench_epoll_ctl(int argc, const char **argv)
>  		exit(EXIT_FAILURE);
>  	}
>  
> +	memset(&act, 0, sizeof(act));
>  	sigfillset(&act.sa_mask);
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
> diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> index 7af694437f4ea..5336e628b404c 100644
> --- a/tools/perf/bench/epoll-wait.c
> +++ b/tools/perf/bench/epoll-wait.c
> @@ -427,6 +427,7 @@ int bench_epoll_wait(int argc, const char **argv)
>  		exit(EXIT_FAILURE);
>  	}
>  
> +	memset(&act, 0, sizeof(act));
>  	sigfillset(&act.sa_mask);
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> index 8ba0c3330a9a2..c441aa446c7f8 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -137,6 +137,7 @@ int bench_futex_hash(int argc, const char **argv)
>  	if (!cpu)
>  		goto errmem;
>  
> +	memset(&act, 0, sizeof(act));
>  	sigfillset(&act.sa_mask);
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> index d0cae8125423f..27c6e1944cbed 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -161,6 +161,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
>  	if (!cpu)
>  		err(EXIT_FAILURE, "calloc");
>  
> +	memset(&act, 0, sizeof(act));
>  	sigfillset(&act.sa_mask);
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index a00a6891447ab..7a15c2e610228 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -128,6 +128,7 @@ int bench_futex_requeue(int argc, const char **argv)
>  	if (!cpu)
>  		err(EXIT_FAILURE, "cpu_map__new");
>  
> +	memset(&act, 0, sizeof(act));
>  	sigfillset(&act.sa_mask);
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> index a053cf2b70397..cd2b81a845acb 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -234,6 +234,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
>  		exit(EXIT_FAILURE);
>  	}
>  
> +	memset(&act, 0, sizeof(act));
>  	sigfillset(&act.sa_mask);
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index 58906e9499bb0..2dfcef3e371e4 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -136,6 +136,7 @@ int bench_futex_wake(int argc, const char **argv)
>  	if (!cpu)
>  		err(EXIT_FAILURE, "calloc");
>  
> +	memset(&act, 0, sizeof(act));
>  	sigfillset(&act.sa_mask);
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
> -- 
> 2.21.1
> 

-- 

- Arnaldo
