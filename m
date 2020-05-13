Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBDDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7504A2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbChOTO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389626AbgEMQ1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730831AbgEMQ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:27:14 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E908C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:27:14 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id o8so47944ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iR+YZyCK60n7j0PhRCWIGeDyu4fPn5yxvMiFkG9j6Vk=;
        b=HbChOTO0LwbB+3zPBYJLy4lgxdOq/ASw3ThUqbrmMLxapPdH4HzOliG6/xNoFF98O3
         Q63vYTUKcXdnmQwqKzXImWlo+Q1GClDj7Pqyr4LWGpAOTYJOifKFQmSY7VB0Hrmh5LGr
         Ca1aSQRKHcUa2Nlm7uEyux/tBuvUzlEP1DGYNCRPmuE8MbuLNh+DVv0RACGqQrJtWapT
         nwU9Df/KhYYuJXOYgyUAbivU9Wtse3Q8G3cA59/KD8Gnb69fnXb69fLkUzf47gMZl083
         om8cDSr9FgattjVTzYbF2FzgIivKojJmuC+eIZCJlYbj3MJgMgxq2xeHMlNU5oJnVo/k
         kMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iR+YZyCK60n7j0PhRCWIGeDyu4fPn5yxvMiFkG9j6Vk=;
        b=Fze2qGSH5iZh0aC3n2a1DRYzDZtDSH5ZW9BzHwGLDNfHfuxaIiCfsJTR6bPiT9CjkN
         4KWcrLO08G1vecICa1HDYptS+105Zqdg3w4aMgTpeNsOcnmoeUah3Z6Idmv1Tt0/xafh
         76mREpwIh9r8oA+px3AMEDOYL5EUmGmD9Lm+F0bsfjEmwZFEYtYpOnjzOljEsm0INn8d
         Szm8qRohV2+zMPbWZESMy75ql/PQQ4CeBmpLns7h2wyPhIfiEPS39mPsr6DhF96nij4q
         cCCtHIfnvw+Pc9wns7S1MguLRigX3QwVAjCsEusWddnVuyfv3PtmGXqadGjsso3v+8VG
         /Cvg==
X-Gm-Message-State: AGi0PubQ4DnRgeDv49P6trV55DBdsKEzb7UYrdS24oEWckfG0r3L7HL7
        ZNAbXigi4wYxYA5/Phom6kJrJfWjBe/NhRDfc1fZxw==
X-Google-Smtp-Source: APiQypJ5V7hR63rAwTJc0LcNxjJ2oHEwb0qvENjjiQt1JCupYyf6BdCCRmjSZ274N4FPkLV6EteFHkb8JtLtYbtBW/k=
X-Received: by 2002:a25:be81:: with SMTP id i1mr43110035ybk.184.1589387233040;
 Wed, 13 May 2020 09:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200512235918.10732-1-irogers@google.com> <20200513133627.GC5583@kernel.org>
In-Reply-To: <20200513133627.GC5583@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 May 2020 09:27:01 -0700
Message-ID: <CAP-5=fUD9D1p3vHpX_Zci7FRooRTsdAV1oZBksEk+5iEqsNTYA@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Fix 2 memory leaks
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 6:36 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, May 12, 2020 at 04:59:18PM -0700, Ian Rogers escreveu:
> > If allocated, perf_pkg_mask and metric_events need freeing.
>
> Applied, were those found with some tool? Or just by visual inspection?
>
> Also I noticed that evsel->metric_events is correctly initialized to
> NULL in evsel__init(), but evsel->per_pkg_mask isn't, and while
> evsel__new() uses zalloc() it is possible, IIRC, for evsels associated
> with hists to be part of a larger struct, so I think the safest way is
> to initialize evsel->per_pkg_mask to NULL in evsel__init(), will do it
> in a follow up patch.
>
> - Arnaldo

Thanks for following up on other issues related to this!

On the tool side I was testing metric code with address sanitizer as
described in Build.txt:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Documentation/Build.txt

Here it is for current kernel/git/acme/linux.git perf/core
$ make -C tools/perf O=/tmp/perf DEBUG=1
EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address' install
$ /tmp/perf/perf stat -a -M TopDownL1 sleep 1
...
==187042==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 332 byte(s) in 19 object(s) allocated from:
    #0 0x7f23a435f0b5 in strdup (/lib/x86_64-linux-gnu/libasan.so.5+0x920b5)
    #1 0x562e03f83321 in str util/expr.l:75
    #2 0x562e03f84048 in expr_lex util/expr.l:110
    #3 0x562e03f8c2ad in expr_parse /tmp/perf/util/expr-bison.c:1341
    #4 0x562e03f8e5fd in __expr__parse util/expr.c:51
    #5 0x562e03f8e74e in expr__parse util/expr.c:61
    #6 0x562e03eeef65 in generic_metric util/stat-shadow.c:781
    #7 0x562e03ef125f in perf_stat__print_shadow_stats util/stat-shadow.c:1057
    #8 0x562e03ef5661 in printout util/stat-display.c:490
    #9 0x562e03ef8248 in print_counter_aggr util/stat-display.c:820
    #10 0x562e03efb31c in perf_evlist__print_counters util/stat-display.c:1233
    #11 0x562e03c36b9e in print_counters tools/perf/builtin-stat.c:777
    #12 0x562e03c3d79c in cmd_stat tools/perf/builtin-stat.c:2151
    #13 0x562e03d79021 in run_builtin tools/perf/perf.c:312
    #14 0x562e03d7956b in handle_internal_command tools/perf/perf.c:364
    #15 0x562e03d79922 in run_argv tools/perf/perf.c:408
    #16 0x562e03d7a0fe in main tools/perf/perf.c:538
    #17 0x7f23a3bccbba in __libc_start_main ../csu/libc-start.c:308

Direct leak of 332 byte(s) in 19 object(s) allocated from:
    #0 0x7f23a435f0b5 in strdup (/lib/x86_64-linux-gnu/libasan.so.5+0x920b5)
    #1 0x562e03f83321 in str util/expr.l:75
    #2 0x562e03f84048 in expr_lex util/expr.l:110
    #3 0x562e03f8c2ad in expr_parse /tmp/perf/util/expr-bison.c:1341
    #4 0x562e03f8e5fd in __expr__parse util/expr.c:51
    #5 0x562e03f8e96d in expr__find_other util/expr.c:85
    #6 0x562e03e1a830 in __metricgroup__add_metric util/metricgroup.c:503
    #7 0x562e03e1af60 in metricgroup__add_metric util/metricgroup.c:552
    #8 0x562e03e1b11e in metricgroup__add_metric_list util/metricgroup.c:588
    #9 0x562e03e1b5c7 in metricgroup__parse_groups util/metricgroup.c:629
    #10 0x562e03c36ed0 in parse_metric_groups tools/perf/builtin-stat.c:843
    #11 0x562e040478c2 in get_value tools/lib/subcmd/parse-options.c:248
    #12 0x562e04048b05 in parse_short_opt tools/lib/subcmd/parse-options.c:348
    #13 0x562e04049ad3 in parse_options_step
tools/lib/subcmd/parse-options.c:536
    #14 0x562e0404a9f6 in parse_options_subcommand
tools/lib/subcmd/parse-options.c:651
    #15 0x562e03c3c73d in cmd_stat tools/perf/builtin-stat.c:1889
    #16 0x562e03d79021 in run_builtin tools/perf/perf.c:312
    #17 0x562e03d7956b in handle_internal_command tools/perf/perf.c:364
    #18 0x562e03d79922 in run_argv tools/perf/perf.c:408
    #19 0x562e03d7a0fe in main tools/perf/perf.c:538
    #20 0x7f23a3bccbba in __libc_start_main ../csu/libc-start.c:308

Direct leak of 152 byte(s) in 1 object(s) allocated from:
    #0 0x7f23a43d4628 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x107628)
    #1 0x562e040504fd in cpu_map__trim_new tools/lib/perf/cpumap.c:79
    #2 0x562e04050c97 in perf_cpu_map__read tools/lib/perf/cpumap.c:149
    #3 0x562e04050d7d in cpu_map__read_all_cpu_map tools/lib/perf/cpumap.c:166
    #4 0x562e04050ea6 in perf_cpu_map__new tools/lib/perf/cpumap.c:181
    #5 0x562e03db3063 in perf_evlist__create_maps util/evlist.c:929
    #6 0x562e03c3d138 in cmd_stat tools/perf/builtin-stat.c:2047
    #7 0x562e03d79021 in run_builtin tools/perf/perf.c:312
    #8 0x562e03d7956b in handle_internal_command tools/perf/perf.c:364
    #9 0x562e03d79922 in run_argv tools/perf/perf.c:408
    #10 0x562e03d7a0fe in main tools/perf/perf.c:538
    #11 0x7f23a3bccbba in __libc_start_main ../csu/libc-start.c:308

Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7f23a43d4a2e in __interceptor_realloc
(/lib/x86_64-linux-gnu/libasan.so.5+0x107a2e)
    #1 0x562e04052b3a in perf_thread_map__realloc tools/lib/perf/threadmap.c:23
    #2 0x562e04052cb5 in perf_thread_map__new_dummy
tools/lib/perf/threadmap.c:47
    #3 0x562e03e77a1d in thread_map__new_by_tid_str util/thread_map.c:255
    #4 0x562e03e77e17 in thread_map__new_str util/thread_map.c:304
    #5 0x562e03db2ffe in perf_evlist__create_maps util/evlist.c:920
    #6 0x562e03c3d138 in cmd_stat tools/perf/builtin-stat.c:2047
    #7 0x562e03d79021 in run_builtin tools/perf/perf.c:312
    #8 0x562e03d7956b in handle_internal_command tools/perf/perf.c:364
    #9 0x562e03d79922 in run_argv tools/perf/perf.c:408
    #10 0x562e03d7a0fe in main tools/perf/perf.c:538
    #11 0x7f23a3bccbba in __libc_start_main ../csu/libc-start.c:308

SUMMARY: AddressSanitizer: 848 byte(s) leaked in 40 allocation(s).

The RFC metric group event sharing code fixes the top two, the bottom
two need more investigation due to the use of reference counting. If
each reference count were a leak then it'd be reasonably easy to track
and fix the culprit. There might be something smarter to track down
reference count leaks, I'll try to find out. Setting breakpoints in
gdb I saw about 115 increments and 112 decrements, and pairing those
up was more than a 5 minute job :-)

Thanks,
Ian


> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index a2397ca4d57a..654b79c1f4ac 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1266,6 +1266,8 @@ void evsel__exit(struct evsel *evsel)
> >       zfree(&evsel->group_name);
> >       zfree(&evsel->name);
> >       zfree(&evsel->pmu_name);
> > +     zfree(&evsel->per_pkg_mask);
> > +     zfree(&evsel->metric_events);
> >       perf_evsel__object.fini(evsel);
> >  }
> >
> > --
> > 2.26.2.645.ge9eca65c58-goog
> >
>
> --
>
> - Arnaldo
