Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF36C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073F520737
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLS0EAFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgH0UyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0Ux6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 16:53:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFCAC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:53:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m8so4440630pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IcrAzu0/UMhNvU/QrMjkiMrk/PLtQgMkds9y37Yu4qg=;
        b=LLS0EAFFujy5fRuUgd1HMdou2VPRHvhJHVGPx88qbNkBmrp8bDnDuSu1oY20uM3NSJ
         bcWQ/aR7gtU9XCl4E3YUN9VnoGmQx4Nm6uZhRMJG+Q1QAglTe0Pq7+MyYf/Sc2Dou9+e
         KoTNfGLzgMtMu6Ccy560d9o+Duj8HUmhC+LgZd4h/HAREzMeHvjNEKVIkph0WVBmuQOj
         wHoIAsO97H22BlpOGpNNyHE+EGH6TqOV/CBByLEmJQBPj97d7IE2gxWV5cgn492608TW
         afz78x54mz01cNmCtK+8EzTn0zHijsHp9dMHFU2zIdGCoke3HU5fh4vkuXKXKNV5n/ab
         f+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IcrAzu0/UMhNvU/QrMjkiMrk/PLtQgMkds9y37Yu4qg=;
        b=Zk6/EFhAtvQNPjJayCy9guRCaEovrjYsXI1upTKQQFx7zvZisoku501/S0JA3AelHE
         FBF+4cue7XDel6v2ByhXCyXENa/YJ2NxipuBUST6F1SrqkuMKyTnUWDseEliIamFU2O3
         gvG7tQeP3XXV0J6LMicJUvg0kk+PoH7pKSXGaieK19fCqx3K0cQXVgDCATkXEG+KsX0W
         +pKsXv4sxo4HcA1V05Nb9Q6gz8mlq8844NCGryo4gYW7UOH17AF5Ewd+D/CPGo0/CLsp
         Kb5Vb7sc1S5tQ3ITV8cmqLDwspgX2A29mwUKpGcimEmd8kNpy82bPC7TbwYWMw/AxmaW
         5GVg==
X-Gm-Message-State: AOAM5339v1eDlC7GqqAxP2ma9x/vJ4m8jV0jX8f3S7wk3JvwsiWTAfSM
        EjdkH5XaQXJteDc741/qo+elHQ==
X-Google-Smtp-Source: ABdhPJxNw+/656VRD6PGnpA+zHOJCy9wwMygdqm6UmvDTT77dmMyvoR0p4c//KsTPQ2uf+XtChHC8A==
X-Received: by 2002:a17:902:b28a:: with SMTP id u10mr2912502plr.30.1598561637578;
        Thu, 27 Aug 2020 13:53:57 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q11sm3266818pgj.92.2020.08.27.13.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 13:53:57 -0700 (PDT)
Date:   Thu, 27 Aug 2020 14:53:54 -0600
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
        Al Grant <al.grant@arm.com>
Subject: Re: [PATCH 1/2] perf cs-etm: Fix corrupt data after perf inject from
Message-ID: <20200827205354.GE22307@xps15>
References: <20200819084751.17686-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819084751.17686-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo and Al,

On Wed, Aug 19, 2020 at 04:47:50PM +0800, Leo Yan wrote:
> From: Al Grant <al.grant@arm.com>
> 
> Commit 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> changed the format of branch stacks in perf samples. When samples use
> this new format, a flag must be set in the corresponding event.
> Synthesized branch stacks generated from CoreSight ETM trace were using
> the new format, but not setting the event attribute, leading to
> consumers seeing corrupt data. This patch fixes the issue by setting the
> event attribute to indicate use of the new format.
> 
> Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> Signed-off-by: Al Grant <al.grant@arm.com>
> Reviewed-by: Andrea Brunato <andrea.brunato@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index c283223fb31f..a2a369e2fbb6 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1344,8 +1344,15 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
>  		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
>  	}
>  
> -	if (etm->synth_opts.last_branch)
> +	if (etm->synth_opts.last_branch) {
>  		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
> +		/*
> +		 * We don't use the hardware index, but the sample generation
> +		 * code uses the new format branch_stack with this field,
> +		 * so the event attributes must indicate that it's present.
> +		 */
> +		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
> +	}

I've see this patch before...  I thought it had been merged - what happened?

Thanks,
Mathieu

>  
>  	if (etm->synth_opts.instructions) {
>  		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
> -- 
> 2.17.1
> 
