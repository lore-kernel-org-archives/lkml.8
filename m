Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D05C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E04DD2071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgIAGSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:18:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:14045 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgIAGSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:18:15 -0400
IronPort-SDR: S+AQAx64QgxZdJsVQ/i6UxrJyb44T/7aICX5OtwMWaJQZPBoNQ2ZrGvx4LMdKPLw2DFt6lgl/m
 K1jIo4krh3iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="158117111"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="158117111"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 23:18:14 -0700
IronPort-SDR: nFa3g5/kWJDLubhnL29MkE2NKcYNROw0N4lxPN+5GWf5Brn+2Yec+1oRg8AQnFy7oOWhovaKe5
 oPNVSOdO7VqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="325219893"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2020 23:18:11 -0700
Cc:     baolu.lu@linux.intel.com, CobeChen-oc@zhaoxin.com,
        RaymondPang-oc@zhaoxin.com, TonyWWang-oc@zhaoxin.com
Subject: Re: [PATCH v3 2/2] iommu/vt-d:Add support for probing ACPI device in
 RMRR
To:     FelixCuioc <FelixCui-oc@zhaoxin.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
References: <20200827100217.21324-1-FelixCui-oc@zhaoxin.com>
 <20200827100217.21324-3-FelixCui-oc@zhaoxin.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e5b1daaf-f073-94c9-714c-832b10d284f4@linux.intel.com>
Date:   Tue, 1 Sep 2020 14:12:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827100217.21324-3-FelixCui-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felix,

On 8/27/20 6:02 PM, FelixCuioc wrote:
> After acpi device in RMRR is detected,it is necessary
> to establish a mapping for these devices.
> In acpi_device_create_direct_mappings(),create a mapping
> for the acpi device in RMRR.
> Add a helper to achieve the acpi namespace device can
> access the RMRR region.

Are those ACPI devices visible to kernel? If so, any device driver bound
for it?

Best regards,
baolu

> 
> Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
> ---
>   drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c       |  6 ++++++
>   include/linux/iommu.h       |  3 +++
>   3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 208a91605288..51d7a5b18f41 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4799,6 +4799,21 @@ static int __init platform_optin_force_iommu(void)
>   	return 1;
>   }
>   
> +static int acpi_device_create_direct_mappings(struct device *pn_dev, struct device *acpi_device)
> +{
> +	struct iommu_group *group;
> +
> +	acpi_device->bus->iommu_ops = &intel_iommu_ops;
> +	group = iommu_group_get(pn_dev);
> +	if (!group) {
> +		pr_warn("ACPI name space devices create direct mappings wrong!\n");
> +		return -EINVAL;
> +	}
> +	__acpi_device_create_direct_mappings(group, acpi_device);
> +
> +	return 0;
> +}
> +
>   static int __init probe_acpi_namespace_devices(void)
>   {
>   	struct dmar_drhd_unit *drhd;
> @@ -4813,6 +4828,7 @@ static int __init probe_acpi_namespace_devices(void)
>   			struct acpi_device_physical_node *pn;
>   			struct iommu_group *group;
>   			struct acpi_device *adev;
> +			struct device *pn_dev = NULL;
>   
>   			if (dev->bus != &acpi_bus_type)
>   				continue;
> @@ -4823,6 +4839,7 @@ static int __init probe_acpi_namespace_devices(void)
>   					    &adev->physical_node_list, node) {
>   				group = iommu_group_get(pn->dev);
>   				if (group) {
> +					pn_dev = pn->dev;
>   					iommu_group_put(group);
>   					continue;
>   				}
> @@ -4831,7 +4848,19 @@ static int __init probe_acpi_namespace_devices(void)
>   				ret = iommu_probe_device(pn->dev);
>   				if (ret)
>   					break;
> +				pn_dev = pn->dev;
> +			}
> +			if (!pn_dev) {
> +				dev->bus->iommu_ops = &intel_iommu_ops;
> +				ret = iommu_probe_device(dev);
> +				if (ret) {
> +					pr_err("acpi_device probe fail! ret:%d\n", ret);
> +					goto unlock;
> +				}
> +				goto unlock;
>   			}
> +			ret = acpi_device_create_direct_mappings(pn_dev, dev);
> +unlock:
>   			mutex_unlock(&adev->physical_node_lock);
>   
>   			if (ret)
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 609bd25bf154..4f714a2d5ef7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -779,6 +779,12 @@ static bool iommu_is_attach_deferred(struct iommu_domain *domain,
>   	return false;
>   }
>   
> +void  __acpi_device_create_direct_mappings(struct iommu_group *group, struct device *acpi_device)
> +{
> +	iommu_create_device_direct_mappings(group, acpi_device);
> +}
> +EXPORT_SYMBOL_GPL(__acpi_device_create_direct_mappings);
> +
>   /**
>    * iommu_group_add_device - add a device to an iommu group
>    * @group: the group into which to add the device (reference should be held)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index fee209efb756..9be134775886 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -514,6 +514,9 @@ extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
>   extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
>   			      unsigned long iova, int flags);
>   
> +extern void __acpi_device_create_direct_mappings(struct iommu_group *group,
> +						struct device *acpi_device);
> +
>   static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
>   {
>   	if (domain->ops->flush_iotlb_all)
> 
