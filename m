Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89500C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D5B2071C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkmzhG0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDVWqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgDVWqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:46:45 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B77C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:46:44 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id i16so2090534ybq.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=By0UsUhZVZtoAmBKjypfpeldZgKiGOA+PhJTwHcpY2A=;
        b=hkmzhG0Szlk6dLqIhJVLMVYLOmN7+LIE+ltfsz3TBmwQ0istc0TU4Kn8uEZYceToYF
         sGrCsdldeJLydgoV31c5Ib/g2VCiIgNIo7YMBQEUrieih2GPr3dP0F6uModcl49M7M/n
         1d3oBQEwH6qMOgEEqHFyGrlbrBo4NnUG0uIsvvAtLb+c0igCJkrvaWh03nRUFaLbIJY+
         QcrCEy4cDKY5k3hnspQ7bZieYNa/JI/Z9qJFAjjlv6ZqNGz1oGtpYgnMdzh7FtbS9eDp
         dFRFRQGz/VGSdyxWzw+kjzaKr/1ex7unGcu6sSFfOKR/wr4c49ppkjLxodeaBamDJZD/
         wvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=By0UsUhZVZtoAmBKjypfpeldZgKiGOA+PhJTwHcpY2A=;
        b=V2p9frCXjOc6+N+m2V1mA/31AO8P8HkaPgPG7xHQiGjdaEtIsj6rgaVwJzAPf0ipuf
         xH3MEUq4pZFK+glnjAEaL0AObHlZt9vOKBgnwVPyVDEMEymAhaFDMvt2wwS40g9+cfAx
         pjti0ZDEcrbK/fagvVdgqgjYjra4Ep3NhqH5JFTW2EbvVPeCg8qr0vW/101aRHpWVaqc
         KALRrXptUCTH1Ph6C4vcLpMOc26EAbopeiLwrQTGq6CMGz+Pcl/bhpIbPmM953m46w1C
         kG8+vlpHmM2DwDC5n2EQYXmOjRm1uGRDcbUp3MEvLEnvDA5Im+rCeW8Uq+ntQot7wrBm
         QkiA==
X-Gm-Message-State: AGi0PuZzoNN5D9Yp1YCwUORfI8dxjpQzwrUxIxpHzpmKEoW8HCFSTAmn
        rDoJyJq6ZHTDKhbVHEjazaXBq+03bdiSczpA6u2r6A==
X-Google-Smtp-Source: APiQypK5ZG4rSt40/22JbAmemrxcrOOyQGqL1jgTRfkhJ5lKdsHLv6oOSfcKyXtS6EVQC1tgwXvcbpBqmKJGLGR2TEY=
X-Received: by 2002:a25:be81:: with SMTP id i1mr2097391ybk.184.1587595603400;
 Wed, 22 Apr 2020 15:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com> <20200422220430.254014-9-irogers@google.com>
 <70bb1987-c8cd-ecc1-a6d8-61569a83494c@us.ibm.com>
In-Reply-To: <70bb1987-c8cd-ecc1-a6d8-61569a83494c@us.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Apr 2020 15:46:32 -0700
Message-ID: <CAP-5=fVOPdFjthXuh1MZWuNzJbEATg0EnL946HBYo+vzdbiwVw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] perf metrics: fix parse errors in power8 metrics
To:     Paul Clarke <pc@us.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 3:31 PM Paul Clarke <pc@us.ibm.com> wrote:
>
> On 4/22/20 5:04 PM, Ian Rogers wrote:
> > Mismatched parentheses.
> >
> > Fixes: dd81eafacc52 (perf vendor events power8: Cpi_breakdown & estimated_dcache_miss_cpi metrics)
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/arch/powerpc/power8/metrics.json | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
> > index bffb2d4a6420..ad71486a38e3 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
> > @@ -169,7 +169,7 @@
> >      },
> >      {
> >          "BriefDescription": "Cycles GCT empty where dispatch was held",
> > -        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL)",
> > +        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL",
>
> OK. (Thank you!)
>
> >          "MetricGroup": "cpi_breakdown",
> >          "MetricName": "gct_empty_disp_held_cpi"
> >      },
> > @@ -886,7 +886,7 @@
> >      },
> >      {
> >          "BriefDescription": "GCT slot utilization (11 to 14) as a % of cycles this thread had atleast 1 slot valid",
> > -        "MetricExpr": "PM_GCT_UTIL_11_14_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
> > +        "MetricExpr": "PM_GCT_UTIL_11_14_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC ) * 100",
>
> I think this is just a whitespace change?  Is it necessary?
> Curiosity, more than complaint.

Sorry about that, the space isn't necessary and this doesn't need to
change. For the curious, originally the parse test would make all
metrics equal to 1.0 and this metric would trigger a divide by zero
because of this. This motivated adding a debug print for this case.

Thanks,
Ian

> >          "MetricGroup": "general",
> >          "MetricName": "gct_util_11to14_slots_percent"
> >      },
>
> Reviewed-by: Paul A. Clarke <pc@us.ibm.com>
>
> PC
