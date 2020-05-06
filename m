Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF01C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA27206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/3mxwsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgEFXqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEFXqk (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:46:40 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4EFC061A0F
        for <Linux-kernel@vger.kernel.org>; Wed,  6 May 2020 16:46:40 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id c4so1796229qvi.6
        for <Linux-kernel@vger.kernel.org>; Wed, 06 May 2020 16:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=laSmCS31gEA41tuA8ZNrSPpS46j8yRqPinu80CqMU88=;
        b=R/3mxwspz3FlVkn3zYKAGxLVg5EDpiBtfT/ixr0OZqIy6VbW3btZKgRbSdMo457C9w
         27pNqYmZieLkjiipA70j/IZSXluimwiVZCjzGmYGMTjXvILQZvN+FR1KVVCBdX+Y5rO7
         1W5YoL0yrjWACfvXr/easyyyWHYgXEx6/1Y4yvhs5wVYg7z4DVw9IYgawInDa5XanqYt
         e5JktoOh9TXXYeY0p8cMMH9kI3xQmobzrCl53jtD6vHdLE6x4NwsacTdn9nqWfzeQeGk
         A3DBSNiTetuFsjXdWs8hOc4loJ7CxDY7INCenp76lXNnYqE5+JTHCUMCE9t/yqMBn6sF
         iiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=laSmCS31gEA41tuA8ZNrSPpS46j8yRqPinu80CqMU88=;
        b=P6huYnOo1oOwYA151oedOzjGITKq8tQeaIFnoQ9MtbyYV42z/idGRE0vR96vHR/Hnp
         aAF+qnvDvrsOeIW/wDMhQqmPTioPag5OHK+K458a7balC3PLa8qRcS2cWxUBORSZOz+g
         UA75Hm0Tda5IpOju9OJeijkdfBDkpBYo2rihLGGCswqIcBqC9yWWhLwoQpp966MIAeSh
         qnnEOkIoJZp5B40CsvrIndhJoaXEs4ws6XTY8fXN7i1xBcW6RFYCaUx8C4cvfbXBJ0+9
         1v0OewQaQ/8uId0ZWuMrOztL7pKS/Dd/fuhCksF+S7/VrGC1OZNe0NS8Tfe3ZSGZJlBM
         wtFA==
X-Gm-Message-State: AGi0PuYXB+qK90DU6haj9UXRwj46gHWY9XjiB7Y0n2C0sVRDP4ifZXWF
        zcPjR5W+LLHrsBtYmCBXfTA=
X-Google-Smtp-Source: APiQypJygM5y77jO7ltNrcVYexM1YLWtR4g1ASboE4xB+ctSmBdtfZId5qz6V4QX8CYr0k2YbLKjpg==
X-Received: by 2002:a0c:b5dd:: with SMTP id o29mr11130452qvf.87.1588808799130;
        Wed, 06 May 2020 16:46:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id e23sm2952077qkm.63.2020.05.06.16.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 16:46:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 64D7F409A3; Wed,  6 May 2020 20:46:36 -0300 (-03)
Date:   Wed, 6 May 2020 20:46:36 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, "Jin, Yao" <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        yao.jin@intel.com, John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] perf parse-events: Use strcmp to compare the PMU name
Message-ID: <20200506234636.GC5377@kernel.org>
References: <20200430003618.17002-1-yao.jin@linux.intel.com>
 <20200430084529.GC1681583@krava>
 <fc51012d-66c7-3e93-07df-22411b23fa8f@linux.intel.com>
 <20200430153253.GF1694693@krava>
 <CAP-5=fVLGfr-bYgR=vt0g-0TtxB+-1mLPt59WfiPEPTtRdQh2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVLGfr-bYgR=vt0g-0TtxB+-1mLPt59WfiPEPTtRdQh2Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 06, 2020 at 03:45:59PM -0700, Ian Rogers escreveu:
> On Thu, Apr 30, 2020 at 8:33 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Apr 30, 2020 at 09:45:14PM +0800, Jin, Yao wrote:
> > > Hi Jiri,
> > >
> > > On 4/30/2020 4:45 PM, Jiri Olsa wrote:
> > > > On Thu, Apr 30, 2020 at 08:36:18AM +0800, Jin Yao wrote:
> > > > > A big uncore event group is split into multiple small groups which
> > > > > only include the uncore events from the same PMU. This has been
> > > > > supported in the commit 3cdc5c2cb924a ("perf parse-events: Handle
> > > > > uncore event aliases in small groups properly").
> > > > >
> > > > > If the event's PMU name starts to repeat, it must be a new event.
> > > > > That can be used to distinguish the leader from other members.
> > > > > But now it only compares the pointer of pmu_name
> > > > > (leader->pmu_name == evsel->pmu_name).
> > > > >
> > > > > If we use "perf stat -M LLC_MISSES.PCIE_WRITE -a" on cascadelakex,
> > > > > the event list is:
> > > > >
> > > > > evsel->name                                       evsel->pmu_name
> > > > > ---------------------------------------------------------------
> > > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_4 (as leader)
> > > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_2
> > > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_0
> > > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_5
> > > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_3
> > > > > unc_iio_data_req_of_cpu.mem_write.part0           uncore_iio_1
> > > > > unc_iio_data_req_of_cpu.mem_write.part1           uncore_iio_4
> > > > > ......
> > > > >
> > > > > For the event "unc_iio_data_req_of_cpu.mem_write.part1" with
> > > > > "uncore_iio_4", it should be the event from PMU "uncore_iio_4".
> > > > > It's not a new leader for this PMU.
> > > > >
> > > > > But if we use "(leader->pmu_name == evsel->pmu_name)", the check
> > > > > would be failed and the event is stored to leaders[] as a new
> > > > > PMU leader.
> > > > >
> > > > > So this patch uses strcmp to compare the PMU name between events.
> > > > >
> > > > > Fixes: 3cdc5c2cb924a ("perf parse-events: Handle uncore event aliases in small groups properly")
> > > > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > >
> > > > looks good, any chance we could have automated test
> > > > for this uncore leader setup logic? like maybe the way
> > > > John did the pmu-events tests? like test will trigger
> > > > only when there's the pmu/events in the system
> > > >
> > > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > > >
> > > > thanks,
> > > > jirka
> > > >
> > > >
> > >
> > > I'm considering to use LKP to do the sanity tests for all perf events
> > > (core/uncore) and perf metrics periodically. It may help us to find the
> > > regressions on time.
> >
> > sounds good ;) thanks
> >
> > jirka
> 
> I've tested this and would be happy to see this merged. John's bisect
> found a memory leak fix of mine as the culprit.
> 
> Wrt testing, libbpf is using github/travis CI:
> https://github.com/libbpf/libbpf
> https://travis-ci.org/libbpf/libbpf
> Perhaps that kind of set up can automate testing and lower the
> reviewer burden - but there's upfront cost in setting it up.

Well, if someone wants to bear this upfront cost, I can provide all the
Dockerfiles + scripts I have to build those images, etc, I just don't
have the time right now to invest in learning about travis, etc.

That would be awesome.

But if people run:

make -C tools/perf build-test

And:

perf test

Before sending pull requests, that would as well be fantastic :)

- Arnaldo
