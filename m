Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A64C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E033206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595421851;
	bh=4HoHx6Kg+zuAik+A+6zs2gFpbAbN8jVyumGvH4MQ/FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rPrg56YHwZHRqax8Pux+JIAOGMZyZjkQ8FxZVXj64hxx8g7n+rIsFqSgY15qqYStP
	 tiHf+5iVB5IwqhVBGRoA5Xp90YlCLbXwgQxI94ew87GzV/WoSGWA0LFIvsYDQasLfg
	 KrNy9gFo/wg/jy3IKmr2iFfzZlrbpfrDQRTW0gtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbgGVMoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgGVMoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:44:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872E120658;
        Wed, 22 Jul 2020 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595421849;
        bh=4HoHx6Kg+zuAik+A+6zs2gFpbAbN8jVyumGvH4MQ/FE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxCI1ge74Q9BMpgLBJybC2fYmdKoDMOTQuEuJWQo/Q6bGpLYjDTEXgKLrtRyVexAt
         5W/g0LyoK5/UNGepqlg1NQkAfvU6sSFUUpKimrpY8CT/KImgiRzM/Pi8SczxiyinhF
         rIrLzmRxGvDH3Fw4l5zZMeNJYh8/YF2vH6w09P/k=
Date:   Wed, 22 Jul 2020 14:44:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     WeitaoWangoc <WeitaoWang-oc@zhaoxin.com>
Cc:     mathias.nyman@linux.intel.com, ulf.hansson@linaro.org,
        vkoul@kernel.org, hslester96@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Carsten_Schmid@mentor.com,
        efremov@linux.com, tonywwang@zhaoxin.com, weitaowang@zhaoxin.com,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, wwt8723@163.com
Subject: Re: [PATCH] USB:Fix kernel NULL pointer when unbind UHCI form
 vfio-pci
Message-ID: <20200722124414.GA3153105@kroah.com>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 07:57:48PM +0800, WeitaoWangoc wrote:
> This bug is found in Zhaoxin platform, but it's a commom code bug.
> Fail sequence:
> step1: Unbind UHCI controller from native driver;
> step2: Bind UHCI controller to vfio-pci, which will put UHCI controller in one vfio
>        group's device list and set UHCI's dev->driver_data to struct vfio-pci(for UHCI)

Hah, that works?  How do you do that properly?  What code does that?

> step3: Unbind EHCI controller from native driver, will try to tell UHCI native driver
>        that "I'm removed by set companion_hcd->self.hs_companion to NULL. However,
>        companion_hcd get from UHCI's dev->driver_data that has modified by vfio-pci
>        already.So, the vfio-pci structure will be damaged!

Because you are messing around with bind/unbind "by hand", which is
never guaranteed to work properly.

It's amazing any of that works at all...

> step4: Bind EHCI controller to vfio-pci driver, which will put EHCI controller in the
>        same vfio group as UHCI controller;
>      ... ...
> step5: Unbind UHCI controller from vfio-pci, which will delete UHCI from vfio group'
>        device list that has been damaged in step 3. So,delete operation can random
>        result into a NULL pointer dereference with the below stack dump.
> step6: Bind UHCI controller to native driver;
> step7: Unbind EHCI controller from vfio-pci, which will try to remove EHCI controller
>        from the vfio group;
> step8: Bind EHCI controller to native driver;
> 
> [  929.114641] uhci_hcd 0000:00:10.0: remove, state 1
> [  929.114652] usb usb1: USB disconnect, device number 1
> [  929.114655] usb 1-1: USB disconnect, device number 2
> [  929.270313] usb 1-2: USB disconnect, device number 3
> [  929.318404] uhci_hcd 0000:00:10.0: USB bus 1 deregistered
> [  929.343029] uhci_hcd 0000:00:10.1: remove, state 4
> [  929.343045] usb usb3: USB disconnect, device number 1
> [  929.343685] uhci_hcd 0000:00:10.1: USB bus 3 deregistered
> [  929.369087] ehci-pci 0000:00:10.7: remove, state 4
> [  929.369102] usb usb4: USB disconnect, device number 1
> [  929.370325] ehci-pci 0000:00:10.7: USB bus 4 deregistered
> [  932.398494] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [  932.398496] PGD 42a67d067 P4D 42a67d067 PUD 42a65f067 PMD 0
> [  932.398502] Oops: 0002 [#2] SMP NOPTI
> [  932.398505] CPU: 2 PID: 7824 Comm: vfio_unbind.sh Tainted: P   D  4.19.65-2020051917-rainos #1

4.19 is a bit old, what about 5.7?

> [  932.398506] Hardware name: Shanghai Zhaoxin Semiconductor Co., Ltd. HX002EH/HX002EH,
>                BIOS HX002EH0_01_R480_R_200408 04/08/2020
> [  932.398513] RIP: 0010:vfio_device_put+0x31/0xa0 [vfio]
> [  932.398515] Code: 89 e5 41 54 53 4c 8b 67 18 48 89 fb 49 8d 74 24 30 e8 e3 0e f3 de
>                 84 c0 74 67 48 8b 53 20 48 8b 43 28 48 8b 7b 18 48 89 42 08 <48> 89 10
>                 48 b8 00 01 00 00 00 00 ad de 48 89 43 20 48 b8 00 02 00
> [  932.398516] RSP: 0018:ffffbbfd04cffc18 EFLAGS: 00010202
> [  932.398518] RAX: 0000000000000000 RBX: ffff92c7ea717880 RCX: 0000000000000000
> [  932.398519] RDX: ffff92c7ea713620 RSI: ffff92c7ea713630 RDI: ffff92c7ea713600
> [  932.398521] RBP: ffffbbfd04cffc28 R08: ffff92c7f02a8080 R09: ffff92c7efc03980
> [  932.398522] R10: ffffbbfd04cff9a8 R11: 0000000000000000 R12: ffff92c7ea713600
> [  932.398523] R13: ffff92c7ed8bb0a8 R14: ffff92c7ea717880 R15: 0000000000000000
> [  932.398525] FS:  00007f3031500740(0000) GS:ffff92c7f0280000(0000) knlGS:0000000000000000
> [  932.398526] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  932.398527] CR2: 0000000000000000 CR3: 0000000428626004 CR4: 0000000000160ee0
> [  932.398528] Call Trace:
> [  932.398534]  vfio_del_group_dev+0xe8/0x2a0 [vfio]
> [  932.398539]  ? __blocking_notifier_call_chain+0x52/0x60
> [  932.398542]  ? do_wait_intr_irq+0x90/0x90
> [  932.398546]  ? iommu_bus_notifier+0x75/0x100
> [  932.398551]  vfio_pci_remove+0x20/0xa0 [vfio_pci]
> [  932.398554]  pci_device_remove+0x3e/0xc0
> [  932.398557]  device_release_driver_internal+0x17a/0x240
> [  932.398560]  device_release_driver+0x12/0x20
> [  932.398561]  unbind_store+0xee/0x180
> [  932.398564]  drv_attr_store+0x27/0x40
> [  932.398567]  sysfs_kf_write+0x3c/0x50
> [  932.398568]  kernfs_fop_write+0x125/0x1a0
> [  932.398572]  __vfs_write+0x3a/0x190
> [  932.398575]  ? apparmor_file_permission+0x1a/0x20
> [  932.398577]  ? security_file_permission+0x3b/0xc0
> [  932.398581]  ? _cond_resched+0x1a/0x50
> [  932.398582]  vfs_write+0xb8/0x1b0
> [  932.398584]  ksys_write+0x5c/0xe0
> [  932.398586]  __x64_sys_write+0x1a/0x20
> [  932.398589]  do_syscall_64+0x5a/0x110
> [  932.398592]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Using virt-manager/qemu to boot guest os, we can see the same fail sequence!
> 
> Fix this by check for UHCI driver loaded or not before modifiy UHCI's dev->driver_data,
> which will happen in ehci native driver probe/remove.
> 
> Signed-off-by: WeitaoWangoc <WeitaoWang-oc@zhaoxin.com>
> ---
>  drivers/usb/core/hcd-pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index 1547aa6..484f2a0 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -34,6 +34,7 @@ static DECLARE_RWSEM(companions_rwsem);
>  #define CL_OHCI                PCI_CLASS_SERIAL_USB_OHCI
>  #define CL_EHCI                PCI_CLASS_SERIAL_USB_EHCI
> 
> +#define PCI_DEV_DRV_FLAG       2

Why is the USB core allowed to touch a private PCI structure field?

I do not think this is allowed.

And why is this a USB host controller-specific issue, shouldn't this
type of thing be fixed in the PCI core?

thanks,

greg k-h
