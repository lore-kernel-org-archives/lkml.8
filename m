Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4F2C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD99320848
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgH2K4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:56:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:60007 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgH2Kzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:55:37 -0400
IronPort-SDR: xA4aNxm5G1MPMSV4g57rEH/BnpcL69lxj+sZYn2comYYHNeP33R9mK2vU9PHyGT0bXemILcykJ
 sV+6wWNfhQHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="157807118"
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="157807118"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 03:55:36 -0700
IronPort-SDR: jepVJiZHigirgJG8hB2a6rqM8nfB9gHvja9lJDNkPzODR31JJZwdc/wT2dJ/TxYXPrtpFGeyIB
 qlkuB7ufGgmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,367,1592895600"; 
   d="scan'208";a="324338400"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2020 03:55:33 -0700
Date:   Sat, 29 Aug 2020 18:55:32 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     <linux-kernel@vger.kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, <x86@kernel.org>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20200829105532.GE13723@shuo-intel.sh.intel.com>
References: <20200825024516.16766-1-shuo.a.liu@intel.com>
 <20200825024516.16766-7-shuo.a.liu@intel.com>
 <20200828102704.GB1470435@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200828102704.GB1470435@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri 28.Aug'20 at 12:27:04 +0200, Greg Kroah-Hartman wrote:
>On Tue, Aug 25, 2020 at 10:45:06AM +0800, shuo.a.liu@intel.com wrote:
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
>> ---
>>  drivers/virt/acrn/Makefile    |  2 +-
>>  drivers/virt/acrn/acrn_drv.h  | 16 ++++++++-
>>  drivers/virt/acrn/hsm.c       | 58 +++++++++++++++++++++++++++++-
>>  drivers/virt/acrn/hypercall.h | 62 ++++++++++++++++++++++++++++++++
>>  drivers/virt/acrn/vm.c        | 66 +++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/acrn.h     | 36 +++++++++++++++++++
>>  6 files changed, 237 insertions(+), 3 deletions(-)
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
>> index 36f43d8d43d0..35fcb5cbbff3 100644
>> --- a/drivers/virt/acrn/acrn_drv.h
>> +++ b/drivers/virt/acrn/acrn_drv.h
>> @@ -10,12 +10,26 @@
>>
>>  #define ACRN_INVALID_VMID (0xffffU)
>>
>> +#define ACRN_VM_FLAG_DESTROYED		0U
>> +extern struct list_head acrn_vm_list;
>> +extern rwlock_t acrn_vm_list_lock;
>>  /**
>>   * struct acrn_vm - Properties of ACRN User VM.
>> + * @list:	Entry within global list of all VMs
>>   * @vmid:	User VM ID
>> + * @vcpu_num:	Number of virtual CPUs in the VM
>> + * @flags:	Flags (ACRN_VM_FLAG_*) of the VM. This is VM flag management
>> + *		in HSM which is different from the &acrn_vm_creation.vm_flag.
>>   */
>>  struct acrn_vm {
>> -	u16	vmid;
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
>> index a08169f35c96..ed8921a6c68b 100644
>> --- a/drivers/virt/acrn/hsm.c
>> +++ b/drivers/virt/acrn/hsm.c
>> @@ -45,19 +45,75 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
>>  static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>>  			   unsigned long ioctl_param)
>>  {
>> +	struct acrn_vm *vm = filp->private_data;
>> +	struct acrn_vm_creation *vm_param;
>> +	int ret = 0;
>> +
>>  	if (cmd == ACRN_IOCTL_GET_API_VERSION) {
>>  		if (copy_to_user((void __user *)ioctl_param,
>>  				 &api_version, sizeof(api_version)))
>>  			return -EFAULT;
>> +		return 0;
>>  	}
>>
>> -	return 0;
>> +	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
>> +		pr_err("ioctl 0x%x: Invalid VM state!\n", cmd);
>
>For this whole driver, you have a real 'struct device' to use, please
>use it for all of these error messages everywhere.  dev_err() gives you
>much more information than pr_err() does.

OK. I will use dev_err() instead.

>
>Same everywhere in this patch series.

Sure.

Thanks
shuo
