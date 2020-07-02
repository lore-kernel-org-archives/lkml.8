Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F90C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 22:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C62D2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 22:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flMT1sP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGBWjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 18:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgGBWjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 18:39:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782F6C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 15:39:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z3so3853117pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 15:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hpu8XAwtmw+kOkLZIDuQrqRUjCpHBHdYp8QrdsSt1UY=;
        b=flMT1sP+tqTMlnOZZkcn0W4Ha4XYoXoL/dPj0adpgOuDpi+GIqKpb2CAl7SwumpXo3
         1sfAWsDzrxpzuwDGfxIa3l3TiwUb+YhcaR4+rtCC7VooizGww9W9jA3yuHQ1jtSsyuBY
         /EY29vYYv0bpCjtizpWHWOyMApzwLqY0Wn8Gcpdg8OcXcrUjWNxxhL6vkRiUh2ddJ424
         4N+NuueT+jkgZQg1Z98KrIf+HlKPjBOdnNHeG2BsmwN3jhyBVuVwjsqwITg+qiSKrNrF
         teGCQGmIYsWo0C2UH0s85xK8J9RLGqsztEPxSMvNsk5WHebrOscwPNdHphEb0D8vHWlY
         zKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpu8XAwtmw+kOkLZIDuQrqRUjCpHBHdYp8QrdsSt1UY=;
        b=c0gqGCINXSJKIfY/pWcNkTWWjH6B/pN29tLk7A7BzFoBEcWtgLq5ZUfArOOdZlQ35i
         62yIGEJgo+Md2tOLvOKLDysz7/knRaSFAwfv2+37Fdv92Jc8GKUXq4x1y//D9yKfuI1o
         S13wTBDJmI9B213ApwxY0gS1CAaefYZr3hziasoWm/TDcYzjpCs07pKrwmDv82DOPlOy
         YXq7byYLdknJ12xZgEOVJhfS+5m9cHT6Dr+xf+1sRWYaJOm+DAtiXpT+wVmiVV0R3UJB
         fgit5SWDPNy8aoRcZt8HAkCXZbsg0aGbm8tgvaThHOL0LO4AdC/EFVPUOb0vrehLA8vu
         /zng==
X-Gm-Message-State: AOAM532MmG4O3WzeBVn0/RlfeqPNv5WGeqWwx2fVIW0x63tGcWvdtgip
        vDYP+/IDbtMK3Li8L0TqR7HBXg==
X-Google-Smtp-Source: ABdhPJw9sBmZpW6b/xmF9uf5wIzxYbJiz9XfJS95WdRI7TvRVNnoc0HEZU0ltp/2qita2GXq82Z4MA==
X-Received: by 2002:a62:7bc9:: with SMTP id w192mr28293570pfc.255.1593729592836;
        Thu, 02 Jul 2020 15:39:52 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m68sm169126pje.24.2020.07.02.15.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 15:39:52 -0700 (PDT)
Date:   Thu, 2 Jul 2020 16:39:50 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/2] perf tools: ARM SPE code cleanup
Message-ID: <20200702223950.GA471976@xps15>
References: <20200623123141.27747-1-liwei391@huawei.com>
 <20200623123141.27747-2-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623123141.27747-2-liwei391@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:31:40PM +0800, Wei Li wrote:
> Remove the useless check code to make it clear.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/arch/arm/util/auxtrace.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 0a6e75b8777a..62b7b03d691a 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -57,7 +57,7 @@ struct auxtrace_record
>  	struct evsel *evsel;
>  	bool found_etm = false;
>  	bool found_spe = false;
> -	static struct perf_pmu **arm_spe_pmus = NULL;
> +	static struct perf_pmu **arm_spe_pmus;
>  	static int nr_spes = 0;
>  	int i = 0;
>  
> @@ -65,9 +65,7 @@ struct auxtrace_record
>  		return NULL;
>  
>  	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
> -
> -	if (!arm_spe_pmus)
> -		arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> +	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (cs_etm_pmu &&
> -- 
> 2.17.1
> 
