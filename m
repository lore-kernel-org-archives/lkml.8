Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6634EC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF9722314
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ImzEWBmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgA0Jpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:45:45 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17685 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgA0Jpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:45:45 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2eb13a0000>; Mon, 27 Jan 2020 01:45:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 27 Jan 2020 01:45:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 27 Jan 2020 01:45:44 -0800
Received: from [10.26.11.94] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan
 2020 09:45:41 +0000
Subject: Re: [alsa-devel] [PATCH 5/9] ASoC: tegra: add Tegra210 based AHUB
 driver
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sameer Pujar <spujar@nvidia.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <atalambedu@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <lgirdwood@gmail.com>, <viswanathl@nvidia.com>,
        <sharadg@nvidia.com>, <broonie@kernel.org>,
        <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rlokhande@nvidia.com>, <mkumard@nvidia.com>, <dramesh@nvidia.com>
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-6-git-send-email-spujar@nvidia.com>
 <5ed7482e-e874-9e11-c84e-7418e4b5162e@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2c3b2533-f271-4e38-6779-d82d6da40ffd@nvidia.com>
Date:   Mon, 27 Jan 2020 09:45:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5ed7482e-e874-9e11-c84e-7418e4b5162e@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580118330; bh=LsX/gVdaQaPPnhkyvm9oZIfwSci6J3ljj8zm1g3dbd8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ImzEWBmmKcCFUsxK4kbHE1C5dluhJR8sSw3L/+ojKKvQVKf36tEAzmqk8+txj/wXo
         gBISVKDazLEn1wOTmJfzwdTjCLfLx+EwtW3X2kqEgnpNu+yN49ZZWf64BGR/a3TAPG
         KB0YoZeZYL/KIcpKnIsFxhsPbHwpeYv6m2/YlFDyg1S4u7VDRD02UpAx1viIkt5lg+
         x/rcn0VuqHIu85NvDGJJ/AL3UCMaGIGZhp0U5aJadH6B4hs7oGg0VJQusfLMp++KCd
         MSbTWmbFAwhn5lKmLcN8IihPig9ZwcjiBKR6oyRb+K5+05z91qjZRLTDHJgVX4oT75
         YnAyK2god3lGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/01/2020 01:18, Dmitry Osipenko wrote:
> 20.01.2020 17:23, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> [snip]
>> +static int tegra_ahub_get_value_enum(struct snd_kcontrol *kctl,
>> +				     struct snd_ctl_elem_value *uctl)
>> +{
>> +	struct snd_soc_component *cmpnt =3D snd_soc_dapm_kcontrol_component(kc=
tl);
>> +	struct tegra_ahub *ahub =3D snd_soc_component_get_drvdata(cmpnt);
>> +	struct soc_enum *e =3D (struct soc_enum *)kctl->private_value;
>> +	unsigned int reg, i, bit_pos =3D 0;
>> +
>> +	/*
>> +	 * Find the bit position of current MUX input.
>> +	 * If nothing is set, position would be 0 and it corresponds to 'None'=
.
>> +	 */
>> +	for (i =3D 0; i < ahub->soc_data->reg_count; i++) {
>> +		unsigned int reg_val;
>> +
>> +		reg =3D e->reg + (TEGRA210_XBAR_PART1_RX * i);
>> +		snd_soc_component_read(cmpnt, reg, &reg_val);
>> +		reg_val &=3D ahub->soc_data->mask[i];
>> +
>> +		if (reg_val) {
>> +			bit_pos =3D ffs(reg_val) +
>> +				  (8 * cmpnt->val_bytes * i);
>=20
> Multiplication takes precedence, braces are not needed. Same for all
> other occurrences in the code.

Personally, I prefer the above as it is explicit and helps readability.

Jon

--=20
nvpublic
