Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46F9C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C6320724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvwCk952"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgCVQb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:31:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35516 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCVQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:31:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id k26so11012290otr.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rE1paS4p2jyWTXkjBBokLZuTQ89ze7aCdRvVGvddOTc=;
        b=WvwCk9523yeNbywcS3SJKrelb/P70ZdC7nvbK+WMfYb+aKxG8FbQ1ksM3LqfHW8gvZ
         1wn1/ZaoOMtIv8tfuW7GutVK66orW02JMz02+1N4N/sQXz9h60fkrD8o9QMdtDz+fARh
         aJGoO+dIAlZLPoBxv3zai+e2FY7FbGNgBf0k3gK0yMYPzQC1IU62QswVoC4SNCamVF1i
         Rt5jAURaGwnnx8z2O+W2QE1do45wvvPzpOpO9ppaa0wcUO1UF3ciZvUMeAR2k3rVoFaM
         EFUVlhy+UciFBxb3JCsjlgZUi8n7ViI28j33zyF+f9xYbYONcPRSDgvUIkihng0bhgX/
         fEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rE1paS4p2jyWTXkjBBokLZuTQ89ze7aCdRvVGvddOTc=;
        b=Egit6/BrQ/XB/i10irH1AaPJsGHEZsOyKkknn1RUR/k7YuI9IURB3SBOe8E57cSrPN
         iAdilkx5d66hKBUFUeAKUu5i2b/X0ufCMkqA33jlfjp/VJpFZ2B+iAXa9iGwmB3pEj9s
         V3KOqsHbjQ/3ugf9qG/rk3XIf6Z71uilSTwVO6+WK8jCOFB1ILAp14mOhow2gua73+dO
         0oSojtSuF/jdptZq/HRWT72ypeJ8rcjS1ziXhK65hNj2YBOWdc4ULi+4xVZnUUcJmCrY
         CMyzJZizm3ly2cG0S+eUAR4aKGAWlw4jJLD9/2CU6k+lRM5X/sEqwpERgnpl2Np73EZO
         sasg==
X-Gm-Message-State: ANhLgQ12PN00Z27qVCo2tEx+wOZEHbbp9pwVoqJ3OARroSVbUUVRFoWr
        dov6qpzRAgw+HWmyV5PNr6UgiUS7YubJ+YgaXDU=
X-Google-Smtp-Source: ADFU+vsnn84YtA90phzuq7MHfIWuOBy7VU5ziU+i60uPqhGRpK3xVrkcsQsZHWqnWSQuyJq93szEqPs9hv9xjdiO32M=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr5496911oth.338.1584894718538;
 Sun, 22 Mar 2020 09:31:58 -0700 (PDT)
MIME-Version: 1.0
From:   ron minnich <rminnich@gmail.com>
Date:   Sun, 22 Mar 2020 09:31:47 -0700
Message-ID: <CAP6exYKCN3k3YLT9WRFYjhhwYn9D0Dg7ow2-mJKGBCQu5r6QSw@mail.gmail.com>
Subject: x86: add phys_initrd_[start,size] as an initrd source
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
to replace proprietary firmware/BIOS code. In most systems, the initrd
is compiled into the kernel, where space allows. Space being at a premium
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

The initrd code provides two variables, phys_initrd_start
and phys_initrd_size, which can be used to indicate the
location of an initrd, which is in the physical address
space but not compiled in or provided in the bootparams.

For debugging and recovery purposes,
other existing initrd sources should still have
higher priority. The initramfs in FLASH might be damaged or
broken.

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
