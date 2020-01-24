Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAFFC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF102070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgAXIuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 03:50:15 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:51506 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbgAXIuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:50:15 -0500
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1iuufL-0002gP-Ar; Fri, 24 Jan 2020 08:50:11 +0000
Subject: Re: [PATCH v8 22/22] clk: tegra: Remove audio clocks configuration
 from clock driver
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-23-git-send-email-skomatineni@nvidia.com>
 <d69fe7a8-71cc-c560-a567-f89b936753ad@gmail.com>
 <9765b723-33af-9863-72c9-8094203c8cb8@nvidia.com>
 <f2506b91-0199-f2a5-ea8c-ace7b651b443@gmail.com>
 <e6013c72-4ceb-aa3f-50bf-187794f85b66@gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <fc2b6c3d-a204-ee35-fce4-b2831c444eb3@codethink.co.uk>
Date:   Fri, 24 Jan 2020 08:50:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e6013c72-4ceb-aa3f-50bf-187794f85b66@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2020 04:34, Dmitry Osipenko wrote:
> 21.01.2020 19:57, Dmitry Osipenko пишет:
>> 21.01.2020 19:19, Sowjanya Komatineni пишет:
>>>
>>> On 1/19/20 7:04 AM, Dmitry Osipenko wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> 14.01.2020 10:24, Sowjanya Komatineni пишет:
>>>>
>>>> [snip]
>>>>
>>>>> diff --git a/drivers/clk/tegra/clk-tegra30.c
>>>>> b/drivers/clk/tegra/clk-tegra30.c
>>>>> index 5732fdbe20db..53d1c48532ae 100644
>>>>> --- a/drivers/clk/tegra/clk-tegra30.c
>>>>> +++ b/drivers/clk/tegra/clk-tegra30.c
>>>>> @@ -1221,9 +1221,8 @@ static struct tegra_clk_init_table init_table[]
>>>>> __initdata = {
>>>>>         { TEGRA30_CLK_UARTC, TEGRA30_CLK_PLL_P, 408000000, 0 },
>>>>>         { TEGRA30_CLK_UARTD, TEGRA30_CLK_PLL_P, 408000000, 0 },
>>>>>         { TEGRA30_CLK_UARTE, TEGRA30_CLK_PLL_P, 408000000, 0 },
>>>>> -     { TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 1 },
>>>>> -     { TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 1 },
>>>>> -     { TEGRA30_CLK_EXTERN1, TEGRA30_CLK_PLL_A_OUT0, 0, 1 },
>>>>> +     { TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 0 },
>>>>> +     { TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 0 },
>>>>>         { TEGRA30_CLK_I2S0, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>>>>         { TEGRA30_CLK_I2S1, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>>>>         { TEGRA30_CLK_I2S2, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>>>>
>>>> What about to use the assigned-clock-rates in device-tree and thus to
>>>> remove those PLL_A entries?
>>>
>>> Yes clock rates can be used and also PLL rate is set based on sample
>>> rate during hw_params. So this can be removed.
>>>
>>> But PLLA clock rates are not related to this patch series and also
>>> changing this needs audio function testing across all platforms and
>>> currently we don't have audio functional tests in place for older
>>> platforms.
>>>
>>> All audio clocks proper fixes and cleanup b/w clock driver and audio
>>> driver will be done separately.
>>
>> If there are real plans to make sound driver to drive the PLLA rate,
>> then indeed should be fine to keep it as-is for now.
> 
> Looking at tegra_asoc_utils_set_rate(), it already sets the PLLA rate.
> Maybe those table entries are not needed already?

This reminds me I still have patches for support for tegra30 as clock
slave. I should really sort out getting these finished up and tested.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
