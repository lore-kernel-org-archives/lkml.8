Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3EFC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CC52076C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8SCln14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgCTAvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:51:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41509 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCTAvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 20:51:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id b17so4814439oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 17:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CIpYNXlGrsUSUuQiLOtI07Pjunv3Od5yxPcElIGP60s=;
        b=G8SCln14kUrYoiO1L5uEMeMhoV/QKPDnv8DhQllZdDx+2crqpFk31IP7dGpCh3KvH6
         AnoA9IdojiwGyVhSaJIgagFwUdTY3kdLLwXnw0LwWZvZ2+bRoOYEjETGBL5HbJsYZEcl
         ZcRwy1B8hnbLSwnw/sz2yG9yLKGjmZ9y2TzkPeXLegZKGB5gQNPsioYv+Voyr/O7V37b
         5r7wclW9iOrgAC1QEppIphroSW6DibS1b8kGUXPpMjq3mW9eH/f0+/uNFgRp5vuBUGHA
         uU4KfIwnYqqNdG110tftrTF0PJ922j0UU6nY6qTFoKMwOUxhzYPClZwTIk32tAYZJnrJ
         WKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIpYNXlGrsUSUuQiLOtI07Pjunv3Od5yxPcElIGP60s=;
        b=jxhQDakHsKhEeSyOETZNQFd2hrcypAm+uyalYgQ5SGnmn8yKXKOm2M5ez8rfPIC+xp
         37ZbXXL9PwX/WWx828YH1JdPC8HjVGk0bZPrHgP0YdD/8DAbkb0Gs2dMNHuC8vXsWWVU
         AbKI5TibAtAdxytBPC578oEtd97dB0mSPRJ3XdeBF1svw1LA2zdDHDRxrJGgGAgcYEX3
         lI0gNaMFm13+hrATjSvUT0iDycWYRNQMKvIzv06dP/4BJ7fB9A3FlcVFDa+Kaxr7roKJ
         aN/TeH2EaUlp5eEU2eqed62HZhU4Gx8Sv2BytpM9LGJV0VNCQ80czVAAHM3cx20zdYuy
         5EMA==
X-Gm-Message-State: ANhLgQ3D3e/5z25fn2dsCqTMh6d/rWGU8MJFo4suoxW3fqUw8od8z8hq
        iclWScT/7RUB9/4F0GAhJA6Vw7fgtXxXOMZaOSQ=
X-Google-Smtp-Source: ADFU+vuKqxbuwj4RBfPPq742I+MpPYEG+iVgeWTi9y0hbYSEg+szmQy1c/XvO5WsatUBKK428WiheRsFnaggjWkkzVs=
X-Received: by 2002:aca:b608:: with SMTP id g8mr4633367oif.142.1584665463624;
 Thu, 19 Mar 2020 17:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
 <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com>
In-Reply-To: <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Thu, 19 Mar 2020 17:50:52 -0700
Message-ID: <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
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

Thanks for looking, but I'm not entirely sure how to parse your answer :-)

In LinuxBoot, we compile Linux into a UEFI driver and load it in
FLASH. It's started by the UEFI driver scheduler, a.k.a DxeCore. In
this case, Linux is both a bootloader (for the Linux or other kernel
it will boot) and Linux is also the thing booted by UEFI. As I
mentioned, we want to avoid writing a UEFI driver just to tell Linux
where to find the initramfs. Further, we want to be able to boot this
kernel and have it use an initramfs provided by a different bootloader
(pxeboot, for example). This flexibility is proving very useful for
companies deploying LinuxBoot today.

I got the idea of using initrd= because u-boot is able to pass that
option to the ARM kernel and the ARM kernel will process it: see,
e.g., the usage in arch/arm/configs/acs5k_defconfig.

Are you saying initrd is reserved for a bootloader to produce it or
consume it? It's certainly not either on ARM: it is in some cases
included in a compiled-in command line, and used by the kernel, just
as we are doing in this patch. The kernel build process produces it,
and the kernel consumes it. All this functionality is there, and all
this patch does it bring it into the x86 kernel with this 6 line
patch.

If, in spite of this usage on ARM, you'd still not rather see a
corresponding usage on x86, how do we get the effect we need here?
Again, we don't want to write UEFI drivers, but we would like some
minimal way to communicate to the kernel where an initramfs is in
memory; and, further, we want it to be the lowest priority option, so
we easily override it. Suggestions on how to do this are welcome.

ron

On Thu, Mar 19, 2020 at 4:57 PM <hpa@zytor.com> wrote:
>
> On March 19, 2020 4:49:05 PM PDT, ron minnich <rminnich@gmail.com> wrote:
> >In LinuxBoot systems, a kernel and initramfs are loaded into FLASH
> >to replace proprietary firmware/BIOS code. Space being at a premium
> >on some systems, the kernel and initramfs must be place in whatever
> >open corners of the FLASH exist. These corners are not always
> >easily used.
> >
> >For example, on Intel-based UEFI systems, the Management Engine
> >(ME) is given half the FLASH, though it uses very little, as little
> >as 1.25MiB.  Not only is 2.75MiB of an 8MiB part unused; but
> >10.75MiB of a 16MiB part is unused. This space can be recovered by
> >a number of tools, e.g. utk and its tighten_me command, and if
> >Linux can be told where the space is Linux can load an initrd from
> >it.
> >
> >In an ideal case, we would take the space from the ME and add it to
> >a FLASH-based filesystem.  While UEFI does have filesystem-like
> >structures, this recovered space can only be added to its "file
> >system" by rebuilding UEFI from source or writing a UEFI device
> >driver. Both these options are impractical in most cases. The space
> >can only be referenced as a physical address.
> >
> >There is code in the core that allows specification of the initrd
> >as a physical address and size, but it is not supported on all
> >architectures. This patch adds support for initrd= to the x86.
> >
> >For debugging and recovery purposes, if initrd= is present in the
> >command line, other existing initrd sources should still have
> >higher priority. The initramfs in flash might be damaged or
> >broken. Hence, it must still be possible to load a kernel and
> >initramfs with a conventional bootloader, or even load the
> >FLASH-based kernel with a different initramfs; or boot a
> >kernel and let it use the initrd in FLASH.
> >
> >In support of that priority ordering, this patch sets the ramdisk
> >image pointer to phys_initrd_start only if it is not already set;
> >and sets ramdisk_size to phys_initrd_size only if it is not already
> >set.
> >
> >It has been tested extensively in LinuxBoot environments.
> >
> >Signed-off-by: Ronald G. Minnich <rminnich@gmail.com>
> >---
> > arch/x86/kernel/setup.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> >diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >index a74262c71484..1b04ef8ea12d 100644
> >--- a/arch/x86/kernel/setup.c
> >+++ b/arch/x86/kernel/setup.c
> >@@ -237,6 +237,9 @@ static u64 __init get_ramdisk_image(void)
> >
> >     ramdisk_image |= (u64)boot_params.ext_ramdisk_image << 32;
> >
> >+    if (ramdisk_image == 0) {
> >+        ramdisk_image = phys_initrd_start;
> >+    }
> >     return ramdisk_image;
> > }
> > static u64 __init get_ramdisk_size(void)
> >@@ -245,6 +248,9 @@ static u64 __init get_ramdisk_size(void)
> >
> >     ramdisk_size |= (u64)boot_params.ext_ramdisk_size << 32;
> >
> >+    if (ramdisk_size == 0) {
> >+        ramdisk_size = phys_initrd_size;
> >+    }
> >     return ramdisk_size;
> > }
>
> The initrd= option is reserved namespace for the bootloader. It is also worth noting that the x86 boot protocol now allows the bootloader to point to arbitrary chunks of memory for the initrd.
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
