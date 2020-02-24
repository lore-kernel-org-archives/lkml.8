Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D32FC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B0520732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Kp6riYbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgBXL3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:29:06 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1321 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXL3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:29:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e53b35c0000>; Mon, 24 Feb 2020 03:28:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Feb 2020 03:29:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Feb 2020 03:29:04 -0800
Received: from [10.26.11.229] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Feb
 2020 11:28:59 +0000
Subject: Re: [PATCH v3 03/10] ASoC: tegra: add Tegra210 based DMIC driver
To:     Mark Brown <broonie@kernel.org>
CC:     Sameer Pujar <spujar@nvidia.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-4-git-send-email-spujar@nvidia.com>
 <20200221130005.GD5546@sirena.org.uk>
 <316ce0d5-318d-0533-ef06-bd7e8672f893@nvidia.com>
 <20200221165535.GG5546@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <47f94534-e997-d56c-5793-ae832fb2add4@nvidia.com>
Date:   Mon, 24 Feb 2020 11:28:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221165535.GG5546@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582543709; bh=qUgfEWROPZ5NHbaz93BXjwIxn40AQzx3A83F2mD4UMA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Kp6riYbQFS4x3zgXyfXPsN6bYbX54Fntx/GCuBqqbnS0IE6/fyN+OtDghfd4BpB7P
         zjLe27l68nvPON2uD7gvad/ZVCmufdxg5wxwScrI0ksow9L4VkjQI5hKlRQJ/F/Zub
         LEbfEwVLHDfm6ReBG/qCck9VkkX+jnLJl39xeoYaYwenen8ELQ+5N8x9Qph+OZg8Ig
         EcCKu4t5zkX6rvri0dmWALx77bFUXW/HO4bdQA6+IGceTEy4FrN5LStg5r/1kgvqOd
         xuO++9PCrU+goQkxYxguIHcbGfRtguYIAtITIRhLmGI3ldjt7dmijOL1qC7dL4eZf2
         GoD1tGkiqCrHg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/02/2020 16:55, Mark Brown wrote:
> On Fri, Feb 21, 2020 at 02:31:05PM +0000, Jon Hunter wrote:
>> On 21/02/2020 13:00, Mark Brown wrote:
> 
>>>> +	srate = params_rate(params);
>>>> +	if (dmic->srate_override)
>>>> +		srate = dmic->srate_override;
> 
>>> How does this work for userspace?  If we just ignore the sample rate we
>>> were asked for I'd expect that the application would get upset.
> 
>> Tegra has a hardware sample rate converter (though driver not yet
>> upstream or part of this initial series) and if using the sample-rate
>> converter, then the actual rate captured by the DMIC interface could be
>> different from the resulting sample-rate.
> 
> The ideal thing in a component model would be to represent those sample
> rate convertors directly to usrspace so the routing and rewriting is
> explicit.

I assume that it would be OK for the sample rate converter itself to
expose mixer controls to configure its input and output rates so the
user could configure as needed?

>> So we want a way to indicate to the DMIC it is capturing at rate X,
>> while the resulting sample-rate is Y.
> 
>> I am not sure if there is a better way to do this? Ideally, the DMIC
>> would query the rate from the upstream MUX it is connected to, but I am
>> not sure if there is a way to do that. So right now it is a manual
>> process and the user has to configure these which are not ideal.
> 
> Is there any *need* for these to be user configurable?  What's normally
> happening at the minute is that either the external DAIs are fixed
> configuration and the DSP just converts everything or there's no format
> conversion done and things get passed through.

I can see that in most cases there are a finite set of configurations
that the end user may use. However, we would like to make the
configuration flexible as possible and this also allow us to test lots
of different configurations for verification purposes as well.

So a typical scenario would be ...

DMIC --> SRC --> DMA

Where SRC is the sample-rate converter. Now, the DMICs support upto
48kHz and although it maybe unlikely that someone would want to up
convert to say 96kHz, it is possible we can do this with the SRC.

So if the user executes arecord with '-r 96000', the DMIC hw_params
would return an error as this is not supported. So today we override
this. However, the best solution would be to allow the user the set the
input of the SRC and then if the DMIC output is routed via the SRC use
the SRC input rate instead of the actual rate seen/specified by the
user. So like you said in your other mail, if we could propagate the
rate information that would be ideal.

Jon

-- 
nvpublic
