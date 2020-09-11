Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738EEC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E4B208A9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599793672;
	bh=opLyeOSHTRjFoc96A/yV92cybgMaRloSyPltgGSSZWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hOCqhZwQgGO3Z6ToR8czGKIshH25t+bzKREZjTLGwaSYr2/rvv0dnOVgpAkHkXN4s
	 ld8izoZVrn/ZXLZI9Qc5+KUaY4RBa9VPwbWp0wbQp6AoLiRekj/25wy2XXkn5EhuvC
	 Of7viJUEITKrHDw01svsbDIFr8aG0iuCym4B7vvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgIKDHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:07:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33675 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKDHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:07:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id m6so9990389wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 20:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qgSu72sdlC0fW9onlXxHrtdDJYX3P6lc30tqeyzrxc=;
        b=AF0jHfYMxNi3h+Dk3mtU87A4lDed+16W7pO0VVPDuPtWiOe+X4RKg2y4jp/5Sm3ELh
         bbRTz0z7ff0bKNzEr4WRfv0MiAO8nFGKI7/xhW7jtXbwLwi4IRDDyETGyvmyG7bE9aW7
         mdrF1yKa/RPV3TqeArCqi+fhBlg6CASRmep6/qZQ/57B6BCcg04odLO4sStfzUbUIgiW
         +lYYreyQONOms+QqtVCVjjewT61jawH0gkZJz8aOgHvyIGpXKLgbfRQd6LeDLj7iwF2F
         tR5MUMZozvZUaBsJIh7TTJn8hPx+xCXVjQjIDhUdD9x6y+K0fT41Y04l3dDKsaPnUl4m
         kDTA==
X-Gm-Message-State: AOAM533gTVNOXOzS4fLW80pdPDjEZJ/sw1ps/83ICZZE0dbD4sO//nF4
        kRjW2jODPDpnmj8G06W0yEUHDkG0ZyqU2RfZ3ahs+wlnx+0=
X-Google-Smtp-Source: ABdhPJw3IW2aqZ0H/w71ytLwxU6s6OEMt3m3YPy0K4zRMFDLfr4VtneFS9t1NIxHJtzyeZ1tSI6S/kyL0s6xoF1Qt9g=
X-Received: by 2002:adf:8b48:: with SMTP id v8mr12001515wra.21.1599793666738;
 Thu, 10 Sep 2020 20:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200910180231.786751-1-irogers@google.com>
In-Reply-To: <20200910180231.786751-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 11 Sep 2020 12:07:35 +0900
Message-ID: <CAM9d7cjLpE=cKfemsuokc57-5kzezRr3YzqOKZb9Pf4r4-X8+g@mail.gmail.com>
Subject: Re: [PATCH v3] perf metricgroup: Fix uncore metric expressions
To:     Ian Rogers <irogers@google.com>
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

On Fri, Sep 11, 2020 at 3:02 AM Ian Rogers <irogers@google.com> wrote:
>
> A metric like DRAM_BW_Use has on SkylakeX events uncore_imc/cas_count_read/
> and uncore_imc/case_count_write/. These events open 6 events per socket
> with pmu names of uncore_imc_[0-5]. The current metric setup code in
> find_evsel_group assumes one ID will map to 1 event to be recorded in
> metric_events. For events with multiple matches, the first event is
> recorded in metric_events (avoiding matching >1 event with the same
> name) and the evlist_used updated so that duplicate events aren't
> removed when the evlist has unused events removed.
>
> Before this change:
> $ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1
>
>  Performance counter stats for 'system wide':
>
>              41.14 MiB  uncore_imc/cas_count_read/
>      1,002,614,251 ns   duration_time
>
>        1.002614251 seconds time elapsed
>
> After this change:
> $ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1
>
>  Performance counter stats for 'system wide':
>
>             157.47 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
>             126.97 MiB  uncore_imc/cas_count_write/
>      1,003,019,728 ns   duration_time
>
> v3. cleans up searching for the same event within metric_events to use a
>     helper and avoids a redundant search. It uses a continue loop to
>     make the search for similarly named events shorter.
> v2. avoids iterating over the whole evlist as suggested by
>     namhyung@kernel.org. It also fixes the metric_leader computation
>     that was broken in the same commits.
>
> Erroneous duplication introduced in:
> commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").
>
> Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
> Reported-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


> ---
>  tools/perf/util/metricgroup.c | 75 ++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 662f4e8777d5..7b66452cb9f9 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -149,6 +149,18 @@ static void expr_ids__exit(struct expr_ids *ids)
>                 free(ids->id[i].id);
>  }
>
> +static bool contains_event(struct evsel **metric_events, int num_events,
> +                       const char *event_name)
> +{
> +       int i;
> +
> +       for (i = 0; i < num_events; i++) {
> +               if (!strcmp(metric_events[i]->name, event_name))
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  /**
>   * Find a group of events in perf_evlist that correspond to those from a parsed
>   * metric expression. Note, as find_evsel_group is called in the same order as
> @@ -179,7 +191,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>         int i = 0, matched_events = 0, events_to_match;
>         const int idnum = (int)hashmap__size(&pctx->ids);
>
> -       /* duration_time is grouped separately. */
> +       /*
> +        * duration_time is always grouped separately, when events are grouped
> +        * (ie has_constraint is false) then ignore it in the matching loop and
> +        * add it to metric_events at the end.
> +        */
>         if (!has_constraint &&
>             hashmap__find(&pctx->ids, "duration_time", (void **)&val_ptr))
>                 events_to_match = idnum - 1;
> @@ -206,23 +222,20 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>                                 sizeof(struct evsel *) * idnum);
>                         current_leader = ev->leader;
>                 }
> -               if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
> -                       if (has_constraint) {
> -                               /*
> -                                * Events aren't grouped, ensure the same event
> -                                * isn't matched from two groups.
> -                                */
> -                               for (i = 0; i < matched_events; i++) {
> -                                       if (!strcmp(ev->name,
> -                                                   metric_events[i]->name)) {
> -                                               break;
> -                                       }
> -                               }
> -                               if (i != matched_events)
> -                                       continue;
> -                       }
> +               /*
> +                * Check for duplicate events with the same name. For example,
> +                * uncore_imc/cas_count_read/ will turn into 6 events per socket
> +                * on skylakex. Only the first such event is placed in
> +                * metric_events. If events aren't grouped then this also
> +                * ensures that the same event in different sibling groups
> +                * aren't both added to metric_events.
> +                */
> +               if (contains_event(metric_events, matched_events, ev->name))
> +                       continue;
> +               /* Does this event belong to the parse context? */
> +               if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr))
>                         metric_events[matched_events++] = ev;
> -               }
> +
>                 if (matched_events == events_to_match)
>                         break;
>         }
> @@ -238,7 +251,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>         }
>
>         if (matched_events != idnum) {
> -               /* Not whole match */
> +               /* Not a whole match */
>                 return NULL;
>         }
>
> @@ -246,8 +259,32 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>
>         for (i = 0; i < idnum; i++) {
>                 ev = metric_events[i];
> -               ev->metric_leader = ev;
> +               /* Don't free the used events. */
>                 set_bit(ev->idx, evlist_used);
> +               /*
> +                * The metric leader points to the identically named event in
> +                * metric_events.
> +                */
> +               ev->metric_leader = ev;
> +               /*
> +                * Mark two events with identical names in the same group (or
> +                * globally) as being in use as uncore events may be duplicated
> +                * for each pmu. Set the metric leader of such events to be the
> +                * event that appears in metric_events.
> +                */
> +               evlist__for_each_entry_continue(perf_evlist, ev) {
> +                       /*
> +                        * If events are grouped then the search can terminate
> +                        * when then group is left.
> +                        */
> +                       if (!has_constraint &&
> +                           ev->leader != metric_events[i]->leader)
> +                               break;
> +                       if (!strcmp(metric_events[i]->name, ev->name)) {
> +                               set_bit(ev->idx, evlist_used);
> +                               ev->metric_leader = metric_events[i];
> +                       }
> +               }
>         }
>
>         return metric_events[0];
> --
> 2.28.0.526.ge36021eeef-goog
>
