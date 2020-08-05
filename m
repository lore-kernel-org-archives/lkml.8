Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784A3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FECA22CB1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgHEDBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:01:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:7557 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHEDBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:01:42 -0400
IronPort-SDR: 9L5W4hKZyr4mdpTdq6sSl3OSQl1v4z2Pbha+bmpHCWeb4Vth6OAuVmRG55IAo9fRLPCHQLnroE
 O/v3IfnUew4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="237312916"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="237312916"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 20:01:36 -0700
IronPort-SDR: mmwnzXQEH8njXhG5ywBqWZbp/Zcoa/j7qkolC1AsIqDoHKnzHLXLsxWZX8A+Ufss+M/asm6Yh8
 r+8Lyl9rNYcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="396782880"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2020 20:01:34 -0700
Cc:     baolu.lu@linux.intel.com,
        RaymondPang-oc <RaymondPang-oc@zhaoxin.com>,
        CobeChen-oc <CobeChen-oc@zhaoxin.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENI?=
 =?UTF-8?Q?=5d_iommu/vt-d=3aAdd_support_for_ACPI_device_in_RMRR?=
To:     FelixCui-oc <FelixCui-oc@zhaoxin.com>,
        Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20200802100735.2722-1-FelixCui-oc@zhaoxin.com>
 <73d4a1e4-f6b7-efb0-e225-2e462c838657@linux.intel.com>
 <f6759b9bb2594026b58f9a89e3ce9dc6@zhaoxin.com>
 <9f64d9b6-16e8-73ce-2186-9d8ba49c39f4@linux.intel.com>
 <44ff8f73fa1f49a183a1d8d6d9c2213c@zhaoxin.com>
 <314679b4-7653-041b-9310-73baf8117766@linux.intel.com>
 <1aea042a1b524ef88e491ca2a6d95fb7@zhaoxin.com>
 <36da53a6-00e2-1be1-91b5-d90906a6199f@linux.intel.com>
 <a5fda3f364da4e739736e7d7bc618972@zhaoxin.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a2658f9c-23fa-bb72-edba-ad61e52085cd@linux.intel.com>
Date:   Wed, 5 Aug 2020 10:56:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a5fda3f364da4e739736e7d7bc618972@zhaoxin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/4/20 11:11 AM, FelixCui-oc wrote:
> Hi  baolu ,
> 		When creating a identity mapping for a namespace device in RMRR, you need to add the namespace device to the rmrr->device[] , right?

Yes. You are right.

> 		The dmar_acpi_bus_add_dev() in patch adds the enumeration of the namespace device in RMRR. This is similar to > enumerating pci devices. Do you think this is unreasonable? If it is 
unreasonable, please tell me why it is unreasonable.

It looks reasonable. Thanks for the explanation.

But I don't think we need to add acpi_device_create_direct_mappings()
since the rmrr identity mapping is already done in the iommu core.

Best regards,
baolu

> 			
> Best regards
> Felix cui-oc
> 
> 
> 
> -----邮件原件-----
> 发件人: Lu Baolu <baolu.lu@linux.intel.com>
> 发送时间: 2020年8月4日 9:12
> 收件人: FelixCui-oc <FelixCui-oc@zhaoxin.com>; Joerg Roedel <joro@8bytes.org>; iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org; David Woodhouse <dwmw2@infradead.org>
> 抄送: baolu.lu@linux.intel.com; RaymondPang-oc <RaymondPang-oc@zhaoxin.com>; CobeChen-oc <CobeChen-oc@zhaoxin.com>
> 主题: Re: 答复: 答复: 答复: [PATCH] iommu/vt-d:Add support for ACPI device in RMRR
> 
> Hi Felix,
> 
> On 2020/8/3 17:41, FelixCui-oc wrote:
>> Hi baolu,
>> 		 dmar_acpi_dev_scope_init() parse ANDD structure and enumerated namespaces device in DRHD.
> 
> Yes.
> 
>> 		 But the namespace device in RMRR is not enumerated, right?
> 
> It should be probed in probe_acpi_namespace_devices().
> 
> Best regards,
> baolu
> 
>>
>> Best regards
>> Felix cui-oc
>>
>>
>>
>>
>> -----邮件原件-----
>> 发件人: FelixCui-oc
>> 发送时间: 2020年8月3日 17:02
>> 收件人: 'Lu Baolu' <baolu.lu@linux.intel.com>; Joerg Roedel
>> <joro@8bytes.org>; iommu@lists.linux-foundation.org;
>> linux-kernel@vger.kernel.org; David Woodhouse <dwmw2@infradead.org>
>> 抄送: RaymondPang-oc <RaymondPang-oc@zhaoxin.com>; CobeChen-oc
>> <CobeChen-oc@zhaoxin.com>
>> 主题: 答复: 答复: 答复: [PATCH] iommu/vt-d:Add support for ACPI device in RMRR
>>
>> Hi  baolu:
>> 		"The namespace devices are enumerated in probe_acpi_namespace_devices().
>> 		It calls iommu_probe_device() to process the enumeration and setup the identity mappings."
>> 		
>> 		This situation only applies to the physical node of the namespaces device as the pci device.
>> 		In fact, the physical node of the namespaces device can be a platform device or NULL.
>> 		If the physical node of the namespaces is a platform device or NULL, it has not actually been enumerated.
>> 		So it is necessary to increase the analysis of the namespaces device in RMRR and establish an identity mapping.
>>
>> Best regards
>> Felix cui
>>
>>
>>
>>
>> -----邮件原件-----
>> 发件人: Lu Baolu <baolu.lu@linux.intel.com>
>> 发送时间: 2020年8月3日 16:26
>> 收件人: FelixCui-oc <FelixCui-oc@zhaoxin.com>; Joerg Roedel
>> <joro@8bytes.org>; iommu@lists.linux-foundation.org;
>> linux-kernel@vger.kernel.org; David Woodhouse <dwmw2@infradead.org>
>> 抄送: baolu.lu@linux.intel.com; RaymondPang-oc
>> <RaymondPang-oc@zhaoxin.com>; CobeChen-oc <CobeChen-oc@zhaoxin.com>
>> 主题: Re: 答复: 答复: [PATCH] iommu/vt-d:Add support for ACPI device in RMRR
>>
>> On 2020/8/3 14:52, FelixCui-oc wrote:
>>> Hi  baolu ,
>>> 		Yes ,that's right.
>>> 		This patch is to achieve acpi namespace devices to access the RMRR region.
>>
>> The namespace devices are enumerated in probe_acpi_namespace_devices().
>> It calls iommu_probe_device() to process the enumeration and setup the identity mappings. Can you please check why that code doesn't work for you?
>>
>> Best regards,
>> baolu
>>
>>>
>>> Best regards
>>> Felix cui
>>>
>>>
>>>
>>>
>>> -----邮件原件-----
>>> 发件人: Lu Baolu <baolu.lu@linux.intel.com>
>>> 发送时间: 2020年8月3日 14:19
>>> 收件人: FelixCui-oc <FelixCui-oc@zhaoxin.com>; Joerg Roedel
>>> <joro@8bytes.org>; iommu@lists.linux-foundation.org;
>>> linux-kernel@vger.kernel.org; David Woodhouse <dwmw2@infradead.org>
>>> 抄送: baolu.lu@linux.intel.com; RaymondPang-oc
>>> <RaymondPang-oc@zhaoxin.com>; CobeChen-oc <CobeChen-oc@zhaoxin.com>
>>> 主题: Re: 答复: [PATCH] iommu/vt-d:Add support for ACPI device in RMRR
>>>
>>> Hi,
>>>
>>> On 2020/8/3 12:40, FelixCui-oc wrote:
>>>> Hi baolu:
>>>> 		Some ACPI devices need to issue dma requests to access the reserved memory area.
>>>> 		So bios uses the device scope type ACPI_NAMESPACE_DEVICE in RMRR to report these ACPI devices.
>>>> 		At present, there is no analysis in the kernel that the device scope type in RMRR is ACPI_NAMESPACE_DEVICE.
>>>> 		This patch is mainly to add the analysis of the device scope type ACPI_NAMESPACE_DEVICE in RMRR structure and establish identity mapping for > these ACPI devices.
>>>
>>> So the problem is "although namespace devices in RMRR have been parsed, but the identity map for those devices aren't created. As the result, the namespace devices fail to access the RMRR region."
>>>
>>> Do I understand it right?
>>>
>>> Best regards,
>>> baolu
>>>
>>>> In addition, some naming changes have been made in patch in order to distinguish acpi device from pci device.
>>>> 		You can refer to the description of type in 8.3.1 device scope in vt-d spec.
>>>>
>>>> Best regards
>>>> FelixCui-oc
>>>>
>>>>
>>>>
>>>> -----邮件原件-----
>>>> 发件人: Lu Baolu <baolu.lu@linux.intel.com>
>>>> 发送时间: 2020年8月3日 10:32
>>>> 收件人: FelixCui-oc <FelixCui-oc@zhaoxin.com>; Joerg Roedel
>>>> <joro@8bytes.org>; iommu@lists.linux-foundation.org;
>>>> linux-kernel@vger.kernel.org; David Woodhouse <dwmw2@infradead.org>
>>>> 抄送: baolu.lu@linux.intel.com; Cobe Chen(BJ-RD)
>>>> <CobeChen@zhaoxin.com>; Raymond Pang(BJ-RD)
>>>> <RaymondPang@zhaoxin.com>
>>>> 主题: Re: [PATCH] iommu/vt-d:Add support for ACPI device in RMRR
>>>>
>>>> Hi,
>>>>
>>>> On 8/2/20 6:07 PM, FelixCuioc wrote:
>>>>> Some ACPI devices require access to the specified reserved memory
>>>>> region.BIOS report the specified reserved memory region through
>>>>> RMRR structures.Add analysis of ACPI device in RMRR and establish
>>>>> identity mapping for ACPI device.
>>>>
>>>> Can you please add more words about the problem you want to solve? Do you mean some RMRRs are not enumerated correctly? Or, enumerated, but not identity mapped?
>>>>
>>>> Nit: add version and change log once you refreshed your patch.
>>>>
>>>>>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> No need to add this. The problem you want to solve through this patch is not reported by lkp.
>>>>
>>>> Best regards,
>>>> baolu
>>>>
>>>>> Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
>>>>> ---
>>>>>       drivers/iommu/intel/dmar.c  | 74 ++++++++++++++++++++-----------------
>>>>>       drivers/iommu/intel/iommu.c | 46 ++++++++++++++++++++++-
>>>>>       drivers/iommu/iommu.c       |  6 +++
>>>>>       include/linux/dmar.h        | 12 +++++-
>>>>>       include/linux/iommu.h       |  3 ++
>>>>>       5 files changed, 105 insertions(+), 36 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/intel/dmar.c
>>>>> b/drivers/iommu/intel/dmar.c index 93e6345f3414..024ca38dba12
>>>>> 100644
>>>>> --- a/drivers/iommu/intel/dmar.c
>>>>> +++ b/drivers/iommu/intel/dmar.c
>>>>> @@ -215,7 +215,7 @@ static bool dmar_match_pci_path(struct dmar_pci_notify_info *info, int bus,
>>>>>       }
>>>>>       
>>>>>       /* Return: > 0 if match found, 0 if no match found, < 0 if
>>>>> error happens */ -int dmar_insert_dev_scope(struct
>>>>> dmar_pci_notify_info *info,
>>>>> +int dmar_pci_insert_dev_scope(struct dmar_pci_notify_info *info,
>>>>>       			  void *start, void*end, u16 segment,
>>>>>       			  struct dmar_dev_scope *devices,
>>>>>       			  int devices_cnt)
>>>>> @@ -304,7 +304,7 @@ static int dmar_pci_bus_add_dev(struct
>>>>> dmar_pci_notify_info *info)
>>>>>       
>>>>>       		drhd = container_of(dmaru->hdr,
>>>>>       				    struct acpi_dmar_hardware_unit, header);
>>>>> -		ret = dmar_insert_dev_scope(info, (void *)(drhd + 1),
>>>>> +		ret = dmar_pci_insert_dev_scope(info, (void *)(drhd + 1),
>>>>>       				((void *)drhd) + drhd->header.length,
>>>>>       				dmaru->segment,
>>>>>       				dmaru->devices, dmaru->devices_cnt); @@ -696,48 +696,56 @@
>>>>> dmar_find_matched_drhd_unit(struct pci_dev *dev)
>>>>>       
>>>>>       	return dmaru;
>>>>>       }
>>>>> -
>>>>> -static void __init dmar_acpi_insert_dev_scope(u8 device_number,
>>>>> -					      struct acpi_device *adev)
>>>>> +int dmar_acpi_insert_dev_scope(u8 device_number,
>>>>> +				struct acpi_device *adev,
>>>>> +				void *start, void *end,
>>>>> +				struct dmar_dev_scope *devices,
>>>>> +				int devices_cnt)
>>>>>       {
>>>>> -	struct dmar_drhd_unit *dmaru;
>>>>> -	struct acpi_dmar_hardware_unit *drhd;
>>>>>       	struct acpi_dmar_device_scope *scope;
>>>>>       	struct device *tmp;
>>>>>       	int i;
>>>>>       	struct acpi_dmar_pci_path *path;
>>>>>       
>>>>> +	for (; start < end; start += scope->length) {
>>>>> +		scope = start;
>>>>> +		if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
>>>>> +			continue;
>>>>> +		if (scope->enumeration_id != device_number)
>>>>> +			continue;
>>>>> +		path = (void *)(scope + 1);
>>>>> +		for_each_dev_scope(devices, devices_cnt, i, tmp)
>>>>> +			if (tmp == NULL) {
>>>>> +				devices[i].bus = scope->bus;
>>>>> +				devices[i].devfn = PCI_DEVFN(path->device, path->function);
>>>>> +				rcu_assign_pointer(devices[i].dev,
>>>>> +						   get_device(&adev->dev));
>>>>> +				return 1;
>>>>> +			}
>>>>> +		WARN_ON(i >= devices_cnt);
>>>>> +	}
>>>>> +	return 0;
>>>>> +}
>>>>> +static int dmar_acpi_bus_add_dev(u8 device_number, struct
>>>>> +acpi_device
>>>>> +*adev) {
>>>>> +	struct dmar_drhd_unit *dmaru;
>>>>> +	struct acpi_dmar_hardware_unit *drhd;
>>>>> +	int ret = 0;
>>>>> +
>>>>>       	for_each_drhd_unit(dmaru) {
>>>>>       		drhd = container_of(dmaru->hdr,
>>>>>       				    struct acpi_dmar_hardware_unit,
>>>>>       				    header);
>>>>> +		ret = dmar_acpi_insert_dev_scope(device_number, adev, (void *)(drhd+1),
>>>>> +						((void *)drhd)+drhd->header.length,
>>>>> +						dmaru->devices, dmaru->devices_cnt);
>>>>> +		if (ret)
>>>>> +			break;
>>>>> +	}
>>>>> +	ret = dmar_rmrr_add_acpi_dev(device_number, adev);
>>>>>       
>>>>> -		for (scope = (void *)(drhd + 1);
>>>>> -		     (unsigned long)scope < ((unsigned long)drhd) + drhd->header.length;
>>>>> -		     scope = ((void *)scope) + scope->length) {
>>>>> -			if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
>>>>> -				continue;
>>>>> -			if (scope->enumeration_id != device_number)
>>>>> -				continue;
>>>>> +	return ret;
>>>>>       
>>>>> -			path = (void *)(scope + 1);
>>>>> -			pr_info("ACPI device \"%s\" under DMAR at %llx as %02x:%02x.%d\n",
>>>>> -				dev_name(&adev->dev), dmaru->reg_base_addr,
>>>>> -				scope->bus, path->device, path->function);
>>>>> -			for_each_dev_scope(dmaru->devices, dmaru->devices_cnt, i, tmp)
>>>>> -				if (tmp == NULL) {
>>>>> -					dmaru->devices[i].bus = scope->bus;
>>>>> -					dmaru->devices[i].devfn = PCI_DEVFN(path->device,
>>>>> -									    path->function);
>>>>> -					rcu_assign_pointer(dmaru->devices[i].dev,
>>>>> -							   get_device(&adev->dev));
>>>>> -					return;
>>>>> -				}
>>>>> -			BUG_ON(i >= dmaru->devices_cnt);
>>>>> -		}
>>>>> -	}
>>>>> -	pr_warn("No IOMMU scope found for ANDD enumeration ID %d (%s)\n",
>>>>> -		device_number, dev_name(&adev->dev));
>>>>>       }
>>>>>       
>>>>>       static int __init dmar_acpi_dev_scope_init(void) @@ -766,7
>>>>> +774,7 @@ static int __init dmar_acpi_dev_scope_init(void)
>>>>>       				       andd->device_name);
>>>>>       				continue;
>>>>>       			}
>>>>> -			dmar_acpi_insert_dev_scope(andd->device_number, adev);
>>>>> +			dmar_acpi_bus_add_dev(andd->device_number, adev);
>>>>>       		}
>>>>>       	}
>>>>>       	return 0;
>>>>> diff --git a/drivers/iommu/intel/iommu.c
>>>>> b/drivers/iommu/intel/iommu.c index ca557d351518..be1793415326
>>>>> 100644
>>>>> --- a/drivers/iommu/intel/iommu.c
>>>>> +++ b/drivers/iommu/intel/iommu.c
>>>>> @@ -4507,6 +4507,24 @@ int dmar_find_matched_atsr_unit(struct
>>>>> pci_dev
>>>>> *dev)
>>>>>       
>>>>>       	return ret;
>>>>>       }
>>>>> +int dmar_rmrr_add_acpi_dev(u8 device_number, struct acpi_device
>>>>> +*adev) {
>>>>> +	int ret;
>>>>> +	struct dmar_rmrr_unit *rmrru;
>>>>> +	struct acpi_dmar_reserved_memory *rmrr;
>>>>> +
>>>>> +	list_for_each_entry(rmrru, &dmar_rmrr_units, list) {
>>>>> +		rmrr = container_of(rmrru->hdr,
>>>>> +				struct acpi_dmar_reserved_memory,
>>>>> +				header);
>>>>> +		ret = dmar_acpi_insert_dev_scope(device_number, adev, (void *)(rmrr + 1),
>>>>> +						((void *)rmrr) + rmrr->header.length,
>>>>> +						rmrru->devices, rmrru->devices_cnt);
>>>>> +		if (ret)
>>>>> +			break;
>>>>> +	}
>>>>> +	return 0;
>>>>> +}
>>>>>       
>>>>>       int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
>>>>>       {
>>>>> @@ -4523,7 +4541,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
>>>>>       		rmrr = container_of(rmrru->hdr,
>>>>>       				    struct acpi_dmar_reserved_memory, header);
>>>>>       		if (info->event == BUS_NOTIFY_ADD_DEVICE) {
>>>>> -			ret = dmar_insert_dev_scope(info, (void *)(rmrr + 1),
>>>>> +			ret = dmar_pci_insert_dev_scope(info, (void *)(rmrr + 1),
>>>>>       				((void *)rmrr) + rmrr->header.length,
>>>>>       				rmrr->segment, rmrru->devices,
>>>>>       				rmrru->devices_cnt);
>>>>> @@ -4541,7 +4559,7 @@ int dmar_iommu_notify_scope_dev(struct
>>>>> dmar_pci_notify_info *info)
>>>>>       
>>>>>       		atsr = container_of(atsru->hdr, struct acpi_dmar_atsr, header);
>>>>>       		if (info->event == BUS_NOTIFY_ADD_DEVICE) {
>>>>> -			ret = dmar_insert_dev_scope(info, (void *)(atsr + 1),
>>>>> +			ret = dmar_pci_insert_dev_scope(info, (void *)(atsr + 1),
>>>>>       					(void *)atsr + atsr->header.length,
>>>>>       					atsr->segment, atsru->devices,
>>>>>       					atsru->devices_cnt);
>>>>> @@ -4779,6 +4797,26 @@ static int __init
>>>>> platform_optin_force_iommu(void)
>>>>>       
>>>>>       	return 1;
>>>>>       }
>>>>> +static int acpi_device_create_direct_mappings(struct device
>>>>> +*pn_dev, struct device *acpi_device) {
>>>>> +	int ret;
>>>>> +	struct iommu_group *group;
>>>>> +
>>>>> +	if (pn_dev == NULL) {
>>>>> +		acpi_device->bus->iommu_ops = &intel_iommu_ops;
>>>>> +		ret = iommu_probe_device(acpi_device);
>>>>> +		if (ret) {
>>>>> +			pr_err("acpi_device probe fail! ret:%d\n", ret);
>>>>> +			return ret;
>>>>> +		}
>>>>> +		return 0;
>>>>> +	}
>>>>> +	acpi_device->bus->iommu_ops = &intel_iommu_ops;
>>>>> +	group = iommu_group_get(pn_dev);
>>>>> +	__acpi_device_create_direct_mappings(group, acpi_device);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>>       
>>>>>       static int __init probe_acpi_namespace_devices(void)
>>>>>       {
>>>>> @@ -4794,6 +4832,7 @@ static int __init probe_acpi_namespace_devices(void)
>>>>>       			struct acpi_device_physical_node *pn;
>>>>>       			struct iommu_group *group;
>>>>>       			struct acpi_device *adev;
>>>>> +			struct device *pn_dev = NULL;
>>>>>       
>>>>>       			if (dev->bus != &acpi_bus_type)
>>>>>       				continue;
>>>>> @@ -4804,6 +4843,7 @@ static int __init probe_acpi_namespace_devices(void)
>>>>>       					    &adev->physical_node_list, node) {
>>>>>       				group = iommu_group_get(pn->dev);
>>>>>       				if (group) {
>>>>> +					pn_dev = pn->dev;
>>>>>       					iommu_group_put(group);
>>>>>       					continue;
>>>>>       				}
>>>>> @@ -4812,7 +4852,9 @@ static int __init probe_acpi_namespace_devices(void)
>>>>>       				ret = iommu_probe_device(pn->dev);
>>>>>       				if (ret)
>>>>>       					break;
>>>>> +				pn_dev = pn->dev;
>>>>>       			}
>>>>> +			ret = acpi_device_create_direct_mappings(pn_dev, dev);
>>>>>       			mutex_unlock(&adev->physical_node_lock);
>>>>>       
>>>>>       			if (ret)
>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
>>>>> 609bd25bf154..4f714a2d5ef7 100644
>>>>> --- a/drivers/iommu/iommu.c
>>>>> +++ b/drivers/iommu/iommu.c
>>>>> @@ -779,6 +779,12 @@ static bool iommu_is_attach_deferred(struct iommu_domain *domain,
>>>>>       	return false;
>>>>>       }
>>>>>       
>>>>> +void  __acpi_device_create_direct_mappings(struct iommu_group
>>>>> +*group, struct device *acpi_device) {
>>>>> +	iommu_create_device_direct_mappings(group, acpi_device); }
>>>>> +EXPORT_SYMBOL_GPL(__acpi_device_create_direct_mappings);
>>>>> +
>>>>>       /**
>>>>>        * iommu_group_add_device - add a device to an iommu group
>>>>>        * @group: the group into which to add the device (reference
>>>>> should be held) diff --git a/include/linux/dmar.h
>>>>> b/include/linux/dmar.h index 65565820328a..881ac61a4336 100644
>>>>> --- a/include/linux/dmar.h
>>>>> +++ b/include/linux/dmar.h
>>>>> @@ -113,10 +113,14 @@ extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
>>>>>       				struct dmar_dev_scope **devices, u16 segment);
>>>>>       extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
>>>>>       extern void dmar_free_dev_scope(struct dmar_dev_scope
>>>>> **devices, int *cnt); -extern int dmar_insert_dev_scope(struct
>>>>> dmar_pci_notify_info *info,
>>>>> +extern int dmar_pci_insert_dev_scope(struct dmar_pci_notify_info
>>>>> +*info,
>>>>>       				 void *start, void*end, u16 segment,
>>>>>       				 struct dmar_dev_scope *devices,
>>>>>       				 int devices_cnt);
>>>>> +extern int dmar_acpi_insert_dev_scope(u8 device_number,
>>>>> +				struct acpi_device *adev, void *start, void *end,
>>>>> +				struct dmar_dev_scope *devices, int devices_cnt);
>>>>> +
>>>>>       extern int dmar_remove_dev_scope(struct dmar_pci_notify_info *info,
>>>>>       				 u16 segment, struct dmar_dev_scope *devices,
>>>>>       				 int count);
>>>>> @@ -140,6 +144,7 @@ extern int dmar_parse_one_atsr(struct acpi_dmar_header *header, void *arg);
>>>>>       extern int dmar_check_one_atsr(struct acpi_dmar_header *hdr, void *arg);
>>>>>       extern int dmar_release_one_atsr(struct acpi_dmar_header *hdr, void *arg);
>>>>>       extern int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru,
>>>>> bool insert);
>>>>> +extern int dmar_rmrr_add_acpi_dev(u8 device_number, struct
>>>>> +acpi_device *adev);
>>>>>       extern int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info);
>>>>>       #else /* !CONFIG_INTEL_IOMMU: */
>>>>>       static inline int intel_iommu_init(void) { return -ENODEV; }
>>>>> @@
>>>>> -150,6 +155,11 @@ static inline void intel_iommu_shutdown(void) { }
>>>>>       #define	dmar_check_one_atsr		dmar_res_noop
>>>>>       #define	dmar_release_one_atsr		dmar_res_noop
>>>>>       
>>>>> +static inline int dmar_rmrr_add_acpi_dev(u8 device_number, struct
>>>>> +acpi_device *adev) {
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>       static inline int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
>>>>>       {
>>>>>       	return 0;
>>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
>>>>> fee209efb756..9be134775886 100644
>>>>> --- a/include/linux/iommu.h
>>>>> +++ b/include/linux/iommu.h
>>>>> @@ -514,6 +514,9 @@ extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
>>>>>       extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
>>>>>       			      unsigned long iova, int flags);
>>>>>       
>>>>> +extern void __acpi_device_create_direct_mappings(struct iommu_group *group,
>>>>> +						struct device *acpi_device);
>>>>> +
>>>>>       static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
>>>>>       {
>>>>>       	if (domain->ops->flush_iotlb_all)
>>>>>
