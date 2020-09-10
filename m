Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5F9C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9375E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599773905;
	bh=HgdV9+FJJihFM3IekafTP1p5UbQd4q92rPxRVRZ/a7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=krVRx/UeeXj26aCOsEylLX7uCwEJL07MxQ5m3pLGSCcxBjcFpzZ5wsWqAkOEfsoDa
	 fukmqOiuj0ruKu1HyeTLHXScal6/ji9mkxlO1cEuDIQgNz0NxkXZ0LrKVqMl0B+cFO
	 XQU6CUCjooZcuha6VOrKvuAx3xru/iTwoPPbykgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgIJViI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:38:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53121 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgIJNdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:33:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id q9so67007wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FQw6dLAP93Aj1WWJXzAvIyFEW1p2iZC9e/7pbv+/is=;
        b=nTKD6kCDoSi1BkzBIlss2M6gpLk0JqB2pqaesieXks4kfKsk/v7P9JcmpIDi3Vlkx8
         geuDSiuO4sSpnZ4VkZVn+lgAP3PFrvGOGSDTvjV0h5zFj7AAOuClCwZZNkXDxRkN1V9Z
         PxOOQtvOtFBq7vt5iDVFOhvk1a9Dtmo2AJ5PfJ1DeoV+fUfZ6PaHvd6nZr7xsomH9+lM
         1pfVf11yvj1hsO2FXb4OFtCxACbgl3ysgVCt0diyFD4Btkwm+rjwNtFrEW2Giq+07ZKI
         AR4aJsjmWsdj+6rZ+8UmjMjBjsE3BbkcZ/4zlIsivqyy/zxMmFVcScoUnU9c2fRu67Pw
         2yUg==
X-Gm-Message-State: AOAM5339pu/b8M5cgd4pHf8g9BuEk3SRaqEqsYp0u/Ljc4+z3Eu2RytV
        re4OS4BoyAunnQo0W9mfU6KlSly8v7aIh5nOmJc=
X-Google-Smtp-Source: ABdhPJy4fvlfg/yr4zT44X06qzG2hdASTCcFsQBtHEDWsMTfAG7CYLT7VEpmf/JkIeNoSQ8iYPQz08ZY99EX0E8q79A=
X-Received: by 2002:a1c:6341:: with SMTP id x62mr35045wmb.70.1599744774950;
 Thu, 10 Sep 2020 06:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200908044228.61197-1-namhyung@kernel.org> <20200910091542.GD1627030@krava>
 <20200910111020.GA4018363@kernel.org>
In-Reply-To: <20200910111020.GA4018363@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Sep 2020 22:32:44 +0900
Message-ID: <CAM9d7cjvid5zoAKnUtHMqwgMTA7FLAbh9fqamCZg5E-_pvD7qQ@mail.gmail.com>
Subject: Re: [PATCHSET 0/4] perf stat: Add --multiply-cgroup option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Sep 10, 2020 at 8:10 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Sep 10, 2020 at 11:15:42AM +0200, Jiri Olsa escreveu:
> > On Tue, Sep 08, 2020 at 01:42:24PM +0900, Namhyung Kim wrote:
> > > When we profile cgroup events with perf stat, it's very annoying to
> > > specify events and cgroups on the command line as it requires the
> > > mapping between events and cgroups.  (Note that perf record can use
> > > cgroup sampling but it's not usable for perf stat).
>
> > > I guess most cases we just want to use a same set of events (N) for
> > > all cgroups (M), but we need to specify NxM events and NxM cgroups.
> > > This is not good especially when profiling large number of cgroups:
> > > say M=200.
>
> > > So I added --multiply-cgroup option to make it easy for that case.  It
> > > will create NxM events from N events and M cgroups.  One more upside
> > > is that it can handle metrics too.
>
> > agreed that it's PITA to use -G option ;-)
>
> yeah, its great that someone is looking at cgroups improvements, thanks
> Namyung, its great to have you working on this!

Thanks! :)

>
> More below.
>
> > > For example, the following example measures IPC metric for 3 cgroups
>
> > >   $ cat perf-multi-cgrp.sh
> > >   #!/bin/sh
>
> > >   METRIC=${1:-IPC}
> > >   CGROUP_DIR=/sys/fs/cgroup/perf_event
>
> > >   sudo mkdir $CGROUP_DIR/A $CGROUP_DIR/B $CGROUP_DIR/C
>
> > >   # add backgroupd workload for each cgroup
> > >   echo $$ | sudo tee $CGROUP_DIR/A/cgroup.procs > /dev/null
> > >   yes > /dev/null &
> > >   echo $$ | sudo tee $CGROUP_DIR/B/cgroup.procs > /dev/null
> > >   yes > /dev/null &
> > >   echo $$ | sudo tee $CGROUP_DIR/C/cgroup.procs > /dev/null
> > >   yes > /dev/null &
>
> > >   # run 'perf stat' in the root cgroup
> > >   echo $$ | sudo tee $CGROUP_DIR/cgroup.procs > /dev/null
> > >   perf stat -a -M $METRIC --multiply-cgroup -G A,B,C sleep 1
> >
> > would it be easier to have new option for this? like:
> >
> >   perf stat -a -M $METRIC --for-cgroup A,B,C
> >   perf stat -a -M $METRIC --for-each-cgroup A,B,C
> >   perf stat -a -M $METRIC --attach-cgroup A,B,C
> >   perf stat -a -M $METRIC --attach-to-cgroup A,B,C

Looks good.  I like the --for-each-cgroup.
Then we should make it and -G mutually exclusive IMHO.

> >
> > I'm still not sure how the --multiply-cgroup deals with empty
> > cgroup A,,C but looks like we don't need this behaviour now?

Yep, it can handle such case and bind the events to the root cgroup.

>
> Yeah, I also didn't like the --multiply-cgroup thing, perhaps we can use
> a per-event term? or per group, for example:
>
>   perf stat -a -M $METRIC/cgroups=A,B,C/
>   perf stat -a -e '{cycles,instructions,cache-misses}/cgroups=A,B,C/'
>
> Allowing wildcards or regexps would help with some use cases.
>
> We already have several terms that allows us to control per event knobs,
> this would be one more.

At some point, we can support this kind of flexibility, but it'd make the code
complex when multiple events or metrics have different cgroup membership.
So I'd like to do the simple case (all events are expanded to same cgroups)
first..

Thanks
Namhyung
