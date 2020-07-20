Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA412C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A9B20709
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TZQQOzD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgGTEOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:14:14 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19719 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGTEON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:14:13 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1519d70000>; Sun, 19 Jul 2020 21:13:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 19 Jul 2020 21:14:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 19 Jul 2020 21:14:12 -0700
Received: from [10.25.99.163] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 04:14:05 +0000
CC:     <spujar@nvidia.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 03/10] ASoC: audio-graph: Support Codec with multiple
 endpoints
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
 <1595135417-16589-4-git-send-email-spujar@nvidia.com>
 <87365n2i2z.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <870feaf2-3aa2-dbb8-f883-9b6cfcb36d82@nvidia.com>
Date:   Mon, 20 Jul 2020 09:44:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87365n2i2z.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595218391; bh=nx5lAIYmOjDB4BduiFhtKmLRJSU6RRYMWVlTJDi4E/g=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=TZQQOzD1ItvuulsVlIa1WUJnL2CkhNwOS7poO+6Z3JLe7mfSuyw4hSfeMpFQd21CS
         JJ3HoVHvh+iE6GRADC1p22/9vIGbMcunNC1+048hYcRz0J22zowoilNrZoxfNXZfd+
         tbchL+aGMtAZ7Ju8oaNI3XV7rEEdiOiKWRzqk3qyuYSVvvq50KxqfvzHtQ1J62rbiD
         TWW/BTWpr8Jshg0aNzRe6UvMNcB+VjYF4BrD4WdoD2HgF0cY/xmSfjRqqo2l6DtDrX
         RwD6efyaI4vgy198gRaVOn68x1Qh4jzZsjGqZs6d4/x8ERbWFQbj8P4rMUiuqasSZi
         BBgS3IvXcCZJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2020 5:07 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
>
>> If a Codec port has multiple endpoints, only first endpoint gets parsed
>> and remaining are ignored. This can be fixed by removing 'dup_codec' flag
>> passed to graph_dai_link_of_dpcm() and thus it loops over all endpoints
>> of Codec. Similarly graph_count_dpcm() is updated as well.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   sound/soc/generic/audio-graph-card.c | 28 +++++++++-------------------
>>   1 file changed, 9 insertions(+), 19 deletions(-)
>>
>> diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
>> index 1e20562..b1903f9 100644
>> --- a/sound/soc/generic/audio-graph-card.c
>> +++ b/sound/soc/generic/audio-graph-card.c
>> @@ -201,8 +201,7 @@ static void graph_parse_mclk_fs(struct device_node *top,
>>   static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
>>                                  struct device_node *cpu_ep,
>>                                  struct device_node *codec_ep,
>> -                               struct link_info *li,
>> -                               int dup_codec)
>> +                               struct link_info *li)
> This patch breaks DPCM connection which is used for MIXer

Could you please elaborate a bit more as to what is broken with this? 
The problem I am trying to solve here is to have multiple endpoints for 
Codec port.

>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

