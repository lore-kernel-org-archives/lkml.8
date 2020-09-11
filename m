Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32AEC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E6E2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgIKCrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:47:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:30460 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgIKCrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:47:20 -0400
IronPort-SDR: KJc/wj0yhQXcfwMDSEzEBDeoJzYoj4bu8WfH3RcOqUDhrxMtlKBWgC/PMbUQo2HoqvrJ3yjKC1
 F9KSiVn+baZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="159625704"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="159625704"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 19:47:19 -0700
IronPort-SDR: kfKtYPVFdRCywLByMqGTWO99NBy9P4e1zFHCKMCXz1P4n7VRaHNzwCuQPfWtnl9cAqi3LOpoW2
 OYbWnhdx6l3A==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="506051819"
Received: from sliu49-mobl1.ccr.corp.intel.com (HELO [10.238.13.173]) ([10.238.13.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 19:47:16 -0700
Subject: Re: [PATCH v3 06/17] virt: acrn: Introduce VM management interfaces
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
References: <20200909090836.46762-1-shuo.a.liu@intel.com>
 <20200909090836.46762-7-shuo.a.liu@intel.com>
 <20200909094516.GB607744@kroah.com>
 <20200910061900.GI13723@shuo-intel.sh.intel.com>
 <20200910162810.GB1265411@kroah.com>
From:   "Liu, Shuo A" <shuo.a.liu@intel.com>
Message-ID: <5e089ae2-f4b6-17de-2f91-f0c66c70ab78@intel.com>
Date:   Fri, 11 Sep 2020 10:47:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
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

Hi Greg,

On 9/11/2020 00:28, Greg Kroah-Hartman wrote:
> On Thu, Sep 10, 2020 at 02:19:00PM +0800, Shuo A Liu wrote:
>> On Wed  9.Sep'20 at 11:45:16 +0200, Greg Kroah-Hartman wrote:
>>> On Wed, Sep 09, 2020 at 05:08:25PM +0800, shuo.a.liu@intel.com wrote:
>>>> From: Shuo Liu <shuo.a.liu@intel.com>
>>>>
>>>> The VM management interfaces expose several VM operations to ACRN
>>>> userspace via ioctls. For example, creating VM, starting VM, destroying
>>>> VM and so on.
>>>>
>>>> The ACRN Hypervisor needs to exchange data with the ACRN userspace
>>>> during the VM operations. HSM provides VM operation ioctls to the ACRN
>>>> userspace and communicates with the ACRN Hypervisor for VM operations
>>>> via hypercalls.
>>>>
>>>> HSM maintains a list of User VM. Each User VM will be bound to an
>>>> existing file descriptor of /dev/acrn_hsm. The User VM will be
>>>> destroyed when the file descriptor is closed.
>>>>
>>>> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>>>> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
>>>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>>>> Cc: Zhi Wang <zhi.a.wang@intel.com>
>>>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>>>> Cc: Yu Wang <yu1.wang@intel.com>
>>>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>>  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>>>>  MAINTAINERS                                   |  1 +
>>>>  drivers/virt/acrn/Makefile                    |  2 +-
>>>>  drivers/virt/acrn/acrn_drv.h                  | 22 +++++-
>>>>  drivers/virt/acrn/hsm.c                       | 66 ++++++++++++++++
>>>>  drivers/virt/acrn/hypercall.h                 | 78 +++++++++++++++++++
>>>>  drivers/virt/acrn/vm.c                        | 69 ++++++++++++++++
>>>>  include/uapi/linux/acrn.h                     | 56 +++++++++++++
>>>>  8 files changed, 293 insertions(+), 2 deletions(-)
>>>>  create mode 100644 drivers/virt/acrn/hypercall.h
>>>>  create mode 100644 drivers/virt/acrn/vm.c
>>>>  create mode 100644 include/uapi/linux/acrn.h
>>>>

[...]

>>>> +	ret = hcall_create_vm(virt_to_phys(vm_param));
>>>> +	if (ret < 0 || vm_param->vmid == ACRN_INVALID_VMID) {
>>>> +		dev_err(vm->dev, "Failed to create VM! Error: %d\n", ret);
>>>> +		return NULL;
>>>> +	}
>>>> +
>>>> +	vm->vmid = vm_param->vmid;
>>>> +	vm->vcpu_num = vm_param->vcpu_num;
>>>> +
>>>> +	write_lock_bh(&acrn_vm_list_lock);
>>>> +	list_add(&vm->list, &acrn_vm_list);
>>>
>>> Wait, why do you have a global list of devices?  Shouldn't that device
>>> be tied to the vm structure?  Who will be iterating this list that does
>>> not have the file handle to start with?
>>
>> Active VMs in this list will be used by the I/O requests dispatching
>> tasklet ioreq_tasklet, whose callback function is ioreq_tasklet_handler()
>> in patch 0009. ioreq_tasklet_handler() currently handles the notification
>> interrupt from the hypervisor and dispatches I/O requests to each VMs.
> 
> So you need to somehow look through the whole list of devices for every
> I/O request?  That feels really really wrong, why don't you have that
> pointer in the first place?
> 
> Again, step back and describe what you need/desire and then think about
> how to best solve that.  Almost always, a list of objects that you have
> to iterate over all the time is not the way to do it...

Each VM has a shared buffer for I/O requests passing with the
hypervisor. Currently, the hypervisor doesn't indicate the VMs which has
pending I/O requests. So when kernel get the notification interrupt, it
search all VMs' shared buffer and dispatch the pending I/O requests.

The current I/O requests dispatching implementation uses one global
tasklet (be scheduled in the hypervisor notification interrupt), so it
needs to iterate all VMs to do the dispatching.

Each VM has a dedicated hypervisor notification interrupt vector might
be suited (a vector can be linked with a VM). The disadvantage is that
it might occupy many vectors.

Looking forward to more suggestions. Thanks very much.

> 
> Somedays I think we need an "here's how to do the things you really need
> to do in a driver" chapter in the Linux Device Driver's book..
That will be great. :)

Thanks
shuo
