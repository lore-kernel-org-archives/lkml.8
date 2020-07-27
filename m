Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEBDC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C835F20759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1OLq0r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgG0U3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbgG0U3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:29:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE664C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:29:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so10564813pge.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZZE0HZeDL5UBrXoQ+ujG0JHVNwE71GMAkB+NRWsAgu0=;
        b=n1OLq0r/GKYz8Y0x/eHB+o6erqShH+VRB+ABUFXzEgSJPT6jh0hyCqGULmA5MpQ4NG
         T/X7y+p8eznBWNfJN0bCY8u9yWE0H9hOm9jBXA0+S73P+cQJYYbFt2Utop3k0kB5mlTL
         7mTzIgyQPEaDf5iNXdp1rES9pZ9EZVSZ4mUoTCWOt1l4ABtO7RGucr29xwNNEBMm6f+5
         Qu4y1hySX5skV1vNnKqkKi2SXpMpsDObw38lP0eCip/sUn5KEKigD/29xNd6CRyLyWFM
         x2pJY7fPmSLwlQvmYhic4mash6tRTaaMgnuU0MMeC8MHBAflxWlQQkyyFIgz3FGr39UM
         nLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZZE0HZeDL5UBrXoQ+ujG0JHVNwE71GMAkB+NRWsAgu0=;
        b=Z0iV3dhgmFONPnWx+/X50B5HW/ySjcDZutPw5nEmds/t7c5xOeVL0Ex9cr+QpTRQSL
         wo+fwX5BJCnPGN/rnEqoty7S6ed6glQZHcPsrD+Cz5ct/Wam3DSM6Yv5/unGL/zk5HQw
         S73cibsODHzkEUbm16L6V/ztwX+e3yQA4LEytD0fag1lM0DzslkyVGWRnCErWbWsepk9
         mcFVUcwfpz+8zj6wpA8DuWn67DUGAQ/qlr3C82zCbPkOVbv8Yj1eSx4jrfz+ib+Nkh/Q
         Ak74ygLdKoJZFzdV2b86j1zeDMm/fV6lU4qrImAS68YJGefdwqR8HRgQgat9ScJh2x8H
         +HhA==
X-Gm-Message-State: AOAM533SY7rj8N+W8ptv5u8gVvwSLjRYf3/2gsp5C7UO45yegvaoQTbq
        X/YjOIGxDxLfGdt+Y0D6Qb8Cxg==
X-Google-Smtp-Source: ABdhPJzSYmJD1T3R1Puzm/m1BNEdBF/HDyi984VBuDf0FSSRRh4x/jGO+DmMej430nP+b4o2q5vXXA==
X-Received: by 2002:aa7:93bb:: with SMTP id x27mr3317469pff.203.1595881781333;
        Mon, 27 Jul 2020 13:29:41 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 141sm16796428pfw.72.2020.07.27.13.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:29:40 -0700 (PDT)
Date:   Mon, 27 Jul 2020 14:29:38 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     leo.yan@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
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
Message-ID: <20200727202938.GB2381376@xps15>
References: <20200724071111.35593-1-liwei391@huawei.com>
 <20200724071111.35593-2-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724071111.35593-2-liwei391@huawei.com>
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

Usually SHA1 are 12 character long rather than 13.  Depending on what Arnaldo
wants to do you may have to resend.

> Signed-off-by: Wei Li <liwei391@huawei.com>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

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
