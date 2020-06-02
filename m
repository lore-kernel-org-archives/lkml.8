Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE64C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E798720734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+XXKV+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFBTDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:03:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32242 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726174AbgFBTDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591124598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WtrYSz6qHZPXe9mHbjwGNmsUDvvIsrVil0AIiTdl8U0=;
        b=h+XXKV+bqI0vxgNG1wprL6zBPB/3hdRXE1stUP7lwwMA70vydEwjkMq44MfgCEmHkUTauj
        MHZQmiJSFcJ1OeEEk7lmho9cffBMPV6T3Y7yCrXfGBTyOFKdNffa5RUlXwSzHsXledvCq/
        TeBDF6aDt9QLm0HPhe1/5FzUiVQGTv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-NwLzME_pNGexxlu9llJrbA-1; Tue, 02 Jun 2020 15:03:14 -0400
X-MC-Unique: NwLzME_pNGexxlu9llJrbA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CCFE80B726;
        Tue,  2 Jun 2020 19:03:12 +0000 (UTC)
Received: from krava (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id F3D7278EF6;
        Tue,  2 Jun 2020 19:03:09 +0000 (UTC)
Date:   Tue, 2 Jun 2020 21:03:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 04/13] perf tests: Add another metric parsing test
Message-ID: <20200602190308.GF1169993@krava>
References: <20200602115055.1168446-1-jolsa@kernel.org>
 <20200602115055.1168446-5-jolsa@kernel.org>
 <CAP-5=fXjQ0ZgtrsizH6F7y2VRZ6dnsu54BXRxszyM+mMAvP-cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXjQ0ZgtrsizH6F7y2VRZ6dnsu54BXRxszyM+mMAvP-cQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:58:32AM -0700, Ian Rogers wrote:
> On Tue, Jun 2, 2020 at 4:51 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > The test goes through all metrics compiled for arch
> > within pmu events and try to parse them.
> >
> > This test is different from 'test_parsing' in that
> > we go through all the events in the current arch,
> > not just one defined for current CPU model. Using
> > 'fake_pmu' to parse events which do not have PMUs
> > defined in the system.
> >
> > Say there's bad change in ivybridge metrics file, like:
> >
> >   --- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> >   +++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> >   @@ -8,7 +8,7 @@
> >   -        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ((
> >   +        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / / (4 *
> >
> > the test fails with (on my kabylake laptop):
> >
> >   $ perf test 'Parsing of PMU event table metrics with fake PMUs' -v
> >   parsing 'idq_uops_not_delivered.core / / (4 * (( ( cpu_clk_unh...
> >   syntax error, line 1
> >   expr__parse failed
> >   test child finished with -1
> >   ...
> 
> For this example as the problem is the expression, presumably this was
> "passing" with test_parsing due to returning TEST_SKIP? I did this
> initially so that we could get the test merged and then the metrics
> fixed. I'd prefer if test_parsing were returning TEST_FAIL.

it will fail:

	[jolsa@krava perf]$ git diff
	diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
	index 28e25447d3ef..0cad6b709f96 100644
	--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
	+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
	@@ -1,7 +1,7 @@
	 [
	     {
		 "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
	-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
	+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / / (4 * cycles)",
		 "MetricGroup": "TopdownL1",
		 "MetricName": "Frontend_Bound",

	[jolsa@krava perf]$ ./perf test  'Parsing of PMU event table metrics with fake PMUs' 
	10: PMU events                                            :
	10.4: Parsing of PMU event table metrics with fake PMUs   : FAILED!

because the metric is malformed

jirka

