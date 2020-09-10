Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3AEC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7512C20731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599768706;
	bh=VxQVC648qQ3aQ7KAntrOBMaixdukqiVVbKsy/UOgfbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nhe/cNqMyvle1/421JGS8Lwy5eNTsjeM5pgXalW+V7+bhG8dpPcYpmHEzWMBgIe72
	 HTmn3DHMcpza4pHFA6LjRJHNLFcJjFB2Blzf2jnBL/b+Aw1/tJOPcGm2K9FbB64KcV
	 eY0oLfp17xQ0BRnYc7QahvVc36AHwFEqvZCUQb4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgIJULp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbgIJO7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:59:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 374E12075A;
        Thu, 10 Sep 2020 14:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599749986;
        bh=VxQVC648qQ3aQ7KAntrOBMaixdukqiVVbKsy/UOgfbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVNBnRotKgVhSUvQ8fjuA/p57cW1gM3ixuT6H+i2fFWc0tBV1Kl6O8vv6UW26vTYC
         qOEtDdXT2U5Dhv5fAkDYxM4odfmArF5CqgTupH0rO9tvLu6uhulA+c6nv3QrFgitaj
         pqwgbtf58sVqHXdgFJSAjeYuvOopPRxRzQSjG8rs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 48FE240D3D; Thu, 10 Sep 2020 11:59:44 -0300 (-03)
Date:   Thu, 10 Sep 2020 11:59:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHv2] perf tools: Call test_attr__open directly
Message-ID: <20200910145944.GE4018363@kernel.org>
References: <20200827134830.126721-1-jolsa@kernel.org>
 <20200827134830.126721-2-jolsa@kernel.org>
 <20200827193201.GB127372@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827193201.GB127372@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 27, 2020 at 09:32:01PM +0200, Jiri Olsa escreveu:
> nack.. forgot python header change :-\ v2 attached
> 
> thanks,
> jirka

Thanks, applied.
 
> 
> ---
> There's no longer need to have test_attr__open inside
> sys_perf_event_open call, because both record and stat
> call evsel__open_cpu, so we can call it directly from
> there and not polute perf-sys.h header.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/perf-sys.h    | 22 ++--------------------
>  tools/perf/tests/attr.c  |  2 +-
>  tools/perf/util/evsel.c  |  5 +++++
>  tools/perf/util/python.c |  2 +-
>  tools/perf/util/util.h   |  6 ++++++
>  5 files changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/perf-sys.h b/tools/perf/perf-sys.h
> index 15e458e150bd..7a2264e1e4e1 100644
> --- a/tools/perf/perf-sys.h
> +++ b/tools/perf/perf-sys.h
> @@ -9,31 +9,13 @@
>  
>  struct perf_event_attr;
>  
> -extern bool test_attr__enabled;
> -void test_attr__ready(void);
> -void test_attr__init(void);
> -void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
> -		     int fd, int group_fd, unsigned long flags);
> -
> -#ifndef HAVE_ATTR_TEST
> -#define HAVE_ATTR_TEST 1
> -#endif
> -
>  static inline int
>  sys_perf_event_open(struct perf_event_attr *attr,
>  		      pid_t pid, int cpu, int group_fd,
>  		      unsigned long flags)
>  {
> -	int fd;
> -
> -	fd = syscall(__NR_perf_event_open, attr, pid, cpu,
> -		     group_fd, flags);
> -
> -#if HAVE_ATTR_TEST
> -	if (unlikely(test_attr__enabled))
> -		test_attr__open(attr, pid, cpu, fd, group_fd, flags);
> -#endif
> -	return fd;
> +	return syscall(__NR_perf_event_open, attr, pid, cpu,
> +		       group_fd, flags);
>  }
>  
>  #endif /* _PERF_SYS_H */
> diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
> index a9599ab8c471..ec972e0892ab 100644
> --- a/tools/perf/tests/attr.c
> +++ b/tools/perf/tests/attr.c
> @@ -30,9 +30,9 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <unistd.h>
> -#include "../perf-sys.h"
>  #include <subcmd/exec-cmd.h>
>  #include "event.h"
> +#include "util.h"
>  #include "tests.h"
>  
>  #define ENV "PERF_TEST_ATTR"
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index fd865002cbbd..6f0e23105cf8 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1680,6 +1680,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  			FD(evsel, cpu, thread) = fd;
>  
> +			if (unlikely(test_attr__enabled)) {
> +				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
> +						fd, group_fd, flags);
> +			}
> +
>  			if (fd < 0) {
>  				err = -errno;
>  
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 75a9b1d62bba..74f85948d101 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -17,7 +17,7 @@
>  #include "mmap.h"
>  #include "util/env.h"
>  #include <internal/lib.h>
> -#include "../perf-sys.h"
> +#include "util.h"
>  
>  #if PY_MAJOR_VERSION < 3
>  #define _PyUnicode_FromString(arg) \
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index f486fdd3a538..ad737052e597 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -62,4 +62,10 @@ char *perf_exe(char *buf, int len);
>  #endif
>  #endif
>  
> +extern bool test_attr__enabled;
> +void test_attr__ready(void);
> +void test_attr__init(void);
> +struct perf_event_attr;
> +void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
> +		     int fd, int group_fd, unsigned long flags);
>  #endif /* GIT_COMPAT_UTIL_H */
> -- 
> 2.26.2
> 

-- 

- Arnaldo
