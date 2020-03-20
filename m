Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAF8C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2423020740
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 00:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GwoDQ3g5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCTA7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:59:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56173 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbgCTA7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 20:59:41 -0400
Received: from [IPv6:2601:646:8600:3281:9577:eff3:b2f7:e372] ([IPv6:2601:646:8600:3281:9577:eff3:b2f7:e372])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 02K0xNMM1255369
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 19 Mar 2020 17:59:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 02K0xNMM1255369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020022001; t=1584665967;
        bh=xSIh/pQjs7n22PEUnpcaVeF1w3izG60H/Jy62WK+v/Q=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=GwoDQ3g5acr+/b+Xb9ZLFOSp0sSVI/I3SelpYFwrA4ei0qAUVET9ZngILcFmmeNQY
         3oxpvxF2Oz5FX5oU8R7kq7+Y/xPeqQspNOM/gO64O7D8BifMjGjw8q/yBe5Xu8HsTm
         qQMmfbiBqllvZxIJlHvS/pEX/eyVV4GO0ZnNt4lxoHZFr1mCfq8fjknzQTXCTfMXhd
         XTktfn3FZbbkY6+IgYdvzMkYGZynrpwCE6g4ia2VoQ4u736Wvi2lCO3MO18xyeUppx
         Duh0CsKasVT3Iz3e15Qg95ahBPlJ4SAqX/hpAOVZhz5DCj43nIN/TyFe+9JfrMO2T5
         A5P6K0IZ2WeUw==
Date:   Thu, 19 Mar 2020 17:59:16 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com> <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     ron minnich <rminnich@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        mjg59@google.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 19, 2020 5:50:52 PM PDT, ron minnich <rminnich@gmail=2Ecom> wrote:
>Thanks for looking, but I'm not entirely sure how to parse your answer
>:-)
>
>In LinuxBoot, we compile Linux into a UEFI driver and load it in
>FLASH=2E It's started by the UEFI driver scheduler, a=2Ek=2Ea DxeCore=2E =
In
>this case, Linux is both a bootloader (for the Linux or other kernel
>it will boot) and Linux is also the thing booted by UEFI=2E As I
>mentioned, we want to avoid writing a UEFI driver just to tell Linux
>where to find the initramfs=2E Further, we want to be able to boot this
>kernel and have it use an initramfs provided by a different bootloader
>(pxeboot, for example)=2E This flexibility is proving very useful for
>companies deploying LinuxBoot today=2E
>
>I got the idea of using initrd=3D because u-boot is able to pass that
>option to the ARM kernel and the ARM kernel will process it: see,
>e=2Eg=2E, the usage in arch/arm/configs/acs5k_defconfig=2E
>
>Are you saying initrd is reserved for a bootloader to produce it or
>consume it? It's certainly not either on ARM: it is in some cases
>included in a compiled-in command line, and used by the kernel, just
>as we are doing in this patch=2E The kernel build process produces it,
>and the kernel consumes it=2E All this functionality is there, and all
>this patch does it bring it into the x86 kernel with this 6 line
>patch=2E
>
>If, in spite of this usage on ARM, you'd still not rather see a
>corresponding usage on x86, how do we get the effect we need here?
>Again, we don't want to write UEFI drivers, but we would like some
>minimal way to communicate to the kernel where an initramfs is in
>memory; and, further, we want it to be the lowest priority option, so
>we easily override it=2E Suggestions on how to do this are welcome=2E
>
>ron
>
>On Thu, Mar 19, 2020 at 4:57 PM <hpa@zytor=2Ecom> wrote:
>>
>> On March 19, 2020 4:49:05 PM PDT, ron minnich <rminnich@gmail=2Ecom>
>wrote:
>> >In LinuxBoot systems, a kernel and initramfs are loaded into FLASH
>> >to replace proprietary firmware/BIOS code=2E Space being at a premium
>> >on some systems, the kernel and initramfs must be place in whatever
>> >open corners of the FLASH exist=2E These corners are not always
>> >easily used=2E
>> >
>> >For example, on Intel-based UEFI systems, the Management Engine
>> >(ME) is given half the FLASH, though it uses very little, as little
>> >as 1=2E25MiB=2E  Not only is 2=2E75MiB of an 8MiB part unused; but
>> >10=2E75MiB of a 16MiB part is unused=2E This space can be recovered by
>> >a number of tools, e=2Eg=2E utk and its tighten_me command, and if
>> >Linux can be told where the space is Linux can load an initrd from
>> >it=2E
>> >
>> >In an ideal case, we would take the space from the ME and add it to
>> >a FLASH-based filesystem=2E  While UEFI does have filesystem-like
>> >structures, this recovered space can only be added to its "file
>> >system" by rebuilding UEFI from source or writing a UEFI device
>> >driver=2E Both these options are impractical in most cases=2E The spac=
e
>> >can only be referenced as a physical address=2E
>> >
>> >There is code in the core that allows specification of the initrd
>> >as a physical address and size, but it is not supported on all
>> >architectures=2E This patch adds support for initrd=3D to the x86=2E
>> >
>> >For debugging and recovery purposes, if initrd=3D is present in the
>> >command line, other existing initrd sources should still have
>> >higher priority=2E The initramfs in flash might be damaged or
>> >broken=2E Hence, it must still be possible to load a kernel and
>> >initramfs with a conventional bootloader, or even load the
>> >FLASH-based kernel with a different initramfs; or boot a
>> >kernel and let it use the initrd in FLASH=2E
>> >
>> >In support of that priority ordering, this patch sets the ramdisk
>> >image pointer to phys_initrd_start only if it is not already set;
>> >and sets ramdisk_size to phys_initrd_size only if it is not already
>> >set=2E
>> >
>> >It has been tested extensively in LinuxBoot environments=2E
>> >
>> >Signed-off-by: Ronald G=2E Minnich <rminnich@gmail=2Ecom>
>> >---
>> > arch/x86/kernel/setup=2Ec | 6 ++++++
>> > 1 file changed, 6 insertions(+)
>> >
>> >diff --git a/arch/x86/kernel/setup=2Ec b/arch/x86/kernel/setup=2Ec
>> >index a74262c71484=2E=2E1b04ef8ea12d 100644
>> >--- a/arch/x86/kernel/setup=2Ec
>> >+++ b/arch/x86/kernel/setup=2Ec
>> >@@ -237,6 +237,9 @@ static u64 __init get_ramdisk_image(void)
>> >
>> >     ramdisk_image |=3D (u64)boot_params=2Eext_ramdisk_image << 32;
>> >
>> >+    if (ramdisk_image =3D=3D 0) {
>> >+        ramdisk_image =3D phys_initrd_start;
>> >+    }
>> >     return ramdisk_image;
>> > }
>> > static u64 __init get_ramdisk_size(void)
>> >@@ -245,6 +248,9 @@ static u64 __init get_ramdisk_size(void)
>> >
>> >     ramdisk_size |=3D (u64)boot_params=2Eext_ramdisk_size << 32;
>> >
>> >+    if (ramdisk_size =3D=3D 0) {
>> >+        ramdisk_size =3D phys_initrd_size;
>> >+    }
>> >     return ramdisk_size;
>> > }
>>
>> The initrd=3D option is reserved namespace for the bootloader=2E It is
>also worth noting that the x86 boot protocol now allows the bootloader
>to point to arbitrary chunks of memory for the initrd=2E
>> --
>> Sent from my Android device with K-9 Mail=2E Please excuse my brevity=
=2E

It has been designated consumed by the bootloader on x86 since at least 19=
95=2E So ARM broke it=2E

How is this information passed to any version of Linux in the first place,=
 and how do you then start up Linux? I suspect this is probably rather simp=
le in the end=2E=2E=2E

Note that when Linux is run as an UEFI binary the kernel UEFI stub can loa=
d an initrd file via the UEFI file I/O interface=2E

In some ways, arguably the Right Thing for the firmware to expose this wou=
ld be to have a resource exposed via ACPI =2E


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
