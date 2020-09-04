Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F5AC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 01:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3C420758
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 01:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgIDBM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 21:12:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:15668 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgIDBM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 21:12:56 -0400
IronPort-SDR: qaLi+hVmA1bQH1k/WDPGPuEtcW9a9SMTcFneM3zyd6FggmnbfAnUzmW9yJAi8UDmrIbKqRYt2t
 lrkAnATPL+nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="158658854"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="158658854"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 18:12:55 -0700
IronPort-SDR: 1A2Grwsws4l6bNTQS50Sh+Kbul7Nb1FbNeb8S1u8XR52KiDvMuqDxu7vfS6k1yznVa3MuQomR7
 dwNfQbDokatg==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="478264128"
Received: from sliu49-mobl1.ccr.corp.intel.com (HELO [10.249.174.205]) ([10.249.174.205])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 18:12:51 -0700
Subject: Re: [PATCH v2 05/17] virt: acrn: Introduce ACRN HSM basic driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20200903124201.17275-1-shuo.a.liu@intel.com>
 <20200903124201.17275-6-shuo.a.liu@intel.com>
 <20200903125359.GA2778029@kroah.com>
From:   "Liu, Shuo A" <shuo.a.liu@intel.com>
Message-ID: <f2f33bee-8aef-f2e6-89a3-4e417dc6071d@intel.com>
Date:   Fri, 4 Sep 2020 09:12:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903125359.GA2778029@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/2020 20:53, Greg Kroah-Hartman wrote:
> On Thu, Sep 03, 2020 at 08:41:49PM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> ACRN Hypervisor Service Module (HSM) is a kernel module in Service VM
>> which communicates with ACRN userspace through ioctls and talks to ACRN
>> Hypervisor through hypercalls.
>>
>> Add a basic HSM driver which allows Service VM userspace to communicate
>> with ACRN. The following patches will add more ioctls, guest VM memory
>> mapping caching, I/O request processing, ioeventfd and irqfd into this
>> module. HSM exports a char device interface (/dev/acrn_hsm) to userspace.
>>
>> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Zhi Wang <zhi.a.wang@intel.com>
>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> Cc: Yu Wang <yu1.wang@intel.com>
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>>  MAINTAINERS                                   |  2 +
>>  drivers/virt/Kconfig                          |  2 +
>>  drivers/virt/Makefile                         |  1 +
>>  drivers/virt/acrn/Kconfig                     | 14 +++
>>  drivers/virt/acrn/Makefile                    |  3 +
>>  drivers/virt/acrn/acrn_drv.h                  | 19 ++++
>>  drivers/virt/acrn/hsm.c                       | 98 +++++++++++++++++++
>>  include/uapi/linux/acrn.h                     | 17 ++++
>>  9 files changed, 157 insertions(+)
>>  create mode 100644 drivers/virt/acrn/Kconfig
>>  create mode 100644 drivers/virt/acrn/Makefile
>>  create mode 100644 drivers/virt/acrn/acrn_drv.h
>>  create mode 100644 drivers/virt/acrn/hsm.c
>>  create mode 100644 include/uapi/linux/acrn.h
>>
>> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> index 2a198838fca9..ac60efedb104 100644
>> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
>> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
>> @@ -319,6 +319,7 @@ Code  Seq#    Include File                                           Comments
>>  0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
>>                                                                       <mailto:kenji@bitgate.com>
>>  0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
>> +0xA2  all    uapi/linux/acrn.h                                       ACRN hypervisor
> 
> You don't have any ioctls in this patch, so why add this documentation
> here? 

This was left when i removed an api version ioctl from the v1 patch set.
Let me move it to a later patch.

>>  0xA3  80-8F                                                          Port ACL  in development:
>>                                                                       <mailto:tlewis@mindspring.com>
>>  0xA3  90-9F  linux/dtlk.h
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e0fea5e464b4..d4c1ef303c2d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -442,6 +442,8 @@ L:	acrn-dev@lists.projectacrn.org
>>  S:	Supported
>>  W:	https://projectacrn.org
>>  F:	Documentation/virt/acrn/
>> +F:	drivers/virt/acrn/
>> +F:	include/uapi/linux/acrn.h
> 
> This uapi file is not used in this patch, please add it in a later
> patch.

OK.

> 
>> +static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>> +			   unsigned long ioctl_param)
>> +{
>> +	return 0;
>> +}
> 
> As your ioctl does nothing, no need to include it here, add it in a
> later patch.

OK.

> 
>> +
>> +static int acrn_dev_release(struct inode *inode, struct file *filp)
>> +{
>> +	struct acrn_vm *vm = filp->private_data;
>> +
>> +	kfree(vm);
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations acrn_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.open		= acrn_dev_open,
>> +	.release	= acrn_dev_release,
>> +	.unlocked_ioctl	= acrn_dev_ioctl,
>> +};
>> +
>> +static struct miscdevice acrn_dev = {
>> +	.minor	= MISC_DYNAMIC_MINOR,
>> +	.name	= "acrn_hsm",
>> +	.fops	= &acrn_fops,
>> +};
>> +
>> +static int __init hsm_init(void)
>> +{
>> +	int ret;
>> +
>> +	if (x86_hyper_type != X86_HYPER_ACRN)
>> +		return -ENODEV;
>> +
>> +	if (!acrn_is_privileged_vm())
>> +		return -EPERM;
>> +
>> +	ret = misc_register(&acrn_dev);
>> +	if (ret) {
>> +		pr_err("Create misc dev failed!\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
> 
> Tiny tiny nit, these lines can be rewritten as:
> 	if (ret)
> 		pr_err("Create misc dev failed!\n");
> 
> 	return ret;
> 
> :)

OK. Thanks.

> 
>> +}
>> +
>> +static void __exit hsm_exit(void)
>> +{
>> +	misc_deregister(&acrn_dev);
>> +}
>> +module_init(hsm_init);
>> +module_exit(hsm_exit);
>> +
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("ACRN Hypervisor Service Module (HSM)");
>> diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
>> new file mode 100644
>> index 000000000000..4ae34f86e2be
>> --- /dev/null
>> +++ b/include/uapi/linux/acrn.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Userspace interface for /dev/acrn_hsm - ACRN Hypervisor Service Module
>> + *
>> + * This file can be used by applications that need to communicate with the HSM
>> + * via the ioctl interface.
>> + */
>> +
>> +#ifndef _UAPI_ACRN_H
>> +#define _UAPI_ACRN_H
>> +
>> +#include <linux/types.h>
>> +
>> +/* The ioctl type, documented in ioctl-number.rst */
>> +#define ACRN_IOCTL_TYPE			0xA2
> 
> This isn't used in this patch, so save it for a later one please.

Sure. I will move to later one.

Thanks
shuo
