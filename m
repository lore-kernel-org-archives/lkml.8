Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA35C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 05:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 539AC21775
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 05:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jJbUjZIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgEBFrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 01:47:40 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6530 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgEBFrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 01:47:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ead09360000>; Fri, 01 May 2020 22:46:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 May 2020 22:47:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 May 2020 22:47:39 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 May
 2020 05:47:38 +0000
Received: from [10.2.59.220] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 May 2020
 05:47:37 +0000
Subject: Re: [PATCH hmm v2 1/5] mm/hmm: make CONFIG_DEVICE_PRIVATE into a
 select
To:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        <amd-gfx@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        <dri-devel@lists.freedesktop.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        <intel-gfx@lists.freedesktop.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        <nouveau@lists.freedesktop.org>,
        "Yang, Philip" <Philip.Yang@amd.com>
References: <1-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <17b40a00-658a-1bf4-c14a-7543dd0d2f8c@nvidia.com>
Date:   Fri, 1 May 2020 22:47:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588398391; bh=9WVhNWEwbrdSv0IZ+XjrYrQTjZYFLJxQOn+wzBze+IE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jJbUjZIFpsl+z/WpjRf+dQtCXmX45b2domJ6ui2m0qQLXPCNWeAK2d+Lt4SbMdTHW
         g6h3pk5CkJS4IW8FgDWLONNamvZn4bouhO81p+K/1DKwCbicz1zs5jlW7h5lYehaw/
         clXb1ncut+A5uh78Ae8RCl1Pxjlxo56PG1PTgpCitHzCJSjToSTeViTPgNwElLgtfg
         qk2aJkzLeiGCZUHBkqurTPk4fTAp+5LR5mZhDn33zl2pf7bJhWSK1TYnaIbhFSoqYr
         /cE70NsFQkUcb0lx6FJJ0mKaFJCNfqcecIhbKwZbc17bnzzdzQMurqGa0/qeJJkiSP
         Uti4fpB1h8oTA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-01 11:20, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> There is no reason for a user to select this or not directly - it should
> be selected by drivers that are going to use the feature, similar to how
> CONFIG_HMM_MIRROR works.

Yes, this is a nice touch.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> Currently all drivers provide a feature kconfig that will disable use of
> DEVICE_PRIVATE in that driver, allowing users to avoid enabling this if
> they don't want the overhead.
> 
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>   arch/powerpc/Kconfig            | 2 +-
>   drivers/gpu/drm/nouveau/Kconfig | 2 +-
>   mm/Kconfig                      | 7 +------
>   3 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 924c541a926008..8de52aefdc74cc 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -455,7 +455,7 @@ config PPC_TRANSACTIONAL_MEM
>   config PPC_UV
>   	bool "Ultravisor support"
>   	depends on KVM_BOOK3S_HV_POSSIBLE
> -	depends on DEVICE_PRIVATE
> +	select DEVICE_PRIVATE
>   	default n
>   	help
>   	  This option paravirtualizes the kernel to run in POWER platforms that
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index d6e4ae1ef7053a..af5793f3e7c2cf 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -86,10 +86,10 @@ config DRM_NOUVEAU_BACKLIGHT
>   
>   config DRM_NOUVEAU_SVM
>   	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
> -	depends on DEVICE_PRIVATE
>   	depends on DRM_NOUVEAU
>   	depends on MMU
>   	depends on STAGING
> +	select DEVICE_PRIVATE
>   	select HMM_MIRROR
>   	select MMU_NOTIFIER
>   	default n
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c1acc34c1c358c..7ca36bf5f5058e 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -805,15 +805,10 @@ config HMM_MIRROR
>   	depends on MMU
>   
>   config DEVICE_PRIVATE
> -	bool "Unaddressable device memory (GPU memory, ...)"
> +	bool
>   	depends on ZONE_DEVICE
>   	select DEV_PAGEMAP_OPS
>   
> -	help
> -	  Allows creation of struct pages to represent unaddressable device
> -	  memory; i.e., memory that is only accessible from the device (or
> -	  group of devices). You likely also want to select HMM_MIRROR.
> -
>   config FRAME_VECTOR
>   	bool
>   
> 

