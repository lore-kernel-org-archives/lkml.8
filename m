Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E99C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F275E20661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgBEJfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:35:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:18567 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbgBEJfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:35:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 01:35:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="scan'208";a="311314489"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga001.jf.intel.com with ESMTP; 05 Feb 2020 01:35:16 -0800
Subject: Re: TI PCIe xHCI and kexec
To:     Joel Stanley <joel@jms.id.au>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <CACPK8XdFUWoEr6YvVHf-g28hREFOWMX0g5=Vsdxq9Asq=ftOVQ@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <26635edf-2df3-df0f-5644-e016e1e20248@linux.intel.com>
Date:   Wed, 5 Feb 2020 11:37:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XdFUWoEr6YvVHf-g28hREFOWMX0g5=Vsdxq9Asq=ftOVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.2.2020 2.55, Joel Stanley wrote:
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
>       xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>               "xhci_shutdown completed - status = %x",
>               readl(&xhci->op_regs->status));
> +
> +    /* TI XHCI controllers do not come back after kexec without this hack */
> +    pci_reset_function_locked(to_pci_dev(hcd->self.sysdev));
>   }
>   EXPORT_SYMBOL_GPL(xhci_shutdown);
> 
> I would like some advice on how to implement it in a way that is
> acceptable. Would a quirk on the pci id in xhci_shutdown be ok?

Yes, but as this is a pci specific workaround the quirk should go to
xhci-pci.c: xhci_pci_shutdown(), which was added in v5.5

Is the rootcause known?
Is the only possible solution to reset the pci function?.
Have you tried, or seen this issue on any other controller than this TUSB73x0?

> 
> 0003:01:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB
> 3.0 xHCI Host Controller (rev 02)
> 
> The full debug log of the distro kernel booting is below.
> 
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

Hmm, all bits in both USBCMD and USBSTS are 0. This is a bit suspicious.
Normally at least USBCMD Run/Stop bit, and USBSTS HCHalted bit have
opposite values.

-Mathias
