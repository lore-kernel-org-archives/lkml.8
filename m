Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D9CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461C121D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 03:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lsVorQu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgAXDjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:39:18 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11501 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgAXDjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 22:39:18 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2a66d60000>; Thu, 23 Jan 2020 19:39:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 Jan 2020 19:39:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 Jan 2020 19:39:17 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jan
 2020 03:39:12 +0000
CC:     <spujar@nvidia.com>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <atalambedu@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <jonathanh@nvidia.com>, <viswanathl@nvidia.com>,
        <sharadg@nvidia.com>, <broonie@kernel.org>,
        <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rlokhande@nvidia.com>, <mkumard@nvidia.com>, <dramesh@nvidia.com>
Subject: Re: [alsa-devel] [PATCH 5/9] ASoC: tegra: add Tegra210 based AHUB
 driver
To:     Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-6-git-send-email-spujar@nvidia.com>
 <5ed7482e-e874-9e11-c84e-7418e4b5162e@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <d160fa01-27d0-6290-cb16-07d159d6fbb2@nvidia.com>
Date:   Fri, 24 Jan 2020 09:09:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5ed7482e-e874-9e11-c84e-7418e4b5162e@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579837143; bh=dwNhjKvOnSDAczFsSdVJn+pMv7d1FeCSRweCtsZHiEk=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=lsVorQu1QfVVzW1W+cWsKDSidbRRqkEOkjjo0tcNH4auM8OAaxv7VFfnOxpDFT8tc
         t5fXBqNsXyYpSGSvq2gZMG2x2fwBuwEHY/Slsn64XzDBb88g63T2d434jbbwFkZLZw
         ebpOC/x6jYR4dyIEhNmyK1a2ubIR68Zt5zhPFDyd+vzLyGBbapdxZrNM/twk5WfI9w
         FRZnrpySgcYfEoRktNkz/DKv8yEpzUYA5ALJucf3SOTSUS5IZuJyKuz7sUXccczZiS
         MbwmdEAkFCuYHz+fxwHm6QKuNChtPvUr7J5XcMwcbJfF4+W3bBHmVgE+LrtjrJDPRU
         AtFzNuXWec5ag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2020 6:48 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 20.01.2020 17:23, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> [snip]
>> +static int tegra_ahub_get_value_enum(struct snd_kcontrol *kctl,
>> +                                  struct snd_ctl_elem_value *uctl)
>> +{
>> +     struct snd_soc_component *cmpnt =3D snd_soc_dapm_kcontrol_componen=
t(kctl);
>> +     struct tegra_ahub *ahub =3D snd_soc_component_get_drvdata(cmpnt);
>> +     struct soc_enum *e =3D (struct soc_enum *)kctl->private_value;
>> +     unsigned int reg, i, bit_pos =3D 0;
>> +
>> +     /*
>> +      * Find the bit position of current MUX input.
>> +      * If nothing is set, position would be 0 and it corresponds to 'N=
one'.
>> +      */
>> +     for (i =3D 0; i < ahub->soc_data->reg_count; i++) {
>> +             unsigned int reg_val;
>> +
>> +             reg =3D e->reg + (TEGRA210_XBAR_PART1_RX * i);
>> +             snd_soc_component_read(cmpnt, reg, &reg_val);
>> +             reg_val &=3D ahub->soc_data->mask[i];
>> +
>> +             if (reg_val) {
>> +                     bit_pos =3D ffs(reg_val) +
>> +                               (8 * cmpnt->val_bytes * i);
> Multiplication takes precedence, braces are not needed. Same for all
> other occurrences in the code.
>
> [snip]
>> +                     break;
>> +             }
>> +     }
>> +
>> +     /* Find index related to the item in array *_ahub_mux_texts[] */
>> +     for (i =3D 0; i < e->items; i++) {
>> +             if (bit_pos =3D=3D e->values[i]) {
>> +                     uctl->value.enumerated.item[0] =3D i;
>> +                     break;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int tegra_ahub_put_value_enum(struct snd_kcontrol *kctl,
>> +                                  struct snd_ctl_elem_value *uctl)
>> +{
>> +     struct snd_soc_component *cmpnt =3D snd_soc_dapm_kcontrol_componen=
t(kctl);
>> +     struct tegra_ahub *ahub =3D snd_soc_component_get_drvdata(cmpnt);
>> +     struct snd_soc_dapm_context *dapm =3D snd_soc_dapm_kcontrol_dapm(k=
ctl);
>> +     struct soc_enum *e =3D (struct soc_enum *)kctl->private_value;
>> +     struct snd_soc_dapm_update update[TEGRA_XBAR_UPDATE_MAX_REG] =3D {=
 };
> Shouldn't this be {0} to make array zero'ed?

Isn't it the same with empty braces?
>
> [snip]
>> +static int tegra_ahub_probe(struct platform_device *pdev)
>> +{
>> +     const struct of_device_id *match;
>> +     struct tegra_ahub *ahub;
>> +     struct tegra_ahub_soc_data *soc_data;
>> +     void __iomem *regs;
>> +     struct resource *res;
>> +     int ret;
>> +
>> +     match =3D of_match_device(tegra_ahub_of_match, &pdev->dev);
>> +     if (!match) {
>> +             dev_err(&pdev->dev, "error: no device match found\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     soc_data =3D (struct tegra_ahub_soc_data *)match->data;
> soc_data =3D device_get_match_data(&pdev->dev);

will update
>> +     ahub =3D devm_kcalloc(&pdev->dev, 1, sizeof(*ahub), GFP_KERNEL);
>> +     if (!ahub)
>> +             return -ENOMEM;
>> +
>> +     ahub->soc_data =3D soc_data;
>> +
>> +     platform_set_drvdata(pdev, ahub);
>> +
>> +     ahub->clk =3D devm_clk_get(&pdev->dev, "ahub");
>> +     if (IS_ERR(ahub->clk)) {
>> +             dev_err(&pdev->dev, "can't retrieve AHUB clock\n");
>> +             return PTR_ERR(ahub->clk);
>> +     }
>> +
>> +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +     regs =3D devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(regs))
>> +             return PTR_ERR(regs);
> regs =3D devm_platform_ioremap_resource(pdev, 0);

will update

