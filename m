Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC831C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D895207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGQBUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:20:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:48121 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgGQBUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:20:10 -0400
IronPort-SDR: cwYvtUxT2QoE8tW8DkEZkI4VQNXRrylE+K7fN8ZSDrrIVxxvm20n+fhvZZvXMIrtYSmjl/7xNx
 O5YftnQ1kC1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="136980128"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="136980128"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 18:20:10 -0700
IronPort-SDR: DYKAK33VRoLIioAqsUIF1mjJoZdZfFn9W+1ZGu5cn72wUx+lyz2k2iLsFdLUdhSQA0oXfV5CXp
 2G/8hxQxyBVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="460677441"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga005.jf.intel.com with ESMTP; 16 Jul 2020 18:20:06 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 5/5] iommu/vt-d: Check UAPI data processed by IOMMU
 core
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1594925117-64892-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594925117-64892-6-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d04f35ff-8921-a3af-ea6d-b8b9cbc929bf@linux.intel.com>
Date:   Fri, 17 Jul 2020 09:15:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1594925117-64892-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/20 2:45 AM, Jacob Pan wrote:
> IOMMU generic layer already does sanity checks UAPI data for version
> match and argsz range under generic information.
> Remove the redundant version check from VT-d driver and check for vendor
> specific data size.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 3 +--
>   drivers/iommu/intel/svm.c   | 7 +++++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index f3a6ca88cf95..5e80484f0537 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5383,8 +5383,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   	int ret = 0;
>   	u64 size = 0;
>   
> -	if (!inv_info || !dmar_domain ||
> -	    inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +	if (!inv_info || !dmar_domain)
>   		return -EINVAL;
>   
>   	if (!dev || !dev_is_pci(dev))
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 713b3a218483..55ea11e9c0f5 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -240,8 +240,11 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	if (WARN_ON(!iommu) || !data)
>   		return -EINVAL;
>   
> -	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> -	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +		return -EINVAL;
> +
> +	/* IOMMU core ensures argsz is more than the start of the union */
> +	if (data->argsz < offsetofend(struct iommu_gpasid_bind_data, vendor.vtd))
>   		return -EINVAL;
>   
>   	if (!dev_is_pci(dev))
> 
