Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A11CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D15524697
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7/Qsko0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCBETi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:19:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39694 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgCBETh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:19:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id l7so4906318pff.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 20:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yHBK3/rKn+LVN6MYF4Du3i4K2LjtQ7eKL0BsrScrxdY=;
        b=d7/Qsko0GvwfGJb8ZsXpoGwF4rLMogSWMCfssVO7mz/dNvAwHn/isV+n87qCFFmbOv
         5zjVJd8s8wTvzQuK/rSEXqdU7n80xgKmPi+YT/pi6b1nRslw9JCLYyEeex4hei2hqpZo
         n8IhdQ4UE13WUvK0oiJaVpkoTqF0ZeOpeFgwoUoJ0rdFRBI2ROI1V/riSgt+SoknniUG
         oU74Yzahxa4Zjlorq1Kj4Atgho4PDTJSYAoV83Dc7sxa8T3EPZoEX2sRIf/JlrFhm6Wo
         XbASG8ErPAaNqYZbbvREyHbQyxN/d5ir00tcBlEylWqYtxDW2w1GK+ZAT+ppZyfIcTfd
         d46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yHBK3/rKn+LVN6MYF4Du3i4K2LjtQ7eKL0BsrScrxdY=;
        b=O4Rf4fsBEovpbSgM5hrTb41NQjw03gWGVfTOAAoWUGAVR/Ex1lVAAm+N83CKB2/D8y
         DYwqINQoe9oplAjDEafDZNTnE+KaNzzDGimYKAseQxYYJ0rao5RjWjf7JMvXpRcfGoF1
         eTdUYCWNxJxMiTrHwf0N29X4em6WVL7pHysMenMWgmhfj6ex8LqZmjv6RuC+uWzIB3Vk
         Y/mlM5z7RwqOPzXK8tllkW0h3J2Hz/Th4XfKcyb1W84JyQ972LLhd/58hqHA3ZawO+J7
         zWtLyQxmnmMTBsDLeYTHU3vAYrxfK+rZoO0bpQeVzE0cVvhpRGa0Et2cK0fZN+gor0/Z
         Igvg==
X-Gm-Message-State: APjAAAWE/V6fxXUBSzf9vXGVlaHlVCyCFxPmBUw16ZWZ9JFORgAKqN6o
        nBfw/msBAx/lahqGcPjepS6uYg==
X-Google-Smtp-Source: APXvYqymLyln6a38K5aMXFA9lXxZgKiZg4FWlryrDmM9cXV42wpxdOAYp3guF6wE7YivyJTj7tRdBw==
X-Received: by 2002:a63:c546:: with SMTP id g6mr16910592pgd.243.1583122776505;
        Sun, 01 Mar 2020 20:19:36 -0800 (PST)
Received: from localhost ([122.167.24.230])
        by smtp.gmail.com with ESMTPSA id z13sm18823624pge.29.2020.03.01.20.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2020 20:19:35 -0800 (PST)
Date:   Mon, 2 Mar 2020 09:49:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Add support for OPP_PLUS
Message-ID: <20200302041933.uuoa5kbvgtde37oq@vireshk-i7>
References: <20200228144529.14548-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228144529.14548-1-t-kristo@ti.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-02-20, 16:45, Tero Kristo wrote:
> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> DRA762 SoC introduces OPP_PLUS which runs at 1.8GHz. Add
> support for this OPP in ti-cpufreq driver.
> 
> Acked-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 557cb513bf7f..d62b6b21325a 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -25,11 +25,14 @@
>  
>  #define DRA7_EFUSE_HAS_OD_MPU_OPP		11
>  #define DRA7_EFUSE_HAS_HIGH_MPU_OPP		15
> +#define DRA76_EFUSE_HAS_PLUS_MPU_OPP		18
>  #define DRA7_EFUSE_HAS_ALL_MPU_OPP		23
> +#define DRA76_EFUSE_HAS_ALL_MPU_OPP		24
>  
>  #define DRA7_EFUSE_NOM_MPU_OPP			BIT(0)
>  #define DRA7_EFUSE_OD_MPU_OPP			BIT(1)
>  #define DRA7_EFUSE_HIGH_MPU_OPP			BIT(2)
> +#define DRA76_EFUSE_PLUS_MPU_OPP		BIT(3)
>  
>  #define OMAP3_CONTROL_DEVICE_STATUS		0x4800244C
>  #define OMAP3_CONTROL_IDCODE			0x4830A204
> @@ -80,6 +83,9 @@ static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
>  	 */
>  
>  	switch (efuse) {
> +	case DRA76_EFUSE_HAS_PLUS_MPU_OPP:
> +	case DRA76_EFUSE_HAS_ALL_MPU_OPP:
> +		calculated_efuse |= DRA76_EFUSE_PLUS_MPU_OPP;
>  	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
>  	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
>  		calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;

This is already merged, why sending it again ?

-- 
viresh
