Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3261DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E717F206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599499571;
	bh=gjXisqWlCHJgG1MHtw8oGtySEd9v+oVnzVV5ewk2mtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pfFSTRkl4uwVRvwybfaRBoa/mm34XZWPCeTOgVk4T1ZHwlTPQrLKfj/JEyMgAnrlO
	 vgzMtsLwhcQcOxsqSqwDD+ryjMsWKXWuO3T+guRZAfsetcsC06ubnZE1RjkrQhxxHB
	 PTszgksOGX3m80zCukD06wHEPz87bei+spTfhv0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgIGR0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:26:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41587 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgIGNUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:20:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5so15794580wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJh+96DWgK4/OLwhvVspOgZjqQ2tTXtnfvMf9TMtY+0=;
        b=MIlO9bhzcyjTXqukJdilqyEgzl2Zq/KhbgLyCGs/wrIfFDp7jMXFkVEpSPb01MKaxy
         IDcgE+XlrZ18Y5ue+5pE7Lg4Gr+REukR1mS56wQIXiF32vqRnRm78RxAjRUoNzrxAFZK
         bUkMOIVhYHgbAu9YqCuxgriEkWUTAnx7udKQB4FMMZvWHHOPb0qsier3IOZZY+J/5Mnk
         m3/RnMr9EBUnRIE+mCP/d+iyLtWZ+fL3fO2jcFQ2B96vKo/6gUEFFWqIsKEY40UBYT7/
         c0rVw/ITGS65GD7ILxJ64WC/jv7ZxLL3DYfVLraR0MnXV6SsWnLhcT3hvlbXuzycBCO8
         Apew==
X-Gm-Message-State: AOAM531dOtmEqTZABOGILb/jBMGRiW9tbC3TeW3v91tlebkUSqSugIdK
        QUcOxp8eE+S4/K257xiKnzZiZDnCCEOiMcBn+Rg=
X-Google-Smtp-Source: ABdhPJwfdgYm5BkwquVIODnEJccaJug77FwuJ80KdUg1SzNeTy6idbD1HYhmNquByLy+vxk+6mUW/qi/PzCQDGDHnkg=
X-Received: by 2002:adf:e481:: with SMTP id i1mr21343750wrm.391.1599484846078;
 Mon, 07 Sep 2020 06:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200907034502.753230-1-namhyung@kernel.org> <20200907034502.753230-9-namhyung@kernel.org>
 <78911dd7-8a93-0f1b-7805-1fad87ad6979@huawei.com>
In-Reply-To: <78911dd7-8a93-0f1b-7805-1fad87ad6979@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 7 Sep 2020 22:20:34 +0900
Message-ID: <CAM9d7ci=knY_Wu8vbdfOzCtJX_onciz2eri8E=d2KM2qwG6QGQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] perf test: Free aliases for PMU event map aliases test
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Sep 7, 2020 at 7:31 PM John Garry <john.garry@huawei.com> wrote:
>
> On 07/09/2020 04:45, Namhyung Kim wrote:
> > The aliases were never released causing the following leaks:
> >
> >    Indirect leak of 1224 byte(s) in 9 object(s) allocated from:
> >      #0 0x7feefb830628 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x107628)
> >      #1 0x56332c8f1b62 in __perf_pmu__new_alias util/pmu.c:322
> >      #2 0x56332c8f401f in pmu_add_cpu_aliases_map util/pmu.c:778
> >      #3 0x56332c792ce9 in __test__pmu_event_aliases tests/pmu-events.c:295
> >      #4 0x56332c792ce9 in test_aliases tests/pmu-events.c:367
> >      #5 0x56332c76a09b in run_test tests/builtin-test.c:410
> >      #6 0x56332c76a09b in test_and_print tests/builtin-test.c:440
> >      #7 0x56332c76ce69 in __cmd_test tests/builtin-test.c:695
> >      #8 0x56332c76ce69 in cmd_test tests/builtin-test.c:807
> >      #9 0x56332c7d2214 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
> >      #10 0x56332c6701a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
> >      #11 0x56332c6701a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
> >      #12 0x56332c6701a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
> >      #13 0x7feefb359cc9 in __libc_start_main ../csu/libc-start.c:308
> >
> > Cc: John Garry <john.garry@huawei.com>
> > Fixes: 956a78356c24c ("perf test: Test pmu-events aliases")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >   tools/perf/tests/pmu-events.c | 5 +++++
> >   tools/perf/util/pmu.c         | 2 +-
> >   tools/perf/util/pmu.h         | 1 +
> >   3 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> > index eb19f9a0bc15..d3517a74d95e 100644
> > --- a/tools/perf/tests/pmu-events.c
> > +++ b/tools/perf/tests/pmu-events.c
> > @@ -274,6 +274,7 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
> >       int res = 0;
> >       bool use_uncore_table;
> >       struct pmu_events_map *map = __test_pmu_get_events_map();
> > +     struct perf_pmu_alias *a, *tmp;
> >
> >       if (!map)
> >               return -1;
> > @@ -347,6 +348,10 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
> >                         pmu_name, alias->name);
> >       }
> >
> > +     list_for_each_entry_safe(a, tmp, &aliases, list) {
> > +             list_del(&a->list);
> > +             perf_pmu_free_alias(a);
>
> This looks ok.

Thanks!

>
> I also notice that we have other paths like this, where the allocated
> pmu (and aliases) are not freed for later error paths, it seems:
>
> parse_events_add_pmu() -> perf_pmu_find() -> pmu_lookup() ->
> pmu_add_cpu_aliases().
>
> I had a quick look at the rest of the series, and could not see if we
> fix up any of this.

Right, I also found that and wondered why ASAN didn't report it.
I think we should free all pmu instances from the pmus list.
But this can be a later work..

Thanks
Namhyung
