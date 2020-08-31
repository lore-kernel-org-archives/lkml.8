Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5054CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F81A208A9
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iD3qjy7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgHaUih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHaUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:38:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1479DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:38:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u128so1312567pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 13:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K/7PK6S5Q6HPaHq1eTEnKf0uxbke5x5RCxK0h2wg5MI=;
        b=iD3qjy7K7rLQsbdLS08nvec3+rM9z7c+f4CUp0k4t39HnIujZ8vk0S8wvig/Z+Afhd
         sjXJYjB/unW5U/y62CSJod/KXZxJRFkEnUC1VWxC+KIPPzPmNBKoP93r0k/7HLVSzk4g
         QKUrimlJnMdc4cyZHkskrXezSxkUzb80x5/b5FzkLGNpGunkUWqOnV5/JZ6zTQl42Bjd
         cHSUscDipKnvrcPDtsBKFWkOVYxr9tQgD0aJrCKfUXFQT85BZvQe2rB9b1jLLcykGKl7
         GGbhN8LiBhSjcNbNmg5ZqLkaTJG3/W0PjQo6SJoBYmx44NG/8LgG6DOv+dtbAacwo4dj
         bUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K/7PK6S5Q6HPaHq1eTEnKf0uxbke5x5RCxK0h2wg5MI=;
        b=M89TXZBCLDJ34zc8brDK0RDBky1sm3ODLyQ9pUY6ouWKOLKlZTNJq7eEeemfqi/eBk
         PdfOs5hwXVQnaVTtOUdyB7t19tA6Xkdt9R+IqS8OgT6qpVAo+46Cm9zhD/v57aTOxFJx
         2ah0aeaxBE56MGi+mPMEE937ThajRVQvs4mqKHeqXIyBp5SoOLmezG+LxZbAY4ioZvsy
         mXDgmjciQOWIMUQUfM6FvxUR8lAYaVe+AbfLcLIomFSWoVezRkadTEB1Ga5aM7ch5eug
         /HSlppguT9bvtI9L8rjGDqPgUKaT9XJvXytkvu5oK8+YgY1QRRblXmnp9TwX+TS/XMV6
         2Vwg==
X-Gm-Message-State: AOAM531bbkNHKaLEbUV1sTnzuRIqU/hA41YHv1eC3enOXcj2xAx4EuXz
        hKAHdvvJ74zbyFvIthhLfL8Pqw==
X-Google-Smtp-Source: ABdhPJwprAyCBcJ1XpRTFAQaEvCQLHh7Ax18vWRPUmgyeqkVYZHQhwVmBvUkgTn9jN1woKzPD/at+g==
X-Received: by 2002:a65:4847:: with SMTP id i7mr2554665pgs.385.1598906315528;
        Mon, 31 Aug 2020 13:38:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l23sm8267869pgt.16.2020.08.31.13.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:38:34 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:38:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AAl Grant <al.grant@arm.com>
Subject: Re: [PATCH 2/2] perf intel-pt: Fix corrupt data after perf inject
 from
Message-ID: <20200831203832.GA120995@xps15>
References: <20200819084751.17686-1-leo.yan@linaro.org>
 <20200819084751.17686-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819084751.17686-2-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 04:47:51PM +0800, Leo Yan wrote:
> From: Al Grant <al.grant@arm.com>
> 
> Commit 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> changed the format of branch stacks in perf samples. When samples use
> this new format, a flag must be set in the corresponding event.
> Synthesized branch stacks generated from Intel PT were using the new
> format, but not setting the event attribute, leading to consumers
> seeing corrupt data. This patch fixes the issue by setting the event
> attribute to indicate use of the new format.
> 
> Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> Signed-off-by: Al Grant <al.grant@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Arnaldo, please consider.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  tools/perf/util/intel-pt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 2a8d245351e7..0af4e81c46e2 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3017,8 +3017,15 @@ static int intel_pt_synth_events(struct intel_pt *pt,
>  
>  	if (pt->synth_opts.callchain)
>  		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
> -	if (pt->synth_opts.last_branch)
> +	if (pt->synth_opts.last_branch) {
>  		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
> +		/*
> +		 * We don't use the hardware index, but the sample generation
> +		 * code uses the new format branch_stack with this field,
> +		 * so the event attributes must indicate that it's present.
> +		 */
> +		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
> +	}
>  
>  	if (pt->synth_opts.instructions) {
>  		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
> -- 
> 2.17.1
> 
