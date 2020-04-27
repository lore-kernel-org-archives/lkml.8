Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED3FC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C2F2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0HfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgD0HfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:35:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91AAC061A0F;
        Mon, 27 Apr 2020 00:35:20 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSyIN-0005cg-8W; Mon, 27 Apr 2020 09:35:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D24F41C0131;
        Mon, 27 Apr 2020 09:35:14 +0200 (CEST)
Date:   Mon, 27 Apr 2020 07:35:14 -0000
From:   "tip-bot2 for Ronald G. Minnich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/setup: Add an initrdmem= option to specify initrd
 physical address
Cc:     "Ronald G. Minnich" <rminnich@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CAP6exYLK11rhreX=6QPyDQmW7wPHsKNEFtXE47pjx41xS6O7-A@mail.gmail.com>
References: <CAP6exYLK11rhreX=6QPyDQmW7wPHsKNEFtXE47pjx41xS6O7-A@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <158797291438.28353.15021917841777558855.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     694cfd87b0c8a48af2f1afb225563571c0b975c4
Gitweb:        https://git.kernel.org/tip/694cfd87b0c8a48af2f1afb225563571c0b975c4
Author:        Ronald G. Minnich <rminnich@gmail.com>
AuthorDate:    Sat, 25 Apr 2020 18:10:21 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 27 Apr 2020 09:28:16 +02:00

x86/setup: Add an initrdmem= option to specify initrd physical address

Add the initrdmem option:

  initrdmem=ss[KMG],nn[KMG]

which is used to specify the physical address of the initrd, almost
always an address in FLASH. Also add code for x86 to use the existing
phys_init_start and phys_init_size variables in the kernel.

This is useful in cases where a kernel and an initrd is placed in FLASH,
but there is no firmware file system structure in the FLASH.

One such situation occurs when unused FLASH space on UEFI systems has
been reclaimed by, e.g., taking it from the Management Engine. For
example, on many systems, the ME is given half the FLASH part; not only
is 2.75M of an 8M part unused; but 10.75M of a 16M part is unused. This
space can be used to contain an initrd, but need to tell Linux where it
is.

This space is "raw": due to, e.g., UEFI limitations: it can not be added
to UEFI firmware volumes without rebuilding UEFI from source or writing
a UEFI device driver. It can be referenced only as a physical address
and size.

At the same time, if a kernel can be "netbooted" or loaded from GRUB or
syslinux, the option of not using the physical address specification
should be available.

Then, it is easy to boot the kernel and provide an initrd; or boot the
the kernel and let it use the initrd in FLASH. In practice, this has
proven to be very helpful when integrating Linux into FLASH on x86.

Hence, the most flexible and convenient path is to enable the initrdmem
command line option in a way that it is the last choice tried.

For example, on the DigitalLoggers Atomic Pi, an image into FLASH can be
burnt in with a built-in command line which includes:

  initrdmem=0xff968000,0x200000

which specifies a location and size.

 [ bp: Massage commit message, make it passive. ]

[akpm@linux-foundation.org: coding style fixes]
Signed-off-by: Ronald G. Minnich <rminnich@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: http://lkml.kernel.org/r/CAP6exYLK11rhreX=6QPyDQmW7wPHsKNEFtXE47pjx41xS6O7-A@mail.gmail.com
Link: https://lkml.kernel.org/r/20200426011021.1cskg0AGd%akpm@linux-foundation.org
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 arch/x86/kernel/setup.c                         |  6 ++++++
 init/do_mounts_initrd.c                         | 13 ++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3..a441b4f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1748,6 +1748,13 @@
 
 	initrd=		[BOOT] Specify the location of the initial ramdisk
 
+	initrdmem=	[KNL] Specify a physical address and size from which to
+			load the initrd. If an initrd is compiled in or
+			specified in the bootparams, it takes priority over this
+			setting.
+			Format: ss[KMG],nn[KMG]
+			Default is 0, 0
+
 	init_on_alloc=	[MM] Fill newly allocated pages and heap objects with
 			zeroes.
 			Format: 0 | 1
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 4b3fa6c..a3767e7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -237,6 +237,9 @@ static u64 __init get_ramdisk_image(void)
 
 	ramdisk_image |= (u64)boot_params.ext_ramdisk_image << 32;
 
+	if (ramdisk_image == 0)
+		ramdisk_image = phys_initrd_start;
+
 	return ramdisk_image;
 }
 static u64 __init get_ramdisk_size(void)
@@ -245,6 +248,9 @@ static u64 __init get_ramdisk_size(void)
 
 	ramdisk_size |= (u64)boot_params.ext_ramdisk_size << 32;
 
+	if (ramdisk_size == 0)
+		ramdisk_size = phys_initrd_size;
+
 	return ramdisk_size;
 }
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index dab8b11..d72beda 100644
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
+	return early_initrdmem(p);
+}
 early_param("initrd", early_initrd);
 
 static int init_linuxrc(struct subprocess_info *info, struct cred *new)
