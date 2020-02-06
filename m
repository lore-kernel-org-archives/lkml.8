Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB028C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17AD218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UNGce86v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBFL45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:56:57 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15793 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBFL44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:56:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3bfecd0002>; Thu, 06 Feb 2020 03:55:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 03:56:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Feb 2020 03:56:55 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Feb
 2020 11:56:50 +0000
CC:     <spujar@nvidia.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
Subject: Re: [PATCH v2 2/9] ASoC: tegra: add support for CIF programming
To:     Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-3-git-send-email-spujar@nvidia.com>
 <7239e858-16b7-609f-c4e3-8135bee8450b@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <1305a6db-a492-eec2-111e-ddc801d58d86@nvidia.com>
Date:   Thu, 6 Feb 2020 17:26:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <7239e858-16b7-609f-c4e3-8135bee8450b@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580990157; bh=iUPSM/V3A6BDAos6dKxs2BKrINIHdwVPZkEK84cY18A=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=UNGce86vrwf7dXG5TzHsshBC2TH6e5MSnJTd0nTqelKJky6+SVbyxdoLrNIywYqJx
         rhXe+cpscMFAV0uoL/m2pt3cOeQvGqlouFD/A01FtR1cKyHHS1HnsNCT0K2Bf5NcqK
         d8x7+/4ERSIGioKxr9qLmuiQ8EFkW49PPQQA4GNTJgiI732PtsthfhGWQVUPlk0tFj
         Y3GhITrPqld7KVF7lt7HYlb9MTIFrHAv2W0VLKb2KeRvTCaaBm7NjfbqdFCO3sAOkR
         ID1mc05uhPU0BNbJBHX+9UFq5aakQ4CvYCKMaLff9YIosSJ1A7Es2QKZlvrXYPsT4f
         KVHvK31ejK+Yg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/2020 10:32 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 30.01.2020 13:33, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include "tegra_cif.h"
>> +
>> +void tegra_set_cif(struct regmap *regmap, unsigned int reg,
>> +                struct tegra_cif_conf *conf)
>> +{
>> +     unsigned int value;
>> +
>> +     value =3D (conf->threshold << TEGRA_ACIF_CTRL_FIFO_TH_SHIFT) |
>> +             ((conf->audio_ch - 1) << TEGRA_ACIF_CTRL_AUDIO_CH_SHIFT) |
>> +             ((conf->client_ch - 1) << TEGRA_ACIF_CTRL_CLIENT_CH_SHIFT)=
 |
>> +             (conf->audio_bits << TEGRA_ACIF_CTRL_AUDIO_BITS_SHIFT) |
>> +             (conf->client_bits << TEGRA_ACIF_CTRL_CLIENT_BITS_SHIFT) |
>> +             (conf->expand << TEGRA_ACIF_CTRL_EXPAND_SHIFT) |
>> +             (conf->stereo_conv << TEGRA_ACIF_CTRL_STEREO_CONV_SHIFT) |
>> +             (conf->replicate << TEGRA_ACIF_CTRL_REPLICATE_SHIFT) |
>> +             (conf->truncate << TEGRA_ACIF_CTRL_TRUNCATE_SHIFT) |
>> +             (conf->mono_conv << TEGRA_ACIF_CTRL_MONO_CONV_SHIFT);
>> +
>> +     regmap_update_bits(regmap, reg, TEGRA_ACIF_UPDATE_MASK, value);
>> +}
>> +EXPORT_SYMBOL_GPL(tegra_set_cif);
> Are you going to add more stuff into this source file later on?

Yes I plan to add Tegra30 and Tegra124 CIF functions in this. Anything=20
related to CIF can be moved here.
>
> If not, then it's too much to have a separate driver module just for a
> single tiny function, you should move it into the header file (make it
> inline).

