Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB05C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC22020663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRUSsM7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGIKPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgGIKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:14:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12DAC061A0B;
        Thu,  9 Jul 2020 03:14:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j11so1742691ljo.7;
        Thu, 09 Jul 2020 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SPpf7Nl871F0m0nI/v8TgKrxk8tn0S9xL1Qn7nycdkw=;
        b=IRUSsM7ZvHc4O94SB+wb5boOA1uuqUADtNYnhs9c45oiiN/zDzdJrC/Hg5ccplEmYy
         f5ZmLmndmmo7uqD4I9FbT66ZrWyI7j2fRLO8o5k3n1XuLXGz0Yx6wOU98bxDMUYtBD3I
         SF5zJ/NEY0TYVpeIof5a0SCQxpYnEL7KXdFFw5LlLW+q+E+dyML5mT+ijd8SWVyPiOfj
         RVH4NFb8+rP/QnJ1SAPdoESBHhvMip4Ib9oOYOtD8wy1A7SUmcXK/xkmopybjGKlrbmX
         0kFp6G8KOCFvZixCbBpNMDYINagTjxwKiMkLliaTLghpvzE7e5bMrrjxoxO8MSoEmqs8
         sbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SPpf7Nl871F0m0nI/v8TgKrxk8tn0S9xL1Qn7nycdkw=;
        b=B9N1w7fW8uKD7uEJuepwN1954jrK2Rd15AjY6Xo2i0TJiUa7GB/bbYQMB8YMBcsduS
         WJmd+Na3c1cHz1xAesAAWgNPf16efyTuARSQEQxYtzF9Vf+09I8oYtJ6OWyP+cuZb6un
         kCgnKkxrhjtVV+KiF2PVOmL/NMaPVWKRGVD9/GqW4pnHWDtzHfYHJ3Zka5T1JLRoWsCL
         tZRq+H5/AJlv0A1cE7X+DSY3fRQ8S92AMKQwCj3jlH2+I7GHOeu1hYcWZ32qlbsS5gA8
         k2E2MKl+qKPkyR2ivI+6CTbeo3NJyi0VwEdaCvdB9fEcxWyQadEjHYXf3Q/Bv4FzwiKw
         4Mew==
X-Gm-Message-State: AOAM530MyFN5zLOYFrhdqKWQOQ/g0TMPOfuKXUnYweHxG7k0bSjfe/Gj
        rX23Vvea6Os//y6mVmvmhXKfML3y
X-Google-Smtp-Source: ABdhPJy/WvRxPMkzrfdCPDFTOQsQz3XCTPMcqFtTLP+ITBQTfoItQ5akUWYnodmxyggGYzQGQMX10g==
X-Received: by 2002:a2e:3618:: with SMTP id d24mr26980487lja.408.1594289695907;
        Thu, 09 Jul 2020 03:14:55 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.googlemail.com with ESMTPSA id o1sm641218ljj.82.2020.07.09.03.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:14:55 -0700 (PDT)
Subject: Re: [PATCH v3] clk: tegra: pll: Improve PLLM enable-state detection
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200708075418.25295-1-digetx@gmail.com>
 <3755bfe4-c7db-f9ac-0a02-b59b5dee401d@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <54a4cc53-9afe-60a3-d353-2d019a6c08a0@gmail.com>
Date:   Thu, 9 Jul 2020 13:14:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3755bfe4-c7db-f9ac-0a02-b59b5dee401d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.07.2020 12:49, Jon Hunter пишет:
> 
> On 08/07/2020 08:54, Dmitry Osipenko wrote:
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
>> index b2d39a66f0fa..37cfcd6836c9 100644
>> --- a/drivers/clk/tegra/clk-pll.c
>> +++ b/drivers/clk/tegra/clk-pll.c
>> @@ -327,16 +327,26 @@ int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll)
>>  	return clk_pll_wait_for_lock(pll);
>>  }
>>  
>> +static bool pllm_pmc_clk_enabled(struct tegra_clk_pll *pll)
>> +{
>> +	u32 val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
>> +
>> +	return !(val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE) ||
>> +		(val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE);
>> +}
>> +
> 
> 
> I am not sure that the name of the above function really reflects what
> it is doing. If it was enabled, isn't it the AND of these bits?
> 
> Futhermore, what we really want to know is if the override is enabled,
> but the PMC PLLM enable is not set. In other words, the PMC is gating
> the clock. So maybe we should have a function that is called something
> like pllm_clk_is_gated_by_pmc().

Yeah, the name indeed could be improved + the logic could be inverted in
order to make it all more clear. Thank you for the suggestion! I'll
prepare the v4.
