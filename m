Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57303C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA2B206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a18lQYN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgFKRIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:08:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25649 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726527AbgFKRI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591895307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWnBZHCzZtimvuxaZaPnyP5RcPnmsmA1z03ttfGTAFA=;
        b=a18lQYN5t9oUtYRwI37bxpGGWuAhpmpbVi+MsExXl1oKJW5BOHv023b74IFVsZefh6N0Xb
        nzGNTGilTxNrb/3QquVVupV44RR3eNSRx7c4rhznb5lNd2ZTKRREY+tHrZ94TbrJTQ58fU
        hxs6QfAbl/4jFUuLnwjCPgp0bVG0afs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-_iTT8PLmNeGVtV0p0Dz3_A-1; Thu, 11 Jun 2020 13:08:23 -0400
X-MC-Unique: _iTT8PLmNeGVtV0p0Dz3_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25A49107ACCD;
        Thu, 11 Jun 2020 17:08:21 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A4D310013D0;
        Thu, 11 Jun 2020 17:08:17 +0000 (UTC)
Date:   Thu, 11 Jun 2020 11:08:16 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 3/3] iommu/vt-d: Sanity check uapi argsz filled by
 users
Message-ID: <20200611110816.4cea7204@x1.home>
In-Reply-To: <1591848735-12447-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1591848735-12447-4-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 21:12:15 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> IOMMU UAPI data has an argsz field which is filled by user. As the data
> structures expands, argsz may change. As the UAPI data are shared among
> different architectures, extensions of UAPI data could be a result of
> one architecture which has no impact on another. Therefore, these argsz
> santity checks are performed in the model specific IOMMU drivers. This
> patch adds sanity checks in the VT-d to ensure argsz passed by userspace
> matches feature flags and other contents.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 16 ++++++++++++++++
>  drivers/iommu/intel-svm.c   | 12 ++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 27ebf4b9faef..c98b5109684b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5365,6 +5365,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>  	struct device_domain_info *info;
>  	struct intel_iommu *iommu;
>  	unsigned long flags;
> +	unsigned long minsz;
>  	int cache_type;
>  	u8 bus, devfn;
>  	u16 did, sid;
> @@ -5385,6 +5386,21 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>  	if (!(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE))
>  		return -EINVAL;
>  
> +	minsz = offsetofend(struct iommu_cache_invalidate_info, padding);

Would it still be better to look for the end of the last field that's
actually used to avoid the code churn and oversights if/when the padding
field does get used and renamed?

Per my comment on patch 1/, this also seems like where the device
specific IOMMU driver should also have the responsibility of receiving
a __user pointer to do the copy_from_user() here.  vfio can't know
which flags require which fields to make a UAPI with acceptable
compatibility guarantees otherwise.

> +	if (inv_info->argsz < minsz)
> +		return -EINVAL;
> +
> +	/* Sanity check user filled invalidation dat sizes */
> +	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
> +		inv_info->argsz != offsetofend(struct iommu_cache_invalidate_info,
> +					addr_info))
> +		return -EINVAL;
> +
> +	if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
> +		inv_info->argsz != offsetofend(struct iommu_cache_invalidate_info,
> +					pasid_info))
> +		return -EINVAL;
> +
>  	spin_lock_irqsave(&device_domain_lock, flags);
>  	spin_lock(&iommu->lock);
>  	info = get_domain_info(dev);
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 35b43fe819ed..64dc2c66dfff 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -235,15 +235,27 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	struct dmar_domain *dmar_domain;
>  	struct intel_svm_dev *sdev;
>  	struct intel_svm *svm;
> +	unsigned long minsz;
>  	int ret = 0;
>  
>  	if (WARN_ON(!iommu) || !data)
>  		return -EINVAL;
>  
> +	/*
> +	 * We mandate that no size change in IOMMU UAPI data before the
> +	 * variable size union at the end.
> +	 */
> +	minsz = offsetofend(struct iommu_gpasid_bind_data, padding);

Same.  Thanks,

Alex

> +	if (data->argsz < minsz)
> +		return -EINVAL;
> +
>  	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
>  	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
>  		return -EINVAL;
>  
> +	if (data->argsz != offsetofend(struct iommu_gpasid_bind_data, vtd))
> +		return -EINVAL;
> +
>  	if (!dev_is_pci(dev))
>  		return -ENOTSUPP;
>  

