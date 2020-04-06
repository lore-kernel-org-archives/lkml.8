Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0ACC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E001D23730
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuZUDdlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgDFOHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:07:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42322 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:07:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id b10so7209082qtt.9;
        Mon, 06 Apr 2020 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4mtyy44gYeHphxWF5+osmnZwBI5Yi5ai2sDz29iMZVI=;
        b=UuZUDdlIadlahqYsTb/OqiVKmMIO7KWsyUSFv7Jqt2R8gyCUkmiZuJjsHRqeVkbsKq
         B5XPW0QJoeBCaoQ3kGhypHfpUxN5QuA+iK0lPu4EHZXZ6v4cL0/YBs7q6rf7fxyxXfyP
         IJVc0UTKUxoM6POGAZitrIDVX5u9IlRkAAP9tHmpwNpQi7fXspYzZDZyITuHB6kObZay
         IEOfaD/ZD2VWiemSQLIwX9rsSLMdbgeNwC9UVxcM/dIYcUVMD5Ak2AMiUrKt1zqzNXOH
         KQhkxjYHoO2i0QmKlzQTRXsF6oTjON91/aXcrKkNeNWNfEBjvd2KQYJJpuvtfJUCq2fV
         IHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4mtyy44gYeHphxWF5+osmnZwBI5Yi5ai2sDz29iMZVI=;
        b=i2TaECKUzEj+zehET2vjXTMhk/KzOoEFJQ5lKMXVWZJuodQJjDUGxYH/fB7LrtXEew
         +os/eD5bL2pbXo5ErMJqB9Ed0wUZzV6jiyOeAuQqeq6TJ2SWQ6/zm4JRJquBN2tep5TW
         YoTWj+hY38m4CvBWX2CfF/Iyx+oWItPAgN6VtwVrNwNVPVponvII/bsQs55zoHmQYZQ0
         4hgRA6lpmw+Az2MBeX5KFEFfu2py8kKDpSWsG/PADaDIQZ6l/pfAHu5cJzaEoYv3FloG
         8lorOCq7ucAch7dkltQAGxZtuitAafM9G/qoKV4aSBhCdsji3FiECC02dbQihfrOmPcB
         Si6w==
X-Gm-Message-State: AGi0PuYBzl4wyQhcoz1VgB6cdfSCYBOs3ov5hREVxGJ7GRcQFSUuZSLI
        uKPdScKuEXuBkMmb5Tbmg9E=
X-Google-Smtp-Source: APiQypLJqzdpyRFICWE2APILYPmcX6nGwsKQWDowqAZyJr2A/tEh9kuQdrbcudNdmfePVS9+hF0CNg==
X-Received: by 2002:ac8:a09:: with SMTP id b9mr20843765qti.190.1586182026831;
        Mon, 06 Apr 2020 07:07:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t53sm15011731qth.70.2020.04.06.07.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:07:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F32C409A3; Mon,  6 Apr 2020 11:07:02 -0300 (-03)
Date:   Mon, 6 Apr 2020 11:07:02 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/5] perf bench: add event synthesis benchmark
Message-ID: <20200406140702.GC29826@kernel.org>
References: <20200402154357.107873-1-irogers@google.com>
 <20200402154357.107873-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402154357.107873-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 02, 2020 at 08:43:53AM -0700, Ian Rogers escreveu:
> Event synthesis may occur at the start or end (tail) of a perf command.
> In system-wide mode it can scan every process in /proc, which may add
> seconds of latency before event recording. Add a new benchmark that
> times how long event synthesis takes with and without data synthesis.

Thanks, applied,

- Arnaldo
 
> An example execution looks like:
>  $ perf bench internals synthesize
>  # Running 'internals/synthesize' benchmark:
>  Average synthesis took: 168.253800 usec
>  Average data synthesis took: 208.104700 usec
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-bench.txt |   8 ++
>  tools/perf/bench/Build                  |   2 +-
>  tools/perf/bench/bench.h                |   2 +-
>  tools/perf/bench/synthesize.c           | 101 ++++++++++++++++++++++++
>  tools/perf/builtin-bench.c              |   6 ++
>  5 files changed, 117 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/bench/synthesize.c
> 
> diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
> index 0921a3c67381..bad16512c48d 100644
> --- a/tools/perf/Documentation/perf-bench.txt
> +++ b/tools/perf/Documentation/perf-bench.txt
> @@ -61,6 +61,9 @@ SUBSYSTEM
>  'epoll'::
>  	Eventpoll (epoll) stressing benchmarks.
>  
> +'internals'::
> +	Benchmark internal perf functionality.
> +
>  'all'::
>  	All benchmark subsystems.
>  
> @@ -214,6 +217,11 @@ Suite for evaluating concurrent epoll_wait calls.
>  *ctl*::
>  Suite for evaluating multiple epoll_ctl calls.
>  
> +SUITES FOR 'internals'
> +~~~~~~~~~~~~~~~~~~~~~~
> +*synthesize*::
> +Suite for evaluating perf's event synthesis performance.
> +
>  SEE ALSO
>  --------
>  linkperf:perf[1]
> diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
> index e4e321b6f883..042827385c87 100644
> --- a/tools/perf/bench/Build
> +++ b/tools/perf/bench/Build
> @@ -6,9 +6,9 @@ perf-y += futex-wake.o
>  perf-y += futex-wake-parallel.o
>  perf-y += futex-requeue.o
>  perf-y += futex-lock-pi.o
> -
>  perf-y += epoll-wait.o
>  perf-y += epoll-ctl.o
> +perf-y += synthesize.o
>  
>  perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
>  perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index 4aa6de1aa67d..4d669c803237 100644
> --- a/tools/perf/bench/bench.h
> +++ b/tools/perf/bench/bench.h
> @@ -41,9 +41,9 @@ int bench_futex_wake_parallel(int argc, const char **argv);
>  int bench_futex_requeue(int argc, const char **argv);
>  /* pi futexes */
>  int bench_futex_lock_pi(int argc, const char **argv);
> -
>  int bench_epoll_wait(int argc, const char **argv);
>  int bench_epoll_ctl(int argc, const char **argv);
> +int bench_synthesize(int argc, const char **argv);
>  
>  #define BENCH_FORMAT_DEFAULT_STR	"default"
>  #define BENCH_FORMAT_DEFAULT		0
> diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> new file mode 100644
> index 000000000000..6291257bc9c9
> --- /dev/null
> +++ b/tools/perf/bench/synthesize.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Benchmark synthesis of perf events such as at the start of a 'perf
> + * record'. Synthesis is done on the current process and the 'dummy' event
> + * handlers are invoked that support dump_trace but otherwise do nothing.
> + *
> + * Copyright 2019 Google LLC.
> + */
> +#include <stdio.h>
> +#include "bench.h"
> +#include "../util/debug.h"
> +#include "../util/session.h"
> +#include "../util/synthetic-events.h"
> +#include "../util/target.h"
> +#include "../util/thread_map.h"
> +#include "../util/tool.h"
> +#include <linux/err.h>
> +#include <linux/time64.h>
> +#include <subcmd/parse-options.h>
> +
> +static unsigned int iterations = 10000;
> +
> +static const struct option options[] = {
> +	OPT_UINTEGER('i', "iterations", &iterations,
> +		"Number of iterations used to compute average"),
> +	OPT_END()
> +};
> +
> +static const char *const usage[] = {
> +	"perf bench internals synthesize <options>",
> +	NULL
> +};
> +
> +
> +static int do_synthesize(struct perf_session *session,
> +			struct perf_thread_map *threads,
> +			struct target *target, bool data_mmap)
> +{
> +	const unsigned int nr_threads_synthesize = 1;
> +	struct timeval start, end, diff;
> +	u64 runtime_us;
> +	unsigned int i;
> +	double average;
> +	int err;
> +
> +	gettimeofday(&start, NULL);
> +	for (i = 0; i < iterations; i++) {
> +		err = machine__synthesize_threads(&session->machines.host,
> +						target, threads, data_mmap,
> +						nr_threads_synthesize);
> +		if (err)
> +			return err;
> +	}
> +
> +	gettimeofday(&end, NULL);
> +	timersub(&end, &start, &diff);
> +	runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
> +	average = (double)runtime_us/(double)iterations;
> +	printf("Average %ssynthesis took: %f usec\n",
> +		data_mmap ? "data " : "", average);
> +	return 0;
> +}
> +
> +int bench_synthesize(int argc, const char **argv)
> +{
> +	struct perf_tool tool;
> +	struct perf_session *session;
> +	struct target target = {
> +		.pid = "self",
> +	};
> +	struct perf_thread_map *threads;
> +	int err;
> +
> +	argc = parse_options(argc, argv, options, usage, 0);
> +
> +	session = perf_session__new(NULL, false, NULL);
> +	if (IS_ERR(session)) {
> +		pr_err("Session creation failed.\n");
> +		return PTR_ERR(session);
> +	}
> +	threads = thread_map__new_by_pid(getpid());
> +	if (!threads) {
> +		pr_err("Thread map creation failed.\n");
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +	perf_tool__fill_defaults(&tool);
> +
> +	err = do_synthesize(session, threads, &target, false);
> +	if (err)
> +		goto err_out;
> +
> +	err = do_synthesize(session, threads, &target, true);
> +
> +err_out:
> +	if (threads)
> +		perf_thread_map__put(threads);
> +
> +	perf_session__delete(session);
> +	return err;
> +}
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index c06fe21c8613..11c79a8d85d6 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -76,6 +76,11 @@ static struct bench epoll_benchmarks[] = {
>  };
>  #endif // HAVE_EVENTFD
>  
> +static struct bench internals_benchmarks[] = {
> +	{ "synthesize", "Benchmark perf event synthesis",	bench_synthesize	},
> +	{ NULL,		NULL,					NULL			}
> +};
> +
>  struct collection {
>  	const char	*name;
>  	const char	*summary;
> @@ -92,6 +97,7 @@ static struct collection collections[] = {
>  #ifdef HAVE_EVENTFD
>  	{"epoll",       "Epoll stressing benchmarks",                   epoll_benchmarks        },
>  #endif
> +	{ "internals",	"Perf-internals benchmarks",			internals_benchmarks	},
>  	{ "all",	"All benchmarks",				NULL			},
>  	{ NULL,		NULL,						NULL			}
>  };
> -- 
> 2.26.0.rc2.310.g2932bb562d-goog
> 

-- 

- Arnaldo
