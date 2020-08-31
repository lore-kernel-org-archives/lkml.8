Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32749C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003AC208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5X/bvUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHaJLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:11:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36050 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726244AbgHaJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598865095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2+Ja2lbFSkxj+MRurccbusOB7xYs/+ceOBnwJl/iGoI=;
        b=V5X/bvUHInO9RYoFAqf1PheA84Fwm8ScWdxAU0jrFVxNfn3OrjJXOqiRRKdoHdGtCFEfWf
        GGoHBToVyuxB9xfC0FObIWUrZGgUTIeIpzbUq5Qb4CtOZCZ4yenz384kHydro2BESvmyR4
        O1nDYDfPJgtsW6vzte3+uf2zT5OEmJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-S5DPE1G9MVC3IjMMdXsT8Q-1; Mon, 31 Aug 2020 05:11:31 -0400
X-MC-Unique: S5DPE1G9MVC3IjMMdXsT8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B730E75C;
        Mon, 31 Aug 2020 09:11:29 +0000 (UTC)
Received: from krava (unknown [10.40.193.236])
        by smtp.corp.redhat.com (Postfix) with SMTP id AB30D702F7;
        Mon, 31 Aug 2020 09:11:25 +0000 (UTC)
Date:   Mon, 31 Aug 2020 11:11:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: Re: [PATCH v2 5/9] libperf: Add support for user space counter access
Message-ID: <20200831091123.GB406859@krava>
References: <20200828205614.3391252-1-robh@kernel.org>
 <20200828205614.3391252-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828205614.3391252-6-robh@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 02:56:10PM -0600, Rob Herring wrote:

SNIP

>  #endif /* __LIBPERF_INTERNAL_MMAP_H */
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index c82ec39a4ad0..6d0da962870c 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -27,6 +27,7 @@ LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *
>  				 struct perf_thread_map *threads);
>  LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
>  LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> +LIBPERF_API void *perf_evsel__mmap(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>  				 struct perf_counts_values *count);
>  LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index 7be1af8a546c..733a0647be8b 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -23,6 +23,7 @@ LIBPERF_0.0.1 {
>  		perf_evsel__disable;
>  		perf_evsel__open;
>  		perf_evsel__close;
> +		perf_evsel__mmap;
>  		perf_evsel__read;
>  		perf_evsel__cpus;
>  		perf_evsel__threads;

please put perf_evsel__mmap changes into separate patch

SNIP

> +int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count)
> +{
> +	struct perf_event_mmap_page *pc = map->base;
> +	u32 seq, idx, time_mult = 0, time_shift = 0;
> +	u64 cnt, cyc = 0, time_offset = 0, time_cycles = 0, time_mask = ~0ULL;
> +
> +	BUG_ON(!pc);
> +
> +	if (!pc->cap_user_rdpmc)
> +		return -1;
> +
> +	do {
> +		seq = READ_ONCE(pc->lock);
> +		barrier();
> +
> +		count->ena = READ_ONCE(pc->time_enabled);
> +		count->run = READ_ONCE(pc->time_running);
> +
> +		if (pc->cap_user_time && count->ena != count->run) {
> +			cyc = read_timestamp();
> +			time_mult = READ_ONCE(pc->time_mult);
> +			time_shift = READ_ONCE(pc->time_shift);
> +			time_offset = READ_ONCE(pc->time_offset);
> +
> +			if (pc->cap_user_time_short) {
> +				time_cycles = READ_ONCE(pc->time_cycles);
> +				time_mask = READ_ONCE(pc->time_mask);
> +			}
> +		}
> +
> +		idx = READ_ONCE(pc->index);
> +		cnt = READ_ONCE(pc->offset);
> +		if (pc->cap_user_rdpmc && idx) {

no need to check pc->cap_user_rdpmc again

> +static int test_stat_user_read(int event)
> +{
> +	struct perf_counts_values counts = { .val = 0 };
> +	struct perf_thread_map *threads;
> +	struct perf_evsel *evsel;
> +	struct perf_event_mmap_page *pc;
> +	struct perf_event_attr attr = {
> +		.type	= PERF_TYPE_HARDWARE,
> +		.config	= event,
> +	};
> +	int err, i;
> +
> +	threads = perf_thread_map__new_dummy();
> +	__T("failed to create threads", threads);
> +
> +	perf_thread_map__set_pid(threads, 0, 0);
> +
> +	evsel = perf_evsel__new(&attr);
> +	__T("failed to create evsel", evsel);
> +
> +	err = perf_evsel__open(evsel, NULL, threads);
> +	__T("failed to open evsel", err == 0);
> +
> +	pc = perf_evsel__mmap(evsel);
> +	__T("failed to mmap evsel", pc);
> +
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +	__T("userspace counter access not supported", pc->cap_user_rdpmc);
> +	__T("userspace counter access not enabled", pc->index);
> +	__T("userspace counter width not set", pc->pmc_width >= 32);
> +#endif
> +
> +	perf_evsel__read(evsel, 0, 0, &counts);
> +	__T("failed to read value for evsel", counts.val != 0);
> +
> +	fputs("\n", stderr);
> +	for (i = 0; i < 5; i++) {
> +		volatile int count = 0x10000 << i;
> +		__u64 start, end, last = 0;
> +
> +		fprintf(stderr, "\tloop = %u, ", count);

we should add support to display verbose output for tests,
because right now this breaks the output:

- running test-cpumap.c...OK
- running test-threadmap.c...OK
- running test-evlist.c...OK
- running test-evsel.c...
        loop = 65536, count = 328035
        loop = 131072, count = 655715
        loop = 262144, count = 1311075
        loop = 524288, count = 2627060
        loop = 1048576, count = 5253540

        loop = 65536, count = 327594
        loop = 131072, count = 659930
        loop = 262144, count = 1378892
        loop = 524288, count = 2664341
        loop = 1048576, count = 5365682
OK

but we can do it in separate change later

thanks,
jirka

