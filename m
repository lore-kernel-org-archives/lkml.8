Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79F6C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8363020578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+aIP1PS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBUQae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:30:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35851 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgBUQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:30:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so2560890wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/hpmr3iDEF7VesVIhUJxr+wlTQe7A6k8UmT2pP9gqsk=;
        b=E+aIP1PS+y/CidHXVepd4cUIkrlKoYLDO6dl2UeIw3Ml0MfaCUl3hY2pkYthaAFgOg
         Ad1ennzZ4H+O6PaStCgipayhBrpYB4QlnwhYqzNdPEYkB4eMQAuDvatGMEvJALwGJIYz
         MWefy7+GCKzuaKE9IaBzU4+w0zyRXz3FJK30mBYeTp8JKgXTqPchwA18uLVM+HBf/5zZ
         DziJGa6kM4BkWrjhQSd/nn5wL4YowBsz9HY83ZuQvRuHVxXLw9DctNYqNCuGYeljvZ8L
         S7vK18NlhoEklerzBB+rFu4qUxmNtH2ij7pAT8sXufJ27O1igPKaQaRVxz+sTvyrlAk4
         9rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/hpmr3iDEF7VesVIhUJxr+wlTQe7A6k8UmT2pP9gqsk=;
        b=OwyvqVJ5F5Yhe2nsN5R8NpOaAeg3ORBWLhuTtRi7s7sFRulU1BY1G+9WUyfVx4zakf
         M4sWbVadR4RSMKeI7Lqutvv0k/DU42IkPQRTnpqZUsBHtfCwpcugiVDc5hT/qBODkyRP
         e/KQwJpooxl3+Tg+ctWTQKCPSakdWdNPpRms14wmf16l/vBiWvANovlXbEJlAJBlIyeH
         ajxiFQFxrqFDTiVcNLZcMvEstQaKqtINhbRJKDf0k6k8xubtEoraF/9Pa5JavFVosI76
         LPucfr+RrOFxnFvGnrC5acP9zrFitYiegrBHzLN4/1u7sOe4BnfipK7wVLd/IqLz1rFN
         c3tQ==
X-Gm-Message-State: APjAAAVdG9EHz0CuheZNXPAAfx1a9YFv/oM+Pj80kT3ms39Zd17QNnqa
        b/CXYZRMEq44cs1yE6JqQ8p8GQ==
X-Google-Smtp-Source: APXvYqy84yAGhqFaCP2VYwJRbeW1uviJEpEW2HrCyNvsXZW5mAZhvBYKDFwAqaEBRKtnFNxyZIzMpg==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr4784182wmj.33.1582302631058;
        Fri, 21 Feb 2020 08:30:31 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id u62sm4588304wmu.17.2020.02.21.08.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 08:30:30 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:30:28 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 16/17] ARM: multi_v7_defconfig: Enable Tegra cpuidle
 driver
Message-ID: <20200221163028.GR10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-17-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212235134.12638-17-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:33AM +0300, Dmitry Osipenko wrote:
> The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
> it is now a proper platform driver.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 017d65f86eba..7c8a1c310bbb 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -113,6 +113,7 @@ CONFIG_CPU_IDLE=y
>  CONFIG_ARM_CPUIDLE=y
>  CONFIG_ARM_ZYNQ_CPUIDLE=y
>  CONFIG_ARM_EXYNOS_CPUIDLE=y
> +CONFIG_ARM_TEGRA_CPUIDLE=y
>  CONFIG_KERNEL_MODE_NEON=y
>  CONFIG_RASPBERRYPI_FIRMWARE=y
>  CONFIG_TRUSTED_FOUNDATIONS=y
> -- 
> 2.24.0
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
