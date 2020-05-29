Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C064C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D0C208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqxlDAev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgE2VC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgE2VCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:02:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526BCC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:02:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cx22so2028224pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qIcELL/cWodxAT+xrcJD6L0svSyXvOgsSBmnAU1Opv8=;
        b=XqxlDAevdvypUT9MRPBfOGKx8Zz8OjK8Z8UtA60K04UledJFknaky0CyWVGEqakY0Z
         +Ci6+ANCWWCV22dn5+60hex5/tAGiRKgSjAaBeKebTfHQ7HRYMbMofJvZ9SeE9Ot2Qsa
         TXHbsf+mwXz7b4QiYXXV5k6TePQ7R/Od75GLNG12Lw0wyu59jKcXSYv5Wr/LJ83qHcmL
         OzISjg91B0X3e50wmJ5znNv+RrpAQuVoafAwFaW4rAB7FCjT7+pIKb2eBBnesXQKA6eG
         P5j6BKbCUBL1Hg5zmMuOCXmaqfau/gLRYONFYnwC/PGEvhm6gOA9t0ZYzqE7svSyATCy
         yLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qIcELL/cWodxAT+xrcJD6L0svSyXvOgsSBmnAU1Opv8=;
        b=A0KRdiu5e9GbvGqRl45fBNNFQI215svjLM4RAszknIUIQt2Di0084jJt6xpi7xRtV+
         BbaGZEVMU4ABLXsIhnYLEgUXVf+X5dmof4FDm/+s9iDxSLDMQSDpmPYlLSOr13ALWX+D
         iiRVOpJr7F7F2KEqr47yyDVvpPAKKatdcXTAM4R/E2glaMZ+b6XBwrypmziH/iuu6Ra9
         YfB5X4szM01aZ/Z9Su5mQr2iqhBjiHGa4QP0wHEEp8WEq/3QZSabi/qzS86aed7ZhEvx
         rUvo8IOQFBFiCk3/LviPGRSEMBy1NtaENkvAYlxcBpUJjpSKRXCSE4atJu4gt7JuqQ0g
         xhYw==
X-Gm-Message-State: AOAM533DLGe9HQbXLX01WEDX3kcffe2GMEtFd++hTmVE0Ekxy67TovmU
        t4oN61NMoZQDXAHeLKKmfYzJaQ==
X-Google-Smtp-Source: ABdhPJxQgJK3CjFBg/U/IEPDJ5zZBjb1yrnDxxPZhXa47bGPD3W0Z7Npx0t1d2Vvl/F4Rr6jQCQn3g==
X-Received: by 2002:a17:90a:a613:: with SMTP id c19mr11145385pjq.155.1590786143680;
        Fri, 29 May 2020 14:02:23 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h3sm310054pjk.10.2020.05.29.14.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:02:23 -0700 (PDT)
Date:   Fri, 29 May 2020 14:02:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle/firmware: qcom: fix smcc dependencies
Message-ID: <20200529210220.GO11847@yoga>
References: <20200529200531.31738-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529200531.31738-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29 May 13:04 PDT 2020, Arnd Bergmann wrote:

> Selecting QCOM_SCM for compile-tests is broken when the smcc firmware
> is not provided:
> 
> drivers/firmware/qcom_scm-smc.o: in function `scm_smc_call':
> qcom_scm-smc.c:(.text+0x110): undefined reference to `__arm_smccc_smc'
> drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
> qcom_scm-smc.c:(.text+0x1bc): undefined reference to `__arm_smccc_smc'
> 
> Add a Kconfig dependency for the QCOM_SCM to make it easier to catch
> this, and fix the dependency for the newly added ARM_QCOM_SPM_CPUIDLE
> symbol that triggered it this time.
> 
> Fixes: a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> As the bug is currently only present in the cpuidle tree, can we
> merge it through that?

Sounds good to me.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/cpuidle/Kconfig.arm | 3 ++-
>  drivers/firmware/Kconfig    | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 51a7e89085c0..6cdcf5698c4c 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -97,7 +97,8 @@ config ARM_TEGRA_CPUIDLE
>  
>  config ARM_QCOM_SPM_CPUIDLE
>  	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
> -	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64
> +	depends on ARCH_QCOM || (COMPILE_TEST && HAVE_ARM_SMCCC)
> +	depends on ARM
>  	select ARM_CPU_SUSPEND
>  	select CPU_IDLE_MULTIPLE_DRIVERS
>  	select DT_IDLE_STATES
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index fbd785dd0513..297bed30a632 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -238,6 +238,7 @@ config INTEL_STRATIX10_RSU
>  config QCOM_SCM
>  	bool
>  	depends on ARM || ARM64
> +	depends on HAVE_ARM_SMCCC

While this is correct I wonder if we're not opening up for drivers (such
as QCOM_RMTFS_MEM) to be selected without HAVE_ARM_SMCCC and cause an
unmet dependency issue.

Regards,
Bjorn

>  	select RESET_CONTROLLER
>  
>  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> -- 
> 2.26.2
> 
