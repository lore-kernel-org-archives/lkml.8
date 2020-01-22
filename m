Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4E5C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F34724125
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iHWX8TxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgAVHQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 02:16:16 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5405 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVHQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:16:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e27f6b00000>; Tue, 21 Jan 2020 23:16:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 Jan 2020 23:16:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 Jan 2020 23:16:15 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Jan
 2020 07:16:10 +0000
CC:     <spujar@nvidia.com>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <atalambedu@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <jonathanh@nvidia.com>, <viswanathl@nvidia.com>,
        <sharadg@nvidia.com>, <broonie@kernel.org>,
        <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rlokhande@nvidia.com>, <mkumard@nvidia.com>, <dramesh@nvidia.com>
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-5-git-send-email-spujar@nvidia.com>
 <a440d105-8db9-ecf1-3718-e58804ce14b8@gmail.com>
 <0c571858-d72c-97c2-2d6a-ead6fdde06eb@nvidia.com>
 <444731da-c4cd-8578-a732-c803eef31ef0@gmail.com>
 <bdc749bc-b62c-a041-c17c-33fd49fe8e2e@nvidia.com>
 <598fe377-5b95-d30a-eb64-89a645166d42@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <3f51939d-cf4b-f69b-728a-7eb99bbae458@nvidia.com>
Date:   Wed, 22 Jan 2020 12:46:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <598fe377-5b95-d30a-eb64-89a645166d42@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579677360; bh=q6Hqy9YMgHF2zriePc5t7xoV1iQAW7z7hSGzyHNQi+A=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=iHWX8TxAEPWQAHMxnsnEpccgp3pldQW1vu2rjCXTentxBDH+5vQXzXatb6ZHUMKVB
         ScQTwjXFf0s2Av7ssM4F8cN5YrRpAgqRBnbqLzSF0VJqySersVlTpg7yIwnQJ4I/kp
         irh8ngIcJ7B55wDSXgclt9SKVz4Dwl16spDaerpg/P78xOJ+8Fz8A0Q5z4G8HJ7YRu
         QT4MD8axncFxWvVt3iIciiYnAzcvdHpkehLG9lKVEUSkUZCczLBXmGKegLZcX02F7e
         Hs1sMjaq6xqI1BIPOYrPSibIDTlAg2ZKi0jpN81te8kQQlJz+8BqC1Pn20xpr1dViE
         SwvO+fZZ3/wBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/2020 11:53 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 22.01.2020 07:32, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> [snip]
>>>>>> +static int tegra210_i2s_remove(struct platform_device *pdev)
>>>>>> +{
>>>>>> +     pm_runtime_disable(&pdev->dev);
>>>>>> +     if (!pm_runtime_status_suspended(&pdev->dev))
>>>>>> +             tegra210_i2s_runtime_suspend(&pdev->dev);
>>>>> This breaks device's RPM refcounting if it was disabled in the active
>>>>> state. This code should be removed. At most you could warn about the
>>>>> unxpected RPM state here, but it shouldn't be necessary.
>>>> I guess this was added for safety and explicit suspend keeps clock
>>>> disabled.
>>>> Not sure if ref-counting of the device matters when runtime PM is
>>>> disabled and device is removed.
>>>> I see few drivers using this way.
>>> It should matter (if I'm not missing something) because RPM should be i=
n
>>> a wrecked state once you'll try to re-load the driver's module. Likely
>>> that those few other drivers are wrong.
>>>
>>> [snip]
>> Once the driver is re-loaded and RPM is enabled, I don't think it would =
use
>> the same 'dev' and the corresponding ref count. Doesn't it use the new
>> counters?
>> If RPM is not working for some reason, most likely it would be the case
>> for other
>> devices. What best driver can do is probably do a force suspend during
>> removal if
>> already not done. I would prefer to keep, since multiple drivers still
>> have it,
>> unless there is a real harm in doing so.
> I took a closer look and looks like the counter actually should be
> reset. Still I don't think that it's a good practice to make changes
> underneath of RPM, it may strike back.

If RPM is broken, it probably would have been caught during device usage.
I will remove explicit suspend here if no any concerns from other folks.=20
Thanks.
>
>>>>>> +     int rx_fifo_th;
>>>>> Could rx_fifo_th be negative?
>>>> rx_fifo_th itself does not take negative values, explicit
>>>> typecasting> is avoided in "if" condition by declaring this as "int"
>>> Explicit typecasting isn't needed for integers.
>> What I meant was, rx_fifo_th is checked against a 'int' variable in an
>> "if" condition.
> What's the problem with comparing of unsigned with signed?

consider this example,
----
unsigned int x =3D 5;
int y =3D -1;

(x > y) is false.
----
Hence should be careful while using signed and unsigned comparisons.
>
> Besides, cif_conf.audio_ch > I2S_RX_FIFO_DEPTH can't be ever true, isn't
> it? I2S_RX_FIFO_DEPTH=3D64, channels_max=3D16

Yes true.
> Lastly, nothing stops you to make max_th unsigned.

will update.

