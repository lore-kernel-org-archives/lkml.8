Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E426E206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qwFpHH7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgF3DsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:48:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11419 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgF3DsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:48:13 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efab59a0000>; Mon, 29 Jun 2020 20:46:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 29 Jun 2020 20:48:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 29 Jun 2020 20:48:12 -0700
Received: from [10.25.97.62] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 03:48:03 +0000
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
Subject: Re: [PATCH v4 10/23] ASoC: simple-card: Wrong daifmt for CPU end of
 DPCM DAI link
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <1593233625-14961-11-git-send-email-spujar@nvidia.com>
 <877dvq1yhy.wl-kuninori.morimoto.gx@renesas.com>
 <6e27daa5-331e-968b-4027-2e30aeb7d382@nvidia.com>
 <87o8p1z81b.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <841ac69f-1c3f-2b13-17f9-6f196811ce52@nvidia.com>
Date:   Tue, 30 Jun 2020 09:17:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87o8p1z81b.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593488794; bh=Waf+fRsBa+tnFyTsNnzSNk2rurwJRlEFA5A13c5KFMs=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=qwFpHH7QE9mC28kfCJxAzmZEE6JRNuOHvraL8M+Y1I0zQ2WHYK/Oh8u5rmuHvtNqL
         GcmVOB6EW9EOlpdfCaH4AOmTYNBxxacg/Aqt2JtYELBNEAWybmjXvu3pfb4AEyqrHY
         yYntjl5O1xuuT5F/Sh4kN2gK+PEGfeQf+KCl4vnYO0NNbx7GcryFnkzP9t1XgMNp6w
         +kXre478ipBLf7aA32L6fd0Y6QQeVQ5UhAfx1kBLrlGT0G/1FnvSypYJelewxTlkSP
         ACpFmiAhdlrKdgWY8KEQGkm7JZP3NEu8oHzSFiQf8DZKRtYw9BWJms99RTFKLDDhT7
         ThgNFlWVXU8Ag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2020 6:26 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
>
>>   snd_soc_runtime_set_dai_fmt() {
>>       ...
>>
>>       if (cpu_dai->component->driver->non_legacy_dai_naming)
>>           fmt = inv_dai_fmt;
>>
>>       ...
>>   }
>>
>> Above flips polarity for 'cpu_dai' if 'non_legacy_dai_naming' flag is set.
>>
>> 1. Hence example mentioned in the commit message does not work if my 'cpu_dai'
>> driver does not have this flag set.
> ?
> Do you want fo flip it ? or don't flip?
> It is for Codec <-> Codec connection.

For DPCM links I don't want to flip based on one Codec reference. My 
goal was to make the binding work for multiple CPU/Codec link. Hence I 
thought it would be better to explicitly describe the 'Master' DAI. We 
can eventually get rid of 'codec' argument from simple_dai_link_of_dpcm().
>> 2. While it is true that we consider reference of 'Codec' mode for simple CPU<->
>> Codec DAI links, for DPCM this does not seem flexible. For DPCM links CPU and
>> Codec are not directly connected (CPU<->Dummy or Dummy<->Codec). Please
>> consider, for example, if the DAI link has multiple CPU/Codecs. Which 'Codec'
>> reference needs to be considered? Isn't it better if we explicitly mention which
>> DAI we want to operate as 'Master'?
> I think Lars-Peter has (had ?) plan for this SND_SOC_DAIFMT_CBx_CFx
> flag flexibility ? Yes maybe it is needed for multi CPU/Codec system.
>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

