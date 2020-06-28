Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1FCC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56F42065D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AV70+1RZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgF1WGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 18:06:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25441 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726138AbgF1WGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593381971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wrx+wMG9HM1GFKCj2tzsXVGQYf9X5x+VPovksnHdBSg=;
        b=AV70+1RZMxPI9SJTL9O3VncBRuLH4JmaUPgNP7nnEnzrN3/HcS8VwyxHSgZshcGR01uvQ8
        Y+9O2Cg77EI/2c1R+vyHZnDPSOjm4jHK1YqSkoLIVQnYly5zW84lI1TEf4Ejby/Wvnagic
        9y0M8KntjyqlEQcdmswX60OAJYsNn1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-9rZkSM_aMLWpo4Pq_1fylg-1; Sun, 28 Jun 2020 18:06:07 -0400
X-MC-Unique: 9rZkSM_aMLWpo4Pq_1fylg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4668D107ACCA;
        Sun, 28 Jun 2020 22:06:05 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D9AC5C1B2;
        Sun, 28 Jun 2020 22:06:02 +0000 (UTC)
Date:   Mon, 29 Jun 2020 00:06:01 +0200
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
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 06/10] perf tools: Collect other metrics in struct egroup
Message-ID: <20200628220601.GR2988321@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626194720.2915044-7-jolsa@kernel.org>
 <CAP-5=fWJGGPCx4Rk_5UXLjDjQ3fLzzPO-gnRtPGV2GWoNLzL=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWJGGPCx4Rk_5UXLjDjQ3fLzzPO-gnRtPGV2GWoNLzL=w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:48:02PM -0700, Ian Rogers wrote:
> On Fri, Jun 26, 2020 at 12:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Collecting other metrics in struct egroup object,
> > so we can process them later on.
> >
> > The change will parse or 'other' metric names out of
> > expression and 'resolve' them.
> >
> > Every used expression needs to have 'metric:' prefix,
> > like:
> >   cache_miss_cycles = metric:dcache_miss_cpi + metric:icache_miss_cycles
> >
> > All 'other' metrics are disolved into one context,
> > meaning all 'other' metrics events and addded to
> > the parent context.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../arch/x86/skylake/skl-metrics.json         |   2 +-
> >  tools/perf/util/expr.c                        |  11 ++
> >  tools/perf/util/expr.h                        |   1 +
> >  tools/perf/util/metricgroup.c                 | 158 ++++++++++++++++--
> >  4 files changed, 157 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > index 8704efeb8d31..71e5a2b471ac 100644
> > --- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > @@ -57,7 +57,7 @@
> >      },
> >      {
> >          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> > -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> > +        "MetricExpr": "1/metric:CPI",
> >          "MetricGroup": "TopDownL1",
> >          "MetricName": "IPC"
> >      },
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index aa14c7111ecc..cd73dae4588c 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -150,3 +150,14 @@ int expr__find_other(const char *expr, const char *one,
> >
> >         return ret;
> >  }
> > +
> > +#define METRIC "metric:"
> > +
> > +bool expr__is_metric(const char *name, const char **metric)
> > +{
> > +       int ret = !strncmp(name, METRIC, sizeof(METRIC) - 1);
> > +
> > +       if (ret && metric)
> > +               *metric = name + sizeof(METRIC) - 1;
> > +       return ret;
> > +}
> 
> Should expr.l recognize metric:... as a different kind of token rather
> than an ID?

hm, we still want it to be returned as ID token, and the processing
code needs a way to distinguish between event and metric, so I'd think
we need to keep it, but I'll double check

thanks,
jirka

