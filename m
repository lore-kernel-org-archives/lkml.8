Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89B3C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2532075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Sc5umqZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgHRIFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:05:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3068 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHRIFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:05:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3b8b7b0000>; Tue, 18 Aug 2020 01:04:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 01:05:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Aug 2020 01:05:09 -0700
Received: from [10.25.96.247] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 08:05:01 +0000
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
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <97f325a6-96cc-11c5-8027-8c0a159e3da0@nvidia.com>
Date:   Tue, 18 Aug 2020 13:34:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87pn7ofs19.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597737851; bh=Oi6lbenVf+d9qaNFylb6ue+c+bn4H+xbJ5ZdG5w01GY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Sc5umqZgw8m8LG4dT+NvJ1NfVxVpw9Xj6fB066rpl3kPqZ5iFDH0/mMqz0bI1S4Sh
         diqKfHmMnNbAMdMzuyzhhNif+tMIbSArvDAyZFI7O54nZWpD1OY7bjOYtWvF6Q4op9
         7/IkPuA+thy1LgsS7mZ/hugMFT4a7KFpKxkSyZ5oAaK/E9BdN4OaZheMBrKLPJKkHt
         is53Jk3Fck8jNxH0RhgNTajxJhIfex2GBm2kOO06Z/8nXBrzG8b3EFxu2TlAs45u8g
         G90C9Pqna43RNH5A1msm7Xl+ytEPKZo4o+3aJeQ7FGVA7t21ACVnNOVYF19UGL8Zw1
         9ASlmX1NbUg4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuninori,

On 8/18/2020 10:53 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi again
>
>> PCM devices are created for FE dai links with 'no-pcm' flag as '0'.
>> Such DAI links have CPU component which implement either pcm_construct()
>> or pcm_new() at component or dai level respectively. Based on this,
>> current patch exposes a helper function to identify such components
>> and populate 'no_pcm' flag for DPCM DAI link.
>>
>> This helps to have BE<->BE component links where PCM devices need
>> not be created for CPU component involved in such links.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
> (snip)
>> +static bool soc_component_is_pcm(struct snd_soc_dai_link_component *dlc)
>> +{
>> +     struct snd_soc_dai *dai = snd_soc_find_dai(dlc);
>> +
>> +     if (dai && (dai->component->driver->pcm_construct ||
>> +                 dai->driver->pcm_new))
>> +             return true;
>> +
>> +     return false;
>> +}
> This snd_soc_find_dai() will indicate WARNING
> if .config has CONFIG_LOCKDEP for me.
>
> Maybe implement it at soc-core.c with client_mutex lock
> is needed.

Thank you for testing this. I will update this in next revision.

>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto
