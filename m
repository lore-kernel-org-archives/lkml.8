Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF8EC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0E920752
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgCTJGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:06:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:51479 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbgCTJGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:06:38 -0400
IronPort-SDR: WV6iRYI/nCovOZ/O/G7CcQEHmO9oD5D9sHiJ78ERPMg0DcbiJ0zkwheLTcwEQ0exmVy3qUmU/N
 ohYz+kakMDzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 02:06:37 -0700
IronPort-SDR: VJr/NqfJMjzoPVDYl8u2FKpHQk4dwgxi5zGyEvuGtewNYa2JidH3t/JuF8Q6f2198qBZPFuK1I
 GB9URtnpP+1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; 
   d="scan'208";a="356354058"
Received: from sxu27-mobl2.ccr.corp.intel.com (HELO [10.254.214.109]) ([10.254.214.109])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2020 02:06:34 -0700
Cc:     baolu.lu@linux.intel.com, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/6] iommu: Configure default domain with
 def_domain_type
To:     Joerg Roedel <joro@8bytes.org>
References: <20200314010705.30711-1-baolu.lu@linux.intel.com>
 <20200314010705.30711-3-baolu.lu@linux.intel.com>
 <20200319140321.GA5122@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e8f0980c-8431-593c-f9ef-f8f6104e60ec@linux.intel.com>
Date:   Fri, 20 Mar 2020 17:06:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319140321.GA5122@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2020/3/19 22:03, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Sat, Mar 14, 2020 at 09:07:01AM +0800, Lu Baolu wrote:
>> +static int iommu_group_change_def_domain(struct iommu_group *group, int type)
>> +{
>> +	struct group_device *grp_dev, *temp;
>> +	struct iommu_domain *new, *old;
>> +	const struct iommu_ops *ops;
>> +	int ret = 0;
>> +
>> +	if ((type != IOMMU_DOMAIN_IDENTITY && type != IOMMU_DOMAIN_DMA) ||
>> +	    !group->default_domain || type == group->default_domain->type ||
>> +	    !group->default_domain->ops)
>> +		return -EINVAL;
>> +
>> +	if (group->domain != group->default_domain)
>> +		return -EBUSY;
>> +
>> +	iommu_group_ref_get(group);
>> +	old = group->default_domain;
>> +	ops = group->default_domain->ops;
>> +
>> +	/* Allocate a new domain of requested type. */
>> +	new = ops->domain_alloc(type);
>> +	if (!new) {
>> +		ret = -ENOMEM;
>> +		goto domain_out;
>> +	}
>> +	new->type = type;
>> +	new->ops = ops;
>> +	new->pgsize_bitmap = group->default_domain->pgsize_bitmap;
>> +
>> +	group->default_domain = new;
>> +	group->domain = new;
>> +	list_for_each_entry_safe(grp_dev, temp, &group->devices, list) {
>> +		struct device *dev;
>> +
>> +		dev = grp_dev->dev;
>> +		if (device_is_bound(dev)) {
>> +			ret = -EINVAL;
>> +			goto device_out;
>> +		}
>> +
>> +		iommu_group_create_direct_mappings(group, dev);
>> +		ret = __iommu_attach_device(group->domain, dev);
>> +		if (ret)
>> +			goto device_out;
> 
> In case of a failure here with a group containing multiple devices, the
> other devices temporarily lose their mappings. Please only do the
> device_is_bound() check in the loop and the actual re-attachment of the
> group with a call to __iommu_attach_group().

Sure. I've post a v3 of this patch according to your comments here.
Please help to review.

Best regards,
baolu
