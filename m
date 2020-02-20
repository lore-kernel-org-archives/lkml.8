Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD544C11D0A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68B02068F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OdHnmCRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgBTOpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:45:14 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13963 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTOpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:45:14 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4e9b6b0002>; Thu, 20 Feb 2020 06:44:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 06:45:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 06:45:13 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 14:45:10 +0000
Subject: Re: [PATCH v3 04/10] ASoC: tegra: add Tegra210 based I2S driver
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
 <1582180492-25297-5-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8b224e0f-5e69-75a4-6be1-fb7bc083bf32@nvidia.com>
Date:   Thu, 20 Feb 2020 14:45:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-5-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582209899; bh=ToZh4/TyGAmvxNYeBR1CnaphoSG1rFK0lkkCxri83P0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OdHnmCRoqtioB67vc9TZUhgUh9GReTNHyKRyE5tjc/IXkXP37oPK2DERs1ItzJlcC
         Tp8NbO0WDwEvxskGu++2Qnvc7WCT/emskqisVdxNQkQlG5oiIXutOovinGt7JNq+XE
         geoXtQVATTsQyiUSib0iSJFK7CPOMcQ458c9iZvr5xo/du8pw8e9u6x0Fhp9AnDhKd
         av4WhzWL/HZ4xjBl9+FPbzabsZXAQB4GCtQoejfAny6JXo7B+16K663y33XmmHreFs
         Fj1wkT6ZF+UBm514kW5N+CJDzcu8MpIGetazvw6UgiDQeUoX9B1K7XUtaQEKGyiqC1
         bFbFq7de4WjYg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/02/2020 06:34, Sameer Pujar wrote:
> The Inter-IC Sound (I2S) controller implements full-duplex, bi-directional
> and single direction point to point serial interface. It can interface
> with I2S compatible devices. Tegra I2S controller can operate as both
> master and slave.
> 
> This patch registers I2S controller with ASoC framework. The component
> driver exposes DAPM widgets, routes and kcontrols for the device. The DAI
> driver exposes I2S interfaces, which can be used to connect different
> components in the ASoC layer. Makefile and Kconfig support is added to
> allow to build the driver. The I2S devices can be enabled in the DT via
> "nvidia,tegra210-i2s" compatible binding.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/tegra/Kconfig        |  10 +
>  sound/soc/tegra/Makefile       |   2 +
>  sound/soc/tegra/tegra210_i2s.c | 938 +++++++++++++++++++++++++++++++++++++++++
>  sound/soc/tegra/tegra210_i2s.h | 132 ++++++
>  4 files changed, 1082 insertions(+)
>  create mode 100644 sound/soc/tegra/tegra210_i2s.c
>  create mode 100644 sound/soc/tegra/tegra210_i2s.h

Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
