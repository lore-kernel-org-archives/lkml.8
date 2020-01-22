Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C906C24683
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UT+V8Myz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgAVK1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:27:20 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9413 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAVK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:27:19 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e28235b0000>; Wed, 22 Jan 2020 02:26:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 Jan 2020 02:27:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 Jan 2020 02:27:18 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Jan
 2020 10:27:17 +0000
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: rt5659: add S32_LE format
From:   Sameer Pujar <spujar@nvidia.com>
To:     <oder_chiou@realtek.com>, <tiwai@suse.com>, <perex@perex.cz>
References: <1579501059-27936-1-git-send-email-spujar@nvidia.com>
 <74a42452-f19c-1175-9928-da12ccad621d@nvidia.com>
Message-ID: <c700f22c-a053-7f39-dddf-41abe52cad77@nvidia.com>
Date:   Wed, 22 Jan 2020 15:57:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <74a42452-f19c-1175-9928-da12ccad621d@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579688795; bh=aOUpxcs01cAOKV7qZxiqe8Ru3nWAKUx3d66imq+9Gc8=;
        h=X-PGP-Universal:CC:Subject:From:To:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=UT+V8MyzsoZwqaheHe11ny+p2EYWQQpzLLwRbECavHI77aKmrMj65Dn2ZJEr76dpW
         1ZuCKOlYzS/9zsponl4ftlITWjxKCgTEodFSu/VQynzjMLNWmaZfUbCvqZHsBBg3q1
         RXoAYhQyoxop+j1E9E1D+MBI+bJ8pBrhQpIvNu4GXrQzAq4N4DSCmajmD98k+9z41C
         QHgp3BnGRcLtPXxRq3ht9BLAjRiirgoye/4JDP5U1dWYyJwU4B1uApuwa6RiDAnmdh
         231OeUlu+uy53fjsersCopfge1onr8U58DKu+2TvZ+X7FBHLtagI2oRk40p7ig7wT/
         tOgTGgjXiA21Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reviewers,

Kindly review. Thanks.

On 1/20/2020 11:54 AM, Sameer Pujar wrote:
> Removing Bard(bardliao@realtek.com) from "to" list since I am getting=20
> undelivered message.
>
> Oder,
> Please add right folks as you feel necessary. Thanks.
>
> On 1/20/2020 11:47 AM, Sameer Pujar wrote:
>> ALC5659 supports maximum data length of 24-bit. Currently driver=20
>> supports
>> S24_LE which is a 32-bit container with valid data in [23:0] and 0s=20
>> in MSB.
>> S24_3LE is not commonly used and is hard to find audio streams with this
>> format. Also many SoC HW do not support S24_LE and S32_LE is used in
>> general. The 24-bit data can be represented in S32_LE [31:8] and 0s are
>> padded in LSB.
>>
>> This patch adds S32_LE to ALC5659 driver and data length for this is set
>> to 24 as per codec's maximum data length support. This helps to play
>> 24-bit audio, packed in S32_LE, on HW which do not support S24_LE.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>> =C2=A0 sound/soc/codecs/rt5659.c | 4 +++-
>> =C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
>> index fc74dd63..f910ddf 100644
>> --- a/sound/soc/codecs/rt5659.c
>> +++ b/sound/soc/codecs/rt5659.c
>> @@ -3339,6 +3339,7 @@ static int rt5659_hw_params(struct=20
>> snd_pcm_substream *substream,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val_len |=3D RT56=
59_I2S_DL_20;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 24:
>> +=C2=A0=C2=A0=C2=A0 case 32:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val_len |=3D RT56=
59_I2S_DL_24;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 8:
>> @@ -3733,7 +3734,8 @@ static int rt5659_resume(struct=20
>> snd_soc_component *component)
>> =C2=A0 =C2=A0 #define RT5659_STEREO_RATES SNDRV_PCM_RATE_8000_192000
>> =C2=A0 #define RT5659_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |=20
>> SNDRV_PCM_FMTBIT_S20_3LE | \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SNDRV_PCM_FMTBIT_S24_LE | SN=
DRV_PCM_FMTBIT_S8)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SNDRV_PCM_FMTBIT_S24_LE | SN=
DRV_PCM_FMTBIT_S32_LE | \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SNDRV_PCM_FMTBIT_S8)
>> =C2=A0 =C2=A0 static const struct snd_soc_dai_ops rt5659_aif_dai_ops =3D=
 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_params =3D rt5659_hw_params,

