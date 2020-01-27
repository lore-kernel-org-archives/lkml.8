Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67045C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3CC214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jHsIWxV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgA0FLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 00:11:21 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6506 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgA0FLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 00:11:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2e70c70003>; Sun, 26 Jan 2020 21:10:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 26 Jan 2020 21:11:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 26 Jan 2020 21:11:20 -0800
Received: from [10.25.73.144] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan
 2020 05:11:14 +0000
CC:     <spujar@nvidia.com>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <atalambedu@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <jonathanh@nvidia.com>, <viswanathl@nvidia.com>,
        <sharadg@nvidia.com>, <broonie@kernel.org>,
        <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rlokhande@nvidia.com>, <mkumard@nvidia.com>, <dramesh@nvidia.com>
Subject: Re: [alsa-devel] [PATCH 2/9] ASoC: tegra: add support for CIF
 programming
To:     Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-3-git-send-email-spujar@nvidia.com>
 <d01ed171-d949-19b2-3390-ee30eada2779@gmail.com>
 <a8409b81-7c6b-37a9-81fd-772eb2eca185@nvidia.com>
 <229def08-6bd4-30d7-056b-92329e48c699@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <34917b2d-064f-44a9-4548-ae857e8ea29b@nvidia.com>
Date:   Mon, 27 Jan 2020 10:41:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <229def08-6bd4-30d7-056b-92329e48c699@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580101831; bh=Q6yUaoXxJTOevCAJlps/t9pGjtxUfiVFCmE5POJYbT4=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=jHsIWxV51Rg6/b623cEPoy26Vm8xWFiUQDAOvxeuSq0UCOhAe6PEBL0bCHQb0d73g
         uT3PA/BHZtSli0qMdvvE/uN9dyxC97OXRuX9mAiEYi3+FpdNjq7WvwEaedohEuVEkU
         qZujM95qxrcRNpWQRYDscPYbTQkKuwUuofqHwsB5gGYJJeHj6ghhxAABCjHsGLwrGS
         /FMULN6HvwJnHSmozQ8vGQptHa4QscOyYnNvTAPWS/N0aTZ1d+egtatAMIOq6CYhyv
         wx5oWvjIH3s+uLTqcEJpwPnHT/ZspU0oA7RMuwnNg4OT/P1YsH4GOfOFtD5DsZqt/j
         F3CxkfWecvivw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2020 9:34 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 21.01.2020 07:41, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 1/20/2020 9:28 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hello Sameer,
>>>
>>> 20.01.2020 17:23, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>
>>> [snip]
>>>
>>>> Tegra30 and Tegra124 have an identical CIF programming helper function=
.
>>> [snip]
>>>
>>>> -#define TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_SHIFT  24
>>>> -#define TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK_US        0x3f
>>>> -#define TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK
>>>> (TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK_US <<
>>>> TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_SHIFT)
>>>> -
>>>> -/* Channel count minus 1 */
>>>> -#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_SHIFT   24
>>>> -#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK_US 7
>>>> -#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK
>>>> (TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK_US <<
>>>> TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_SHIFT)
>>> The AUDIOCIF_CTRL bitfields are not the same on T30 and T124, why are
>>> you claiming that programming is identical? Have you actually tried to
>>> test these patches on T30?
>> Oh yes! seems like I overlooked the macro values. Thanks for pointing
>> this. I will retain separate CIF function for Tegra30.
>> I do not have a Tegra30 board with me and hence could not test anything
>> specific to it apart from build sanity.
>> If someone can help me test I would really appreciate.
>>
> I'll help with the testing once all obvious problems will be fixed.

Thanks Dmitry. However I plan to send Tegra30 related patch separately.
In this series I will focus on Tegra210 and later.

