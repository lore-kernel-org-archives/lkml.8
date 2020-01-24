Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CEFC35241
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F0022522
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sEiQb0pL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgAXD1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:27:50 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11201 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgAXD1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 22:27:49 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2a64260000>; Thu, 23 Jan 2020 19:27:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 23 Jan 2020 19:27:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 23 Jan 2020 19:27:48 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jan
 2020 03:27:43 +0000
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
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <3759aa0b-9e56-0fb4-27b7-4f98898d4e22@nvidia.com>
Date:   Fri, 24 Jan 2020 08:57:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <743d6d7d-f29c-191a-853b-414250ca38df@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579836454; bh=/uQyjMlog0EEeGCpQdgZ8NEtOXVI02tvF1e/kfKTnrw=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=sEiQb0pLX+BpSOAzxH6fhgVWwQCGYaac7UNqj2/iT9KWSfL/lLbL1cYKxNTL5Su9n
         jVnzqfyD6BquPKUbyt4eZ7xEputbu/V7DM1DeQ1i6ykizK10qMSqOxkZ7KkL5lqu7M
         Sqw0nIvrhGI/XI1tXO2GiPKi1zISexdF2jjSTXml4uUXTLF+BLRzd9bBnYi9uhGkRR
         qJJwgZD6APTXzj85AbJdM0AYs0HrmHihgX41l+nBo78QynBQ2l1qo/UmlLgkwbIce8
         ww3E5qS1uL9MZftcDu8ys4OqM20tt0exJN9WxhL97EvKsEdQ4G3bLtddszOHmyHQSQ
         gDnIoar7Q+G8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2020 6:58 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 20.01.2020 17:23, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> [snip]
>> +static bool tegra_admaif_wr_reg(struct device *dev, unsigned int reg)
>> +{
>> +     struct tegra_admaif *admaif =3D dev_get_drvdata(dev);
>> +     unsigned int ch_stride =3D TEGRA_ADMAIF_CHANNEL_REG_STRIDE;
>> +     unsigned int num_ch =3D admaif->soc_data->num_ch;
>> +     unsigned int rx_base =3D admaif->soc_data->rx_base;
>> +     unsigned int tx_base =3D admaif->soc_data->tx_base;
>> +     unsigned int global_base =3D admaif->soc_data->global_base;
>> +     unsigned int reg_max =3D admaif->soc_data->regmap_conf->max_regist=
er;
>> +     unsigned int rx_max =3D rx_base + (num_ch * ch_stride);
>> +     unsigned int tx_max =3D tx_base + (num_ch * ch_stride);
>> +
>> +     if ((reg >=3D rx_base) && (reg < rx_max)) {
> The braces are not needed around the comparisons because they precede
> the AND. Same for all other similar occurrences in the code.

While that is true, some prefer to use explicit braces to make it more=20
readable.
In the past I was told to use explicitly in such cases.

