Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647BAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1BC206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUIf+u3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGIKkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgGIKkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:40:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6772CC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:40:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so924265pjq.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PWDALEc4aQBpiiDKJrZSu3AoHjPZ9+ketgO5D69yJ4o=;
        b=qUIf+u3SRF46tLGrPgQitW39s6nP+cSuEl8+w9cbKJlOP4lZjfL51qDpLPxu9+m0YQ
         qpB2BpjxNi2ZOve7gBwnul1AB9PZ742MHbmny/HTo3GyPI5x7sIY1SxSnka8mkQsKFXy
         Xhala6QVDw5SGFta7ZJR4f1acI3y8bIKCrl6wBc3HHbTKR5RsXXNzjdnQu9sfbTo13/4
         epP3emPrL1Ft9m2e+WCMdtlfD5HVKK+eEv48FIs5f44ItRVEz40VEF9t4uh/9wrrql7M
         Z1wJI02wiR2fhi6oNqJu3v4NOxtUBLKFaGaf9TgVr9xgMP9rZzJNTxGAd5rcrAJ70VP/
         sbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PWDALEc4aQBpiiDKJrZSu3AoHjPZ9+ketgO5D69yJ4o=;
        b=DCBlylA1U+lYKJZBPAhPEc1CXOD3gfcaI3CGgBTt8pK4wvz7VQ8KjRqyIJa1xmDJHo
         yzh9sRfuVK7xx05VxcwXElC9SEM8l/x28fp9jRPKK1SgP97bASp/nCiKEFWpNq3r1BaR
         k72I2LDsFUoA//E1b9pKPh46ZQ/YJ6C+23db68NTrru1MGk7RMG/JsJmglBlkyFFv00O
         5ZThyEih6GzuLbbKcRmfliFH/Ehy42QoMxMBgzYIdAtuAYHfg9EtPNaConJbZJx3zfB1
         uz8RhpgCfzMUpTnMBnO3R7sD8o2GwZ87dsvNhHrlua9EJ5ZK4YffWdRbyIKGNne1x7lA
         NiPA==
X-Gm-Message-State: AOAM5313HtxGqn95DcVYicYwBGczo2lrV/Kq5/0hY2qQG+pewF1NCrKi
        PsJU+ZQXgnl+ujuO15jF3Tw5wA==
X-Google-Smtp-Source: ABdhPJwCac281N4fXD18A96QQ4/Sj302QYu9LR9of9M4u+V8oOtEVbHUwoh2ALSx2vnR4eSJcx3REA==
X-Received: by 2002:a17:90a:17e4:: with SMTP id q91mr13955267pja.61.1594291250844;
        Thu, 09 Jul 2020 03:40:50 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id ci23sm2197063pjb.29.2020.07.09.03.40.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:40:50 -0700 (PDT)
Date:   Thu, 9 Jul 2020 16:10:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Don't support AMU without cpufreq
Message-ID: <20200709104048.emwuquj2qkyascb3@vireshk-i7>
References: <a710fc4e4e0f1d2e561320130b99bcb5167d73b4.1594277563.git.viresh.kumar@linaro.org>
 <20200709101734.GB5623@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709101734.GB5623@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-20, 11:17, Ionela Voinescu wrote:
> On Thursday 09 Jul 2020 at 12:22:45 (+0530), Viresh Kumar wrote:
> >  		cpumask_set_cpu(cpu, valid_cpus);
> > -		have_policy |= enable_policy_freq_counters(cpu, valid_cpus);
> > +		update_amu_fie_cpus(cpu, valid_cpus);
> 
> I see this as two different pieces of functionality:
>  - (1) validate_cpu_freq_invariance_counters(cpu) has the job of validating
>    the CPU support, including max_freq_hz.
>  - (2) enable_policy_freq_counters() has the job to restrict AMU enablement
>    for the CPUs in a policy if all CPUs in the policy support AMUs.
> 
> So both of them, separately, support the case of !CONFIG_CPU_FREQ.
> 
> >  	}
> >  
> > -	/*
> > -	 * If we are not restricted by cpufreq policies, we only enable
> > -	 * the use of the AMU feature for FIE if all CPUs support AMU.
> > -	 * Otherwise, enable_policy_freq_counters has already enabled
> > -	 * policy cpus.
> > -	 */
> > -	if (!have_policy && cpumask_equal(valid_cpus, cpu_present_mask))
> 
> This is meant to have the following logic: if for some reason we're not
> restricted by policies (according to 2), but all AMU validation was
> successful (according to 1), there is no reason not to enable fully AMU
> enabled frequency invariance.
> 
> I agree that this happening is a cornercase and a reason for which
> cpufreq_get_hw_max_freq() was made weak. If some platform has entirely
> firmware driven frequency control, but it enables CONFIG_CPU_FREQ
> (as is the default) and it defines its own cpufreq_get_hw_max_freq(),
> it could benefit from AMU use.
> 
> So I did believe it was best for these checks to be decoupled, for this
> reason, and potential other reasons in the future, involving more
> decoupling from cpufreq.
> 
> I do have code in progress to clean the overall interaction between
> cpufreq and AMUs, started at [1]. Bear with me on this, it is all
> connected :).

Of course I missed few things here.

- I didn't realize that cpufreq_get_hw_max_freq() is defined weak :(

  I understand that we want to support everything that is possible,
  but there is no need to support cases which we may never have
  actually. We have seen code going in the kernel, which no one ever
  ends up using.

  Do we see a case in near future where someone is going to override
  this weak implementation ? If we don't have an actual target for it
  at the moment, then we should probably remove the weak attribute and
  simplify the code.

- I understood earlier that, we don't pick up AMU support unless all
  CPUs of a policy are supported by AMUs, but forgot that later while
  writing the patch. What is the thing with AMUs? Why would some
  platform add it only for some CPUs out of a policy ? Do we have such
  platforms already or in queue ?

Lets discuss more after we have settled on the first point here.

Thanks for review Ionela.

-- 
viresh
