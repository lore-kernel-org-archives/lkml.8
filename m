Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5091C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E28A20CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mZbVHOUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgH2K4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:56:21 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15947 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgH2Kw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:52:26 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4a33590000>; Sat, 29 Aug 2020 03:52:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 29 Aug 2020 03:52:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 29 Aug 2020 03:52:24 -0700
Received: from [10.25.99.248] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 29 Aug
 2020 10:52:14 +0000
Subject: Re: [PATCH v2 3/9] ASoC: audio-graph: Identify 'no_pcm' DAI links for
 DPCM
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>
References: <1596605064-27748-1-git-send-email-spujar@nvidia.com>
 <1596605064-27748-4-git-send-email-spujar@nvidia.com>
 <87pn7ofs19.wl-kuninori.morimoto.gx@renesas.com>
 <97f325a6-96cc-11c5-8027-8c0a159e3da0@nvidia.com>
 <2d3aa11e-3c56-1f7a-3d41-2457f973d55b@nvidia.com>
 <87sgcbwcnf.wl-kuninori.morimoto.gx@renesas.com>
 <14691a05-cb29-a030-0e72-eca900d8eb7e@nvidia.com>
 <87o8mzwajg.wl-kuninori.morimoto.gx@renesas.com>
 <e9698ac3-0a2e-08a2-3f78-b0be0069d6ee@nvidia.com>
 <87lfi3w7hj.wl-kuninori.morimoto.gx@renesas.com>
 <f3724be2-c79d-0815-6ff5-460a4f6c10cc@nvidia.com>
 <87eentvwab.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <6c2bb431-c7d5-53b7-2f62-c1487e321680@nvidia.com>
Date:   Sat, 29 Aug 2020 16:22:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87eentvwab.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598698330; bh=z9YAEWuxCL0ZcZL6/sF4aCg5M+VV5wvIy23653SjDZc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=mZbVHOUqOGxXut6zWwsgRZ0CUbPiGk7QDGFLrWBAMMepGty8Xh28KLm2rwVEvhpUB
         Q2BwcEzoaFOnzE1pjU7+AH59VEU7ZxQc1I/QGYd/KXXLqbf8YrAue4PhepCWaBKIEz
         cDBpWWb4sB8fp62IRRIHjRoufyO35FyoCKjXDIZsdtQ+VV3ViOf+0cDLzo3cf0FHzg
         BcsOm3uobCfVAvFjrY9/3FnvHMdOblx5ZjpvAmBuV58M5GFYv+IzPlN9cqALNhsw9e
         sx3ui32biKPGCbx7rZhuwEsVUFSS+5PNIdM3vT53hniB9VsNYfod9h97MxB6V+Y8Hn
         f1FFMcjDp6/eg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

Sorry for the delayed reply as I was on sick leave.
>> Sure. BTW, there are more such candidates which require 'lock' version
>> of these helpers.
>> For example: soc_find_component(), snd_soc_add/remove_pcm_runtime()
>> and snd_soc_register_dai().
> soc_find_component() is static function, no need to care about mutex.
> other functions are indeed exported function, but is used from
> topology.c which is calling it under mutex.
>
>
I was just thinking if we need to future proof these functions. As you 
mentioned, currently these have limited usage (in topology.c) and should 
just be fine to address snd_soc_find_dai() for now.

Thanks,
Sameer.

