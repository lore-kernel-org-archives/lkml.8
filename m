Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF81C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2A520787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OglFDve9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgGVSMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:12:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32208 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbgGVSMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595441528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSfhYjO+Al5YeGylBh2w7iH5hO4RJt7NlaU6vhWV88Y=;
        b=OglFDve9sVcWCNDPTzQ1u/L9o2Nd5/h0sXXCpL1nzQSnpaH1sA6e9v2PYRajTpK86JNvT0
        z15JIHO67OZ267WVRelsFxEDGoWKYMeZGjpwqCODB0HKZLVLNKcY2B5G3MZWjOm83g8yfO
        Iokv3v7ZrMNnN5/+K/Qv9qA0ytVaDBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-zW-uzWMFO36WB8UhDOAYFA-1; Wed, 22 Jul 2020 14:12:04 -0400
X-MC-Unique: zW-uzWMFO36WB8UhDOAYFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD77E100A614;
        Wed, 22 Jul 2020 18:12:01 +0000 (UTC)
Received: from krava (unknown [10.40.194.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id 13AAF1009978;
        Wed, 22 Jul 2020 18:11:58 +0000 (UTC)
Date:   Wed, 22 Jul 2020 20:11:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
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
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHv3 00/19] perf metric: Add support to reuse metric
Message-ID: <20200722181158.GF981884@krava>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200721143702.GA15990@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721143702.GA15990@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 09:48:48AM -0500, Paul A. Clarke wrote:
> On Sun, Jul 19, 2020 at 08:13:01PM +0200, Jiri Olsa wrote:
> > hi,
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
> > v3 changes:
> >   - added some acks
> >   - some patches got merged
> >   - added missing zalloc include [John Garry]
> >   - added ids array outside the egroup object [Ian]
> >   - removed wrong m->has_constraint assignment [Ian]
> >   - renamed 'list' to 'metric_list' [Ian]
> >   - fixed group metric and added test for it [Paul A. Clarke]
> >   - fixed memory leak [Arnaldo]
> >   - using lowercase keys for metrics in hashmap, because jevents
> >     converts metric_expr to lowercase
> > 
> > Also available in here:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/metric
> 
> These changes seem to be mostly working for me.
> 
> I attempted to exploit the new capability in the metrics definitions in
> tools/perf/pmu-events/arch/powerpc/power9/metrics.json.  Those changes
> are included below.
> 
> The one problem I found is with the "cpi_breakdown" metric group, as it
> no longer works:
> ```
> # perf stat --metrics cpi_breakdown ./command
> Cannot find metric or group `cpi_breakdown'
> ```
> 
> "cpi_breakdown" does show up in `perf list --metricgroup`, and all of the
> (95!) metrics listed in that group are usable, so it's not obvious whether
> my changes have a problem, or merely provoke one.

I underestimated the recursion depth setup for groups,
your change is working for me with following change:

-#define RECURSION_ID_MAX 100
+#define RECURSION_ID_MAX 1000

jirka

