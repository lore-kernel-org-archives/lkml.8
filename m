Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72FBC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3609B207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599717466;
	bh=SG9T17IuK3lmX5vee4ILoHmxQeuvh0dOCUToOjXugKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SLETCqGhHSAfetXG8wGvkW2Hgc3LNKiRTzm2aS6FITN6NPhdzRHzwt0xNH7hEX5GS
	 jNUOXeehL+kNhQfv2hvPitb6SfDaUIi3I48RP4d6dkon9/eb6wUgMpoSyqV3STukL9
	 eY3uSpQ2wiGN+qYG2IdJhRoeOobqDqNfPC7jZ6mI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIJF5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:57:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39175 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgIJFzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:55:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id b79so4487056wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvZkjyShERvI57/NBFUbYSsp42DvHL3T5wvzV0T9JAg=;
        b=qRcvV8yckNgzf+O8em5zy/xLT/Gi/YCOS2UT63GZrURqAqqrlZjV8AKdc9t+GhBG5Y
         23K2hsNLkSyyN95eNTeAzP93U4foxe3skZpaSiI2oTFyGrjTI3zlddizJt5XLdxLCQzc
         vmXKbdZjfG203UqtogZYephn58EMvoROigXOp0bwX1YSdAiBVLdIa4mvsCj94O/isGdh
         lXWIrQOeD3NwE+5GNr9WeujrItaDqT1OQGD1zZmsi2LVVWR4pEpunHkm6cI+8dBER9Xp
         hPinX/rv00Wv2QY30xr/2SeKSpFbd5LZ6mbXiSUt89pAGJ+QzUan/R7Pubv8XoIu1ltm
         MYRw==
X-Gm-Message-State: AOAM532mOmgGiFbXw6rG9LsvpgIObstupnSvCwgdmH/fWq67z8kZvMC/
        2XkAde6Kj3PKjKw8/HAgY5pgxjLi2REEPpmn+L0=
X-Google-Smtp-Source: ABdhPJw1mCjyHQL52hdOyQPfkkSO+SkJ6mmRjeB1rKC6OvPPLfaQecbUYJvxMbq8pVhuuce2GN6A35+NLWdHY3kRkuI=
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr7016715wmt.92.1599717346013;
 Wed, 09 Sep 2020 22:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200909080220.254585-1-irogers@google.com> <20200909080220.254585-2-irogers@google.com>
 <CAM9d7cgNNBw0d2c39+1D=0peGrxRV3P33aoczKMu5Qxffkd2CQ@mail.gmail.com>
 <CAP-5=fUH3w+UckdzqkUvp0vAz1gFMqrYNF6wE8ib5kPjXqM2Yg@mail.gmail.com> <CAP-5=fVP8p==J-K59Oo6WvZCafnsFAux3g3vW-wLKHqaASyveQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVP8p==J-K59Oo6WvZCafnsFAux3g3vW-wLKHqaASyveQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Sep 2020 14:55:34 +0900
Message-ID: <CAM9d7cg+tzp=5QDF4ZA+NPrv-NY9LntRPinCi98yu-90C=Vfiw@mail.gmail.com>
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

On Thu, Sep 10, 2020 at 12:41 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Sep 9, 2020 at 10:52 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Sep 9, 2020 at 2:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Wed, Sep 9, 2020 at 5:02 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > A metric like DRAM_BW_Use has on SkylakeX events uncore_imc/cas_count_read/
> > > > and uncore_imc/case_count_write/. These events open 6 events per socket
> > > > with pmu names of uncore_imc_[0-5]. The current metric setup code in
> > > > find_evsel_group assumes one ID will map to 1 event to be recorded in
> > > > metric_events. For events with multiple matches, the first event is
> > > > recorded in metric_events (avoiding matching >1 event with the same
> > > > name) and the evlist_used updated so that duplicate events aren't
> > > > removed when the evlist has unused events removed.
> > > >
> > > > Before this change:
> > > > $ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1
> > > >
> > > >  Performance counter stats for 'system wide':
> > > >
> > > >              41.14 MiB  uncore_imc/cas_count_read/
> > > >      1,002,614,251 ns   duration_time
> > > >
> > > >        1.002614251 seconds time elapsed
> > > >
> > > > After this change:
> > > > $ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1
> > > >
> > > >  Performance counter stats for 'system wide':
> > > >
> > > >             157.47 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
> > >
> > > Hmm.. I guess the 0.00 result is incorrect, no?
> >
> > Agreed. There are a number of pre-existing bugs in this code. I'll try
> > to look into this one.
>
> There was a bug where the metric_leader wasn't being set correctly and
> so the accumulation of values wasn't working as expected. There's a
> small fix in:
> https://lore.kernel.org/lkml/20200910032632.511566-3-irogers@google.com/T/#u
> that also does the change I mentioned below.
>
> The metric still remains at 0.0 following this change as I believe
> there is a bug in the metric. The metric expression is:
> "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) /
> 1000000000 ) / duration_time"
> ie the counts of uncore_imc/cas_count_read/ and
> uncore_imc/cas_count_write/ are being first being scaled up by 64,
> that is to turn a count of cache lines into bytes, the count is then
> divided by 1000000000 or a GB to supposedly give GB/s. However, the
> counts are read and scaled:
>
> ...
> void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
> ...
>   count *= counter->scale;
> ...
>
> The scale value from
> /sys/devices/uncore_imc_0/events/cas_count_read.scale is
> 6.103515625e-5 or 64/(1024*1024). This means the result of the
> expression is 64 times too large but in PB/s and so too small to
> display. I don't rule out there being other issues but this appears to
> be a significant one. Printing using intervals also looks suspicious
> as the count appears to just increase rather than vary up and down.

You're right!

Maybe we can change it to simply like below and change the unit to MiB/s?

( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / duration_time

Thanks
Namhyung
