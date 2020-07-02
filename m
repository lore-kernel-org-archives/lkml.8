Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F97C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857C4207E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dgbcAyxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGBDsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 23:48:18 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8291 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGBDsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:48:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efd58cd0000>; Wed, 01 Jul 2020 20:47:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 20:48:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 20:48:16 -0700
Received: from [10.25.97.252] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 03:48:06 +0000
CC:     <spujar@nvidia.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>,
        <nwartikar@nvidia.com>, <swarren@nvidia.com>,
        <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 15/23] ASoC: soc-core: Identify 'no_pcm' DAI links for
 DPCM
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <1593233625-14961-16-git-send-email-spujar@nvidia.com>
 <87h7utytlx.wl-kuninori.morimoto.gx@renesas.com>
 <9c7871ae-6649-7b0d-4780-c8389c299b04@nvidia.com>
 <87d05ezqlc.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <49bac9c1-093c-d353-cef3-c9c3391cc00d@nvidia.com>
Date:   Thu, 2 Jul 2020 09:18:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87d05ezqlc.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593661645; bh=Oqf1zdTjnVv4xMqY49vlWn2YQFtjEyzUTTviPf0shsg=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=dgbcAyxkORD4uUkBD9tIkxdAENIWG1QJUhYTAarenLayi6aUtMJzOtPwxqdlX11aH
         zadPx+3Ks3QUFs89mSsFyx1sNuPJfCReUFPP75q6vJW+qOBg+QxZx48aixd5xqJ0HP
         NrkRa8ZYVniq52jGPIBJf2+vku+uQc6ZtJp6wxrt6PxWDpw4jns5sINzrMTwUDXZMj
         gJjX98OC4AmkOxBoWSRJT3mXDfeVcg5WcrP6EKxnJAGNzNN1N3aFZ9EBzgAMEw0qs7
         2Pyu7ezIf8iHbyz21lsLDl66vCsP4Dpz0pdQMBC5ZVA21HgkbGGP6J6NOihWIsP+3b
         YW8wiHW+MBBMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/2020 6:22 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
>
>>> At least my CPU driver doesn't use component:pcm_construct
>>> but is using DAI:pcm_new for some reasons.
>>> I'm not sure checking DAI:pcm here is enough, or not...
>> OK. If adding DAI:pcm_new above here is not sufficient, then a flag
>> can be used to describe FE component? or is there a better
>> alternative?

> soc_component_is_pcm() is called from simple_dai_link_of_dpcm :: "FE" side.

Yes I had to use this on "FE" side only because I wanted to find a real 
"FE" in FE<->BE and BE<->BE links. Please have a look at patch [23/23] 
for the sound DT binding I am using. Basically I want to connect 
multiple components in a chained fashion (FE <-> BE1 <-> BE2 ... <BEx>). 
Some of these BEs can be SoC components like resampler/mixer/mux/de-mux 
etc., the HW I am using has a cross bar which allows me to 
select/connect BEs in any order and I am trying to have the same 
flexibility here. Hence I only want to create PCM devices for real "FE" 
and trying to use simple-card as much as possible. More details about 
the HW and problems were discussed in [0].

[0] https://lkml.org/lkml/2020/4/30/519

> I wonder component->driver->non_legacy_dai_naming can't work for you ?

I see currently in simple-card driver that, BE<->BE link would be 
treated as CODEC<->CODEC link if 'non_legacy_dai_naming' flag is set at 
both ends of BE. Do we need to set this flag for all BE?
However I am not sure how this will work out for a BE<->BE DPCM DAI link 
considering the fact that I want to use chain of components and I guess 
routing map would get complicated. Also going by the flag name it was 
not meant to differentiate between a FE and BE?
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

