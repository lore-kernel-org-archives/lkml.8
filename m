Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723A2C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3D32075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWi1lrV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgEFWqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgEFWqL (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:46:11 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE5C061A0F
        for <Linux-kernel@vger.kernel.org>; Wed,  6 May 2020 15:46:11 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id o198so1861330ybg.10
        for <Linux-kernel@vger.kernel.org>; Wed, 06 May 2020 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjRTwHggWiwM4X6xKecNjuKevakeacekowAHtGUdnQA=;
        b=JWi1lrV3wsChCcXjeiJ9huwyv/r4heBAPZrWDMYxhSgeHd5ZZzrrtl8TNlel24DLAP
         054FlgpJh8j1sN6zGPdA7bglW+0GBhjtMdPgLXc6ofVrIqZUGdrOx9GrohoH6u2IBAPL
         rm/ca62Q5PCukvsthFMRjNYrdZLuDs6+ACDWbKtB4tVHTWZ8eQkYbDuYzBhmZJSJMCVu
         Oug3pOYyt3PMl97Kd8/RCNx2vudi43bI/vSiD+gmf5d6mSl3mjwBsnbyf6PmOlJlWnfW
         upwS/BIqcl6lhveO/VGvt6acPoz2KlGCvh3UD+skLtSCOKWyippdzkqd46R6lFd91B0l
         TMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjRTwHggWiwM4X6xKecNjuKevakeacekowAHtGUdnQA=;
        b=Lz1DMxpzI4sczu12EO2siqmtDcQIlN7IiE0L0KN5IByXLTipgXQ0BAKfknNIt0S7cM
         iXcQiKnntoomgtw9hYR7JiWUtRBxWzx5zIrH4wtAmSuDVSpKxhEIwOZOl5f6BDkNIFYm
         TCsLFJEm0vc5fx3p/6BdArB61NSXg4lSpx2gXclbsGODHHbbxHgiA/gcbPb3tvhuA9yq
         PhQaF00p/rLckTWs9pXqh7MPEvVPYe400rvV5vCuQHfmEqQkJ9g6SleQjcjGFHQC2z3T
         xeATZIAv/uk2W+4jiQAtJ/np+w6lfxxaeH1pximvnrN85x2m0EcIQDovCCfwQpDmrOIT
         WJaQ==
X-Gm-Message-State: AGi0PuZc7iaOOP2ZJUshzkbjqlf/Icj+sEQBzTpe9IQ9XgvDJh4dTQDN
        8YWZKQHh8/80fGtAwOHGy4QprK0kGEv3sl0Gubpl0w==
X-Google-Smtp-Source: APiQypJVkauLZl4RM85aNILemYh6DIXQPD8BNnf8f9PmxLTsPtTuE61ClBlB5njsTTNQZZ/zSTzUvdltz+mOh9u63I0=
X-Received: by 2002:a25:77d8:: with SMTP id s207mr16003960ybc.47.1588805170245;
 Wed, 06 May 2020 15:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200430003618.17002-1-yao.jin@linux.intel.com>
 <20200430084529.GC1681583@krava> <fc51012d-66c7-3e93-07df-22411b23fa8f@linux.intel.com>
 <20200430153253.GF1694693@krava>
In-Reply-To: <20200430153253.GF1694693@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 May 2020 15:45:59 -0700
Message-ID: <CAP-5=fVLGfr-bYgR=vt0g-0TtxB+-1mLPt59WfiPEPTtRdQh2Q@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: Use strcmp to compare the PMU name
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        yao.jin@intel.com, John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 8:33 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Apr 30, 2020 at 09:45:14PM +0800, Jin, Yao wrote:
> > Hi Jiri,
> >
> > On 4/30/2020 4:45 PM, Jiri Olsa wrote:
> > > On Thu, Apr 30, 2020 at 08:36:18AM +0800, Jin Yao wrote:
> > > > A big uncore event group is split into multiple small groups which
> > > > only include the uncore events from the same PMU. This has been
> > > > supported in the commit 3cdc5c2cb924a ("perf parse-events: Handle
> > > > uncore event aliases in small groups properly").
> > > >
> > > > If the event's PMU name starts to repeat, it must be a new event.
> > > > That can be used to distinguish the leader from other members.
> > > > But now it only compares the pointer of pmu_name
> > > > (leader->pmu_name == evsel->pmu_name).
> > > >
> > > > If we use "perf stat -M LLC_MISSES.PCIE_WRITE -a" on cascadelakex,
> > > > the event list is:
> > > >
> > > > evsel->name                                       evsel->pmu_name
> > > > ---------------------------------------------------------------
> > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_4 (as leader)
> > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_2
> > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_0
> > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_5
> > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_3
> > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_1
> > > > unc_iio_data_req_of_cpu.mem_write.part1           uncore_iio_4
> > > > ......
> > > >
> > > > For the event "unc_iio_data_req_of_cpu.mem_write.part1" with
> > > > "uncore_iio_4", it should be the event from PMU "uncore_iio_4".
> > > > It's not a new leader for this PMU.
> > > >
> > > > But if we use "(leader->pmu_name == evsel->pmu_name)", the check
> > > > would be failed and the event is stored to leaders[] as a new
> > > > PMU leader.
> > > >
> > > > So this patch uses strcmp to compare the PMU name between events.
> > > >
> > > > Fixes: 3cdc5c2cb924a ("perf parse-events: Handle uncore event aliases in small groups properly")
> > > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > >
> > > looks good, any chance we could have automated test
> > > for this uncore leader setup logic? like maybe the way
> > > John did the pmu-events tests? like test will trigger
> > > only when there's the pmu/events in the system
> > >
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > >
> > > thanks,
> > > jirka
> > >
> > >
> >
> > I'm considering to use LKP to do the sanity tests for all perf events
> > (core/uncore) and perf metrics periodically. It may help us to find the
> > regressions on time.
>
> sounds good ;) thanks
>
> jirka

I've tested this and would be happy to see this merged. John's bisect
found a memory leak fix of mine as the culprit.

Wrt testing, libbpf is using github/travis CI:
https://github.com/libbpf/libbpf
https://travis-ci.org/libbpf/libbpf
Perhaps that kind of set up can automate testing and lower the
reviewer burden - but there's upfront cost in setting it up.

Thanks,
Ian
