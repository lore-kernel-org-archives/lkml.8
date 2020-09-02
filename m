Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB73C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B64206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrSEDcO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgIBSIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgIBSHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:07:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36EEC061246
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:07:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so397504wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4qfm/mcOO2TWYyfBbCDG0WKuTmG7F99Q7WZIH/wL9Y=;
        b=VrSEDcO4qKVqnX6Byx/aL0PK0aZCszLJ7yqFdjAa7n+bvN7UIMj3gqQv2t6HGddrTH
         pNpyspr0EP3dtGW6mn+UNfdkQovE1Bx7y2flv3c5nXX0UK8+pGD/zcGY8LcxcSu52IWv
         zuiR58zRQeAZiQ/0ej+2dE9gaqULxte7kH0JsLKMWj5SDwfNWPFn4bBdb46TL3ocTA22
         uu8629POqsNi4yq4KeeznKDeSkDaWk2jvvSy0Ez+Tf83frlMSgJY1FaoLEuBI0olrOCs
         QGx8nqz0SbhooSfFblrdf1TM2XyuvvR6T9xwgbxKg0N+T17H85CuuplDInMWm22oDyhB
         Xw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4qfm/mcOO2TWYyfBbCDG0WKuTmG7F99Q7WZIH/wL9Y=;
        b=gWKVx8Ex5qmqKb9e19RnuwmpsaOfDDy9cKl4PcYwCYRAgjbzR9WJL2GoQOJ4zo9V7c
         TpbHzXfpczTazynkpjhGgKVGMhoDQ+7/zVFOYewpDWxaV06ZuZHaFdfdV+NLmfKTc281
         DP92RDkRo+iCsXYsIAb8T2DaX7Dol3LEG03wGOlOlENi48rTcuGjC48+hhqz9GlFFdGH
         iv95KWkhxpE0lmlHXTvFtNw3Il2LBD/L7Tr4dRBa8Ngtq3p1le1E0MjImJqD2q0aviAu
         UxgUGQRdogfXoWOME8/sKTUmVpIcSxz3qy1dXfwkT/RwzMFuxBetwIChloSDCTtH4gsG
         iBnw==
X-Gm-Message-State: AOAM530EToqg8bmNIIzNX117ktUZ+88El6EnDV25jXudUM9UG3cuEHxv
        H+WD+58VpLA/Gk0imA14eBnTuxfiX8m+s+sBzKR0O5yG7c80fw==
X-Google-Smtp-Source: ABdhPJz/1uivLr+f8qhJGVYuUCiC3DbqUfIyvXH7O9UC1TAWzQ4hyyyHE/4gSVKBQnt0VDaJbIu7fKPz72JYmoNWlOU=
X-Received: by 2002:adf:f88b:: with SMTP id u11mr8050390wrp.376.1599070070103;
 Wed, 02 Sep 2020 11:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200828205614.3391252-1-robh@kernel.org> <20200828205614.3391252-6-robh@kernel.org>
In-Reply-To: <20200828205614.3391252-6-robh@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 2 Sep 2020 11:07:38 -0700
Message-ID: <CAP-5=fXTEd14wCZJgPyk1wUsSDAWP1zW+=e7sUx66L_1+YOO7A@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] libperf: Add support for user space counter access
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        honnappa.nagarahalli@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 1:56 PM Rob Herring <robh@kernel.org> wrote:
>
> x86 and arm64 can both support direct access of event counters in
> userspace. The access sequence is less than trivial and currently exists
> in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
> projects such as PAPI and libpfm4.
>
> In order to support usersapce access, an event must be mmapped. While
> there's already mmap support for evlist, the usecase is a bit different
> than the self monitoring with userspace access. So let's add a new
> perf_evsel__mmap() function to mmap an evsel. This allows implementing
> userspace access as a fastpath for perf_evsel__read().
>
> The mmapped address is returned by perf_evsel__mmap() primarily for
> users/tests to check if userspace access is enabled.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  tools/lib/perf/Documentation/libperf.txt |  1 +
>  tools/lib/perf/evsel.c                   | 33 +++++++++
>  tools/lib/perf/include/internal/evsel.h  |  2 +
>  tools/lib/perf/include/internal/mmap.h   |  3 +
>  tools/lib/perf/include/perf/evsel.h      |  1 +
>  tools/lib/perf/libperf.map               |  1 +
>  tools/lib/perf/mmap.c                    | 90 ++++++++++++++++++++++++
>  tools/lib/perf/tests/test-evsel.c        | 64 +++++++++++++++++
>  8 files changed, 195 insertions(+)
>
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index 0c74c30ed23a..ca7478acc97c 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -136,6 +136,7 @@ SYNOPSIS
>                         struct perf_thread_map *threads);
>    void perf_evsel__close(struct perf_evsel *evsel);
>    void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> +  void *perf_evsel__mmap(struct perf_evsel *evsel);
>    int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>                         struct perf_counts_values *count);
>    int perf_evsel__enable(struct perf_evsel *evsel);
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 4dc06289f4c7..b0c94ef4d9b6 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -11,10 +11,12 @@
>  #include <stdlib.h>
>  #include <internal/xyarray.h>
>  #include <internal/cpumap.h>
> +#include <internal/mmap.h>
>  #include <internal/threadmap.h>
>  #include <internal/lib.h>
>  #include <linux/string.h>
>  #include <sys/ioctl.h>
> +#include <sys/mman.h>
>
>  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
>  {
> @@ -156,6 +158,34 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
>         perf_evsel__close_fd_cpu(evsel, cpu);
>  }
>
> +void *perf_evsel__mmap(struct perf_evsel *evsel)
> +{
> +       int ret;
> +       struct perf_mmap *map;
> +       struct perf_mmap_param mp = {
> +               .mask = -1,
> +               .prot = PROT_READ | PROT_WRITE,
> +       };
> +
> +       if (FD(evsel, 0, 0) < 0)
> +               return NULL;
> +
> +       map = zalloc(sizeof(*map));
> +       if (!map)
> +               return NULL;
> +
> +       perf_mmap__init(map, NULL, false, NULL);
> +
> +       ret = perf_mmap__mmap(map, &mp, FD(evsel, 0, 0), 0);
> +       if (ret) {
> +               free(map);
> +               return NULL;
> +       }
> +
> +       evsel->mmap = map;
> +       return map->base;
> +}
> +
>  int perf_evsel__read_size(struct perf_evsel *evsel)
>  {
>         u64 read_format = evsel->attr.read_format;
> @@ -191,6 +221,9 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>         if (FD(evsel, cpu, thread) < 0)
>                 return -EINVAL;
>
> +       if (evsel->mmap && !perf_mmap__read_self(evsel->mmap, count))
> +               return 0;
> +
>         if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
>                 return -errno;
>
> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> index 1ffd083b235e..a7985dbb68ff 100644
> --- a/tools/lib/perf/include/internal/evsel.h
> +++ b/tools/lib/perf/include/internal/evsel.h
> @@ -9,6 +9,7 @@
>
>  struct perf_cpu_map;
>  struct perf_thread_map;
> +struct perf_mmap;
>  struct xyarray;
>
>  /*
> @@ -40,6 +41,7 @@ struct perf_evsel {
>         struct perf_cpu_map     *cpus;
>         struct perf_cpu_map     *own_cpus;
>         struct perf_thread_map  *threads;
> +       struct perf_mmap        *mmap;
>         struct xyarray          *fd;
>         struct xyarray          *sample_id;
>         u64                     *id;
> diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
> index be7556e0a2b2..5e3422f40ed5 100644
> --- a/tools/lib/perf/include/internal/mmap.h
> +++ b/tools/lib/perf/include/internal/mmap.h
> @@ -11,6 +11,7 @@
>  #define PERF_SAMPLE_MAX_SIZE (1 << 16)
>
>  struct perf_mmap;
> +struct perf_counts_values;
>
>  typedef void (*libperf_unmap_cb_t)(struct perf_mmap *map);
>
> @@ -52,4 +53,6 @@ void perf_mmap__put(struct perf_mmap *map);
>
>  u64 perf_mmap__read_head(struct perf_mmap *map);
>
> +int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count);
> +
>  #endif /* __LIBPERF_INTERNAL_MMAP_H */
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index c82ec39a4ad0..6d0da962870c 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -27,6 +27,7 @@ LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *
>                                  struct perf_thread_map *threads);
>  LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
>  LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> +LIBPERF_API void *perf_evsel__mmap(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>                                  struct perf_counts_values *count);
>  LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index 7be1af8a546c..733a0647be8b 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -23,6 +23,7 @@ LIBPERF_0.0.1 {
>                 perf_evsel__disable;
>                 perf_evsel__open;
>                 perf_evsel__close;
> +               perf_evsel__mmap;
>                 perf_evsel__read;
>                 perf_evsel__cpus;
>                 perf_evsel__threads;
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 79d5ed6c38cc..cb07969cfdbf 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -8,9 +8,11 @@
>  #include <linux/perf_event.h>
>  #include <perf/mmap.h>
>  #include <perf/event.h>
> +#include <perf/evsel.h>
>  #include <internal/mmap.h>
>  #include <internal/lib.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include "internal.h"
>
>  void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
> @@ -273,3 +275,91 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map)
>
>         return event;
>  }
> +
> +#if defined(__i386__) || defined(__x86_64__)
> +static u64 read_perf_counter(unsigned int counter)
> +{
> +       unsigned int low, high;
> +
> +       asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
> +
> +       return low | ((u64)high) << 32;
> +}
> +
> +static u64 read_timestamp(void)
> +{
> +       unsigned int low, high;
> +
> +       asm volatile("rdtsc" : "=a" (low), "=d" (high));
> +
> +       return low | ((u64)high) << 32;
> +}
> +#else
> +static u64 read_perf_counter(unsigned int counter) { return 0; }
> +static u64 read_timestamp(void) { return 0; }
> +#endif
> +
> +int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count)
> +{
> +       struct perf_event_mmap_page *pc = map->base;
> +       u32 seq, idx, time_mult = 0, time_shift = 0;
> +       u64 cnt, cyc = 0, time_offset = 0, time_cycles = 0, time_mask = ~0ULL;
> +
> +       BUG_ON(!pc);
> +
> +       if (!pc->cap_user_rdpmc)
> +               return -1;
> +
> +       do {
> +               seq = READ_ONCE(pc->lock);
> +               barrier();
> +
> +               count->ena = READ_ONCE(pc->time_enabled);
> +               count->run = READ_ONCE(pc->time_running);
> +
> +               if (pc->cap_user_time && count->ena != count->run) {
> +                       cyc = read_timestamp();
> +                       time_mult = READ_ONCE(pc->time_mult);
> +                       time_shift = READ_ONCE(pc->time_shift);
> +                       time_offset = READ_ONCE(pc->time_offset);
> +
> +                       if (pc->cap_user_time_short) {
> +                               time_cycles = READ_ONCE(pc->time_cycles);
> +                               time_mask = READ_ONCE(pc->time_mask);
> +                       }
> +               }
> +
> +               idx = READ_ONCE(pc->index);
> +               cnt = READ_ONCE(pc->offset);
> +               if (pc->cap_user_rdpmc && idx) {
> +                       u64 evcnt = read_perf_counter(idx - 1);
> +                       u16 width = READ_ONCE(pc->pmc_width);
> +
> +                       evcnt <<= 64 - width;
> +                       evcnt >>= 64 - width;
> +                       cnt += evcnt;
> +               } else
> +                       return -1;
> +
> +               barrier();
> +       } while (READ_ONCE(pc->lock) != seq);
> +
> +       if (count->ena != count->run) {

There's an existing bug here that I tried to resolve in this patch:
https://lore.kernel.org/lkml/CAP-5=fVRdqvswtyQMg5cB+ntTGda+SAYskjTQednEH-AeZo13g@mail.gmail.com/
Due to multiplexing, enabled may be > 0 but run == 0 and the divide
below can end up with divide by zero.

I like the idea of this code being in a library, there's an intent
that the perf_event.h and test code be copy-paste-able, but there is
some pre-existing divergence. It would be nice if this code could be
closer to the sample code in both the test and perf_event.h.

As per the change above, I think running and enabled times need to be
out arguments.

Thanks,
Ian

> +               u64 delta;
> +
> +               /* Adjust for cap_usr_time_short, a nop if not */
> +               cyc = time_cycles + ((cyc - time_cycles) & time_mask);
> +
> +               delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
> +
> +               count->ena += delta;
> +               if (idx)
> +                       count->run += delta;
> +
> +               cnt = mul_u64_u64_div64(cnt, count->ena, count->run);
> +       }
> +
> +       count->val = cnt;
> +
> +       return 0;
> +}
> diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> index 135722ac965b..fd637d23216b 100644
> --- a/tools/lib/perf/tests/test-evsel.c
> +++ b/tools/lib/perf/tests/test-evsel.c
> @@ -120,6 +120,68 @@ static int test_stat_thread_enable(void)
>         return 0;
>  }
>
> +static int test_stat_user_read(int event)
> +{
> +       struct perf_counts_values counts = { .val = 0 };
> +       struct perf_thread_map *threads;
> +       struct perf_evsel *evsel;
> +       struct perf_event_mmap_page *pc;
> +       struct perf_event_attr attr = {
> +               .type   = PERF_TYPE_HARDWARE,
> +               .config = event,
> +       };
> +       int err, i;
> +
> +       threads = perf_thread_map__new_dummy();
> +       __T("failed to create threads", threads);
> +
> +       perf_thread_map__set_pid(threads, 0, 0);
> +
> +       evsel = perf_evsel__new(&attr);
> +       __T("failed to create evsel", evsel);
> +
> +       err = perf_evsel__open(evsel, NULL, threads);
> +       __T("failed to open evsel", err == 0);
> +
> +       pc = perf_evsel__mmap(evsel);
> +       __T("failed to mmap evsel", pc);
> +
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +       __T("userspace counter access not supported", pc->cap_user_rdpmc);
> +       __T("userspace counter access not enabled", pc->index);
> +       __T("userspace counter width not set", pc->pmc_width >= 32);
> +#endif
> +
> +       perf_evsel__read(evsel, 0, 0, &counts);
> +       __T("failed to read value for evsel", counts.val != 0);
> +
> +       fputs("\n", stderr);
> +       for (i = 0; i < 5; i++) {
> +               volatile int count = 0x10000 << i;
> +               __u64 start, end, last = 0;
> +
> +               fprintf(stderr, "\tloop = %u, ", count);
> +
> +               perf_evsel__read(evsel, 0, 0, &counts);
> +               start = counts.val;
> +
> +               while (count--) ;
> +
> +               perf_evsel__read(evsel, 0, 0, &counts);
> +               end = counts.val;
> +
> +               __T("invalid counter data", (end - start) > last);
> +               last = end - start;
> +               fprintf(stderr, "count = %llu\n", end - start);
> +       }
> +
> +       perf_evsel__close(evsel);
> +       perf_evsel__delete(evsel);
> +
> +       perf_thread_map__put(threads);
> +       return 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>         __T_START;
> @@ -129,6 +191,8 @@ int main(int argc, char **argv)
>         test_stat_cpu();
>         test_stat_thread();
>         test_stat_thread_enable();
> +       test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
> +       test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
>
>         __T_END;
>         return 0;
> --
> 2.25.1
>
