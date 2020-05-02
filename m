Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB93EC47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1A620757
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nh1pY9Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgEBAx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:53:28 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18427 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEBAx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:53:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eacc4430000>; Fri, 01 May 2020 17:52:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 May 2020 17:53:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 May 2020 17:53:27 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 May
 2020 00:53:27 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 May 2020
 00:53:26 +0000
Subject: Re: [PATCH hmm v2 5/5] mm/hmm: remove the customizable pfn format
 from hmm_range_fault
To:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-mm@kvack.org>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        <amd-gfx@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        <dri-devel@lists.freedesktop.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        <intel-gfx@lists.freedesktop.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        "Niranjana Vishwanathapura" <niranjana.vishwanathapura@intel.com>,
        <nouveau@lists.freedesktop.org>,
        "Yang, Philip" <Philip.Yang@amd.com>
References: <5-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <3c06a94c-c17f-dc31-537e-f3f6e1ace9a2@nvidia.com>
Date:   Fri, 1 May 2020 17:53:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588380739; bh=EV3nm763BNlVbz3132Rm5ScZ/T6SWXq2x/ZiKuEfuP8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nh1pY9Fz7u8s1vJpgRxLXu08giXCQDP363xmg6l0tAXktkX3k7JoYV9gKXZk8ciil
         SsUuIaFfjBxg5B2mGb0w6MYWHWVDSBFSOtvOJA4iKUWDR+lt/J5OTKRwsPFmkGiB2p
         KWQ21HmxXBvfqDQSqQP6ezOvrHGsyqrA94xl/oK9cAXsp7wfeJ4axVyFAWoGkFtyRZ
         74F/UacwzaZaSglpWi4zAE3eIiU+E+80I57OOsg05kYPRSD7GKDMp+tkSbIK6Dy1QA
         ibQfUJa5jPZvKQfDqst9zXF+/N3IiDcejcNSN7m9HKNOHjmzXFxQdHg1RNqoA6EH6G
         vipRDrDiXDJSg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/1/20 11:20 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Presumably the intent here was that hmm_range_fault() could put the data
> into some HW specific format and thus avoid some work. However, nothing
> actually does that, and it isn't clear how anything actually could do that
> as hmm_range_fault() provides CPU addresses which must be DMA mapped.
> 
> Perhaps there is some special HW that does not need DMA mapping, but we
> don't have any examples of this, and the theoretical performance win of
> avoiding an extra scan over the pfns array doesn't seem worth the
> complexity. Plus pfns needs to be scanned anyhow to sort out any
> DEVICE_PRIVATE pages.
> 
> This version replaces the uint64_t with an usigned long containing a pfn
> and fixed flags. On input flags is filled with the HMM_PFN_REQ_* values,
> on successful output it is filled with HMM_PFN_* values, describing the
> state of the pages.
> 
> amdgpu is simple to convert, it doesn't use snapshot and doesn't use
> per-page flags.
> 
> nouveau uses only 16 hmm_pte entries at most (ie fits in a few cache
> lines), and it sweeps over its pfns array a couple of times anyhow. It
> also has a nasty call chain before it reaches the dma map and hardware
> suggesting performance isn't important:
> 
>     nouveau_svm_fault():
>       args.i.m.method = NVIF_VMM_V0_PFNMAP
>       nouveau_range_fault()
>        nvif_object_ioctl()
>         client->driver->ioctl()
> 	  struct nvif_driver nvif_driver_nvkm:
> 	    .ioctl = nvkm_client_ioctl
> 	   nvkm_ioctl()
> 	    nvkm_ioctl_path()
> 	      nvkm_ioctl_v0[type].func(..)
> 	      nvkm_ioctl_mthd()
> 	       nvkm_object_mthd()
> 		  struct nvkm_object_func nvkm_uvmm:
> 		    .mthd = nvkm_uvmm_mthd
> 		   nvkm_uvmm_mthd()
> 		    nvkm_uvmm_mthd_pfnmap()
> 		     nvkm_vmm_pfn_map()
> 		      nvkm_vmm_ptes_get_map()
> 		       func == gp100_vmm_pgt_pfn
> 			struct nvkm_vmm_desc_func gp100_vmm_desc_spt:
> 			  .pfn = gp100_vmm_pgt_pfn
> 			 nvkm_vmm_iter()
> 			  REF_PTES == func == gp100_vmm_pgt_pfn()
> 			    dma_map_page()
> 
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Tested-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   Documentation/vm/hmm.rst                |  26 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  35 ++----
>   drivers/gpu/drm/nouveau/nouveau_dmem.c  |  27 +---
>   drivers/gpu/drm/nouveau/nouveau_dmem.h  |   3 +-
>   drivers/gpu/drm/nouveau/nouveau_svm.c   |  87 ++++++++-----
>   include/linux/hmm.h                     |  99 ++++++---------
>   mm/hmm.c                                | 160 +++++++++++-------------
>   7 files changed, 192 insertions(+), 245 deletions(-)
> 

...snip...

>   
> +static void nouveau_hmm_convert_pfn(struct nouveau_drm *drm,
> +				    struct hmm_range *range, u64 *ioctl_addr)
> +{
> +	unsigned long i, npages;
> +
> +	/*
> +	 * The ioctl_addr prepared here is passed through nvif_object_ioctl()
> +	 * to an eventual DMA map in something like gp100_vmm_pgt_pfn()
> +	 *
> +	 * This is all just encoding the internal hmm reprensetation into a

s/reprensetation/representation/

Looks good and still tests OK with nouveau.
