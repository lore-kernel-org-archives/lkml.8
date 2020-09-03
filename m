Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25DDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B6520767
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I56eiA7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgICI4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:56:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33048 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726292AbgICI4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599123390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ex8sJsf3MwM3gMU7gFxAPmbLmVJ5LgmUnE9JDMtOUlE=;
        b=I56eiA7E9NYsLp+X2EwGlGnzBGM1Lzyt3t2TZK4IOqa4WsoK2pQryWxaN3DOB7mFLkL/la
        M2o3KX43VX8I0s6+2eGpatMGGAkfPS+VU+qtqE0dp+qD5S9PpNB4wOYx+ECRGfvEyjzyir
        V4eWO7Jfj1T/UpdggqBXcTo4X6wHtO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-JU0LndOANy2n5FO2ndAe1A-1; Thu, 03 Sep 2020 04:56:26 -0400
X-MC-Unique: JU0LndOANy2n5FO2ndAe1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DA81801AAB;
        Thu,  3 Sep 2020 08:56:24 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 481995D9CC;
        Thu,  3 Sep 2020 08:56:17 +0000 (UTC)
Subject: Re: [PATCH v8 7/7] iommu/vt-d: Check UAPI data processed by IOMMU
 core
To:     Jacob Pan <jacob.pan.linux@gmail.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598898300-65475-8-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <041fbe2e-3105-8356-6469-be77f73a0d01@redhat.com>
Date:   Thu, 3 Sep 2020 10:56:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1598898300-65475-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,
On 8/31/20 8:25 PM, Jacob Pan wrote:
> IOMMU generic layer already does sanity checks on UAPI data for version
> match and argsz range based on generic information.
> 
> This patch adjusts the following data checking responsibilities:
> - removes the redundant version check from VT-d driver
> - removes the check for vendor specific data size
> - adds check for the use of reserved/undefined flags
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/iommu/intel/iommu.c |  3 +--
>  drivers/iommu/intel/svm.c   | 11 +++++++++--
>  include/uapi/linux/iommu.h  |  1 +
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 43f16f0cebde..a3a0b5c8921d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5399,8 +5399,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>  	int ret = 0;
>  	u64 size = 0;
>  
> -	if (!inv_info || !dmar_domain ||
> -	    inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +	if (!inv_info || !dmar_domain)
>  		return -EINVAL;
>  
>  	if (!dev || !dev_is_pci(dev))
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 99353d6468fa..0cb9a15f1112 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -284,8 +284,15 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	if (WARN_ON(!iommu) || !data)
>  		return -EINVAL;
>  
> -	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> -	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +		return -EINVAL;
> +
> +	/* IOMMU core ensures argsz is more than the start of the union */
> +	if (data->argsz < offsetofend(struct iommu_gpasid_bind_data, vendor.vtd))
> +		return -EINVAL;
> +
> +	/* Make sure no undefined flags are used in vendor data */
> +	if (data->vendor.vtd.flags & ~(IOMMU_SVA_VTD_GPASID_LAST - 1))
>  		return -EINVAL;
>  
>  	if (!dev_is_pci(dev))
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index c64bca5af419..1ebc23df4fbc 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -288,6 +288,7 @@ struct iommu_gpasid_bind_data_vtd {
>  #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write through */
>  #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem type enable */
>  #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level cache disable */
> +#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
>  	__u64 flags;
>  	__u32 pat;
>  	__u32 emt;
> 

