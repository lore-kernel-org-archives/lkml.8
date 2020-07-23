Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F45C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D182206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQWHofNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGWDxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:53:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57000 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725774AbgGWDxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595476400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Drsi8TFXb/iJQ6f6C06Boe8vaJkgAjUcN+prnBjDao=;
        b=EQWHofNVlPFkwLZTy1By+3t+UOCsNxrCHBMyl4xvXMQsH6mrTKMjOGJWuXompfe/NMMmrh
        QzDAqT9VHuMehyGLLPFoxVdsd1EEcIO/zsRXq0O/pKhANSsddUnWE/DfrU7L1WkqxIWvvQ
        fw+NBqokAInuO1gxbNOTFaWEFsvclqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-WS8aASTzNcmloPkFMS-9ag-1; Wed, 22 Jul 2020 23:53:17 -0400
X-MC-Unique: WS8aASTzNcmloPkFMS-9ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 021EF100CD01;
        Thu, 23 Jul 2020 03:53:15 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C637B61100;
        Thu, 23 Jul 2020 03:53:13 +0000 (UTC)
Date:   Wed, 22 Jul 2020 21:53:13 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     WeitaoWangoc <WeitaoWang-oc@zhaoxin.com>
Cc:     <gregkh@linuxfoundation.org>, <mathias.nyman@linux.intel.com>,
        <ulf.hansson@linaro.org>, <vkoul@kernel.org>,
        <hslester96@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Carsten_Schmid@mentor.com>,
        <efremov@linux.com>, <tonywwang@zhaoxin.com>,
        <weitaowang@zhaoxin.com>, <CobeChen@zhaoxin.com>,
        <TimGuo@zhaoxin.com>, <wwt8723@163.com>
Subject: Re: [PATCH] USB:Fix kernel NULL pointer when unbind UHCI form
 vfio-pci
Message-ID: <20200722215313.5a842b93@x1.home>
In-Reply-To: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 19:57:48 +0800
WeitaoWangoc <WeitaoWang-oc@zhaoxin.com> wrote:

> This bug is found in Zhaoxin platform, but it's a commom code bug.
> Fail sequence:
> step1: Unbind UHCI controller from native driver;
> step2: Bind UHCI controller to vfio-pci, which will put UHCI controller i=
n one vfio
>        group's device list and set UHCI's dev->driver_data to struct vfio=
-pci(for UHCI)
> step3: Unbind EHCI controller from native driver, will try to tell UHCI n=
ative driver
>        that "I'm removed by set companion_hcd->self.hs_companion to NULL.=
 However,
>        companion_hcd get from UHCI's dev->driver_data that has modified b=
y vfio-pci
>        already.So, the vfio-pci structure will be damaged!
> step4: Bind EHCI controller to vfio-pci driver, which will put EHCI contr=
oller in the
>        same vfio group as UHCI controller;
>      ... ...
> step5: Unbind UHCI controller from vfio-pci, which will delete UHCI from =
vfio group'
>        device list that has been damaged in step 3. So,delete operation c=
an random
>        result into a NULL pointer dereference with the below stack dump.
> step6: Bind UHCI controller to native driver;
> step7: Unbind EHCI controller from vfio-pci, which will try to remove EHC=
I controller
>        from the vfio group;
> step8: Bind EHCI controller to native driver;
>=20
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
> [  932.398494] BUG: unable to handle kernel NULL pointer dereference at 0=
000000000000000
> [  932.398496] PGD 42a67d067 P4D 42a67d067 PUD 42a65f067 PMD 0
> [  932.398502] Oops: 0002 [#2] SMP NOPTI
> [  932.398505] CPU: 2 PID: 7824 Comm: vfio_unbind.sh Tainted: P   D  4.19=
.65-2020051917-rainos #1
> [  932.398506] Hardware name: Shanghai Zhaoxin Semiconductor Co., Ltd. HX=
002EH/HX002EH,
>                BIOS HX002EH0_01_R480_R_200408 04/08/2020
> [  932.398513] RIP: 0010:vfio_device_put+0x31/0xa0 [vfio]
> [  932.398515] Code: 89 e5 41 54 53 4c 8b 67 18 48 89 fb 49 8d 74 24 30 e=
8 e3 0e f3 de
>                 84 c0 74 67 48 8b 53 20 48 8b 43 28 48 8b 7b 18 48 89 42 =
08 <48> 89 10
>                 48 b8 00 01 00 00 00 00 ad de 48 89 43 20 48 b8 00 02 00
> [  932.398516] RSP: 0018:ffffbbfd04cffc18 EFLAGS: 00010202
> [  932.398518] RAX: 0000000000000000 RBX: ffff92c7ea717880 RCX: 000000000=
0000000
> [  932.398519] RDX: ffff92c7ea713620 RSI: ffff92c7ea713630 RDI: ffff92c7e=
a713600
> [  932.398521] RBP: ffffbbfd04cffc28 R08: ffff92c7f02a8080 R09: ffff92c7e=
fc03980
> [  932.398522] R10: ffffbbfd04cff9a8 R11: 0000000000000000 R12: ffff92c7e=
a713600
> [  932.398523] R13: ffff92c7ed8bb0a8 R14: ffff92c7ea717880 R15: 000000000=
0000000
> [  932.398525] FS:  00007f3031500740(0000) GS:ffff92c7f0280000(0000) knlG=
S:0000000000000000
> [  932.398526] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  932.398527] CR2: 0000000000000000 CR3: 0000000428626004 CR4: 000000000=
0160ee0
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
>=20
> Using virt-manager/qemu to boot guest os, we can see the same fail sequen=
ce!
>=20
> Fix this by check for UHCI driver loaded or not before modifiy UHCI's dev=
->driver_data,
> which will happen in ehci native driver probe/remove.
>=20
> Signed-off-by: WeitaoWangoc <WeitaoWang-oc@zhaoxin.com>
> ---
>  drivers/usb/core/hcd-pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index 1547aa6..484f2a0 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -34,6 +34,7 @@ static DECLARE_RWSEM(companions_rwsem);
>  #define CL_OHCI                PCI_CLASS_SERIAL_USB_OHCI
>  #define CL_EHCI                PCI_CLASS_SERIAL_USB_EHCI
>=20
> +#define PCI_DEV_DRV_FLAG       2
>  static inline int is_ohci_or_uhci(struct pci_dev *pdev)
>  {
>         return pdev->class =3D=3D CL_OHCI || pdev->class =3D=3D CL_UHCI;
> @@ -68,6 +69,8 @@ static void for_each_companion(struct pci_dev *pdev, st=
ruct usb_hcd *hcd,
>                 if (companion->class !=3D CL_UHCI && companion->class !=
=3D CL_OHCI &&
>                                 companion->class !=3D CL_EHCI)
>                         continue;
> +               if (!(companion->priv_flags & PCI_DEV_DRV_FLAG))

But pci_dev.priv_flags is private data for the driver that currently
owns the device, which could be vfio-pci.  This is really no different
than assuming the structure at device.driver_data.  If vfio-pci were to
make legitimate use of pci_dev.priv_flags, this could simply blow up
again.  Should there instead be some sort of registration interface
where hcd complaint drivers register their devices and only those
registered devices can have their driver private data arbitrarily poked
by another driver?  Thanks,

Alex

> +                       continue;
>=20
>                 companion_hcd =3D pci_get_drvdata(companion);
>                 if (!companion_hcd || !companion_hcd->self.root_hub)
> @@ -254,6 +257,7 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const stru=
ct pci_device_id *id,
>         }
>=20
>         pci_set_master(dev);
> +       dev->priv_flags | =3D PCI_DEV_DRV_FLAG;
>=20
>         /* Note: dev_set_drvdata must be called while holding the rwsem */
>         if (dev->class =3D=3D CL_EHCI) {
> @@ -326,6 +330,7 @@ void usb_hcd_pci_remove(struct pci_dev *dev)
>         local_irq_disable();
>         usb_hcd_irq(0, hcd);
>         local_irq_enable();
> +       dev->priv_flags & =3D ~PCI_DEV_DRV_FLAG;
>=20
>         /* Note: dev_set_drvdata must be called while holding the rwsem */
>         if (dev->class =3D=3D CL_EHCI) {
> --
> 2.7.4
>=20
>=20
>=20
> =E4=BF=9D=E5=AF=86=E5=A3=B0=E6=98=8E=EF=BC=9A
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=90=AB=E6=9C=89=E4=BF=9D=E5=AF=86=E6=88=96=
=E4=B8=93=E6=9C=89=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E4=BE=9B=E6=8C=87=E5=
=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=E3=80=82=E4=B8=A5=E7=A6=
=81=E5=AF=B9=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=88=96=E5=85=B6=E5=86=85=E5=AE=B9=
=E5=81=9A=E4=BB=BB=E4=BD=95=E6=9C=AA=E7=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=
=9F=A5=E9=98=85=E3=80=81=E4=BD=BF=E7=94=A8=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=
=96=E8=BD=AC=E5=8F=91=E3=80=82
> CONFIDENTIAL NOTE:
> This email contains confidential or legally privileged information and is=
 for the sole use of its intended recipient. Any unauthorized review, use, =
copying or forwarding of this email or the content of this email is strictl=
y prohibited.
>=20

