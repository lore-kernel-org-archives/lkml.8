Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D14CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB2120838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COvLTGpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgG3EyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 00:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgG3EyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 00:54:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56785C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:54:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so6076733pfx.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oMCESHbnt4MLyPfYQLhtUafiIq6nsztTz/9C1axLQ3A=;
        b=COvLTGpVAwWtURU9EO/rq2zo05ChUueBFPIUsl0iR+uRXWV5ev3HEgbn3kZinSYUN4
         LJCMo1eX5rLFeww5IZ+K6/JQcbTjrkm7R1MbJCVOFpN0WGBx1sMvvaM2eMvdRj+kh2ZV
         WYLK9+6h2sJa2zsTiQ2Fp5bUOrh/BLXycgXxH822CI+N4GsbpPnXKWlVajcG5RaIXjKB
         35IUSn5MqNEFUqcuwc/aJgkAs3xR22Ndcn5fB6l3SfACBsveGzKe3R4OM91RKU4vCW9p
         8Jh/+OlM/amqok9wEPEf3sK5EcyeTApbOAIhPS2FKf0OTGLyJSTv7SjSt0XnsIek3pxD
         AHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oMCESHbnt4MLyPfYQLhtUafiIq6nsztTz/9C1axLQ3A=;
        b=ckK9wOsAOJnRXT54wZO0QxNSOjgcNHhScKj9Yr2dPFB/korB3C2bhWsfO5PRZU5pbv
         j2g+Wufh0vfHPJvfSPWh2NOUneWFCiTK/vCMskMNv7XKGG174LfXX/+M5n2CBizuZIrf
         doiPklgzzQThYIKrQEThJw/iJOg5gnWO8C6A0jLYYrZgktRBXRNGINtkUtDFw6GySols
         wzYIwS7T1o1o7LbeOGAQcNZ37ybjOFwmYvrZACtmOx29r5ueSepw8jYyMezXrxRCbJgA
         iU4dQ42db6ZRAHVQckvJIEXfShUpEXRAz+Kk4yaX0/QNUhvoT1SF18YIx96eVta+sntN
         LTww==
X-Gm-Message-State: AOAM530xPnpeigeBJdPie325bXWdoxVPhmQZcW5kozTs7ttZoRMnGaaE
        DOjAtak5vuPRT8RS0sgu2RDngA==
X-Google-Smtp-Source: ABdhPJydNXI19zoP3MeYmLU03OvHMA1fuHmS1I1xc4IPsSB8Y11b1iDVNotIUa6+bCHwUVO1YD4dmQ==
X-Received: by 2002:a63:ea02:: with SMTP id c2mr32369967pgi.66.1596084851751;
        Wed, 29 Jul 2020 21:54:11 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id q6sm4222105pfg.76.2020.07.29.21.54.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 21:54:10 -0700 (PDT)
Date:   Thu, 30 Jul 2020 10:24:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v2 7/7] cpufreq: make schedutil the default for arm and
 arm64
Message-ID: <20200730045408.cpsoymak33jl3bsm@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-8-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722093732.14297-8-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-20, 10:37, Ionela Voinescu wrote:
> From: Valentin Schneider <valentin.schneider@arm.com>
> 
> schedutil is already a hard-requirement for EAS, which has lead to making
> it default on arm (when CONFIG_BIG_LITTLE), see:
> 
>   commit 8fdcca8e254a ("cpufreq: Select schedutil when using big.LITTLE")
> 
> One thing worth pointing out is that schedutil isn't only relevant for
> asymmetric CPU capacity systems; for instance, schedutil is the only
> governor that honours util-clamp performance requests. Another good example
> of this is x86 switching to using it by default in:
> 
>   commit a00ec3874e7d ("cpufreq: intel_pstate: Select schedutil as the default governor")
> 
> Arguably it should be made the default for all architectures, but it seems
> better to wait for them to also gain frequency invariance powers. Make it
> the default for arm && arm64 for now.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index e91750132552..2c7171e0b001 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -37,7 +37,7 @@ config CPU_FREQ_STAT
>  choice
>  	prompt "Default CPUFreq governor"
>  	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
> -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if BIG_LITTLE
> +	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
>  	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
>  	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
>  	help

Applied. Thanks.

-- 
viresh
