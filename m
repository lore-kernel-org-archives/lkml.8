Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B682BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C4D206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F0MySOhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgF3EIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:08:36 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12523 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgF3EIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:08:35 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efaba610000>; Mon, 29 Jun 2020 21:06:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 29 Jun 2020 21:08:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 29 Jun 2020 21:08:35 -0700
Received: from [10.25.97.62] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 04:08:26 +0000
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
 <1e0cf6d1-bf4e-8808-5390-c8a3b7c7fe7e@nvidia.com>
 <87mu4lz6pt.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <1d7888c7-a8cc-e891-01aa-016e31cc9113@nvidia.com>
Date:   Tue, 30 Jun 2020 09:38:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87mu4lz6pt.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593490017; bh=XIVR0uF6KmslDb3mY0ekre9vEG+3ksH8GQ6MbptjlEc=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=F0MySOhe6yO6KPj5IaF6+GycjZ9dQaX6EVlNjVRiTj1KhlACYxEQT6//yLp9pflkA
         aHe5WkiyvkVh6L/nzLh+E7XoHF4jyAmHPyuLeJlb6+3icHJVe3q3uwqtGkr0+aWRxA
         k8SAqyT77QYJ7Lmxb3ndAK+ObYvOyGirdjykkoUz29JW8gtPa5uhKD+ADYmj8FKWNw
         auxoyN3jxb3A7qUW9iDp/16yau95yEt37uNl6sXeEjzdU/g7jXb/Evi3zotg5dkzNS
         xf1ivyHaHZpkEHBbev20cF72YlKBHoy4eOgv5e/8HOVN95ErgGzIy2M+hbSgsr+Mxc
         +rSBx3vbV0z5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2020 6:54 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
>
>>> Maybe base issue for multiple codec support
>>> is that simple_for_each_link() is caring first codec only ?
> (snip)
>> Ideally I wanted to remove above two lines and allow empty codec
>> list. But some users may expect the parsing to fail if no 'Codec' is
>> found in the DAI link, hence did not remove above. If it is fine to
>> remove above two lines it would be simpler. The loop inside
>> simple_for_each_link() would anyway loop for each child node of DAI
>> link and simple_dai_link_of_dpcm() can parse each 'np'.

> Current simple-card is not assuming multi Codec,
> thus, we need to update it correctly, not quick-hack.
>
> I'm not sure how to do it, but it seems we need to update
> many functions to support it, not only simple-card driver.
> For example, simple-card-utils, soc-core, etc, etc...
>
> I'm not sure, this is just my guess.
> I'm happy if we can support it more easily :)
Right now I am trying re-use simple-card driver as much as possible and 
still make it work for flexible sound cards. I will be happy to discuss 
and improve the patch wherever necessary. Please help me understand 
which part you think looks to be hacky.

> But, if it was difficult to keep compatibility on simple-card,
> we/you need to have new one.
Patch 17/23 and 18/23 introduce new compatible 'simple-cc-audio-card'. 
Idea was to use component chaining which allows connection of FE<->BE 
and multiple BE<->BE components along the DAPM path (patch 16/23). Do 
you think it would be fine?

> Actually, I had a plan to create more flexible sound card
> driver, but it is not hi priority for me in these days.
>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

