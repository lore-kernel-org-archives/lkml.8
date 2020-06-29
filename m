Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C8CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4B92065F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MGcNekim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbgF2T1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:27:17 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10620 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgF2T1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:27:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efa21d80001>; Mon, 29 Jun 2020 10:16:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Jun 2020 10:16:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Jun 2020 10:16:57 -0700
Received: from [10.25.103.164] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jun
 2020 17:16:46 +0000
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
Subject: Re: [PATCH v4 12/23] ASoC: simple-card: Support DPCM DAI link with
 multiple Codecs
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <1593233625-14961-13-git-send-email-spujar@nvidia.com>
 <874kqu1x70.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <1e0cf6d1-bf4e-8808-5390-c8a3b7c7fe7e@nvidia.com>
Date:   Mon, 29 Jun 2020 22:46:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <874kqu1x70.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593450968; bh=RaxazFJv01kl+GXduhdNNy3QB5MQDQAMcc2g7XVpJl4=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=MGcNekimPKBkOEsCk1rJkoseD42Y/vWWmtt6b9wi2eD9y3VoFNf9in23HXcZ21wb+
         +xSu+3Fcnh2ACalnQ0jNDpk4yfNjJ5YItdrjzPRc+VzZqWU+aeKkqBGzaGnun8Yf3U
         1vICpTU8MdTpr0qc6M11PgQcpJHfrzWeNRLam5xXNGQPYJDY4iGB3vz6qElZuhhYBG
         dcIx+VKnI9jE4y4iiTsMFQ1Z3HTp3bUpkPfWqmOgKZ6ew+oMNR4ELfB55KYb7xQ1gi
         REWFicJ1W6BW5uxZeJ6deYeIH7Og+0rnZlf3H3UEgA6OnefYLXCC1DMOoDg9sLsyG9
         VYGUn2BjH8TaQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2020 6:54 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
>
>> The simple-card driver supports multiple CPU and single Codec entries
>> for DPCM DAI links. In some cases it is required to have multiple
>> CPU/Codecs. Currently parsing logic for DPCM link loops over all
>> children of DAI link but assumes that there is a single Codec entry.
>> When DAI link has multiple Codecs it considers only the first Codec
>> entry and remaining Codecs are wrongly treated as CPU. This happens
>> because first Codec is used as reference for parsing all other child
>> nodes.
> (snip)
>> @@ -137,8 +136,13 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
>>         * Codec |return|Pass
>>         * np
>>         */
>> -     if (li->cpu == (np == codec))
>> -             return 0;
>> +     if (li->cpu) {
>> +             if (!strcmp(np->name, "codec"))
>> +                     return 0;
>> +     } else {
>> +             if (!strcmp(np->name, "cpu"))
>> +                     return 0;
>> +     }
> Checking node name is maybe nice idea,
> but please consider "prefix" here.

Sorry I missed that example where DAI is defined at sound level. I will 
update.
>
> Maybe base issue for multiple codec support
> is that simple_for_each_link() is caring first codec only ?

Yes that is true.
>
>          simple_for_each_link(...)
>          {
>                  ...
>                  do {
> =>                      /* get codec */
> =>                      codec = of_get_child_by_name(...);
>                          ...
>                  }
>          }
>
> Remove above and having simple_node_is_codec(np, xxx) function
> or something can help it ?

Ideally I wanted to remove above two lines and allow empty codec list. 
But some users may expect the parsing to fail if no 'Codec' is found in 
the DAI link, hence did not remove above. If it is fine to remove above 
two lines it would be simpler. The loop inside simple_for_each_link() 
would anyway loop for each child node of DAI link and 
simple_dai_link_of_dpcm() can parse each 'np'.
>
>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

