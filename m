Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB84FC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D8A214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="bTjvcohw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgBFDEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 22:04:39 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:42831 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgBFDEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 22:04:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48Cjvm083Hz9sRm;
        Thu,  6 Feb 2020 14:04:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1580958276;
        bh=3GiIB+ybAW+Dkfv7Blu7I604G11RcvKHUbdqalJe2bI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bTjvcohw1EBO03bDjNlvCHI6iEvcqDZ4AS4PSAjuGmlc2gr2UaQqLlF1CzQc9rct/
         0NQWwYYGud0SZ+mPCsV/jJW0T1MvGxmZXUWYN8ao8IK0L1pjxvs4m3AUV+aqIWTTjD
         mWPOEu9QplUmGKz71voVlgf8Lj19kltfU7Z3WRn8sOKxx0wYvH6sX+oq1lThXM/lsl
         hB2nAwiH0k9AVx4QMsVmO0fC7lRuEK7gjxPck2NvombIxoTHKbUfekIssuhnA4Kmr6
         GtHQsdqVxfI4Kxxtp2OEHtX1MU+0HtQ/78SOVjw2vvH8IRTSkzw6sXZ4q2wwI9ZPC+
         3XD6Nh3IoBCRw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joel Stanley <joel@jms.id.au>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TI PCIe xHCI and kexec
In-Reply-To: <CACPK8XdFUWoEr6YvVHf-g28hREFOWMX0g5=Vsdxq9Asq=ftOVQ@mail.gmail.com>
References: <CACPK8XdFUWoEr6YvVHf-g28hREFOWMX0g5=Vsdxq9Asq=ftOVQ@mail.gmail.com>
Date:   Thu, 06 Feb 2020 14:04:32 +1100
Message-ID: <87zhdw1kn3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Stanley <joel@jms.id.au> writes:
> I'm supporting a system that uses Linux-as-a-bootloader to load a
> distro kernel via kexec, The systems have a TI TUSB73x0 PCIe
> controller which goes out to lunch after a kexec. This is the distro
> (post-kexec) kernel:
>
> [    0.235411] pci 0003:01:00.0: xHCI HW did not halt within 16000
> usec status = 0x0
> [    1.037298] xhci_hcd 0003:01:00.0: xHCI Host Controller
> [    1.037367] xhci_hcd 0003:01:00.0: new USB bus registered, assigned
> bus number 1
> [    1.053481] xhci_hcd 0003:01:00.0: Host halt failed, -110
> [    1.053523] xhci_hcd 0003:01:00.0: can't setup: -110
> [    1.053565] xhci_hcd 0003:01:00.0: USB bus 1 deregistered
> [    1.053629] xhci_hcd 0003:01:00.0: init 0003:01:00.0 fail, -110
> [    1.053703] xhci_hcd: probe of 0003:01:00.0 failed with error -110
>
> There were some fixes made a few years back to improve the situation,
> but we've still had to carry some form of the patch below in the
> bootloader kernel. I would like to rework it so it can be merged.
>
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index dbac0fa9748d..eaa94456dd9d 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -789,6 +789,9 @@ void xhci_shutdown(struct usb_hcd *hcd)
>      xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>              "xhci_shutdown completed - status = %x",
>              readl(&xhci->op_regs->status));
> +
> +    /* TI XHCI controllers do not come back after kexec without this hack */
> +    pci_reset_function_locked(to_pci_dev(hcd->self.sysdev));
>  }
>  EXPORT_SYMBOL_GPL(xhci_shutdown);
>
> I would like some advice on how to implement it in a way that is
> acceptable. Would a quirk on the pci id in xhci_shutdown be ok?

Doing something on shutdown only helps the kexec case, where the first
kernel shuts down cleanly.

kdump kernels will still hit the issue, because there the first kernel
has crashed and done no (or very little) shutdown.

The ideal solution is to have the driver/bus code in the second kernel
detect that the device is fubar and do something to reset it then.

But I don't know enough about USB or this device to know if that's
really feasible.

I realise that doesn't actually solve the problem for the
linux-as-bootloader case, because there you want to make it work even if
the kernel you're loading hasn't been updated, so you have to do
something on shutdown.

cheers


> [    1.037638] xhci_hcd 0003:01:00.0: xHCI Host Controller
> [    1.037695] xhci_hcd 0003:01:00.0: new USB bus registered, assigned
> bus number 1
> [    1.037789] xhci_hcd 0003:01:00.0: xHCI capability registers at
>     (ptrval):
> [    1.037792] xhci_hcd 0003:01:00.0: CAPLENGTH AND HCIVERSION 0x960020:
> [    1.037794] xhci_hcd 0003:01:00.0: CAPLENGTH: 0x20
> [    1.037796] xhci_hcd 0003:01:00.0: HCIVERSION: 0x96
> [    1.037798] xhci_hcd 0003:01:00.0: HCSPARAMS 1: 0x8000840
> [    1.037800] xhci_hcd 0003:01:00.0:   Max device slots: 64
> [    1.037802] xhci_hcd 0003:01:00.0:   Max interrupters: 8
> [    1.037804] xhci_hcd 0003:01:00.0:   Max ports: 8
> [    1.037806] xhci_hcd 0003:01:00.0: HCSPARAMS 2: 0xc0000f1
> [    1.037808] xhci_hcd 0003:01:00.0:   Isoc scheduling threshold: 1
> [    1.037810] xhci_hcd 0003:01:00.0:   Maximum allowed segments in
> event ring: 15
> [    1.037813] xhci_hcd 0003:01:00.0: HCSPARAMS 3 0x7ff000a:
> [    1.037815] xhci_hcd 0003:01:00.0:   Worst case U1 device exit latency: 10
> [    1.037816] xhci_hcd 0003:01:00.0:   Worst case U2 device exit latency: 2047
> [    1.037819] xhci_hcd 0003:01:00.0: HCC PARAMS 0x270f06d:
> [    1.037821] xhci_hcd 0003:01:00.0:   HC generates 64 bit addresses
> [    1.037823] xhci_hcd 0003:01:00.0:   HC hasn't Contiguous Frame ID Capability
> [    1.037825] xhci_hcd 0003:01:00.0:   HC can't generate Stopped -
> Short Package event
> [    1.037826] xhci_hcd 0003:01:00.0:   FIXME: more HCCPARAMS debugging
> [    1.037829] xhci_hcd 0003:01:00.0: RTSOFF 0x4a0:
> [    1.037831] xhci_hcd 0003:01:00.0: xHCI operational registers at
>      (ptrval):
> [    1.037833] xhci_hcd 0003:01:00.0: USBCMD 0x0:
> [    1.037835] xhci_hcd 0003:01:00.0:   HC is being stopped
> [    1.037837] xhci_hcd 0003:01:00.0:   HC has finished hard reset
> [    1.037839] xhci_hcd 0003:01:00.0:   Event Interrupts disabled
> [    1.037841] xhci_hcd 0003:01:00.0:   Host System Error Interrupts disabled
> [    1.037843] xhci_hcd 0003:01:00.0:   HC has finished light reset
> [    1.037846] xhci_hcd 0003:01:00.0: USBSTS 0x0:
> [    1.037847] xhci_hcd 0003:01:00.0:   Event ring is empty
> [    1.037849] xhci_hcd 0003:01:00.0:   No Host System Error
> [    1.037851] xhci_hcd 0003:01:00.0:   HC is running
> [    1.037854] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
> [    1.037857] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
> [    1.037860] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
> [    1.037862] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
> [    1.037865] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
> [    1.037868] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
> [    1.037870] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
> [    1.037873] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
> [    1.037876] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0xe03
> [    1.037878] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
> [    1.037881] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
> [    1.037884] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
> [    1.037886] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0xe03
> [    1.037889] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
> [    1.037892] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
> [    1.037894] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
> [    1.037897] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
> [    1.037900] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
> [    1.037902] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
> [    1.037905] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
> [    1.037908] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
> [    1.037910] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
> [    1.037913] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
> [    1.037916] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
> [    1.037918] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
> [    1.037921] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
> [    1.037924] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
> [    1.037926] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
> [    1.037929] xhci_hcd 0003:01:00.0:         (ptrval) port status reg = 0x2a0
> [    1.037931] xhci_hcd 0003:01:00.0:         (ptrval) port power reg = 0x0
> [    1.037934] xhci_hcd 0003:01:00.0:         (ptrval) port link reg = 0x0
> [    1.037937] xhci_hcd 0003:01:00.0:         (ptrval) port reserved reg = 0x0
> [    1.037939] xhci_hcd 0003:01:00.0: // Halt the HC
> [    1.053945] xhci_hcd 0003:01:00.0: Host halt failed, -110
> [    1.053987] xhci_hcd 0003:01:00.0: can't setup: -110
> [    1.054032] xhci_hcd 0003:01:00.0: USB bus 1 deregistered
> [    1.054099] xhci_hcd 0003:01:00.0: init 0003:01:00.0 fail, -110
> [    1.054165] xhci_hcd: probe of 0003:01:00.0 failed with error -110
