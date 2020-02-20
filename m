Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7F0C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C92208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ni1qflRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgBTOwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:52:12 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4631 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgBTOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:52:12 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4e9cd30000>; Thu, 20 Feb 2020 06:50:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 06:52:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 06:52:11 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 14:52:07 +0000
Subject: Re: [PATCH v3 09/10] arm64: tegra: enable AHUB modules for few Tegra
 chips
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
 <1582180492-25297-10-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b55acd02-a492-77cd-833c-d3b18f230037@nvidia.com>
Date:   Thu, 20 Feb 2020 14:52:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-10-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582210259; bh=DZHlCZb018d/zo5xDroBdpIDW9ip6fqXfYqSSOWT/JQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ni1qflRZzYz34vqKivqunhS7MmM24P5AmcqRfHIF+urTDCRwA+1GD3Os5R7bkZ3wr
         yKxy/GmEZC39B4VNlcz4m/FcqVYoXLfnZkXvBtfLZir27PA0hoJrtTRjzaF3IxAXMI
         OQ02s+Ll0uT+jeoYrQZKyKef8w+CVks05D4tmLshLSlsBlajjqIRprsKaBOd7hrnan
         oEyGs0LvDyHUR26XD5/zcVfaJApqutMsmydojfD/VmuQLj1r3xMBKazFnSQnkL3/38
         uG6iuQTar7mhxAm5N3yCcNIhXQl1SJMr7NdklhHAn7/QeDqwOHhU91fc4Gsv1EbjtL
         CcUhf/Xs1arWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/02/2020 06:34, Sameer Pujar wrote:
> This patch enables AHUB, ADMAIF modules for following Tegra platforms.
> Along with this specific instances of I/O modules are enabled as per
> the board design.
> 
>  * Jetson TX1
>    - I2S1, I2S2, I2S3, I2S4 and I2S5
>    - DMIC1, DMIC2 and DMIC3
> 
>  * Jetson TX2
>    - I2S1, I2S2, I2S3, I2S4, I2S5 and I2S6
>    - DMIC1, DMIC2 and DMIC3
>    - DSPK2
> 
>  * Jetson AGX Xavier
>    - I2S1, I2S2, I2S4 and I2S6
>    - DMIC2 and DMIC3
>    - DSPK1
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 48 ++++++++++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 36 ++++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 40 ++++++++++++++++++
>  3 files changed, 124 insertions(+)
Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
