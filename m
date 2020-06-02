Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CBEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DF6206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFZuHwx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgFBVxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgFBVxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:53:16 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F93C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:53:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d7so12544713ioq.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKk/50km335wP5vYExKHj8LF75uWPnrWjyE59PhAFDw=;
        b=aFZuHwx5e1aDmo3x5/6O0f6louCN4buh/3DU6L5G8IPotwB25Tx2wTBsqrcy59mJIM
         Ok9kuVzwd8gdQIWkxP4hvbjvyQ1G0/msj7GGV1HKUtOLsdvM+jQuXhQR+JMKHiHyZyaL
         hykzo/edcOqt8KBoTl19bqBu/Tu+aJNa6+ja3Ljcl8GDcr/1CKbAHMcpkFBB7Zi61SSW
         5FfuZnmmd2hoye7Q5GblXmaBYS3jSDMortOG1y0OpZPoT9fefeHvc4cArsCedMUFzRI+
         lNcjtw85gcvuuY5qZsPfBBEcR2yNIOo57bBP+r2QWHDqs4kSI6QOE7Ddzz1aUaiYvftp
         SHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKk/50km335wP5vYExKHj8LF75uWPnrWjyE59PhAFDw=;
        b=mnCT/z8gfabzzcnBeWqwiLcWZ2nUr51W6IsH40Zj9fZi2TITxlK7OIyatBprxYiTSN
         1lGkGTqRVePqEw1LRO+uajq9F+YdDsV0amIjnMpfgeGvgkphVJsfLqmgqaXOPFynazSe
         vvRoo6VWvvYETVKhYF4By5vAUoN2iFeYPbT/TG9ueA91hQ6+N0EEKDRW0ZIGDKLs7wvE
         62eP212hmx0ZoNo4J7ZZm91gBNLiLsUEipRNX367SJz7oaaT4paSBE0j3UeYn8SeQUR6
         2FOnPPZUicHYrwMt+RPujEULldzwLVDo27cRpOrc7e8lVn6gOn0zJD1RKVjTjbw4xSDE
         91rg==
X-Gm-Message-State: AOAM530VBqrN8ACcnX6rRqnXMuyLEvRmRpx8Gt1y1Xk+rPg5f3+qt2Dy
        NX5+Xyid/f1ariru/bk2y8FXZpqGC5vuDtfk+K5Xjw==
X-Google-Smtp-Source: ABdhPJwK1gEygjIDHmHj+Z7wt3ksysqmkxnd7ELfYmPc4KxLR8NccueJ6iAkyWhc/DWpqV+goCTP8TPvKnFgeQkUfYc=
X-Received: by 2002:a6b:6414:: with SMTP id t20mr1205986iog.32.1591134795058;
 Tue, 02 Jun 2020 14:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200429190819.64235-1-irogers@google.com>
In-Reply-To: <20200429190819.64235-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 Jun 2020 14:53:03 -0700
Message-ID: <CAP-5=fVRdqvswtyQMg5cB+ntTGda+SAYskjTQednEH-AeZo13g@mail.gmail.com>
Subject: Re: [PATCH v3] perf test x86: address multiplexing in rdpmc test
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:08 PM Ian Rogers <irogers@google.com> wrote:
>
> Counters may be being used for pinned or other events which inhibit the
> instruction counter in the test from being scheduled - time_enabled > 0
> but time_running == 0. This causes the test to fail with division by 0.
> Make time_running and enabled out parameters of mmap_read_self and add a
> sleep loop to ensure that the counter is running before computing the
> delta.

Ping. Peter does this address your feedback?

Thanks,
Ian

> v3. Cleans up the code by adding a single scale_count boolean. It aligns
>     the code with the comments in perf_event.h as suggested by Peter
>     Zijlstra.
> v2. Address review feedback from Peter Zijlstra.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/uapi/linux/perf_event.h       | 34 +++++++-----
>  tools/include/uapi/linux/perf_event.h | 34 +++++++-----
>  tools/perf/arch/x86/tests/rdpmc.c     | 80 +++++++++++++++++++--------
>  3 files changed, 98 insertions(+), 50 deletions(-)
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 7b2d6fc9e6ed..4936cce0a6d0 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -488,19 +488,22 @@ struct perf_event_mmap_page {
>         /*
>          * Bits needed to read the hw events in user-space.
>          *
> -        *   u32 seq, time_mult, time_shift, index, width;
> -        *   u64 count, enabled, running;
> -        *   u64 cyc, time_offset;
> -        *   s64 pmc = 0;
> +        *   u32 seq, time_mult, time_shift, index;
> +        *   u64 cyc, time_offset, enabled, running = -1;
> +        *   s64 count = 0;
> +        *   bool scale_count = false;
>          *
>          *   do {
>          *     seq = pc->lock;
> -        *     barrier()
> +        *     barrier();
>          *
> -        *     enabled = pc->time_enabled;
> -        *     running = pc->time_running;
> +        *     if (pc->cap_user_time) {
> +        *       enabled = pc->time_enabled;
> +        *       running = pc->time_running;
> +        *       scale_count = enabled != running && running != 0;
> +        *     }
>          *
> -        *     if (pc->cap_usr_time && enabled != running) {
> +        *     if (scale_count) {
>          *       cyc = rdtsc();
>          *       time_offset = pc->time_offset;
>          *       time_mult   = pc->time_mult;
> @@ -509,9 +512,13 @@ struct perf_event_mmap_page {
>          *
>          *     index = pc->index;
>          *     count = pc->offset;
> -        *     if (pc->cap_user_rdpmc && index) {
> -        *       width = pc->pmc_width;
> -        *       pmc = rdpmc(index - 1);
> +        *     if (pc->cap_user_rdpmc && index && running != 0) {
> +        *       u16 width = pc->pmc_width;
> +        *       s64 pmc = rdpmc(index - 1);
> +        *
> +        *       pmc <<= 64 - width;
> +        *       pmc >>= 64 - width;  // signed shift right
> +        *       count += pmc;
>          *     }
>          *
>          *     barrier();
> @@ -562,8 +569,9 @@ struct perf_event_mmap_page {
>          *              ((rem * time_mult) >> time_shift);
>          *
>          * Where time_offset,time_mult,time_shift and cyc are read in the
> -        * seqcount loop described above. This delta can then be added to
> -        * enabled and possible running (if index), improving the scaling:
> +        * seqcount loop described above when scale_count is true. This delta
> +        * can then be added to enabled and possible running (if index),
> +        * improving the scaling:
>          *
>          *   enabled += delta;
>          *   if (index)
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 7b2d6fc9e6ed..4936cce0a6d0 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -488,19 +488,22 @@ struct perf_event_mmap_page {
>         /*
>          * Bits needed to read the hw events in user-space.
>          *
> -        *   u32 seq, time_mult, time_shift, index, width;
> -        *   u64 count, enabled, running;
> -        *   u64 cyc, time_offset;
> -        *   s64 pmc = 0;
> +        *   u32 seq, time_mult, time_shift, index;
> +        *   u64 cyc, time_offset, enabled, running = -1;
> +        *   s64 count = 0;
> +        *   bool scale_count = false;
>          *
>          *   do {
>          *     seq = pc->lock;
> -        *     barrier()
> +        *     barrier();
>          *
> -        *     enabled = pc->time_enabled;
> -        *     running = pc->time_running;
> +        *     if (pc->cap_user_time) {
> +        *       enabled = pc->time_enabled;
> +        *       running = pc->time_running;
> +        *       scale_count = enabled != running && running != 0;
> +        *     }
>          *
> -        *     if (pc->cap_usr_time && enabled != running) {
> +        *     if (scale_count) {
>          *       cyc = rdtsc();
>          *       time_offset = pc->time_offset;
>          *       time_mult   = pc->time_mult;
> @@ -509,9 +512,13 @@ struct perf_event_mmap_page {
>          *
>          *     index = pc->index;
>          *     count = pc->offset;
> -        *     if (pc->cap_user_rdpmc && index) {
> -        *       width = pc->pmc_width;
> -        *       pmc = rdpmc(index - 1);
> +        *     if (pc->cap_user_rdpmc && index && running != 0) {
> +        *       u16 width = pc->pmc_width;
> +        *       s64 pmc = rdpmc(index - 1);
> +        *
> +        *       pmc <<= 64 - width;
> +        *       pmc >>= 64 - width;  // signed shift right
> +        *       count += pmc;
>          *     }
>          *
>          *     barrier();
> @@ -562,8 +569,9 @@ struct perf_event_mmap_page {
>          *              ((rem * time_mult) >> time_shift);
>          *
>          * Where time_offset,time_mult,time_shift and cyc are read in the
> -        * seqcount loop described above. This delta can then be added to
> -        * enabled and possible running (if index), improving the scaling:
> +        * seqcount loop described above when scale_count is true. This delta
> +        * can then be added to enabled and possible running (if index),
> +        * improving the scaling:
>          *
>          *   enabled += delta;
>          *   if (index)
> diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
> index 1ea916656a2d..93e1770d03d3 100644
> --- a/tools/perf/arch/x86/tests/rdpmc.c
> +++ b/tools/perf/arch/x86/tests/rdpmc.c
> @@ -16,13 +16,13 @@
>  #include <internal/lib.h> // page_size
>  #include "arch-tests.h"
>
> -static u64 rdpmc(unsigned int counter)
> +static s64 rdpmc(unsigned int counter)
>  {
>         unsigned int low, high;
>
>         asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
>
> -       return low | ((u64)high) << 32;
> +       return low | ((s64)high) << 32;
>  }
>
>  static u64 rdtsc(void)
> @@ -34,49 +34,67 @@ static u64 rdtsc(void)
>         return low | ((u64)high) << 32;
>  }
>
> -static u64 mmap_read_self(void *addr)
> +/*
> + * Return a user rdpmc result as well as the time enabled and running. In the
> + * situation that the counter was ran and the kernel is multiplexing events, the
> + * counter is scaled.
> + */
> +static s64 mmap_read_self(void *addr, u64 *enabled, u64 *running)
>  {
>         struct perf_event_mmap_page *pc = addr;
> -       u32 seq, idx, time_mult = 0, time_shift = 0;
> -       u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
> +       u32 seq, time_mult = 0, time_shift = 0, index;
> +       u64 cyc = 0, time_offset = 0;
> +       s64 count = 0;
> +       bool scale_count = false;
>
> +       *enabled = -1;
> +       *running = -1;
>         do {
>                 seq = pc->lock;
>                 barrier();
>
> -               enabled = pc->time_enabled;
> -               running = pc->time_running;
> +               if (pc->cap_user_time) {
> +                       *enabled = pc->time_enabled;
> +                       *running = pc->time_running;
> +                       scale_count = *enabled != *running && *running != 0;
> +               }
>
> -               if (enabled != running) {
> +               if (scale_count) {
>                         cyc = rdtsc();
>                         time_mult = pc->time_mult;
>                         time_shift = pc->time_shift;
>                         time_offset = pc->time_offset;
>                 }
>
> -               idx = pc->index;
> +               index = pc->index;
>                 count = pc->offset;
> -               if (idx)
> -                       count += rdpmc(idx - 1);
> +               if (pc->cap_user_rdpmc && index && *running != 0) {
> +                       u16 width = pc->pmc_width;
> +                       s64 pmc = rdpmc(index - 1);
> +
> +                       pmc <<= 64 - width;
> +                       pmc >>= 64 - width;  // signed shift right
> +                       count += pmc;
> +               }
>
>                 barrier();
>         } while (pc->lock != seq);
>
> -       if (enabled != running) {
> -               u64 quot, rem;
> +       if (scale_count) {
> +               u64 quot, rem, delta;
>
>                 quot = (cyc >> time_shift);
>                 rem = cyc & (((u64)1 << time_shift) - 1);
>                 delta = time_offset + quot * time_mult +
>                         ((rem * time_mult) >> time_shift);
>
> -               enabled += delta;
> -               if (idx)
> -                       running += delta;
> +               *enabled += delta;
> +               if (index)
> +                       *running += delta;
>
> -               quot = count / running;
> -               rem = count % running;
> -               count = quot * enabled + (rem * enabled) / running;
> +               quot = count / *running;
> +               rem = count % *running;
> +               count = quot * *enabled + (rem * *enabled) / *running;
>         }
>
>         return count;
> @@ -104,7 +122,7 @@ static int __test__rdpmc(void)
>                 .config = PERF_COUNT_HW_INSTRUCTIONS,
>                 .exclude_kernel = 1,
>         };
> -       u64 delta_sum = 0;
> +       u64 delta_sum = 0, sleep_count = 0;
>          struct sigaction sa;
>         char sbuf[STRERR_BUFSIZE];
>
> @@ -130,14 +148,23 @@ static int __test__rdpmc(void)
>         }
>
>         for (n = 0; n < 6; n++) {
> -               u64 stamp, now, delta;
> -
> -               stamp = mmap_read_self(addr);
> +               u64 stamp, now, delta, enabled, running;
> +
> +               for (;;) {
> +                       stamp = mmap_read_self(addr, &enabled, &running);
> +                       if (enabled && running)
> +                               break;
> +                       /* Try to wait for event to be running. */
> +                       sleep_count++;
> +                       if (sleep_count > 20)
> +                               goto out_never_run;
> +                       sleep(1);
> +               }
>
>                 for (i = 0; i < loops; i++)
>                         tmp++;
>
> -               now = mmap_read_self(addr);
> +               now = mmap_read_self(addr, &enabled, &running);
>                 loops *= 10;
>
>                 delta = now - stamp;
> @@ -155,6 +182,11 @@ static int __test__rdpmc(void)
>                 return -1;
>
>         return 0;
> +
> +out_never_run:
> +       close(fd);
> +       pr_err("Event counter failed to multiplexed in. Are higher priority counters being sampled by a different process?\n");
> +       return -1;
>  }
>
>  int test__rdpmc(struct test *test __maybe_unused, int subtest __maybe_unused)
> --
> 2.26.2.303.gf8c07b1a785-goog
>
