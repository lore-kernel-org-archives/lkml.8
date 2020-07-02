Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00780C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF00720874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JaTHyCUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgGBJ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:56:34 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2803 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGBJ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:56:34 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efdaeec0001>; Thu, 02 Jul 2020 02:54:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 02:56:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 Jul 2020 02:56:33 -0700
Received: from [10.25.97.252] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 09:56:25 +0000
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
 <49bac9c1-093c-d353-cef3-c9c3391cc00d@nvidia.com>
 <875zb6z4fq.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <c23f962a-7192-8187-39d8-18eff26e06be@nvidia.com>
Date:   Thu, 2 Jul 2020 15:26:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <875zb6z4fq.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593683692; bh=dDYuyP/VcCvHIR0JuEEZXo9QqLf+pb+8/yFvb6XxP/g=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=JaTHyCUHRSSIxrMUZwHzmEP4jaeDDaUhMyF/Vq4hBT2x86Hv7lFPDY5qyddsEe6eH
         LZ/H8+3TKvgKFHq9dYpDB13s4XKRW/icwqU/QIT6fVXsih+UdkCtxRv5ZJDR5x+nsC
         6b2eoafvPpUY7C+10Q2YadI+ycqZZU4oz54ATWoHvUUoz97m2L1TN5VsEqt3GUERU3
         QdGeVvznLbqFJIo8GXJW3cK8MTkTiRVCG515/9g89c5RkUKrRwyMIqbpBe16dznfxK
         pMGfCpvO8yW5zS8U3f0nr1Ry+Aw6ZRM+toEp3OZCuTnj66iAHEx95pTDYPTVaSgL9V
         aQ0sJJXuudzOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/2020 2:20 PM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
>
>>> I wonder component->driver->non_legacy_dai_naming can't work for you ?
>> I see currently in simple-card driver that, BE<->BE link would be
>> treated as CODEC<->CODEC link if 'non_legacy_dai_naming' flag is set
>> at both ends of BE. Do we need to set this flag for all BE?
>> However I am not sure how this will work out for a BE<->BE DPCM DAI
>> link considering the fact that I want to use chain of components and I
>> guess routing map would get complicated. Also going by the flag name
>> it was not meant to differentiate between a FE and BE?
> OK, non_legacy_dai_naming was just my quick idea.

>
> Maybe your soc_component_is_pcm() idea can work,
> but it seems a littl bit hackish for me.
> So, can you please
>
> 1) Add soc_component_is_pcm() on simple-card, not soc-core ?
>     Maybe we can move it to soc-core later,
>     but want to keep it under simple-card, so far.
>
> 2) Use it with data->component_chaining, and some comment ?
>     non component_chaining user doesn't get damage in worst case,
>     and easy to understand.
>
>          /*
>           * This is for BE<->BE connection.
>           * It needs to ...
>           * It is assumng ...
>           * Note is ...
>           */
>          if (data->component_chaining &&
>              !soc_component_is_pcm(cpus))
>                  dai_link->no_pcm = 1;
>
> 3) maybe you can reuse snd_soc_find_dai() for soc_component_is_pcm() ?
>
>          dai = snd_soc_find_dai(dlc);
>          if (dai &&
>              (dai->pcm_new || dai->component->driver->pcm_construct))
>                  return xxx

Sounds fine, I can make changes as per above points. Thanks.

>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

