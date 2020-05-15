Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774F7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A37320709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUI0vkA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgEOLsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:48:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23827 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbgEOLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589543319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3N2VSvW/zqfym+ZRBh9Z7xiCG6XPCCcLlnyZdZ3YQtY=;
        b=iUI0vkA1alBcURxjxlQ9Q0Fu1iWD3u8t4vrQLcT2oTcxstqmEa2mV2I1bWXHToWW150T05
        eMRFr+9h05DpJ1jEQMQkbvDe1LWKZIQABAniQYCmDq2QcWaWfv1tS/C3El8/013VRQlymZ
        7bOpO7X7u9w6IWBojBdZmU1GwxRge+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-A-mNt03iPwO2eUkviJ8dGg-1; Fri, 15 May 2020 07:48:35 -0400
X-MC-Unique: A-mNt03iPwO2eUkviJ8dGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C167A8005AD;
        Fri, 15 May 2020 11:48:32 +0000 (UTC)
Received: from krava (unknown [10.40.194.127])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1E38E6E9E2;
        Fri, 15 May 2020 11:48:28 +0000 (UTC)
Date:   Fri, 15 May 2020 13:48:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/2] perf test: Improve pmu event metric testing
Message-ID: <20200515114827.GA3547844@krava>
References: <20200513062236.854-1-irogers@google.com>
 <20200513062236.854-2-irogers@google.com>
 <ac88604a-56c2-b632-57c2-3bee316dcea7@huawei.com>
 <CAP-5=fVkD+0wCMcBBHWM8djsnn2KsshOyK_XcjNDTsiVo04vwQ@mail.gmail.com>
 <5264e16c-fb1a-4bbc-96b5-1d867e38902e@huawei.com>
 <CAP-5=fWt58UVTTj_qvirMhMOaUbur+HzxrTi5u1qvCA1ft9BEw@mail.gmail.com>
 <799e8dde-6f56-7add-a177-3e21c0de03fc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <799e8dde-6f56-7add-a177-3e21c0de03fc@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 10:09:10AM +0100, John Garry wrote:
> On 15/05/2020 00:02, Ian Rogers wrote:
> > On Thu, May 14, 2020 at 2:00 AM John Garry <john.garry@huawei.com> wrote:
> > > 
> > > On 13/05/2020 17:10, Ian Rogers wrote:
> > > > > Out of interest, if we could move the validation of metrics to jevents,
> > > > > how much functionality would we still have here?
> > > > If we add checking to jevents then the MetricExpr would be known to be
> > > > valid, however, the events (aka ids) within the expression could be
> > > > invalid.
> > > 
> > > So I think that has some value. I mean, just to detect syntax errors,
> > > like those remedied in "perf metrics: fix parse errors in power8 metrics".
> > > 
> > > > I'm not sure we could realistically check the events at
> > > > jevents (build) time as there is no guarantee that the machine we run
> > > > on is the same as the one we compile on.
> > > 
> > > But we could at least check that there are event aliases for that CPU,
> > > right? (by examining the JSONs for that cpu). If the event alias does
> > > not actually match on the target CPU, then that can't be helped.
> > 
> > Agreed, I think there will be some cases where something more can be
> > done. Jiri has proposed fake pmus as well:
> > https://www.spinics.net/lists/linux-perf-users/msg11760.html
> > I don't know how much sense it makes trying to get this in jevents, as
> > long as 'perf test' is run.
> 
> At a glance, that does not look like something we would want in jevents. But
> rather the metric expr parsing error detection and alias checking.
> 
> About jirka's patch:
> 
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -485,6 +485,102 @@ static int test_parsing(void)
>  	return ret == 0 ? TEST_OK : TEST_SKIP;
>  }
> 
> +
> +static struct test_metric metrics[] = {
> +	{ .metric = "imx8_ddr0@read\\-cycles@ * 4 * 4", },
> +	{ .metric = "imx8_ddr0@axid\\-read\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@
> * 4", },
> +	{ .metric = "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100", },
> +	{ .metric = "(imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@)", },
> +};
> 
> Maybe we could add these to pmu-events/arch/test/test_cpu/metric.json, and
> get at them that way.

that test sets the 'fake pmu' stuff.. could we do that in your test?

jirka

