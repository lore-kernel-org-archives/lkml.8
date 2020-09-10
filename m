Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677A6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEDB2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599717221;
	bh=zNSwgCKektJyCmVa7uAqvjhw0X3FzQvi+7JzFdkC6fk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F3uUz2bSFL2j+wchG9jXnl4uKCbcsJ3ux3uv0GlcoZIbyV3CSdsCQj9aB9yo4sdNU
	 AmakT+YcxVRdd+f/b9zTQtOg7EhkKW7opWPupPrJjLc4SX+cxhjeudTxTewUycCTng
	 2H3+jQZ5PVjTiescl4f7tZOtw7Onxu0prQ/D9gZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgIJFxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:53:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39628 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgIJFv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:51:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id a17so5263935wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5QxPgDamejxhn6ECEdmwxgpxU3vLhZVPh3TAfAaIes=;
        b=sqcJtooLNuEI/mFetvU/GFvBItHCa/xco2p6D5qWW4C++WfjwH90hP426uJD8358I+
         bJ34MT0f7rz4v/ZVZjy18utgEIThVrzuZSnjtS7NI+ps7gJrduUAl/8fTk0TJWx5IVUB
         nNEfKksUj0pJZDkgGhp7x0Kd11PIpP4HxABPIq8NCQlBs2Kuv6uskRPi1UvEbFSmHpOY
         1Xx4c3l/IiMy/PnubimPVuJPYXtGY3NomzLVo+cv62IBDEHm60iNOWGN+23KOle7W0n7
         w4HnxK6z1+GBvjLe4Zm+xutrLiPCuKWQwJKos35FPhwOsMnPnx/cIrvo8BKn6/EKXNf6
         d9dA==
X-Gm-Message-State: AOAM530FUwumlUxWL7eJSbn6jyLtZPpxXXTvHDFL53LM5kqV7F+RRG32
        pRwd6uxgoz9NVteBvBJCoQz0+pfoV7YKsVg5Fug=
X-Google-Smtp-Source: ABdhPJwcAFjZQdLTE0ZVu58CdJSUYlW3kZdTBMqFRrislYy7UHFrhU194SQhy0Ck6lT4drv3BoG6EMuqkB2WSypJAsk=
X-Received: by 2002:adf:82d5:: with SMTP id 79mr7962253wrc.60.1599717084918;
 Wed, 09 Sep 2020 22:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200910032632.511566-1-irogers@google.com> <20200910032632.511566-3-irogers@google.com>
In-Reply-To: <20200910032632.511566-3-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Sep 2020 14:51:13 +0900
Message-ID: <CAM9d7cjCV8qb2M9CW+NV2KpCwBTBAMWyE36yAL5SMFQ4wfxJfQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf metricgroup: Fix uncore metric expressions
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

On Thu, Sep 10, 2020 at 12:26 PM Ian Rogers <irogers@google.com> wrote:
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
> ---
>  tools/perf/util/metricgroup.c | 45 ++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 662f4e8777d5..79080de9217d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -206,6 +206,18 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>                                 sizeof(struct evsel *) * idnum);
>                         current_leader = ev->leader;
>                 }
> +               /*
> +                * Check for duplicate events with the same name. For example,
> +                * uncore_imc/cas_count_read/ will turn into 6 events per socket
> +                * on skylakex. Only the first such event is placed in
> +                * metric_events.
> +                */
> +               for (i = 0; i < matched_events; i++) {
> +                       if (!strcmp(metric_events[i]->name, ev->name))
> +                               break;
> +               }
> +               if (i != matched_events)
> +                       continue;

We have the same logic in the below.  Maybe it'd better to factor out..


>                 if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
>                         if (has_constraint) {
>                                 /*
> @@ -245,9 +257,36 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>         metric_events[idnum] = NULL;
>
>         for (i = 0; i < idnum; i++) {
> -               ev = metric_events[i];
> -               ev->metric_leader = ev;
> -               set_bit(ev->idx, evlist_used);
> +               /* Don't free used events. */
> +               set_bit(metric_events[i]->idx, evlist_used);
> +               /*
> +                * The metric leader points to the identically named event in
> +                * metric_events.
> +                */
> +               metric_events[i]->metric_leader = metric_events[i];
> +               /*
> +                * Mark two events with identical names in the same group (or
> +                * globally) as being in use as uncore events may be duplicated
> +                * for each pmu. Set the metric leader to be the event that
> +                * appears in metric_events.
> +                */

I thought this again, and it's not guaranteed that the metric leader is
a group leader so below won't work IMHO.  Instead we should iterate
evlist always, but started from the metric leader with the
evlist__for_each_entry_continue.

Thanks
Namhyung


> +               if (!has_constraint) {
> +                       for_each_group_evsel(ev, metric_events[i]->leader) {
> +                               if (ev != metric_events[i] &&
> +                                   !strcmp(metric_events[i]->name, ev->name)) {
> +                                       set_bit(ev->idx, evlist_used);
> +                                       ev->metric_leader = metric_events[i];
> +                               }
> +                       }
> +               } else {
> +                       evlist__for_each_entry(perf_evlist, ev) {
> +                               if (ev != metric_events[i] &&
> +                                   !strcmp(metric_events[i]->name, ev->name)) {
> +                                       set_bit(ev->idx, evlist_used);
> +                                       ev->metric_leader = metric_events[i];
> +                               }
> +                       }
> +               }
>         }
>
>         return metric_events[0];
> --
> 2.28.0.526.ge36021eeef-goog
>
