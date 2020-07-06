Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829C8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F09820720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594039141;
	bh=PlU8BSY+wNjEY5nGeiVNmxET7zLtMpSGhLtSKa5lOgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YrR2Bkh+es9jtBZyvLUnMDle7ispqzD3hN6tqqCCIzdxDlat0o8IRQkZhWUoxFSHC
	 jOujDFoP27WDEkrTlagYOK6+sJN+pNUjMoYntZJnHYNjeXZ4th+D9n3wDf1VHrRJXs
	 lGVn2KplE9zof5rOby6TC5XgyCDZ0iQpCcoYQAec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbgGFMjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgGFMi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:38:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.135.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1988320715;
        Mon,  6 Jul 2020 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594039138;
        bh=PlU8BSY+wNjEY5nGeiVNmxET7zLtMpSGhLtSKa5lOgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vhKgZZI6c77XupfGu8sQOpUMh393W7RQsAdyvA4CtqZ3zX0qc/EmEFoSW/XTzcl4B
         SxfPJ8Fh/kgV0J3ZakoxlIrdQ9l2qx8E7ZlNjc0h6Bxr9s6BbzXbzp5LPtx31LAkm/
         P7zgDZBv9Dak0VmMqyf3OiLVO4UE6ujI+LHCsRpU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F2B51405FF; Mon,  6 Jul 2020 09:38:55 -0300 (-03)
Date:   Mon, 6 Jul 2020 09:38:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Paul Clarke <pc@us.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        maddy@linux.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>, nasastry@in.ibm.com
Subject: Re: [PATCH] perf/tools/pmu-events/powerpc: Added nest imc metric
 events
Message-ID: <20200706123855.GI1320@kernel.org>
References: <20200703065658.377467-1-kjain@linux.ibm.com>
 <CAP-5=fUraGwGLC79g51eZpcB9e2P=tOmz7U7G=RAu+Hmjjjxzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUraGwGLC79g51eZpcB9e2P=tOmz7U7G=RAu+Hmjjjxzw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 05, 2020 at 06:30:30PM -0700, Ian Rogers escreveu:
> On Thu, Jul 2, 2020 at 11:57 PM Kajol Jain <kjain@linux.ibm.com> wrote:
> >
> > Added nest imc metric events.
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
 
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> > ---
> >  .../arch/powerpc/power9/nest_metrics.json     | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > index c121e526442a..8383a37647ad 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > @@ -15,5 +15,40 @@
> >         "MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
> >          "MetricName": "PowerBUS_Frequency",
> >          "ScaleUnit": "2.5e-7GHz"
> > +    },
> > +    {
> > +       "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
> > +       "MetricName" : "mcs01-read",
> > +       "MetricGroup" : "memory_bw",
> > +       "ScaleUnit": "6.1e-5MB"
> 
> nit: I'm guessing this is from:
> 64.0/(1024.0*1024.0) = 6.103515625e-05
> and for reference:
> 64.0/(1000.0*1000.0) = 6.3999999999999997e-05
> should the unit be MiB?
> https://en.wikipedia.org/wiki/Kibibyte
> 
> Searching around I only see knightslanding using MiB but it seems to
> be using it in the 1000^2 case which probably means it should be MB:
> knightslanding/uncore-memory.json:        "ScaleUnit": "6.4e-05MiB"
> 
> Given there is some confusion I wonder if it makes sense to just make
> this 0.015625B and then we have a utility function that selects the
> best unit for "bytes" with config options similar to --big-num?
> 
> Thanks,
> Ian
> 
> > +    },
> > +    {
> > +       "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
> > +       "MetricName" : "mcs23-read",
> > +       "MetricGroup" : "memory_bw",
> > +       "ScaleUnit": "6.1e-5MB"
> > +    },
> > +    {
> > +       "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
> > +       "MetricName" : "mcs01-write",
> > +       "MetricGroup" : "memory_bw",
> > +       "ScaleUnit": "6.1e-5MB"
> > +    },
> > +    {
> > +       "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
> > +       "MetricName" : "mcs23-write",
> > +       "MetricGroup" : "memory-bandwidth",
> > +       "ScaleUnit": "6.1e-5MB"
> > +    },
> > +    {
> > +       "MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
> > +       "MetricName" : "powerbus_freq",
> > +       "ScaleUnit": "1e-9GHz"
> > +    },
> > +    {
> > +       "MetricExpr" : "(nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@)",
> > +       "MetricName" : "Memory-bandwidth-MCS",
> > +       "MetricGroup" : "memory_bw",
> > +       "ScaleUnit": "6.1e-5MB"
> >      }
> >  ]
> > --
> > 2.17.1
> >

-- 

- Arnaldo
