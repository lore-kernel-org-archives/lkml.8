Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464CFC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1977521569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMjx9T7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgAUQ6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:58:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45201 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbgAUQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:57:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so2842066lfa.12;
        Tue, 21 Jan 2020 08:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=13rfNwxyiR9yuh7eK/7sBMvhz8O70v72cEL2FYuVuuw=;
        b=CMjx9T7PtY1kfCg2UepPrVQ1Hpe7hOMZU/pLX4viCwRLqN/qlrwhwyJUAuQPjE73ha
         MX/QAp600urA0KcCNWXi70P5jCWzwjVxgQdgQA704meGkw9BBq6HfJljGniXS3/tV6Sh
         rXBfa93dOG1XoDH6wLQCKUghxqXlCcCanLsdxNZZstCtE6HheuASHqU29T6tw3SVtPWU
         r8F+INeCbTbPEWEn1Rq/XwxUg6AB3TLDfVXIoSjfBUZopXm3iLKOE9u19hdcshXffCr2
         FJnK3dgh+wGWAq6lTe7pFuGusnmjcTf1NzYb6LY0QsEIthGl1F4d0fdSgUlCbUWnLjOk
         tqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=13rfNwxyiR9yuh7eK/7sBMvhz8O70v72cEL2FYuVuuw=;
        b=CSxAA09tZzsnRQuA+RjcP+hJRetplg6bHbM6OVmglOz0ze9IRk6ctQNByVHm7f3jBU
         cBaiOONoo2/dEnuDVa+HOY6aPkDFKsWxtQtVR+4CtYiqhfw7JWqIqMwH5/9AkwisKZzZ
         65i+ls1ekhtnKjpKTYLrRm6sRuR+DOBAaGyYzkK61zAt7gvSFRa1iginDAqPApM4xdHt
         +HZ4RDNdymslV8NY0zwW79ObWxWZw2eQc/nCnlf9j01x0AnVGaPEB8wVTFGQSR9a9BGf
         jQWqMCO+YRBVz8LrMLtn1mCvfX/ZCbTJAeqduggdMTfCPwnxEmtZViJBpropbDP+6hNN
         Hs0Q==
X-Gm-Message-State: APjAAAVLfWc56mWRMtnMpiTxBf58q2WQJ8Q5L4zQMTxqN1kZsk6muzmG
        +SwmRBk9/EngQyMMQtxcgyGp6V5S
X-Google-Smtp-Source: APXvYqz8y+exlJhNtla7NozdORcCyX05vAJjJeIxAxEhtNFlCSv1FCczCahSTpmAE+gzeqg/mFl3pg==
X-Received: by 2002:ac2:5216:: with SMTP id a22mr3177132lfl.18.1579625875608;
        Tue, 21 Jan 2020 08:57:55 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r20sm19173224lfi.91.2020.01.21.08.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 08:57:55 -0800 (PST)
Subject: Re: [PATCH v8 22/22] clk: tegra: Remove audio clocks configuration
 from clock driver
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f2506b91-0199-f2a5-ea8c-ace7b651b443@gmail.com>
Date:   Tue, 21 Jan 2020 19:57:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9765b723-33af-9863-72c9-8094203c8cb8@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.01.2020 19:19, Sowjanya Komatineni пишет:
> 
> On 1/19/20 7:04 AM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 14.01.2020 10:24, Sowjanya Komatineni пишет:
>>
>> [snip]
>>
>>> diff --git a/drivers/clk/tegra/clk-tegra30.c
>>> b/drivers/clk/tegra/clk-tegra30.c
>>> index 5732fdbe20db..53d1c48532ae 100644
>>> --- a/drivers/clk/tegra/clk-tegra30.c
>>> +++ b/drivers/clk/tegra/clk-tegra30.c
>>> @@ -1221,9 +1221,8 @@ static struct tegra_clk_init_table init_table[]
>>> __initdata = {
>>>        { TEGRA30_CLK_UARTC, TEGRA30_CLK_PLL_P, 408000000, 0 },
>>>        { TEGRA30_CLK_UARTD, TEGRA30_CLK_PLL_P, 408000000, 0 },
>>>        { TEGRA30_CLK_UARTE, TEGRA30_CLK_PLL_P, 408000000, 0 },
>>> -     { TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 1 },
>>> -     { TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 1 },
>>> -     { TEGRA30_CLK_EXTERN1, TEGRA30_CLK_PLL_A_OUT0, 0, 1 },
>>> +     { TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 0 },
>>> +     { TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 0 },
>>>        { TEGRA30_CLK_I2S0, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>>        { TEGRA30_CLK_I2S1, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>>        { TEGRA30_CLK_I2S2, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
>>>
>> What about to use the assigned-clock-rates in device-tree and thus to
>> remove those PLL_A entries?
> 
> Yes clock rates can be used and also PLL rate is set based on sample
> rate during hw_params. So this can be removed.
> 
> But PLLA clock rates are not related to this patch series and also
> changing this needs audio function testing across all platforms and
> currently we don't have audio functional tests in place for older
> platforms.
> 
> All audio clocks proper fixes and cleanup b/w clock driver and audio
> driver will be done separately.

If there are real plans to make sound driver to drive the PLLA rate,
then indeed should be fine to keep it as-is for now.
