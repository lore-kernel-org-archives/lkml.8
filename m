Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412C0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE0B2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="El7SegGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgHCPy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgHCPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:54:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DC0C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 08:54:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k20so59436wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slx0T/61/kBkje+VgygjK5EF0iAmWExpUdKWBN4DQu0=;
        b=El7SegGhgmlVjZSXK9LFNbEa5SXGe5QjXxZBHpKNiLGpFUO+xyZDK4cAnp6mLgWCE8
         DyMMwFY40ZmDAKwqZEifdcbuYqhMRLfqFg+o3kRCB1G4aK3f7SP4R2CsAiRGG9F70YhJ
         ykfhwEEjRxUe5mApbThptFSz7PYIVL6GQsNNHwataU19jpZywK2aAX0qOU1SRVLX8h00
         OkVQ39g6OR/wdlqZQIBV34z+LAhI/m2pobjD7J1ktyYHmxSjWK11ZlgJZpU4Whw1WxG0
         s0tPnaN8L+nXRHCyhF9211Oz/QUXKyoHyQPoU6SXJcloNqNhJSmTj0+urvF0ofxRmgCT
         +ZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slx0T/61/kBkje+VgygjK5EF0iAmWExpUdKWBN4DQu0=;
        b=NnLlCoNBk+y6CYBxUQsS0F1EHxdN/7C3gjnMJJmUcEecM/Vk75D8b/bEVZPRYrPSGo
         QD6VeaMuw2szfp26cB4Rrfx77un7T51o2YUItVhoFP4525FWU3QuJCrJaJ2+tfSshvFF
         R24J/JOGKVbdTGXu8okReqRFg5LNKkArCwwUgPqfqMtj4slWtKoWmLK/SzntYQMHwotl
         FkjUdyPwwZolf/8BsegwOzLVr26iPCZjcJEFNIregQBF0RNDxt2MVJvV6gXYrp1LEj/S
         PJBxW2O0FJ/zbb0d6aiZ4GSVjoj3WG8zWgqHHpAVWivR16Zod4kdssNTTFj7pdbW0U7S
         tZ/g==
X-Gm-Message-State: AOAM532uRyA925I3BJoexag0op0l6RMcuXI6OpYg+upKaQ0Iz6RQw/3f
        xWULFvrl69fhnNQLTsuYFYvQquMvQkBbe0LemQadOg==
X-Google-Smtp-Source: ABdhPJzM9u8R5oum7uRM/EZlBGfcxVu+JeJDr5FqKavtE27ufcZAGJg6WDSIyIouN1kkxuy8PRBCoBPLyLt8ctEUOoU=
X-Received: by 2002:a1c:a914:: with SMTP id s20mr579819wme.76.1596470067410;
 Mon, 03 Aug 2020 08:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200729091908.1378911-1-jolsa@kernel.org> <20200801114050.GB377079@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
In-Reply-To: <20200801114050.GB377079@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 3 Aug 2020 08:54:16 -0700
Message-ID: <CAP-5=fUjMH-VHaLhNjBhk4pSsAGs_9kUuy1N68RRF4d6E5e5Lg@mail.gmail.com>
Subject: Re: [PATCHv4 00/19] perf metric: Add support to reuse metric
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 4:41 AM Paul A. Clarke <pc@us.ibm.com> wrote:
>
> On Wed, Jul 29, 2020 at 11:18:49AM +0200, Jiri Olsa wrote:
> > this patchset is adding the support to reused metric in
> > another metric.
> >
> > For example, to define IPC by using CPI with change like:
> >
> >      {
> >          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> > -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> > +        "MetricExpr": "1/CPI",
> >          "MetricGroup": "TopDownL1",
> >          "MetricName": "IPC"
> >      },
> >
> > I won't be able to find all the possible places we could
> > use this at, so I wonder you guys (who was asking for this)
> > would try it and come up with comments if there's something
> > missing or we could already use it at some places.
> >
> > It's based on Arnaldo's tmp.perf/core.
> >
> > v4 changes:
> >   - removed acks from patch because it changed a bit
> >     with the last fixes:
> >       perf metric: Collect referenced metrics in struct metric_ref_node
> >   - fixed runtime metrics [Kajol Jain]
> >   - increased recursion depth [Paul A. Clarke]
> >   - changed patches due to dependencies:
> >       perf metric: Collect referenced metrics in struct metric_ref_node
> >       perf metric: Add recursion check when processing nested metrics
> >       perf metric: Rename struct egroup to metric
> >       perf metric: Rename group_list to metric_list
> >
> > Also available in here:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/metric
>
> I built and ran from the above git branch, and things seem to work.
> Indeed, I was able to apply my changes to exploit the new capabilities
> via modifications to tools/perf/pmu-events/arch/powerpc/power9/metrics.json,
> as I posted earlier (and will submit once this set gets merged).
>
> Tested-by: Paul A. Clarke <pc@us.ibm.com>
>
> One thing I noted, but which also occurs without these patches, is that
> the perf metrics are not computed unless run as root:
> --
> $ perf stat --metrics br_misprediction_percent command
>
>  Performance counter stats for 'command':
>
>      1,823,530,051      pm_br_pred:u
>          2,662,705      pm_br_mpred_cmpl:u
>
> $ /usr/bin/sudo perf stat --metrics br_misprediction_percent command
>
>  Performance counter stats for 'command':
>
>      1,824,655,269      pm_br_pred                #     0.09 br_misprediction_percent
>          1,654,466      pm_br_mpred_cmpl
> --
>
> Is that expected?  I don't think it's always been that way.

I agree Paul, this seems broken. I've noticed a bunch of issues with
printing CSV, per-socket output and so on. Jiri may have a better idea
but I plan to look at problems in this area later, and hopefully stick
a few tests on it :-)

Thanks,
Ian

> PC
