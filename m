Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29557C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33842072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgGMLzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:55:48 -0400
Received: from foss.arm.com ([217.140.110.172]:57966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgGMLzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:55:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2636630E;
        Mon, 13 Jul 2020 04:55:47 -0700 (PDT)
Received: from [10.57.62.178] (unknown [10.57.62.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 957063F887;
        Mon, 13 Jul 2020 04:55:44 -0700 (PDT)
Subject: Re: [PATCH 1/4] dma-mapping: Add bounced DMA ops
To:     Claire Chang <tientzu@chromium.org>, robh+dt@kernel.org,
        frowand.list@gmail.com, hch@lst.de, m.szyprowski@samsung.com
Cc:     treding@nvidia.com, gregkh@linuxfoundation.org,
        saravanak@google.com, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        tfiga@chromium.org, drinkcat@chromium.org
References: <20200713091211.2183368-1-tientzu@chromium.org>
 <20200713091211.2183368-2-tientzu@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4a2451f9-57d8-2e83-e1d6-f144f37173c0@arm.com>
Date:   Mon, 13 Jul 2020 12:55:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713091211.2183368-2-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-13 10:12, Claire Chang wrote:
> The bounced DMA ops provide an implementation of DMA ops that bounce
> streaming DMA in and out of a specially allocated region. Only the
> operations relevant to streaming DMA are supported.

I think there are too many implicit assumptions here - apparently that 
coherent allocations will always be intercepted by 
dma_*_from_dev_coherent(), and that calling into dma-direct won't 
actually bounce things a second time beyond where you thought they were 
going, manage coherency for a different address, and make it all go 
subtly wrong. Consider "swiotlb=force", for instance...

Again, plumbing this straight into dma-direct so that SWIOTLB can simply 
target a different buffer and always bounce regardless of masks would 
seem a far better option.

Robin.

> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>   include/linux/device.h      |   3 +
>   include/linux/dma-mapping.h |   1 +
>   kernel/dma/Kconfig          |  17 +++
>   kernel/dma/Makefile         |   1 +
>   kernel/dma/bounced.c        | 215 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 237 insertions(+)
>   create mode 100644 kernel/dma/bounced.c
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 7322c51e9c0c..868b9a364003 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -588,6 +588,9 @@ struct device {
>   
>   	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
>   
> +#ifdef CONFIG_DMA_BOUNCED
> +	struct dma_bounced_mem  *dma_bounced_mem;
> +#endif
>   #ifdef CONFIG_DMA_DECLARE_COHERENT
>   	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
>   					     override */
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 2328f451a45d..86089424dafd 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -135,6 +135,7 @@ struct dma_map_ops {
>   
>   extern const struct dma_map_ops dma_virt_ops;
>   extern const struct dma_map_ops dma_dummy_ops;
> +extern const struct dma_map_ops dma_bounced_ops;
>   
>   #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>   
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 1da3f44f2565..148734c8748b 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -88,6 +88,23 @@ config DMA_DIRECT_REMAP
>   	select DMA_REMAP
>   	select DMA_COHERENT_POOL
>   
> +config DMA_BOUNCED
> +	bool "DMA Bounced"
> +	depends on !HIGHMEM
> +	select OF_RESERVED_MEM
> +	help
> +	  This enables support for bounced DMA pools which provide a level of
> +	  DMA memory protection on systems with limited hardware protection
> +	  capabilities, such as those lacking an IOMMU. It does so by bouncing
> +	  the data to a specially allocated DMA-accessible protected region
> +	  before mapping and unmapping. One can assign the protected memory
> +	  region in the device tree by using reserved-memory.
> +
> +	  For more information see
> +	  <Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt>
> +	  and <kernel/dma/bounced.c>.
> +	  If unsure, say "n".
> +
>   config DMA_CMA
>   	bool "DMA Contiguous Memory Allocator"
>   	depends on HAVE_DMA_CONTIGUOUS && CMA
> diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
> index 370f63344e9c..f5fb4f42326a 100644
> --- a/kernel/dma/Makefile
> +++ b/kernel/dma/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   obj-$(CONFIG_HAS_DMA)			+= mapping.o direct.o dummy.o
> +obj-$(CONFIG_DMA_BOUNCED)		+= bounced.o
>   obj-$(CONFIG_DMA_CMA)			+= contiguous.o
>   obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
>   obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
> diff --git a/kernel/dma/bounced.c b/kernel/dma/bounced.c
> new file mode 100644
> index 000000000000..fcaabb5eccf2
> --- /dev/null
> +++ b/kernel/dma/bounced.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Bounced DMA support.
> + *
> + * This implements the mitigations for lack of IOMMU by bouncing the data to a
> + * specially allocated region before mapping and unmapping.
> + *
> + * Copyright 2020 Google LLC.
> + */
> +#include <linux/dma-direct.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-noncoherent.h>
> +#include <linux/io.h>
> +#include <linux/genalloc.h>
> +#include <linux/slab.h>
> +
> +struct dma_bounced_mem {
> +	void		**orig_addr;
> +	void		*virt_base;
> +	dma_addr_t	device_base;
> +	dma_addr_t	device_end;
> +	struct gen_pool	*pool;
> +	size_t		size;
> +};
> +
> +static void dma_bounced_set_orig_virt(struct device *dev, dma_addr_t dma_addr,
> +				      void *orig_addr)
> +{
> +	struct dma_bounced_mem *mem = dev->dma_bounced_mem;
> +	int idx = (dma_addr - mem->device_base) >> PAGE_SHIFT;
> +
> +	if (dma_addr < mem->device_base || dma_addr >= mem->device_end)
> +		return;
> +
> +	mem->orig_addr[idx] = orig_addr;
> +}
> +
> +static void *dma_bounced_get_orig_virt(struct device *dev, dma_addr_t dma_addr)
> +{
> +	struct dma_bounced_mem *mem = dev->dma_bounced_mem;
> +	int idx = (dma_addr - mem->device_base) >> PAGE_SHIFT;
> +
> +	if (dma_addr < mem->device_base || dma_addr >= mem->device_end)
> +		return NULL;
> +
> +	return mem->orig_addr[idx];
> +}
> +
> +static void *dma_bounced_get_virt(struct device *dev, dma_addr_t dma_addr)
> +{
> +	struct dma_bounced_mem *mem = dev->dma_bounced_mem;
> +
> +	if (dma_addr < mem->device_base || dma_addr >= mem->device_end)
> +		return NULL;
> +
> +	return (dma_addr - mem->device_base) + mem->virt_base;
> +}
> +
> +static void dma_bounced_sync_single_for_cpu(struct device *dev,
> +					    dma_addr_t dma_addr, size_t size,
> +					    enum dma_data_direction dir)
> +{
> +	void *orig_virt = dma_bounced_get_orig_virt(dev, dma_addr);
> +	void *bounced_virt = dma_bounced_get_virt(dev, dma_addr);
> +
> +	if (!orig_virt || !bounced_virt)
> +		return;
> +
> +	dma_direct_sync_single_for_cpu(dev, dma_addr, size, dir);
> +
> +	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
> +		memcpy(orig_virt, bounced_virt, size);
> +}
> +
> +static void dma_bounced_sync_single_for_device(struct device *dev,
> +					       dma_addr_t dma_addr, size_t size,
> +					       enum dma_data_direction dir)
> +{
> +	void *orig_virt = dma_bounced_get_orig_virt(dev, dma_addr);
> +	void *bounced_virt = dma_bounced_get_virt(dev, dma_addr);
> +
> +	if (!orig_virt || !bounced_virt)
> +		return;
> +
> +	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
> +		memcpy(bounced_virt, orig_virt, size);
> +
> +	dma_direct_sync_single_for_device(dev, dma_addr, size, dir);
> +}
> +
> +static void dma_bounced_sync_sg_for_cpu(struct device *dev,
> +					struct scatterlist *sgl, int nents,
> +					enum dma_data_direction dir)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(sgl, sg, nents, i) {
> +		dma_bounced_sync_single_for_cpu(dev, sg->dma_address,
> +						sg->length, dir);
> +	}
> +}
> +
> +static void dma_bounced_sync_sg_for_device(struct device *dev,
> +					   struct scatterlist *sgl, int nents,
> +					   enum dma_data_direction dir)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(sgl, sg, nents, i) {
> +		dma_bounced_sync_single_for_device(dev, sg->dma_address,
> +						   sg->length, dir);
> +	}
> +}
> +
> +static void dma_bounced_unmap_page(struct device *dev, dma_addr_t dma_addr,
> +				   size_t size, enum dma_data_direction dir,
> +				   unsigned long attrs)
> +{
> +	struct dma_bounced_mem *mem = dev->dma_bounced_mem;
> +
> +	if (dma_addr < mem->device_base || dma_addr >= mem->device_end)
> +		return;
> +
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		dma_bounced_sync_single_for_cpu(dev, dma_addr, size, dir);
> +
> +	dma_bounced_set_orig_virt(dev, dma_addr, NULL);
> +	gen_pool_free(mem->pool,
> +		      (unsigned long)dma_bounced_get_virt(dev, dma_addr), size);
> +}
> +
> +static dma_addr_t dma_bounced_map_page(struct device *dev, struct page *page,
> +				       unsigned long offset, size_t size,
> +				       enum dma_data_direction dir,
> +				       unsigned long attrs)
> +{
> +	struct dma_bounced_mem *mem = dev->dma_bounced_mem;
> +	dma_addr_t dma_addr;
> +	void *orig_virt;
> +
> +	if (unlikely(!gen_pool_dma_alloc(mem->pool, size, &dma_addr)))
> +		return DMA_MAPPING_ERROR;
> +
> +	orig_virt = page_to_virt(page) + offset;
> +	dma_bounced_set_orig_virt(dev, dma_addr, orig_virt);
> +
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		dma_bounced_sync_single_for_device(dev, dma_addr, size, dir);
> +
> +	return dma_addr;
> +}
> +
> +static void dma_bounced_unmap_sg(struct device *dev, struct scatterlist *sgl,
> +				 int nents, enum dma_data_direction dir,
> +				 unsigned long attrs)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(sgl, sg, nents, i) {
> +		dma_bounced_unmap_page(dev, sg->dma_address, sg_dma_len(sg),
> +				       dir, attrs);
> +	}
> +}
> +
> +static int dma_bounced_map_sg(struct device *dev, struct scatterlist *sgl,
> +			      int nents, enum dma_data_direction dir,
> +			      unsigned long attrs)
> +{
> +	int i;
> +	struct scatterlist *sg;
> +
> +	for_each_sg(sgl, sg, nents, i) {
> +		sg->dma_address = dma_bounced_map_page(
> +			dev, sg_page(sg), sg->offset, sg->length, dir, attrs);
> +		if (sg->dma_address == DMA_MAPPING_ERROR)
> +			goto out_unmap;
> +		sg_dma_len(sg) = sg->length;
> +	}
> +
> +	return nents;
> +
> +out_unmap:
> +	dma_bounced_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> +	return 0;
> +}
> +
> +static size_t dma_bounced_max_mapping_size(struct device *dev)
> +{
> +	return dev->dma_bounced_mem->size;
> +}
> +
> +const struct dma_map_ops dma_bounced_ops = {
> +	.alloc			= NULL,
> +	.free			= NULL,
> +	.mmap			= NULL,
> +	.get_sgtable		= NULL,
> +	.sync_single_for_cpu	= dma_bounced_sync_single_for_cpu,
> +	.sync_single_for_device = dma_bounced_sync_single_for_device,
> +	.sync_sg_for_cpu	= dma_bounced_sync_sg_for_cpu,
> +	.sync_sg_for_device	= dma_bounced_sync_sg_for_device,
> +	.map_page		= dma_bounced_map_page,
> +	.unmap_page		= dma_bounced_unmap_page,
> +	.map_sg			= dma_bounced_map_sg,
> +	.unmap_sg		= dma_bounced_unmap_sg,
> +	.unmap_resource		= NULL,
> +	.map_resource		= NULL,
> +	.cache_sync		= NULL,
> +	.dma_supported		= dma_direct_supported,
> +	.get_required_mask	= dma_direct_get_required_mask,
> +	.max_mapping_size	= dma_bounced_max_mapping_size,
> +	.get_merge_boundary	= NULL,
> +};
> 
