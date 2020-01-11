Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC7DC33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 08:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D450D20866
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 08:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUxF0R25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgAKIqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 03:46:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20106 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728662AbgAKIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 03:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578732395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ryPwgX4h0fv0PqQURJdtqBJqmMzlmxt0UnN1Eaml9k8=;
        b=UUxF0R257U9M81WB0p9P/O3iwTMO1N2KgEoVS0S3fIKuXXiCikcImHGW6a3s3dbNEQzt7z
        thRdx0jw6odunlA894E4dFvqS5DlYCzxib93okMGw4qOnMwl6ydY21xQ8U0d8IUU+rsSpz
        cvcuFLDKEPcDYIm/L+id6oGeJS3KZIQ=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-rR-7cyLfNmuRgnjhUdxsrw-1; Sat, 11 Jan 2020 03:46:34 -0500
X-MC-Unique: rR-7cyLfNmuRgnjhUdxsrw-1
Received: by mail-il1-f199.google.com with SMTP id l13so3451636ils.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 00:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryPwgX4h0fv0PqQURJdtqBJqmMzlmxt0UnN1Eaml9k8=;
        b=ATnuA7X4fDT2DN4PP01PAOJ1QR5U+zs+HHBhMfww0wAztxqhrWxj5GQ/esU9yqgoPG
         MJpGVTl3H0HNJfGtSXaYXzR/8WOHT+vvMBD32Wgu+QpGbSfsE/VYzh9r+etXDVH0Bd6F
         vxnDNhixshamGxC0UnuU3QPuasjFSH8rzNVuiJ9ROQvq9B0bawNxxSRYOs/pRqS1vcGc
         WEfJmjSOOMfaVIy4U+EwO0cPRSAbevjCDsq8+WFsj5e6ZTyOlR0ff60OUmzr4No/AdZI
         KwfB9SfZ+J16rimr+rPXKYLeJZLNuuKAUOT5ZOqX9Vc5g76JGqC0BHHBJ3GgCu4NcNCE
         QFUw==
X-Gm-Message-State: APjAAAVD1JO2gWN87ovmhia0bp6mRjYdUK082K6pIb6/pVsovdgDlcG0
        A4YBRB0YYOabPCTtRIfvCYWIA0ca+dxUXRqVZw9zRTR9RVnNew9IORHVGTGbIoGX5vKtdYADHax
        QpKYyffcA35CKJPmbMseB3Jr//EarQtyrrtUeWIvF
X-Received: by 2002:a92:5e46:: with SMTP id s67mr6481957ilb.162.1578732393598;
        Sat, 11 Jan 2020 00:46:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEEuR6hFZaMskU7KT02zTWtoS0CzMF6B3DJtVuJAC7rZjKipG3HRyG1I0FgcNnqA1itY5dyMn7CzfpmIrj1BQ=
X-Received: by 2002:a92:5e46:: with SMTP id s67mr6481943ilb.162.1578732393346;
 Sat, 11 Jan 2020 00:46:33 -0800 (PST)
MIME-Version: 1.0
References: <20191225192118.283637-1-kasong@redhat.com> <20200110214217.GA88274@google.com>
In-Reply-To: <20200110214217.GA88274@google.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Sat, 11 Jan 2020 16:46:22 +0800
Message-ID: <CACPcB9d7Fq=6Fvz_Tjsq_E2qgyaPQKc=KdzfTdBj3uhygoN5qA@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Baoquan He <bhe@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>, khalid@gonehiking.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 5:42 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Can you help me understand the sequence of events?  If I understand
> correctly, the desired sequence is:
>
>   - user kernel boots
>   - user kernel panics and kexecs to kdump kernel

One thing imported need to be mentioned here, user kernel kexec into
kdump kernel using the fast path, which does very few things, and
leave all the PCI devices untouched. If they are on, or doing DMA,
will just keep doing that, nothing will stop them.

In most cases the on going DMA seems harmless though, as kdump kernel
only live in reserved crash memory.

>   - kdump kernel writes vmcore to network or disk
>   - kdump kernel reboots
>   - user kernel boots
>
> But the problem is that as part of the kdump kernel reboot,
>
>   - kdump kernel disables bus mastering for a Root Port
>   - device below the Root Port attempts DMA
>   - Root Port receives DMA transaction, handles it as Unsupported
>     Request, sends UR Completion to device
>   - device signals uncorrectable error
>   - uncorrectable error causes a crash (Or a hang?  You mention both
>     and I'm not sure which it is)
>
> Is that right so far?

Yes everything else all correct. On the machine I can reproduce it,
system just hanged, even serial console is dead with no output.

>
> > So for kdump, let kernel read the correct hardware power state on boot,
> > and always clear the bus master bit of PCI device upon shutdown if the
> > device is on. PCIe port driver will always shutdown all downstream
> > devices first, so this should ensure all downstream devices have bus
> > master bit off before clearing the bridge's bus master bit.
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >  drivers/pci/pci-driver.c | 11 ++++++++---
> >  drivers/pci/quirks.c     | 20 ++++++++++++++++++++
> >  2 files changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 0454ca0e4e3f..84a7fd643b4d 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/kexec.h>
> >  #include <linux/of_device.h>
> >  #include <linux/acpi.h>
> > +#include <linux/crash_dump.h>
> >  #include "pci.h"
> >  #include "pcie/portdrv.h"
> >
> > @@ -488,10 +489,14 @@ static void pci_device_shutdown(struct device *dev)
> >        * If this is a kexec reboot, turn off Bus Master bit on the
> >        * device to tell it to not continue to do DMA. Don't touch
> >        * devices in D3cold or unknown states.
> > -      * If it is not a kexec reboot, firmware will hit the PCI
> > -      * devices with big hammer and stop their DMA any way.
> > +      * If this is kdump kernel, also turn off Bus Master, the device
> > +      * could be activated by previous crashed kernel and may block
> > +      * it's upstream from shutting down.
> > +      * Else, firmware will hit the PCI devices with big hammer
> > +      * and stop their DMA any way.
> >        */
> > -     if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> > +     if ((kexec_in_progress || is_kdump_kernel()) &&
> > +                     pci_dev->current_state <= PCI_D3hot)
> >               pci_clear_master(pci_dev);
>
> I'm clearly missing something because this will turn off bus mastering
> in cases where we previously left it enabled.
>
> I was assuming the crash was related to a device doing DMA when the
> Root Port had bus mastering disabled.  But that must be wrong.

That is just what is happening. When kdump kernel try to reboot, it
only cleared bus mastering bit of the Root Port, ignoring enabled
device under it, because it's not the kdump kernel that enabled the
device, it's the first kernel enabled it, and kdump kernel don't know
it.

>
> I'd like to understand the crash/hang better because the quirk
> especially is hard to connect to anything.  If the crash is because of
> an AER or other PCIe error, maybe another possibility is that we could
> handle it better or disable signaling of it or something.
>

Maybe if we can solve the problem by properly shutdown the devices in
right order, then better don't disable any error handling features? Or
kernel might miss some real hardware issue.

--
Best Regards,
Kairui Song

