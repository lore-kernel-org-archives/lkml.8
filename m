Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160D2C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3FC208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Dv5g3JHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBJLWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:22:49 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10831 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJLWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:22:49 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e413cfa0000>; Mon, 10 Feb 2020 03:22:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 03:22:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 10 Feb 2020 03:22:48 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 11:22:43 +0000
CC:     <spujar@nvidia.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
Subject: Re: [PATCH v2 0/9] add ASoC components for AHUB
To:     Dmitry Osipenko <digetx@gmail.com>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <fcab0af1-fe84-6028-701b-ab101feaa8de@gmail.com>
 <d17b2654-a888-8251-468d-12ef1451cd4b@nvidia.com>
 <40a4d544-7c33-3f28-0b9c-384bc9fe3b53@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <3cb0642f-46be-26e0-4090-f82981538a09@nvidia.com>
Date:   Mon, 10 Feb 2020 16:52:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <40a4d544-7c33-3f28-0b9c-384bc9fe3b53@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581333754; bh=D0y6xeonACafAuD+vXIgDjhVKU1a9PB64HFqz8+HmFs=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Dv5g3JHfPme0U1x/ORxA4oCce9xyttHVQXD0j5xoFs+aLm48ch9H+pAjWSuWdcWdk
         r+LsPCy2yiXMjnSbVTtZdri/kh/o9509s3MHd1nLsC2olV9tqPuEOdK0KAHXuVbDOD
         4DI0YEtWXgk+uYbREBCO1po1FmGp+cfovfajz6aPAxA0o5LNKBHfdvJ3Kl+2k9Es9g
         fGtQQ6ClCV6GH93GFDfbGY930t+a/g3rS3D1Acn6ihQMIXxopsWYt6rOSAgOqPUIpp
         vFd2r/5OeHfK7TzehQm1ISfC0xPBmXVyt/AiAYtg2YJz1c5vyk1ULhmxQXAKD0oxT5
         d2y7DBi8tyk2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/2020 11:55 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 07.02.2020 14:30, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 2/6/2020 11:06 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 30.01.2020 13:33, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> ...
>>>>    sound/soc/tegra/Kconfig                            |=C2=A0 56 ++
>>> Probably won't hurt to enable the new drivers in the
>>> arch/arm64/configs/defconfig?
>> Do you mean, if drivers can be enabled?
> Yes, I mean to enable them in the default kernel configuration.

Yes these can be enabled by default. I can push a defconfig patch, if=20
that is what you were referring in the beginning.

