Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4320C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A839A2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fsLiRzQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgHYFxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:53:24 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12339 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYFxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 01:53:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f44a7130000>; Mon, 24 Aug 2020 22:52:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 22:53:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 24 Aug 2020 22:53:21 -0700
Received: from [10.25.97.151] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 05:53:15 +0000
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
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <e9698ac3-0a2e-08a2-3f78-b0be0069d6ee@nvidia.com>
Date:   Tue, 25 Aug 2020 11:23:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o8mzwajg.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598334739; bh=bOJlbPEDP7bzEfLTN1ma/hpFcaswtMKhxhFtn3X3KB0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=fsLiRzQw2KhMMRuKJolVunTD28eXxVDQEasbWsBseJFOJDgUaSFnunqKtJ3hBvnjb
         E7KH1w1J+OjQ3pxSZXZpO+ndOwCuK0G2/xn5odTxVE055PvSbW4ECgZOPS2OGsbbH7
         rOTlyUpcq+sthGswphFXGjEDvltPYqQKPUEiDY1CgM3MnLEhYtWEBV2/wZxieSF4SN
         ezxBnh4qVgtV983svcZeEKtOAZxdKwbwbVIe0utHlM7kG0Oq8ssLOsvFEAUnDYnjBO
         b/eNGzTOIAnxUbM7fpNZ8m4Rvv7XVXAdZ1hImwviKGkkc2sFPkgiMHW91zdOI1622/
         erQHqP+NaoXCg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

>>> Yes, I'm posting fixup patch.
>>>
>>>           https://patchwork.kernel.org/patch/11719919/
>> Just curious that why snd_soc_find_dai() itself cannot be protected,
>> instead of leaving this to callers.
> Because, snd_soc_find_dai() is called both with/without client_mutex.
> (same/sof are calling it with mutex, simple-card/audio-graph are calling without mutex)
>
> Other solution is create both snd_soc_find_dai_with_mutex()/without_mutex().
> I'm not sure which style is best.

I don't know how complex it is to have a unified solution. But if we can 
protect snd_soc_find_dai() itself, things would be simpler may be in 
long term. Right now there are separate source files for soc-core, 
soc-dai and soc-component, but because of two approaches looks like the 
function need to be moved around and need to be placed in soc-core. Also 
the issue might go unnoticed if LOCKDEP is not enabled.

May be start with a wrapper for now and eventually unify?

Thanks,
Sameer.

