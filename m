Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D58C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B080206EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599138498;
	bh=tfzu/ZWIp8d2WAZNm1IHe6S3/MEpEsZM5VlFwOuIU00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iHtK9Gw2I8Cxk71BR9hALLSBOi894JJFxRoQ5JfBnosgfzBslrMzLSutFzFiUWJpQ
	 QmKQBlf8sGeKujn/F4p8reE/OmxVGbSKQ3AihoJERdKFsRJYO4wk+jz1LoplaIbty8
	 9W4ySVyT1SNpNOKdaTYK4RzrP62MLcQe6/yr6FAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgICNHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 09:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgICMxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:53:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECB082072A;
        Thu,  3 Sep 2020 12:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599137615;
        bh=tfzu/ZWIp8d2WAZNm1IHe6S3/MEpEsZM5VlFwOuIU00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rp6LONV/3+Siygj3rKc8zUqJMYY285dZqy9PfeYyddjBT9olzZ8t8SkWA10rrKuuR
         1aDh78ixCTcYCMPLYS0NH3ZHfk8Hl5iaGX/ikbf/Y8T7BWcgLi8moiWnTAmc+vimA4
         cGSWZpdXXhR90EIumCcTu1670kIbptuw36hPiSiQ=
Date:   Thu, 3 Sep 2020 14:53:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
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
Subject: Re: [PATCH v2 05/17] virt: acrn: Introduce ACRN HSM basic driver
Message-ID: <20200903125359.GA2778029@kroah.com>
References: <20200903124201.17275-1-shuo.a.liu@intel.com>
 <20200903124201.17275-6-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903124201.17275-6-shuo.a.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 08:41:49PM +0800, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> ACRN Hypervisor Service Module (HSM) is a kernel module in Service VM
> which communicates with ACRN userspace through ioctls and talks to ACRN
> Hypervisor through hypercalls.
> 
> Add a basic HSM driver which allows Service VM userspace to communicate
> with ACRN. The following patches will add more ioctls, guest VM memory
> mapping caching, I/O request processing, ioeventfd and irqfd into this
> module. HSM exports a char device interface (/dev/acrn_hsm) to userspace.
> 
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Yu Wang <yu1.wang@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>  MAINTAINERS                                   |  2 +
>  drivers/virt/Kconfig                          |  2 +
>  drivers/virt/Makefile                         |  1 +
>  drivers/virt/acrn/Kconfig                     | 14 +++
>  drivers/virt/acrn/Makefile                    |  3 +
>  drivers/virt/acrn/acrn_drv.h                  | 19 ++++
>  drivers/virt/acrn/hsm.c                       | 98 +++++++++++++++++++
>  include/uapi/linux/acrn.h                     | 17 ++++
>  9 files changed, 157 insertions(+)
>  create mode 100644 drivers/virt/acrn/Kconfig
>  create mode 100644 drivers/virt/acrn/Makefile
>  create mode 100644 drivers/virt/acrn/acrn_drv.h
>  create mode 100644 drivers/virt/acrn/hsm.c
>  create mode 100644 include/uapi/linux/acrn.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 2a198838fca9..ac60efedb104 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -319,6 +319,7 @@ Code  Seq#    Include File                                           Comments
>  0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
>                                                                       <mailto:kenji@bitgate.com>
>  0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
> +0xA2  all    uapi/linux/acrn.h                                       ACRN hypervisor

You don't have any ioctls in this patch, so why add this documentation
here?

>  0xA3  80-8F                                                          Port ACL  in development:
>                                                                       <mailto:tlewis@mindspring.com>
>  0xA3  90-9F  linux/dtlk.h
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0fea5e464b4..d4c1ef303c2d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -442,6 +442,8 @@ L:	acrn-dev@lists.projectacrn.org
>  S:	Supported
>  W:	https://projectacrn.org
>  F:	Documentation/virt/acrn/
> +F:	drivers/virt/acrn/
> +F:	include/uapi/linux/acrn.h

This uapi file is not used in this patch, please add it in a later
patch.

> +static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> +			   unsigned long ioctl_param)
> +{
> +	return 0;
> +}

As your ioctl does nothing, no need to include it here, add it in a
later patch.

> +
> +static int acrn_dev_release(struct inode *inode, struct file *filp)
> +{
> +	struct acrn_vm *vm = filp->private_data;
> +
> +	kfree(vm);
> +	return 0;
> +}
> +
> +static const struct file_operations acrn_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= acrn_dev_open,
> +	.release	= acrn_dev_release,
> +	.unlocked_ioctl	= acrn_dev_ioctl,
> +};
> +
> +static struct miscdevice acrn_dev = {
> +	.minor	= MISC_DYNAMIC_MINOR,
> +	.name	= "acrn_hsm",
> +	.fops	= &acrn_fops,
> +};
> +
> +static int __init hsm_init(void)
> +{
> +	int ret;
> +
> +	if (x86_hyper_type != X86_HYPER_ACRN)
> +		return -ENODEV;
> +
> +	if (!acrn_is_privileged_vm())
> +		return -EPERM;
> +
> +	ret = misc_register(&acrn_dev);
> +	if (ret) {
> +		pr_err("Create misc dev failed!\n");
> +		return ret;
> +	}
> +
> +	return 0;

Tiny tiny nit, these lines can be rewritten as:
	if (ret)
		pr_err("Create misc dev failed!\n");

	return ret;

:)

> +}
> +
> +static void __exit hsm_exit(void)
> +{
> +	misc_deregister(&acrn_dev);
> +}
> +module_init(hsm_init);
> +module_exit(hsm_exit);
> +
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ACRN Hypervisor Service Module (HSM)");
> diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> new file mode 100644
> index 000000000000..4ae34f86e2be
> --- /dev/null
> +++ b/include/uapi/linux/acrn.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace interface for /dev/acrn_hsm - ACRN Hypervisor Service Module
> + *
> + * This file can be used by applications that need to communicate with the HSM
> + * via the ioctl interface.
> + */
> +
> +#ifndef _UAPI_ACRN_H
> +#define _UAPI_ACRN_H
> +
> +#include <linux/types.h>
> +
> +/* The ioctl type, documented in ioctl-number.rst */
> +#define ACRN_IOCTL_TYPE			0xA2

This isn't used in this patch, so save it for a later one please.

thanks,

greg k-h
