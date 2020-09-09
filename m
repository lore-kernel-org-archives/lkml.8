Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B77EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD73C21D46
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8jK3A5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgIIRi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIIRix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:38:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D600C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 10:38:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so3094386wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SaXmQ2Ek0SU/mYoFuXw7smplUEJZOqgz2riTKArpeAU=;
        b=t8jK3A5RUuH7QfBxnf/Cfrszm1tOpHGFIx23IBgH4+0xCNtlxIceusLPob7AYf7RYF
         TTHSIe3R70gSAD8OfBTavYKDvzDZWnKs4UFcZQfU0Phb5YyemBWgsb7zganC1bhCc5Y6
         tamnnpOde5JAqrEY6dFZ30Iwf90BlSQfiUzbw0kDRXrbenWMLqCr7ot+cJJC+QIrhGKN
         HFq3PIMQoCzCUy5MqWVAWXkjcGs98rDLEs6sUwYZPytB+CV2dZ2AxLCaF7kv1U/H+BvV
         E+lkxusdCn4IuLbAAl8RPdPWWx1ip2uA3gsknYV//2SRGsA1SkLEKwN13EdR0+lKMTyn
         QdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaXmQ2Ek0SU/mYoFuXw7smplUEJZOqgz2riTKArpeAU=;
        b=SrZy8iv2OprwJ/D5Nw41oxyqbSVZ+aVJ4hbIbI+NH1qSNHkfvRB/gMYy3kAiR0B7Y3
         JvHhrI+ck9o7P4E7oEnscKFvFKwGIlaCzxM3UC4Mz/kYEca+Qq7F6Flcx02hVssdCBr3
         wqRXGFgHEHBr4ckwGj9Kp4W3pf2ky6GoKeCT9DPuE8Cd4ahwpm+THKcZdxWVeg24UdMI
         mVsNTXE87IM1LDHQ+d7KtClIsimJC+GEQNuwH0Nu2FWCpuIZi5GQh/fpnQJ2isApUJzS
         crwezkPvMQQE2Q6oXpOLfEn2YeBHm2L4j5fN6+iLXNKtbGamf9MXHxp7ypaZJW1Yu0Ia
         weyw==
X-Gm-Message-State: AOAM532ttvJ5WKT/gpnbwLsqQh60kLPfhhDsSHfiJkovY+ykWbHomzFt
        +uQTDVs79KSI/Wm8MVeYhkh6qhq9iKNYdkdoAsJI1Q==
X-Google-Smtp-Source: ABdhPJwFCNCVDRn2ymW/90+yJpS3SvWKbWGGHHg3QnD5Z3HDFGY9ZKNTy6SflIUNTbET/vWmnkDLMDHQQZIARi6jlKk=
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr4767287wmb.77.1599673130963;
 Wed, 09 Sep 2020 10:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200909080220.254585-1-irogers@google.com> <20200909080220.254585-2-irogers@google.com>
 <9d22f4d1-ea24-bc42-40bc-d25202f25678@linux.intel.com>
In-Reply-To: <9d22f4d1-ea24-bc42-40bc-d25202f25678@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 9 Sep 2020 10:38:39 -0700
Message-ID: <CAP-5=fUA5sq5-xayrG6KbdU1+hNLqKRN7Aks4B4QV84yH8CuPw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf metricgroup: Fix uncore metric expressions
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>, Jin@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 1:33 AM Jin, Yao <yao.jin@linux.intel.com> wrote:
>
>
>
> On 9/9/2020 4:02 PM, Ian Rogers wrote:
> > A metric like DRAM_BW_Use has on SkylakeX events uncore_imc/cas_count_read/
> > and uncore_imc/case_count_write/. These events open 6 events per socket
> > with pmu names of uncore_imc_[0-5]. The current metric setup code in
> > find_evsel_group assumes one ID will map to 1 event to be recorded in
> > metric_events. For events with multiple matches, the first event is
> > recorded in metric_events (avoiding matching >1 event with the same
> > name) and the evlist_used updated so that duplicate events aren't
> > removed when the evlist has unused events removed.
> >
> > Before this change:
> > $ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1
> >
> >   Performance counter stats for 'system wide':
> >
> >               41.14 MiB  uncore_imc/cas_count_read/
> >       1,002,614,251 ns   duration_time
> >
> >         1.002614251 seconds time elapsed
> >
> > After this change:
> > $ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1
> >
> >   Performance counter stats for 'system wide':
> >
> >              157.47 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
> >              126.97 MiB  uncore_imc/cas_count_write/
> >       1,003,019,728 ns   duration_time
> >
> > Erroneous duplication introduced in:
> > commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").
> >
> > Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
> > Reported-by: Jin, Yao <yao.jin@linux.intel.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/util/metricgroup.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 8831b964288f..d216a161f41c 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -206,6 +206,18 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >                               sizeof(struct evsel *) * idnum);
> >                       current_leader = ev->leader;
> >               }
> > +             /*
> > +              * Check for duplicate events with the same name. For example,
> > +              * uncore_imc/cas_count_read/ will turn into 6 events per socket
> > +              * on skylakex. Only the first such event is placed in
> > +              * metric_events.
> > +              */
> > +             for (i = 0; i < matched_events; i++) {
> > +                     if (!strcmp(metric_events[i]->name, ev->name))
> > +                             break;
> > +             }
> > +             if (i != matched_events)
> > +                     continue;
> >               if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
> >                       if (has_constraint) {
> >                               /*
> > @@ -248,6 +260,16 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >               ev = metric_events[i];
> >               ev->metric_leader = ev;
> >               set_bit(ev->idx, evlist_used);
> > +             /*
> > +              * Mark two events with identical names in the same group as
> > +              * being in use as uncore events may be duplicated for each pmu.
> > +              */
> > +             evlist__for_each_entry(perf_evlist, ev) {
> > +                     if (metric_events[i]->leader == ev->leader &&
> > +                         !strcmp(metric_events[i]->name, ev->name)) {
>
> Do we really need this '!strcmp(metric_events[i]->name, ev->name)'?

When there are multiple metrics being computed then we end up parsing
multiple groups of events, something like
"{...}:W,{....}:W,{....}:W...". The code sorts the groups so that
those with the largest number of events appear at the front, it then
matches metrics against the list trying to reuse events at the front
of the list first (the selection must respect the groupings). It's not
a particularly sophisticated algorithm, but it reduces multiplexing
for say top down metrics. We need to remove the unused events/groups
from the evlist to achieve this benefit. If there were some events
like "{instructions,cycles}:W" but we only matched "instructions"
within the group, then we would want to eliminate "cycles" from the
group - the strcmp achieves this, otherwise we'd mark everything in
the group as in use. Now, the "cycles" will likely be marked live by
another metric, that's how we got the group in the first place, but
marking it live here strikes me as a little odd as the event wouldn't
be being used by the metric. A case where this problem could happen is
with --metric-no-group, where all the events multiplex freely with
each other as they aren't grouped. We'd like to eliminate duplicated
events in the evlist, but if we mark them all live this won't happen.

Sorry for the long explanation :-) TL;DR I think it is necessary.

Thanks,
Ian

> Thanks
> Jin Yao
>
> > +                             set_bit(ev->idx, evlist_used);
> > +                     }
> > +             }
> >       }
> >
> >       return metric_events[0];
> >
