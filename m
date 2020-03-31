Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9A2208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGcQY9OV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgCaTIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:08:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41900 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgCaTIM (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:08:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id q188so24277266qke.8
        for <Linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kfxuOLi573qLCPHoRYNlv++6004OLZ/KMbmyRo3d8Kk=;
        b=pGcQY9OVjnVnV1sFaFvIFquoRLmJQInWwu1QcoFwYJEiSXSyXs/asKSi5lqgvPUoUv
         DhVtm9IljhhHf3poZrN+MmAMzrtVwoaKGnJlX+cG+nqyvcyfWcLsP+gJb8hIQvtFYzLv
         X9yCeIS2n3LBVJ7Kl5C3KbNKKLEwW7N/Kwy17+hZNjVBasuCWTEMS33tFLBHtukubzSl
         WtbixzGb/K1haxrznQHUOFnKEzxNG1A6Qv41qg+QRJv5ns+YETne2aKpczDvOPXToarK
         Np8l2dno6zItLToHba82kaJ0a3nWEJruvtIkJDO+gWgnvry4asfsFITcc0b82+DfXQGa
         3+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kfxuOLi573qLCPHoRYNlv++6004OLZ/KMbmyRo3d8Kk=;
        b=BCV7FaW+QWU1gfanyo+QOBJ9fQmIq9M9YWddhxNGh34ioIevlMNXK8mhbe20N7pEb7
         Kx4rFhaYOkl1QqKjW6tk8eYo6o/ohhYRKohV2uuR+c+kMY/ENwLNXcqdPTt3QIDcsQ6e
         1ah8XL/FKJg1/74G1i4tP8lzdVjPQWZi40XvFkBaDNqNQfzNW70Bs6lOhDLOiKdNmbxq
         k3+xcPy5qvUArNb2I6P0hs+Ozdj4A02/3+N9PMxVEZUIKxRn2beHkmvJgtn4S5AGZQTC
         6nQ3wKRZtYl87rAx22CJnuUso0FP+zv32/LsxGokhnotmGDDR8LuRbarFpVQfC0MD424
         S70Q==
X-Gm-Message-State: ANhLgQ3OhBJ9GjekdirKiOukWGWL4cDD4mfn89T4dwfGTyI2HVfRFAKb
        8kd/LF6vcVhhvWio48+WdeI=
X-Google-Smtp-Source: ADFU+vtDC6zJQQibMsUvQOk/Xdt0K84ub3VjkyznxuSBOJSmmy/tagny/QMyWx8ERGy+9af7HnnIdA==
X-Received: by 2002:a37:514:: with SMTP id 20mr6212267qkf.420.1585681688621;
        Tue, 31 Mar 2020 12:08:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id a200sm13387691qkc.13.2020.03.31.12.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:08:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 54BF3409A3; Tue, 31 Mar 2020 16:08:04 -0300 (-03)
Date:   Tue, 31 Mar 2020 16:08:04 -0300
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf/x86/pmu-events: Use CPU_CLK_UNHALTED.THREAD in
 Kernel_Utilization metric
Message-ID: <20200331190804.GK9917@kernel.org>
References: <20200309013125.7559-1-yao.jin@linux.intel.com>
 <f335f8ec-f92e-787e-0594-00cec2e06036@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f335f8ec-f92e-787e-0594-00cec2e06036@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 30, 2020 at 08:38:29AM +0800, Jin, Yao escreveu:
> Hi,
> 
> Any comments for this patch?

Can someone help Jin reviewing this x86 specific metric?

- Arnaldo
 
> Thanks
> Jin Yao
> 
> On 3/9/2020 9:31 AM, Jin Yao wrote:
> > The kernel utilization metric does multiplexing currently and is somewhat
> > unreliable. The problem is that it uses two instances of the fixed counter,
> > and the kernel has to multipleplex which causes errors. So should use
> > CPU_CLK_UNHALTED.THREAD instead.
> > 
> > Before:
> > 
> >    # perf stat -M Kernel_Utilization -- sleep 1
> > 
> >    Performance counter stats for 'sleep 1':
> > 
> >            1,419,425      cpu_clk_unhalted.ref_tsc:k
> >        <not counted>      cpu_clk_unhalted.ref_tsc	(0.00%)
> > 
> > After:
> > 
> >    # perf stat -M Kernel_Utilization -- sleep 1
> > 
> >    Performance counter stats for 'sleep 1':
> > 
> >              746,688      cpu_clk_unhalted.thread:k #      0.7 Kernel_Utilization
> >            1,088,348      cpu_clk_unhalted.thread
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> >   tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json     | 2 +-
> >   tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
> >   tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json    | 2 +-
> >   tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 2 +-
> >   tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json       | 2 +-
> >   tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json      | 2 +-
> >   tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json     | 2 +-
> >   tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json       | 2 +-
> >   tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json      | 2 +-
> >   tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json   | 2 +-
> >   tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json       | 2 +-
> >   tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json      | 2 +-
> >   12 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> > index 45a34ce4fe89..8cdc7c13dc2a 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> > @@ -297,7 +297,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > index 961fe4395758..16fd8a7490fc 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > @@ -115,7 +115,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> > index 746734ce09be..1eb0415fa11a 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> > @@ -297,7 +297,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > index f94653229dd4..a2c32db8f14e 100644
> > --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > @@ -315,7 +315,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> > index 5402cd3120f9..f57c5f3506c2 100644
> > --- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> > @@ -267,7 +267,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> > index 832f3cb40b34..311a005dc35b 100644
> > --- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> > @@ -267,7 +267,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> > index d69b2a8fc0bc..28e25447d3ef 100644
> > --- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
> > @@ -285,7 +285,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> > index 5f465fd81315..db23db2e98be 100644
> > --- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> > @@ -285,7 +285,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> > index 3e909b306003..dbb33e00b72a 100644
> > --- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> > @@ -171,7 +171,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> > index 50c053235752..fb2d7b8875f8 100644
> > --- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> > @@ -171,7 +171,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > index e7feb60f9fa9..e3afc3178958 100644
> > --- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> > @@ -303,7 +303,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> > index 21d7a0c2c2e8..12d1efba79bb 100644
> > --- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> > @@ -315,7 +315,7 @@
> >       },
> >       {
> >           "BriefDescription": "Fraction of cycles spent in Kernel mode",
> > -        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:k / CPU_CLK_UNHALTED.REF_TSC",
> > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD:k / CPU_CLK_UNHALTED.THREAD",
> >           "MetricGroup": "Summary",
> >           "MetricName": "Kernel_Utilization"
> >       },
> > 

-- 

- Arnaldo
