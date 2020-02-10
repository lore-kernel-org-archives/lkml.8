Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEF3C3B186
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A1220842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bg+TX0Nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJLPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:15:15 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1236 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBJLPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:15:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e413b030000>; Mon, 10 Feb 2020 03:14:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 03:15:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 03:15:14 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 11:15:08 +0000
CC:     <spujar@nvidia.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
Subject: Re: [PATCH v2 6/9] ASoC: tegra: add Tegra186 based DSPK driver
To:     Dmitry Osipenko <digetx@gmail.com>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-7-git-send-email-spujar@nvidia.com>
 <f8ed8c4a-af40-44b2-b720-4d3a9b660fda@gmail.com>
 <75a63cb3-7d79-7216-6791-3cec57464cd9@nvidia.com>
 <847f4512-7118-e087-1004-685e476e11d8@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <3c19ef99-8051-76f7-a4d6-0d61182fe6e4@nvidia.com>
Date:   Mon, 10 Feb 2020 16:45:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <847f4512-7118-e087-1004-685e476e11d8@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581333251; bh=WuJ/yXuI1Dh+KZQlZCVWcQ74+5I0SnMra5tYUj5mEvo=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=bg+TX0NvBS/rnU/L9+9F0whahwkuD+eMLwfwyayTBaN9q1wi0PEeOTdUyF/B82lNn
         vRu66mZnWVm6HOu1uhchVBqVgz54ANkhaIkyXOECSAxcqtlFc57Sh34oPRnhH1o0Ka
         5j7xN1ivogH8DuQFTD1SN6lcLQ+UpHgCvZQG8ED1lISyv7xVS4njeVlVAllUf0h4cN
         8A1NrMkDvadFZQEexIu58GqRAvjYyV2nwUivJA1/CK3ZoDvZMOWlib7xM0hWnEPjc7
         kZ5KF2a8uIHthYW7zYBe49dYFx5I3iMfFojAwmlGfNsLRb8I9sjtThMHVIcMXqhKpj
         8zI6jS0qpGuew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/2020 11:52 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 07.02.2020 14:26, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 2/6/2020 10:45 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 30.01.2020 13:33, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> +static const struct dev_pm_ops tegra186_dspk_pm_ops =3D {
>>>> +     SET_RUNTIME_PM_OPS(tegra186_dspk_runtime_suspend,
>>>> +                        tegra186_dspk_runtime_resume, NULL)
>>>> +     SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>>>> +                                  pm_runtime_force_resume)
>>>> +};
>>> Could you please explain why drivers need the "late" system sleep?
>> It was done to ensure core drivers are suspended first and defer the
>> codec driver suspend
> Suspend order is opposite to the drivers registration order. If there is
> no real problem with that, then you should use the default suspend

> level. Please don't try to fix a non-existent problems.

No. This was done specifically to allow sound core to first stop any=20
ongoing audio activity during normal suspend and ensure a safe suspend=20
of AHUB devices by doing a LATE suspend.

