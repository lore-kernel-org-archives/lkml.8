Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9059FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708482076B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qB3L+FIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHCMHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:07:07 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19983 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCMHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:07:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f27fd860000>; Mon, 03 Aug 2020 05:05:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Aug 2020 05:07:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Aug 2020 05:07:03 -0700
Received: from [10.25.96.161] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Aug
 2020 12:06:55 +0000
Subject: Re: [PATCH 09/10] arm64: tegra: Audio graph header for Tegra210
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
References: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
 <1595135417-16589-10-git-send-email-spujar@nvidia.com>
 <871rl72gjb.wl-kuninori.morimoto.gx@renesas.com>
 <b5484f5d-6ed4-e04b-3e62-8f4f3893ed67@nvidia.com>
 <87pn8qzt6n.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <6a84b5f8-3e9c-96e4-c8f8-ec95ff5e42ac@nvidia.com>
Date:   Mon, 3 Aug 2020 17:36:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87pn8qzt6n.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596456326; bh=O17RBFs0E+MM0oeqpF+ZH5SzEfjMCHt248amEuAzj9c=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=qB3L+FInzKYByqbBGHPxzkO0x8F6IjpXhXmBoQ05KQ3cM/RUYKsqeVCA2r8EnWGUu
         ARTnwguioC5a73RO4UcCnSCwsy6Wi6F4Szt7/KlG1FEkQ1h9upp7+4gns2+xyfDU45
         Exg+vyrjpzzaOq/zgSCYZltBaR1IjU8iCrPTR7iXLPd04RJzaqMEzIJuakc/zPtExU
         dKiTaALqOf7Vsa3CynVZ09UVmMYJ48uuknvjNENqDKUF5iA/3dRGlae0mk2q2x+c0b
         QwHLJcSl0hbzfXAKamvjUV23qf54aUZ7wik1sklR/AQghO4eHjX/FKPZNeo+GlFmuv
         9PNtQyL4EObMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/20/2020 10:21 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
>
>>>> +&tegra_admaif {
>>>> +     admaif_port: port {
>>>> +             admaif0: endpoint@0 {
>>>> +                     remote-endpoint = <&xbar_admaif0>;
>>>> +             };
>>>> +             admaif1: endpoint@1 {
>>>> +                     remote-endpoint = <&xbar_admaif1>;
>>>> +             };
>>> (snip)
>>>> +             admaif8: endpoint@8 {
>>>> +                     remote-endpoint = <&xbar_admaif8>;
>>>> +             };
>>>> +             admaif9: endpoint@9 {
>>>> +                     remote-endpoint = <&xbar_admaif9>;
>>>> +             };
>>>> +     };
>>>> +};
>>> I'm not familiar with your system, so, one question.
>>> Does this ADMAIF has total 10 interface which is used in the same time ?
>>> or select one of 10 connections when use ?
>> One ore more ADMAIF interfaces can be used simultaneously. In fact all
>> of them can be used at the same time.
> Ah, sorry my questoin was not correct.
> I want to clarify was that below.
>
> In my understanding,
> if your system has 10 interfaces,
> you need to create 10 ports, not 10 endpoints.
> If your system has 1 interface, but is connected from 10
> devices, it has 1 port 10 endpoints.

OK, I see your point. I will work on re-organizing ports/endpoints and 
once tested will publish V2 for current series. Thanks for inputs.

>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto
