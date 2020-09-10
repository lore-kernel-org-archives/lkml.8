Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12C3C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AAA21D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwMUXdQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIJSOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgIJR6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:58:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1BC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:58:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so1041508wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScFF7njHyD7jDn62ILaf2pwzv53IErIyozW137RkZM0=;
        b=fwMUXdQRPBwBaQOLV3PtXnhu/+LsFl4cER3JSuvH3OI/P8Xil2ZGHhMR3qFFDKCUPs
         r1FGTIcodXpgKgRgWEj+y5DR9MJDGuExix7iHQdwpKBmWGazagcnNMs5u43NKaMjhnlT
         yyryOz+eky4nr/3SmuNVyHBEkVBxKt0ER8QfdJlytIw3hQ6t4tNHBT0ALjAJ5h5ahlaR
         MgHGN8YlvNfvhexi7WVHaty1aqDYFRwfiD1995UfhjbAaRkQRstgYFBgAC76e9vc5IDG
         moJ+tuMJCZ8BLzGL+GAnpQbGXRsIwQhbvGt+gpam1egv2ql8mQZKLkhBO4jiJwGNlspG
         A/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScFF7njHyD7jDn62ILaf2pwzv53IErIyozW137RkZM0=;
        b=PxYxTCulypkmBKA3gNRemks4xI2rrKC0XVyCAdCbAWDDEC1TH2RBV48Z2w4llTL+fJ
         MtOoziYgwsUpbhdlSWayM82V4LozPNh04uN4gNYgxQPfY3RwFl7mEarwJYfHBOS+x9nl
         4PqrfItvqZhdOLnrXXGXNZINjOafX9EN5c1IibabvkuHvhs02xGYQguwuU9VxuLiRemK
         lUTv2v+Y3kx25HA5Rq7tY1KI9aZBYVt2b8BUW+z4m8KoZrU/fpMWeJwz9rC8Qblkhs5J
         GJM31qbGY6aQdijm4kfFM/qdZ5TDOsBpRUPlrYy9U0bfR/9z5HIIrRW9fEScoyuFblCc
         hyGA==
X-Gm-Message-State: AOAM531vYOB03Wu+qpVuk9tdHeWO8ayKcUamnkAO+Cz2CUq5J44zfF9a
        vw0mSAjK1sUHgs25566ZIP5wRgLF4n7nddrIPX5fTg==
X-Google-Smtp-Source: ABdhPJxbwDIjheT+o4oKTyGMAComWN78ZyxllrySrcHb7r4wjwdFMy3lplV2zL9ugp6yz8B9vQ4JaPEY2bM8GFMUBVk=
X-Received: by 2002:a1c:81c6:: with SMTP id c189mr1202580wmd.124.1599760710591;
 Thu, 10 Sep 2020 10:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200910032632.511566-1-irogers@google.com> <20200910032632.511566-3-irogers@google.com>
 <CAM9d7cjCV8qb2M9CW+NV2KpCwBTBAMWyE36yAL5SMFQ4wfxJfQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjCV8qb2M9CW+NV2KpCwBTBAMWyE36yAL5SMFQ4wfxJfQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Sep 2020 10:58:18 -0700
Message-ID: <CAP-5=fUCt0s-SV+7MSccvG3rWOhFVu83VVxKE5CwF7QCfJXpYw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf metricgroup: Fix uncore metric expressions
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 10:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Thu, Sep 10, 2020 at 12:26 PM Ian Rogers <irogers@google.com> wrote:
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
> >             126.97 MiB  uncore_imc/cas_count_write/
> >      1,003,019,728 ns   duration_time
> >
> > v2. avoids iterating over the whole evlist as suggested by
> >     namhyung@kernel.org. It also fixes the metric_leader computation
> >     that was broken in the same commits.
> >
> > Erroneous duplication introduced in:
> > commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").
> >
> > Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
> > Reported-by: Jin Yao <yao.jin@linux.intel.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/metricgroup.c | 45 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 42 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 662f4e8777d5..79080de9217d 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -206,6 +206,18 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >                                 sizeof(struct evsel *) * idnum);
> >                         current_leader = ev->leader;
> >                 }
> > +               /*
> > +                * Check for duplicate events with the same name. For example,
> > +                * uncore_imc/cas_count_read/ will turn into 6 events per socket
> > +                * on skylakex. Only the first such event is placed in
> > +                * metric_events.
> > +                */
> > +               for (i = 0; i < matched_events; i++) {
> > +                       if (!strcmp(metric_events[i]->name, ev->name))
> > +                               break;
> > +               }
> > +               if (i != matched_events)
> > +                       continue;
>
> We have the same logic in the below.  Maybe it'd better to factor out..

You're right, actually with this loop the below is redundant.

>
> >                 if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
> >                         if (has_constraint) {
> >                                 /*
> > @@ -245,9 +257,36 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >         metric_events[idnum] = NULL;
> >
> >         for (i = 0; i < idnum; i++) {
> > -               ev = metric_events[i];
> > -               ev->metric_leader = ev;
> > -               set_bit(ev->idx, evlist_used);
> > +               /* Don't free used events. */
> > +               set_bit(metric_events[i]->idx, evlist_used);
> > +               /*
> > +                * The metric leader points to the identically named event in
> > +                * metric_events.
> > +                */
> > +               metric_events[i]->metric_leader = metric_events[i];
> > +               /*
> > +                * Mark two events with identical names in the same group (or
> > +                * globally) as being in use as uncore events may be duplicated
> > +                * for each pmu. Set the metric leader to be the event that
> > +                * appears in metric_events.
> > +                */
>
> I thought this again, and it's not guaranteed that the metric leader is
> a group leader so below won't work IMHO.  Instead we should iterate
> evlist always, but started from the metric leader with the
> evlist__for_each_entry_continue.

Thanks for pointing out evlist__for_each_entry_continue! For the
constraint case it avoids iterating a bunch of list elements. For the
sibling group case we do know that all the metric's events are
siblings with the exception of duration time that is pulled out
specially and not at risk of being aliased.

Thanks,
Ian

> Thanks
> Namhyung
>
>
> > +               if (!has_constraint) {
> > +                       for_each_group_evsel(ev, metric_events[i]->leader) {
> > +                               if (ev != metric_events[i] &&
> > +                                   !strcmp(metric_events[i]->name, ev->name)) {
> > +                                       set_bit(ev->idx, evlist_used);
> > +                                       ev->metric_leader = metric_events[i];
> > +                               }
> > +                       }
> > +               } else {
> > +                       evlist__for_each_entry(perf_evlist, ev) {
> > +                               if (ev != metric_events[i] &&
> > +                                   !strcmp(metric_events[i]->name, ev->name)) {
> > +                                       set_bit(ev->idx, evlist_used);
> > +                                       ev->metric_leader = metric_events[i];
> > +                               }
> > +                       }
> > +               }
> >         }
> >
> >         return metric_events[0];
> > --
> > 2.28.0.526.ge36021eeef-goog
> >
