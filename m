Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A5FC11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A385208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RjISuM6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgBTOts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:49:48 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3259 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTOts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:49:48 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4e9c6a0000>; Thu, 20 Feb 2020 06:49:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 06:49:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 06:49:47 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 14:49:44 +0000
Subject: Re: [PATCH v3 08/10] arm64: tegra: add AHUB components for few Tegra
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
 <1582180492-25297-9-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6b4c7878-cc5b-b8d5-e340-73abe7d079cb@nvidia.com>
Date:   Thu, 20 Feb 2020 14:49:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-9-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582210154; bh=8IjmeHutB4327ZKHATUFT1dvnarL52Z/5RCH+yurKHU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RjISuM6Cs5qQkZhBl3/51rbPKC2O5r8kASuzixWUzktK5yYnU1Y8xOAitAxatmGV7
         nE+oFxF2UkRCgyi4lcbm0dUPnetHa+tpU7QHZy1jaLUKc1eY8Kv1kb3zzkD8RfHOh+
         eTxI5mc116UTHMwSOR/5G54mnrDfusTjqtdTLuXDlVlYkBa59Rh6dS35DTgyeXCddF
         EbECHEvuoLfno711slw2RwL4ehxzN5DFqpUCYDiLa6I9q+pYh8xxzFsV5z8rwwzHKC
         VN18h/DwQ518Dr6clhSQ2UW0oDdRCn4Dlu74YpctlQgH6XAY7yuEBKgjQgzsdOEvbz
         oge1G/lnOJPpg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/02/2020 06:34, Sameer Pujar wrote:
> This patch adds few AHUB modules for Tegra210, Tegra186 and Tegra194.
> Following modules are common to all above SoCs,
>  * AHUB added as a child node under ACONNECT
>  * AHUB includes many HW accelerators and below components are added
>    as its children.
>    * ADMAIF
>    * I2S
>    * DMIC
>    * DSPK (added for Tegra186 and Tegra194 only, since Tegra210 does
>      not have this module)
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 231 ++++++++++++++++++++++++++++-
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 239 ++++++++++++++++++++++++++++++-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 145 +++++++++++++++++++
>  3 files changed, 613 insertions(+), 2 deletions(-)
Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
