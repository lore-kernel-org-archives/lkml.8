Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0632FC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68FC20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwSnLpKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgAJOzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:55:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37382 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgAJOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:54:51 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so1688440lfc.4;
        Fri, 10 Jan 2020 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0gvZHliErrU7djUiz1bUBUU13O2uF7FKyxCjuMcMz4A=;
        b=ZwSnLpKaKb6q4r7zGNWe7D5oMy4xJbxw62JlSACoi+64rbdXXBIpYyPqTqP1l2jnoo
         oFI1qdzwPLQgcpjHA/MkHpdyxcu3wUfYPWc17x1oXRJ8RQGCklBYvNrrxGcrSZCXlUcJ
         IypPLhtptAxQ1LzaPeFulZ9PO0X1kokI4CU0NkIu6MyRe+5kMLTjRvnGWXsPmV36CxHy
         lxGRd1Cl1WPtVZoW9YQvs7KRzno2qiQSSW3XLuTVOJGH2rtIy3bF4M4R3pJrHbRLxZ6c
         hQnLHvNgEPuq56C+mShBGJlIaK1m3hd3z34JoU43ZdW4pR1HnfBOfPXgCtu320IihwQM
         Wgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0gvZHliErrU7djUiz1bUBUU13O2uF7FKyxCjuMcMz4A=;
        b=F7Lv1vRoGJAa5CrWFPaPkSMxoO/iTimjPrDjJf2tW518Urgm/bPqIuyuXwgB4/UEUx
         pfMqTUaehTavyITwh/imATnXEVOnBdgaQva5XmKGpdla71Aj1oQNxGYzjTbkgdJf2dhq
         e3rWDPjIw/80HarBWX5Rhb3fXEviyzs+wsoiymKCRneAFFibkhicGyqDQ+tdii9dYpFA
         /uU0aELSw99SYGTXwfmuUApiBGjsU6NAHu6WY+cgyqy5qstpTKCMBU8SS/1qZM9Hebe1
         /v2YcUGcTAZe0EG61msLNO5nfB6wUJmFu8qZ2Cz8YFbrgnKM0q3WZ7x0yk4lgRyURTbT
         KB8A==
X-Gm-Message-State: APjAAAUt12uO11Yqbo/1u8FMkvg7L8p+jW5+8MxDjOB8CIjY7ge8HtaT
        EBsUIEWMllxnNHAKzhjunomsvygo
X-Google-Smtp-Source: APXvYqxePfSFGAZu4SWy5PyGmHGomgkEOZPqNm3XdZH9IjoYpGYtGKRWcHyDO7lwvXnVKadQOSjIEQ==
X-Received: by 2002:a05:6512:244:: with SMTP id b4mr2579177lfo.85.1578668087958;
        Fri, 10 Jan 2020 06:54:47 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y14sm1118286ljk.46.2020.01.10.06.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 06:54:47 -0800 (PST)
Subject: Re: [PATCH v7 00/21] Move PMC clocks into Tegra PMC driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mperttunen@nvidia.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, josephl@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <4e9fab30-14b5-bf1f-dc91-fd57ef614503@gmail.com>
 <61a78ba8-4cc3-f6a6-513b-36daa9be32f0@nvidia.com>
 <37a9676b-e0e5-7e80-5ee4-abfca361dcf7@nvidia.com>
 <62751d2d-2b7d-509b-e236-363d2bb29b02@nvidia.com>
 <880b2e8a-aa55-40f3-7502-24392b88e53f@nvidia.com>
 <738f42e2-7135-b111-5863-1cb15aa96c18@nvidia.com>
 <dbb80785-59a8-6725-f43b-babe27ebbaeb@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <06919c0e-d0a5-5cf6-ba94-758fe9e1cdd6@gmail.com>
Date:   Fri, 10 Jan 2020 17:54:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <dbb80785-59a8-6725-f43b-babe27ebbaeb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.01.2020 07:47, Sowjanya Komatineni пишет:
> 
> On 1/9/20 8:43 PM, Sameer Pujar wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 1/10/2020 10:06 AM, Sowjanya Komatineni wrote:
>>>
>>> On 1/9/20 7:32 PM, Sowjanya Komatineni wrote:
>>>>
>>>> On 1/9/20 7:24 PM, Sowjanya Komatineni wrote:
>>>>>
>>>>> On 1/9/20 5:39 PM, Sowjanya Komatineni wrote:
>>>>>>
>>>>>> On 1/9/20 11:44 AM, Dmitry Osipenko wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> 08.01.2020 07:24, Sowjanya Komatineni пишет:
>>>>>>>> This patch series moves Tegra PMC clocks from clock driver to pmc
>>>>>>>> driver
>>>>>>>> along with the device trees changes and audio driver which uses
>>>>>>>> one of
>>>>>>>> the pmc clock for audio mclk.
>>>>>>>>
>>>>>>>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls
>>>>>>>> which
>>>>>>>> are currently registered by Tegra clock driver using
>>>>>>>> clk_regiser_mux and
>>>>>>>> clk_register_gate which performs direct Tegra PMC register access.
>>>>>>>>
>>>>>>>> When Tegra PMC is in secure mode, any access from non-secure
>>>>>>>> world will
>>>>>>>> not go through.
>>>>>>>>
>>>>>>>> This patch series adds these Tegra PMC clocks and blink controls
>>>>>>>> to Tegra
>>>>>>>> PMC driver with PMC as clock provider and removes them from Tegra
>>>>>>>> clock
>>>>>>>> driver.
>>>>>>>>
>>>>>>>> PMC clock clk_out_1 is dedicated for audio mclk from Tegra30 thru
>>>>>>>> Tegra210
>>>>>>>> and clock driver does inital parent configuration for it and
>>>>>>>> enables them.
>>>>>>>> But this clock should be taken care by audio driver as there is
>>>>>>>> no need
>>>>>>>> to have this clock pre enabled.
>>>>>>>>
>>>>>>>> So, this series also includes patch that updates ASoC driver to
>>>>>>>> take
>>>>>>>> care of parent configuration for mclk if device tree don't specify
>>>>>>>> initial parent configuration using assigned-clock-parents and
>>>>>>>> controls
>>>>>>>> audio mclk enable/disable during ASoC machine startup and shutdown.
>>>>>>>>
>>>>>>>> DTs are also updated to use clk_out_1 as audio mclk rather than
>>>>>>>> extern1.
>>>>>>>>
>>>>>>>> This series also includes a patch for mclk fallback to extern1 when
>>>>>>>> retrieving mclk fails to have this backward compatible of new DT
>>>>>>>> with
>>>>>>>> old kernels.
>>>>>>> Suspend-resume doesn't work anymore, reverting this series helps. I
>>>>>>> don't have any other information yet, please take a look.
>>>>>> Thanks Dmitry. Will test suspend resume and check..
>>>>>
>>>>> I see if we leave audio mclk (cdev1) enabled during
>>>>> tegra_asoc_utils_init, suspend resume works.
>>>>>
>>>>> Without audio mclk enabled during tegra_asoc_utils_init, somehow it
>>>>> prevents entry to suspend on Tegra30 platform.
>>>>>
>>>>> Will look in detail..
>>>>>
>>>> audio mclk is only needed for audio and werid that having it not
>>>> enabled all the time like in current clock driver prevents suspend
>>>> entry on Tegra30
>>>>
>>>> Looks like this issue is masked earlier with having mclk enabled all
>>>> the time by clock driver.
>>>>
>>> On linux-next without this patch series, I just disabled mclk to be
>>> enabled all the time (removed set_rate from utils_init) and also
>>> disabled default enable from clock driver.
>>>
>>> So somehow disabling mclk is preventing suspend entry.
>>
>> This is strange.
>>
>>>
>>> Probably debugging suspend issue on Tegra30 when audio mclk is
>>> disabled can be done separately and will keep audio mclk enabled in
>>> asoc_utils_init with comment mentioning this issue and fix as TBD to
>>> move on with PMC clock fixes.
>>
>> Sounds fine with me as the suspend/resume issue is not introduced in the
>> current series. It can be addressed separately.
>>
>>>
> Thanks Sameer. So, will keep mclk not enabled in clock driver but will
> do mclk enable in asoc_utils_init and will remove machine startup and
> shutdown.
> 
> mclk dependency with suspend/resume and I2S and audio clocks proper
> handling in audio driver can be taken care separately out of this series.
> 
> Dimitry, I hope you too agree with this.

Yes, should be fine to fix it separately from this series.

I suppose the clocks management isn't done properly by some of the audio
drivers and machine hangs after trying to access hardware module which
has the disabled clock. That's a quite typical bug.
