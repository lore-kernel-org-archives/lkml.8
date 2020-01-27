Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8589C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97C121569
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="r7zqGfrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgA0FIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 00:08:52 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6398 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgA0FIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 00:08:51 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2e70310000>; Sun, 26 Jan 2020 21:08:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 26 Jan 2020 21:08:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 26 Jan 2020 21:08:50 -0800
Received: from [10.25.73.144] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan
 2020 05:08:43 +0000
CC:     <spujar@nvidia.com>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <atalambedu@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <jonathanh@nvidia.com>, <viswanathl@nvidia.com>,
        <sharadg@nvidia.com>, <broonie@kernel.org>,
        <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rlokhande@nvidia.com>, <mkumard@nvidia.com>, <dramesh@nvidia.com>
Subject: Re: [alsa-devel] [PATCH 7/9] ASoC: tegra: add Tegra210 based ADMAIF
 driver
To:     Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-8-git-send-email-spujar@nvidia.com>
 <743d6d7d-f29c-191a-853b-414250ca38df@gmail.com>
 <3759aa0b-9e56-0fb4-27b7-4f98898d4e22@nvidia.com>
 <8a3259b7-6875-236a-b16c-cd8e023cc8b2@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <208e3f8b-75ca-9bb0-ad43-7489709fcae0@nvidia.com>
Date:   Mon, 27 Jan 2020 10:38:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8a3259b7-6875-236a-b16c-cd8e023cc8b2@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580101682; bh=LUht9Gcr7wFh+xPtTMEK2tJj/GlzVeLgVO2GrvXpTH4=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=r7zqGfrHqTIn5gRQgSMV5IVO6t8pSqTq+WbiKenqxJleVMdN9fyya9NRYRtTKyHxG
         MjhGVw8KTHShviWDQuvIHw7kj7ITLqH0Ccoz1XSSBZWj7hyJiskkKbshIES6xRtaFF
         0KooO1eM4pJ7+6xk5oe1vMe8sdaN82o/HUJ/Nn5bSjWqDMoCHltLpdosFCatZYqykc
         IESo6RZUY82fH8gMbywez8Tik4Ncpd47t62SsOPI3mmKAQNLWFxQsqqU7ptPscSJ+5
         tgvh8/OsOa1nRy2vPdMMAMKyDb/OtKlA2cATOPEDzgRU9bu+FrSiPNvn5+kMK1aMxl
         PDbr1F5GVIHhA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2020 9:55 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 24.01.2020 06:27, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 1/24/2020 6:58 AM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 20.01.2020 17:23, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> [snip]
>>>> +static bool tegra_admaif_wr_reg(struct device *dev, unsigned int reg)
>>>> +{
>>>> +     struct tegra_admaif *admaif =3D dev_get_drvdata(dev);
>>>> +     unsigned int ch_stride =3D TEGRA_ADMAIF_CHANNEL_REG_STRIDE;
>>>> +     unsigned int num_ch =3D admaif->soc_data->num_ch;
>>>> +     unsigned int rx_base =3D admaif->soc_data->rx_base;
>>>> +     unsigned int tx_base =3D admaif->soc_data->tx_base;
>>>> +     unsigned int global_base =3D admaif->soc_data->global_base;
>>>> +     unsigned int reg_max =3D
>>>> admaif->soc_data->regmap_conf->max_register;
>>>> +     unsigned int rx_max =3D rx_base + (num_ch * ch_stride);
>>>> +     unsigned int tx_max =3D tx_base + (num_ch * ch_stride);
>>>> +
>>>> +     if ((reg >=3D rx_base) && (reg < rx_max)) {
>>> The braces are not needed around the comparisons because they precede
>>> the AND. Same for all other similar occurrences in the code.
>> While that is true, some prefer to use explicit braces to make it more
>> readable.
>> In the past I was told to use explicitly in such cases.
> At least most of code in kernel (I've seen) doesn't have superfluous
> parens (the curvy thingies actually should be the braces). Readability
> is arguable in this case, I'm finding such code a bit more difficult to
> read, although in some cases parens and spacing may help to read more
> complex constructions.

Yes this is subjective and depends on the individual reading the code. It i=
s
confusing every time, for the sender, about which guideline to follow.=20
Resending
the patch/series for only this reason may not be really necessary. Since=20
I need
to fix couple of issues in this series I may consider removing the=20
explicit braces.

