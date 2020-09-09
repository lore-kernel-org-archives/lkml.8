Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33DFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAC421D7E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZcdNOua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIIRxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIIRxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:53:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231DDC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 10:53:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a65so3134061wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81bPiN/545geCaIVpzuoDosAeqfaE3oH20jaKbiHmFo=;
        b=tZcdNOua4o0C664+yOEvAEPO8AQloNdD+WAws8ZAB2Nj4Z+F4tqQeVnBR0Y6lrC/nW
         p7MMx5eGBNquFus/kCnzJeoJ8TCYG/SulwBkcfUFAZGv6QAVCQLxSPA1PJ1JXjp4PSXe
         JUXVM7KLf8y97hX+F6LqOXQlfjo5QuE+L+Bcwot3uOF+mb3BXnhAj6AOVv4wXaZvvQC2
         cDYivC6jfrEH1pTiIavQE0Zy7mUdwKh3g29ew9/LdVExScgchf7AG6JHSsfixmvM4H/T
         U/+3VTOtSE7ZXWjqdiO0e2rcUc1T575I+7WQJXzzTWDPB9zZLPs8GaaO2QZIgwF3135j
         SpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81bPiN/545geCaIVpzuoDosAeqfaE3oH20jaKbiHmFo=;
        b=mue/mk39F87LPkEnk5ObDZ2akPABs+n7bR4xT5DmyU6PjUDZdE8LDm2bOiRdfKUMwl
         rcs5DCBTBCEFQSYDDokWIM+TIa98lju6kSeFplU92CBSDOot77YewTmF81GbUmEN+sX0
         thO090qvUA/ceFdQFtaJCb5ELnOD6C26j4o230/vrRBi9M83triVEZY7K13977M2pAQ0
         iH/FonHLf4BNWTBL1YuOPPAuMJw4XuyJK1It+1Aca+LHKbtjzQ/hWgVzNUcfDZfkMdU0
         CUHQ+2joFI3xfy5tsng0tmvfVKaytFm2AzYj6E1d+ac2EMeLpZSDem7Pkmlar74g58MG
         KjNg==
X-Gm-Message-State: AOAM532ORDfiFCP6hptUyONQlbcUj0HKhunVje2RjhfIluL7XCc3YL+M
        0AhzVbBXJC7g5qjEc4JF3w5+QxcubJ9he8rC6ZxA9w==
X-Google-Smtp-Source: ABdhPJxqjpvGx1MWX2rhPnvdfxhmmhvZFATqyRorhRwUTsvphO68oVDz0uFvoGlyNH8JlaVSoivWKQMNx+GFNAyuJww=
X-Received: by 2002:a1c:f402:: with SMTP id z2mr4525670wma.87.1599673986537;
 Wed, 09 Sep 2020 10:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200909080220.254585-1-irogers@google.com> <20200909080220.254585-2-irogers@google.com>
 <CAM9d7cgNNBw0d2c39+1D=0peGrxRV3P33aoczKMu5Qxffkd2CQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgNNBw0d2c39+1D=0peGrxRV3P33aoczKMu5Qxffkd2CQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 9 Sep 2020 10:52:54 -0700
Message-ID: <CAP-5=fUH3w+UckdzqkUvp0vAz1gFMqrYNF6wE8ib5kPjXqM2Yg@mail.gmail.com>
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

On Wed, Sep 9, 2020 at 2:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Wed, Sep 9, 2020 at 5:02 PM Ian Rogers <irogers@google.com> wrote:
> >
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
> >  Performance counter stats for 'system wide':
> >
> >              41.14 MiB  uncore_imc/cas_count_read/
> >      1,002,614,251 ns   duration_time
> >
> >        1.002614251 seconds time elapsed
> >
> > After this change:
> > $ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >             157.47 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
>
> Hmm.. I guess the 0.00 result is incorrect, no?

Agreed. There are a number of pre-existing bugs in this code. I'll try
to look into this one.

> >             126.97 MiB  uncore_imc/cas_count_write/
> >      1,003,019,728 ns   duration_time
> >
> > Erroneous duplication introduced in:
> > commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").
> >
> > Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
> > Reported-by: Jin, Yao <yao.jin@linux.intel.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> [SNIP]
> > @@ -248,6 +260,16 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >                 ev = metric_events[i];
> >                 ev->metric_leader = ev;
> >                 set_bit(ev->idx, evlist_used);
> > +               /*
> > +                * Mark two events with identical names in the same group as
> > +                * being in use as uncore events may be duplicated for each pmu.
> > +                */
> > +               evlist__for_each_entry(perf_evlist, ev) {
> > +                       if (metric_events[i]->leader == ev->leader &&
> > +                           !strcmp(metric_events[i]->name, ev->name)) {
> > +                               set_bit(ev->idx, evlist_used);
>
> I'm not sure whether they are grouped together.
> But if so, you can use for_each_group_member(ev, leader).

Good suggestion, unfortunately the groups may be removed for things
like NMI watchdog or --metric-no-group and so there wouldn't be a
leader to follow. We could do something like this:

if (metric_events[i]->leader) {
  for_each_group_member(ev, leader) {
    if (!strcmp(metric_events[i]->name, ev->name))
      set_bit(ev->idx, evlist_used);
  }
} else {
  evlist__for_each_entry(perf_evlist, ev) {
    if (!ev->leader && !strcmp(metric_events[i]->name, ev->name))
      set_bit(ev->idx, evlist_used);
  }
 }
}

What do you think?

Thanks,
Ian

> Thanks
> Namhyung
>
>
> > +                       }
> > +               }
> >         }
> >
> >         return metric_events[0];
> > --
> > 2.28.0.526.ge36021eeef-goog
> >
