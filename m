Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C2FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D8A21841
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CZG3pHme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgGNIUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:20:36 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15979 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgGNIUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:20:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0d6a990001>; Tue, 14 Jul 2020 01:19:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jul 2020 01:20:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jul 2020 01:20:35 -0700
Received: from [10.26.72.103] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jul
 2020 08:20:33 +0000
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
Message-ID: <93106a4c-b0fb-3bbf-49cb-bfe348b1ffc7@nvidia.com>
Date:   Tue, 14 Jul 2020 09:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200709172057.13951-1-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594714778; bh=KtQByRKgbCXTNDhrfVdrgBvgK/Gron8uXU8n9vp9BIE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CZG3pHmeKX2j1mhUunJaHF993vqWq0iQB9nuMkfACF211N+vC12Rk88/GOmgN6lar
         6V4Hu/4HZnebvSKWyRVE89i4daaKJA/jp71SA/Wcuu/eAowoV/LuREZXBr2DLwC8rd
         vWZTrSopZLNe5ayPptb2iZ4HmVQ2L3bjkboWgChuMhIg4vMIVmFIiyAtxS2jUfdk/Q
         L2zk0LW1uDnhKRnQlyIiIDer+wGd3+XdBOoxC4AkrQbq7rrRU5zWLOYiiNg2ISWBTK
         e8wcwqCwr9c/H/24BRCnXs5jgyWO7ll4pnj+DZtzfGM3Edj8bJAzApS/KxTD3F0Rlx
         nMDoHeel/etWg==
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


Thanks! This looks good to me. However, I just want to do a bit of
testing on Tegra124 (hopefully this week).

Jon

-- 
nvpublic
