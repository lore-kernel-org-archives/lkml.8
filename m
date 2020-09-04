Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74572C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504E5206CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIDEkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 00:40:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:64597 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgIDEkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 00:40:00 -0400
IronPort-SDR: GicBLU7aOz9GmRy63zWLbhi9IZXX2SoIY99M1uo6m3znExbi0bG1tczjJhvOmFgF11Y/h20dYA
 00S1GVcfIwNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="157700170"
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; 
   d="scan'208";a="157700170"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 21:39:59 -0700
IronPort-SDR: vPCwzAlOwsfHd5loa5iIKb8ynDAIMtKRdz0Porl/lDM0a9YPIrkweuuIC+OjFN8yFFsotnhahG
 OSAV+arkrjMg==
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; 
   d="scan'208";a="478316190"
Received: from sliu49-mobl1.ccr.corp.intel.com (HELO [10.249.174.205]) ([10.249.174.205])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 21:39:56 -0700
Subject: Re: [PATCH v2 07/17] virt: acrn: Introduce an ioctl to set vCPU
 registers state
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
 <20200903124201.17275-8-shuo.a.liu@intel.com>
 <20200903130325.GC2778029@kroah.com>
From:   "Liu, Shuo A" <shuo.a.liu@intel.com>
Message-ID: <89b140af-e128-46d8-191e-8b7d8e0620c0@intel.com>
Date:   Fri, 4 Sep 2020 12:39:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903130325.GC2778029@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 9/3/2020 21:03, Greg Kroah-Hartman wrote:
> On Thu, Sep 03, 2020 at 08:41:51PM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> A virtual CPU of User VM has different context due to the different
>> registers state. ACRN userspace needs to set the virtual CPU
>> registers state (e.g. giving a initial registers state to a virtual
>> BSP of a User VM).
>>
>> HSM provides an ioctl ACRN_IOCTL_SET_VCPU_REGS to do the virtual CPU
>> registers state setting. The ioctl passes the registers state from ACRN
>> userspace to the hypervisor directly.
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
>>  drivers/virt/acrn/hsm.c       | 14 +++++++
>>  drivers/virt/acrn/hypercall.h | 13 +++++++
>>  include/uapi/linux/acrn.h     | 71 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 98 insertions(+)
>>
>> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
>> index 6ec6aa9053d3..13df76d0206e 100644
>> --- a/drivers/virt/acrn/hsm.c
>> +++ b/drivers/virt/acrn/hsm.c
>> @@ -12,6 +12,7 @@
>>  #define pr_fmt(fmt) "acrn: " fmt
>>  #define dev_fmt(fmt) "acrn: " fmt
>>  
>> +#include <linux/io.h>
>>  #include <linux/miscdevice.h>
>>  #include <linux/mm.h>
>>  #include <linux/module.h>
>> @@ -49,6 +50,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>>  {
>>  	struct acrn_vm *vm = filp->private_data;
>>  	struct acrn_vm_creation *vm_param;
>> +	struct acrn_vcpu_regs *cpu_regs;
>>  	int ret = 0;
>>  
>>  	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
>> @@ -96,6 +98,18 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>>  	case ACRN_IOCTL_DESTROY_VM:
>>  		ret = acrn_vm_destroy(vm);
>>  		break;
>> +	case ACRN_IOCTL_SET_VCPU_REGS:
>> +		cpu_regs = memdup_user((void __user *)ioctl_param,
>> +				       sizeof(struct acrn_vcpu_regs));
>> +		if (IS_ERR(cpu_regs))
>> +			return PTR_ERR(cpu_regs);
>> +
>> +		ret = hcall_set_vcpu_regs(vm->vmid, virt_to_phys(cpu_regs));
> 
> No sanity checking of any arguments?

The HSM driver has limited VM status maintenance so it doesn't have full
ability to do the sanity checking.

> 
> Wow, fuzzers are going to have a fun time with your hypervisor, good
> luck!  :)

The hypervisor has some sanity checking. :)

Thanks
shuo
