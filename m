Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3179EC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E94BB20855
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgIJSfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:35:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:2108 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgIJSdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:33:47 -0400
IronPort-SDR: wSYNeRRvAS+P7TZvhEhi1sEKZvUy+NQrpPGTzkFoHCspugprrZyYf8Lg1qWU7sX3uGgEO9I6L0
 oY3l2gCP+Uig==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="138128098"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="138128098"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 11:33:43 -0700
IronPort-SDR: 1a/KSLpHMr/+R7JtsXWE2hXmug66deTVdvrtfeesZwCdJX/YgF8I0vNKPFK65vrZ2aRx1LX4FP
 uG4HpMCpUYFQ==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="334266515"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.209.150.7]) ([10.209.150.7])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 11:33:42 -0700
Subject: Re: [PATCH v3 06/17] virt: acrn: Introduce VM management interfaces
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuo A Liu <shuo.a.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20200909090836.46762-1-shuo.a.liu@intel.com>
 <20200909090836.46762-7-shuo.a.liu@intel.com>
 <20200909094516.GB607744@kroah.com>
 <20200910061900.GI13723@shuo-intel.sh.intel.com>
 <20200910162810.GB1265411@kroah.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <df5adcb4-152b-f7fc-fae8-8c93eb2b818b@intel.com>
Date:   Thu, 10 Sep 2020 11:33:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910162810.GB1265411@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuo and Greg,

On 9/10/2020 9:28 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 10, 2020 at 02:19:00PM +0800, Shuo A Liu wrote:
>> On Wed  9.Sep'20 at 11:45:16 +0200, Greg Kroah-Hartman wrote:
>>> On Wed, Sep 09, 2020 at 05:08:25PM +0800, shuo.a.liu@intel.com wrote:

...

>>>>  /**
>>>>   * struct acrn_vm - Properties of ACRN User VM.
>>>> + * @dev:	The struct device this VM belongs to
>>>> + * @list:	Entry within global list of all VMs
>>>>   * @vmid:	User VM ID
>>>> + * @vcpu_num:	Number of virtual CPUs in the VM
>>>> + * @flags:	Flags (ACRN_VM_FLAG_*) of the VM. This is VM flag management
>>>> + *		in HSM which is different from the &acrn_vm_creation.vm_flag.
>>>>   */
>>>>  struct acrn_vm {
>>>> -	u16	vmid;
>>>> +	struct device		*dev;
>>>> +	struct list_head	list;
>>>> +	u16			vmid;
>>>> +	int			vcpu_num;
>>>> +	unsigned long		flags;
>>>>  };
>>>>
>>>> +struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
>>>> +			       struct acrn_vm_creation *vm_param);
>>>> +int acrn_vm_destroy(struct acrn_vm *vm);
>>>> +
>>>>  #endif /* __ACRN_HSM_DRV_H */
>>>> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
>>>> index 28a3052ffa55..bc85a3c14f87 100644
>>>> --- a/drivers/virt/acrn/hsm.c
>>>> +++ b/drivers/virt/acrn/hsm.c
>>>> @@ -19,6 +19,8 @@
>>>>
>>>>  #include "acrn_drv.h"
>>>>
>>>> +static struct miscdevice acrn_dev;
>>>> +
>>>>  /*
>>>>   * When /dev/acrn_hsm is opened, a 'struct acrn_vm' object is created to
>>>>   * represent a VM instance and continues to be associated with the opened file
>>>> @@ -34,14 +36,77 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
>>>>  		return -ENOMEM;
>>>>
>>>>  	vm->vmid = ACRN_INVALID_VMID;
>>>> +	vm->dev = get_device(acrn_dev.this_device);
>>>
>>> You are grabbing a reference on a static structure?
>>
>> acrn_dev is static, but acrn_dev.this_device is not.
> 
> But you don't control that device, the misc device core does.
> 
>>>
>>> Ugh, who reviewed this code before it was sent out???
>>
>> This part was just newly added according to your suggestion.. Please
>> refer to
>> https://lore.kernel.org/lkml/1946bf48-fda7-20e0-246d-93414a1a67f5@intel.com/
> 
> What you were doing there was wrong, and what you are doing here is just
> odd.
> 
> Step back please, and describe exactly what you are trying to do.  And
> then explain how grabbing a reference to the device reference count for
> the misc device is going to help solve that issue.
> 

From what I understand this current path was entered after Greg's
original suggestion from
https://lore.kernel.org/lkml/20200828102704.GB1470435@kroah.com
to replace the pr_xxx() calls with the more informative dev_xxx() ones.

Perhaps all that is needed to follow the original suggestion is to
replace the pr_xxx() calls with dev_xxx(acrn_dev.this_device, ...) ?

(An example of this is drivers/input/serio/userio.c and some others)

The device (acrn_dev.this_device) can be trusted to exist for the
lifetime of the driver since it is removed on module unload where the
misc device is unregistered.

Reinette


