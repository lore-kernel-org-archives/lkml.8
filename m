Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37D2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA30020758
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XdHGmzsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgGTERS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:17:18 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11939 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGTERS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:17:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f151ac10003>; Sun, 19 Jul 2020 21:17:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 19 Jul 2020 21:17:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 19 Jul 2020 21:17:17 -0700
Received: from [10.25.99.163] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 04:17:09 +0000
CC:     <spujar@nvidia.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 09/10] arm64: tegra: Audio graph header for Tegra210
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <1595135417-16589-1-git-send-email-spujar@nvidia.com>
 <1595135417-16589-10-git-send-email-spujar@nvidia.com>
 <871rl72gjb.wl-kuninori.morimoto.gx@renesas.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <b5484f5d-6ed4-e04b-3e62-8f4f3893ed67@nvidia.com>
Date:   Mon, 20 Jul 2020 09:47:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <871rl72gjb.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595218625; bh=lWBM6E+QzEDtmyDZPFCowyLU1JN5PwFJvJc2iSnzkRY=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=XdHGmzsL8bTrzEavdy6VRGHQjucOqIxSPTh0Gcs2yztT/WBPcnyX62goRm7gglP4E
         HQ6VzjmW6/wPxBfbEaxkAsu6Qrn0xGujlp8yn8FAweNG/mTHqn5UjDr+fCGiONiIjp
         3RPA1F4Pxct3ZhednRhm472Pw2YLhj39QWZMcM3h/MSdh9LnFMuJxozIsYbg5YiwB4
         wgE2JWD0plPzssbrRkHeg1wZ4f+dag888kCTciNMQ7QMvWFvh7n5u/SrOvdJK8d7uw
         aIfrKC1q7uyH+Oq+hR89MoAusG1fq/hwiiKr6sIvi+dE4++sbNDnk3F8w2IqGavB/R
         ZV/ZWRnLXGIoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2020 5:40 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
>
>> +&tegra_admaif {
>> +     admaif_port: port {
>> +             admaif0: endpoint@0 {
>> +                     remote-endpoint = <&xbar_admaif0>;
>> +             };
>> +             admaif1: endpoint@1 {
>> +                     remote-endpoint = <&xbar_admaif1>;
>> +             };
> (snip)
>> +             admaif8: endpoint@8 {
>> +                     remote-endpoint = <&xbar_admaif8>;
>> +             };
>> +             admaif9: endpoint@9 {
>> +                     remote-endpoint = <&xbar_admaif9>;
>> +             };
>> +     };
>> +};
> I'm not familiar with your system, so, one question.
> Does this ADMAIF has total 10 interface which is used in the same time ?
> or select one of 10 connections when use ?

One ore more ADMAIF interfaces can be used simultaneously. In fact all 
of them can be used at the same time.

>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

