Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E38C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2AF2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLeNoJj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgAXEe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 23:34:29 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39414 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAXEe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 23:34:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id t23so300396lfk.6;
        Thu, 23 Jan 2020 20:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iRMdTlWpB/i07RpBQjACVTfdEIqwZ2lTL+v769LcM3k=;
        b=ZLeNoJj9lm0TqcCEmDTQPBhM4MiG15+CetdBuDpzpbSxShkmzI5SwGqj59jyQFvOlU
         pRT57mMmEo1vymIWW78BJm0TDGiHlSEQp1SPfjt7isJp6VHa5PMa9hhr0IArUZPAiKnd
         qrb/4pmjor6Nu/yDJ3YHmaD0gjH+Ch6PM/JoXoVhT0x4z2HP/dRluVtMESb5dTfNIU36
         /BO/L6or0QUemYBYVDEHyq3S1+7G6BxcdiCRCNfl9SPcsqahMkXJjsiX+70vOKxIanYz
         nf2Ntft1yg40iZ/6/QzgSmAE9vCRqwWQoUQsopiNXS5KQ3XqtMSzmg1Ghv1dW4cR/Sjk
         hVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iRMdTlWpB/i07RpBQjACVTfdEIqwZ2lTL+v769LcM3k=;
        b=Y1V4VFzudyDxd1L6da9QUfvWdsZhHvDbLaUrCi1+NxQ9C/u5DINQ1Xrmg0nDWUxv1D
         UwgFeRE6rZ0+MsTAR75YTOFcFfMG71wQ1McSczG3rr1w8v6XWhlKktegGqTpLdEAjB6M
         IGMcP/luoza1wh6rqYqQwAEkj22AYc2ywCW7YFw9Ao1O4MlQ8PCaOIcW19QYhMDRzGbN
         0wSKnYKkXy6RiyY2UobanQ7jDVj8vbo8IpNziR+nno8j4krWKhWKUdHGrnIputh7FGIm
         6KCbuhWNWRXidX7NaBwMlSKKWkxEX31ylBvmrSVXyixq60WN3R3PS4V9JM9dJHSNCw80
         nwwQ==
X-Gm-Message-State: APjAAAV7RnBimkRwwTZauEoqu4DwQ0CXwphnBGp5FYKi5jFtv/a8I5ru
        Yqp1ScCDeWrlm3i6JGJoe3TX6jUr
X-Google-Smtp-Source: APXvYqwj3uUlHz/aP9yCFgv4v7F5Xp4Uwp0yDO0OIk5+TdT9VBsVV6BI/tG2l19oYhPq/DM988vGGg==
X-Received: by 2002:ac2:544f:: with SMTP id d15mr529764lfn.126.1579840465779;
        Thu, 23 Jan 2020 20:34:25 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y5sm2069884lfl.6.2020.01.23.20.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 20:34:25 -0800 (PST)
Subject: Re: [PATCH v8 22/22] clk: tegra: Remove audio clocks configuration
 from clock driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
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
Message-ID: <e6013c72-4ceb-aa3f-50bf-187794f85b66@gmail.com>
Date:   Fri, 24 Jan 2020 07:34:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f2506b91-0199-f2a5-ea8c-ace7b651b443@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.01.2020 19:57, Dmitry Osipenko пишет:
> 21.01.2020 19:19, Sowjanya Komatineni пишет:
>>
>> On 1/19/20 7:04 AM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 14.01.2020 10:24, Sowjanya Komatineni пишет:
>>>
>>> [snip]
>>>
>>>> diff --git a/drivers/clk/tegra/clk-tegra30.c
>>>> b/drivers/clk/tegra/clk-tegra30.c
>>>> index 5732fdbe20db..53d1c48532ae 100644
>>>> --- a/drivers/clk/tegra/clk-tegra30.c
>>>> +++ b/drivers/clk/tegra/clk-tegra30.c
>>>> @@ -1221,9 +1221,8 @@ static struct tegra_clk_init_table init_table[]
>>>> __initdata = {
>>>>        { TEGRA30_CLK_UARTC, TEGRA30_CLK_PLL_P, 408000000, 0 },
>>>>        { TEGRA30_CLK_UARTD, TEGRA30_CLK_PLL_P, 408000000, 0 },
>>>>        { TEGRA30_CLK_UARTE, TEGRA30_CLK_PLL_P, 408000000, 0 },
>>>> -     { TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 1 },
>>>> -     { TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 1 },
>>>> -     { TEGRA30_CLK_EXTERN1, TEGRA30_CLK_PLL_A_OUT0, 0, 1 },
>>>> +     { TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 0 },
>>>> +     { TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 0 },
>>>>        { TEGRA30_CLK_I2S0, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>>>        { TEGRA30_CLK_I2S1, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>>>        { TEGRA30_CLK_I2S2, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>>>
>>> What about to use the assigned-clock-rates in device-tree and thus to
>>> remove those PLL_A entries?
>>
>> Yes clock rates can be used and also PLL rate is set based on sample
>> rate during hw_params. So this can be removed.
>>
>> But PLLA clock rates are not related to this patch series and also
>> changing this needs audio function testing across all platforms and
>> currently we don't have audio functional tests in place for older
>> platforms.
>>
>> All audio clocks proper fixes and cleanup b/w clock driver and audio
>> driver will be done separately.
> 
> If there are real plans to make sound driver to drive the PLLA rate,
> then indeed should be fine to keep it as-is for now.

Looking at tegra_asoc_utils_set_rate(), it already sets the PLLA rate.
Maybe those table entries are not needed already?
