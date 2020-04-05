Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8886C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 06:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8100920709
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 06:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRntigpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgDEGhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 02:37:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgDEGhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 02:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586068659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tNuGzUcg8YK/0FJvzs2aQfmLLWvLugIzMXk72DzpMc=;
        b=JRntigpZA2p/hKcjld2E2dzrslQ9sP0c212TBypjJuiFz3dsfxOZY/BNVuVuazIDPIbnFo
        FBz2nCENGJwmx0EIHdChcaJI3URlGfNrEM3QZ90I0s4CmDBdVSAnCThfc/6NkW0krNbIfj
        X2pX74bRzEd/4LYwVpUbkshGA4t/Evg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-amJAqqodNDibbIcwBWKQcg-1; Sun, 05 Apr 2020 02:37:35 -0400
X-MC-Unique: amJAqqodNDibbIcwBWKQcg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2044D107ACC7;
        Sun,  5 Apr 2020 06:37:33 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6078E10013D9;
        Sun,  5 Apr 2020 06:37:27 +0000 (UTC)
Subject: Re: [PATCH v11 06/10] iommu/vt-d: Support flushing more translation
 cache types
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
 <1585939334-21396-7-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <913838c1-6ae0-c349-dafe-1ea816e4139a@redhat.com>
Date:   Sun, 5 Apr 2020 08:37:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1585939334-21396-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/3/20 8:42 PM, Jacob Pan wrote:
> When Shared Virtual Memory is exposed to a guest via vIOMMU, scalable
> IOTLB invalidation may be passed down from outside IOMMU subsystems.
> This patch adds invalidation functions that can be used for additional
> translation cache types.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> ---
> v9 -> v10:
> Fix off by 1 in pasid device iotlb flush
> 
> Address v7 missed review from Eric
> 
> ---
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/dmar.c        | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-pasid.c |  3 ++-
>  include/linux/intel-iommu.h | 20 ++++++++++++++++----
>  3 files changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index f77dae7ba7d4..4d6b7b5b37ee 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1421,6 +1421,42 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
>  	qi_submit_sync(&desc, iommu);
>  }
>  
> +/* PASID-based device IOTLB Invalidate */
> +void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +		u32 pasid,  u16 qdep, u64 addr, unsigned size_order, u64 granu)
> +{
> +	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
> +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
> +
> +	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
> +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
> +		QI_DEV_IOTLB_PFSID(pfsid);
> +	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
> +
> +	/*
> +	 * If S bit is 0, we only flush a single page. If S bit is set,
> +	 * The least significant zero bit indicates the invalidation address
> +	 * range. VT-d spec 6.5.2.6.
> +	 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates 16KB.
> +	 * size order = 0 is PAGE_SIZE 4KB
> +	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
> +	 * ECAP.
> +	 */
> +	desc.qw1 |= addr & ~mask;
> +	if (size_order)
> +		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
> +
> +	qi_submit_sync(&desc, iommu);
> +}
> +
> +void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu, int pasid)
> +{
> +	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
> +
> +	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) | QI_PC_GRAN(granu) | QI_PC_TYPE;
> +	qi_submit_sync(&desc, iommu);
> +}
> +
>  /*
>   * Disable Queued Invalidation interface.
>   */
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index fcd015644c4f..698e661ccca7 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -435,7 +435,8 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>  {
>  	struct qi_desc desc;
>  
> -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL | QI_PC_PASID(pasid);
> +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> +		QI_PC_PASID(pasid) | QI_PC_TYPE;
>  	desc.qw1 = 0;
>  	desc.qw2 = 0;
>  	desc.qw3 = 0;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index a5bd53cf190c..f775bb825343 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -334,7 +334,7 @@ enum {
>  #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >> (DMA_TLB_FLUSH_GRANU_OFFSET-4))
>  #define QI_IOTLB_ADDR(addr)	(((u64)addr) & VTD_PAGE_MASK)
>  #define QI_IOTLB_IH(ih)		(((u64)ih) << 6)
> -#define QI_IOTLB_AM(am)		(((u8)am))
> +#define QI_IOTLB_AM(am)		(((u8)am) & 0x3f)
>  
>  #define QI_CC_FM(fm)		(((u64)fm) << 48)
>  #define QI_CC_SID(sid)		(((u64)sid) << 32)
> @@ -353,16 +353,21 @@ enum {
>  #define QI_PC_DID(did)		(((u64)did) << 16)
>  #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
>  
> -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
> -#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
> +/* PASID cache invalidation granu */
> +#define QI_PC_ALL_PASIDS	0
> +#define QI_PC_PASID_SEL		1
>  
>  #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
>  #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
> -#define QI_EIOTLB_AM(am)	(((u64)am))
> +#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
>  #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
>  #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
>  #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
>  
> +/* QI Dev-IOTLB inv granu */
> +#define QI_DEV_IOTLB_GRAN_ALL		1
> +#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
> +
>  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
>  #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
> @@ -687,8 +692,15 @@ extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>  			  unsigned int size_order, u64 type);
>  extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  			u16 qdep, u64 addr, unsigned mask);
> +
>  void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
>  		     unsigned long npages, bool ih);
> +
> +extern void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> +			u32 pasid, u16 qdep, u64 addr, unsigned size_order, u64 granu);
> +
> +extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu, int pasid);
> +
>  extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
>  
>  extern int dmar_ir_support(void);
> 

