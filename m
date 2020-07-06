Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E74AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365902074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVv1wBIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgGFBao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgGFBan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:30:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252FFC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 18:30:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so39147647wrn.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 18:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JYyRVvqNIc62LGSokbbb0X0L2S1S+TqLgg1DI9mzWEU=;
        b=mVv1wBIcJTFIMn19FwpgaohZ0VYTsrPIRxYNcXMjeY4CGHr4karnOelIfVeLOz1qH+
         kVoEJUKxGbxbqp6BD9TtvPQwf9WceT+vYZ9LPqEBTc444cidPcne/QNcBGd8xK2puDJm
         RiNU1jBSufXnTZKTdCNaS37KDkyk79YEg7yEB+hsXVLq3oaFRkQjM1Seh4FE9x7Ki0If
         ThjP5/9VE0D/LFWtiupEKPI2plz8BrZ+B+xX3ulMeQ/6BLFDI0O7BpiYSa/p8lcqkeSB
         eaBxpd0cTNWjgjy33WKCPg7g4OaZbKJa22CwhSAaw/AauFw7aJHMCavPoqyQmT3MgP5f
         cSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JYyRVvqNIc62LGSokbbb0X0L2S1S+TqLgg1DI9mzWEU=;
        b=i3Civ31v5swVeRRM21oiFlRJurQS4aA/bmD7DR5Rqr5GRNmiJyhWXvYZOi+HzeyKjy
         Gf/8YRhZGj3ZoKt0ufzDCVIW6C7lEjDd07kKEIQNWgmsvQ+8a1vOqAKfcmiMSeBlo2qD
         T0Gf4EbNaT6nRh+A3I/VXLtbKJpYxwvsn6FdK+7Bgt9KWSIQknc+DbwEqXJAzx7ZuB0n
         rpXyRjTFbt2a2XkZnlUMk7+vssduzca6n+8Q5vz+qlJNbi88q4As/Co2XIK/cp46avWg
         LHwn3ypDpguY9wmAY9UYfd89VL6t5YgkTJLTcj7kkIIJQJdeqO8SY0Va+ByU4GG+haM1
         P35Q==
X-Gm-Message-State: AOAM531A3fbrQUSiPZqHRbDqPrJ6+5rmxg06/AuBP9T0Hj1Snonlb1ll
        zlV73WSj3mGorBpVs+BGOdI/kxKVShPYeivO2K+bqw==
X-Google-Smtp-Source: ABdhPJy0owcxY3FvUnm/MFMNAcffijazPUsWYCPlPupXNBs64/jQXJxJR20x81QjnlwzJVv6YNHrB+j8XrT5YQkXW7c=
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr44322325wrn.48.1593999041596;
 Sun, 05 Jul 2020 18:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200703065658.377467-1-kjain@linux.ibm.com>
In-Reply-To: <20200703065658.377467-1-kjain@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 5 Jul 2020 18:30:30 -0700
Message-ID: <CAP-5=fUraGwGLC79g51eZpcB9e2P=tOmz7U7G=RAu+Hmjjjxzw@mail.gmail.com>
Subject: Re: [PATCH] perf/tools/pmu-events/powerpc: Added nest imc metric events
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 11:57 PM Kajol Jain <kjain@linux.ibm.com> wrote:
>
> Added nest imc metric events.

Acked-by: Ian Rogers <irogers@google.com>

> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  .../arch/powerpc/power9/nest_metrics.json     | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json =
b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> index c121e526442a..8383a37647ad 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> @@ -15,5 +15,40 @@
>         "MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=3D?@ )",
>          "MetricName": "PowerBUS_Frequency",
>          "ScaleUnit": "2.5e-7GHz"
> +    },
> +    {
> +       "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + ne=
st_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
> +       "MetricName" : "mcs01-read",
> +       "MetricGroup" : "memory_bw",
> +       "ScaleUnit": "6.1e-5MB"

nit: I'm guessing this is from:
64.0/(1024.0*1024.0) =3D 6.103515625e-05
and for reference:
64.0/(1000.0*1000.0) =3D 6.3999999999999997e-05
should the unit be MiB?
https://en.wikipedia.org/wiki/Kibibyte

Searching around I only see knightslanding using MiB but it seems to
be using it in the 1000^2 case which probably means it should be MB:
knightslanding/uncore-memory.json:        "ScaleUnit": "6.4e-05MiB"

Given there is some confusion I wonder if it makes sense to just make
this 0.015625B and then we have a utility function that selects the
best unit for "bytes" with config options similar to --big-num?

Thanks,
Ian

> +    },
> +    {
> +       "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + ne=
st_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
> +       "MetricName" : "mcs23-read",
> +       "MetricGroup" : "memory_bw",
> +       "ScaleUnit": "6.1e-5MB"
> +    },
> +    {
> +       "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + ne=
st_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
> +       "MetricName" : "mcs01-write",
> +       "MetricGroup" : "memory_bw",
> +       "ScaleUnit": "6.1e-5MB"
> +    },
> +    {
> +       "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + ne=
st_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
> +       "MetricName" : "mcs23-write",
> +       "MetricGroup" : "memory-bandwidth",
> +       "ScaleUnit": "6.1e-5MB"
> +    },
> +    {
> +       "MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
> +       "MetricName" : "powerbus_freq",
> +       "ScaleUnit": "1e-9GHz"
> +    },
> +    {
> +       "MetricExpr" : "(nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + n=
est_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_=
RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@ + nest_mcs01=
_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_P=
ORT23@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_M=
CS23_128B_WR_DISP_PORT23@)",
> +       "MetricName" : "Memory-bandwidth-MCS",
> +       "MetricGroup" : "memory_bw",
> +       "ScaleUnit": "6.1e-5MB"
>      }
>  ]
> --
> 2.17.1
>
