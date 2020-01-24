Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273CCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F2C206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Bk1vimbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388059AbgAXJvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:51:32 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8038 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388038AbgAXJva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:51:30 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2abe130000>; Fri, 24 Jan 2020 01:51:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 Jan 2020 01:51:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 24 Jan 2020 01:51:29 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jan
 2020 09:51:26 +0000
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
From:   Jon Hunter <jonathanh@nvidia.com>
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
 <9f73afdf-1e9a-cdbd-f972-a022d503ef51@nvidia.com>
Message-ID: <264d3354-8a2e-ee12-44ae-aff69213d551@nvidia.com>
Date:   Fri, 24 Jan 2020 09:51:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9f73afdf-1e9a-cdbd-f972-a022d503ef51@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579859475; bh=BhDleast9LuvQxUZx9yNqe9Bj3o/7udKwCoxfMF5oWM=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Bk1vimbW6xL2jVwyO3bsS9EMmPp9GMv3D0o09KKBs/88NO9R/NTNvb2y0qQVeobI5
         nT9rCtDZgysjY5JjLfrce5yczLEqXQzXXLuYXTCdQN6s/Xa5/PpBE58P72HpZlBhHz
         SpuYYN7iG1Uo6ftnK5RWM2ZZwyt47IJUj9ppG5mX3qV7ewtGuJlVqdGxkL+VScZ4En
         y1J6NHo07k8AStlbILkvphRCSRhTp1hQz8OWz53WaFpQBiYCvR3i03yPGETTDrfr3/
         4yPKm/H4MVIyVE3Biq7oTocZPOAO6SKojFfO3REoQt9HLy4ESP9OH19TJmEE/bI54J
         Of8r+Dj7uOBHA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/01/2020 09:07, Jon Hunter wrote:
>=20
> On 23/01/2020 15:16, Dmitry Osipenko wrote:
>> 23.01.2020 12:22, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>
>>>
>>> On 1/22/2020 9:57 PM, Dmitry Osipenko wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> 22.01.2020 14:52, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> On 22/01/2020 07:16, Sameer Pujar wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>>>>>>>> +static int tegra210_i2s_remove(struct platform_device *pdev)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_disable(&pdev->dev);
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (!pm_runtime_status_suspended(&pd=
ev->dev))
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>>>>>>> This breaks device's RPM refcounting if it was disabled in the
>>>>>>>>>>> active
>>>>>>>>>>> state. This code should be removed. At most you could warn
>>>>>>>>>>> about the
>>>>>>>>>>> unxpected RPM state here, but it shouldn't be necessary.
>>>>>>>>>> I guess this was added for safety and explicit suspend keeps clo=
ck
>>>>>>>>>> disabled.
>>>>>>>>>> Not sure if ref-counting of the device matters when runtime PM i=
s
>>>>>>>>>> disabled and device is removed.
>>>>>>>>>> I see few drivers using this way.
>>>>>>>>> It should matter (if I'm not missing something) because RPM shoul=
d
>>>>>>>>> be in
>>>>>>>>> a wrecked state once you'll try to re-load the driver's module.
>>>>>>>>> Likely
>>>>>>>>> that those few other drivers are wrong.
>>>>>>>>>
>>>>>>>>> [snip]
>>>>>>>> Once the driver is re-loaded and RPM is enabled, I don't think it
>>>>>>>> would use
>>>>>>>> the same 'dev' and the corresponding ref count. Doesn't it use the
>>>>>>>> new
>>>>>>>> counters?
>>>>>>>> If RPM is not working for some reason, most likely it would be the
>>>>>>>> case
>>>>>>>> for other
>>>>>>>> devices. What best driver can do is probably do a force suspend
>>>>>>>> during
>>>>>>>> removal if
>>>>>>>> already not done. I would prefer to keep, since multiple drivers
>>>>>>>> still
>>>>>>>> have it,
>>>>>>>> unless there is a real harm in doing so.
>>>>>>> I took a closer look and looks like the counter actually should be
>>>>>>> reset. Still I don't think that it's a good practice to make change=
s
>>>>>>> underneath of RPM, it may strike back.
>>>>>> If RPM is broken, it probably would have been caught during device
>>>>>> usage.
>>>>>> I will remove explicit suspend here if no any concerns from other
>>>>>> folks.
>>>>>> Thanks.
>>>>> I recall that this was the preferred way of doing this from the RPM
>>>>> folks. Tegra30 I2S driver does the same and Stephen had pointed me to
>>>>> this as a reference.
>>>>> I believe that this is meant to ensure that the
>>>>> device is always powered-off regardless of it RPM is enabled or not a=
nd
>>>>> what the current state is.
>>>> Yes, it was kinda actual for the case of unavailable RPM.
>>>
>>>> Anyways, /I think/ variant like this should have been more preferred:
>>>>
>>>> if (!pm_runtime_enabled(&pdev->dev))
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra210_i2s_runtime_=
suspend(&pdev->dev);
>>>> else
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_disable(&p=
dev->dev);
>>>
>>> I think it looks to be similar to what is there already.
>>>
>>> pm_runtime_disable(&pdev->dev); // it would turn out to be a dummy call
>>> if !RPM
>>> if (!pm_runtime_status_suspended(&pdev->dev)) // it is true always if !=
RPM
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tegra210_i2s_runtime_suspend=
(&pdev->dev);
>>
>> Maybe this is fine for !RPM, but not really fine in a case of enabled
>> RPM. Device could be in resumed state after pm_runtime_disable() if it
>> wasn't suspended before the disabling.
>=20
> I don't see any problem with this for the !RPM case.

Sorry I meant the RPM case. In other words, I don't see a problem for
neither the RPM case of the !RPM case.

Jon

--=20
nvpublic
