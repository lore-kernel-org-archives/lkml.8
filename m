Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091B9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC09F207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dkALFZOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgFZMVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:21:54 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13983 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgFZMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:21:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef5e8020000>; Fri, 26 Jun 2020 05:20:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 05:21:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 05:21:53 -0700
Received: from [10.26.73.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 12:21:51 +0000
Subject: Re: [PATCH V2] soc/tegra: Add defines for Tegra186+ chip IDs
To:     Sandipan Patra <spatra@nvidia.com>, <treding@nvidia.com>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>, <snikam@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1593171922-30632-1-git-send-email-spatra@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bb9ae015-4fe8-59d4-48fd-6a99a7ae8bc9@nvidia.com>
Date:   Fri, 26 Jun 2020 13:21:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593171922-30632-1-git-send-email-spatra@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593174018; bh=lcR1OuqUE4nBsR2lUB4yD8hOU88qdEHQbzDUa07kZ0I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dkALFZOi+Gi3URC2kHiaKd/E0I/zUk4h1OMbfdTirb0oR4iQalfQncXsG867be7V2
         ViZkE8oSSlsbExwojcyDacHv0it5i11VMdeLes2xIeCI6RwXoPy32LCA9f9JdgpU01
         /kKK2qKGa7VIgRuPy4oZEL70T30D4q6gdiTus2BpEpVvh7zA88yCjZ12bXk3Qggxs3
         z8yoDhXGaQZJXZkkwJrxMrBWh2B2ZbvqRo+0rYYrevcw80w5yX9hIQSdCT7znT4gt4
         AiqOs0zFLos1l7vrSENe6tlJufu9XeiPde2LI67f/M9Yu1x7EPOh0BGWDlReI10FyQ
         2TxcDyX2/7AKg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/06/2020 12:45, Sandipan Patra wrote:
> Add the chip IDs for NVIDIA Tegra186, Tegra194 and Tegra234
> SoC families.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> V2:
>   - Precise commit message
> 
>  include/soc/tegra/fuse.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
> index 252ea20..4a5236b 100644
> --- a/include/soc/tegra/fuse.h
> +++ b/include/soc/tegra/fuse.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2012-2020, NVIDIA CORPORATION.  All rights reserved.
>   */
>  
>  #ifndef __SOC_TEGRA_FUSE_H__
> @@ -12,6 +12,9 @@
>  #define TEGRA124	0x40
>  #define TEGRA132	0x13
>  #define TEGRA210	0x21
> +#define TEGRA186	0x18
> +#define TEGRA194	0x19
> +#define TEGRA234	0x23
>  
>  #define TEGRA_FUSE_SKU_CALIB_0	0xf0
>  #define TEGRA30_FUSE_SATA_CALIB	0x124


Thanks. Looks good to me.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
