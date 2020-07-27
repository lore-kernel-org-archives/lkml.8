Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F3C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137D020792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1tC07P0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgG0Uel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgG0Uek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:34:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54709C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:34:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so8757085ply.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WP0fLNy8D403ScB05mOHvlfIuI3Tu9/pHzHxCWbIkXw=;
        b=V1tC07P0C1HuxAi2wM10iFmcSTSGt/L09OuGoLRIA+huxAJ9JDkQx46T24Kiil1Ax9
         ljXCLhT5b3mRb79bGD5X+jBT1yaP6I68UFGizDP39qT9H3jukxUJGycy0GGEFQXofdpB
         VNYb7sLf6NsspCGNAr+qsl1L84hfDyttllEeEOTufecX7TnOrNJhjLxQEaexkgngOhsy
         G7M34PMqr83wMpore2LkQSoRqKpxBlys/MG/S6UWytgdsS4xiVpxgfnTfTL/3aayVBUk
         wi1pQb0/kef9Abs94i1a3DSTdga7caEIMxkqY8JKCY+iu8REwl1y+QzVQ67iCuDAnfd/
         bm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WP0fLNy8D403ScB05mOHvlfIuI3Tu9/pHzHxCWbIkXw=;
        b=M/XcFnQ5H2SP28eM+RIA78xj2dMywrSStJUO8RVBW/TXu12CtRst8IyvRgBAr2RlTn
         bOJFBdx0kXLBmWNdPhgR0kshYdcD0fj4Xp6OJhTZjCLZl1NNbysS6nv3ytxpaSNG6cBH
         SxOfqf8sTTICqSZeG74rDzafFStGsZvLzrkf01Oas9PrkrDB4VF6wBIhsPqISDdyPhAt
         sNckFHXObyfF9+kQO0aIm4c8aojtDlw9YbP+E0jPGxBtNJ3hTBO3pwPkU6oqiOuBmPlV
         QbmWTeorIqrZ4wojicuzYAWkLxM28+qPTv0vpBcH7lt0eRcAOeRpCffz4jgVeb9/XOBX
         YgEw==
X-Gm-Message-State: AOAM533HiwycanMl7t0yvUBzCMhQNKTtL5afCt1xFyLIqJrYbYVFfKFc
        mM1Xse/RtRXlCZzjZ49Q9/rEsXt9JbM=
X-Google-Smtp-Source: ABdhPJyF7g2Ad/CT2Y8o0gkeq9t2s5jq5sTKFwMKXA2IC7jBq7CmWYJ0t0OAvdUGzK0Mp0fsg2NehQ==
X-Received: by 2002:a17:90b:247:: with SMTP id fz7mr942456pjb.17.1595882079803;
        Mon, 27 Jul 2020 13:34:39 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b21sm16520817pfb.45.2020.07.27.13.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:34:39 -0700 (PDT)
Date:   Mon, 27 Jul 2020 14:34:36 -0600
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
Subject: Re: [PATCH v2 2/2] perf tools: ARM SPE code cleanup
Message-ID: <20200727203436.GC2381376@xps15>
References: <20200724071111.35593-1-liwei391@huawei.com>
 <20200724071111.35593-3-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724071111.35593-3-liwei391@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 03:11:11PM +0800, Wei Li wrote:
> - Firstly, the function auxtrace_record__init() will be invoked only
>   once, the variable "arm_spe_pmus" will not be used afterwards, thus
>   we don't need to check "arm_spe_pmus" is NULL or not;
> - Another reason is, even though SPE is micro-architecture dependent,
>   but so far it only supports "statistical-profiling-extension-v1" and
>   we have no chance to use multiple SPE's PMU events in Perf command.

I find the above changelog somewhat out of touch with the patch itself.  The
only thing that is happening here is the removal of a useless check and a fix
for a memory leak.

Once again whether Arnaldo wants to make the changes by hand or not you may have
to resubmit.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> So remove the useless check code to make it clear.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/arch/arm/util/auxtrace.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 28a5d0c18b1d..b187bddbd01a 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -57,17 +57,15 @@ struct auxtrace_record
>  	struct evsel *evsel;
>  	bool found_etm = false;
>  	struct perf_pmu *found_spe = NULL;
> -	static struct perf_pmu **arm_spe_pmus = NULL;
> -	static int nr_spes = 0;
> +	struct perf_pmu **arm_spe_pmus = NULL;
> +	int nr_spes = 0;
>  	int i = 0;
>  
>  	if (!evlist)
>  		return NULL;
>  
>  	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
> -
> -	if (!arm_spe_pmus)
> -		arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> +	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (cs_etm_pmu &&
> @@ -84,6 +82,7 @@ struct auxtrace_record
>  			}
>  		}
>  	}
> +	free(arm_spe_pmus);
>  
>  	if (found_etm && found_spe) {
>  		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
> -- 
> 2.17.1
> 
