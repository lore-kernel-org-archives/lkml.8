Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713B3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5009E20760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Jv2lz5H9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388969AbgF2UIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:08:51 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16982 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbgF2UIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:08:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efa24980000>; Mon, 29 Jun 2020 10:27:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Jun 2020 10:29:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Jun 2020 10:29:30 -0700
Received: from [10.25.103.164] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jun
 2020 17:29:20 +0000
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
Subject: Re: [PATCH v4 16/23] ASoC: soc-pcm: Get all BEs along DAPM path
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <1593233625-14961-17-git-send-email-spujar@nvidia.com>
 <871rly1wem.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <d45bf2fc-3baa-fd68-4d96-345ab7b99df9@nvidia.com>
Date:   Mon, 29 Jun 2020 22:59:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <871rly1wem.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593451672; bh=VngQ8+Vmfzw1t09YiyiqerLv/mWB5JEXAQux2nHccrU=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Jv2lz5H9kDXCcAWkYYs5hZM0NYd+3onwc+585S9DakRaHHx/t/LOpP+rd/KNOLsoz
         OTYjJIhz2oUDmDPaIG6xqdV1cskod1HL9KDOI5VInL+3RbBoGgOAyxNgRygOca9cr0
         pgV7//H4S4IWitR/1BCkmRU3YH4zbE7GUqHYd8NdXyHYI8KpNr8zo0VCzuWLMh21as
         0a1RA8Kmd4WT/3BRJSc7aYao9U7IuW5tmtOLV37hdQ6YB+i03Zrc7w4qEXAC4MgF+K
         GHpFGcGeQJlvHxD0oYDxJk+aoolbQ3jirK4U7mgrEVKG1RvPaW7zk/S3rl8DMx8KNc
         6pmn4s6Fc8iLg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2020 7:11 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
>
>> dpcm_end_walk_at_be() stops the graph walk when first BE is found for
>> the given FE component. In a component model we may want to connect
>> multiple DAIs from different components. A new flag is introduced in
>> 'snd_soc_card', which when set allows DAI/component chaining. Later
>> PCM operations can be called for all these listed components for a
>> valid DAPM path.
> (snip)
>> @@ -1069,6 +1069,7 @@ struct snd_soc_card {
>>        int num_of_dapm_widgets;
>>        const struct snd_soc_dapm_route *of_dapm_routes;
>>        int num_of_dapm_routes;
>> +     bool component_chaining;
> snd_soc_card has many /* bit field */ variables.
> Please use it instead of bool.

OK, will use.
>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

