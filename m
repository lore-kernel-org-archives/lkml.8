Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228AEC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D658D21D7B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599645199;
	bh=9+azOBmQAbvrkoBP3shjYeyaD0BqltDrloM4QLv2reo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1x/NtiTc9L2DFyfBEac0knAOpf/5Wv0VW0PUMfvzYxTecYoWrNxwwA8LahbpssQwb
	 HJTK1K+m+TzwFohc1rnx4I+7scOwJ+dkzylDFlkf6GDG8u553lsEEKHYXNZYcIUm60
	 an+u1PspQPWqLJidzlusQpEXXOJz02jfmbJ3fOZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIIJxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:53:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54196 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgIIJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:53:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id x23so1655920wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 02:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vmWMH1A25UpofAkiL5wYFS/ULJOPz3j8rpLW3h7/cY=;
        b=EsGYWbAikEBRjcc/sujs6iy5BBhfmQmVnJRGQa5XvZAXkK+fXYq/Z5fmHKs7+J/ybd
         1EQGPlyKvThof5DpL1/GEOSX9i81iLu5pIizRtjjpIRmxO3rRaAYtvEpj6o2gfnoyjOs
         rKrGDBOTA2c45mB1fGYdj/Ox8oY/pX6aEC++svM/7HZVniJY5mHdSdHFds4XSah7+/5Y
         x40rZ/v892emcZxJ4xzjfaBLFAWmS/i5yM3u99eslnGNeJnHb1cKkBnXCwJb6M35iRAv
         DzwuMTwFgrURBvXEjat4oQq2HKQeUZ//D8PA8mGwl+/wXxQxnezyPeDfwzp4ggFcD/A0
         4yDw==
X-Gm-Message-State: AOAM530wljwCR/PfWvQxj+qU6DJo4ALKWfUZ8tVfjDO6pGNQK/W3azsK
        GJDLK7YpEcf3ZYYTHWJs17scylxuXMqrU+ifVoA=
X-Google-Smtp-Source: ABdhPJxl8uaVSt53fPgQQJ9q3iYyv41oDWaotXGBv9wGvkc5B8gNOHukYLVXL7f3e1UZJfLijSgZoahs2Iv9QpfMiFw=
X-Received: by 2002:a1c:6341:: with SMTP id x62mr2728082wmb.70.1599645192671;
 Wed, 09 Sep 2020 02:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200909080220.254585-1-irogers@google.com> <20200909080220.254585-2-irogers@google.com>
In-Reply-To: <20200909080220.254585-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 9 Sep 2020 18:53:01 +0900
Message-ID: <CAM9d7cgNNBw0d2c39+1D=0peGrxRV3P33aoczKMu5Qxffkd2CQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf metricgroup: Fix uncore metric expressions
To:     Ian Rogers <irogers@google.com>
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

Hi Ian,

On Wed, Sep 9, 2020 at 5:02 PM Ian Rogers <irogers@google.com> wrote:
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

Hmm.. I guess the 0.00 result is incorrect, no?


>             126.97 MiB  uncore_imc/cas_count_write/
>      1,003,019,728 ns   duration_time
>
> Erroneous duplication introduced in:
> commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").
>
> Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
> Reported-by: Jin, Yao <yao.jin@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> @@ -248,6 +260,16 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>                 ev = metric_events[i];
>                 ev->metric_leader = ev;
>                 set_bit(ev->idx, evlist_used);
> +               /*
> +                * Mark two events with identical names in the same group as
> +                * being in use as uncore events may be duplicated for each pmu.
> +                */
> +               evlist__for_each_entry(perf_evlist, ev) {
> +                       if (metric_events[i]->leader == ev->leader &&
> +                           !strcmp(metric_events[i]->name, ev->name)) {
> +                               set_bit(ev->idx, evlist_used);

I'm not sure whether they are grouped together.
But if so, you can use for_each_group_member(ev, leader).

Thanks
Namhyung


> +                       }
> +               }
>         }
>
>         return metric_events[0];
> --
> 2.28.0.526.ge36021eeef-goog
>
