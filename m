Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15AC20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uT+26KhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgCXQFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:05:38 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35102 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgCXQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:05:38 -0400
Received: by mail-oi1-f194.google.com with SMTP id k8so19016096oik.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwpTKi3gJ8BLkjQrFUw7l6hWz2zTWEixI9aoiPlw/WM=;
        b=uT+26KhJSGNNjdTx9pC/T5npeV70PL0PGLe+/aEb+5H+SUaaeX6fU4wfCyHA6eLpZs
         ojYWyx/oM8MwhW4iBGK7nbAO6UBq+q+VUDmnuIhOxPtMABwhCYmcrhLBPz19vOMiQkeR
         n1SKwoenqQxaopHOox20EOC+X/alIJyxK3rQ2W9zr37BlJ+j34BkEXHkkXdZG7tyP0K6
         jvR+S0OHxfl1Nw0N+vD4ybcwfk6X1jbljeyIdQiry9qk7Kq1omSOuFUDarP1J8P3PL+9
         dO4EmidUOl7KZBYwo1DbPR4tw03dkW2DY5t78PDeuj2k4HQ+GKrzbR9c/eBa5N4Cm6n6
         pyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwpTKi3gJ8BLkjQrFUw7l6hWz2zTWEixI9aoiPlw/WM=;
        b=DmmguzyzdNhpHogJaeHfCxdSnBDbIxZcLO6Du/chMB5WtXH7pBg1Tp+4w6Oh7c0433
         wwE58ZYeOnhFj03iLQYOS9xecj945A3A+WXXbwUGZI8N5+kj4u2KQp9kPCWurYkTJ7nb
         MVAne/D/eK+HTUL/ePVVNWOdUtbGOpG/THWtcRdG2+3ES7/XFfHvWqaK0D7/q5sAdxYk
         rqpkBiRornh0K7qgRary8anB2hPbXmZs/smlXBDNk2s3KTNlEBoVmIq3GVBhFcG+uvFW
         Wk6an53h1igEamfQtIy5bJFBemt4zZk8LDtYTApjmEUt9QKSa7GpDvmcSVVm8OTWf4rd
         3R0A==
X-Gm-Message-State: ANhLgQ3WZ4MfmolTLDImb3pJC+iVoa4hh3W+0LNtUsSKU/u4CbH3X6Sz
        Bsa5k1I4uqCuZSNL3k4u4ua8eG6DnCVbbBZhQUSL4CYKtCU=
X-Google-Smtp-Source: ADFU+vvS67Pjuew+uES3TAgl+KCsbVZSgUgZUlkhjy1YaDMbIQ+B9+BqXvwqfHucGDmPVKXp1TQY+VGiMeV/4l910bs=
X-Received: by 2002:aca:1e1a:: with SMTP id m26mr4012187oic.39.1585065937556;
 Tue, 24 Mar 2020 09:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
 <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
 <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com> <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com>
 <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com> <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com>
 <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com> <CAP6exYJj5n8tLibwnAPA554ax9gjUFvyMntCx4OYULUOknWQ0g@mail.gmail.com>
 <C2B3BE61-665A-47FD-87E0-BDB5C30CEFF4@zytor.com> <CAP6exY+avh0G3nuqbxJj2ZgKkRdvwGTKeWyazqXJHbp+X-2u+A@mail.gmail.com>
 <CAP6exYLEg+iu4Hs0+vdk0b6rgB5ZT7ZTvuhe--biCg9dGbNCTQ@mail.gmail.com>
In-Reply-To: <CAP6exYLEg+iu4Hs0+vdk0b6rgB5ZT7ZTvuhe--biCg9dGbNCTQ@mail.gmail.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Tue, 24 Mar 2020 09:05:26 -0700
Message-ID: <CAP6exYLCFp8AMFx_d3XJtYiSibF76Fo-km4vB5MwSbqE8D8DNA@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the version that I think does what you asked.

I'd like to change the patch title but left it on this email thread.


Subject: [PATCH 1/1] initrdmem= option to specify initrd physical address

This patch adds the initrdmem option:
initrdmem=ss[KMG],nn[KMG]
which is used to specify the physical address of the initrd,
almost always an address in FLASH. It also adds code for
x86 to use the existing phys_init_start and
phys_init_size variables in the kernel.
This is useful in cases where we wish to place a kernel
and initrd in FLASH, but there is no firmware file
system structure in the FLASH.

One such situation occurs when we have reclaimed unused FLASH
space on UEFI systems by, e.g., taking it from the Management
Engine. For example, on many systems, the ME is given half the
FLASH part; not only is 2.75M of an 8M part unused; but 10.75M
of a 16M part is unused. We can use this space to contain
an initrd, but need to tell Linux where it is.

This space is "raw": due to, e.g., UEFI limitations:
it can not be added to UEFI firmware volumes without rebuilding
UEFI from source or writing a UEFI device driver. We can reference it
only as a physical address and size.

At the same time, should we netboot a kernel or load it from
GRUB or syslinux, we want to have the option of not using
the physical address specification. Then, should we wish, it
is easy to boot the kernel and provide an initrd; or boot the
the kernel and let it use the initrd in FLASH. In practice this
has proven to be very helpful as we integrate Linux into FLASH
on x86.

Hence, the most flexible and convenient path is to enable the
initrdmem command line flag in a way that it is the last choice tried.

For example, on the DigitalLoggers Atomic Pi, we burn an image into
FLASH with a built-in command line which includes:
initrdmem=0xff968000,0x200000
which specifies a location and size.

Signed-off-by: Ronald G. Minnich <rminnich@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 arch/x86/kernel/setup.c                         |  6 ++++++
 init/do_mounts_initrd.c                         | 13 ++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt
b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..9cd356958a7f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1714,6 +1714,13 @@

     initrd=        [BOOT] Specify the location of the initial ramdisk

+    initrdmem=    [KNL] Specify a physical adddress and size from which
+            to load the inird. If an initrd is compiled in or
+            specified in the bootparams, it takes priority
+            over this setting.
+            Format: ss[KMG],nn[KMG]
+            Defaut is 0, 0
+
     init_on_alloc=    [MM] Fill newly allocated pages and heap objects with
             zeroes.
             Format: 0 | 1
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a74262c71484..1b04ef8ea12d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -237,6 +237,9 @@ static u64 __init get_ramdisk_image(void)

     ramdisk_image |= (u64)boot_params.ext_ramdisk_image << 32;

+    if (ramdisk_image == 0) {
+        ramdisk_image = phys_initrd_start;
+    }
     return ramdisk_image;
 }
 static u64 __init get_ramdisk_size(void)
@@ -245,6 +248,9 @@ static u64 __init get_ramdisk_size(void)

     ramdisk_size |= (u64)boot_params.ext_ramdisk_size << 32;

+    if (ramdisk_size == 0) {
+        ramdisk_size = phys_initrd_size;
+    }
     return ramdisk_size;
 }

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index dab8b1151b56..d72beda824aa 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -28,7 +28,7 @@ static int __init no_initrd(char *str)

 __setup("noinitrd", no_initrd);

-static int __init early_initrd(char *p)
+static int __init early_initrdmem(char *p)
 {
     phys_addr_t start;
     unsigned long size;
@@ -43,6 +43,17 @@ static int __init early_initrd(char *p)
     }
     return 0;
 }
+early_param("initrdmem", early_initrdmem);
+
+/*
+ * This is here as the initrd keyword has been in use since 11/2018
+ * on ARM, PowerPC, and MIPS.
+ * It should not be; it is reserved for bootloaders.
+ */
+static int __init early_initrd(char *p)
+{
+    return early_initrdmem(p);
+}
 early_param("initrd", early_initrd);

 static int init_linuxrc(struct subprocess_info *info, struct cred *new)
-- 
2.17.1
