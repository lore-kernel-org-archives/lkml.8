Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739D6C2D0E8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 06:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26ED0206F8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 06:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H160auRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgDEGhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 02:37:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45600 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726250AbgDEGhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 02:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586068656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oLJp8gNoJW3dJ3wHholYHDaHHlYLtE5HahLyoRw+fos=;
        b=H160auRYGqfbU9VGWBbc+TXovOeo4a4OBNE9lD2qV2/hDUvTA/apIWJBE+mDEvzmwD/Pp8
        Or9ddiDblf/gy0CxEfjOvELLNSB0l9y4IrAQdPnMnX+srJEZdHhwTdlyg/Tw0NAPbPbnoL
        0K/3CeYjT0uGlzf1v7FZsBqQwPhwJQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-qk1hOz4oNuOokJeo_SK-nw-1; Sun, 05 Apr 2020 02:37:34 -0400
X-MC-Unique: qk1hOz4oNuOokJeo_SK-nw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32E22800D50;
        Sun,  5 Apr 2020 06:37:32 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BA5A5DA66;
        Sun,  5 Apr 2020 06:37:26 +0000 (UTC)
Subject: Re: [PATCH v11 03/10] iommu/vt-d: Use a helper function to skip agaw
 for SL
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585939334-21396-4-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <54625f36-909e-405d-fe8d-e80f4314646a@redhat.com>
Date:   Sun, 5 Apr 2020 08:37:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1585939334-21396-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/3/20 8:42 PM, Jacob Pan wrote:
> An Intel iommu domain uses 5-level page table by default. If the
> iommu that the domain tries to attach supports less page levels,
> the top level page tables should be skipped. Add a helper to do
> this so that it could be used in other places.
> 
> ---
> v11 Added Baolu's commit message and squashed 4 & 5 from v10.
> ---
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/intel-pasid.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 22b30f10b396..66c364719ad1 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -500,6 +500,26 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
>  }
>  
>  /*
> + * Skip top levels of page tables for iommu which has less agaw
> + * than default. Unnecessary for PT mode.
> + */
> +static inline int iommu_skip_agaw(struct dmar_domain *domain,
> +				  struct intel_iommu *iommu,
> +				  struct dma_pte **pgd)
> +{
> +	int agaw;
> +
> +	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
> +		*pgd = phys_to_virt(dma_pte_addr(*pgd));
> +		if (!dma_pte_present(*pgd)) {
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return agaw;
> +}
> +
> +/*
>   * Set up the scalable mode pasid entry for second only translation type.
>   */
>  int intel_pasid_setup_second_level(struct intel_iommu *iommu,
> @@ -522,17 +542,11 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  		return -EINVAL;
>  	}
>  
> -	/*
> -	 * Skip top levels of page tables for iommu which has less agaw
> -	 * than default. Unnecessary for PT mode.
> -	 */
>  	pgd = domain->pgd;
> -	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
> -		pgd = phys_to_virt(dma_pte_addr(pgd));
> -		if (!dma_pte_present(pgd)) {
> -			dev_err(dev, "Invalid domain page table\n");
> -			return -EINVAL;
> -		}
> +	agaw = iommu_skip_agaw(domain, iommu, &pgd);
> +	if (agaw < 0) {
> +		dev_err(dev, "Invalid domain page table\n");
> +		return -EINVAL;
>  	}
>  
>  	pgd_val = virt_to_phys(pgd);
> 

