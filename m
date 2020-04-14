Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78100C352B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E682206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436623AbgDNIX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407126AbgDNIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:20:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6559C0A3BE2;
        Tue, 14 Apr 2020 01:20:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOGoM-0006Hn-Rx; Tue, 14 Apr 2020 10:20:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 739CE1C0086;
        Tue, 14 Apr 2020 10:20:50 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:20:50 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] Documentation/x86, efi/x86: Clarify EFI handover
 protocol and its requirements
Cc:     Borislav Petkov <bp@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200409130434.6736-7-ardb@kernel.org>
References: <20200409130434.6736-7-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <158685245007.28353.9642020863132398203.tip-bot2@tip-bot2>
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

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     8b84769a7a1505b279b337dae83d16390e83f5c1
Gitweb:        https://git.kernel.org/tip/8b84769a7a1505b279b337dae83d16390e83f5c1
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 09 Apr 2020 15:04:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 14 Apr 2020 08:32:15 +02:00

Documentation/x86, efi/x86: Clarify EFI handover protocol and its requirements

The EFI handover protocol was introduced on x86 to permit the boot
loader to pass a populated boot_params structure as an additional
function argument to the entry point. This allows the bootloader to
pass the base and size of a initrd image, which is more flexible
than relying on the EFI stub's file I/O routines, which can only
access the file system from which the kernel image itself was loaded
from firmware.

This approach requires a fair amount of internal knowledge regarding
the layout of the boot_params structure on the part of the boot loader,
as well as knowledge regarding the allowed placement of the initrd in
memory, and so it has been deprecated in favour of a new initrd loading
method that is based on existing UEFI protocols and best practices.

So update the x86 boot protocol documentation to clarify that the EFI
handover protocol has been deprecated, and while at it, add a note that
invoking the EFI handover protocol still requires the PE/COFF image to
be loaded properly (as opposed to simply being copied into memory).
Also, drop the code32_start header field from the list of values that
need to be provided, as this is no longer required.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200409130434.6736-7-ardb@kernel.org
---
 Documentation/x86/boot.rst | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index fa7ddc0..5325c71 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1399,8 +1399,8 @@ must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
 must be __BOOT_DS; interrupt must be disabled; %rsi must hold the base
 address of the struct boot_params.
 
-EFI Handover Protocol
-=====================
+EFI Handover Protocol (deprecated)
+==================================
 
 This protocol allows boot loaders to defer initialisation to the EFI
 boot stub. The boot loader is required to load the kernel/initrd(s)
@@ -1408,6 +1408,12 @@ from the boot media and jump to the EFI handover protocol entry point
 which is hdr->handover_offset bytes from the beginning of
 startup_{32,64}.
 
+The boot loader MUST respect the kernel's PE/COFF metadata when it comes
+to section alignment, the memory footprint of the executable image beyond
+the size of the file itself, and any other aspect of the PE/COFF header
+that may affect correct operation of the image as a PE/COFF binary in the
+execution context provided by the EFI firmware.
+
 The function prototype for the handover entry point looks like this::
 
     efi_main(void *handle, efi_system_table_t *table, struct boot_params *bp)
@@ -1419,9 +1425,18 @@ UEFI specification. 'bp' is the boot loader-allocated boot params.
 
 The boot loader *must* fill out the following fields in bp::
 
-  - hdr.code32_start
   - hdr.cmd_line_ptr
   - hdr.ramdisk_image (if applicable)
   - hdr.ramdisk_size  (if applicable)
 
 All other fields should be zero.
+
+NOTE: The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
+      entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
+      loading protocol (refer to [0] for an example of the bootloader side of
+      this), which removes the need for any knowledge on the part of the EFI
+      bootloader regarding the internal representation of boot_params or any
+      requirements/limitations regarding the placement of the command line
+      and ramdisk in memory, or the placement of the kernel image itself.
+
+[0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
