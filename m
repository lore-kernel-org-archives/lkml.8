Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279FFC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB60208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dg+NdGs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgBTPQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:16:54 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5753 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBTPQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:16:54 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4ea29d0000>; Thu, 20 Feb 2020 07:15:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 07:16:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Feb 2020 07:16:53 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 15:16:50 +0000
Subject: Re: [PATCH v3 07/10] ASoC: tegra: add Tegra210 based ADMAIF driver
To:     Sameer Pujar <spujar@nvidia.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <viswanathl@nvidia.com>, <rlokhande@nvidia.com>,
        <dramesh@nvidia.com>, <atalambedu@nvidia.com>
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-8-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <995e806f-e5be-cb17-3660-93caa627e8e9@nvidia.com>
Date:   Thu, 20 Feb 2020 15:16:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-8-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582211741; bh=+sa5Zfhg7sZegJxxsD1lRhsDyJDuz5MxqEfd/IWF328=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dg+NdGs1RsXzpnF7JjXzRn6Uz5Vo6B5aTTATAh78j+BdqHfezmvnrTeRjOTuQKZwD
         t7kJLC04loNxljRxrK6zZh8/QVZ4AA6eZhIIYxg3iiQo03WTAakLTeKQoH87xkvStq
         f4S+b4NgfjQiUa4s8BRwqnKK0gwCzfdVOmsUV8Dhn75kO9ekEx7bHiOcapBGvrgejk
         PpdkV14X6L4EJ4hqK1gbD2fOwo6ew6sG+Jec1MEE0b6OrITbR32TW755kAmYNrszXS
         ZaeOdWdck+zyKBBvKb7zVrAV3k/8XfcABlx6sm1sRoMX0un5XbuVLopcHb0LnOCUjj
         zv92pxJVvHMng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/02/2020 06:34, Sameer Pujar wrote:
> ADMAIF is the interface between ADMA and AHUB. Each ADMA channel that
> sends/receives data to/from AHUB must intreface through an ADMAIF channel.
> ADMA channel sending data to AHUB pairs with an ADMAIF Tx channel and
> similarly ADMA channel receiving data from AHUB pairs with an ADMAIF Rx
> channel. Buffer size is configuranle for each ADMAIF channel, but currently
> SW uses default values.
> 
> This patch registers ADMAIF driver with ASoC framework. The component
> driver exposes DAPM widgets, routes and kcontrols for the device. The DAI
> driver exposes ADMAIF interfaces, which can be used to connect different
> components in the ASoC layer. Makefile and Kconfig support is added to
> allow to build the driver. The ADMAIF device can be enabled in the DT via
> "nvidia,tegra210-admaif" compatible binding.
> 
> Tegra PCM driver is updated to expose required PCM interfaces and
> snd_pcm_ops callbacks.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/tegra/Kconfig           |  12 +
>  sound/soc/tegra/Makefile          |   2 +
>  sound/soc/tegra/tegra210_admaif.c | 884 ++++++++++++++++++++++++++++++++++++++
>  sound/soc/tegra/tegra210_admaif.h | 164 +++++++
>  sound/soc/tegra/tegra_pcm.c       | 222 +++++++++-
>  sound/soc/tegra/tegra_pcm.h       |  23 +-
>  6 files changed, 1305 insertions(+), 2 deletions(-)
>  create mode 100644 sound/soc/tegra/tegra210_admaif.c
>  create mode 100644 sound/soc/tegra/tegra210_admaif.h

Aside from Randy's comment ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
