Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8D0C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8AF20758
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgIICFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 22:05:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:59425 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgIICFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 22:05:15 -0400
IronPort-SDR: ascVOh4eIFewb0RJvTAW/fAk8AT91Fwu7Hsgi0mCTOy0uuTSGM5yOg6m9vwZ0vjroLOSlfgTjC
 3wXYvzAGHPUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="176315096"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="176315096"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 19:05:04 -0700
IronPort-SDR: EwMvsQnqiow84WybRJd3Wz4IdLwdqpsZRhwF3StOI1WcwhzelaTRAF5rFeezLyrG+mPt1JIJFc
 7B1B7o7lDxsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="407319111"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2020 19:04:56 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/5] iommu/vt-d: Convert intel iommu driver to the
 iommu ops
To:     Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-5-murphyt7@tcd.ie>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7b0c0f62-2efa-8183-0cbc-6028feb8ec93@linux.intel.com>
Date:   Wed, 9 Sep 2020 09:59:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903201839.7327-5-murphyt7@tcd.ie>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 4:18 AM, Tom Murphy wrote:
> +static int intel_iommu_needs_bounce_buffer(struct device *d)
> +{
> +	return !intel_no_bounce && dev_is_pci(d) && to_pci_dev(d)->untrusted;
> +}
> +
> +
>   static void intel_iommu_probe_finalize(struct device *dev)
>   {
> -	struct iommu_domain *domain;
> +	dma_addr_t base = IOVA_START_PFN << VTD_PAGE_SHIFT;
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>   
> -	domain = iommu_get_domain_for_dev(dev);
> -	if (device_needs_bounce(dev))
> -		set_dma_ops(dev, &bounce_dma_ops);
> -	else if (domain && domain->type == IOMMU_DOMAIN_DMA)
> -		set_dma_ops(dev, &intel_dma_ops);
> +	if (intel_iommu_needs_bounce_buffer(dev) ||

For untrusted devices, the DMA type of domain is enforced. There's no
need to check again here.

Best regards,
baolu

> +			(domain && domain->type == IOMMU_DOMAIN_DMA))
> +		iommu_setup_dma_ops(dev, base,
> +				__DOMAIN_MAX_ADDR(dmar_domain->gaw) - base);
>   	else
>   		set_dma_ops(dev, NULL);
>   }
>   
