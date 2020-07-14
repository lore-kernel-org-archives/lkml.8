Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350CEC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107DB217A0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDjG8he2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGNJg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgGNJgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:36:55 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D3BC061755;
        Tue, 14 Jul 2020 02:36:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so21623762lji.9;
        Tue, 14 Jul 2020 02:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kY4YX2hIy3ivPBGeD+CPwXcdkRIs2VM7rDcdPR/WlRE=;
        b=HDjG8he2L90VPS290BuQKswRMt1dfJOQp/N5SM3tNqWBG3I3sMfibTlke3Hvw8Rm4a
         H8agt4VOrJz+JZ3rmiZn938rB7AUGJCrj8J+oIh8Tei/nhgYPFqKz4NWRzGEu1W7vbNw
         Ijk47dHwcWcCdhxa+vU1FlIuLI1ufBZuJBt3WRixesxaWleUGsX9YNBLIs0bN6LROT8j
         Lq8ki9S2a9EA953R1gu3iajngedMwunBKkA0paWsngzDRF4ukd5FlUwQAmBYQdgY5KJF
         pgh8D+OEp3SqEvMb4sE/teBX/PA+I7f6jBRJXg3p+GCAVvhBRME7GhF3iWt7JlDFSd2b
         +K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kY4YX2hIy3ivPBGeD+CPwXcdkRIs2VM7rDcdPR/WlRE=;
        b=VTcEvHmBiIK8RabKb9y+yniVVlGWQL0Mp+3rZU4f7fswaW4hUZ2RNtoy7hvsuAUmzH
         PyEYZpHF8/PdVLmaQxb1Oj+wpc3X3gvpn2vq7RsA9UC9tEg+Z5bxNifhohwounbtjG8m
         7TakksNgEDPuzV2vzu5BtNLZGS20d66vikV1ws9U5fX0qHx6gCsxO+lWxNMYGcurBcQS
         ELZsGYg295vUS4F2/8S9PxqUGtHCSnUsvoTbPTkMyyqY8ZcZuFpgPoQOixMhIJHWS1WN
         XbNsTt2ckUlkPHgI+ukJAgnSBe6cWdPSI1NIUNYsSYy9lZwt11FL/9uv3F2PVlPs4Isk
         mRwA==
X-Gm-Message-State: AOAM532YkQ3b27oDKO+BbKf/gDYdX28zpR+2Ff54VcQK8cpy2eDYuC9c
        5f4hkvckUHxJG/aaj7ulnfJ3SPnS
X-Google-Smtp-Source: ABdhPJw88vs/UiQIgGDfGKYqqUL+LavOJZcUM4xAQ0ay4LLCSkEbYdUM12f9PGmO6mPzXa831sGdaQ==
X-Received: by 2002:a2e:91c4:: with SMTP id u4mr2003431ljg.20.1594719413117;
        Tue, 14 Jul 2020 02:36:53 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.googlemail.com with ESMTPSA id d6sm4553300ljc.23.2020.07.14.02.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 02:36:52 -0700 (PDT)
Subject: Re: [PATCH v4] clk: tegra: pll: Improve PLLM enable-state detection
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200709172057.13951-1-digetx@gmail.com>
 <93106a4c-b0fb-3bbf-49cb-bfe348b1ffc7@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4abe7959-3c69-7b05-e9af-565957bafbcd@gmail.com>
Date:   Tue, 14 Jul 2020 12:36:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <93106a4c-b0fb-3bbf-49cb-bfe348b1ffc7@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.07.2020 11:20, Jon Hunter пишет:
> 
> On 09/07/2020 18:20, Dmitry Osipenko wrote:
>> Power Management Controller (PMC) can override the PLLM clock settings,
>> including the enable-state. Although PMC could only act as a second level
>> gate, meaning that PLLM needs to be enabled by the Clock and Reset
>> Controller (CaR) anyways if we want it to be enabled. Hence, when PLLM is
>> overridden by PMC, it needs to be enabled by CaR and ungated by PMC in
>> order to be functional. Please note that this patch doesn't fix any known
>> problem, and thus, it's merely a minor improvement.
>>
>> Link: https://lore.kernel.org/linux-arm-kernel/20191210120909.GA2703785@ulmo/T/
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v4: - Renamed pllm_pmc_clk_enabled() to pllm_clk_is_gated_by_pmc() as
>>       it was suggested by Jon Hunter in the review comment to v3.
>>
>> v3: - Dropped unintended code change that was accidentally added to v2.
>>
>> v2: - Added clarifying comment to the code.
>>
>>     - Prettified the code.
>>
>>  drivers/clk/tegra/clk-pll.c | 20 +++++++++++++++-----
>>  1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
>> index b2d39a66f0fa..ff13b371e176 100644
>> --- a/drivers/clk/tegra/clk-pll.c
>> +++ b/drivers/clk/tegra/clk-pll.c
>> @@ -327,16 +327,26 @@ int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll)
>>  	return clk_pll_wait_for_lock(pll);
>>  }
>>  
>> +static bool pllm_clk_is_gated_by_pmc(struct tegra_clk_pll *pll)
>> +{
>> +	u32 val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
>> +
>> +	return (val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE) &&
>> +	      !(val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE);
>> +}
>> +
>>  static int clk_pll_is_enabled(struct clk_hw *hw)
>>  {
>>  	struct tegra_clk_pll *pll = to_clk_pll(hw);
>>  	u32 val;
>>  
>> -	if (pll->params->flags & TEGRA_PLLM) {
>> -		val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
>> -		if (val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE)
>> -			return val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE ? 1 : 0;
>> -	}
>> +	/*
>> +	 * Power Management Controller (PMC) can override the PLLM clock
>> +	 * settings, including the enable-state. The PLLM is enabled when
>> +	 * PLLM's CaR state is ON and when PLLM isn't gated by PMC.
>> +	 */
>> +	if ((pll->params->flags & TEGRA_PLLM) && pllm_clk_is_gated_by_pmc(pll))
>> +		return 0;
>>  
>>  	val = pll_readl_base(pll);
> 
> 
> Thanks! This looks good to me. However, I just want to do a bit of
> testing on Tegra124 (hopefully this week).

Okay, thank you :)
