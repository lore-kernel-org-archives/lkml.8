Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53BCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8957820723
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="odNGbTWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgGFSJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:09:26 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4612 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgGFSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:09:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f03689f0000>; Mon, 06 Jul 2020 11:08:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Jul 2020 11:09:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Jul 2020 11:09:25 -0700
Received: from [10.26.72.33] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 18:09:20 +0000
Subject: Re: [PATCH] arm64: tegra: Re-order PCIe aperture mappings
To:     Vidya Sagar <vidyas@nvidia.com>, <robh+dt@kernel.org>,
        <treding@nvidia.com>, <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <amurray@thegoodpenguin.co.uk>,
        <bhelgaas@google.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200706171454.11316-1-vidyas@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d7e37f3c-9d4c-a12d-bd29-df12f5ffb26d@nvidia.com>
Date:   Mon, 6 Jul 2020 19:09:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200706171454.11316-1-vidyas@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594058912; bh=T8ZsPViLfuGLPzyA2wQu8w+RoLUkmnwNsf817BwziWU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=odNGbTWl99yvu3yH2HSm5JuT/vdKuM9eMXPtaxkZiVaLbokbw5iI/Vbz8QHqntrRY
         sGwhB2jM0nYTQlwt74zlp83rCo3tbXvGGLtIs50GrP3uXS4JgyTXFngmCva2vud+0a
         zzdOYv1uVsh/HT6EwaAdxiRqcpP+eUw/imGPpp23NjyiD4rddItR1ovv9CI1ljEWRs
         V0deuvQMj0ayM+nZ2BAU6Z3RdaVKgBwABs0bBdh3qaKFpHFZRCWWVSr16zIDNIi/05
         9PMsraBbTTOtADD6U5kn7Q1mqe14m/5T+HALPGQctDxJ0AvZFKTwXkCPxkDmhyQAXf
         OiwTpYIYEvb+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/07/2020 18:14, Vidya Sagar wrote:
> Re-order Tegra194's PCIe aperture mappings to have IO window moved to
> 64-bit aperture and have the entire 32-bit aperture used for accessing
> the configuration space. This makes it to use the entire 32MB of the 32-bit
> aperture for ECAM purpose while booting through ACPI.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 36 ++++++++++++------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index 4bc187a4eacd..2b378fa06d19 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -1404,9 +1404,9 @@
>  		nvidia,aspm-l0s-entrance-latency-us = <3>;
>  
>  		bus-range = <0x0 0xff>;
> -		ranges = <0x81000000 0x0  0x30100000 0x0  0x30100000 0x0 0x00100000   /* downstream I/O (1MB) */
> -			  0xc3000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* prefetchable memory (768MB) */
> -			  0x82000000 0x0  0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
> +		ranges = <0xc3000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* prefetchable memory (768MB) */
> +			  0x82000000 0x00 0x40000000 0x12 0x30000000 0x0 0x0fff0000   /* non-prefetchable memory (256MB - 64KB) */
> +			  0x81000000 0x00 0x00000000 0x12 0x3fff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
>  	};
>  
>  	pcie@14120000 {
> @@ -1449,9 +1449,9 @@
>  		nvidia,aspm-l0s-entrance-latency-us = <3>;
>  
>  		bus-range = <0x0 0xff>;
> -		ranges = <0x81000000 0x0  0x32100000 0x0  0x32100000 0x0 0x00100000   /* downstream I/O (1MB) */
> -			  0xc3000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* prefetchable memory (768MB) */
> -			  0x82000000 0x0  0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
> +		ranges = <0xc3000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* prefetchable memory (768MB) */
> +			  0x82000000 0x00 0x40000000 0x12 0x70000000 0x0 0x0fff0000   /* non-prefetchable memory (256MB - 64KB) */
> +			  0x81000000 0x00 0x00000000 0x12 0x7fff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
>  	};
>  
>  	pcie@14140000 {
> @@ -1494,9 +1494,9 @@
>  		nvidia,aspm-l0s-entrance-latency-us = <3>;
>  
>  		bus-range = <0x0 0xff>;
> -		ranges = <0x81000000 0x0  0x34100000 0x0  0x34100000 0x0 0x00100000   /* downstream I/O (1MB) */
> -			  0xc3000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* prefetchable memory (768MB) */
> -			  0x82000000 0x0  0x40000000 0x12 0xb0000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
> +		ranges = <0xc3000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* prefetchable memory (768MB) */
> +			  0x82000000 0x00 0x40000000 0x12 0xb0000000 0x0 0x0fff0000   /* non-prefetchable memory (256MB - 64KB) */
> +			  0x81000000 0x00 0x00000000 0x12 0xbfff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
>  	};
>  
>  	pcie@14160000 {
> @@ -1539,9 +1539,9 @@
>  		nvidia,aspm-l0s-entrance-latency-us = <3>;
>  
>  		bus-range = <0x0 0xff>;
> -		ranges = <0x81000000 0x0  0x36100000 0x0  0x36100000 0x0 0x00100000   /* downstream I/O (1MB) */
> -			  0xc3000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
> -			  0x82000000 0x0  0x40000000 0x17 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
> +		ranges = <0xc3000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
> +			  0x82000000 0x00 0x40000000 0x17 0x40000000 0x0 0xbfff0000   /* non-prefetchable memory (3GB - 64KB) */
> +			  0x81000000 0x00 0x00000000 0x17 0xffff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
>  	};
>  
>  	pcie@14180000 {
> @@ -1584,9 +1584,9 @@
>  		nvidia,aspm-l0s-entrance-latency-us = <3>;
>  
>  		bus-range = <0x0 0xff>;
> -		ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000   /* downstream I/O (1MB) */
> -			  0xc3000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
> -			  0x82000000 0x0  0x40000000 0x1b 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
> +		ranges = <0xc3000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
> +			  0x82000000 0x00 0x40000000 0x1b 0x40000000 0x0 0xbfff0000   /* non-prefetchable memory (3GB - 64KB) */
> +			  0x81000000 0x00 0x00000000 0x1b 0xffff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
>  	};
>  
>  	pcie@141a0000 {
> @@ -1633,9 +1633,9 @@
>  		nvidia,aspm-l0s-entrance-latency-us = <3>;
>  
>  		bus-range = <0x0 0xff>;
> -		ranges = <0x81000000 0x0  0x3a100000 0x0  0x3a100000 0x0 0x00100000   /* downstream I/O (1MB) */
> -			  0xc3000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
> -			  0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
> +		ranges = <0xc3000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
> +			  0x82000000 0x00 0x40000000 0x1f 0x40000000 0x0 0xbfff0000   /* non-prefetchable memory (3GB - 64KB) */
> +			  0x81000000 0x00 0x00000000 0x1f 0xffff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
>  	};
>  
>  	pcie_ep@14160000 {
> 


Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers!
Jon

-- 
nvpublic
