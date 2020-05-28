Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E758520776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ycvw3d71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbgE1JdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgE1JdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:33:08 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF83C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:33:08 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id s7so7082981ybo.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RIEKd2/mNC5ZCQKsZfjS5e0RETs6SJqkGikMbM7WjKs=;
        b=Ycvw3d711px4YUgUi3RnPf4HNuJOmURAfUbCEeW1zaFjuwJ3bloc11fClVuOdjVBnc
         7oGJnL7+kWEuh6Scm8jrRudKosKQtHz3wPjV2afqhnnnf/W4vEd2yaP9yd3zey2Rh9yb
         Ryh/6CMe1h0PqlXxynmkXnMIBKow7zGJXxaqtS//UdH8ueZB+C1wTT7OQRCanA0KrPqA
         GPW1/KNJ6dKJmtHdqix8iWscF5bwr4Lz06Hjx9eu+ScH0UI4htiFAMrxyNG0KfntKXQM
         lY7crDkx/+MXGZjUar9NKxrclPUZBJvFa+xBoRMc/mzvd8PAockPi71MIXDwyMThQenK
         vj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RIEKd2/mNC5ZCQKsZfjS5e0RETs6SJqkGikMbM7WjKs=;
        b=Pg3d6mAQ5C4E9aaoTfQW6o1BJwrqRWXVwbB6O6puZGdoacnB6ayK5+LojrGjGSLFAj
         wqoB6w+x8AAPo641VUGr3mcZT7RdCtrqcV3jjph88o7ZYIywMMbz+UEH9mKLNTK2HM8L
         TNjHW27zF3TCjsWjLi1fE6x07bTpiiy/cCJQMTovAx23ea73d6u9/zaOvESJBiOE7vUX
         BBWUCPfUTSYMDg7mE8Us1dVCgD+RVS9wh5Wsaf6Gd3dBYEhTygQTRxsYZ2GH0bYawe6P
         nNJ4/s+dlH9P2CWbxiZlo9sB4VkmUGU1MlrhVCPJqOqYw1rCHwZMg0mj/QF2BOa1//dp
         f3lw==
X-Gm-Message-State: AOAM532IZ9SeJ1deDIYqCYhZmkcVLP2oaqgBGppe5fKsuEx0Q3k2NWHr
        DISARD6i95I109ZMu5rS/cRkRNmdjx6ovmBi+R8jcg==
X-Google-Smtp-Source: ABdhPJwIR1hbxELMPTR9/UqrGD0+JDxGladZozhLbAsFMVRRdFi2h5IBC3WWXn7hhDcTMrbbfyiTdkdTtvvTCSa1fHw=
X-Received: by 2002:a25:c08b:: with SMTP id c133mr3742107ybf.286.1590658387444;
 Thu, 28 May 2020 02:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com>
 <CAP-5=fXGXqkTbSwKv7eq9UkPvVqRJXDm3E-XNxD8+5fmQk3bpg@mail.gmail.com>
 <MN2PR21MB15185419971A29EF52B8138FF7B10@MN2PR21MB1518.namprd21.prod.outlook.com>
 <CAP-5=fVHo262Lo_Re31wM8Bt0soJ-m51J7MEnwvdTg5P8J6e6A@mail.gmail.com>
In-Reply-To: <CAP-5=fVHo262Lo_Re31wM8Bt0soJ-m51J7MEnwvdTg5P8J6e6A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 28 May 2020 02:32:55 -0700
Message-ID: <CAP-5=fV7F4u66388HC-q8btOYWKxtb1gTTi4LK_Besb-zE25Rw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap events
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Steve MacLean <steve.maclean@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 1:59 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, May 27, 2020 at 12:27 PM Steve MacLean
> <Steve.MacLean@microsoft.com> wrote:
> >
> > >> ** Implemented solution
> > >>
> > >> This patch solves the issue by removing // anon mmap events for any
> > >> process which has a valid jit-<pid>.dump file.
> > >>
> > >> It tracks on a per process basis to handle the case where some running
> > >> apps support jit-<pid>.dump, but some only support perf-<pid>.map.
> > >>
> > >> It adds new assumptions:
> > >> * // anon mmap events are only required for perf-<pid>.map support.
> > >> * An app that uses jit-<pid>.dump, no longer needs perf-<pid>.map
> > >> support. It assumes that any perf-<pid>.map info is inferior.
> > >>
> > >> *** Details
> > >>
> > >> Use thread->priv to store whether a jitdump file has been processed
> > >>
> > >> During "perf inject --jit", discard "//anon*" mmap events for any pid
> > >> which has sucessfully processed a jitdump file.
> > >
> > >
> > > Thanks Steve this is an important fix! As //anon could be for malloc or other uses, should the stripping behavior be behind a flag?
> > >
> > > Ian
> >
> > I hadn't anticipated a need to preserve the //anon mmap events when profiling JIT generated code.
> >
> > As far as I know mmap events are captured by perf only for mapping code to symbols.  File mappings are kept
> > by the change.  Only // anon mappings are stripped.  (Only for processes which emitted jitdump files.)
> > And these are stripped only during the `perf inject --jit` step. I believe the // Anon mapping are only
> > generally useful for mapping JIT code.
> >
> > I suppose if someone was trying to count mmap events it might be confusing, but `perf inject --jit` creates
> > synthetic mmap file events which would also make this scenario confusing.
> >
> > I personally don't see a good reason to add a flag.  I also don't see a simple way either.  Not running `perf inject --jit`
> > would preserve existing behavior w/o jitdump support.  Without stripping the anon events jitdump support is painfully
> > broken....
>
> Agreed that things are broken. In general only executable mappings are
> held onto by perf, so it could be I'm over worrying about //anon
> stripping breaking around memory allocations. We have some other use
> cases for //anon at Google but they aren't impacted by jitdump. We
> have also been trying to migrate jit caches to using memfd_create,
> which has the same problem that this patch fixes for //anon. Fixing
> memfd_create is a separate issue to //anon. I'll try to get a repro
> for Java that demonstrates the problem and then add a Tested-by.
>
> Thanks,
> Ian

So on tip/perf/core with:
1c0cd2dbb993 perf jvmti: Fix jitdump for methods without debug info
3ce17c1e52f4 perf jvmti: remove redundant jitdump line table entries

I've been trying variants of:

Before:
/tmp/perf/perf record -k 1 -e cycles:u -o /tmp/perf.data java
-agentpath:/tmp/perf/libperf-jvmti.so -XX:+PreserveFramePointer
-XX:InitialCodeCacheSize=20M -XX:ReservedCodeCacheSize=1G -jar
dacapo-9.12-bach.jar jython
/tmp/perf/perf inject -i /tmp/perf.data -o /tmp/perf-jit.data -j
/tmp/perf/perf report -i /tmp/perf-jit.data |grep class\ |wc -l
578
/tmp/perf/perf report -i /tmp/perf-jit.data |grep unknown |wc -l
6

After:
/tmp/perf/perf record -k 1 -e cycles:u -o /tmp/perf.data java
-agentpath:/tmp/perf/libperf-jvmti.so -XX:+PreserveFramePointer
-XX:InitialCodeCacheSize=20M -XX:ReservedCodeCacheSize=1G -jar
dacapo-9.12-bach.jar jython
/tmp/perf/perf inject -i /tmp/perf.data -o /tmp/perf-jit.data -j
/tmp/perf/perf report -i /tmp/perf-jit.data |grep class\ |wc -l
589
/tmp/perf/perf report -i /tmp/perf-jit.data |grep unknown |wc -l
60

So maybe the jit cache isn't behaving the way that the patch cures,
the uptick in unknowns appears consistent in my testing though. I
expect user error, is there an obvious explanation I'm missing?

Thanks,
Ian
