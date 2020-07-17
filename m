Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44512C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1864C20739
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMCoBnOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgGQD5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGQD5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:57:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17A4C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 20:57:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so12909285wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 20:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SzUcIHj1G4IHGMKYeYYU1OCDfXFqgR7DJ+soyCYtfRw=;
        b=FMCoBnOJGQ+2cQL0atQyDmvYnxGGdvM4+yz3oA2EvBlhDR6WLkz/h3J7R5rJucv/xk
         fQE0ZQt619rFxxCtoXrmyJ0nCLDlXhxgUpHJB9LJZZ4+Cr19sv1Pmc8yLs3EmAIS5pJw
         ItgIP7WEOZ0T24/ZQNQE4mPlzDL5AadiEf4Hpdi7PHBMROlMwR1a1i361Q+77j1zxziv
         I6kspplJ5NHDiB/tBuM5ka2NDwZn2T/+asEoPN3wbVuyO2Mg0KwVE1I/+kQ6exNNzuRq
         Na85+934GqbfgbNEd00aiA19KXeqjMIgabTkB9ZhHQoUC6GT3XRNAR13RCLGy/hisnjd
         DuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SzUcIHj1G4IHGMKYeYYU1OCDfXFqgR7DJ+soyCYtfRw=;
        b=C7ejxVcXtNotgUdQIEzdcmIPnrIz7HGcbddN4Iw/KZCDUzegJmdJvTozIFPYr+IzO+
         Qvistu21Nzvuv3ZuqJvA+nCQqMbsXozq2wwikMcY2fAbGzPL6Ez6I79VSrwr8OWUSNVl
         wSXBy4My00SBIRaUwSn0za1Y0pbIqEJ4aRzSIuhHwBRRPsmLQonobPY3ioPYYeU4j/ce
         1/tZ+G5bYd70y7OsS1FdOZDe2IJ8Bsl2VSl5lQisygiiGasHqKTGain4eKUlcg9F/2Js
         n6QamFahv1iJ68vFvn11fWZyHftGZ8ezP47S9JxeLszNE2zuN1NXJDn/Lr2C/aANwZOJ
         pw3A==
X-Gm-Message-State: AOAM5336o+ggm9wplSvE/O3oU/LcohLEBFahtNHL/ef8je5ZCx7cjfuy
        aQJzUR4RJUQa0Oex6FP759iypA==
X-Google-Smtp-Source: ABdhPJyO6/RufqFu/qPL4dbdQxByfllRoEvhTfskX9CXW37bEP4ncIJb8PBn7psAWigr/9KcDK+2wA==
X-Received: by 2002:a05:600c:4109:: with SMTP id j9mr6992647wmi.157.1594958252182;
        Thu, 16 Jul 2020 20:57:32 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id f14sm12543847wro.90.2020.07.16.20.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 20:57:31 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] arm64: imx: Select TPM driver by default
To:     Anson Huang <Anson.Huang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1594178168-13007-1-git-send-email-Anson.Huang@nxp.com>
 <1594178168-13007-2-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <84b4373a-3dea-5dd1-d661-1a66d1cf1da2@linaro.org>
Date:   Fri, 17 Jul 2020 05:57:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594178168-13007-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2020 05:16, Anson Huang wrote:
> Select CLKSRC_IMX_TPM for ARCH_MXC by default.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 8dd05b2..c52b7a0 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -169,6 +169,7 @@ config ARCH_MXC
>  	bool "ARMv8 based NXP i.MX SoC family"
>  	select ARM64_ERRATUM_843419
>  	select ARM64_ERRATUM_845719 if COMPAT
> +	select CLKSRC_IMX_TPM
>  	select IMX_GPCV2
>  	select IMX_GPCV2_PM_DOMAINS
>  	select PM

Shall I take this patch also or just 1/2 ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
