Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7EEC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BFC20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="hzoBspec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBJGMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 01:12:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47063 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgBJGMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 01:12:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id g195so5407201qke.13;
        Sun, 09 Feb 2020 22:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJxiczW6rVs39h8niickM8jWjK4NKE6CUAh3gWpIbko=;
        b=hzoBspecNjfJ0A86puSAKgOjTVBrjYylpgXPbD5adb3ixT57bpROptc7rhO3zqdzN0
         pXuJD7RN93FQEpPHkfoEZUh6gfqpgPjpMwJ7mL+3Kv957RrQAF48ZPxz8T0o9WCyKtvI
         m3OBT/98Po32TGRyfGl6bEGP34KJtsPcaBAAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJxiczW6rVs39h8niickM8jWjK4NKE6CUAh3gWpIbko=;
        b=JePSero19q+V2zh528IT0BZkDl9JfyXd97RU23qG5n7PiS/crljbanTGrZsCKKQqZO
         6Dnxcq+v/2xNumE13K5wvoP6faZpeECkDUtBljP7akePtAJIManV/TB112RSFCsc002e
         17Wl2uXYGU+t9/eEJQHcnCsAiJcGbWqo/YC0g3XDosKAM7umKkmTYVxbiWynWSm6jOkl
         NYTD7cqX26h2sBX08dyUAOMORYZya2HGXvZampdvtuD23qqDv30tlh3B5oBst2VAMEGh
         bxTltM7qwPcyM9vBBYYV208a+NXncPZr5sDukRPrWm5CpRoUpzd5L7dXi8vLEX5iXt9b
         H11A==
X-Gm-Message-State: APjAAAVKryuDZDyJ+YjHbCB/58wbVX0PEoX4mPfzvbTR0DIywL3jf0zy
        NsLISRKaO13wqdBz6CH3Zj8LdjtX8eY6ehBHDRM=
X-Google-Smtp-Source: APXvYqzFaYhHvulG+uZoK02Ia10oCG2L++TePzwpN79w/Ud4Z5KTOcMYmx7lBruqibvRCl21I0KLsrrauTC5jaXfIig=
X-Received: by 2002:ae9:e702:: with SMTP id m2mr2176qka.208.1581315138862;
 Sun, 09 Feb 2020 22:12:18 -0800 (PST)
MIME-Version: 1.0
References: <CACPK8XdFUWoEr6YvVHf-g28hREFOWMX0g5=Vsdxq9Asq=ftOVQ@mail.gmail.com>
 <26635edf-2df3-df0f-5644-e016e1e20248@linux.intel.com> <CACPK8XfsuyVXiLtra7mBNWTDucArPAZfOUqt96squmtBnqsGvg@mail.gmail.com>
 <fa02dbf7-9681-55e4-f0d7-a46939e6e18e@linux.intel.com>
In-Reply-To: <fa02dbf7-9681-55e4-f0d7-a46939e6e18e@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 10 Feb 2020 06:12:07 +0000
Message-ID: <CACPK8XdeqCCycD2wm247g1jtmCVUB0MaHJ=2687H_RuG9oZbRw@mail.gmail.com>
Subject: Re: TI PCIe xHCI and kexec
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020 at 14:23, Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 6.2.2020 5.37, Joel Stanley wrote:
> > On Wed, 5 Feb 2020 at 09:35, Mathias Nyman
> > <mathias.nyman@linux.intel.com> wrote:
> >>
> >> On 5.2.2020 2.55, Joel Stanley wrote:
> >>> I'm supporting a system that uses Linux-as-a-bootloader to load a
> >>> distro kernel via kexec, The systems have a TI TUSB73x0 PCIe
> >>> controller which goes out to lunch after a kexec. This is the distro
> >>> (post-kexec) kernel:
> >>>
> >>> [    0.235411] pci 0003:01:00.0: xHCI HW did not halt within 16000
> >>> usec status = 0x0
> >>> [    1.037298] xhci_hcd 0003:01:00.0: xHCI Host Controller
> >>> [    1.037367] xhci_hcd 0003:01:00.0: new USB bus registered, assigned
> >>> bus number 1
> >>> [    1.053481] xhci_hcd 0003:01:00.0: Host halt failed, -110
> >>> [    1.053523] xhci_hcd 0003:01:00.0: can't setup: -110
> >>> [    1.053565] xhci_hcd 0003:01:00.0: USB bus 1 deregistered
> >>> [    1.053629] xhci_hcd 0003:01:00.0: init 0003:01:00.0 fail, -110
> >>> [    1.053703] xhci_hcd: probe of 0003:01:00.0 failed with error -110
> >>>
>
> >>>
> >>> 0003:01:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB
> >>> 3.0 xHCI Host Controller (rev 02)
> >>>
> >>> The full debug log of the distro kernel booting is below.
> >>>
> >>> [    1.037833] xhci_hcd 0003:01:00.0: USBCMD 0x0:
> >>> [    1.037835] xhci_hcd 0003:01:00.0:   HC is being stopped
> >>> [    1.037837] xhci_hcd 0003:01:00.0:   HC has finished hard reset
> >>> [    1.037839] xhci_hcd 0003:01:00.0:   Event Interrupts disabled
> >>> [    1.037841] xhci_hcd 0003:01:00.0:   Host System Error Interrupts disabled
> >>> [    1.037843] xhci_hcd 0003:01:00.0:   HC has finished light reset
> >>> [    1.037846] xhci_hcd 0003:01:00.0: USBSTS 0x0:
> >>> [    1.037847] xhci_hcd 0003:01:00.0:   Event ring is empty
> >>> [    1.037849] xhci_hcd 0003:01:00.0:   No Host System Error
> >>> [    1.037851] xhci_hcd 0003:01:00.0:   HC is running
> >>
> >> Hmm, all bits in both USBCMD and USBSTS are 0. This is a bit suspicious.
> >> Normally at least USBCMD Run/Stop bit, and USBSTS HCHalted bit have
> >> opposite values.
> >
> > Does this suggest the controller is not responding at all?
> >
>
> The Capability registers looks fine, so does port status registers.
> It's just the operational USBSTS and USBCMD registers that return 0.
>
> Current xhci implementation assumes host failed to halt because USBSTS
> HCHalted bit is still 0, and bails out before reset.
> Host is probably not running, register just returns all zero.
>
> Can you try if the below code works, it checks if host is running from
> an additional place, and continues with the host reset.

Here's the patch applied to 5.6-rc1, and then kexec'd twice (once so
we're running a kernel without any workarounds on shutdown, and the
second time to test the recovery code).

It appears to have made it a bit further:

[    1.532920] pci 0003:01:00.0: enabling device (0140 -> 0142)
[    1.549081] pci 0003:01:00.0: xHCI HW did not halt within 16000
usec status = 0x10
[    1.549119] pci 0003:01:00.0: quirk_usb_early_handoff+0x0/0x7c4
took 15820 usecs

[    5.494595] xhci_hcd 0003:01:00.0: xHCI Host Controller
[    5.494670] xhci_hcd 0003:01:00.0: new USB bus registered, assigned
bus number 1
[    5.510774] xhci_hcd 0003:01:00.0: Host halt failed, -110
[    5.510791] xhci_hcd 0003:01:00.0: Continue with reset even if host
appears running
[    5.511271] xhci_hcd 0003:01:00.0: hcc params 0x0270f06d hci
version 0x96 quirks 0x0000000004000000
[    5.522063] xhci_hcd 0003:01:00.0: xHCI Host Controller
[    5.522115] xhci_hcd 0003:01:00.0: new USB bus registered, assigned
bus number 2
[    5.522186] xhci_hcd 0003:01:00.0: Host supports USB 3.0 SuperSpeed

[   19.003160] xhci_hcd 0003:01:00.0: Abort failed to stop command ring: -110
[   19.019167] xhci_hcd 0003:01:00.0: Host halt failed, -110
[   19.019168] xhci_hcd 0003:01:00.0: xHCI host controller not
responding, assume dead
[   19.019172] xhci_hcd 0003:01:00.0: HC died; cleaning up
[   19.019299] xhci_hcd 0003:01:00.0: Error while assigning device slot ID
[   19.019302] xhci_hcd 0003:01:00.0: Max number of devices this xHCI
host supports is 64.


>
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index fe38275363e0..2dbfeaf88574 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -177,8 +177,16 @@ int xhci_reset(struct xhci_hcd *xhci)
>         }
>
>         if ((state & STS_HALT) == 0) {
> -               xhci_warn(xhci, "Host controller not halted, aborting reset.\n");
> -               return 0;
> +               /*
> +                * After a kexec TI TUSB73x0 might appear running as its USBSTS
> +                * and USBCMD registers return all zeroes. Doublecheck if host
> +                * is running from USBCMD RUN bit before bailing out.
> +                */
> +               command = readl(&xhci->op_regs->command);
> +               if (command & CMD_RUN) {
> +                       xhci_warn(xhci, "Host controller not halted, aborting reset.\n");
> +                       return 0;
> +               }
>         }
>
>         xhci_dbg_trace(xhci, trace_xhci_dbg_init, "// Reset the HC");
> @@ -5217,7 +5225,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
>         /* Make sure the HC is halted. */
>         retval = xhci_halt(xhci);
>         if (retval)
> -               return retval;
> +               xhci_warn(xhci, "Continue with reset even if host appears running\n");
>
>         xhci_zero_64b_regs(xhci);
