Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8FAC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F3E20786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599139785;
	bh=U7r+JBSfO6GSo/dvzM+GlF/c71/786sO/WzGCOHt/IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QND+wETMTQM2Y6CB44wN7eZisM2l7DvPVa3LZ/BIf0AILth+zaFJbr5yfyzKQtoPl
	 m4y+c3o3wxH6ubZNaMRtB0uTDVOr3sHYt6cynBXvw46R86esj8WPIG36uZglj4DfjQ
	 OtlqMuLZC67ZYFtffQtzeC/lM30c6ZaPqnMVsuPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgICN3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 09:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbgICNDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:03:32 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19CED206EF;
        Thu,  3 Sep 2020 13:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599138181;
        bh=U7r+JBSfO6GSo/dvzM+GlF/c71/786sO/WzGCOHt/IQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POxN7cDS+w1rM1/5rZeiUIhYEJm6Ks5RElG+9VYqR+BuPbHY7BGsC9LZErVF97eJF
         TJswrWsR6hCM/WA4O6QR7afh1VSF3S+2qzAQNGiC23F2Ww8G6VWCPJjRhqlxpolhsg
         RvD1ZXBjnNYaB/oflmuaBqKI/Xtv1Lfwq8BsQ9As=
Date:   Thu, 3 Sep 2020 15:03:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v2 07/17] virt: acrn: Introduce an ioctl to set vCPU
 registers state
Message-ID: <20200903130325.GC2778029@kroah.com>
References: <20200903124201.17275-1-shuo.a.liu@intel.com>
 <20200903124201.17275-8-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903124201.17275-8-shuo.a.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 08:41:51PM +0800, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> A virtual CPU of User VM has different context due to the different
> registers state. ACRN userspace needs to set the virtual CPU
> registers state (e.g. giving a initial registers state to a virtual
> BSP of a User VM).
> 
> HSM provides an ioctl ACRN_IOCTL_SET_VCPU_REGS to do the virtual CPU
> registers state setting. The ioctl passes the registers state from ACRN
> userspace to the hypervisor directly.
> 
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Yu Wang <yu1.wang@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/virt/acrn/hsm.c       | 14 +++++++
>  drivers/virt/acrn/hypercall.h | 13 +++++++
>  include/uapi/linux/acrn.h     | 71 +++++++++++++++++++++++++++++++++++
>  3 files changed, 98 insertions(+)
> 
> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> index 6ec6aa9053d3..13df76d0206e 100644
> --- a/drivers/virt/acrn/hsm.c
> +++ b/drivers/virt/acrn/hsm.c
> @@ -12,6 +12,7 @@
>  #define pr_fmt(fmt) "acrn: " fmt
>  #define dev_fmt(fmt) "acrn: " fmt
>  
> +#include <linux/io.h>
>  #include <linux/miscdevice.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
> @@ -49,6 +50,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  {
>  	struct acrn_vm *vm = filp->private_data;
>  	struct acrn_vm_creation *vm_param;
> +	struct acrn_vcpu_regs *cpu_regs;
>  	int ret = 0;
>  
>  	if (vm->vmid == ACRN_INVALID_VMID && cmd != ACRN_IOCTL_CREATE_VM) {
> @@ -96,6 +98,18 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  	case ACRN_IOCTL_DESTROY_VM:
>  		ret = acrn_vm_destroy(vm);
>  		break;
> +	case ACRN_IOCTL_SET_VCPU_REGS:
> +		cpu_regs = memdup_user((void __user *)ioctl_param,
> +				       sizeof(struct acrn_vcpu_regs));
> +		if (IS_ERR(cpu_regs))
> +			return PTR_ERR(cpu_regs);
> +
> +		ret = hcall_set_vcpu_regs(vm->vmid, virt_to_phys(cpu_regs));

No sanity checking of any arguments?

Wow, fuzzers are going to have a fun time with your hypervisor, good
luck!  :)

