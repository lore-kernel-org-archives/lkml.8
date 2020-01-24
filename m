Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEB3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827E72071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG1SAK6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390103AbgAXOE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:04:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41306 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387698AbgAXOE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:04:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so1185599lfp.8;
        Fri, 24 Jan 2020 06:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DWyzbO4741sf0L5+8NtxZfMXKdFgeyMskzc4yQ5LKik=;
        b=IG1SAK6dVJxniffYa8ulrA7AL/YuJg0iC3DrdcKxYWOtAYxaJCUF5ARno/fLnNOKJg
         tjzeaGLlFal2k+c8zm/KilTTuXdsu21giT/0mp87i+hBj9xEQBPNXC6TK/eGQkJbPXQy
         cBKc8ejx71i8Hwvk3/AHxfx57Ro/J4uirB3XgKEqC/gqvw/0X+Nw3f22ifyDdNpidHJB
         q0ma+E0ZMOB0d4w+GS+Az7Y4kgUuaJ2hHow0a6lciSbkNcjnnqtBSwEfq7OhBicL8fMi
         /fG/5jKgM3HuXxQ+oe8Afi9ou3LMdZLxvJwv1mrRxSIgHvpu4KWXZvMNz6vAEjcYYHhl
         FC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWyzbO4741sf0L5+8NtxZfMXKdFgeyMskzc4yQ5LKik=;
        b=GfHpXpOZRWi/Kaxgy7eUlpDWT97HYgSLR1H9+CX1FfoKCph9IXZRk0JZw5+fKEZrQd
         ZrbBQlqJztFvmw/Wb6DI4vz9e0nTFSfQg9lX5v9zSoSa03F6ddWgGaW9b1F/Z2NOjVnG
         jxm/5t9yRBkBEIt/fMnMX+hOzTePJaSoewF8lUSNPF1ccCatvklxohHQ+frOwHdJr5Pd
         8jXFbNXsL+vYwSeRZ0lOUmuM6zqdO1ZqsPIChpP8Vb12it51bkDRgYimVS4AzqYBMjfn
         EfeFY1Y3SfqLXfFAkea+anmXudKxfCUqC9Cltm6efYdfSjRjwmZRwpMV0CyeYbk7vRO0
         HVqQ==
X-Gm-Message-State: APjAAAXxf+CxlCs+Fcssdunb0PjP2ktB5iuNl5ld2m9HUkY8ZOXkfnpT
        bi1Vx+eiIeMe5qlzMsCuvB8=
X-Google-Smtp-Source: APXvYqx9x4q/YcfnEp5oOwdHBsbqmMlHPOlXmnQ8lPeXqMgUjWgk8nn69tfRIWWqDpSjdMc+MrAniA==
X-Received: by 2002:a19:c210:: with SMTP id l16mr1495777lfc.35.1579874663409;
        Fri, 24 Jan 2020 06:04:23 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i13sm3094490ljg.89.2020.01.24.06.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 06:04:22 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Jon Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org, atalambedu@nvidia.com, tiwai@suse.com,
        viswanathl@nvidia.com, linux-tegra@vger.kernel.org,
        robh+dt@kernel.org, thierry.reding@gmail.com, sharadg@nvidia.com,
        rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-5-git-send-email-spujar@nvidia.com>
 <a440d105-8db9-ecf1-3718-e58804ce14b8@gmail.com>
 <0c571858-d72c-97c2-2d6a-ead6fdde06eb@nvidia.com>
 <444731da-c4cd-8578-a732-c803eef31ef0@gmail.com>
 <bdc749bc-b62c-a041-c17c-33fd49fe8e2e@nvidia.com>
 <598fe377-5b95-d30a-eb64-89a645166d42@gmail.com>
 <3f51939d-cf4b-f69b-728a-7eb99bbae458@nvidia.com>
 <34ac1fd3-ae0f-07f2-555f-a55087a2c9dc@nvidia.com>
 <1a84b393-938f-8bed-d08e-cc3bb6ed4844@gmail.com>
 <0fc814c2-0dc6-7741-b954-463381ff7fb9@nvidia.com>
 <b5c581b9-17af-d004-33fb-2cc782ab820a@gmail.com>
 <9f73afdf-1e9a-cdbd-f972-a022d503ef51@nvidia.com>
 <264d3354-8a2e-ee12-44ae-aff69213d551@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <075e476a-36bb-5fee-15bc-76af4474a797@gmail.com>
Date:   Fri, 24 Jan 2020 17:04:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <264d3354-8a2e-ee12-44ae-aff69213d551@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.01.2020 12:51, Jon Hunter пишет:
> 
> On 24/01/2020 09:07, Jon Hunter wrote:
>>
>> On 23/01/2020 15:16, Dmitry Osipenko wrote:
>>> 23.01.2020 12:22, Sameer Pujar пишет:
>>>>
>>>>
>>>> On 1/22/2020 9:57 PM, Dmitry Osipenko wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> 22.01.2020 14:52, Jon Hunter пишет:
>>>>>> On 22/01/2020 07:16, Sameer Pujar wrote:
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>>>>>>>> +static int tegra210_i2s_remove(struct platform_device *pdev)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +     pm_runtime_disable(&pdev->dev);
>>>>>>>>>>>>> +     if (!pm_runtime_status_suspended(&pdev->dev))
>>>>>>>>>>>>> +             tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>>>>>>>> This breaks device's RPM refcounting if it was disabled in the
>>>>>>>>>>>> active
>>>>>>>>>>>> state. This code should be removed. At most you could warn
>>>>>>>>>>>> about the
>>>>>>>>>>>> unxpected RPM state here, but it shouldn't be necessary.
>>>>>>>>>>> I guess this was added for safety and explicit suspend keeps clock
>>>>>>>>>>> disabled.
>>>>>>>>>>> Not sure if ref-counting of the device matters when runtime PM is
>>>>>>>>>>> disabled and device is removed.
>>>>>>>>>>> I see few drivers using this way.
>>>>>>>>>> It should matter (if I'm not missing something) because RPM should
>>>>>>>>>> be in
>>>>>>>>>> a wrecked state once you'll try to re-load the driver's module.
>>>>>>>>>> Likely
>>>>>>>>>> that those few other drivers are wrong.
>>>>>>>>>>
>>>>>>>>>> [snip]
>>>>>>>>> Once the driver is re-loaded and RPM is enabled, I don't think it
>>>>>>>>> would use
>>>>>>>>> the same 'dev' and the corresponding ref count. Doesn't it use the
>>>>>>>>> new
>>>>>>>>> counters?
>>>>>>>>> If RPM is not working for some reason, most likely it would be the
>>>>>>>>> case
>>>>>>>>> for other
>>>>>>>>> devices. What best driver can do is probably do a force suspend
>>>>>>>>> during
>>>>>>>>> removal if
>>>>>>>>> already not done. I would prefer to keep, since multiple drivers
>>>>>>>>> still
>>>>>>>>> have it,
>>>>>>>>> unless there is a real harm in doing so.
>>>>>>>> I took a closer look and looks like the counter actually should be
>>>>>>>> reset. Still I don't think that it's a good practice to make changes
>>>>>>>> underneath of RPM, it may strike back.
>>>>>>> If RPM is broken, it probably would have been caught during device
>>>>>>> usage.
>>>>>>> I will remove explicit suspend here if no any concerns from other
>>>>>>> folks.
>>>>>>> Thanks.
>>>>>> I recall that this was the preferred way of doing this from the RPM
>>>>>> folks. Tegra30 I2S driver does the same and Stephen had pointed me to
>>>>>> this as a reference.
>>>>>> I believe that this is meant to ensure that the
>>>>>> device is always powered-off regardless of it RPM is enabled or not and
>>>>>> what the current state is.
>>>>> Yes, it was kinda actual for the case of unavailable RPM.
>>>>
>>>>> Anyways, /I think/ variant like this should have been more preferred:
>>>>>
>>>>> if (!pm_runtime_enabled(&pdev->dev))
>>>>>          tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>> else
>>>>>          pm_runtime_disable(&pdev->dev);
>>>>
>>>> I think it looks to be similar to what is there already.
>>>>
>>>> pm_runtime_disable(&pdev->dev); // it would turn out to be a dummy call
>>>> if !RPM
>>>> if (!pm_runtime_status_suspended(&pdev->dev)) // it is true always if !RPM
>>>>         tegra210_i2s_runtime_suspend(&pdev->dev);
>>>
>>> Maybe this is fine for !RPM, but not really fine in a case of enabled
>>> RPM. Device could be in resumed state after pm_runtime_disable() if it
>>> wasn't suspended before the disabling.
>>
>> I don't see any problem with this for the !RPM case.
> 
> Sorry I meant the RPM case. In other words, I don't see a problem for
> neither the RPM case of the !RPM case.

1. Device shall be in RPM-suspended state at the time of driver's
removal, unless there is a bug in the sound driver. Hence why do you
need the dead code which doesn't bring any practical value?

2. Making changes underneath of RPM is simply error-prone. It may hit
badly in the future once something will change in the RPM core.
