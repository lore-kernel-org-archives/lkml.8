Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCF7C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061C22070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IflV+gAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgGXI7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgGXI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:59:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E1FC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:59:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k1so4856404pjt.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1MxniXN6LhWByFZd4hnNaw3opb0vP8cxpLeP2Agsu5I=;
        b=IflV+gAxT3o6ePugHRwOdjpdhbFWlIGjyFlYk9LM2PbjKfXT/NEQnKrhYW0sNSs5Fm
         AJpoEwiBW36h6dcvC/UVPE48u278JfgOvIu0o590YtVkmFEBVmnSC39+y2ZE5lKVEJp4
         EchMpPZeRsSueONz/TcFnkyqxjyokvVkipl73X94DlpF4/CfWWdT5OpEOayoD8U0+7zv
         TtJES8NzlrZEvUTABiRwumPB1LtaMeTbDfgmQQCsRk6Uc2mokLerAIsLYlaql0oCrZcv
         SAEQEw+zu0Vm0ca35u7CMapl0qVnro7EMlFhy4sLaQCG4mgP3JNnvNWN7MGx5rfkSNID
         ycjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1MxniXN6LhWByFZd4hnNaw3opb0vP8cxpLeP2Agsu5I=;
        b=X65G0xcwbBqqm05oNreDcnd3amg3paQwU33QAr/SlRPADE4HH4fAO+cwgMbdDPAxw5
         vMw2b/ERM2jzSMXJnCayee7raFJW4GiGIvPgjJ7F/Uhj6y4bdA1qglz/B9GLaHrlqCkB
         1Jsd9+oPHqH9wGzRUuBGVnXhq5iqMmltyGSIkuumoOZ0hZx+8o16or12ggl2nN52eI1l
         Kz3bY9HW3SfCvVp4MRZATkzZWauPdP0UUXmjBFs8jpP2bckn25dbyMLlMiWAR7KHndjg
         oK0q+jEAWfxKGxDeAjggkqsXZRrjMyz1JTrf3gwY4sN3PEBWcgu4kmD4VfItZTAM7C1k
         1b9A==
X-Gm-Message-State: AOAM533LDovuEMMcQy3wNTfPXJOnfs0CmIe0ufdOE2HPvWZIRvlUu5bc
        +nzE9hUh3HSQBY0T5MbqVCrBHUr1L/kdMQ==
X-Google-Smtp-Source: ABdhPJzf8pEDqQLmMmwoYOu8Fk3KR19ULkiH8Lhwl0XGLsZespjeFGAi+KO7umLqyg5m6ImPC+A8ig==
X-Received: by 2002:a17:90b:300a:: with SMTP id hg10mr4395895pjb.211.1595581164648;
        Fri, 24 Jul 2020 01:59:24 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([117.136.120.151])
        by smtp.gmail.com with ESMTPSA id s30sm5729984pgn.34.2020.07.24.01.59.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 01:59:24 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:59:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, guohanjun@huawei.com
Subject: Re: [PATCH v2 1/2] perf tools: Fix record failure when mixed with
 ARM SPE event
Message-ID: <20200724085911.GA8487@leoy-ThinkPad-X240s>
References: <20200724071111.35593-1-liwei391@huawei.com>
 <20200724071111.35593-2-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724071111.35593-2-liwei391@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 03:11:10PM +0800, Wei Li wrote:
> When recording with cache-misses and arm_spe_x event, i found that
> it will just fail without showing any error info if i put cache-misses
> after 'arm_spe_x' event.
> 
> [root@localhost 0620]# perf record -e cache-misses -e \
> arm_spe_0/ts_enable=1,pct_enable=1,pa_enable=1,load_filter=1,\
> jitter=1,store_filter=1,min_latency=0/ sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.067 MB perf.data ]
> [root@localhost 0620]# perf record -e \
> arm_spe_0/ts_enable=1,pct_enable=1,pa_enable=1,load_filter=1,jitter=1,\
> store_filter=1,min_latency=0/ -e cache-misses sleep 1
> [root@localhost 0620]#
> 
> The current code can only work if the only event to be traced is an
> 'arm_spe_x', or if it is the last event to be specified. Otherwise the
> last event type will be checked against all the arm_spe_pmus[i]->types,
> none will match and an out of bound 'i' index will be used in
> arm_spe_recording_init().
> 
> We don't support concurrent multiple arm_spe_x events currently, that
> is checked in arm_spe_recording_options(), and it will show the relevant
> info. So add the check and record of the first found 'arm_spe_pmu' to
> fix this issue here.
> 
> Fixes: ffd3d18c20b8d ("perf tools: Add ARM Statistical Profiling Extensions (SPE) support")
> Signed-off-by: Wei Li <liwei391@huawei.com>

Thanks for the patch, Wei.  I have tested this series on Arm64 D06
platform:

Tested-by: Leo Yan <leo.yan@linaro.org>

I'd like to wait for Mathieu's ACK.

Thanks,
Leo

> ---
>  tools/perf/arch/arm/util/auxtrace.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 0a6e75b8777a..28a5d0c18b1d 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -56,7 +56,7 @@ struct auxtrace_record
>  	struct perf_pmu	*cs_etm_pmu;
>  	struct evsel *evsel;
>  	bool found_etm = false;
> -	bool found_spe = false;
> +	struct perf_pmu *found_spe = NULL;
>  	static struct perf_pmu **arm_spe_pmus = NULL;
>  	static int nr_spes = 0;
>  	int i = 0;
> @@ -74,12 +74,12 @@ struct auxtrace_record
>  		    evsel->core.attr.type == cs_etm_pmu->type)
>  			found_etm = true;
>  
> -		if (!nr_spes)
> +		if (!nr_spes || found_spe)
>  			continue;
>  
>  		for (i = 0; i < nr_spes; i++) {
>  			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
> -				found_spe = true;
> +				found_spe = arm_spe_pmus[i];
>  				break;
>  			}
>  		}
> @@ -96,7 +96,7 @@ struct auxtrace_record
>  
>  #if defined(__aarch64__)
>  	if (found_spe)
> -		return arm_spe_recording_init(err, arm_spe_pmus[i]);
> +		return arm_spe_recording_init(err, found_spe);
>  #endif
>  
>  	/*
> -- 
> 2.17.1
> 
