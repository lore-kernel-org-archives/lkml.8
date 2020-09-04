Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3AEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3836620748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIDE3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 00:29:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:4722 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgIDE3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 00:29:18 -0400
IronPort-SDR: MTIYFWNk/HCu4NbQrMa/JoYu6RXkVBiTiMWdCZBxg4rs1MzrqccGy0hXZ7uZfJmdkPAHOTd4+1
 BxUuwPrWiSOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="242512030"
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; 
   d="scan'208";a="242512030"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 21:29:13 -0700
IronPort-SDR: vP/tGVpVmxWP+0Zx4QvsGNmU/Rrkw+R1kwrXn6/aAv2Kx/yOGuVoYL2lAMkLRbwbBo7sa2U2Jn
 XQ21ZWzvVo2Q==
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; 
   d="scan'208";a="478313934"
Received: from sliu49-mobl1.ccr.corp.intel.com (HELO [10.249.174.205]) ([10.249.174.205])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 21:29:10 -0700
Subject: Re: [PATCH v2 06/17] virt: acrn: Introduce VM management interfaces
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20200903124201.17275-1-shuo.a.liu@intel.com>
 <20200903124201.17275-7-shuo.a.liu@intel.com>
 <20200903130239.GB2778029@kroah.com>
From:   "Liu, Shuo A" <shuo.a.liu@intel.com>
Message-ID: <1946bf48-fda7-20e0-246d-93414a1a67f5@intel.com>
Date:   Fri, 4 Sep 2020 12:29:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903130239.GB2778029@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 9/3/2020 21:02, Greg Kroah-Hartman wrote:
> On Thu, Sep 03, 2020 at 08:41:50PM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> The VM management interfaces expose several VM operations to ACRN
>> userspace via ioctls. For example, creating VM, starting VM, destroying
>> VM and so on.
>>
>> The ACRN Hypervisor needs to exchange data with the ACRN userspace
>> during the VM operations. HSM provides VM operation ioctls to the ACRN
>> userspace and communicates with the ACRN Hypervisor for VM operations
>> via hypercalls.
>>
>> HSM maintains a list of User VM. Each User VM will be bound to an
>> existing file descriptor of /dev/acrn_hsm. The User VM will be
>> destroyed when the file descriptor is closed.
>>
>> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Zhi Wang <zhi.a.wang@intel.com>
>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> Cc: Yu Wang <yu1.wang@intel.com>
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  drivers/virt/acrn/Makefile    |  2 +-
>>  drivers/virt/acrn/acrn_drv.h  | 21 +++++++++-
>>  drivers/virt/acrn/hsm.c       | 62 +++++++++++++++++++++++++++-
>>  drivers/virt/acrn/hypercall.h | 78 +++++++++++++++++++++++++++++++++++
>>  drivers/virt/acrn/vm.c        | 67 ++++++++++++++++++++++++++++++
>>  include/uapi/linux/acrn.h     | 39 ++++++++++++++++++
>>  6 files changed, 266 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/virt/acrn/hypercall.h
>>  create mode 100644 drivers/virt/acrn/vm.c
>>
>> diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
>> index 6920ed798aaf..cf8b4ed5e74e 100644
>> --- a/drivers/virt/acrn/Makefile
>> +++ b/drivers/virt/acrn/Makefile
>> @@ -1,3 +1,3 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_ACRN_HSM)	:= acrn.o
>> -acrn-y := hsm.o
>> +acrn-y := hsm.o vm.o
>> diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
>> index 0b8e4fdc168a..043ae6840995 100644
>> --- a/drivers/virt/acrn/acrn_drv.h
>> +++ b/drivers/virt/acrn/acrn_drv.h
>> @@ -4,16 +4,35 @@
>>  #define __ACRN_HSM_DRV_H
>>  
>>  #include <linux/acrn.h>
>> +#include <linux/dev_printk.h>
>>  #include <linux/types.h>
>>  
>> +#include "hypercall.h"
>> +
>>  #define ACRN_INVALID_VMID (0xffffU)
>>  
>> +#define ACRN_VM_FLAG_DESTROYED		0U
>> +extern struct list_head acrn_vm_list;
>> +extern rwlock_t acrn_vm_list_lock;
>>  /**
>>   * struct acrn_vm - Properties of ACRN User VM.
>> + * @dev:	The struct device this VM belongs to
>> + * @list:	Entry within global list of all VMs
>>   * @vmid:	User VM ID
>> + * @vcpu_num:	Number of virtual CPUs in the VM
>> + * @flags:	Flags (ACRN_VM_FLAG_*) of the VM. This is VM flag management
>> + *		in HSM which is different from the &acrn_vm_creation.vm_flag.
>>   */
>>  struct acrn_vm {
>> -	u16	vmid;
>> +	struct device		*dev;
>> +	struct list_head	list;
>> +	u16			vmid;
>> +	int			vcpu_num;
>> +	unsigned long		flags;
>>  };
>>  
>> +struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
>> +			       struct acrn_vm_creation *vm_param);
>> +int acrn_vm_destroy(struct acrn_vm *vm);
>> +
>>  #endif /* __ACRN_HSM_DRV_H */
>> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
>> index 549c7f8d6b5f..6ec6aa9053d3 100644
>> --- a/drivers/virt/acrn/hsm.c
>> +++ b/drivers/virt/acrn/hsm.c
>> @@ -10,6 +10,7 @@
>>   */
>>  
>>  #define pr_fmt(fmt) "acrn: " fmt
>> +#define dev_fmt(fmt) "acrn: " fmt
> 
> This should not be needed anywhere, what is wrong with the default
> prefix given to you by the dev_*() calls?

OK, the default prefix is enough. I will remove this define.

> 
>>  
>>  #include <linux/miscdevice.h>
>>  #include <linux/mm.h>
>> @@ -21,6 +22,8 @@
>>  
>>  #include "acrn_drv.h"
>>  
>> +static struct device *dev;
> 
> Um, why?  This feels really odd...

Sorry, my foolish. :)
Will use 'static struct miscdevice acrn_dev' directly.

>> +
>>  /*
>>   * When /dev/acrn_hsm is opened, a 'struct acrn_vm' object is created to
>>   * represent a VM instance and continues to be associated with the opened file
>> @@ -36,6 +39,7 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
>>  		return -ENOMEM;
>>  
>>  	vm->vmid = ACRN_INVALID_VMID;
>> +	vm->dev = dev;
>>  	filp->private_data = vm;
>>  	return 0;
>>  }
>> @@ -43,13 +47,68 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
>>  static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>>  			   unsigned long ioctl_param)
>>  {
>> -	return 0;
>> +	struct acrn_vm *vm = filp->private_data;
>> +	struct acrn_vm_creation *vm_param;
>> +	int ret = 0;
>> +
>> +	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
>> +		dev_err(dev, "ioctl 0x%x: Invalid VM state!\n", cmd);
>> +		return -EFAULT;
>> +	}
>> +
>> +	switch (cmd) {
>> +	case ACRN_IOCTL_CREATE_VM:
>> +		vm_param = memdup_user((void __user *)ioctl_param,
>> +				       sizeof(struct acrn_vm_creation));
>> +		if (IS_ERR(vm_param))
>> +			return PTR_ERR(vm_param);
>> +
>> +		vm = acrn_vm_create(vm, vm_param);
>> +		if (!vm) {
>> +			ret = -EFAULT;
>> +			kfree(vm_param);
>> +			break;
>> +		}
>> +
>> +		if (copy_to_user((void __user *)ioctl_param, vm_param,
>> +				 sizeof(struct acrn_vm_creation))) {
>> +			acrn_vm_destroy(vm);
>> +			ret = -EFAULT;
>> +		}
>> +
>> +		kfree(vm_param);
>> +		break;
>> +	case ACRN_IOCTL_START_VM:
>> +		ret = hcall_start_vm(vm->vmid);
>> +		if (ret < 0)
>> +			dev_err(dev, "Failed to start VM %u!\n", vm->vmid);
>> +		break;
>> +	case ACRN_IOCTL_PAUSE_VM:
>> +		ret = hcall_pause_vm(vm->vmid);
>> +		if (ret < 0)
>> +			dev_err(dev, "Failed to pause VM %u!\n", vm->vmid);
>> +		break;
>> +	case ACRN_IOCTL_RESET_VM:
>> +		ret = hcall_reset_vm(vm->vmid);
>> +		if (ret < 0)
>> +			dev_err(dev, "Failed to restart VM %u!\n", vm->vmid);
>> +		break;
>> +	case ACRN_IOCTL_DESTROY_VM:
>> +		ret = acrn_vm_destroy(vm);
>> +		break;
>> +	default:
>> +		dev_warn(dev, "Unknown IOCTL 0x%x!\n", cmd);
>> +		ret = -ENOTTY;
>> +	}
>> +
>> +	return ret;
>>  }
>>  
>>  static int acrn_dev_release(struct inode *inode, struct file *filp)
>>  {
>>  	struct acrn_vm *vm = filp->private_data;
>>  
>> +	acrn_vm_destroy(vm);
>>  	kfree(vm);
>>  	return 0;
>>  }
>> @@ -83,6 +142,7 @@ static int __init hsm_init(void)
>>  		return ret;
>>  	}
>>  
>> +	dev = acrn_dev.this_device;
> 
> Oh wow.  No, please no.  You just broke reference counting rules.
> 
> Put this in your file-handle-specific structure, not in a global
> structure, that's going to break into loads of tiny pieces if you ever
> glance wrong at it...
> 
> And as always, when you save a pointer to something, you HAVE TO
> REFERENCE COUNT IT!  Otherwise it will go away from you without you
> noticing and bad thigns will happen.
> 
> There's a reason we have the functions get_device(), don't ignore it
> please...

Thanks for reminding. Will use the helpers.

> 
>> +#define HC_ID_VM_BASE			0x10UL
> 
> Why 10?

the hypercalls are grouped with each group has a 0x10 items.
There was also a 0, which was removed with api verison hypercall.
The last patch will introduce another hypercall using group 0.


>> +#define HC_CREATE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x00)
>> +#define HC_DESTROY_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x01)
>> +#define HC_START_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x02)
>> +#define HC_PAUSE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x03)
>> +#define HC_RESET_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x05)
>> +
>> +/**
>> + * hcall_create_vm() - Create a User VM
>> + * @vminfo:	Service VM GPA of info of User VM creation
>> + *
>> + * Return: 0 on success, <0 on failure
>> + */
>> +static inline long hcall_create_vm(u64 vminfo)
>> +{
>> +	return acrn_hypercall1(HC_CREATE_VM, vminfo);
>> +}
>> +
>> +/**
>> + * hcall_start_vm() - Start a User VM
>> + * @vmid:	User VM ID
>> + *
>> + * Return: 0 on success, <0 on failure
>> + */
>> +static inline long hcall_start_vm(u64 vmid)
>> +{
>> +	return acrn_hypercall1(HC_START_VM, vmid);
>> +}
>> +
>> +/**
>> + * hcall_pause_vm() - Pause a User VM
>> + * @vmid:	User VM ID
>> + *
>> + * Return: 0 on success, <0 on failure
>> + */
>> +static inline long hcall_pause_vm(u64 vmid)
>> +{
>> +	return acrn_hypercall1(HC_PAUSE_VM, vmid);
>> +}
>> +
>> +/**
>> + * hcall_destroy_vm() - Destroy a User VM
>> + * @vmid:	User VM ID
>> + *
>> + * Return: 0 on success, <0 on failure
>> + */
>> +static inline long hcall_destroy_vm(u64 vmid)
>> +{
>> +	return acrn_hypercall1(HC_DESTROY_VM, vmid);
>> +}
>> +
>> +/**
>> + * hcall_reset_vm() - Reset a User VM
>> + * @vmid:	User VM ID
>> + *
>> + * Return: 0 on success, <0 on failure
>> + */
>> +static inline long hcall_reset_vm(u64 vmid)
>> +{
>> +	return acrn_hypercall1(HC_RESET_VM, vmid);
>> +}
> 
> Why are you putting these as inline functions? 

There are short and in header file. Isn't it preferred?

 ANd not using the acrn_*
> prefix for them?

The original reason is that the header file in the driver's own
directory with 'static inline'. So i thought there are  no symbol name
pollution.

I can add the prefix if you think it is better to have.

> 
>> +#endif /* __ACRN_HSM_HYPERCALL_H */
>> diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
>> new file mode 100644
>> index 000000000000..770322904fcc
>> --- /dev/null
>> +++ b/drivers/virt/acrn/vm.c
>> @@ -0,0 +1,67 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ACRN_HSM: Virtual Machine management
>> + *
>> + * Copyright (C) 2020 Intel Corporation. All rights reserved.
>> + *
>> + * Authors:
>> + *	Jason Chen CJ <jason.cj.chen@intel.com>
>> + *	Yakui Zhao <yakui.zhao@intel.com>
>> + */
>> +#define pr_fmt(fmt) "acrn: " fmt
>> +#define dev_fmt(fmt) "acrn: " fmt
> 
> Both of these should not be needed, right?

OK. I will remove them.

> 
>> +
>> +#include <linux/io.h>
>> +#include <linux/mm.h>
>> +#include <linux/slab.h>
>> +
>> +#include "acrn_drv.h"
>> +
>> +LIST_HEAD(acrn_vm_list);
> 
> static?
> 
>> +DEFINE_RWLOCK(acrn_vm_list_lock);
> 
> static?

They will be used in another file by a later patch.

> 
> What is this locking?  Documentation please...

To protect acrn_vm_list. I will comments for it.

> 
>> +
>> +struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
>> +			       struct acrn_vm_creation *vm_param)
>> +{
>> +	int ret;
>> +
>> +	ret = hcall_create_vm(virt_to_phys(vm_param));
>> +	if (ret < 0 || vm_param->vmid == ACRN_INVALID_VMID) {
>> +		dev_err(vm->dev, "Failed to create VM! Error: %d\n", ret);
>> +		return NULL;
>> +	}
>> +
>> +	vm->vmid = vm_param->vmid;
>> +	vm->vcpu_num = vm_param->vcpu_num;
>> +
>> +	write_lock_bh(&acrn_vm_list_lock);
>> +	list_add(&vm->list, &acrn_vm_list);
>> +	write_unlock_bh(&acrn_vm_list_lock);
>> +
>> +	dev_dbg(vm->dev, "VM %u created.\n", vm->vmid);
>> +	return vm;
>> +}
>> +
>> +int acrn_vm_destroy(struct acrn_vm *vm)
>> +{
>> +	int ret;
>> +
>> +	if (vm->vmid == ACRN_INVALID_VMID ||
>> +	    test_and_set_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags))
>> +		return 0;
>> +
>> +	/* Remove from global VM list */
>> +	write_lock_bh(&acrn_vm_list_lock);
>> +	list_del_init(&vm->list);
>> +	write_unlock_bh(&acrn_vm_list_lock);
>> +
>> +	ret = hcall_destroy_vm(vm->vmid);
>> +	if (ret < 0) {
>> +		dev_err(vm->dev, "Failed to destroy VM %u\n", vm->vmid);
>> +		clear_bit(ACRN_VM_FLAG_DESTROYED, &vm->flags);
>> +		return ret;
>> +	}
>> +	dev_dbg(vm->dev, "VM %u destroyed.\n", vm->vmid);
>> +	vm->vmid = ACRN_INVALID_VMID;
>> +	return 0;
>> +}
>> diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
>> index 4ae34f86e2be..364b1a783074 100644
>> --- a/include/uapi/linux/acrn.h
>> +++ b/include/uapi/linux/acrn.h
>> @@ -11,7 +11,46 @@
>>  
>>  #include <linux/types.h>
>>  
>> +/**
>> + * struct acrn_vm_creation - Info to create a User VM
>> + * @vmid:		User VM ID returned from the hypervisor
>> + * @reserved0:		Reserved
>> + * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
>> + * @reserved1:		Reserved
>> + * @uuid:		UUID of the VM. Pass to hypervisor directly.
>> + * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
>> + * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
>> + *			hypervisor directly.
>> + * @cpu_affinity:	CPU affinity of the VM. Pass to hypervisor directly.
>> + * @reserved2:		Reserved
>> + */
>> +struct acrn_vm_creation {
>> +	__u16	vmid;
>> +	__u16	reserved0;
>> +	__u16	vcpu_num;
>> +	__u16	reserved1;
>> +	__u8	uuid[16];
> 
> Don't we have a uuid type?

Yes. include/uapi/linux/uuid.h

But in this case, we just pass the uuid data from user space to
hypervisor. So, we can remove a header dependeny with using raw data format.

> 
>> +	__u64	vm_flag;
>> +	__u64	ioreq_buf;
>> +	__u64	cpu_affinity;
>> +	__u8	reserved2[8];
>> +} __attribute__((aligned(8)));
> 
> For "reserved" fields, are you ensuring that they are set to 0 now?  If
> not, please do so, otherwise things will break in the future...

These structures are filled by user space, then be passed to hypervisor
via hypercalls. Need kernel fill reserved fields in the transmitting ?

Thanks
shuo
