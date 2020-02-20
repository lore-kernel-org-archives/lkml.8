Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C582C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686C2208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iJiqZm/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgBTPKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:10:17 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15494 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgBTPKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:10:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4ea14a0000>; Thu, 20 Feb 2020 07:10:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 07:10:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 07:10:15 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 15:10:12 +0000
Subject: Re: [PATCH v3 06/10] ASoC: tegra: add Tegra186 based DSPK driver
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
 <1582180492-25297-7-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <21f89564-2e04-7d06-bb07-5fa488d9ee8f@nvidia.com>
Date:   Thu, 20 Feb 2020 15:10:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-7-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582211402; bh=DqhgkJnHxUcz8diUkAKKorYICLcz915PBRp2VzGuspI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=iJiqZm/8CmQ+plBvUef6JAzfIwThPCK7ELdBLATXQ1HHnhpPGcC6AMs5eGG50IHC/
         qZyeHfJ4KuLem1QhEnqfHr6Tw/j4PStoRmi5VYIWKizvoGMfNxm3Q/qALQygxJgU1j
         DMUp3OoK8kZFgspILqGleRn4nDu9vdFkWMH33SQdG5n2KpGXM9uOxXhGu5Z8yeOO5U
         mLp06zsH2VCH/z3sfEieQ+gQ+CVLPvzCQekA0fqtYrFUnw+txu0u2KTUzLzE6Ita7k
         sJqSWo/Wj6KwwDfuuQKSBG3TIfVF0QYsr9Pm4Ka69rKw75EcrftJ/J+mX1c/Wd/HTz
         mwFQxuse41eKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/02/2020 06:34, Sameer Pujar wrote:
> The Digital Speaker Controller (DSPK) converts the multi-bit Pulse Code
> Modulation (PCM) audio input to oversampled 1-bit Pulse Density Modulation
> (PDM) output. From the signal flow perpsective, the DSPK can be viewed as
> a PDM transmitter that up-samples the input to the desired sampling rate
> by interpolation then converts the oversampled PCM input to the desired
> 1-bit output via Delta Sigma Modulation (DSM).
> 
> This patch registers DSPK component with ASoC framework. The component
> driver exposes DAPM widgets, routes and kcontrols for the device. The DAI
> driver exposes DSPK interfaces, which can be used to connect different
> components in the ASoC layer. Makefile and Kconfig support is added to
> allow to build the driver. The DSPK devices can be enabled in the DT via
> "nvidia,tegra186-dspk" compatible binding. This driver can be used
> on Tegra194 chip as well.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/tegra/Kconfig         |  13 +
>  sound/soc/tegra/Makefile        |   2 +
>  sound/soc/tegra/tegra186_dspk.c | 510 ++++++++++++++++++++++++++++++++++++++++
>  sound/soc/tegra/tegra186_dspk.h |  73 ++++++
>  4 files changed, 598 insertions(+)
>  create mode 100644 sound/soc/tegra/tegra186_dspk.c
>  create mode 100644 sound/soc/tegra/tegra186_dspk.h

Aside from Randy's comment ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
