Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC891C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9132B2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXfddYHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCTPkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:40:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43925 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgCTPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:40:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id p125so6894318oif.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smFjiVPyHaYs02LLgXgbowZbHL4h3MjwvpQdSzza7jw=;
        b=CXfddYHym1U/VYfeeWDqMgps4IkRQttiuOlp4ttZynnWw9VB2Wcl4tzg23Rrcsq8eD
         DzTNHETJJIrd8zpNC/v3tlMlFn/fRDsU7zkkDgEJAtDWYpY4Lw9jU0/HLDBd1inuuXGQ
         mDm3GVy5IncTOaXkGugRu5o9QjVnl0gQfui8UjyusKjb30neBoLQOhgUut3xe3cQcRLm
         ueQOENzBMPH7mgrX2oGeaPH9XRsdt2TicAibMG62FNOwR6A210aPh6IlufaKwX1WX3Ze
         mgPI/MbuiLqUR8NObO7kzjWkAwowFsZLwAReb/f3wt5PV/buMxahc/9ACerZpVQCBJzM
         UHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smFjiVPyHaYs02LLgXgbowZbHL4h3MjwvpQdSzza7jw=;
        b=CHEKA4SivFkz40x5zZKkf3qIIKChZVXIKIyHWTJOf8075QohIlLngbIt621u1i4/Wm
         0+BLXcIyul3T6Oopok91BYPHu5sHcXVRrPEhx6a5E4P09pAFAxtfKzeR3KuLnhjKlcKT
         cb9Gqk5WapHBuWQ1YUrL92IzloamhhIy7qHikRqZt3YhQM6uTUmogCdQaUAAaH0du5BW
         vVjE3D2o7blnHGHzc7L/dzV4x3NqqxUDRtfIGEXnL0PTK0iHBAQb/hHNkSEO0nqxuXso
         2WBNHECcZm7NAxrX5lZWjaEPODGGB/RUit4uJIyKtVREK4UrzNx/Alg5NrTJfc0TDGmq
         R45w==
X-Gm-Message-State: ANhLgQ3cs/cXNpsNAsVB+vvW5ExCAybAjkZb8m0V1jeiT0O3V3PvF6M+
        UAHaxG+fq54TGfUiEzJesxWd95u7hgU1uUD5Cxk=
X-Google-Smtp-Source: ADFU+vs9T++tfGC4mY7P0KSbIuFQQe/Ox9jQn5vTZWwytZ3SPsVGZilnVgaC9OSYhV/qcq0e+eXI+vTTazUts2EQrC4=
X-Received: by 2002:a05:6808:8:: with SMTP id u8mr6807730oic.37.1584718803378;
 Fri, 20 Mar 2020 08:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
 <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
 <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com>
In-Reply-To: <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Fri, 20 Mar 2020 08:39:52 -0700
Message-ID: <CAP6exYKMt+A+B9X_fM2nKh78k0gXNuk6nezpHccweF=KA2YO=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        mjg59@google.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 5:59 PM <hpa@zytor.com> wrote:
>
> On March 19, 2020 5:50:52 PM PDT, ron minnich <rminnich@gmail.com> wrote:
> >Thanks for looking, but I'm not entirely sure how to parse your answer
> >:-)
> >
> >In LinuxBoot, we compile Linux into a UEFI driver and load it in
> >FLASH. It's started by the UEFI driver scheduler, a.k.a DxeCore. In
> >this case, Linux is both a bootloader (for the Linux or other kernel
> >it will boot) and Linux is also the thing booted by UEFI. As I
> >mentioned, we want to avoid writing a UEFI driver just to tell Linux
> >where to find the initramfs. Further, we want to be able to boot this
> >kernel and have it use an initramfs provided by a different bootloader
> >(pxeboot, for example). This flexibility is proving very useful for
> >companies deploying LinuxBoot today.
> >
> >I got the idea of using initrd= because u-boot is able to pass that
> >option to the ARM kernel and the ARM kernel will process it: see,
> >e.g., the usage in arch/arm/configs/acs5k_defconfig.
> >
> >Are you saying initrd is reserved for a bootloader to produce it or
> >consume it? It's certainly not either on ARM: it is in some cases
> >included in a compiled-in command line, and used by the kernel, just
> >as we are doing in this patch. The kernel build process produces it,
> >and the kernel consumes it. All this functionality is there, and all
> >this patch does it bring it into the x86 kernel with this 6 line
> >patch.
> >
> >If, in spite of this usage on ARM, you'd still not rather see a
> >corresponding usage on x86, how do we get the effect we need here?
> >Again, we don't want to write UEFI drivers, but we would like some
> >minimal way to communicate to the kernel where an initramfs is in
> >memory; and, further, we want it to be the lowest priority option, so
> >we easily override it. Suggestions on how to do this are welcome.
> >
> >ron
> >
> >On Thu, Mar 19, 2020 at 4:57 PM <hpa@zytor.com> wrote:
> >>
> >> On March 19, 2020 4:49:05 PM PDT, ron minnich <rminnich@gmail.com>
> >wrote:
> >> >In LinuxBoot systems, a kernel and initramfs are loaded into FLASH
> >> >to replace proprietary firmware/BIOS code. Space being at a premium
> >> >on some systems, the kernel and initramfs must be place in whatever
> >> >open corners of the FLASH exist. These corners are not always
> >> >easily used.
> >> >
> >> >For example, on Intel-based UEFI systems, the Management Engine
> >> >(ME) is given half the FLASH, though it uses very little, as little
> >> >as 1.25MiB.  Not only is 2.75MiB of an 8MiB part unused; but
> >> >10.75MiB of a 16MiB part is unused. This space can be recovered by
> >> >a number of tools, e.g. utk and its tighten_me command, and if
> >> >Linux can be told where the space is Linux can load an initrd from
> >> >it.
> >> >
> >> >In an ideal case, we would take the space from the ME and add it to
> >> >a FLASH-based filesystem.  While UEFI does have filesystem-like
> >> >structures, this recovered space can only be added to its "file
> >> >system" by rebuilding UEFI from source or writing a UEFI device
> >> >driver. Both these options are impractical in most cases. The space
> >> >can only be referenced as a physical address.
> >> >
> >> >There is code in the core that allows specification of the initrd
> >> >as a physical address and size, but it is not supported on all
> >> >architectures. This patch adds support for initrd= to the x86.
> >> >
> >> >For debugging and recovery purposes, if initrd= is present in the
> >> >command line, other existing initrd sources should still have
> >> >higher priority. The initramfs in flash might be damaged or
> >> >broken. Hence, it must still be possible to load a kernel and
> >> >initramfs with a conventional bootloader, or even load the
> >> >FLASH-based kernel with a different initramfs; or boot a
> >> >kernel and let it use the initrd in FLASH.
> >> >
> >> >In support of that priority ordering, this patch sets the ramdisk
> >> >image pointer to phys_initrd_start only if it is not already set;
> >> >and sets ramdisk_size to phys_initrd_size only if it is not already
> >> >set.
> >> >
> >> >It has been tested extensively in LinuxBoot environments.
> >> >
> >> >Signed-off-by: Ronald G. Minnich <rminnich@gmail.com>
> >> >---
> >> > arch/x86/kernel/setup.c | 6 ++++++
> >> > 1 file changed, 6 insertions(+)
> >> >
> >> >diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >> >index a74262c71484..1b04ef8ea12d 100644
> >> >--- a/arch/x86/kernel/setup.c
> >> >+++ b/arch/x86/kernel/setup.c
> >> >@@ -237,6 +237,9 @@ static u64 __init get_ramdisk_image(void)
> >> >
> >> >     ramdisk_image |= (u64)boot_params.ext_ramdisk_image << 32;
> >> >
> >> >+    if (ramdisk_image == 0) {
> >> >+        ramdisk_image = phys_initrd_start;
> >> >+    }
> >> >     return ramdisk_image;
> >> > }
> >> > static u64 __init get_ramdisk_size(void)
> >> >@@ -245,6 +248,9 @@ static u64 __init get_ramdisk_size(void)
> >> >
> >> >     ramdisk_size |= (u64)boot_params.ext_ramdisk_size << 32;
> >> >
> >> >+    if (ramdisk_size == 0) {
> >> >+        ramdisk_size = phys_initrd_size;
> >> >+    }
> >> >     return ramdisk_size;
> >> > }
> >>
> >> The initrd= option is reserved namespace for the bootloader. It is
> >also worth noting that the x86 boot protocol now allows the bootloader
> >to point to arbitrary chunks of memory for the initrd.
> >> --
> >> Sent from my Android device with K-9 Mail. Please excuse my brevity.
>
> It has been designated consumed by the bootloader on x86 since at least 1995. So ARM broke it.

No argument, but at the same time, it is now used in arch, mips, and
powerpc. I suspect there is no going back.

> How is this information passed to any version of Linux in the first place, and how do you then start up Linux? I suspect this is probably rather simple in the end...

Right now, it is an early_param in init/do_mounts_initrd.c, hence part
of core. It came in with b1ab95c6 in 11/2018, which is what drew us to
it initially.

On some systems, we now have LInuxBoot running on the ARM board
controller (BMC) AND on the x86 as well, and keeping some conformance
of booting and command line structure has a high value. There's a
reason this patch is so small: all the bits I needed are in the kernel
already. If I use initrd= on the kernel command line, and
CONFIG_BLK_DEV_INITRD is set, the kernel variables are set, on all
architectures.

Google, facebook, and others are now deploying LinuxBoot into their
data centers; IoT companies are building on it; manufacturers are
using it; aerospace companies too.  We have need of this kind of
capability. We chose this way of doing it after looking at a lot of
options, including ACPI. Many of the smaller companies we work with
also use ARM, and prefer this method to using ACPI, because then it's
one less point of difference.

> Note that when Linux is run as an UEFI binary the kernel UEFI stub can load an initrd file via the UEFI file I/O interface.

As part of our deployment of LinuxBoot, we are removing all UEFI
components we can, including those that implement file system and disk
I/O. They represent attack surface. So that's not an option.

Besides, the initrd is in reclaimed flash anyway, not a disk. UEFI can
only load components from a firmware volume and, as mentioned, to make
the reclaimed space available for UEFI to use we have to recompile
from source or write a UEFI driver to add that reclaimed space to the
firmware volume at startup -- undesirable and, for most places,
impossible.

Further, some companies (e.g. facebook) are looking to deploy
FSP/coreboot on x86, so using UEFI components to load initrd is a
short-term, dead-end effort.

>
> In some ways, arguably the Right Thing for the firmware to expose this would be to have a resource exposed via ACPI .

Arguably true, but we've found a real reluctance among our partners to
get involved with ACPI. Further, many of them work with ARM, and feel
that given this works today on ARM, it would be nice to have it work
on x86. While it is true that the bootloaders such as syslinux, grub,
etc. have initrd in their namespace, in LinuxBoot systems we don't
have those bootloaders. Linux is our bootloader.

I don't expect ARM/powerpc/MIPS communities to give initrd= up; it's
already in core; I can put it on a command line for a FLASH-installed
x86 Linux kernel and it will be processed, and those variables will be
set. It's ubiquity is what makes it so attractive. It's wonderfully
convenient, especially in test situations, where I might netboot a
kernel but tell it to use the initramfs in flash.

So, how do we move forward? If it's just not possible to have initrd=
mean something to the x86 kernel, as it does to other architectures,
is a different name OK? That's a bit less attractive, as it puts us in
"when on x86, do this; on all others, the standard initrd= parameter
works" mode. But if that's what it takes, we'll do it. physinitrd?
initrdaddr? something else?

We do need this. We're rolling systems into datacenters and at some
point the need for this is a blocker. So I'd like to get this figured
out.

Thanks for anything you can do.

ron
