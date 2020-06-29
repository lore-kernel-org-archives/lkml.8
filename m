Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E425AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F3A206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l47u7exl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbgF2TeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733223AbgF2Tcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FF9C0307AE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:55:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so14057083wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFc5XPKIgNYhYwJA1n4yTN5CHu3v+KM87EzlXbZPcTY=;
        b=l47u7exlvIn/jx3xAqIAczbjhilE4KyVhrwkqtjh3duabNCEBJC5hubFV7C3FVPfbv
         Lyo/gqXT64iB8DVEAjIEwYTtOxRfJZTlCcSP+xRt3Ibu07jWuP9ibzQXstlbxLp/Z/LF
         I9heSPEDvEZP0OIiv7KOz5sTqhstz4tDEV80/+RkCgCx+iPYYApzgFRhCqw95A/z49/5
         +M/xHElO/C6XA3d6DbiKDcNcmxDu7QMhI9Jck806xyW4QJfOVQQAR6145hjqyw98UGAg
         c7CD+y0VqKEpnjrNOmkrZnT7ANLuY18qM3pbH98E6I5Z19Cm2jzmkmmsy4V4wBHmjDLd
         HiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFc5XPKIgNYhYwJA1n4yTN5CHu3v+KM87EzlXbZPcTY=;
        b=bXbrNlY4pclX0iEgJ9VEbzLrKXQQ3km9A2sM/ONbg0c31QD2zkpHk9nUoEuaMThpWQ
         3uM/kQWUgPPfTYYeCPxSL8u5nVhanoET36wNJUdfc1kRiKPp4ZiA2wjnX7xgeXSqOzow
         XpqirZLHM1SLdZQwzOuyQEMwWXjFylZbD75qZOp7o1MfzQSEl6ilIRJFo5HSNu8ViBA3
         rXUoQe+bI3tUI3fzHh+TDRiRjAO8ppSOIdoCGkX0EZwrT8DRvKLsMO24Cr8FmJJE6tUR
         nGqYJldijCCK0qsVWGqfwAHyYcqGAEoIu1DOqhBWZ1qw5RVLzUFPagNTDfxNefBO/i/7
         PsDg==
X-Gm-Message-State: AOAM531U3EIH309KlDlLhl+nAyx+yQeDOGQQ+tHG6oEriPQbz3DMPHFy
        kOuyTznXeNvtT/P6pHskwUtmulKUVam9ScFXbXZtUg==
X-Google-Smtp-Source: ABdhPJy40XlPWnOzw4LBzoM58nDVnA2N6tc38Ldgg9nvLriVUNZtGOSvI7l8GImcKcnpqhT6hQPAkU02W13k1JbL+W0=
X-Received: by 2002:adf:e40e:: with SMTP id g14mr18979492wrm.271.1593446105622;
 Mon, 29 Jun 2020 08:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-7-jolsa@kernel.org>
 <CAP-5=fWJGGPCx4Rk_5UXLjDjQ3fLzzPO-gnRtPGV2GWoNLzL=w@mail.gmail.com> <20200628220601.GR2988321@krava>
In-Reply-To: <20200628220601.GR2988321@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Jun 2020 08:54:54 -0700
Message-ID: <CAP-5=fWoBwqONO_obfCAfQTyMzv_kxVNsnRTQ1yToTxD5ew+cw@mail.gmail.com>
Subject: Re: [PATCH 06/10] perf tools: Collect other metrics in struct egroup
To:     Jiri Olsa <jolsa@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 3:06 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jun 26, 2020 at 02:48:02PM -0700, Ian Rogers wrote:
> > On Fri, Jun 26, 2020 at 12:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Collecting other metrics in struct egroup object,
> > > so we can process them later on.
> > >
> > > The change will parse or 'other' metric names out of
> > > expression and 'resolve' them.
> > >
> > > Every used expression needs to have 'metric:' prefix,
> > > like:
> > >   cache_miss_cycles = metric:dcache_miss_cpi + metric:icache_miss_cycles
> > >
> > > All 'other' metrics are disolved into one context,
> > > meaning all 'other' metrics events and addded to
> > > the parent context.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  .../arch/x86/skylake/skl-metrics.json         |   2 +-
> > >  tools/perf/util/expr.c                        |  11 ++
> > >  tools/perf/util/expr.h                        |   1 +
> > >  tools/perf/util/metricgroup.c                 | 158 ++++++++++++++++--
> > >  4 files changed, 157 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > > index 8704efeb8d31..71e5a2b471ac 100644
> > > --- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > > +++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > > @@ -57,7 +57,7 @@
> > >      },
> > >      {
> > >          "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> > > -        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> > > +        "MetricExpr": "1/metric:CPI",
> > >          "MetricGroup": "TopDownL1",
> > >          "MetricName": "IPC"
> > >      },
> > > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > > index aa14c7111ecc..cd73dae4588c 100644
> > > --- a/tools/perf/util/expr.c
> > > +++ b/tools/perf/util/expr.c
> > > @@ -150,3 +150,14 @@ int expr__find_other(const char *expr, const char *one,
> > >
> > >         return ret;
> > >  }
> > > +
> > > +#define METRIC "metric:"
> > > +
> > > +bool expr__is_metric(const char *name, const char **metric)
> > > +{
> > > +       int ret = !strncmp(name, METRIC, sizeof(METRIC) - 1);
> > > +
> > > +       if (ret && metric)
> > > +               *metric = name + sizeof(METRIC) - 1;
> > > +       return ret;
> > > +}
> >
> > Should expr.l recognize metric:... as a different kind of token rather
> > than an ID?
>
> hm, we still want it to be returned as ID token, and the processing
> code needs a way to distinguish between event and metric, so I'd think
> we need to keep it, but I'll double check

Thanks, the struct names sound good. I suggested using a token as it
is a little strange that we have layers of parsing and this would be a
chance to avoid one layer. It isn't a big deal, the event parsing is
far more complex :-)

Ian

> thanks,
> jirka
>
