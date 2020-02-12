Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59C0C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DA720659
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTcIoa1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgBLNBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:01:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727600AbgBLNBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581512462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DOPHEKFLyaPC6zE7+mONOmd/Bj3/+FfIgKvbZjXfR6A=;
        b=XTcIoa1up6puAHD9Z9KhJpEgFIL8PYih88jI8dFP5HYRSeLPUYOdFvIfypoWhm/BsXbnF7
        UcguzijbadpDk30cJP5JOO3hg3AJJRWGAuIBBcPpmspZxV3HUXHsuHP5bG2cgrKwQErYqu
        eVKHEGaCB0Cy5/+UrzabUfcUIIaotl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-LiCh0EWTP9uopGyqb8dcqQ-1; Wed, 12 Feb 2020 08:00:51 -0500
X-MC-Unique: LiCh0EWTP9uopGyqb8dcqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE83B100551A;
        Wed, 12 Feb 2020 13:00:49 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 403075DE55;
        Wed, 12 Feb 2020 13:00:24 +0000 (UTC)
Subject: Re: [PATCH V9 07/10] iommu/vt-d: Cache virtual command capability
 register
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277713-66934-8-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <5776bf45-7541-1576-9ced-38883447bf29@redhat.com>
Date:   Wed, 12 Feb 2020 14:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1580277713-66934-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 1/29/20 7:01 AM, Jacob Pan wrote:
> Virtual command registers are used in the guest only, to prevent
> vmexit cost, we cache the capability and store it during initialization.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
I sent my R-b in https://lkml.org/lkml/2019/11/8/228
Also Baolo did. Do I miss any change?

Again history log would help.

Thanks

Eric
> ---
>  drivers/iommu/dmar.c        | 1 +
>  include/linux/intel-iommu.h | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 206733ec8140..fd35e625f315 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -953,6 +953,7 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
>  		warn_invalid_dmar(phys_addr, " returns all ones");
>  		goto unmap;
>  	}
> +	iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
>  
>  	/* the registers might be more than one page */
>  	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index dd9fa61689bc..4a8bf3b11de6 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -192,6 +192,9 @@
>  #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
>  #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
>  
> +/* Virtual command interface capabilities */
> +#define vccap_pasid(v)		((v & DMA_VCS_PAS)) /* PASID allocation */
> +
>  /* IOTLB_REG */
>  #define DMA_TLB_FLUSH_GRANU_OFFSET  60
>  #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
> @@ -285,6 +288,7 @@
>  
>  /* PRS_REG */
>  #define DMA_PRS_PPR	((u32)1)
> +#define DMA_VCS_PAS	((u64)1)
>  
>  #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
>  do {									\
> @@ -535,6 +539,7 @@ struct intel_iommu {
>  	u64		reg_size; /* size of hw register set */
>  	u64		cap;
>  	u64		ecap;
> +	u64		vccap;
>  	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
>  	raw_spinlock_t	register_lock; /* protect register handling */
>  	int		seq_id;	/* sequence id of the iommu */
> 

