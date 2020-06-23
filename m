Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85565C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A702070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HFrX1kZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbgFWA5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:57:40 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19117 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732144AbgFWA5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:57:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef153760001>; Mon, 22 Jun 2020 17:57:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 17:57:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 17:57:39 -0700
Received: from [10.2.59.206] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 00:57:31 +0000
Subject: Re: [RESEND PATCH 3/3] nouveau: make nvkm_vmm_ctor() and
 nvkm_mmu_ptp_get() static
To:     Ralph Campbell <rcampbell@nvidia.com>,
        <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20200622233854.10889-1-rcampbell@nvidia.com>
 <20200622233854.10889-4-rcampbell@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c4421e68-e585-30b4-a6c3-e78e9e15c27f@nvidia.com>
Date:   Mon, 22 Jun 2020 17:57:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622233854.10889-4-rcampbell@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592873846; bh=xt/DdoBrc7yZMBZQe7V2Al8LVTlDZOsWZMnDlqU0wok=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HFrX1kZHglfl1VvYBuoLqx22N0dETh2Vr8k2DJE6gl5LV9ujkobLDnbkPVN6dPZgr
         BFOxjTfLAPEJZXB5vvaAH7MZMLItWJKYIagC7RXVMlDgABKww7sZt/cpG1Z4tszwC5
         OasJ6bXWpHeJ84oshxjFQVD56tIJ+YpmI1RCawYuIbi0nnry6CkmkbVVcUQPgnC4hk
         Yw6MemJ/1EQ6XXuOig0WTHsBUZv1KaKywMaKvNNVctioQbUa04cBP2D7EVLiHbXlJ6
         YqT88zvzC1rZ+C5LNxlc7QOjzBiAjuGQN+EMw6FmDN7cfE5TjmXOlQrC4FftxUP0GK
         aLUQHXWsAbmcA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22 16:38, Ralph Campbell wrote:
> The functions nvkm_vmm_ctor() and nvkm_mmu_ptp_get() are not called outside
> of the file defining them so make them static.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c  | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h  | 3 ---
>   3 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c
> index ee11ccaf0563..de91e9a26172 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c
> @@ -61,7 +61,7 @@ nvkm_mmu_ptp_put(struct nvkm_mmu *mmu, bool force, struct nvkm_mmu_pt *pt)
>   	kfree(pt);
>   }
>   
> -struct nvkm_mmu_pt *
> +static struct nvkm_mmu_pt *
>   nvkm_mmu_ptp_get(struct nvkm_mmu *mmu, u32 size, bool zero)
>   {
>   	struct nvkm_mmu_pt *pt;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> index 199f94e15c5f..67b00dcef4b8 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> @@ -1030,7 +1030,7 @@ nvkm_vmm_ctor_managed(struct nvkm_vmm *vmm, u64 addr, u64 size)
>   	return 0;
>   }
>   
> -int
> +static int
>   nvkm_vmm_ctor(const struct nvkm_vmm_func *func, struct nvkm_mmu *mmu,
>   	      u32 pd_header, bool managed, u64 addr, u64 size,
>   	      struct lock_class_key *key, const char *name,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h
> index d3f8f916d0db..a2b179568970 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h
> @@ -163,9 +163,6 @@ int nvkm_vmm_new_(const struct nvkm_vmm_func *, struct nvkm_mmu *,
>   		  u32 pd_header, bool managed, u64 addr, u64 size,
>   		  struct lock_class_key *, const char *name,
>   		  struct nvkm_vmm **);
> -int nvkm_vmm_ctor(const struct nvkm_vmm_func *, struct nvkm_mmu *,
> -		  u32 pd_header, bool managed, u64 addr, u64 size,
> -		  struct lock_class_key *, const char *name, struct nvkm_vmm *);
>   struct nvkm_vma *nvkm_vmm_node_search(struct nvkm_vmm *, u64 addr);
>   struct nvkm_vma *nvkm_vmm_node_split(struct nvkm_vmm *, struct nvkm_vma *,
>   				     u64 addr, u64 size);
> 

Looks accurate: the order within vmm.c (now that there is no .h
declaration) is still good, and I found no other uses of either function
within the linux.git tree, so


Reviewed-by: John Hubbard <jhubbard@nvidia.com


thanks,
-- 
John Hubbard
NVIDIA
