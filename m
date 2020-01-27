Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED396C35247
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE83C214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WOyBbCjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgA0FXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 00:23:08 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8270 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgA0FXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 00:23:07 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2e73840000>; Sun, 26 Jan 2020 21:22:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 26 Jan 2020 21:22:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 26 Jan 2020 21:22:26 -0800
Received: from [10.25.73.144] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan
 2020 05:22:21 +0000
CC:     <spujar@nvidia.com>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <broonie@kernel.org>,
        <atalambedu@nvidia.com>, <tiwai@suse.com>, <viswanathl@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <sharadg@nvidia.com>,
        <rlokhande@nvidia.com>, <mkumard@nvidia.com>, <dramesh@nvidia.com>
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
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
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <c6022a93-b79a-c691-1d75-d007d0b64ead@nvidia.com>
Date:   Mon, 27 Jan 2020 10:52:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <075e476a-36bb-5fee-15bc-76af4474a797@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580102532; bh=uyQ7nxDtadx0HKIFwTV9Y/Ni4jJ8RtmHuiaNgpeGCVQ=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=WOyBbCjo0xTj12FVF25Yp1r1fV1gjHMY39c/AKkvSqdoN4YQ+TmEJgCDKGkWZ8CUS
         uXfojDb95fmA49UWlns0lMxbRtb/hJoXQN1d5bvf7fxIiKhdMy0GTPJm7AxdHGbHXV
         VFToAlODWyoYIHhldt2qp4LICkvwScpCr6Qkvq2OSpSI7tURbR8etrzEjmAzAauQ/O
         G/LHqtNBTtMV5HfLqhLxc5AIyA0nojqExfW+mU5kiTOBRmO8mYafsijhf1zdvf3+a+
         9i11lAj01mx8nuiVj3R91baTa8gkSItMXFk58WRPVK4h4hW9vDXZXUeBZMcd0vIddr
         Dh1hIr4h4ZZHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2020 7:34 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 24.01.2020 12:51, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 24/01/2020 09:07, Jon Hunter wrote:
>>> On 23/01/2020 15:16, Dmitry Osipenko wrote:
>>>> 23.01.2020 12:22, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>
>>>>> On 1/22/2020 9:57 PM, Dmitry Osipenko wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> 22.01.2020 14:52, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>> On 22/01/2020 07:16, Sameer Pujar wrote:
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>>>>>>>> +static int tegra210_i2s_remove(struct platform_device *pdev=
)
>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>> +     pm_runtime_disable(&pdev->dev);
>>>>>>>>>>>>>> +     if (!pm_runtime_status_suspended(&pdev->dev))
>>>>>>>>>>>>>> +             tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>>>>>>>>> This breaks device's RPM refcounting if it was disabled in th=
e
>>>>>>>>>>>>> active
>>>>>>>>>>>>> state. This code should be removed. At most you could warn
>>>>>>>>>>>>> about the
>>>>>>>>>>>>> unxpected RPM state here, but it shouldn't be necessary.
>>>>>>>>>>>> I guess this was added for safety and explicit suspend keeps c=
lock
>>>>>>>>>>>> disabled.
>>>>>>>>>>>> Not sure if ref-counting of the device matters when runtime PM=
 is
>>>>>>>>>>>> disabled and device is removed.
>>>>>>>>>>>> I see few drivers using this way.
>>>>>>>>>>> It should matter (if I'm not missing something) because RPM sho=
uld
>>>>>>>>>>> be in
>>>>>>>>>>> a wrecked state once you'll try to re-load the driver's module.
>>>>>>>>>>> Likely
>>>>>>>>>>> that those few other drivers are wrong.
>>>>>>>>>>>
>>>>>>>>>>> [snip]
>>>>>>>>>> Once the driver is re-loaded and RPM is enabled, I don't think i=
t
>>>>>>>>>> would use
>>>>>>>>>> the same 'dev' and the corresponding ref count. Doesn't it use t=
he
>>>>>>>>>> new
>>>>>>>>>> counters?
>>>>>>>>>> If RPM is not working for some reason, most likely it would be t=
he
>>>>>>>>>> case
>>>>>>>>>> for other
>>>>>>>>>> devices. What best driver can do is probably do a force suspend
>>>>>>>>>> during
>>>>>>>>>> removal if
>>>>>>>>>> already not done. I would prefer to keep, since multiple drivers
>>>>>>>>>> still
>>>>>>>>>> have it,
>>>>>>>>>> unless there is a real harm in doing so.
>>>>>>>>> I took a closer look and looks like the counter actually should b=
e
>>>>>>>>> reset. Still I don't think that it's a good practice to make chan=
ges
>>>>>>>>> underneath of RPM, it may strike back.
>>>>>>>> If RPM is broken, it probably would have been caught during device
>>>>>>>> usage.
>>>>>>>> I will remove explicit suspend here if no any concerns from other
>>>>>>>> folks.
>>>>>>>> Thanks.
>>>>>>> I recall that this was the preferred way of doing this from the RPM
>>>>>>> folks. Tegra30 I2S driver does the same and Stephen had pointed me =
to
>>>>>>> this as a reference.
>>>>>>> I believe that this is meant to ensure that the
>>>>>>> device is always powered-off regardless of it RPM is enabled or not=
 and
>>>>>>> what the current state is.
>>>>>> Yes, it was kinda actual for the case of unavailable RPM.
>>>>>> Anyways, /I think/ variant like this should have been more preferred=
:
>>>>>>
>>>>>> if (!pm_runtime_enabled(&pdev->dev))
>>>>>>           tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>> else
>>>>>>           pm_runtime_disable(&pdev->dev);
>>>>> I think it looks to be similar to what is there already.
>>>>>
>>>>> pm_runtime_disable(&pdev->dev); // it would turn out to be a dummy ca=
ll
>>>>> if !RPM
>>>>> if (!pm_runtime_status_suspended(&pdev->dev)) // it is true always if=
 !RPM
>>>>>          tegra210_i2s_runtime_suspend(&pdev->dev);
>>>> Maybe this is fine for !RPM, but not really fine in a case of enabled
>>>> RPM. Device could be in resumed state after pm_runtime_disable() if it
>>>> wasn't suspended before the disabling.
>>> I don't see any problem with this for the !RPM case.
>> Sorry I meant the RPM case. In other words, I don't see a problem for
>> neither the RPM case of the !RPM case.
> 1. Device shall be in RPM-suspended state at the time of driver's
> removal, unless there is a bug in the sound driver. Hence why do you
> need the dead code which doesn't bring any practical value?
>
> 2. Making changes underneath of RPM is simply error-prone. It may hit
> badly in the future once something will change in the RPM core.

I think we are stretching a bit more here when there is no any real harm.
Right now it works well for both RPM and !RPM case and if we really need to
fix something in future we can fix. Since my initial inclination was keepin=
g
the code as it is and Jon also has similar thoughts, I would retain this=20
code.
Sorry Dmitry, we can fix if something comes up and many other drivers would
need this at that time.


