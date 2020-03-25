Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5523C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9712920772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AsmavEhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCYRXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:23:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41563 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbgCYRXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:23:10 -0400
Received: from [IPv6:2601:646:8600:3281:c898:2a71:8b3c:1618] ([IPv6:2601:646:8600:3281:c898:2a71:8b3c:1618])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 02PHLjgI3526476
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 25 Mar 2020 10:21:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 02PHLjgI3526476
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020032201; t=1585156906;
        bh=hNa8evV5Hu1zOs/UUGiqrSieOily/K/LQaClIZEAxmc=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=AsmavEhCc1MFkyU0nBp1sVNYnVxuijnL/E5P61pz6a+Pa6hrtKVg54sNCJBe7RoX9
         CWtebAS/xDHrfxUFzQUGWphTWVZgT4FSTu8bTkJKqg8kfJYu72IZz3HJ8x9fzCrIwf
         SP2PvNTMj4+NIi8nhpOTmCwc8pqNJfYLS8f5E2mJEr2oPEoDkOqCbHZilmIUoFnfP3
         0fmfd6lah2QwXcrUbrWZwJmEoz5IItpE4umtgf1wR9/73SoPfDFUOM5AA9NYaXHZgq
         XxI76OYxuel3r2Oeyn6HRMr9mjNcZXLeII/fC3ry5y5ayujkiyj7B53wEileAVuoey
         Pofp5dLQKUqXg==
Date:   Wed, 25 Mar 2020 10:21:39 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP6exYLK11rhreX=6QPyDQmW7wPHsKNEFtXE47pjx41xS6O7-A@mail.gmail.com>
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com> <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com> <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com> <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com> <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com> <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com> <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com> <CAP6exYJj5n8tLibwnAPA554ax9gjUFvyMntCx4OYULUOknWQ0g@mail.gmail.com> <C2B3BE61-665A-47FD-87E0-BDB5C30CEFF4@zytor.com> <CAP6exY+avh0G3nuqbxJj2ZgKkRdvwGTKeWyazqXJHbp+X-2u+A@mail.gmail.com> <CAP6exYLEg+iu4Hs0+vdk0b6rgB5ZT7ZTvuhe--biCg9dGbNCTQ@mail.gmail.com> <CAP6exYLCFp8AMFx_d3XJtYiSibF76Fo-km4vB5MwSbqE8D8DNA@mail.gmail.com> <2837291a-b682-bd6d-4e08-ffa76d3097b0@infradead.org> <CAP6exYLK11rhreX=6QPyDQmW7wPHsKNEFtXE47pjx41xS6O7-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     ron minnich <rminnich@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <F4664C3D-B6A0-4559-BEFB-59098190904D@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 24, 2020 9:19:01 AM PDT, ron minnich <rminnich@gmail=2Ecom> wrote:
>Subject: [PATCH 1/1] initrdmem=3D option to specify initrd physical
>address
>
>This patch adds the initrdmem option:
>initrdmem=3Dss[KMG],nn[KMG]
>which is used to specify the physical address of the initrd,
>almost always an address in FLASH=2E It also adds code for
>x86 to use the existing phys_init_start and
>phys_init_size variables in the kernel=2E
>This is useful in cases where we wish to place a kernel
>and initrd in FLASH, but there is no firmware file
>system structure in the FLASH=2E
>
>One such situation occurs when we have reclaimed unused FLASH
>space on UEFI systems by, e=2Eg=2E, taking it from the Management
>Engine=2E For example, on many systems, the ME is given half the
>FLASH part; not only is 2=2E75M of an 8M part unused; but 10=2E75M
>of a 16M part is unused=2E We can use this space to contain
>an initrd, but need to tell Linux where it is=2E
>
>This space is "raw": due to, e=2Eg=2E, UEFI limitations:
>it can not be added to UEFI firmware volumes without rebuilding
>UEFI from source or writing a UEFI device driver=2E We can reference it
>only as a physical address and size=2E
>
>At the same time, should we netboot a kernel or load it from
>GRUB or syslinux, we want to have the option of not using
>the physical address specification=2E Then, should we wish, it
>is easy to boot the kernel and provide an initrd; or boot the
>the kernel and let it use the initrd in FLASH=2E In practice this
>has proven to be very helpful as we integrate Linux into FLASH
>on x86=2E
>
>Hence, the most flexible and convenient path is to enable the
>initrdmem command line flag in a way that it is the last choice tried=2E
>
>For example, on the DigitalLoggers Atomic Pi, we burn an image into
>FLASH with a built-in command line which includes:
>initrdmem=3D0xff968000,0x200000
>which specifies a location and size=2E
>
>Signed-off-by: Ronald G=2E Minnich <rminnich@gmail=2Ecom>
>---
> Documentation/admin-guide/kernel-parameters=2Etxt |  7 +++++++
> arch/x86/kernel/setup=2Ec                         |  6 ++++++
> init/do_mounts_initrd=2Ec                         | 13 ++++++++++++-
> 3 files changed, 25 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/admin-guide/kernel-parameters=2Etxt
>b/Documentation/admin-guide/kernel-parameters=2Etxt
>index c07815d230bc=2E=2E9cd356958a7f 100644
>--- a/Documentation/admin-guide/kernel-parameters=2Etxt
>+++ b/Documentation/admin-guide/kernel-parameters=2Etxt
>@@ -1714,6 +1714,13 @@
>
>     initrd=3D        [BOOT] Specify the location of the initial ramdisk
>
>+    initrdmem=3D    [KNL] Specify a physical adddress and size from
>which
>+            to load the initrd=2E If an initrd is compiled in or
>+            specified in the bootparams, it takes priority
>+            over this setting=2E
>+            Format: ss[KMG],nn[KMG]
>+            Default is 0, 0
>+
>init_on_alloc=3D    [MM] Fill newly allocated pages and heap objects with
>             zeroes=2E
>             Format: 0 | 1
>diff --git a/arch/x86/kernel/setup=2Ec b/arch/x86/kernel/setup=2Ec
>index a74262c71484=2E=2E1b04ef8ea12d 100644
>--- a/arch/x86/kernel/setup=2Ec
>+++ b/arch/x86/kernel/setup=2Ec
>@@ -237,6 +237,9 @@ static u64 __init get_ramdisk_image(void)
>
>     ramdisk_image |=3D (u64)boot_params=2Eext_ramdisk_image << 32;
>
>+    if (ramdisk_image =3D=3D 0) {
>+        ramdisk_image =3D phys_initrd_start;
>+    }
>     return ramdisk_image;
> }
> static u64 __init get_ramdisk_size(void)
>@@ -245,6 +248,9 @@ static u64 __init get_ramdisk_size(void)
>
>     ramdisk_size |=3D (u64)boot_params=2Eext_ramdisk_size << 32;
>
>+    if (ramdisk_size =3D=3D 0) {
>+        ramdisk_size =3D phys_initrd_size;
>+    }
>     return ramdisk_size;
> }
>
>diff --git a/init/do_mounts_initrd=2Ec b/init/do_mounts_initrd=2Ec
>index dab8b1151b56=2E=2Ed72beda824aa 100644
>--- a/init/do_mounts_initrd=2Ec
>+++ b/init/do_mounts_initrd=2Ec
>@@ -28,7 +28,7 @@ static int __init no_initrd(char *str)
>
> __setup("noinitrd", no_initrd);
>
>-static int __init early_initrd(char *p)
>+static int __init early_initrdmem(char *p)
> {
>     phys_addr_t start;
>     unsigned long size;
>@@ -43,6 +43,17 @@ static int __init early_initrd(char *p)
>     }
>     return 0;
> }
>+early_param("initrdmem", early_initrdmem);
>+
>+/*
>+ * This is here as the initrd keyword has been in use since 11/2018
>+ * on ARM, PowerPC, and MIPS=2E
>+ * It should not be; it is reserved for bootloaders=2E
>+ */
>+static int __init early_initrd(char *p)
>+{
>+    return early_initrdmem(p);
>+}
> early_param("initrd", early_initrd);
>
>static int init_linuxrc(struct subprocess_info *info, struct cred *new)

Reviewed-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
