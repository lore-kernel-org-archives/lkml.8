Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50458C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E7A246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MMBLwFsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgB1Had (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:30:33 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1711 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgB1Had (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:30:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e58c1480000>; Thu, 27 Feb 2020 23:29:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Feb 2020 23:30:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Feb 2020 23:30:32 -0800
Received: from [10.25.72.245] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Feb
 2020 07:30:27 +0000
Subject: Re: Re: [PATCH v3 03/10] ASoC: tegra: add Tegra210 based DMIC driver
To:     Mark Brown <broonie@kernel.org>, Sameer Pujar <spujar@nvidia.com>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-4-git-send-email-spujar@nvidia.com>
 <20200221130005.GD5546@sirena.org.uk>
From:   Viswanath L <viswanathl@nvidia.com>
Message-ID: <1e450c5c-ea8a-1310-38d6-7f8f26c4cab0@nvidia.com>
Date:   Fri, 28 Feb 2020 13:00:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221130005.GD5546@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582874952; bh=4kZVOrzuVxGsciGvo4kiUXAzqPqE+iXtKlxdYPsdjB8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=MMBLwFsfMCG8oO5+ak8hn3OsHMNQ54b8pQdDvVT36Po6wnFWLE4dwcLgjAzb6apG+
         7MPSDuuqI0+FSpJ2c8/+nOcoamXzIL+Ob36KJPzqaGcgmnvhV3KYnkgVmsTlUW8lN9
         mOBO4YDoEiHt3ZFxTUUKxZgxWLsKWSvlSrAjnEt1PWL/4gUu9HnGB5bFUH3RRsnZk5
         Ab9OCODKpTXWG4/F8Rt3VYW5y7GcUFWAlC+5c4b7tZkXbzDhrCmEBNr8Ktd279xl6M
         f/PmkLaXo4AMyPBkNqf3Loy5I0PFhDjaCyaj2uxyMe+Yib8Zyn1rOlEw5MDepUZIYw
         k5mMZiTvSTV2Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/21/2020 6:30 PM, Mark Brown wrote:
> On Thu, Feb 20, 2020 at 12:04:45PM +0530, Sameer Pujar wrote:
>
>> +++ b/sound/soc/tegra/tegra210_dmic.c
>> @@ -0,0 +1,515 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * tegra210_dmic.c - Tegra210 DMIC driver
>> + *
>> + * Copyright (c) 2020 NVIDIA CORPORATION.  All rights reserved.
> Please make the entire comment a C++ one so things look more
> intentional.
>
>> +	/* Below enables all filters - DCR, LP and SC */
>> +	{ TEGRA210_DMIC_DBG_CTRL, 0xe },
> So this isn't the hardware default?
No, the HW default is 0x2. Also, we are repurposing the LP filter for 
applying gain.
>
>> +	srate = params_rate(params);
>> +	if (dmic->srate_override)
>> +		srate = dmic->srate_override;
> How does this work for userspace?  If we just ignore the sample rate we
> were asked for I'd expect that the application would get upset.
>
>> +	if (strstr(kcontrol->id.name, "Boost Gain"))
>> +		dmic->boost_gain = value;
> Volume controls should end in "Volume".
>
>> +	else if (strstr(kcontrol->id.name, "Audio Channels"))
>> +		dmic->audio_ch_override = value;
> This is something that would usually come from hw_params?
Yes, hw_params is where it is taken from. The additional override is 
optional and would not usually need to be set by user. However, we have 
certain other modules, like multiplexer and demultiplexer (proposed to 
be upstreamed in the near future), where no. of channels get changed at 
the output. When one or more such modules are connected in the path, 
hw_params does not reflect the channels post multiplex/demultiplex, 
hence this override would be needed.
>
>> +	else if (strstr(kcontrol->id.name, "LR Polarity Select"))
>> +		dmic->lrsel = value;
> This and some of the others look like they're describing details of how
> the board is wired up so I'd not expect them to be runtime selectable?
No, these are not board wiring. OSR, polarity, etc. are configurable 
within the DMIC (within Tegra). Of course, these controls are optional 
and the default works just fine. Also, to clarify here, 'runtime 
selectable' does not mean these parameters can be modified while a 
recording session is in progress. These parameters (optional) need to 
set up before a session is started. User can close the recording, 
reconfigure the parameters, then start a new session, without needing 
reboot.
>
>> +	SND_SOC_DAPM_MIC("Dummy Input", NULL),
> This is just the microphone that happens to be attached, isn't it?  If
> so that's a weird name.
It is not necessary for an actual mic to be connected to the pin. 
Recording will work even when the pin is left open, capture being 
silence. All the drivers, whether for playback or for capture, work OK 
even without any physical end-point, hence the "dummy" I/O.
>
>> +static const char * const tegra210_dmic_mono_conv_text[] = {
>> +	"ZERO", "COPY",
>> +};
> It'd be more idiomatic for ALSA to write these as Zero and Copy.
>
>> +	SOC_ENUM_EXT("Channel Select", tegra210_dmic_ch_enum,
>> +		     tegra210_dmic_get_control, tegra210_dmic_put_control),
>> +	SOC_ENUM_EXT("Mono To Stereo",
>> +		     tegra210_dmic_mono_conv_enum, tegra210_dmic_get_control,
>> +		     tegra210_dmic_put_control),
>> +	SOC_ENUM_EXT("Stereo To Mono",
>> +		     tegra210_dmic_stereo_conv_enum, tegra210_dmic_get_control,
>> +		     tegra210_dmic_put_control),
> I'd expect these to be in DAPM.
These are finer controls and I would guess are outside what can be 
described by DAPM. E.g. - say the user wants mono capture, but the board 
has stereo mics connected. Default configuration is that the Left 
channel would be propagated. The stereo_to_mono option offers additional 
control - to select the Right channel, or mix L and R into one. As 
mentioned earlier, much of the controls here are not necessary to be set 
for a basic use case to work. These are advanced settings.
