Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F18C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94AD2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WdjJGNZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAVLwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 06:52:23 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5471 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgAVLwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:52:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2837640000>; Wed, 22 Jan 2020 03:52:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 Jan 2020 03:52:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 Jan 2020 03:52:21 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Jan
 2020 11:52:17 +0000
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Sameer Pujar <spujar@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <atalambedu@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <lgirdwood@gmail.com>, <viswanathl@nvidia.com>,
        <sharadg@nvidia.com>, <broonie@kernel.org>,
        <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rlokhande@nvidia.com>, <mkumard@nvidia.com>, <dramesh@nvidia.com>
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-5-git-send-email-spujar@nvidia.com>
 <a440d105-8db9-ecf1-3718-e58804ce14b8@gmail.com>
 <0c571858-d72c-97c2-2d6a-ead6fdde06eb@nvidia.com>
 <444731da-c4cd-8578-a732-c803eef31ef0@gmail.com>
 <bdc749bc-b62c-a041-c17c-33fd49fe8e2e@nvidia.com>
 <598fe377-5b95-d30a-eb64-89a645166d42@gmail.com>
 <3f51939d-cf4b-f69b-728a-7eb99bbae458@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <34ac1fd3-ae0f-07f2-555f-a55087a2c9dc@nvidia.com>
Date:   Wed, 22 Jan 2020 11:52:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3f51939d-cf4b-f69b-728a-7eb99bbae458@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579693926; bh=L+WKarEuaJmFD3C6XaQOv9lM1k6insdFfgdLwCP9YYM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WdjJGNZ+SKYDjmcbQLw7ufIdQm17d7TcWNRdgZG20fNLJegRVnOWw4PFuLOGPSfrh
         2beUm9Vzys0K+h84AQjGZx4cXK91lcIToww0+UsbK/8RAnU6AUIkEc1e5OWc5LIM6i
         wIMM1yCjRsdpoDCPv1rSNIVfWQjtbphOBTIRHpFw4wyGXqu67KK6d/SefllbB8F3p2
         Jy6zM5UoopaGL0SZtkoH2Np/g0Wm0PjaFU4dAsDtXZ+g3ipTtRhm5BaWPCC/qdWw5A
         npys/yOwLnsGh+qSN9ljgdNDDQZC3ySqAZPrKhgNzbZa2nfrGCboW0JFAbva3jBMU9
         abyF6R5zOlpvA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/01/2020 07:16, Sameer Pujar wrote:

...

>>>>>>> +static int tegra210_i2s_remove(struct platform_device *pdev)
>>>>>>> +{
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_disable(&pdev->dev);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (!pm_runtime_status_suspended(&pdev->d=
ev))
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>>> This breaks device's RPM refcounting if it was disabled in the activ=
e
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
>=20
> If RPM is broken, it probably would have been caught during device usage.
> I will remove explicit suspend here if no any concerns from other folks.
> Thanks.

I recall that this was the preferred way of doing this from the RPM
folks. Tegra30 I2S driver does the same and Stephen had pointed me to
this as a reference. I believe that this is meant to ensure that the
device is always powered-off regardless of it RPM is enabled or not and
what the current state is.

Now for Tegra210 (or actually 64-bit Tegra) RPM is always enabled and so
we don't need to worry about the !RPM case. However, I still don't see
the harm in this.

Jon

--=20
nvpublic
