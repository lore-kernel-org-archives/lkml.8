Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F7A20706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390116AbgFYHHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:07:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:15462 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390080AbgFYHHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:07:33 -0400
IronPort-SDR: j54iSx45yI9CiBLA9AsWg34+OLeOJTDVn9kOLRiXPaU5MdjTNj/ivKX4jOLbnyfGVc9HOZsksR
 UBYlZBck7+iQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="132221540"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="132221540"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 00:07:32 -0700
IronPort-SDR: VbikwaFc4A3y6iXRr3/X0tdSVtYk86TFkbXmVtNMfMd/TjS30CV0BxTsNDPGFxAictFFXCoyu4
 9RyqgEGqnypQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="263854658"
Received: from yijiangw-mobl1.ccr.corp.intel.com (HELO [10.255.28.52]) ([10.255.28.52])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2020 00:07:28 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 4/5] iommu/uapi: Handle data and argsz filled by users
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592931837-58223-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <84491857-4a7e-e669-3cf5-615b010930e4@linux.intel.com>
 <20200624100709.1277f912@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1d730edf-277f-17fb-6a44-e6af07b6d43e@linux.intel.com>
Date:   Thu, 25 Jun 2020 15:07:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624100709.1277f912@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/25 1:07, Jacob Pan wrote:
> On Wed, 24 Jun 2020 14:54:49 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> Hi Jacob,
>>
>> On 2020/6/24 1:03, Jacob Pan wrote:
>>> IOMMU UAPI data has a user filled argsz field which indicates the
>>> data length comes with the API call. User data is not trusted,
>>> argsz must be validated based on the current kernel data size,
>>> mandatory data size, and feature flags.
>>>
>>> User data may also be extended, results in possible argsz increase.
>>> Backward compatibility is ensured based on size and flags checking.
>>> Details are documented in Documentation/userspace-api/iommu.rst
>>>
>>> This patch adds sanity checks in both IOMMU layer and vendor code,
>>> where VT-d is the only user for now.
>>>
>>> Signed-off-by: Liu Yi L<yi.l.liu@intel.com>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>    drivers/iommu/intel/svm.c |  3 ++
>>>    drivers/iommu/iommu.c     | 96
>>> ++++++++++++++++++++++++++++++++++++++++++++---
>>> include/linux/iommu.h     |  7 ++-- 3 files changed, 98
>>> insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>>> index 713b3a218483..237db56878c0 100644
>>> --- a/drivers/iommu/intel/svm.c
>>> +++ b/drivers/iommu/intel/svm.c
>>> @@ -244,6 +244,9 @@ int intel_svm_bind_gpasid(struct iommu_domain
>>> *domain, struct device *dev, data->format !=
>>> IOMMU_PASID_FORMAT_INTEL_VTD) return -EINVAL;
>>>    
>>> +	if (data->argsz != offsetofend(struct
>>> iommu_gpasid_bind_data, vendor.vtd))
>>> +		return -EINVAL;
>> Need to do size check in intel_iommu_sva_invalidate() as well?
>>
> No need. The difference is that there is no
> vendor specific union for intel_iommu_sva_invalidate().
> 
> Generic flags are used to process invalidation data inside
> intel_iommu_sva_invalidate().

Thanks for the explanation. With the nit tweaked,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
