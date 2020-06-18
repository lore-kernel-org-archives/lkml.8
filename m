Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F94C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B7021548
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwZyvRFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgFRJyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgFRJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:54:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CABCC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 02:54:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u8so2308504pje.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jxYaQFOuethLH+6qCp7SYy5ev2dqdee2Bmv5jtz/8kU=;
        b=SwZyvRFdIOLAmwWOUo+F40IAyx5vcY7t7VtCMKmlXE5959lxtrfuSOav6SXn4HEn9b
         qfL+cZUXFpZGvbPTC0VlkifpM0hcelUY7m2dbEIVCQDc0i5gwQLG8jRublPoOSB8U/A1
         CKLeuwPhIXsjBVZHBPSvT9aVkkzWnvLpesnQzIHA/l82U+rOC2gO5V0int8I8RCnhuNo
         eFYWYbjZF600Vd0sOYvGaO0vsM6+v/nsa46OEeu+OWY/jwRx2Rrz2AOy43tjQbMeADoK
         vP+wEJo0eNBi9Zt0Hpo4x1Wd/Dg1bEnKYbB1LhKC/pAUd14DWmTBmrs7gvgmBx27wOQq
         Nzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jxYaQFOuethLH+6qCp7SYy5ev2dqdee2Bmv5jtz/8kU=;
        b=CTi81CDsRBuVK2R3ciLyaSmBFE/jfCMsFe5ViipTR43zPcs4Gxt/tMOnebnOncCqqT
         p/TtJnI315x8U+r34xyddp2952MT0oyI2+b3vQqFJZ3TsqDDtZrU5+2ZX6AB9xTBVEuX
         4h6mT6rofZzdszHGeFimTj7iIH6/FyqYkOqnkgWMsXbpuRdNOWPI3oq4sknwqnXG9/mH
         0DwJjzlAWo9DeL0Jrd3LoHR3dGk04vYpEHiOBTTYKrEn2FscWOa1uK/vu+O3xYLMA01E
         kVMqB8hayZzDXVgjuhkiOhtH8WJ6Y8g7E7GKYcU8GrQf+myME3Ze28XSyCWnz+uByQMn
         tUHg==
X-Gm-Message-State: AOAM530ObA4Xjp77yOjn6w3sTuxaHpEO9lwvIwAO0tr+79QBu4XoWZ7X
        mhfGEHFFLoVVforg0Nit1kgQpw==
X-Google-Smtp-Source: ABdhPJwri2PoCABkalcKuQR/pD7ASrRIrdyeZ9bnWjTeKTykWL3STjOgPPvyP9Bl4x+fqvXirq3UgQ==
X-Received: by 2002:a17:902:ee12:: with SMTP id z18mr2983112plb.308.1592474072433;
        Thu, 18 Jun 2020 02:54:32 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id z144sm2567092pfc.195.2020.06.18.02.54.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 02:54:31 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:24:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
Subject: Re: [PATCH 2/2] cpufreq: arm_scmi: Set fast_switch_possible
 conditionally
Message-ID: <20200618095429.tj3ddquy5m2q367e@vireshk-i7>
References: <20200617094332.8391-1-nicola.mazzucato@arm.com>
 <20200617094332.8391-2-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617094332.8391-2-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-06-20, 10:43, Nicola Mazzucato wrote:
> Currently the fast_switch_possible flag is set unconditionally
> to true. Based on this, schedutil does not create a
> thread for frequency switching and would always use the
> fast switch path.
> However, if the platform does not support frequency
> fast switch, this may cause the governor to attempt an
> operation that is not supported by the platform.
> 
> Fix this by correctly retrieve the fast_switch capability
> from the driver which knows if the platform can support
> this feature.
> 
> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 61623e2ff149..1cf688fcb56b 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -198,7 +198,8 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	policy->cpuinfo.transition_latency = latency;
>  
> -	policy->fast_switch_possible = true;
> +	policy->fast_switch_possible =
> +		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
>  
>  	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
