Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A9CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BAB22B42
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzel8Nfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgG3Enu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 00:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgG3Enu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 00:43:50 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE05C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:43:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l12so4762133pgt.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wF05xhf0pmO+SSDfaVtMOIn5xpcwCosKEIhsXa5iKW0=;
        b=fzel8NfefEAXLrAbNWtDcfYD0YL3yGUJOZ3zytgP3tVwdyw20MGYQzzKYicNU9dZru
         ZYDVRNCXeeALbgfgg7WKV8Gz5ueVQ9X12Ypfah1VBwaQbAAzjmkkUNRaGmSJLcaY7eFH
         30rB53RFoOHvXqK0yuFOFX6oekKlie4+nLSSMBDlQNV4BoBrKJiAbDsVaPwQH5N71GFo
         8y3/iSrAWU26TB6qnbDiKcQVDw9vTTyYl6QEjfRpPhbfWP9grtYdwN0ejgxda8HI/1n2
         qfkQYKGpZ5yLugfXZtPpyxJUqEKAKTD4DmzOx+pd9moHzFYO5o0Ro3KUKwkExoEkl5CN
         ODTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wF05xhf0pmO+SSDfaVtMOIn5xpcwCosKEIhsXa5iKW0=;
        b=nPXam3GUDFcfKWJ3ipFYqXM644aTOHS5kOkALNS10vkqy1pGNBiqMoxCm2zrkA6o63
         TlFgklchSO9npglQF5HnfG9QZeUhTy6deZJrKI2v5eUpn+EolmC+RRQef/1ukYSwB/pQ
         YFBmPBlnCZAT/Nz9oVn8m0gyyugnwjOea8xszFdDWEbZdhbdROyPDT89R+sETL7hpFPB
         HYH5yPI5mUNIew6Aq+buNjZ8gPHBKS+q/m9PfX75r/LnAYy97iq9ysDLWLa8XypEg5V3
         B41rXSklfvXY2+Yi09onriQ+86ClWC7QVdLnWeZn08bc+gTnaJUp+jvsfUeQllAmQSVq
         a3NA==
X-Gm-Message-State: AOAM531ku3/NaVJoU+Bc0iyH5NuM1JCQzLHWyvGaWc34fU46/yjwzgB+
        Wn23P+88Tb6Asw6qBN6Durqd9A==
X-Google-Smtp-Source: ABdhPJxoozYbKSzWF/vpDj6rzKXc6Czkqc1yWHX7rgEwF6c/alcWJ6gw85vqUjBwUGpFgmce229YqQ==
X-Received: by 2002:a63:f316:: with SMTP id l22mr31659281pgh.291.1596084229406;
        Wed, 29 Jul 2020 21:43:49 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id t184sm4334122pfd.49.2020.07.29.21.43.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 21:43:48 -0700 (PDT)
Date:   Thu, 30 Jul 2020 10:13:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200730044346.rgtaikotkgwdpc3m@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-5-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722093732.14297-5-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-20, 10:37, Ionela Voinescu wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 3497c1cd6818..1d0b046fe8e9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -61,6 +61,9 @@ static struct cpufreq_driver *cpufreq_driver;
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>  static DEFINE_RWLOCK(cpufreq_driver_lock);
>  
> +/* Mark support for the scheduler's frequency invariance engine */
> +static DEFINE_STATIC_KEY_FALSE(cpufreq_set_freq_scale);
> +
>  /* Flag to suspend/resume CPUFreq governors */
>  static bool cpufreq_suspended;
>  
> @@ -69,6 +72,25 @@ static inline bool has_target(void)
>  	return cpufreq_driver->target_index || cpufreq_driver->target;
>  }
>  
> +static inline
> +void enable_cpufreq_freq_invariance(struct cpufreq_driver *driver)
> +{
> +	if ((driver->target || driver->target_index || driver->fast_switch) &&
> +	    !driver->setpolicy) {

Just checking for !driver->setpolicy should be enough here.

> +		static_branch_enable_cpuslocked(&cpufreq_set_freq_scale);
> +		pr_debug("%s: Driver %s can provide frequency invariance.",
> +			 __func__, driver->name);

I think a simpler print will work well too.

                pr_debug("Freq invariance enabled");

__func__ isn't really required as this is the only print with that
kind of info in cpufreq.c.

> +	} else
> +		pr_err("%s: Driver %s cannot provide frequency invariance.",
> +		__func__, driver->name);

Why not supporting freq-invariance an error ? I will just drop this
message completely.

-- 
viresh
