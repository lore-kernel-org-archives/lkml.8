Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17925C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B9E208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599066027;
	bh=9sBHcuRcepXfRVr1C3OYqQw0Qs7jDe3Ezpq7YV00SDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RyGQer0xgcDuf8xylvVgBghwSUqBTTV6y9B072cywVt531edZ9boIRwS9Uwu+gsvA
	 E3elICuF50W7ooTcii6a7K8jPODNPHYDoXjZe/BHNPee8zTIPhyQNlY/Y450wVtEpG
	 mxSxu17UuxDJciXdMwm3doMZ48WCamkUdVoN1n5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgIBRAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbgIBQ6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:58:47 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 499E5208CA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599065926;
        bh=9sBHcuRcepXfRVr1C3OYqQw0Qs7jDe3Ezpq7YV00SDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rECrCV9I9p0WaYyZmDZu7jX0RrNbNJNB/qAyme60YcvGp5GYUPMkiX0pLlh3LSnoh
         OeSu85Yy3VsMPdk2BoXHWKH6v7m5cX5802/pYgGZt63nCT6Q2D/9iDqqjkAEqPaGHG
         ql2oSaHRPxA4T2/E8rfsQg+SUjYnIcxZCVO141Gw=
Received: by mail-ot1-f43.google.com with SMTP id v16so4872999otp.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:58:46 -0700 (PDT)
X-Gm-Message-State: AOAM5327mSjViF4Gn8V7NbNAHliFsYaa+nrfVhP/2FA2h9iJtDAdyOJS
        0lG4+e8QeuQXH2sc8CAYHuYyfzvU1z3z+E9hLg==
X-Google-Smtp-Source: ABdhPJwLslJyX+kBLbx+GX6LBVNvriQ+kCK1XYqDIYbc9dyVrh4HImeKW/9KxZAf9ajRVyhq5b5Gh0V4SxU7SIu7bkM=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr1615812otp.129.1599065925544;
 Wed, 02 Sep 2020 09:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200828205614.3391252-1-robh@kernel.org> <20200828205614.3391252-6-robh@kernel.org>
 <20200831091123.GB406859@krava>
In-Reply-To: <20200831091123.GB406859@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 2 Sep 2020 10:58:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rrQWObtaTQpoxjJbFJeWPf5VxnOZyp6pZzZcb3Ybv+w@mail.gmail.com>
Message-ID: <CAL_Jsq+rrQWObtaTQpoxjJbFJeWPf5VxnOZyp6pZzZcb3Ybv+w@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] libperf: Add support for user space counter access
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 3:11 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Aug 28, 2020 at 02:56:10PM -0600, Rob Herring wrote:
>
> SNIP


> > +int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count)
> > +{
> > +     struct perf_event_mmap_page *pc = map->base;
> > +     u32 seq, idx, time_mult = 0, time_shift = 0;
> > +     u64 cnt, cyc = 0, time_offset = 0, time_cycles = 0, time_mask = ~0ULL;
> > +
> > +     BUG_ON(!pc);
> > +
> > +     if (!pc->cap_user_rdpmc)
> > +             return -1;
> > +
> > +     do {
> > +             seq = READ_ONCE(pc->lock);
> > +             barrier();
> > +
> > +             count->ena = READ_ONCE(pc->time_enabled);
> > +             count->run = READ_ONCE(pc->time_running);
> > +
> > +             if (pc->cap_user_time && count->ena != count->run) {
> > +                     cyc = read_timestamp();
> > +                     time_mult = READ_ONCE(pc->time_mult);
> > +                     time_shift = READ_ONCE(pc->time_shift);
> > +                     time_offset = READ_ONCE(pc->time_offset);
> > +
> > +                     if (pc->cap_user_time_short) {
> > +                             time_cycles = READ_ONCE(pc->time_cycles);
> > +                             time_mask = READ_ONCE(pc->time_mask);
> > +                     }
> > +             }
> > +
> > +             idx = READ_ONCE(pc->index);
> > +             cnt = READ_ONCE(pc->offset);
> > +             if (pc->cap_user_rdpmc && idx) {
>
> no need to check pc->cap_user_rdpmc again

I was thinking cap_user_rdpmc could change, but I guess idx will
always be 0 in that case.

> > +static int test_stat_user_read(int event)
> > +{
> > +     struct perf_counts_values counts = { .val = 0 };
> > +     struct perf_thread_map *threads;
> > +     struct perf_evsel *evsel;
> > +     struct perf_event_mmap_page *pc;
> > +     struct perf_event_attr attr = {
> > +             .type   = PERF_TYPE_HARDWARE,
> > +             .config = event,
> > +     };
> > +     int err, i;
> > +
> > +     threads = perf_thread_map__new_dummy();
> > +     __T("failed to create threads", threads);
> > +
> > +     perf_thread_map__set_pid(threads, 0, 0);
> > +
> > +     evsel = perf_evsel__new(&attr);
> > +     __T("failed to create evsel", evsel);
> > +
> > +     err = perf_evsel__open(evsel, NULL, threads);
> > +     __T("failed to open evsel", err == 0);
> > +
> > +     pc = perf_evsel__mmap(evsel);
> > +     __T("failed to mmap evsel", pc);
> > +
> > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > +     __T("userspace counter access not supported", pc->cap_user_rdpmc);
> > +     __T("userspace counter access not enabled", pc->index);
> > +     __T("userspace counter width not set", pc->pmc_width >= 32);
> > +#endif
> > +
> > +     perf_evsel__read(evsel, 0, 0, &counts);
> > +     __T("failed to read value for evsel", counts.val != 0);
> > +
> > +     fputs("\n", stderr);
> > +     for (i = 0; i < 5; i++) {
> > +             volatile int count = 0x10000 << i;
> > +             __u64 start, end, last = 0;
> > +
> > +             fprintf(stderr, "\tloop = %u, ", count);
>
> we should add support to display verbose output for tests,
> because right now this breaks the output:
>
> - running test-cpumap.c...OK
> - running test-threadmap.c...OK
> - running test-evlist.c...OK
> - running test-evsel.c...
>         loop = 65536, count = 328035
>         loop = 131072, count = 655715
>         loop = 262144, count = 1311075
>         loop = 524288, count = 2627060
>         loop = 1048576, count = 5253540
>
>         loop = 65536, count = 327594
>         loop = 131072, count = 659930
>         loop = 262144, count = 1378892
>         loop = 524288, count = 2664341
>         loop = 1048576, count = 5365682
> OK
>
> but we can do it in separate change later

Would you like me to just comment this out then for now?

Rob
