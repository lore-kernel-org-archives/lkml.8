Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C706BC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938EA20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OeN2lMXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGQQzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:55:45 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5234 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:55:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f11d79b0000>; Fri, 17 Jul 2020 09:53:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 17 Jul 2020 09:55:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 17 Jul 2020 09:55:43 -0700
Received: from [10.26.72.76] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Jul
 2020 16:55:40 +0000
Subject: Re: [PATCH v4] clk: tegra: pll: Improve PLLM enable-state detection
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200709172057.13951-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <997361b8-4466-cdf0-beeb-eedcbeb48597@nvidia.com>
Date:   Fri, 17 Jul 2020 17:55:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709172057.13951-1-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595004827; bh=xUiiKYbnv22YTABo9Sa2h4Gcr4zzqyR4GLBZuaxCju4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OeN2lMXI9jnym+iTparOQb2vLQRk6+ej+NO8/wKAiU9ul85w4WGIsxku1sk3DIPdS
         bwIu7ld4VMFj3M/jYpqhF+jbnYeo3IuG6JOT/jhfy/0xbRmkMYhAsFon8LB6a04pX7
         nuN6SDqLPw7HvS/xkSNLBVMCqQjSDPypoZ9xAIY0qWRiyg94wXIisFHN1aZRidWOOb
         olQpHhjnk7vkgdpHmxiBG+xbD19SKjvYA2V/H4apoHAUIjtjFYEA/Ite8mwbbpoIUb
         YklUt/SJLLBl9TC8K4RYdug1b2DuTWkPGhn2MjJu3/c8GpSdrjIGw2j4iiV1wBsGqo
         x8V1Y+67KpFbA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/07/2020 18:20, Dmitry Osipenko wrote:
> Power Management Controller (PMC) can override the PLLM clock settings,
> including the enable-state. Although PMC could only act as a second level
> gate, meaning that PLLM needs to be enabled by the Clock and Reset
> Controller (CaR) anyways if we want it to be enabled. Hence, when PLLM is
> overridden by PMC, it needs to be enabled by CaR and ungated by PMC in
> order to be functional. Please note that this patch doesn't fix any known
> problem, and thus, it's merely a minor improvement.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/20191210120909.GA2703785@ulmo/T/
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v4: - Renamed pllm_pmc_clk_enabled() to pllm_clk_is_gated_by_pmc() as
>       it was suggested by Jon Hunter in the review comment to v3.
> 
> v3: - Dropped unintended code change that was accidentally added to v2.
> 
> v2: - Added clarifying comment to the code.
> 
>     - Prettified the code.
> 
>  drivers/clk/tegra/clk-pll.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> index b2d39a66f0fa..ff13b371e176 100644
> --- a/drivers/clk/tegra/clk-pll.c
> +++ b/drivers/clk/tegra/clk-pll.c
> @@ -327,16 +327,26 @@ int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll)
>  	return clk_pll_wait_for_lock(pll);
>  }
>  
> +static bool pllm_clk_is_gated_by_pmc(struct tegra_clk_pll *pll)
> +{
> +	u32 val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
> +
> +	return (val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE) &&
> +	      !(val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE);
> +}
> +
>  static int clk_pll_is_enabled(struct clk_hw *hw)
>  {
>  	struct tegra_clk_pll *pll = to_clk_pll(hw);
>  	u32 val;
>  
> -	if (pll->params->flags & TEGRA_PLLM) {
> -		val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
> -		if (val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE)
> -			return val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE ? 1 : 0;
> -	}
> +	/*
> +	 * Power Management Controller (PMC) can override the PLLM clock
> +	 * settings, including the enable-state. The PLLM is enabled when
> +	 * PLLM's CaR state is ON and when PLLM isn't gated by PMC.
> +	 */
> +	if ((pll->params->flags & TEGRA_PLLM) && pllm_clk_is_gated_by_pmc(pll))
> +		return 0;
>  
>  	val = pll_readl_base(pll);
>  
> 

I have tested this on Jetson TK1 using u-boot to verify the behaviour
and it does indeed work as described here. I have also ran it through
the automated testing we have for Tegra and see no immediate issue.
Therefore ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
