Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5811BC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C54E20873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kEr69vlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgBJMXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:23:02 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13834 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:23:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e414b170000>; Mon, 10 Feb 2020 04:22:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 04:23:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 04:23:01 -0800
Received: from [10.26.11.122] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 12:22:57 +0000
Subject: Re: [PATCH v2 6/9] ASoC: tegra: add Tegra186 based DSPK driver
To:     Sameer Pujar <spujar@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-7-git-send-email-spujar@nvidia.com>
 <f8ed8c4a-af40-44b2-b720-4d3a9b660fda@gmail.com>
 <75a63cb3-7d79-7216-6791-3cec57464cd9@nvidia.com>
 <847f4512-7118-e087-1004-685e476e11d8@gmail.com>
 <3c19ef99-8051-76f7-a4d6-0d61182fe6e4@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4c75fc51-fbfd-158f-a096-d4f178921ee3@nvidia.com>
Date:   Mon, 10 Feb 2020 12:22:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3c19ef99-8051-76f7-a4d6-0d61182fe6e4@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581337367; bh=Q48ZjXxd5DyM/9JMirpECQ8alliDV1CVCfS6foToQeA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kEr69vlCpsxam1NKtiahRg1il9jAuXxuZ3oT9M0TD5rImRvxPfBOHBbFNzdDwte7b
         7hxAs5gV4FlqUJH11XHtAYKHMuUCj4FkG4UVMWpltLJgODLouT3GHtseNzgaxF2g7n
         AB+P9S107xnFkO1ZO2kpe6d9pc95z4xFqlnZ04UZTo277pQ6/s6lbepsDrz/w2ujLw
         NezAMoshkD0PN+MCpvIzTTB2rWdKVorZ8zgxT/Zv9VRDXdf2bZN1EaozYlVAKT5waD
         4NZmjOlZva9xPTUPWqoNrD9TXFCDYJvvnCC51eZN8uXvN/VS7404KLEpD/azEY5ika
         msjzsMHDopLTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/02/2020 11:15, Sameer Pujar wrote:
>=20
>=20
> On 2/7/2020 11:52 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 07.02.2020 14:26, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>
>>> On 2/6/2020 10:45 PM, Dmitry Osipenko wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> 30.01.2020 13:33, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> +static const struct dev_pm_ops tegra186_dspk_pm_ops =3D {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 SET_RUNTIME_PM_OPS(tegra186_dspk_runtime_su=
spend,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 te=
gra186_dspk_runtime_resume, NULL)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_for=
ce_suspend,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_force_=
resume)
>>>>> +};
>>>> Could you please explain why drivers need the "late" system sleep?
>>> It was done to ensure core drivers are suspended first and defer the
>>> codec driver suspend
>> Suspend order is opposite to the drivers registration order. If there is
>> no real problem with that, then you should use the default suspend
>=20
>> level. Please don't try to fix a non-existent problems.
>=20
> No. This was done specifically to allow sound core to first stop any
> ongoing audio activity during normal suspend and ensure a safe suspend
> of AHUB devices by doing a LATE suspend.

What Dmitry is saying is that if the DSPK driver is registered after the
sound core then we will not need to suspend in the late phase. The DSPK
device should only be registered once the sound core is loaded, because
otherwise we should fail to register it with the sound core. So I don't
think we need this to be late afterall.

Jon

--=20
nvpublic
