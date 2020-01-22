Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC575C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3B02253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEtDzy3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgAVQ1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:27:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38683 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:27:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so7528199ljh.5;
        Wed, 22 Jan 2020 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gyeCH9xGtCulfFDHcJD6zCd/sMhVJQbBdrtw8jLxavk=;
        b=uEtDzy3tbP7MsHzt2WKoG6BRGtVK2Z09+1dHcrHzh7vZ/n9aqi1sVDPUD3jFHn/Fak
         F04w2Be300xT1Wx9qQWla58A82e78mL8ujsvwUrQq+oj4K6OunfdG9EtvpK8NYBJh/L0
         XOr/kW9OKoX6OmBudv8C7Mh0sOCUmprEq3fAaq3d+SiTbM6c1ZyVYhQzrM7VkJ5/odPb
         8Rj/S+FEGevAfVKwXP01EgXi479QiOacmP4NlP07jWCULhAGUX8DQaH4y5qGVMIlEq9v
         k2Oi6GXjQM/KI6+j5t+opM27PQ7WBcmP36lECVtZ+5iF5NiPpzqWtgjrUjlPIT/TZCXg
         /QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gyeCH9xGtCulfFDHcJD6zCd/sMhVJQbBdrtw8jLxavk=;
        b=FZ7mq6kYJJIIUx3/08muYuK9Lcprf5e78RPU27BEVf9XbuV/Zt+7iEE1HxCrWGzN4+
         wOd7o3I/ORH81TzF3DUU9VKQgV+k9fQtvX8l7NwETPehQxWQW6IwfFKYcHcBw2dOLF1p
         jHS4Rgf0on9ObbYVK0Viu4STZ/k2Z5Y9wgZ1sHSCvRG9eI9n6DXXnLr6+30KJIlzy0z8
         hnsf7nZ3Wx/V59Jd1C0b3GsMQT/xFeMd9f66tmbRk2c1l/leif1YdpyN2LCMBarKVzoO
         CfxHaa4PketyMcTAYFNK4nu96whGfkb8KJqlp5ClbpzXsKdcrotHbEDsDtXCDQoZFEsP
         eWqw==
X-Gm-Message-State: APjAAAV/ehQQWlfmDqaRbhYi2UWp8VRe9Wx4QY4mcmW4NgiG50CeRs8R
        fGCbhHwcGzvsUHzQu47GUi0=
X-Google-Smtp-Source: APXvYqz5ssAEa2D0DdqYDAcXynfwpquZa/aDNsc8yYqMDTfyH5s04Mr37yYctq1LnUWYEdjtXu0fDQ==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr20273717ljo.180.1579710433017;
        Wed, 22 Jan 2020 08:27:13 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id d20sm20510706ljg.95.2020.01.22.08.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 08:27:12 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Jon Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1a84b393-938f-8bed-d08e-cc3bb6ed4844@gmail.com>
Date:   Wed, 22 Jan 2020 19:27:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <34ac1fd3-ae0f-07f2-555f-a55087a2c9dc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.01.2020 14:52, Jon Hunter пишет:
> 
> On 22/01/2020 07:16, Sameer Pujar wrote:
> 
> ...
> 
>>>>>>>> +static int tegra210_i2s_remove(struct platform_device *pdev)
>>>>>>>> +{
>>>>>>>> +     pm_runtime_disable(&pdev->dev);
>>>>>>>> +     if (!pm_runtime_status_suspended(&pdev->dev))
>>>>>>>> +             tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>>> This breaks device's RPM refcounting if it was disabled in the active
>>>>>>> state. This code should be removed. At most you could warn about the
>>>>>>> unxpected RPM state here, but it shouldn't be necessary.
>>>>>> I guess this was added for safety and explicit suspend keeps clock
>>>>>> disabled.
>>>>>> Not sure if ref-counting of the device matters when runtime PM is
>>>>>> disabled and device is removed.
>>>>>> I see few drivers using this way.
>>>>> It should matter (if I'm not missing something) because RPM should
>>>>> be in
>>>>> a wrecked state once you'll try to re-load the driver's module. Likely
>>>>> that those few other drivers are wrong.
>>>>>
>>>>> [snip]
>>>> Once the driver is re-loaded and RPM is enabled, I don't think it
>>>> would use
>>>> the same 'dev' and the corresponding ref count. Doesn't it use the new
>>>> counters?
>>>> If RPM is not working for some reason, most likely it would be the case
>>>> for other
>>>> devices. What best driver can do is probably do a force suspend during
>>>> removal if
>>>> already not done. I would prefer to keep, since multiple drivers still
>>>> have it,
>>>> unless there is a real harm in doing so.
>>> I took a closer look and looks like the counter actually should be
>>> reset. Still I don't think that it's a good practice to make changes
>>> underneath of RPM, it may strike back.
>>
>> If RPM is broken, it probably would have been caught during device usage.
>> I will remove explicit suspend here if no any concerns from other folks.
>> Thanks.
> 
> I recall that this was the preferred way of doing this from the RPM
> folks. Tegra30 I2S driver does the same and Stephen had pointed me to
> this as a reference.

> I believe that this is meant to ensure that the
> device is always powered-off regardless of it RPM is enabled or not and
> what the current state is.

Yes, it was kinda actual for the case of unavailable RPM.

Anyways, /I think/ variant like this should have been more preferred:

if (!pm_runtime_enabled(&pdev->dev))
	tegra210_i2s_runtime_suspend(&pdev->dev);
else
	pm_runtime_disable(&pdev->dev);

> Now for Tegra210 (or actually 64-bit Tegra) RPM is always enabled and so
> we don't need to worry about the !RPM case. However, I still don't see
> the harm in this.

There is no real harm today, but:

1. I'd prefer to be very careful with RPM in general, based on
   previous experience.

2. It should be a bug if device isn't RPM-suspended during
   of driver's removal. Thus the real problem needs to be fixed
   rather than worked around.
