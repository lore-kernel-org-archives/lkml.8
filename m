Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C52C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7FA20722
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwkxeTFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgHCQ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:26:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47928 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726878AbgHCQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596472007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltJG4zktCSntDkNDayw7z+gChix7SCDzCjd72YBUIQ0=;
        b=KwkxeTFOAcxZGGFTOKx2Now+iyvD9QO6S0I0drd1cY0+BkF+jXHV3dFkEBPrbVuJjE3lXB
        gnHyQtJ+P+VOYf97ydFfYZv/xzq1zZk+sVkqPzFT7xIq73mTbw/L1r8O0WVcHnQnFmAQ9s
        7D9NVVvYM+ULqfvKdvMtu2wfPuClpsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-Btw4iw8GMn6mFEAi_QW12g-1; Mon, 03 Aug 2020 12:26:43 -0400
X-MC-Unique: Btw4iw8GMn6mFEAi_QW12g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 729FC800685;
        Mon,  3 Aug 2020 16:26:41 +0000 (UTC)
Received: from krava (unknown [10.40.194.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id E201A87E27;
        Mon,  3 Aug 2020 16:26:37 +0000 (UTC)
Date:   Mon, 3 Aug 2020 18:26:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     "Paul A. Clarke" <pc@us.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
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
Subject: Re: [PATCHv4 00/19] perf metric: Add support to reuse metric
Message-ID: <20200803162636.GF139381@krava>
References: <20200729091908.1378911-1-jolsa@kernel.org>
 <20200801114050.GB377079@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <CAP-5=fUjMH-VHaLhNjBhk4pSsAGs_9kUuy1N68RRF4d6E5e5Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUjMH-VHaLhNjBhk4pSsAGs_9kUuy1N68RRF4d6E5e5Lg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 08:54:16AM -0700, Ian Rogers wrote:
> On Sat, Aug 1, 2020 at 4:41 AM Paul A. Clarke <pc@us.ibm.com> wrote:
> >
> > On Wed, Jul 29, 2020 at 11:18:49AM +0200, Jiri Olsa wrote:
> > > this patchset is adding the support to reused metric in
> > > another metric.
> > >
> > > For example, to define IPC by using CPI with change like:
> > >
> > >      {
> > >          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> > > -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> > > +        "MetricExpr": "1/CPI",
> > >          "MetricGroup": "TopDownL1",
> > >          "MetricName": "IPC"
> > >      },
> > >
> > > I won't be able to find all the possible places we could
> > > use this at, so I wonder you guys (who was asking for this)
> > > would try it and come up with comments if there's something
> > > missing or we could already use it at some places.
> > >
> > > It's based on Arnaldo's tmp.perf/core.
> > >
> > > v4 changes:
> > >   - removed acks from patch because it changed a bit
> > >     with the last fixes:
> > >       perf metric: Collect referenced metrics in struct metric_ref_node
> > >   - fixed runtime metrics [Kajol Jain]
> > >   - increased recursion depth [Paul A. Clarke]
> > >   - changed patches due to dependencies:
> > >       perf metric: Collect referenced metrics in struct metric_ref_node
> > >       perf metric: Add recursion check when processing nested metrics
> > >       perf metric: Rename struct egroup to metric
> > >       perf metric: Rename group_list to metric_list
> > >
> > > Also available in here:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > >   perf/metric
> >
> > I built and ran from the above git branch, and things seem to work.
> > Indeed, I was able to apply my changes to exploit the new capabilities
> > via modifications to tools/perf/pmu-events/arch/powerpc/power9/metrics.json,
> > as I posted earlier (and will submit once this set gets merged).
> >
> > Tested-by: Paul A. Clarke <pc@us.ibm.com>
> >
> > One thing I noted, but which also occurs without these patches, is that
> > the perf metrics are not computed unless run as root:
> > --
> > $ perf stat --metrics br_misprediction_percent command
> >
> >  Performance counter stats for 'command':
> >
> >      1,823,530,051      pm_br_pred:u
> >          2,662,705      pm_br_mpred_cmpl:u

it's because when you don't run as root, events will get the :u suffix,
so they will not match the events in metric.. we need to decide if we
want the metric to match events without modifiers or be strict about it

> >
> > $ /usr/bin/sudo perf stat --metrics br_misprediction_percent command
> >
> >  Performance counter stats for 'command':
> >
> >      1,824,655,269      pm_br_pred                #     0.09 br_misprediction_percent
> >          1,654,466      pm_br_mpred_cmpl
> > --
> >
> > Is that expected?  I don't think it's always been that way.
> 
> I agree Paul, this seems broken. I've noticed a bunch of issues with
> printing CSV, per-socket output and so on. Jiri may have a better idea
> but I plan to look at problems in this area later, and hopefully stick
> a few tests on it :-)

ok, that'd be great, thanks

jirka

