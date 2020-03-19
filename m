Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F168C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E824E20740
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2UpNnFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgCSXtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:49:17 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42622 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSXtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 19:49:17 -0400
Received: by mail-oi1-f195.google.com with SMTP id 13so4687281oiy.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 16:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=O6UYEuu9USYd3Lm4ZwOGt6AHTZhdq8dyDYUaZFKRfAw=;
        b=R2UpNnFWF9Dcbu0Bjkayq97kdYaixurxyQKhaCoIjtSRcIa919RhSx3VsZsz0dfqw6
         EgVjfgOsTMDJuVMH0Ig8bmC5VFUyPYxrM7pjaqc4lUKZbXOpHFK6Os5JvTOkxMA40lDY
         oOk8gbdLw9FI0bNHGs1OOm1Dh8C8keAnChC2meNY4KMWlRfuOtQxr7vZRZ4D2nBE10iy
         3ManvCKP09sfNk8jbCwmlnhwSnOMwp1caW3vqbfBPUdGR6nkbQZy+WFMLu5ljNoazr5W
         mMbzX46wOBJ/1l4m1TCfkbswrYRYOaeLs5cMaU9LMWYFMHoUkaSlXy14Kz7+XCaDy6YI
         SG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=O6UYEuu9USYd3Lm4ZwOGt6AHTZhdq8dyDYUaZFKRfAw=;
        b=WUaN3Vgue9ZE7V+GV4iXZtvp89Uh6CNRLpvbTS8N7eAodL9CKyuRsI151hm+kzLJDQ
         u7F+8NaX//xY6ZUnBS04Tlfyi24mLhywKJStQXhHILbj9xOmSKNtF4L5EWQBaXd/50aK
         jVlK4/x2pWdr9L44b0FCPY6E18N/u/WpSNGLezmHo6DCFnBsvA6u/2/J4/wO9UVoSCez
         0ygragx9T5YbqDwbb1oujiynjeFwSrpVCTEBaURsQQdKuNWzjFYwAtFPlt4c360cra0S
         AYUA7EE+bABK3KTBj3x+IIJwRPvS5OvP+ZCzxcAI8BFOEABSjf9bTZckIB+2gPeQ4Ioe
         zlIw==
X-Gm-Message-State: ANhLgQ3HhiBoW8U/+O/Q/tT+RJduwbOh27dYHx1VR8WEy05G0qIVOvaG
        P/603LA8NESxC6qYbupdqesyxiEQZjgZ900j6J4=
X-Google-Smtp-Source: ADFU+vuROdl+ozSkhfloI3j/e9o4YsKIhz3pHbuyhzobsGDKP8Fp2eQ0Iy+/WRBhjRMDF7/+lgmkxiQS4v6eXJh7DOg=
X-Received: by 2002:aca:1e1a:: with SMTP id m26mr4459581oic.39.1584661756692;
 Thu, 19 Mar 2020 16:49:16 -0700 (PDT)
MIME-Version: 1.0
From:   ron minnich <rminnich@gmail.com>
Date:   Thu, 19 Mar 2020 16:49:05 -0700
Message-ID: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
Subject: [PATCH 1/1] x86 support for the initrd= command line option
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

In LinuxBoot systems, a kernel and initramfs are loaded into FLASH
to replace proprietary firmware/BIOS code. Space being at a premium
on some systems, the kernel and initramfs must be place in whatever
open corners of the FLASH exist. These corners are not always
easily used.

For example, on Intel-based UEFI systems, the Management Engine
(ME) is given half the FLASH, though it uses very little, as little
as 1.25MiB.  Not only is 2.75MiB of an 8MiB part unused; but
10.75MiB of a 16MiB part is unused. This space can be recovered by
a number of tools, e.g. utk and its tighten_me command, and if
Linux can be told where the space is Linux can load an initrd from
it.

In an ideal case, we would take the space from the ME and add it to
a FLASH-based filesystem.  While UEFI does have filesystem-like
structures, this recovered space can only be added to its "file
system" by rebuilding UEFI from source or writing a UEFI device
driver. Both these options are impractical in most cases. The space
can only be referenced as a physical address.

There is code in the core that allows specification of the initrd
as a physical address and size, but it is not supported on all
architectures. This patch adds support for initrd= to the x86.

For debugging and recovery purposes, if initrd= is present in the
command line, other existing initrd sources should still have
higher priority. The initramfs in flash might be damaged or
broken. Hence, it must still be possible to load a kernel and
initramfs with a conventional bootloader, or even load the
FLASH-based kernel with a different initramfs; or boot a
kernel and let it use the initrd in FLASH.

In support of that priority ordering, this patch sets the ramdisk
image pointer to phys_initrd_start only if it is not already set;
and sets ramdisk_size to phys_initrd_size only if it is not already
set.

It has been tested extensively in LinuxBoot environments.

Signed-off-by: Ronald G. Minnich <rminnich@gmail.com>
---
 arch/x86/kernel/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

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

-- 
2.17.1
