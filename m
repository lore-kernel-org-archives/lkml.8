Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF022C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B572A21835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1DKaRxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAWPQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:16:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33650 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgAWPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:16:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so3892706lji.0;
        Thu, 23 Jan 2020 07:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yfgpWVliAB55UTtNyKcSVyCqGSUJiB1fMDMcAEJZeJ4=;
        b=b1DKaRxvy5UqCTHxcEUKFSXo97Y9/2RMbOwH/t4jG/2WcuRn8uTUVfwF9C38fjjQEw
         dpOeDm+b4Qi/j/byQlHDO/4JcxfyxZUP6sjF/GnQDjkxPj60QcZfD8RrGM0qZ3aiYK4P
         goke2QqnkMRogN/2mvILn8YYOV5ZciFxPAH+BQg9Qs5YVpuck8R1lEJOWBsxxFZ/xlTW
         5Q31csM3tqvc/kDLg9ElOCZCBAkiQW8tVHOneHo2bRH/XkqMaY+47wRzWoyJo+/4+L+U
         mNVUrLUpg2e2+SGfj3dBSrfbOh6RzXtRTTaSlgx6hV0W4irRTlT5rAa/7HaxWL5TNsUS
         F8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yfgpWVliAB55UTtNyKcSVyCqGSUJiB1fMDMcAEJZeJ4=;
        b=J9V+029ZpyBXrbDnS8KAKt+BmmrdL5n43pysomcH54GZVV0+6vRWBgfXift9HpssN4
         0qZ3HbtvYZWo3HB9Zq2apL1J76cJhJ0RxaM04bNQY90nCsGYKAstrVOMP39ppyQvejiT
         R+ZvHuXksZs7hr1D4+31YS9AMkprXEH7l5OwUa0JSoXPV+hERk1hA0E6oOKHWVo7rBpf
         4Py62B3OPlCkFP+XC1IL5O1RSYFM1fHvhLfU3DEhXbGMwJHin/aCFoxFTInRwjlIYN8/
         j58OtkskYfxwe8Z3PUMmCfnY9HTR65z2PL4YtgW1OBBBBIPR9KtM2agtnPy4hd1rRJ4v
         4KYQ==
X-Gm-Message-State: APjAAAVaOBAs0cHTryrWzk3rdRPqs+bBlSQ04n/A9GqnVKUJvmVJgZyj
        Ju+rPeRwGxZ164/ykEJorU4=
X-Google-Smtp-Source: APXvYqwmxF98dYl23Cu+/uDH5g3hUS8mq5X/ld/eN62rkh6ei3M1OAGSxl9nV/npy89xEb/8gjTeVg==
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr23929879ljc.39.1579792563481;
        Thu, 23 Jan 2020 07:16:03 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r10sm484836ljk.99.2020.01.23.07.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 07:16:02 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Sameer Pujar <spujar@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        atalambedu@nvidia.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, viswanathl@nvidia.com, sharadg@nvidia.com,
        broonie@kernel.org, thierry.reding@gmail.com,
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
 <34ac1fd3-ae0f-07f2-555f-a55087a2c9dc@nvidia.com>
 <1a84b393-938f-8bed-d08e-cc3bb6ed4844@gmail.com>
 <0fc814c2-0dc6-7741-b954-463381ff7fb9@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b5c581b9-17af-d004-33fb-2cc782ab820a@gmail.com>
Date:   Thu, 23 Jan 2020 18:16:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <0fc814c2-0dc6-7741-b954-463381ff7fb9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.01.2020 12:22, Sameer Pujar пишет:
> 
> 
> On 1/22/2020 9:57 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 22.01.2020 14:52, Jon Hunter пишет:
>>> On 22/01/2020 07:16, Sameer Pujar wrote:
>>>
>>> ...
>>>
>>>>>>>>>> +static int tegra210_i2s_remove(struct platform_device *pdev)
>>>>>>>>>> +{
>>>>>>>>>> +     pm_runtime_disable(&pdev->dev);
>>>>>>>>>> +     if (!pm_runtime_status_suspended(&pdev->dev))
>>>>>>>>>> +             tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>>>>> This breaks device's RPM refcounting if it was disabled in the
>>>>>>>>> active
>>>>>>>>> state. This code should be removed. At most you could warn
>>>>>>>>> about the
>>>>>>>>> unxpected RPM state here, but it shouldn't be necessary.
>>>>>>>> I guess this was added for safety and explicit suspend keeps clock
>>>>>>>> disabled.
>>>>>>>> Not sure if ref-counting of the device matters when runtime PM is
>>>>>>>> disabled and device is removed.
>>>>>>>> I see few drivers using this way.
>>>>>>> It should matter (if I'm not missing something) because RPM should
>>>>>>> be in
>>>>>>> a wrecked state once you'll try to re-load the driver's module.
>>>>>>> Likely
>>>>>>> that those few other drivers are wrong.
>>>>>>>
>>>>>>> [snip]
>>>>>> Once the driver is re-loaded and RPM is enabled, I don't think it
>>>>>> would use
>>>>>> the same 'dev' and the corresponding ref count. Doesn't it use the
>>>>>> new
>>>>>> counters?
>>>>>> If RPM is not working for some reason, most likely it would be the
>>>>>> case
>>>>>> for other
>>>>>> devices. What best driver can do is probably do a force suspend
>>>>>> during
>>>>>> removal if
>>>>>> already not done. I would prefer to keep, since multiple drivers
>>>>>> still
>>>>>> have it,
>>>>>> unless there is a real harm in doing so.
>>>>> I took a closer look and looks like the counter actually should be
>>>>> reset. Still I don't think that it's a good practice to make changes
>>>>> underneath of RPM, it may strike back.
>>>> If RPM is broken, it probably would have been caught during device
>>>> usage.
>>>> I will remove explicit suspend here if no any concerns from other
>>>> folks.
>>>> Thanks.
>>> I recall that this was the preferred way of doing this from the RPM
>>> folks. Tegra30 I2S driver does the same and Stephen had pointed me to
>>> this as a reference.
>>> I believe that this is meant to ensure that the
>>> device is always powered-off regardless of it RPM is enabled or not and
>>> what the current state is.
>> Yes, it was kinda actual for the case of unavailable RPM.
> 
>> Anyways, /I think/ variant like this should have been more preferred:
>>
>> if (!pm_runtime_enabled(&pdev->dev))
>>          tegra210_i2s_runtime_suspend(&pdev->dev);
>> else
>>          pm_runtime_disable(&pdev->dev);
> 
> I think it looks to be similar to what is there already.
> 
> pm_runtime_disable(&pdev->dev); // it would turn out to be a dummy call
> if !RPM
> if (!pm_runtime_status_suspended(&pdev->dev)) // it is true always if !RPM
>         tegra210_i2s_runtime_suspend(&pdev->dev);

Maybe this is fine for !RPM, but not really fine in a case of enabled
RPM. Device could be in resumed state after pm_runtime_disable() if it
wasn't suspended before the disabling.
