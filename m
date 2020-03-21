Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBACC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 17:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111EA206F9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 17:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQB3sN3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCURpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 13:45:03 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38347 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgCURpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 13:45:02 -0400
Received: by mail-yb1-f196.google.com with SMTP id j138so4452702ybg.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 10:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDDCdUT3w8PXr5ckKdRWDtDk4sYI0ipsqhagY47HppI=;
        b=mQB3sN3ERdBINoUDWL9HpPDq+xEWCrMwjbZ5CPAL8WHa/HThym8B/53Q+zXXiQNWV6
         8phD2fpQAPRYFEOgSfX1estYmpYjawilxFJeJkK8rCHDNCODIejZ7eEo95fOZ+Mo9m2v
         bT0G9AzJoFYAIQqa7pCt3W+lYAv/SLDkhp1GiqPjv6VJnp08NPl805ltUsHlfkOveAly
         tpgJZ+QkMzmX7VRebjYplDtrI9hU9gGOxCu2ocN3eD82VTP6sU0GbaeGa4/fHI88oC85
         3DBBQumgqmq76BB/TngONMsHAEiPzzk3YJCccH/suU95mh5z6Fyk/IVJ1Or+zON8TFo1
         2I+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDDCdUT3w8PXr5ckKdRWDtDk4sYI0ipsqhagY47HppI=;
        b=BvLkJe+82ljFBXaHcKzuaenztBfirrH7/EwIJK8mkCujcEhzY0XIVR2fPjAGZT9kJv
         6fgKrKukxgqRNX3wEwF5db/eESiX0t2UJw+D6TyRZ4LJ7guxQ2MpcE5QKVnSgy2uHGSN
         7wYAPUmCDbtrFZbT+nDjP5aQWpz0g+/qHK5n3/B+hy65qPpFpA47dSJmxsrkyhrS+L5R
         KHXJJTFHn1NBa26ufoeFFgiXOgsGCf3utOyrpNm7k+5M0gUYz4fWx8Fs35ox4WLlqNSQ
         GR+Q+J1CitmTwg4D26B+lPNhjC89NUny+k4J+mT526tarz2BTU1c8d0YwwWy8eCC5iia
         8gAQ==
X-Gm-Message-State: ANhLgQ3t/p/FkODCgXaNtac0rMjBSgLLhJcdmRCqCezdAVUGV7TO75hW
        UnFoRLofvNItofGST1coNEIoCZ1jfhosXoZmtCnf8Q==
X-Google-Smtp-Source: ADFU+vulKBeSD5ShM0DX8OXvTqNvKAqjvP+t4llrTV5IyQ2fADw58DXHUQQV4Fbes8CvFh+/6090Vj9lR3+xR8aOPjk=
X-Received: by 2002:a25:9787:: with SMTP id i7mr21236360ybo.383.1584812700636;
 Sat, 21 Mar 2020 10:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200321001400.245121-1-irogers@google.com> <20200321134053.GJ20696@hirez.programming.kicks-ass.net>
In-Reply-To: <20200321134053.GJ20696@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 21 Mar 2020 10:44:49 -0700
Message-ID: <CAP-5=fXcHrh=uHmPj43=xYnikx0mHRWFQwMJa1q8yQ=opvSEDA@mail.gmail.com>
Subject: Re: [PATCH] perf test x86: address multiplexing in rdpmc test
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

On Sat, Mar 21, 2020 at 6:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 20, 2020 at 05:14:00PM -0700, Ian Rogers wrote:
> > Counters may be being used for pinned or other events which inhibit the
> > instruction counter in the test from being scheduled - time_enabled > 0
> > but time_running == 0. This causes the test to fail with division by 0.
> > Add a sleep loop to ensure that the counter is run before computing
> > the count.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/tests/rdpmc.c | 45 ++++++++++++++++++++++++-------
> >  1 file changed, 35 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
> > index 1ea916656a2d..0b0792ae67f7 100644
> > --- a/tools/perf/arch/x86/tests/rdpmc.c
> > +++ b/tools/perf/arch/x86/tests/rdpmc.c
> > @@ -34,19 +34,35 @@ static u64 rdtsc(void)
> >       return low | ((u64)high) << 32;
> >  }
> >
> > -static u64 mmap_read_self(void *addr)
> > +static u64 mmap_read_self(void *addr, bool *error)
> >  {
> >       struct perf_event_mmap_page *pc = addr;
> > -     u32 seq, idx, time_mult = 0, time_shift = 0;
> > +     u32 seq, idx, time_mult = 0, time_shift = 0, sleep_count = 0;
> >       u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
> >
> > +     *error = false;
> >       do {
> > -             seq = pc->lock;
> > -             barrier();
> > -
> > -             enabled = pc->time_enabled;
> > -             running = pc->time_running;
> > -
> > +             do {
> > +                     seq = pc->lock;
> > +                     barrier();
> > +
> > +                     enabled = pc->time_enabled;
> > +                     running = pc->time_running;
> > +
> > +                     if (running == 0) {
>
> This is not in fact the condition the Changelog calls out.

Not sure I follow. As in the multiplexing? It is exactly the condition
that time_running == 0.

> > +                             /*
> > +                              * Event hasn't run, this may be caused by
> > +                              * multiplexing.
> > +                              */
> > +                             sleep_count++;
> > +                             if (sleep_count > 60) {
> > +                                     pr_err("Event failed to run. Are higher priority counters being sampled by a different process?\n");
> > +                                     *error = true;
> > +                                     return 0;
> > +                             }
> > +                             sleep(1);
> > +                     }
> > +             } while (running == 0);
>
>
> Also, I would much prefer this test to be in the caller of this
> function, and not deface this function.
>
> I'd prefer this function to stay representative of the outlines in
> uapi/linux/perf_event.h and an example of how to actually use it.

I 100% agree the code here should line up with
uapi/linux/perf_event.h, there are already small divergences. I've
tried to address these comments in v2 here:
https://lkml.org/lkml/2020/3/21/325
Of course, I don't mind just being the person reporting this issue and
someone with a stronger opinion on the API to propose something better
and line up the perf_event.h comments. Another option is to fail the
test if the counter never runs rather than sleeping. That would be
unfortunate for some of the testing conditions we have, and we'd have
to run the test less frequently.

Thanks,
Ian

> >               if (enabled != running) {
> >                       cyc = rdtsc();
> >                       time_mult = pc->time_mult;
> > @@ -131,13 +147,22 @@ static int __test__rdpmc(void)
> >
> >       for (n = 0; n < 6; n++) {
> >               u64 stamp, now, delta;
> > +             bool error;
> >
> > -             stamp = mmap_read_self(addr);
> > +             stamp = mmap_read_self(addr, &error);
> > +             if (error) {
> > +                     delta_sum = 0;
> > +                     goto out_close;
> > +             }
> >
> >               for (i = 0; i < loops; i++)
> >                       tmp++;
> >
> > -             now = mmap_read_self(addr);
> > +             now = mmap_read_self(addr, &error);
> > +             if (error) {
> > +                     delta_sum = 0;
> > +                     goto out_close;
> > +             }
> >               loops *= 10;
> >
> >               delta = now - stamp;
> > --
> > 2.25.1.696.g5e7596f4ac-goog
> >
