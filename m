Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC32C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 00:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA392072E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 00:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTx2563M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgCWAPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 20:15:02 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41465 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgCWAPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 20:15:02 -0400
Received: by mail-yb1-f195.google.com with SMTP id d5so6123164ybs.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjwtgGcC/0RJG3cr8UqxohiTqm2F7O5fvhFKgL5z6C8=;
        b=RTx2563MXcqpw37mQqC7toeXapCiDjIHacqda8ty1fmBVVoU0deczhxsWb539dYMfd
         mzPf0MKMX59nxzwOVPjdStSrDuJzz1cDS8eKk/d17iCIVwqpaRqOx1koIuyoIvHD5cWJ
         rdE87FayVbB6SfJNsldjPZMuPsORO8yYO54qVnCZK5Ux3LZYDHhRNGWJonKvFcLk2OOs
         A1HqVKX8ephFuqGOVgvWYcVPv49Riede5ES0WQlwr8z+VZjTokjCX2t30oVH6gr8b3Fn
         ZUWzgC1XnQHPIufaOrnJ7XPPt62fMnMX4KevxuTnNkuSU2SrGt7mDlOTfZ316+3IROHj
         8Oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjwtgGcC/0RJG3cr8UqxohiTqm2F7O5fvhFKgL5z6C8=;
        b=QrpA49NcgJL2q0FxRc7bD0JPqKLPqf6AQLYt5ZUZo0SAOuhIzJqWi/1AyLJTrZkQXQ
         GuXU9bognNOa0CNiOMshZ0UwL58yowMviu5YEvMAB+cwMCLFS5PJG0Zg/Virz/9rzTMn
         H4T4vhfk7w6PqgCtC0Da5scoT/hnvVN8Fzd0Oif7XlvGizg0YnJj7BlRlhVtwuZSiYhF
         fFazcj8pbNga/Ohglp0q4WN/np9hCJ4pAJiCdfI2FjJE9HBvTyU/s1XRTf2SiVlBFXAm
         zo/cOY2hGgAGJDrPW2kNSVTGmCYTeTWc232EDAoCvm10Ug+Bem+yddSMW8KmbAR5ydp4
         jTKQ==
X-Gm-Message-State: ANhLgQ3X9kUXw13qZpfKyxvd1KsFX+nknPSrL1rEJGP5TnLAfbEWH6YV
        FL0SUGh0narmaZn8fyzVaNqZqlWYAO/sGKTqK70kgw==
X-Google-Smtp-Source: ADFU+vuxDfqQobzDMsyzocv+6N7EDuINMZuiO1pFqzqKYMSqXE8ypSfr5UezmIQnGJZhiFSrx1x5JzRsAl3IUAvqR7E=
X-Received: by 2002:a25:b0a1:: with SMTP id f33mr27670771ybj.403.1584922498432;
 Sun, 22 Mar 2020 17:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200321173710.127770-1-irogers@google.com> <20200322101848.GF2452@worktop.programming.kicks-ass.net>
In-Reply-To: <20200322101848.GF2452@worktop.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 22 Mar 2020 17:14:47 -0700
Message-ID: <CAP-5=fWf84C4YdXVMWLBG0_mtJeOxns+iOS6Sf0S-cHbJQGqDA@mail.gmail.com>
Subject: Re: [PATCH v2] perf test x86: address multiplexing in rdpmc test
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 3:18 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Mar 21, 2020 at 10:37:10AM -0700, Ian Rogers wrote:
>
> > +static u64 mmap_read_self(void *addr, u64 *running)
> >  {
> >       struct perf_event_mmap_page *pc = addr;
> >       u32 seq, idx, time_mult = 0, time_shift = 0;
> > -     u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
> > +     u64 count, cyc = 0, time_offset = 0, enabled, delta;
> >
> >       do {
> >               seq = pc->lock;
> >               barrier();
> >
> >               enabled = pc->time_enabled;
> > -             running = pc->time_running;
> > -
> > -             if (enabled != running) {
> > +             *running = pc->time_running;
> > +
> > +             if (*running == 0) {
> > +                     /*
> > +                      * Counter won't have a value as due to multiplexing the
> > +                      * event wasn't scheduled.
> > +                      */
> > +                     return 0;
> > +             }
>
> I still think adding code for an error case here is a bad idea. And only
> passing running as an argument is inconsistent.
>
> Also, then I had a look at what the compiler made of that function and
> cried.
>
> Here's something a little better. Much of it copied from linux/math64.h
> and asm/div64.h.
>
> ---
> diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
> index 1ea916656a2d..386a6dacb21e 100644
> --- a/tools/perf/arch/x86/tests/rdpmc.c
> +++ b/tools/perf/arch/x86/tests/rdpmc.c
> @@ -34,20 +34,98 @@ static u64 rdtsc(void)
>         return low | ((u64)high) << 32;
>  }
>
> -static u64 mmap_read_self(void *addr)
> +#ifdef __x86_64__
> +static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
> +{
> +       u64 q;
> +
> +       asm ("mulq %2; divq %3" : "=a" (q)
> +                               : "a" (a), "rm" (b), "rm" (c)
> +                               : "rdx");
> +
> +       return q;
> +}
> +#define mul_u64_u64_div64 mul_u64_u64_div64
> +#endif
> +
> +#ifdef __SIZEOF_INT128__
> +
> +static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
> +{
> +       return (u64)(((unsigned __int128)a * b) >> shift);
> +}
> +
> +#ifndef mul_u64_u64_div64
> +static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
> +{
> +       unsigned __int128 m = a;
> +       m *= b;
> +       return m / c;
> +}
> +#endif
> +
> +#else
> +
> +#ifdef __i386__
> +static inline u64 mul_u32_u32(u32 a, u32 b)
> +{
> +       u32 high, low;
> +
> +       asm ("mull %[b]" : "=a" (low), "=d" (high)
> +                        : [a] "a" (a), [b] "rm" (b) );
> +
> +       return low | ((u64)high) << 32;
> +}
> +#else
> +static inline u64 mul_u32_u32(u32 a, u32 b)
> +{
> +       return (u64)a * b;
> +}
> +#endif
> +
> +static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
> +{
> +       u32 ah, al;
> +       u64 ret;
> +
> +       al = a;
> +       ah = a >> 32;
> +
> +       ret = mul_u32_u32(al, mul) >> shift;
> +       if (ah)
> +               ret += mul_u32_u32(ah, mul) << (32 - shift);
> +
> +       return ret;
> +}
> +
> +#ifndef mul_u64_u64_div64
> +static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
> +{
> +       u64 quot, rem;
> +
> +       quot = a / c;
> +       rem = a % c;
> +
> +       return qout * b + (rem * b) / c;
> +}
> +#endif
> +
> +#endif
> +
> +static u64 mmap_read_self(void *addr, u64 *enabled, u64 *running)
>  {
>         struct perf_event_mmap_page *pc = addr;
>         u32 seq, idx, time_mult = 0, time_shift = 0;
> -       u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
> +       u64 count, cyc = 0, time_offset = 0;
>
>         do {
>                 seq = pc->lock;
>                 barrier();
>
> -               enabled = pc->time_enabled;
> -               running = pc->time_running;
> +               *enabled = pc->time_enabled;
> +               *running = pc->time_running;
>
> -               if (enabled != running) {
> +               if (*enabled != *running) {
>                         cyc = rdtsc();
>                         time_mult = pc->time_mult;
>                         time_shift = pc->time_shift;
> @@ -62,21 +140,13 @@ static u64 mmap_read_self(void *addr)
>                 barrier();
>         } while (pc->lock != seq);
>
> -       if (enabled != running) {
> -               u64 quot, rem;
> -
> -               quot = (cyc >> time_shift);
> -               rem = cyc & (((u64)1 << time_shift) - 1);
> -               delta = time_offset + quot * time_mult +
> -                       ((rem * time_mult) >> time_shift);
> -
> -               enabled += delta;
> +       if (*enabled != *running) {
> +               u64 delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
> +               *enabled += delta;
>                 if (idx)
> -                       running += delta;
> +                       *running += delta;
>
> -               quot = count / running;
> -               rem = count % running;
> -               count = quot * enabled + (rem * enabled) / running;
> +               count = mul_u64_u64_div64(count, *enabled, *running);

*running may be 0 here, because of multiplexing, and so it will yield a SIGFPE.

>         }
>
>         return count;
> @@ -130,14 +200,18 @@ static int __test__rdpmc(void)
>         }
>
>         for (n = 0; n < 6; n++) {
> -               u64 stamp, now, delta;
> +               u64 stamp, now, delta, enabled, running;
>
> -               stamp = mmap_read_self(addr);
> +               stamp = mmap_read_self(addr, &enabled, &running);
>
>                 for (i = 0; i < loops; i++)
>                         tmp++;
>
> -               now = mmap_read_self(addr);
> +               now = mmap_read_self(addr, &enabled, &running);
> +
> +               if (enabled && !running)
> +                       goto out_error;
> +
>                 loops *= 10;
>
>                 delta = now - stamp;
> @@ -155,6 +229,11 @@ static int __test__rdpmc(void)
>                 return -1;
>
>         return 0;
> +
> +out_error:
> +       close(fd);
> +       pr_err("counter never ran; you loose\n");
> +       return -1;

I'd prefer to retry in this case as I'm not running the test on an
isolated machine. Perhaps -2 (TEST_SKIP) rather than -1 (TEST_FAIL),
some kind of resource not available error would be better.

Thanks,
Ian

>  }
>
>  int test__rdpmc(struct test *test __maybe_unused, int subtest __maybe_unused)
>
