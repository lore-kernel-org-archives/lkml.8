Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E03C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E882071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QwVgTRUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgAXJHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:07:33 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8311 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAXJHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:07:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2ab3a20000>; Fri, 24 Jan 2020 01:06:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 Jan 2020 01:07:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 Jan 2020 01:07:32 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jan
 2020 09:07:24 +0000
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sameer Pujar <spujar@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <broonie@kernel.org>, <atalambedu@nvidia.com>, <tiwai@suse.com>,
        <viswanathl@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <mkumard@nvidia.com>,
        <dramesh@nvidia.com>
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9f73afdf-1e9a-cdbd-f972-a022d503ef51@nvidia.com>
Date:   Fri, 24 Jan 2020 09:07:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b5c581b9-17af-d004-33fb-2cc782ab820a@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579856806; bh=7aoEWgOMrsENsyCSERE4iOvClQ10ZBvAeKGx7j04F0Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QwVgTRUkTeKYuVdIF7IWb8Lx6v4QxDRL3CI5bRnrYOJwXFYDVgMmPs5XFiEQ0Qfk4
         wqx0DGl28wvYoC4xC0tkZah++mlIsfR8UrL12MvIgBntdJ0oA57208JrBcXNZRb2xF
         bxrjLt4MAxLDlMn5/rcnn5er2CGH8stTdmDBAOImYAtrUnk2DOBgU7xWuuOyBrqesr
         rOkiqEckCbQJwpbwZgu+MuDnK2VVPRFAAitb253LPKwCb3SFyUV1vjYzXrw2hosS7R
         MZciu+P9Zy8jm+skB8HZ97Q2LK9OiU77dRSKfnIM4aQj72Mnb7bHsjN/hOgGr6jHGA
         KVmJjRE4Uf0dA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/01/2020 15:16, Dmitry Osipenko wrote:
> 23.01.2020 12:22, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>>
>> On 1/22/2020 9:57 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 22.01.2020 14:52, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On 22/01/2020 07:16, Sameer Pujar wrote:
>>>>
>>>> ...
>>>>
>>>>>>>>>>> +static int tegra210_i2s_remove(struct platform_device *pdev)
>>>>>>>>>>> +{
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_disable(&pdev->dev);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (!pm_runtime_status_suspended(&pde=
v->dev))
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>>>>>> This breaks device's RPM refcounting if it was disabled in the
>>>>>>>>>> active
>>>>>>>>>> state. This code should be removed. At most you could warn
>>>>>>>>>> about the
>>>>>>>>>> unxpected RPM state here, but it shouldn't be necessary.
>>>>>>>>> I guess this was added for safety and explicit suspend keeps cloc=
k
>>>>>>>>> disabled.
>>>>>>>>> Not sure if ref-counting of the device matters when runtime PM is
>>>>>>>>> disabled and device is removed.
>>>>>>>>> I see few drivers using this way.
>>>>>>>> It should matter (if I'm not missing something) because RPM should
>>>>>>>> be in
>>>>>>>> a wrecked state once you'll try to re-load the driver's module.
>>>>>>>> Likely
>>>>>>>> that those few other drivers are wrong.
>>>>>>>>
>>>>>>>> [snip]
>>>>>>> Once the driver is re-loaded and RPM is enabled, I don't think it
>>>>>>> would use
>>>>>>> the same 'dev' and the corresponding ref count. Doesn't it use the
>>>>>>> new
>>>>>>> counters?
>>>>>>> If RPM is not working for some reason, most likely it would be the
>>>>>>> case
>>>>>>> for other
>>>>>>> devices. What best driver can do is probably do a force suspend
>>>>>>> during
>>>>>>> removal if
>>>>>>> already not done. I would prefer to keep, since multiple drivers
>>>>>>> still
>>>>>>> have it,
>>>>>>> unless there is a real harm in doing so.
>>>>>> I took a closer look and looks like the counter actually should be
>>>>>> reset. Still I don't think that it's a good practice to make changes
>>>>>> underneath of RPM, it may strike back.
>>>>> If RPM is broken, it probably would have been caught during device
>>>>> usage.
>>>>> I will remove explicit suspend here if no any concerns from other
>>>>> folks.
>>>>> Thanks.
>>>> I recall that this was the preferred way of doing this from the RPM
>>>> folks. Tegra30 I2S driver does the same and Stephen had pointed me to
>>>> this as a reference.
>>>> I believe that this is meant to ensure that the
>>>> device is always powered-off regardless of it RPM is enabled or not an=
d
>>>> what the current state is.
>>> Yes, it was kinda actual for the case of unavailable RPM.
>>
>>> Anyways, /I think/ variant like this should have been more preferred:
>>>
>>> if (!pm_runtime_enabled(&pdev->dev))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra210_i2s_runtime_s=
uspend(&pdev->dev);
>>> else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_disable(&pd=
ev->dev);
>>
>> I think it looks to be similar to what is there already.
>>
>> pm_runtime_disable(&pdev->dev); // it would turn out to be a dummy call
>> if !RPM
>> if (!pm_runtime_status_suspended(&pdev->dev)) // it is true always if !R=
PM
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra210_i2s_runtime_suspend(=
&pdev->dev);
>=20
> Maybe this is fine for !RPM, but not really fine in a case of enabled
> RPM. Device could be in resumed state after pm_runtime_disable() if it
> wasn't suspended before the disabling.

I don't see any problem with this for the !RPM case.

Jon

--=20
nvpublic
