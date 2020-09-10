Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110A6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3DF214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599756000;
	bh=aAjYBTZ3/89B51LJ2Wk5dGPzivMcjg7GrmlvXzSk3Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A8fj98lZIgyLHuxr25l7jfWFTaGVM2jW/RCd5RdC5TkzMPb+nhJKNa97SKf2ldkii
	 5IqhmKGf1C4F/kafJCbvIlhGe1nffGPRGXKQL63c6kAUjKdzxpbM0f3Ax5+BLzztoz
	 HzkAMsRmJYbcPQ7LYaAlD9lTovnOK2p8Bai+OoKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIJQjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbgIJQfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:35:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F2FC2075A;
        Thu, 10 Sep 2020 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599755282;
        bh=aAjYBTZ3/89B51LJ2Wk5dGPzivMcjg7GrmlvXzSk3Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xg4Eyc35xllZSP2TmUr6B9GmszG4r1jvspO0QO2MFd6xU4cbGjEPo3wyR2E/OYVwZ
         v7omHP/al7ElPqmweJTiQ5DWzIhVyOQuybnXnKjzIGJuWLAydswtfVw4COrKAVdHaY
         osBhnzzOXIUmAQwUfTuNnUJXS/paGvh6pswL+2AI=
Date:   Thu, 10 Sep 2020 18:28:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v3 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20200910162810.GB1265411@kroah.com>
References: <20200909090836.46762-1-shuo.a.liu@intel.com>
 <20200909090836.46762-7-shuo.a.liu@intel.com>
 <20200909094516.GB607744@kroah.com>
 <20200910061900.GI13723@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910061900.GI13723@shuo-intel.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 02:19:00PM +0800, Shuo A Liu wrote:
> Hi Greg,
> 
> On Wed  9.Sep'20 at 11:45:16 +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 09, 2020 at 05:08:25PM +0800, shuo.a.liu@intel.com wrote:
> > > From: Shuo Liu <shuo.a.liu@intel.com>
> > > 
> > > The VM management interfaces expose several VM operations to ACRN
> > > userspace via ioctls. For example, creating VM, starting VM, destroying
> > > VM and so on.
> > > 
> > > The ACRN Hypervisor needs to exchange data with the ACRN userspace
> > > during the VM operations. HSM provides VM operation ioctls to the ACRN
> > > userspace and communicates with the ACRN Hypervisor for VM operations
> > > via hypercalls.
> > > 
> > > HSM maintains a list of User VM. Each User VM will be bound to an
> > > existing file descriptor of /dev/acrn_hsm. The User VM will be
> > > destroyed when the file descriptor is closed.
> > > 
> > > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> > > Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
> > > Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> > > Cc: Zhi Wang <zhi.a.wang@intel.com>
> > > Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> > > Cc: Yu Wang <yu1.wang@intel.com>
> > > Cc: Reinette Chatre <reinette.chatre@intel.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
> > >  MAINTAINERS                                   |  1 +
> > >  drivers/virt/acrn/Makefile                    |  2 +-
> > >  drivers/virt/acrn/acrn_drv.h                  | 22 +++++-
> > >  drivers/virt/acrn/hsm.c                       | 66 ++++++++++++++++
> > >  drivers/virt/acrn/hypercall.h                 | 78 +++++++++++++++++++
> > >  drivers/virt/acrn/vm.c                        | 69 ++++++++++++++++
> > >  include/uapi/linux/acrn.h                     | 56 +++++++++++++
> > >  8 files changed, 293 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/virt/acrn/hypercall.h
> > >  create mode 100644 drivers/virt/acrn/vm.c
> > >  create mode 100644 include/uapi/linux/acrn.h
> > > 
> > > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > index 2a198838fca9..ac60efedb104 100644
> > > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > @@ -319,6 +319,7 @@ Code  Seq#    Include File                                           Comments
> > >  0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
> > >                                                                       <mailto:kenji@bitgate.com>
> > >  0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
> > > +0xA2  all    uapi/linux/acrn.h                                       ACRN hypervisor
> > >  0xA3  80-8F                                                          Port ACL  in development:
> > >                                                                       <mailto:tlewis@mindspring.com>
> > >  0xA3  90-9F  linux/dtlk.h
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 3030d0e93d02..d4c1ef303c2d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -443,6 +443,7 @@ S:	Supported
> > >  W:	https://projectacrn.org
> > >  F:	Documentation/virt/acrn/
> > >  F:	drivers/virt/acrn/
> > > +F:	include/uapi/linux/acrn.h
> > > 
> > >  AD1889 ALSA SOUND DRIVER
> > >  L:	linux-parisc@vger.kernel.org
> > > diff --git a/drivers/virt/acrn/Makefile b/drivers/virt/acrn/Makefile
> > > index 6920ed798aaf..cf8b4ed5e74e 100644
> > > --- a/drivers/virt/acrn/Makefile
> > > +++ b/drivers/virt/acrn/Makefile
> > > @@ -1,3 +1,3 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_ACRN_HSM)	:= acrn.o
> > > -acrn-y := hsm.o
> > > +acrn-y := hsm.o vm.o
> > > diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
> > > index 29eedd696327..043ae6840995 100644
> > > --- a/drivers/virt/acrn/acrn_drv.h
> > > +++ b/drivers/virt/acrn/acrn_drv.h
> > > @@ -3,16 +3,36 @@
> > >  #ifndef __ACRN_HSM_DRV_H
> > >  #define __ACRN_HSM_DRV_H
> > > 
> > > +#include <linux/acrn.h>
> > > +#include <linux/dev_printk.h>
> > >  #include <linux/types.h>
> > > 
> > > +#include "hypercall.h"
> > > +
> > >  #define ACRN_INVALID_VMID (0xffffU)
> > > 
> > > +#define ACRN_VM_FLAG_DESTROYED		0U
> > > +extern struct list_head acrn_vm_list;
> > > +extern rwlock_t acrn_vm_list_lock;
> > >  /**
> > >   * struct acrn_vm - Properties of ACRN User VM.
> > > + * @dev:	The struct device this VM belongs to
> > > + * @list:	Entry within global list of all VMs
> > >   * @vmid:	User VM ID
> > > + * @vcpu_num:	Number of virtual CPUs in the VM
> > > + * @flags:	Flags (ACRN_VM_FLAG_*) of the VM. This is VM flag management
> > > + *		in HSM which is different from the &acrn_vm_creation.vm_flag.
> > >   */
> > >  struct acrn_vm {
> > > -	u16	vmid;
> > > +	struct device		*dev;
> > > +	struct list_head	list;
> > > +	u16			vmid;
> > > +	int			vcpu_num;
> > > +	unsigned long		flags;
> > >  };
> > > 
> > > +struct acrn_vm *acrn_vm_create(struct acrn_vm *vm,
> > > +			       struct acrn_vm_creation *vm_param);
> > > +int acrn_vm_destroy(struct acrn_vm *vm);
> > > +
> > >  #endif /* __ACRN_HSM_DRV_H */
> > > diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> > > index 28a3052ffa55..bc85a3c14f87 100644
> > > --- a/drivers/virt/acrn/hsm.c
> > > +++ b/drivers/virt/acrn/hsm.c
> > > @@ -19,6 +19,8 @@
> > > 
> > >  #include "acrn_drv.h"
> > > 
> > > +static struct miscdevice acrn_dev;
> > > +
> > >  /*
> > >   * When /dev/acrn_hsm is opened, a 'struct acrn_vm' object is created to
> > >   * represent a VM instance and continues to be associated with the opened file
> > > @@ -34,14 +36,77 @@ static int acrn_dev_open(struct inode *inode, struct file *filp)
> > >  		return -ENOMEM;
> > > 
> > >  	vm->vmid = ACRN_INVALID_VMID;
> > > +	vm->dev = get_device(acrn_dev.this_device);
> > 
> > You are grabbing a reference on a static structure?
> 
> acrn_dev is static, but acrn_dev.this_device is not.

But you don't control that device, the misc device core does.

> > 
> > Ugh, who reviewed this code before it was sent out???
> 
> This part was just newly added according to your suggestion.. Please
> refer to
> https://lore.kernel.org/lkml/1946bf48-fda7-20e0-246d-93414a1a67f5@intel.com/

What you were doing there was wrong, and what you are doing here is just
odd.

Step back please, and describe exactly what you are trying to do.  And
then explain how grabbing a reference to the device reference count for
the misc device is going to help solve that issue.


> > > +	ret = hcall_create_vm(virt_to_phys(vm_param));
> > > +	if (ret < 0 || vm_param->vmid == ACRN_INVALID_VMID) {
> > > +		dev_err(vm->dev, "Failed to create VM! Error: %d\n", ret);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	vm->vmid = vm_param->vmid;
> > > +	vm->vcpu_num = vm_param->vcpu_num;
> > > +
> > > +	write_lock_bh(&acrn_vm_list_lock);
> > > +	list_add(&vm->list, &acrn_vm_list);
> > 
> > Wait, why do you have a global list of devices?  Shouldn't that device
> > be tied to the vm structure?  Who will be iterating this list that does
> > not have the file handle to start with?
> 
> Active VMs in this list will be used by the I/O requests dispatching
> tasklet ioreq_tasklet, whose callback function is ioreq_tasklet_handler()
> in patch 0009. ioreq_tasklet_handler() currently handles the notification
> interrupt from the hypervisor and dispatches I/O requests to each VMs.

So you need to somehow look through the whole list of devices for every
I/O request?  That feels really really wrong, why don't you have that
pointer in the first place?

Again, step back and describe what you need/desire and then think about
how to best solve that.  Almost always, a list of objects that you have
to iterate over all the time is not the way to do it...

Somedays I think we need an "here's how to do the things you really need
to do in a driver" chapter in the Linux Device Driver's book...

thanks,

greg k-h
