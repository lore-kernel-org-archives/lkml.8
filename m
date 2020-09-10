Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD94C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247EC2078E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ic/dkvj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgIJDlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIJDlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:41:08 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D214C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 20:41:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so4297376wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 20:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2O4vBfI3hKOEmoFZGCZtLNv0ZqkiQWCU9CvU7E2a6A=;
        b=ic/dkvj6+icYMMycK0JNnD8hEeDsHfGgUoHXFOJsVshYoPZch9PKciNxbzHoAVhfxL
         3BW45H7TtnVv4zzeJfD3Ilz9T5qHHay2Z+ymqw8DAX39cs3JbEhpBqJ8KSJEKbsTLwgb
         g56iS2nfwmpv1BMeEBGANLQQp1BsSB0SwAxBe60rmXQ7EdxeHw41ZhK+9++2NBq0NCm/
         rcpt2NehUYCGFUkwmDfawmnKBiQ8cn3CH80FUWCAeLRrA6ecyhgxN+cKbWMe2VFVebK+
         A+CCm1ovP3FZI6CqB4dkxy5/QPAsnTQGCU5PDxLSh37laXEv1usd/qDnjIYA5zdD8sCN
         llPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2O4vBfI3hKOEmoFZGCZtLNv0ZqkiQWCU9CvU7E2a6A=;
        b=aglQ0NhD711NB+xNB8xgnPg77FyH4LHkQbpjbN3B1MQ5681k9lK8dLLExd4EOyCm/x
         1SwkomBY7cPYdApMML762cZ0JNGfsbBkfYzxLB8xJ3Xu5yI4ldsWMrpShAWgb3HhWbpS
         xCyNySVMfrj5VAg5xe+u4TpRAbK0pcLm8I0pgtf5+vbbsVFZMUTcOEE8jwuIeei0ygxU
         +6+mVXddXzEYKjqiR1p3PbtU4fq1GoXFvxi/KlKRRxNighMSSpPIcDQT5AwBTuy5t1rk
         7ReAm7BhSfHoIlPwvtNc8Gy5/aU7pUG9aFUhVmQqzwe6VJy+U8lnSvJhcldT1LodE6nH
         NFdg==
X-Gm-Message-State: AOAM531/SphgXaymedXXG7cLop2pFbeWoi6MxEgU3EaA8ZO9htgaOeWU
        ZXW7P0BFBy9NerSYk1qMA7g4VYUCD9yFRbsPn7JL+A==
X-Google-Smtp-Source: ABdhPJyHReDBLcTFf8m72rDMREPXa29V1bM32KrL0se1sCz3qeo4QNlqPTC4GDDWBAV64W/rCblYa3YAI+JJdohV1Eo=
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr6585086wmb.77.1599709265560;
 Wed, 09 Sep 2020 20:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200909080220.254585-1-irogers@google.com> <20200909080220.254585-2-irogers@google.com>
 <CAM9d7cgNNBw0d2c39+1D=0peGrxRV3P33aoczKMu5Qxffkd2CQ@mail.gmail.com> <CAP-5=fUH3w+UckdzqkUvp0vAz1gFMqrYNF6wE8ib5kPjXqM2Yg@mail.gmail.com>
In-Reply-To: <CAP-5=fUH3w+UckdzqkUvp0vAz1gFMqrYNF6wE8ib5kPjXqM2Yg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 9 Sep 2020 20:40:54 -0700
Message-ID: <CAP-5=fVP8p==J-K59Oo6WvZCafnsFAux3g3vW-wLKHqaASyveQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf metricgroup: Fix uncore metric expressions
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>, Jin@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 10:52 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Sep 9, 2020 at 2:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Sep 9, 2020 at 5:02 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > A metric like DRAM_BW_Use has on SkylakeX events uncore_imc/cas_count_read/
> > > and uncore_imc/case_count_write/. These events open 6 events per socket
> > > with pmu names of uncore_imc_[0-5]. The current metric setup code in
> > > find_evsel_group assumes one ID will map to 1 event to be recorded in
> > > metric_events. For events with multiple matches, the first event is
> > > recorded in metric_events (avoiding matching >1 event with the same
> > > name) and the evlist_used updated so that duplicate events aren't
> > > removed when the evlist has unused events removed.
> > >
> > > Before this change:
> > > $ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >              41.14 MiB  uncore_imc/cas_count_read/
> > >      1,002,614,251 ns   duration_time
> > >
> > >        1.002614251 seconds time elapsed
> > >
> > > After this change:
> > > $ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >             157.47 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
> >
> > Hmm.. I guess the 0.00 result is incorrect, no?
>
> Agreed. There are a number of pre-existing bugs in this code. I'll try
> to look into this one.

There was a bug where the metric_leader wasn't being set correctly and
so the accumulation of values wasn't working as expected. There's a
small fix in:
https://lore.kernel.org/lkml/20200910032632.511566-3-irogers@google.com/T/#u
that also does the change I mentioned below.

The metric still remains at 0.0 following this change as I believe
there is a bug in the metric. The metric expression is:
"( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) /
1000000000 ) / duration_time"
ie the counts of uncore_imc/cas_count_read/ and
uncore_imc/cas_count_write/ are being first being scaled up by 64,
that is to turn a count of cache lines into bytes, the count is then
divided by 1000000000 or a GB to supposedly give GB/s. However, the
counts are read and scaled:

...
void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
...
  count *= counter->scale;
...

The scale value from
/sys/devices/uncore_imc_0/events/cas_count_read.scale is
6.103515625e-5 or 64/(1024*1024). This means the result of the
expression is 64 times too large but in PB/s and so too small to
display. I don't rule out there being other issues but this appears to
be a significant one. Printing using intervals also looks suspicious
as the count appears to just increase rather than vary up and down.
Jin Yao, I don't know if you can take a look?

Thanks,
Ian

> > >             126.97 MiB  uncore_imc/cas_count_write/
> > >      1,003,019,728 ns   duration_time
> > >
> > > Erroneous duplication introduced in:
> > > commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").
> > >
> > > Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
> > > Reported-by: Jin, Yao <yao.jin@linux.intel.com>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > [SNIP]
> > > @@ -248,6 +260,16 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> > >                 ev = metric_events[i];
> > >                 ev->metric_leader = ev;
> > >                 set_bit(ev->idx, evlist_used);
> > > +               /*
> > > +                * Mark two events with identical names in the same group as
> > > +                * being in use as uncore events may be duplicated for each pmu.
> > > +                */
> > > +               evlist__for_each_entry(perf_evlist, ev) {
> > > +                       if (metric_events[i]->leader == ev->leader &&
> > > +                           !strcmp(metric_events[i]->name, ev->name)) {
> > > +                               set_bit(ev->idx, evlist_used);
> >
> > I'm not sure whether they are grouped together.
> > But if so, you can use for_each_group_member(ev, leader).
>
> Good suggestion, unfortunately the groups may be removed for things
> like NMI watchdog or --metric-no-group and so there wouldn't be a
> leader to follow. We could do something like this:
>
> if (metric_events[i]->leader) {
>   for_each_group_member(ev, leader) {
>     if (!strcmp(metric_events[i]->name, ev->name))
>       set_bit(ev->idx, evlist_used);
>   }
> } else {
>   evlist__for_each_entry(perf_evlist, ev) {
>     if (!ev->leader && !strcmp(metric_events[i]->name, ev->name))
>       set_bit(ev->idx, evlist_used);
>   }
>  }
> }
>
> What do you think?
>
> Thanks,
> Ian
>
> > Thanks
> > Namhyung
> >
> >
> > > +                       }
> > > +               }
> > >         }
> > >
> > >         return metric_events[0];
> > > --
> > > 2.28.0.526.ge36021eeef-goog
> > >
