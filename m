Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C87C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC242051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERsmc/Qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgCPN6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:58:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44456 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731392AbgCPN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:58:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id h16so14162752qtr.11;
        Mon, 16 Mar 2020 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3qtCtnALikW4YRd7lmEcJiEiNtsvnAppAgjxyAmiqH4=;
        b=ERsmc/Qibw62KbwGpwOOfWIZ6CBFiFkO67cMiCszwdoC1DcIaQu8Hw2zScckRBFb44
         k6GGHr1CPptG34oTO/ZnP+9Va99g5f7NypepdLh5NycRp3Osd96XGvWA4c68o3XvDYP/
         C71MoeHY59is5S69ymeDdD7pK2hzT7yvHs4mF1UVVEae44I7wUBwlUmKJ//z581FAYGb
         Gl7jgCbMqBDRIApWcMaBUFRcrUYOfpEc7/pgaj1AKUjzlnCiERfrzVCP8+lyl5mRppQA
         Gw+H0kLNsLXhnkQ0mQ2+CEttrfnsikLOSSCgc373TnuPJroYc/pFHduTIYS7SjyiiKzP
         7d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3qtCtnALikW4YRd7lmEcJiEiNtsvnAppAgjxyAmiqH4=;
        b=a8FpaQr7wnrvr3JSd5x8BOc/TRwCd8tFGnZFx6w9dKMc/QDlfhwNpb9vzthAx1bt8T
         ohUEXyiUsbA7tIgFz8pG8SDRD4BNG3JqG/MVE5AHIPyY/Glu3Kqx8WcbQdjBZk7e8i8J
         0jS0cYZpIJ8NoeysdlArzuOVfYBO+VTbzSXd6ibXaImYeoc4ZXexYRuTBwtphet1zyT5
         HIscXaBMB59H9SiyglrDQPyoIX6g3zG2UrtlzFIHFJLvdNSd7tYclIvJ2vdHsQBrvg5x
         iWUPHtx7K/n7fSTcGNtFDQvmfgAO+WX2w9OmqCDIlDSBkw/tf/zUGmpENYs77+cvbLPc
         fBdg==
X-Gm-Message-State: ANhLgQ1P+0Mx/rm/8wDKvWj5HLN9ZiBTxFKrkzUj1C1N3Bos1yO+IfL6
        7rfKoOBy/90qiGBm3/II5zA=
X-Google-Smtp-Source: ADFU+vsUgruPzO2nVj4karDuY2h5qc4Sh89hdsjxItBLh5zrjqCxWPDo0lF9ZHSswXcgZF3BH84LQw==
X-Received: by 2002:ac8:e45:: with SMTP id j5mr101097qti.215.1584367095370;
        Mon, 16 Mar 2020 06:58:15 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i4sm17930568qtr.41.2020.03.16.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 06:58:14 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C23F40009; Mon, 16 Mar 2020 10:58:12 -0300 (-03)
Date:   Mon, 16 Mar 2020 10:58:12 -0300
To:     Colin King <colin.king@canonical.com>,
        Andi Kleen <andi@firstfloor.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf vendor events: fix spelling mistakes: "occurences"
 -> "occurrences"
Message-ID: <20200316135812.GA28064@kernel.org>
References: <20200316093853.117752-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316093853.117752-1-colin.king@canonical.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 16, 2020 at 09:38:53AM +0000, Colin King escreveu:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Fix spelling mistake of "occurrences"

This has to be done on the master doc at Intel from where these json
files are generated, otherwise in the next update this will get
overwritten.

- Arnaldo
 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json    | 2 +-
>  tools/perf/pmu-events/arch/x86/ivytown/pipeline.json      | 2 +-
>  tools/perf/pmu-events/arch/x86/jaketown/pipeline.json     | 2 +-
>  .../perf/pmu-events/arch/x86/knightslanding/pipeline.json | 8 ++++----
>  tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json  | 2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> index 2a0aad91d83d..e5ca2d85e84d 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> @@ -80,7 +80,7 @@
>          "EdgeDetect": "1",
>          "EventName": "INT_MISC.RECOVERY_STALLS_COUNT",
>          "SampleAfterValue": "2000003",
> -        "BriefDescription": "Number of occurences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc.)",
> +        "BriefDescription": "Number of occurrences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc.)",
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
> index 2a0aad91d83d..e5ca2d85e84d 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
> @@ -80,7 +80,7 @@
>          "EdgeDetect": "1",
>          "EventName": "INT_MISC.RECOVERY_STALLS_COUNT",
>          "SampleAfterValue": "2000003",
> -        "BriefDescription": "Number of occurences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc.)",
> +        "BriefDescription": "Number of occurrences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc.)",
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> index 783a5b4a67b1..f32fd4aea6b1 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> @@ -1019,7 +1019,7 @@
>          "EdgeDetect": "1",
>          "EventName": "INT_MISC.RECOVERY_STALLS_COUNT",
>          "SampleAfterValue": "2000003",
> -        "BriefDescription": "Number of occurences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
> +        "BriefDescription": "Number of occurrences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> index 92e4ef2e22c6..17c92cdedde0 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> @@ -340,7 +340,7 @@
>          "UMask": "0x1",
>          "EventName": "RECYCLEQ.LD_BLOCK_ST_FORWARD",
>          "SampleAfterValue": "200003",
> -        "BriefDescription": "Counts the number of occurences a retired load gets blocked because its address partially overlaps with a store",
> +        "BriefDescription": "Counts the number of occurrences a retired load gets blocked because its address partially overlaps with a store",
>          "Data_LA": "1"
>      },
>      {
> @@ -349,7 +349,7 @@
>          "UMask": "0x2",
>          "EventName": "RECYCLEQ.LD_BLOCK_STD_NOTREADY",
>          "SampleAfterValue": "200003",
> -        "BriefDescription": "Counts the number of occurences a retired load gets blocked because its address overlaps with a store whose data is not ready"
> +        "BriefDescription": "Counts the number of occurrences a retired load gets blocked because its address overlaps with a store whose data is not ready"
>      },
>      {
>          "PublicDescription": "This event counts the number of retired store that experienced a cache line boundary split(Precise Event). Note that each spilt should be counted only once.",
> @@ -358,7 +358,7 @@
>          "UMask": "0x4",
>          "EventName": "RECYCLEQ.ST_SPLITS",
>          "SampleAfterValue": "200003",
> -        "BriefDescription": "Counts the number of occurences a retired store that is a cache line split. Each split should be counted only once."
> +        "BriefDescription": "Counts the number of occurrences a retired store that is a cache line split. Each split should be counted only once."
>      },
>      {
>          "PEBS": "1",
> @@ -367,7 +367,7 @@
>          "UMask": "0x8",
>          "EventName": "RECYCLEQ.LD_SPLITS",
>          "SampleAfterValue": "200003",
> -        "BriefDescription": "Counts the number of occurences a retired load that is a cache line split. Each split should be counted only once.",
> +        "BriefDescription": "Counts the number of occurrences a retired load that is a cache line split. Each split should be counted only once.",
>          "Data_LA": "1"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> index b7150f65f16d..d69db55f33e7 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> @@ -108,7 +108,7 @@
>          "EdgeDetect": "1",
>          "EventName": "INT_MISC.RECOVERY_STALLS_COUNT",
>          "SampleAfterValue": "2000003",
> -        "BriefDescription": "Number of occurences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
> +        "BriefDescription": "Number of occurrences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
>          "CounterMask": "1",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      },
> -- 
> 2.25.1
> 

-- 

- Arnaldo
