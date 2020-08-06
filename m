Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DC6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5512E221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MwfczHrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgHFScs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:32:48 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12369 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgHFSbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:31:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2c4a7b0000>; Thu, 06 Aug 2020 11:22:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Aug 2020 11:23:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Aug 2020 11:23:41 -0700
Received: from [10.26.73.183] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Aug
 2020 18:23:36 +0000
Subject: Re: [PATCH v5 08/11] arm64: defconfig: Build AHUB component drivers
To:     Sameer Pujar <spujar@nvidia.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>
CC:     <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>
References: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
 <1595134890-16470-9-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <eae61836-463d-4e50-36bc-c422d2094d0e@nvidia.com>
Date:   Thu, 6 Aug 2020 19:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595134890-16470-9-git-send-email-spujar@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596738171; bh=R4YM1NGHdWeT95v8E9vGiRVmOpALow/m7dTW+oS7Nzc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MwfczHrZJLUBOTJcWJJGy7Klr0mISWBuiU8W6VKd/baXDXgeUvwjIxktsP7Qu0fO8
         uQ+sLa2Ah5DnfK/TWUmxpMZVj70/e9g6Byv5hSzj5u6zSdw7lnJny24+QL7/c2Vl7D
         dyB7KSt8tUDhyPjG57Ur6YfF9JRbEXCQtS8ThY5PFDIgJUdVI63o8vR+cxg00GR/Ws
         bKJslnpnJdIIbB7qgOTJWSfwvLzfnOoIwykifPIqz+yt+YChQAsRKiCQp+sQIWDCsh
         Pw0LpFtM4g5/u7VCiPFPumP/pwzoo29Q5e0undXZ49CAVGivoGF5v+TNftPJRSI27p
         1HbCuyDoBOhgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/07/2020 06:01, Sameer Pujar wrote:
> This patch helps to build AHUB and its client drivers (I2S, DMIC,
> DSPK, ADMAIF and AHUB). These register components with ASoC core.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/configs/defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 89538d9..4976e1a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -669,6 +669,12 @@ CONFIG_SND_SOC_RK3399_GRU_SOUND=m
>  CONFIG_SND_SOC_SAMSUNG=y
>  CONFIG_SND_SOC_RCAR=m
>  CONFIG_SND_SUN4I_SPDIF=m
> +CONFIG_SND_SOC_TEGRA=m
> +CONFIG_SND_SOC_TEGRA210_AHUB=m
> +CONFIG_SND_SOC_TEGRA210_DMIC=m
> +CONFIG_SND_SOC_TEGRA210_I2S=m
> +CONFIG_SND_SOC_TEGRA186_DSPK=m
> +CONFIG_SND_SOC_TEGRA210_ADMAIF=m
>  CONFIG_SND_SOC_AK4613=m
>  CONFIG_SND_SOC_ES7134=m
>  CONFIG_SND_SOC_ES7241=m


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
