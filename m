Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF5AC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E81206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bajct2+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgF2TEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbgF2TCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526DDC030F21
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:35:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so17157468wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wt2+QYgzsGCiZ5jzGn3DF1M7zW6pV2DVB1wYY6nIW44=;
        b=Bajct2+ZVPJoRDMicEwKHAotig5QEVkNwLKSg5aT/LW6Wumvsk90f6Q/QIhvsNLrRD
         WN2tHYAAbLHeLZqX7YNifnMuJh0renYAvTm5Tk59GaHQkmKIDfyWHsX9I6ENwSnImZdl
         Qe3IrLAf2Dj4DECkRUQw51ToAgudOdJu5jMZ5UpIh39n38MugmAaah2n8q5yT+ohLjas
         JZCD6OJveAlK+kqzISbbU9xkaEt1kZVWqziHeOmdyxILTGPtYvUf4KfO63ByrOZqidhi
         sWuqgP5e/+QcHcxm+DppmbvrHPyHjXH+ZAhfQc90BQ9v+9St/WnEM+JLDYCzCRs59Cp3
         Mywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wt2+QYgzsGCiZ5jzGn3DF1M7zW6pV2DVB1wYY6nIW44=;
        b=B8qU7oO2iwBHVFVNOASSe8AkMP7sylDkQc8BJUpfz2dGuQFr5bWoEw7Xy4Nazv8cUD
         6hpTA4Q3+IH4gNPkwepMkT2vRjztJdEi1db+5iyeThRjUic2OzmtF6tfCqNAP9q53lhg
         eI7NryPLZgDVCVi9cyD2NwOCxCeLkRLZtwrQVoLBBMyAfiEUkVHo/yIWAoKjeCx2gD43
         asJetwa6r8URrUFbkDw2+mhjT0M8sgAyj1dbdWtKJoSPzwm55djad2SQ9Ayijs27DYN+
         wGJQpQtkNZTDeOnOkSjBmyuCdDHGk/8EJ1JCnldMj9VRcBNHQ+vlvR1CQAjsJrxGoQ4p
         LMrA==
X-Gm-Message-State: AOAM531Gc8FbVrh5PR1QvvzDg/4TxRuhNY92yqVWRPBR4uEwRGWij8Zq
        m4RLysd4tDYF5PQg1ZhijjRCYhAMiaOBsoODHRYRfw==
X-Google-Smtp-Source: ABdhPJzY4nZ0xx0kja+NoBvYD52SqAzPXWDc1jiACjyyTIkCa7mTWSDocPv4eNorqBHjQYtDKek4O7uzGakdu8Ok4fo=
X-Received: by 2002:adf:e40e:: with SMTP id g14mr19147300wrm.271.1593448523736;
 Mon, 29 Jun 2020 09:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-10-jolsa@kernel.org>
 <CAP-5=fUODuF+LY6cbU4BPEcxu_YXDYg42pgRYU=yY5e47z05=g@mail.gmail.com> <20200628215957.GO2988321@krava>
In-Reply-To: <20200628215957.GO2988321@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Jun 2020 09:35:12 -0700
Message-ID: <CAP-5=fWS7dsqrjM2gP6fpsjbjW5CoFHwGLYf-WxzJ9JdhD-LzQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] perf tools: Compute other metrics
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

On Sun, Jun 28, 2020 at 3:00 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jun 26, 2020 at 02:24:38PM -0700, Ian Rogers wrote:
>
> SNIP
>
> > > +
> > > +                                       if (expr__get_id(ctx, lookup, &data) || !data) {
> > >                                                 pr_debug("%s not found\n", $1);
> > >                                                 free($1);
> > >                                                 YYABORT;
> > >                                         }
> > > +
> > > +                                       pr_debug2("lookup: is_other %d, counted %d: %s\n",
> > > +                                                 data->is_other, data->other.counted, lookup);
> > > +
> > > +                                       if (data->is_other && !data->other.counted) {
> > > +                                               data->other.counted = true;
> > > +                                               if (expr__parse(&data->val, ctx, data->other.metric_expr, 1)) {
> >
> > Ah, so this handles the problem the referenced metric isn't calculated
> > and calculates it - with the sharing of events this doesn't impose
> > extra pmu cost. Do we need to worry about detecting recursion? For
> > example:
> >
> > "MetricName": "Foo",
> > "MetricExpr": "1/metric:Foo",
>
> right, we should add some recursion check,
> I'll lcheck on it
>
> >
> > It seems unfortunate to have the MetricExpr calculated twice, but it
>
> hum, not sure what you mean by twice.. we do that just once for
> each involved metric and store the value.. the metric is also
> processed before for 'other' metrics

So I'm thinking out loud. Here is an example from Skylake:

{
 "BriefDescription": "All L2 hit counts",
 "MetricExpr": "L2_RQSTS.DEMAND_DATA_RD_HIT + L2_RQSTS.PF_HIT +
L2_RQSTS.RFO_HIT",
 "MetricName": "DCache_L2_All_Hits",
}
{
 "BriefDescription": "All L2 miss counts",
 "MetricExpr": "MAX(L2_RQSTS.ALL_DEMAND_DATA_RD -
L2_RQSTS.DEMAND_DATA_RD_HIT, 0) + L2_RQSTS.PF_MISS +
L2_RQSTS.RFO_MISS",
 "MetricName": "DCache_L2_All_Miss",
}
{
 "BriefDescription": "All L2 counts",
 "MetricExpr": "metric:DCache_L2_All_Hits + metric:DCache_L2_All_Miss",
 "MetricName": "DCache_L2_All",
}
{
 "BriefDescription": "DCache L2 hit rate",
 "MetricExpr": "d_ratio(metric:DCache_L2_All_Hits, metric:DCache_L2_All)",
 "MetricName": "DCache_L2_Hits",
 "MetricGroup": "DCache_L2",
 "ScaleUnit": "100%",
},
{
 "BriefDescription": "DCache L2 miss rate",
 "MetricExpr": "d_ratio(metric:DCache_L2_All_Miss, metric:DCache_L2_All)",
 "MetricName": "DCache_L2_Misses",
 "MetricGroup": "DCache_L2",
 "ScaleUnit": "100%",
},

Firstly, it should be clear that having this change makes the json far
more readable! The current approach is to copy and paste resulting in
100s of characters wide expressions. This is a great improvement!

With these metrics the hope would be that 'perf stat -M DCache_L2 ...'
is going to report just DCache_L2_Hits and DCache_L2_Misses. To
compute these two metrics, as an example, DCache_L2_All_Hits is needed
three times. My comment was meant to mean that it seems a little
unfortunate to keep repeatedly evaluating the expression rather than
to compute it once and reuse the result.

Thanks,
Ian

> jirka
>
> > is understandable. Is it also a property that referenced/other metrics
> > won't be reported individually? Perhaps these are sub-metrics?
>
> >
> > Thanks,
> > Ian
> >
> > > +                                                       pr_debug("%s failed to count\n", $1);
> > > +                                                       free($1);
> > > +                                                       YYABORT;
> > > +                                               }
> > > +                                       }
> > > +
> > >                                         $$ = data->val;
> > >                                         free($1);
> > >                                 }
> > > --
> > > 2.25.4
> > >
> >
>
