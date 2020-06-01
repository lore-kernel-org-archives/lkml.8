Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F05C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF1120734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfL655X5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgFAIyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:54:05 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B0C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 01:54:05 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m81so6116706ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 01:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bsPfdV/5AKKcKgIigNU4a7u3PzYati4l2g7jTpvHnCI=;
        b=XfL655X5AnrPG9hnbvC0CTQpDBpavZGZwIi8uZ0BV9u3yim+4FmJH/73FiPphmJ70n
         FL/dFVVTfc/oWiENP9PYS9+vTTCARn63J0BVioHXRWsrinxfxyH6JjwofoQ0avblU9M7
         AIropMdNQ5RpZ0D0djB7gj/mOenFuxh7Wj9stRFWoctdj8Cxc8m+7fFvAU/fVZpn1HyG
         pDcj9Hhu7J05aEemy4Xe+ss67Y8zTMl16XlUeAAJSB6TPIhMyCKMrmvSuaua7AjOL/oG
         yLe0pRsOJ2GUIFkHTdcHz+jcn/tiFUMZhRJu/w7LAIWR8EOmmzwlXNlXoaFg8lX1XMt4
         iGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsPfdV/5AKKcKgIigNU4a7u3PzYati4l2g7jTpvHnCI=;
        b=aWtzx2ZL9yeGi9Xu/PKYmLkBq2No2F7zzmLohwilgbg2WH0TJT4q4gHlbm4G182wc7
         18HshNIenv7DjPu4Uzo1AWB5XewogGNHK60nGCgcnexhOPlEF9Y7NTGFIymFCs3GVX+B
         ldPsPZocIhJ6z2N9yzBV6c1wftUTt9clDjwL14KdeYmjZvUtLuP8FlKD0mxJ0qAkgTSr
         QLP2gvs0O1BqrJmjvnEp0GlvA3rTY5g0omUsdeSgNtvtCDXJ3GDTBUoJqJTIOqtVK9vK
         Q0TAK+E/JyE7VBQLUqtqe4kZiwhVN8WwbMuA70CZkC5X6wlXJMmAYV+V2U7tfzqJqsCG
         Vy2A==
X-Gm-Message-State: AOAM532Jtb0boW+EW3lSNQZHulHA98QqvX92eyVFonigWF+d9PxJc12D
        PZ4y720cGzzvGdaF7Vms8z7ykmI2nBWnAnE4grrb3w==
X-Google-Smtp-Source: ABdhPJxzRTeq80o3OxUsTyw3dvEMuNVG5KroPwGREfjss++ZyQDuRFaexcEvcoGiw3KG4880Fjxci4/DJedD92IaeXw=
X-Received: by 2002:a5d:9e51:: with SMTP id i17mr17061784ioi.8.1591001643401;
 Mon, 01 Jun 2020 01:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com>
 <CAP-5=fXGXqkTbSwKv7eq9UkPvVqRJXDm3E-XNxD8+5fmQk3bpg@mail.gmail.com>
 <MN2PR21MB15185419971A29EF52B8138FF7B10@MN2PR21MB1518.namprd21.prod.outlook.com>
 <CAP-5=fVHo262Lo_Re31wM8Bt0soJ-m51J7MEnwvdTg5P8J6e6A@mail.gmail.com>
 <CAP-5=fV7F4u66388HC-q8btOYWKxtb1gTTi4LK_Besb-zE25Rw@mail.gmail.com> <xgl9tuzvz4wc.fsf@arm.com>
In-Reply-To: <xgl9tuzvz4wc.fsf@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 1 Jun 2020 01:53:52 -0700
Message-ID: <CAP-5=fWU==y-DMd5sD7AxHCUNg0L4Qt_VRVvyDVNYPCOdxmU_A@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap events
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Steve MacLean <Steve.MacLean@microsoft.com>,
        Steve MacLean <steve.maclean@linux.microsoft.com>,
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

On Sun, May 31, 2020 at 11:17 PM Nick Gasson <nick.gasson@arm.com> wrote:
>
> On 05/28/20 17:32 PM, Ian Rogers wrote:
> >
> > So on tip/perf/core with:
> > 1c0cd2dbb993 perf jvmti: Fix jitdump for methods without debug info
> > 3ce17c1e52f4 perf jvmti: remove redundant jitdump line table entries
> >
> > I've been trying variants of:
> >
> > Before:
> > /tmp/perf/perf record -k 1 -e cycles:u -o /tmp/perf.data java
> > -agentpath:/tmp/perf/libperf-jvmti.so -XX:+PreserveFramePointer
> > -XX:InitialCodeCacheSize=20M -XX:ReservedCodeCacheSize=1G -jar
> > dacapo-9.12-bach.jar jython
> > /tmp/perf/perf inject -i /tmp/perf.data -o /tmp/perf-jit.data -j
> > /tmp/perf/perf report -i /tmp/perf-jit.data |grep class\ |wc -l
> > 578
> > /tmp/perf/perf report -i /tmp/perf-jit.data |grep unknown |wc -l
> > 6
> >
> > After:
> > /tmp/perf/perf record -k 1 -e cycles:u -o /tmp/perf.data java
> > -agentpath:/tmp/perf/libperf-jvmti.so -XX:+PreserveFramePointer
> > -XX:InitialCodeCacheSize=20M -XX:ReservedCodeCacheSize=1G -jar
> > dacapo-9.12-bach.jar jython
> > /tmp/perf/perf inject -i /tmp/perf.data -o /tmp/perf-jit.data -j
> > /tmp/perf/perf report -i /tmp/perf-jit.data |grep class\ |wc -l
> > 589
> > /tmp/perf/perf report -i /tmp/perf-jit.data |grep unknown |wc -l
> > 60
> >
> > So maybe the jit cache isn't behaving the way that the patch cures,
> > the uptick in unknowns appears consistent in my testing though. I
> > expect user error, is there an obvious explanation I'm missing?
> >
>
> Hi Ian,
>
> I tried this as well with latest perf/core. The difference is that
> unresolved addresses currently look like:
>
>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff451499a4
>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff4514f3e8
>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff45149394
>
> But after Steve's patch this becomes:
>
>      0.00%  java             [unknown]              [.] 0x0000ffff58557d14
>      0.00%  java             [unknown]              [.] 0x0000ffff785c03b4
>      0.00%  java             [unknown]              [.] 0x0000ffff58386520
>
> I couldn't see any events that were symbolised before but are no longer
> symbolised after this patch.

I see this, thanks for digging into the explanation! Were you able to
get a test case where the unknowns went down? For example, by forcing
the code cache size to be small? This is the result I'd expect to see.

> I think most of these unknown events are caused by the asynchronous
> nature of the JVMTI event handling. After an nmethod is compiled the
> JVMTI event is posted to the Service Thread (*). So there can be a delay
> between the time the compiled code starts executing and the time the
> plugin receives the compiled code load event.
>
> Here's an edited down example:
>
>             java 215881 750014.947873:    1289634 cycles:u:      ffff7856ad10 [unknown] ([unknown])
>   Service Thread 215895 750014.947971: PERF_RECORD_MMAP2 215879/215895: [0xffff785694c0(0x640) @ 0x40 fd:01 121010091 1]:
>             java 215881 750014.948665:    1295994 cycles:u:      ffff7856ad10 org.python.core.__builtin__.range(org.python
>
> The plugin receives the event ~100us after the first sample inside that
> method. Ideally we would use the timestamp when the method was actually
> compiled, but I can't see any way to extract this information.

Hmm.. this is a bit weird as the compile_info at one point was a
resource allocation and so would be cleared out when the resource mark
was passed on the compiler's return. Not something you'd want to do
asynchronously. Presumably this has changed to improve performance,
but doing the jvmti on a separate thread defeats jitdump - if we see
samples in code ahead of the code being loaded. Perhaps a profiler
like async-profiler
(https://github.com/jvm-profiling-tools/async-profiler) has a
workaround for the lag.

> However I also saw a few recurring [unknown] addresses that never have a
> corresponding code load event. I'm not sure where these come from.

C2 is pretty bad for having assembly stub routine helpers (aka stub
routines) that aren't "documented". C1 is less like this, but it is
increasingly hard to force C1 as the compiler. If you are seeing these
things as leaf routines then its likely some stub routine clean up
could fix the issue.

Thanks,
Ian

> (*) http://hg.openjdk.java.net/jdk/jdk/file/50fe8727ed79/src/hotspot/share/code/nmethod.cpp#l1591
>
> --
> Nick
>
