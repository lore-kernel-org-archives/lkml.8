Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BEAC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE74F206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436655AbgDNIXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407132AbgDNIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:20:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A598DC008748;
        Tue, 14 Apr 2020 01:20:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOGoN-0006IP-NF; Tue, 14 Apr 2020 10:20:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 554D21C0086;
        Tue, 14 Apr 2020 10:20:51 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:20:50 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Always relocate the kernel for EFI handover entry
Cc:     Sergey Shatunov <me@prok.pw>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200406180614.429454-2-nivedita@alum.mit.edu>
References: <20200406180614.429454-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <158685245097.28353.4683726496003889001.tip-bot2@tip-bot2>
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

Commit-ID:     21cb9b414301c76f77f70d990a784ad6360e5a20
Gitweb:        https://git.kernel.org/tip/21cb9b414301c76f77f70d990a784ad6360e5a20
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Thu, 09 Apr 2020 15:04:29 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 14 Apr 2020 08:32:13 +02:00

efi/x86: Always relocate the kernel for EFI handover entry

Commit

  d5cdf4cfeac9 ("efi/x86: Don't relocate the kernel unless necessary")

tries to avoid relocating the kernel in the EFI stub as far as possible.

However, when systemd-boot is used to boot a unified kernel image [1],
the image is constructed by embedding the bzImage as a .linux section in
a PE executable that contains a small stub loader from systemd that will
call the EFI stub handover entry, together with additional sections and
potentially an initrd. When this image is constructed, by for example
dracut, the initrd is placed after the bzImage without ensuring that at
least init_size bytes are available for the bzImage. If the kernel is
not relocated by the EFI stub, this could result in the compressed
kernel's startup code in head_{32,64}.S overwriting the initrd.

To prevent this, unconditionally relocate the kernel if the EFI stub was
entered via the handover entry point.

[1] https://systemd.io/BOOT_LOADER_SPECIFICATION/#type-2-efi-unified-kernel-images

Fixes: d5cdf4cfeac9 ("efi/x86: Don't relocate the kernel unless necessary")
Reported-by: Sergey Shatunov <me@prok.pw>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200406180614.429454-2-nivedita@alum.mit.edu
Link: https://lore.kernel.org/r/20200409130434.6736-5-ardb@kernel.org
---
 drivers/firmware/efi/libstub/x86-stub.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 867a57e..05ccb22 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -740,8 +740,15 @@ unsigned long efi_main(efi_handle_t handle,
 	 * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
 	 * KASLR uses.
 	 *
-	 * Also relocate it if image_offset is zero, i.e. we weren't loaded by
-	 * LoadImage, but we are not aligned correctly.
+	 * Also relocate it if image_offset is zero, i.e. the kernel wasn't
+	 * loaded by LoadImage, but rather by a bootloader that called the
+	 * handover entry. The reason we must always relocate in this case is
+	 * to handle the case of systemd-boot booting a unified kernel image,
+	 * which is a PE executable that contains the bzImage and an initrd as
+	 * COFF sections. The initrd section is placed after the bzImage
+	 * without ensuring that there are at least init_size bytes available
+	 * for the bzImage, and thus the compressed kernel's startup code may
+	 * overwrite the initrd unless it is moved out of the way.
 	 */
 
 	buffer_start = ALIGN(bzimage_addr - image_offset,
@@ -751,8 +758,7 @@ unsigned long efi_main(efi_handle_t handle,
 	if ((buffer_start < LOAD_PHYSICAL_ADDR)				     ||
 	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
 	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
-	    (image_offset == 0 && !IS_ALIGNED(bzimage_addr,
-					      hdr->kernel_alignment))) {
+	    (image_offset == 0)) {
 		status = efi_relocate_kernel(&bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
