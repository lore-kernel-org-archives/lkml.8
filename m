Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C11C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8D020781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfjW80zN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMJUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:20:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57234 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726053AbgHMJUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597310402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBJ+ExoQy5aEoL39b9C9uVKH38XogTRSFkeFcEtzNJ8=;
        b=KfjW80zN2srPkXWSAMeeVL9AR2sKaDrFC7cgb936RjxkHD3OZ9VsUF0KMLMI9o4aOaCGhF
        ZAxyc/VZPb76y7CwovCEHxZKshBAdi60hH36rfMGY9LVCSfDL3wI46UUlRu8nBouI+R3P+
        ESYQawshnRrSVZDR60myMwpJyRBcfhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-2iC1flfpOPGgncnuADpR8w-1; Thu, 13 Aug 2020 05:19:58 -0400
X-MC-Unique: 2iC1flfpOPGgncnuADpR8w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C290B85B66C;
        Thu, 13 Aug 2020 09:19:56 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CB87600C5;
        Thu, 13 Aug 2020 09:19:48 +0000 (UTC)
Subject: Re: [PATCH v7 7/7] iommu/vt-d: Check UAPI data processed by IOMMU
 core
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
        Jonathan Corbet <corbet@lwn.net>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1596068467-49322-8-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <1b131401-a9a3-3641-99cc-430d9b51efa5@redhat.com>
Date:   Thu, 13 Aug 2020 11:19:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1596068467-49322-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 7/30/20 2:21 AM, Jacob Pan wrote:
> IOMMU generic layer already does sanity checks UAPI data for version
> match and argsz range under generic information.
> Remove the redundant version check from VT-d driver and check for vendor
> specific data size.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

> ---
>  drivers/iommu/intel/iommu.c | 3 +--
>  drivers/iommu/intel/svm.c   | 7 +++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 021f62078f52..7e03cca31a0e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5391,8 +5391,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
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
> index 713b3a218483..55ea11e9c0f5 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -240,8 +240,11 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
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
>  		return -EINVAL;
Shouldn't you test the vendor flags here? intel_pasid_setup_bind_data()
only checks valid ones but not ~mask.

Thanks

Eric
>  
>  	if (!dev_is_pci(dev))
> 

