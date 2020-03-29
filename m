Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9167C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783142073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGD5xcOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgC2QGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:06:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:30798 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728209AbgC2QGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585497962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WF4F6a3BV6rL4SrcIQoZGDz9iVf5DtH5yAxsCBgTYHk=;
        b=TGD5xcOLFLR+jxuv+zPtFPpE4NRpip2bT/XnMySdc5j2C3gtT+tUpaEGiEb+Pgi0HXR61u
        PD/bRYanyLm8W2FnX/XHGWIr55BezNOIj4Lx+TTsQx+tqpNiTm+YIhxIwt5XVS71P7r3Un
        1ZQzvRDobYgvcOFRE2Dz+a0XPKN640U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-rim-uUiNPv67ZgkTdsb38w-1; Sun, 29 Mar 2020 12:05:58 -0400
X-MC-Unique: rim-uUiNPv67ZgkTdsb38w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9863EDBA3;
        Sun, 29 Mar 2020 16:05:56 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A8501001DC0;
        Sun, 29 Mar 2020 16:05:49 +0000 (UTC)
Subject: Re: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <6697b594-4ac1-e524-2ac6-5a0a0925ca3f@redhat.com>
Date:   Sun, 29 Mar 2020 18:05:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 3/21/20 12:27 AM, Jacob Pan wrote:
> When Shared Virtual Address (SVA) is enabled for a guest OS via
> vIOMMU, we need to provide invalidation support at IOMMU API and driver
> level. This patch adds Intel VT-d specific function to implement
> iommu passdown invalidate API for shared virtual address.
> 
> The use case is for supporting caching structure invalidation
> of assigned SVM capable devices. Emulated IOMMU exposes queue
> invalidation capability and passes down all descriptors from the guest
> to the physical IOMMU.
> 
> The assumption is that guest to host device ID mapping should be
> resolved prior to calling IOMMU driver. Based on the device handle,
> host IOMMU driver can replace certain fields before submit to the
> invalidation queue.
> 
> ---
> v7 review fixed in v10
> ---
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 182 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 182 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index b1477cd423dd..a76afb0fd51a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5619,6 +5619,187 @@ static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
>  	aux_domain_remove_dev(to_dmar_domain(domain), dev);
>  }
>  
> +/*
> + * 2D array for converting and sanitizing IOMMU generic TLB granularity to
> + * VT-d granularity. Invalidation is typically included in the unmap operation
> + * as a result of DMA or VFIO unmap. However, for assigned devices guest
> + * owns the first level page tables. Invalidations of translation caches in the
> + * guest are trapped and passed down to the host.
> + *
> + * vIOMMU in the guest will only expose first level page tables, therefore
> + * we do not include IOTLB granularity for request without PASID (second level).
> + *
> + * For example, to find the VT-d granularity encoding for IOTLB
> + * type and page selective granularity within PASID:
> + * X: indexed by iommu cache type
> + * Y: indexed by enum iommu_inv_granularity
> + * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
> + *
> + * Granu_map array indicates validity of the table. 1: valid, 0: invalid
> + *
> + */
> +const static int inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_NR] = {
> +	/*
> +	 * PASID based IOTLB invalidation: PASID selective (per PASID),
> +	 * page selective (address granularity)
> +	 */
> +	{0, 1, 1},
> +	/* PASID based dev TLBs, only support all PASIDs or single PASID */
> +	{1, 1, 0},
> +	/* PASID cache */
> +	{1, 1, 0}
> +};
> +
> +const static int inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_NR] = {
> +	/* PASID based IOTLB */
> +	{0, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
> +	/* PASID based dev TLBs */
> +	{QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},
> +	/* PASID cache */
> +	{QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0},
> +};
> +
> +static inline int to_vtd_granularity(int type, int granu, int *vtd_granu)
> +{
> +	if (type >= IOMMU_CACHE_INV_TYPE_NR || granu >= IOMMU_INV_GRANU_NR ||
> +		!inv_type_granu_map[type][granu])
> +		return -EINVAL;
> +
> +	*vtd_granu = inv_type_granu_table[type][granu];
> +
> +	return 0;
> +}
> +
> +static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
> +{
> +	u64 nr_pages = (granu_size * nr_granules) >> VTD_PAGE_SHIFT;
> +
> +	/* VT-d size is encoded as 2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.
> +	 * IOMMU cache invalidate API passes granu_size in bytes, and number of
> +	 * granu size in contiguous memory.
> +	 */
> +	return order_base_2(nr_pages);
> +}
> +
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct iommu_cache_invalidate_info *inv_info)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct device_domain_info *info;
> +	struct intel_iommu *iommu;
> +	unsigned long flags;
> +	int cache_type;
> +	u8 bus, devfn;
> +	u16 did, sid;
> +	int ret = 0;
> +	u64 size = 0;
> +
> +	if (!inv_info || !dmar_domain ||
> +		inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +		return -EINVAL;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	spin_lock(&iommu->lock);
> +	info = iommu_support_dev_iotlb(dmar_domain, iommu, bus, devfn);
> +	if (!info) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +	did = dmar_domain->iommu_did[iommu->seq_id];
> +	sid = PCI_DEVID(bus, devfn);
> +
> +	/* Size is only valid in non-PASID selective invalidation */
> +	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
> +		size = to_vtd_size(inv_info->addr_info.granule_size,
> +				   inv_info->addr_info.nb_granules);
> +
> +	for_each_set_bit(cache_type, (unsigned long *)&inv_info->cache, IOMMU_CACHE_INV_TYPE_NR) {
> +		int granu = 0;
> +		u64 pasid = 0;
> +
> +		ret = to_vtd_granularity(cache_type, inv_info->granularity, &granu);
> +		if (ret) {
> +			pr_err("Invalid cache type and granu combination %d/%d\n", cache_type,
> +				inv_info->granularity);
> +			break;
> +		}
> +
> +		/* PASID is stored in different locations based on granularity */
> +		if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
> +			inv_info->pasid_info.flags & IOMMU_INV_PASID_FLAGS_PASID)
> +			pasid = inv_info->pasid_info.pasid;
> +		else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
> +			inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID)
> +			pasid = inv_info->addr_info.pasid;
> +		else {
> +			pr_err("Cannot find PASID for given cache type and granularity\n");
I don't get this error msg. In case of domain-selective invalidation,
PASID is not used so if I am not wrong you will end up here while there
is no issue.
> +			break;
> +		}
> +
> +		switch (BIT(cache_type)) {
> +		case IOMMU_CACHE_INV_TYPE_IOTLB:
> +			if ((inv_info->granularity != IOMMU_INV_GRANU_PASID) &&
> +				size && (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> +				pr_err("Address out of range, 0x%llx, size order %llu\n",
> +					inv_info->addr_info.addr, size);
> +				ret = -ERANGE;
> +				goto out_unlock;
> +			}
> +
> +			qi_flush_piotlb(iommu, did,
> +					pasid,
> +					mm_to_dma_pfn(inv_info->addr_info.addr),
> +					(granu == QI_GRAN_NONG_PASID) ? -1 : 1 << size,
> +					inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
> +
> +			/*
> +			 * Always flush device IOTLB if ATS is enabled since guest
> +			 * vIOMMU exposes CM = 1, no device IOTLB flush will be passed
> +			 * down.
> +			 */
> +			if (info->ats_enabled) {
nit {} not requested
> +				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
> +						pasid, info->ats_qdep,
> +						inv_info->addr_info.addr, size,
> +						granu);
> +			}
> +			break;
> +		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> +			if (info->ats_enabled) {
nit {} not requested
> +				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
> +						inv_info->addr_info.pasid, info->ats_qdep,
> +						inv_info->addr_info.addr, size,
> +						granu);
> +			} else
> +				pr_warn("Passdown device IOTLB flush w/o ATS!\n");
> +
nit: extra line
> +			break;
> +		case IOMMU_CACHE_INV_TYPE_PASID:
> +			qi_flush_pasid_cache(iommu, did, granu, inv_info->pasid_info.pasid);
> +
nit: extra line
> +			break;
> +		default:
> +			dev_err(dev, "Unsupported IOMMU invalidation type %d\n",
> +				cache_type);
> +			ret = -EINVAL;
> +		}
> +	}
> +out_unlock:
> +	spin_unlock(&iommu->lock);
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	return ret;
> +}
> +#endif
> +
>  static int intel_iommu_map(struct iommu_domain *domain,
>  			   unsigned long iova, phys_addr_t hpa,
>  			   size_t size, int iommu_prot, gfp_t gfp)
> @@ -6204,6 +6385,7 @@ const struct iommu_ops intel_iommu_ops = {
>  	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> +	.cache_invalidate	= intel_iommu_sva_invalidate,
>  	.sva_bind_gpasid	= intel_svm_bind_gpasid,
>  	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
>  #endif
> 
Thanks

Eric

