Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F56CC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DCF24685
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICSLuPM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgA2DmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:42:07 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42676 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgA2DmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:42:07 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so17097808edv.9;
        Tue, 28 Jan 2020 19:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tcRoYLrQi4SqzH+L20hjDXL3Tb4tgVwmCqHebXVqDrY=;
        b=ICSLuPM7hLBxtdKwuBTZ0n62D8yc+EuKxrioec3WPfWOm9oUT8ve+gw8r3cRk7X8NP
         9cmq0wBdgX0/YM76wZXWB0bsEm9Pm50f+gjVpN7qODrQeqTlJjNmgau3jrsAvdVcOjC3
         u9DiNJeJUBn7cy0cN4rM9IFj5Buuqm/WaaMKqy3DICrhtbo45Ax9RJgiDTJzHe7CBAjj
         47FeXujeVHl2nceCZlyY+LckMIr7qbRuSDkyT4ak4a8CHBYNWfIBF3UDrwbGowVV/aR7
         u9/EYlgdXn8jjExvw2jih+3Fan8jSgm08rsR6HOrG0Lm/2hZErfsrnLO4CgMRSkKyj4S
         nSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tcRoYLrQi4SqzH+L20hjDXL3Tb4tgVwmCqHebXVqDrY=;
        b=jm0TN9OtMsbY/nH8yGiLld3oSrp8JQmB/DsBO3sRMnqEx/Xbfhqy9p4I62Pfw1RT2R
         N8A0D9ECN1/fKe6eGlQQKzUBOnVK/c2j0AbWys5lzRaZ2eE7V+/qNVla2EKpPdc3HPX9
         VEeNMlzRSYsNI9O7ti+CNHmXawI43ikAMuUMFHcJkYUeYNHCz5RLDFYkw5sfivL3IbwA
         DvqmcRRxpbPd0UvGP03ZtUjeGUH8lXhjTyK0V91535Ed99Qra6mvu7mMHD27/uXTwwF/
         1k3HDJrI07ay1yCZ/Z4XKcnnQk+7zFtHFjb6DyYTVkRk++w1OlvHflsqfFdh+mxD0SFv
         rJ+A==
X-Gm-Message-State: APjAAAWNxLMC5b6E61UUERRyH4wNBa88CEVMAuLewXNQU0KCYx4UjJfe
        ZR37Zua3K+Vtco2IQXxBbTw=
X-Google-Smtp-Source: APXvYqy1xKcZRhbwfuXwJLwnS98C7kf6ODqzfP8QqiqHImKQDSKq0PiiIRO+KNZ8+l2N0sGC3KsLWA==
X-Received: by 2002:a05:6402:17e4:: with SMTP id t4mr6182867edy.83.1580269324269;
        Tue, 28 Jan 2020 19:42:04 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e22sm68770edq.75.2020.01.28.19.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 19:42:03 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Sameer Pujar <spujar@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
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
 <075e476a-36bb-5fee-15bc-76af4474a797@gmail.com>
 <c6022a93-b79a-c691-1d75-d007d0b64ead@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3b42c858-733b-0d17-f457-8043d97f5058@gmail.com>
Date:   Wed, 29 Jan 2020 06:41:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <c6022a93-b79a-c691-1d75-d007d0b64ead@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.01.2020 08:22, Sameer Pujar пишет:
> 
> 
> On 1/24/2020 7:34 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 24.01.2020 12:51, Jon Hunter пишет:
>>> On 24/01/2020 09:07, Jon Hunter wrote:
>>>> On 23/01/2020 15:16, Dmitry Osipenko wrote:
>>>>> 23.01.2020 12:22, Sameer Pujar пишет:
>>>>>>
>>>>>> On 1/22/2020 9:57 PM, Dmitry Osipenko wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> 22.01.2020 14:52, Jon Hunter пишет:
>>>>>>>> On 22/01/2020 07:16, Sameer Pujar wrote:
>>>>>>>>
>>>>>>>> ...
>>>>>>>>
>>>>>>>>>>>>>>> +static int tegra210_i2s_remove(struct platform_device
>>>>>>>>>>>>>>> *pdev)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +     pm_runtime_disable(&pdev->dev);
>>>>>>>>>>>>>>> +     if (!pm_runtime_status_suspended(&pdev->dev))
>>>>>>>>>>>>>>> +             tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>>>>>>>>>> This breaks device's RPM refcounting if it was disabled in
>>>>>>>>>>>>>> the
>>>>>>>>>>>>>> active
>>>>>>>>>>>>>> state. This code should be removed. At most you could warn
>>>>>>>>>>>>>> about the
>>>>>>>>>>>>>> unxpected RPM state here, but it shouldn't be necessary.
>>>>>>>>>>>>> I guess this was added for safety and explicit suspend
>>>>>>>>>>>>> keeps clock
>>>>>>>>>>>>> disabled.
>>>>>>>>>>>>> Not sure if ref-counting of the device matters when runtime
>>>>>>>>>>>>> PM is
>>>>>>>>>>>>> disabled and device is removed.
>>>>>>>>>>>>> I see few drivers using this way.
>>>>>>>>>>>> It should matter (if I'm not missing something) because RPM
>>>>>>>>>>>> should
>>>>>>>>>>>> be in
>>>>>>>>>>>> a wrecked state once you'll try to re-load the driver's module.
>>>>>>>>>>>> Likely
>>>>>>>>>>>> that those few other drivers are wrong.
>>>>>>>>>>>>
>>>>>>>>>>>> [snip]
>>>>>>>>>>> Once the driver is re-loaded and RPM is enabled, I don't
>>>>>>>>>>> think it
>>>>>>>>>>> would use
>>>>>>>>>>> the same 'dev' and the corresponding ref count. Doesn't it
>>>>>>>>>>> use the
>>>>>>>>>>> new
>>>>>>>>>>> counters?
>>>>>>>>>>> If RPM is not working for some reason, most likely it would
>>>>>>>>>>> be the
>>>>>>>>>>> case
>>>>>>>>>>> for other
>>>>>>>>>>> devices. What best driver can do is probably do a force suspend
>>>>>>>>>>> during
>>>>>>>>>>> removal if
>>>>>>>>>>> already not done. I would prefer to keep, since multiple drivers
>>>>>>>>>>> still
>>>>>>>>>>> have it,
>>>>>>>>>>> unless there is a real harm in doing so.
>>>>>>>>>> I took a closer look and looks like the counter actually
>>>>>>>>>> should be
>>>>>>>>>> reset. Still I don't think that it's a good practice to make
>>>>>>>>>> changes
>>>>>>>>>> underneath of RPM, it may strike back.
>>>>>>>>> If RPM is broken, it probably would have been caught during device
>>>>>>>>> usage.
>>>>>>>>> I will remove explicit suspend here if no any concerns from other
>>>>>>>>> folks.
>>>>>>>>> Thanks.
>>>>>>>> I recall that this was the preferred way of doing this from the RPM
>>>>>>>> folks. Tegra30 I2S driver does the same and Stephen had pointed
>>>>>>>> me to
>>>>>>>> this as a reference.
>>>>>>>> I believe that this is meant to ensure that the
>>>>>>>> device is always powered-off regardless of it RPM is enabled or
>>>>>>>> not and
>>>>>>>> what the current state is.
>>>>>>> Yes, it was kinda actual for the case of unavailable RPM.
>>>>>>> Anyways, /I think/ variant like this should have been more
>>>>>>> preferred:
>>>>>>>
>>>>>>> if (!pm_runtime_enabled(&pdev->dev))
>>>>>>>           tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>>> else
>>>>>>>           pm_runtime_disable(&pdev->dev);
>>>>>> I think it looks to be similar to what is there already.
>>>>>>
>>>>>> pm_runtime_disable(&pdev->dev); // it would turn out to be a dummy
>>>>>> call
>>>>>> if !RPM
>>>>>> if (!pm_runtime_status_suspended(&pdev->dev)) // it is true always
>>>>>> if !RPM
>>>>>>          tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>> Maybe this is fine for !RPM, but not really fine in a case of enabled
>>>>> RPM. Device could be in resumed state after pm_runtime_disable() if it
>>>>> wasn't suspended before the disabling.
>>>> I don't see any problem with this for the !RPM case.
>>> Sorry I meant the RPM case. In other words, I don't see a problem for
>>> neither the RPM case of the !RPM case.
>> 1. Device shall be in RPM-suspended state at the time of driver's
>> removal, unless there is a bug in the sound driver. Hence why do you
>> need the dead code which doesn't bring any practical value?
>>
>> 2. Making changes underneath of RPM is simply error-prone. It may hit
>> badly in the future once something will change in the RPM core.
> 
> I think we are stretching a bit more here when there is no any real harm.
> Right now it works well for both RPM and !RPM case and if we really need to
> fix something in future we can fix. Since my initial inclination was
> keeping
> the code as it is and Jon also has similar thoughts, I would retain this
> code.
> Sorry Dmitry, we can fix if something comes up and many other drivers would
> need this at that time.

The !RPM case isn't supported by Tegra anymore in upstream kernel. I'm
trying to help to make yours driver better and gave you reasons to
remove the unneeded code, while you're keep saying that "there is no
harm to retain it", which is not a reason to clutter up the code. I
don't feel that it's worthwhile to continue arguing here.
