Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D40C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB862087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CnIey0gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAWJWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:22:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8095 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgAWJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:22:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2965a10000>; Thu, 23 Jan 2020 01:21:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 Jan 2020 01:22:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 Jan 2020 01:22:22 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jan
 2020 09:22:17 +0000
CC:     <spujar@nvidia.com>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <atalambedu@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <viswanathl@nvidia.com>, <sharadg@nvidia.com>,
        <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <linux-tegra@vger.kernel.org>, <rlokhande@nvidia.com>,
        <mkumard@nvidia.com>, <dramesh@nvidia.com>
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
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
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <0fc814c2-0dc6-7741-b954-463381ff7fb9@nvidia.com>
Date:   Thu, 23 Jan 2020 14:52:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1a84b393-938f-8bed-d08e-cc3bb6ed4844@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579771297; bh=W73gVUmkU4iyhPeM1GjN5RD8ETiMnoanQX2UieDd3Rw=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=CnIey0ghCRC/n4tFmo3bopQyZk5SDOV0BWv3LXEUuReEEwe10a/yb+43qvSNXNPXW
         62DxKirTbhxa1nkfJI+Z5pqNSob6hO4l5UzA/6Z9RFRUzes2XdT+VzfJaf3LoaNMgF
         OCoTqniXGmAp7+9n0IOzEwThzzcFJpruKuO16EtOY9s9bFPRkIUKklDiprGDp/z1BV
         AM13q7aA72hVd9wla4i4+k75NK157rsT5BfqoPqJPNu2u0sSlenmP8qyXqOGG6G/tm
         z/3t6CJbNoLeIOOdxP/Ddq5zG4CLB89lgnLtLLhzl2Av2qzPncJEdcMvMLav7U/Ol4
         NAHxD8YJxLOqw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/2020 9:57 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 22.01.2020 14:52, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 22/01/2020 07:16, Sameer Pujar wrote:
>>
>> ...
>>
>>>>>>>>> +static int tegra210_i2s_remove(struct platform_device *pdev)
>>>>>>>>> +{
>>>>>>>>> +     pm_runtime_disable(&pdev->dev);
>>>>>>>>> +     if (!pm_runtime_status_suspended(&pdev->dev))
>>>>>>>>> +             tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>>>> This breaks device's RPM refcounting if it was disabled in the act=
ive
>>>>>>>> state. This code should be removed. At most you could warn about t=
he
>>>>>>>> unxpected RPM state here, but it shouldn't be necessary.
>>>>>>> I guess this was added for safety and explicit suspend keeps clock
>>>>>>> disabled.
>>>>>>> Not sure if ref-counting of the device matters when runtime PM is
>>>>>>> disabled and device is removed.
>>>>>>> I see few drivers using this way.
>>>>>> It should matter (if I'm not missing something) because RPM should
>>>>>> be in
>>>>>> a wrecked state once you'll try to re-load the driver's module. Like=
ly
>>>>>> that those few other drivers are wrong.
>>>>>>
>>>>>> [snip]
>>>>> Once the driver is re-loaded and RPM is enabled, I don't think it
>>>>> would use
>>>>> the same 'dev' and the corresponding ref count. Doesn't it use the ne=
w
>>>>> counters?
>>>>> If RPM is not working for some reason, most likely it would be the ca=
se
>>>>> for other
>>>>> devices. What best driver can do is probably do a force suspend durin=
g
>>>>> removal if
>>>>> already not done. I would prefer to keep, since multiple drivers stil=
l
>>>>> have it,
>>>>> unless there is a real harm in doing so.
>>>> I took a closer look and looks like the counter actually should be
>>>> reset. Still I don't think that it's a good practice to make changes
>>>> underneath of RPM, it may strike back.
>>> If RPM is broken, it probably would have been caught during device usag=
e.
>>> I will remove explicit suspend here if no any concerns from other folks=
.
>>> Thanks.
>> I recall that this was the preferred way of doing this from the RPM
>> folks. Tegra30 I2S driver does the same and Stephen had pointed me to
>> this as a reference.
>> I believe that this is meant to ensure that the
>> device is always powered-off regardless of it RPM is enabled or not and
>> what the current state is.
> Yes, it was kinda actual for the case of unavailable RPM.

> Anyways, /I think/ variant like this should have been more preferred:
>
> if (!pm_runtime_enabled(&pdev->dev))
>          tegra210_i2s_runtime_suspend(&pdev->dev);
> else
>          pm_runtime_disable(&pdev->dev);

I think it looks to be similar to what is there already.

pm_runtime_disable(&pdev->dev); // it would turn out to be a dummy call=20
if !RPM
if (!pm_runtime_status_suspended(&pdev->dev)) // it is true always if !RPM
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra210_i2s_runtime_suspend(&p=
dev->dev);
>> Now for Tegra210 (or actually 64-bit Tegra) RPM is always enabled and so
>> we don't need to worry about the !RPM case. However, I still don't see
>> the harm in this.
> There is no real harm today, but:
>
> 1. I'd prefer to be very careful with RPM in general, based on
>     previous experience.
>
> 2. It should be a bug if device isn't RPM-suspended during
>     of driver's removal. Thus the real problem needs to be fixed
>     rather than worked around.

