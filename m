Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E4C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B11B2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599775179;
	bh=n7fko+K24EPbXR431Tv5ZgLjx98hbWABFxYSBLUpKws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ug72yZNshdV/d+GjRyMEJPWhHJ7dRkPgqBiwF5YJFQ9p81R5yev4VJ7S2v4h4Jqg+
	 qeHKbIfMIa5Py4TmJYTy+S7cLbtXqcoLP/VTrge4H7hVLeg/wABWh7wCR+4YSMcJxz
	 X09b5RlGihtA4/Ngk8GDeph//wAaLaAiyQsxiOk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725290AbgIJV7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbgIJLKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:10:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4B621556;
        Thu, 10 Sep 2020 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599736223;
        bh=n7fko+K24EPbXR431Tv5ZgLjx98hbWABFxYSBLUpKws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jbc6qqCieYpi405/MUUIN69qEpUHLQ9tvNwfAcZHqz1p0Qa7gTdQeldC50pB+Sruy
         zGXbzZDsMsIvYrX9Cka1lOYuNk1YecakhwfgEVpZJQSN5D+7qaSl22txo6jxtWedR7
         SnfcYWMTV1s2CoKH6zv6DEyb7hHPkwvZb0Z+Ie58=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1C8540D3D; Thu, 10 Sep 2020 08:10:20 -0300 (-03)
Date:   Thu, 10 Sep 2020 08:10:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET 0/4] perf stat: Add --multiply-cgroup option
Message-ID: <20200910111020.GA4018363@kernel.org>
References: <20200908044228.61197-1-namhyung@kernel.org>
 <20200910091542.GD1627030@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910091542.GD1627030@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 10, 2020 at 11:15:42AM +0200, Jiri Olsa escreveu:
> On Tue, Sep 08, 2020 at 01:42:24PM +0900, Namhyung Kim wrote:
> > When we profile cgroup events with perf stat, it's very annoying to
> > specify events and cgroups on the command line as it requires the
> > mapping between events and cgroups.  (Note that perf record can use
> > cgroup sampling but it's not usable for perf stat).

> > I guess most cases we just want to use a same set of events (N) for
> > all cgroups (M), but we need to specify NxM events and NxM cgroups.
> > This is not good especially when profiling large number of cgroups:
> > say M=200.

> > So I added --multiply-cgroup option to make it easy for that case.  It
> > will create NxM events from N events and M cgroups.  One more upside
> > is that it can handle metrics too.

> agreed that it's PITA to use -G option ;-)

yeah, its great that someone is looking at cgroups improvements, thanks
Namyung, its great to have you working on this!

More below.
 
> > For example, the following example measures IPC metric for 3 cgroups

> >   $ cat perf-multi-cgrp.sh
> >   #!/bin/sh

> >   METRIC=${1:-IPC}
> >   CGROUP_DIR=/sys/fs/cgroup/perf_event

> >   sudo mkdir $CGROUP_DIR/A $CGROUP_DIR/B $CGROUP_DIR/C

> >   # add backgroupd workload for each cgroup
> >   echo $$ | sudo tee $CGROUP_DIR/A/cgroup.procs > /dev/null
> >   yes > /dev/null &
> >   echo $$ | sudo tee $CGROUP_DIR/B/cgroup.procs > /dev/null
> >   yes > /dev/null &
> >   echo $$ | sudo tee $CGROUP_DIR/C/cgroup.procs > /dev/null
> >   yes > /dev/null &

> >   # run 'perf stat' in the root cgroup
> >   echo $$ | sudo tee $CGROUP_DIR/cgroup.procs > /dev/null
> >   perf stat -a -M $METRIC --multiply-cgroup -G A,B,C sleep 1
> 
> would it be easier to have new option for this? like:
> 
>   perf stat -a -M $METRIC --for-cgroup A,B,C
>   perf stat -a -M $METRIC --for-each-cgroup A,B,C
>   perf stat -a -M $METRIC --attach-cgroup A,B,C
>   perf stat -a -M $METRIC --attach-to-cgroup A,B,C
> 
> I'm still not sure how the --multiply-cgroup deals with empty
> cgroup A,,C but looks like we don't need this behaviour now?

Yeah, I also didn't like the --multiply-cgroup thing, perhaps we can use
a per-event term? or per group, for example:

  perf stat -a -M $METRIC/cgroups=A,B,C/
  perf stat -a -e '{cycles,instructions,cache-misses}/cgroups=A,B,C/'

Allowing wildcards or regexps would help with some use cases.

We already have several terms that allows us to control per event knobs,
this would be one more.

- Arnaldo
