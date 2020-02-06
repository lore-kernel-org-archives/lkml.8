Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E324C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0181620661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="SZ9xZyWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgBFDhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 22:37:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46475 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBFDhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 22:37:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id e25so3412892qtr.13;
        Wed, 05 Feb 2020 19:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fy0LCVYfm45Yj1SMlTDHcT8rLY7rLsCrngabnvAls3c=;
        b=SZ9xZyWygxE91HCl/DMHXWYWKuttICIdff5pdazkGTAd0r/VoPjFrl6y+CmQ1fnJ1m
         wX05iZqW7i0jqGha6L3MvLlR/QSyJXQMsbVEdCTSE6XEBEaYxzoEueZfo03DCljXsVdQ
         s73hhhVaBzDTHAAhiEWC9LCBaTsZWkbIKMV8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fy0LCVYfm45Yj1SMlTDHcT8rLY7rLsCrngabnvAls3c=;
        b=Z2Tl9ZUELayX5G/rV/IiFQz2qlpdlj91hH4mhcyT3zYAJ30ynUzyKif7qRW+/TubRt
         RXOx0MZ2VlvgJujReE1sEUTgXeoSHQCM4YX4U5cN4Jm1HtmCiZtTwJU64UKAB46XHoBw
         aSLvQlF1LwLeOjkdBJM+zJNTfkaRgWRrANYGRHmOnhIjmlx+j8TzHMGS1j4WYf5DmycZ
         riREA/+hJqs0DKHGvd4o/aV/tpw0iL1fyNGbKS5LxFIDj/JIBMiUzQw+dodn9ErTmLlx
         E+T4sjM06kOnKiJxXMk5phN76ztRLN0K6Qc7TwDTEfSyZ0kHZE+tTGR7AzCs6VvpIGeu
         tOJw==
X-Gm-Message-State: APjAAAVOD65XE8dZ26xC8Yu7P5tZmJ7IWiEdZQCbEhk9o/TID67svVAk
        KaQNAFtqidV1qIiDMw1ZLZW3UGwXuUI0kQMnfPQ=
X-Google-Smtp-Source: APXvYqyDLz6miWRvS0QybUMSgD70iGHqzh15onQ9joAuuH+LBPBcIFQNrfVFPF6ri7qTSNhowcHwwvdrBI6qQC4HORI=
X-Received: by 2002:aed:3b3b:: with SMTP id p56mr920975qte.234.1580960266457;
 Wed, 05 Feb 2020 19:37:46 -0800 (PST)
MIME-Version: 1.0
References: <CACPK8XdFUWoEr6YvVHf-g28hREFOWMX0g5=Vsdxq9Asq=ftOVQ@mail.gmail.com>
 <26635edf-2df3-df0f-5644-e016e1e20248@linux.intel.com>
In-Reply-To: <26635edf-2df3-df0f-5644-e016e1e20248@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 6 Feb 2020 03:37:34 +0000
Message-ID: <CACPK8XfsuyVXiLtra7mBNWTDucArPAZfOUqt96squmtBnqsGvg@mail.gmail.com>
Subject: Re: TI PCIe xHCI and kexec
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020 at 09:35, Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 5.2.2020 2.55, Joel Stanley wrote:
> > I'm supporting a system that uses Linux-as-a-bootloader to load a
> > distro kernel via kexec, The systems have a TI TUSB73x0 PCIe
> > controller which goes out to lunch after a kexec. This is the distro
> > (post-kexec) kernel:
> >
> > [    0.235411] pci 0003:01:00.0: xHCI HW did not halt within 16000
> > usec status = 0x0
> > [    1.037298] xhci_hcd 0003:01:00.0: xHCI Host Controller
> > [    1.037367] xhci_hcd 0003:01:00.0: new USB bus registered, assigned
> > bus number 1
> > [    1.053481] xhci_hcd 0003:01:00.0: Host halt failed, -110
> > [    1.053523] xhci_hcd 0003:01:00.0: can't setup: -110
> > [    1.053565] xhci_hcd 0003:01:00.0: USB bus 1 deregistered
> > [    1.053629] xhci_hcd 0003:01:00.0: init 0003:01:00.0 fail, -110
> > [    1.053703] xhci_hcd: probe of 0003:01:00.0 failed with error -110
> >
> > There were some fixes made a few years back to improve the situation,
> > but we've still had to carry some form of the patch below in the
> > bootloader kernel. I would like to rework it so it can be merged.
> >
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index dbac0fa9748d..eaa94456dd9d 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -789,6 +789,9 @@ void xhci_shutdown(struct usb_hcd *hcd)
> >       xhci_dbg_trace(xhci, trace_xhci_dbg_init,
> >               "xhci_shutdown completed - status = %x",
> >               readl(&xhci->op_regs->status));
> > +
> > +    /* TI XHCI controllers do not come back after kexec without this hack */
> > +    pci_reset_function_locked(to_pci_dev(hcd->self.sysdev));
> >   }
> >   EXPORT_SYMBOL_GPL(xhci_shutdown);
> >
> > I would like some advice on how to implement it in a way that is
> > acceptable. Would a quirk on the pci id in xhci_shutdown be ok?
>
> Yes, but as this is a pci specific workaround the quirk should go to
> xhci-pci.c: xhci_pci_shutdown(), which was added in v5.5
>
> Is the rootcause known?
> Is the only possible solution to reset the pci function?.

I don't know the root cause. The people that helped debug it in the
first place have moved on.

> Have you tried, or seen this issue on any other controller than this TUSB73x0?

We don't have any systems with a different USB controller.

In general, the other PCie devices in the system are well (enough)
behaved to survive kexec. We don't have any other out of tree
workarounds.

>
> >
> > 0003:01:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB
> > 3.0 xHCI Host Controller (rev 02)
> >
> > The full debug log of the distro kernel booting is below.
> >
> > [    1.037833] xhci_hcd 0003:01:00.0: USBCMD 0x0:
> > [    1.037835] xhci_hcd 0003:01:00.0:   HC is being stopped
> > [    1.037837] xhci_hcd 0003:01:00.0:   HC has finished hard reset
> > [    1.037839] xhci_hcd 0003:01:00.0:   Event Interrupts disabled
> > [    1.037841] xhci_hcd 0003:01:00.0:   Host System Error Interrupts disabled
> > [    1.037843] xhci_hcd 0003:01:00.0:   HC has finished light reset
> > [    1.037846] xhci_hcd 0003:01:00.0: USBSTS 0x0:
> > [    1.037847] xhci_hcd 0003:01:00.0:   Event ring is empty
> > [    1.037849] xhci_hcd 0003:01:00.0:   No Host System Error
> > [    1.037851] xhci_hcd 0003:01:00.0:   HC is running
>
> Hmm, all bits in both USBCMD and USBSTS are 0. This is a bit suspicious.
> Normally at least USBCMD Run/Stop bit, and USBSTS HCHalted bit have
> opposite values.

Does this suggest the controller is not responding at all?
