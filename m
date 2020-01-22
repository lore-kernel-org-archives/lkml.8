Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656AEC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1F12253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu3i+yiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAVQ01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:26:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36567 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVQ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:26:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so7519914ljg.3;
        Wed, 22 Jan 2020 08:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x5gZN3N4/NDeK/FuVtrS+9B6ytLAp8OABue4zfrSjD8=;
        b=Yu3i+yiQMP9w88lkf2iOgYfcP8beEJqfQ5FEwLhhmaKgQHd5NF/SzL29hTDxBRJbuT
         sSGSyeRp9/mx9GUWSnYJEV74TKW/VrFip4CrOnefOCzizKmtKARKsaNgR/CcLT2YNKTc
         UooEUlPQFbGihC5WvA9De7mSi/GOILvhXM9FujA0vCr9wgqSwVmNHNGfSu6PMQcoTFqH
         MW/Zd/cJHcwRvoERZTVOl47cCupwcRZxM6dcz4+aRb1uFwSBpqkua+Y2hgCfqmm9HkoS
         zlLtR0V6GmwcRYWkDbMFoBI5K80XqpN1IKtkE2WB78G+No0og2fK+G37H0WE5WPu6ODL
         lndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x5gZN3N4/NDeK/FuVtrS+9B6ytLAp8OABue4zfrSjD8=;
        b=T00yNIK7XiaXRqziVPtA6UJsOsD+F8e0NZfwdPUTED3K6xAU6L3tQwuUOfsEbTcpii
         jMLXHXUtwpS+G6bNGONc50BMYCIQ0ETcI8WEOIeTcEgmTs4pFgRgDPaXhneGKDkonQ7X
         SLB5MCc7jL/I1eiiSE7dXgZWtJGMNG/0uGixKUM+5B/WofDduN6Yb9gsH6G9A5n1ZVeh
         DVYpsumShI1iu8i+YDM8qgrGshh9szCw1V5GWP0+sHvior8hY+g/APPSULneOnWx9DTf
         XWhkncJP53fo2yeL3+v5Mo1g6DB7YhDO/lyMoX9RylMDCNNCdW1RAL0jamK5Cnaipi2l
         Ng6A==
X-Gm-Message-State: APjAAAXbblkav/B2zRd2S8GDM9hrmCsDzo0KuJEBxO2udNNdQoNmjNp/
        32gZk5BJz0i/fWTolf1ibRkTd9Rn
X-Google-Smtp-Source: APXvYqzB+dXyRK4ry9eYU9FeFVw9x6A4rswfjLmMI1UMQt6DodIyLJkMZCdUmxZ3TGyMOEI4onDtgg==
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr20026126ljk.201.1579710384616;
        Wed, 22 Jan 2020 08:26:24 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id j19sm24605799lfb.90.2020.01.22.08.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 08:26:23 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        atalambedu@nvidia.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, jonathanh@nvidia.com, viswanathl@nvidia.com,
        sharadg@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, rlokhande@nvidia.com,
        mkumard@nvidia.com, dramesh@nvidia.com
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-5-git-send-email-spujar@nvidia.com>
 <a440d105-8db9-ecf1-3718-e58804ce14b8@gmail.com>
 <0c571858-d72c-97c2-2d6a-ead6fdde06eb@nvidia.com>
 <444731da-c4cd-8578-a732-c803eef31ef0@gmail.com>
 <bdc749bc-b62c-a041-c17c-33fd49fe8e2e@nvidia.com>
 <598fe377-5b95-d30a-eb64-89a645166d42@gmail.com>
 <3f51939d-cf4b-f69b-728a-7eb99bbae458@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3bf50205-efe1-7b2f-9837-0152131e4e85@gmail.com>
Date:   Wed, 22 Jan 2020 19:26:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <3f51939d-cf4b-f69b-728a-7eb99bbae458@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.01.2020 10:16, Sameer Pujar пишет:
> 
> 
> On 1/22/2020 11:53 AM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 22.01.2020 07:32, Sameer Pujar пишет:
>> [snip]
>>>>>>> +static int tegra210_i2s_remove(struct platform_device *pdev)
>>>>>>> +{
>>>>>>> +     pm_runtime_disable(&pdev->dev);
>>>>>>> +     if (!pm_runtime_status_suspended(&pdev->dev))
>>>>>>> +             tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>> This breaks device's RPM refcounting if it was disabled in the active
>>>>>> state. This code should be removed. At most you could warn about the
>>>>>> unxpected RPM state here, but it shouldn't be necessary.
>>>>> I guess this was added for safety and explicit suspend keeps clock
>>>>> disabled.
>>>>> Not sure if ref-counting of the device matters when runtime PM is
>>>>> disabled and device is removed.
>>>>> I see few drivers using this way.
>>>> It should matter (if I'm not missing something) because RPM should
>>>> be in
>>>> a wrecked state once you'll try to re-load the driver's module. Likely
>>>> that those few other drivers are wrong.
>>>>
>>>> [snip]
>>> Once the driver is re-loaded and RPM is enabled, I don't think it
>>> would use
>>> the same 'dev' and the corresponding ref count. Doesn't it use the new
>>> counters?
>>> If RPM is not working for some reason, most likely it would be the case
>>> for other
>>> devices. What best driver can do is probably do a force suspend during
>>> removal if
>>> already not done. I would prefer to keep, since multiple drivers still
>>> have it,
>>> unless there is a real harm in doing so.
>> I took a closer look and looks like the counter actually should be
>> reset. Still I don't think that it's a good practice to make changes
>> underneath of RPM, it may strike back.
> 
> If RPM is broken, it probably would have been caught during device usage.
> I will remove explicit suspend here if no any concerns from other folks.
> Thanks.
>>
>>>>>>> +     int rx_fifo_th;
>>>>>> Could rx_fifo_th be negative?
>>>>> rx_fifo_th itself does not take negative values, explicit
>>>>> typecasting> is avoided in "if" condition by declaring this as "int"
>>>> Explicit typecasting isn't needed for integers.
>>> What I meant was, rx_fifo_th is checked against a 'int' variable in an
>>> "if" condition.
>> What's the problem with comparing of unsigned with signed?
> 
> consider this example,
> ----
> unsigned int x = 5;
> int y = -1;
> 
> (x > y) is false.

Right

> ----
> Hence should be careful while using signed and unsigned comparisons.
>>
>> Besides, cif_conf.audio_ch > I2S_RX_FIFO_DEPTH can't be ever true, isn't
>> it? I2S_RX_FIFO_DEPTH=64, channels_max=16
> 
> Yes true.
>> Lastly, nothing stops you to make max_th unsigned.
> 
> will update.
> 

Thanks
