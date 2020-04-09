Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC189C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2E92074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2eSLHEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDIKOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:14:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36351 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725783AbgDIKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586427284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CTnIFk7SlnjgfgjAutkIHAGc8WK5Yz+a7QSuHJlIns=;
        b=G2eSLHEmm/VJa3xLaUkPBNBR1SfOLNBkkX3Nv6j1MiEj9l3XUqt0zJTgHXjYig76r9ygMQ
        fO2mjTeastPzNad4uFcl8MiYRPEa9ZgbvWTkfGqWxk6BKP5fTMUZYqunvHqUekrSGHhWXA
        lM+aZxmRw7kDNUtbXIeDigybeLQhbL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-08xiuF_KNYOglmQhzs9DPA-1; Thu, 09 Apr 2020 06:14:40 -0400
X-MC-Unique: 08xiuF_KNYOglmQhzs9DPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A787B149C0;
        Thu,  9 Apr 2020 10:14:38 +0000 (UTC)
Received: from [10.36.115.53] (ovpn-115-53.ams2.redhat.com [10.36.115.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 231CAD766F;
        Thu,  9 Apr 2020 10:14:32 +0000 (UTC)
Subject: Re: [PATCH v11 08/10] iommu/vt-d: Cache virtual command capability
 register
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
 <1585939334-21396-9-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <43e7452c-dea8-934c-105e-05798cb1d225@redhat.com>
Date:   Thu, 9 Apr 2020 12:14:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1585939334-21396-9-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/3/20 8:42 PM, Jacob Pan wrote:
> Virtual command registers are used in the guest only, to prevent
> vmexit cost, we cache the capability and store it during initialization.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
nit: following Joerg's comment on 02/10, may be worth squashing it into
the patch that uses it (10/10)

Thanks

Eric
> 
> ---
> v7 Reviewed by Eric & Baolu
> ---
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/dmar.c        | 1 +
>  include/linux/intel-iommu.h | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 4d6b7b5b37ee..3b36491c8bbb 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -963,6 +963,7 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
>  		warn_invalid_dmar(phys_addr, " returns all ones");
>  		goto unmap;
>  	}
> +	iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
>  
>  	/* the registers might be more than one page */
>  	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index f775bb825343..e02a96848586 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -194,6 +194,9 @@
>  #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
>  #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
>  
> +/* Virtual command interface capability */
> +#define vccap_pasid(v)		((v & DMA_VCS_PAS)) /* PASID allocation */
> +
>  /* IOTLB_REG */
>  #define DMA_TLB_FLUSH_GRANU_OFFSET  60
>  #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
> @@ -287,6 +290,7 @@
>  
>  /* PRS_REG */
>  #define DMA_PRS_PPR	((u32)1)
> +#define DMA_VCS_PAS	((u64)1)
>  
>  #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
>  do {									\
> @@ -562,6 +566,7 @@ struct intel_iommu {
>  	u64		reg_size; /* size of hw register set */
>  	u64		cap;
>  	u64		ecap;
> +	u64		vccap;
>  	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
>  	raw_spinlock_t	register_lock; /* protect register handling */
>  	int		seq_id;	/* sequence id of the iommu */
> 

