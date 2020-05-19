Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4264EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218F0204EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgESMfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgESMfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:35:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8746C08C5C0;
        Tue, 19 May 2020 05:35:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb1TC-000059-FP; Tue, 19 May 2020 14:35:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 117451C0178;
        Tue, 19 May 2020 14:35:42 +0200 (CEST)
Date:   Tue, 19 May 2020 12:35:41 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Correct relocation destination on old linkers
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200207214926.3564079-1-nivedita@alum.mit.edu>
References: <20200207214926.3564079-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <158989174193.17951.2884071095602421323.tip-bot2@tip-bot2>
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

Commit-ID:     5214028dd89e49ba27007c3ee475279e584261f0
Gitweb:        https://git.kernel.org/tip/5214028dd89e49ba27007c3ee475279e584261f0
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Fri, 07 Feb 2020 16:49:26 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 19 May 2020 14:11:22 +02:00

x86/boot: Correct relocation destination on old linkers

For the 32-bit kernel, as described in

  6d92bc9d483a ("x86/build: Build compressed x86 kernels as PIE"),

pre-2.26 binutils generates R_386_32 relocations in PIE mode. Since the
startup code does not perform relocation, any reloc entry with R_386_32
will remain as 0 in the executing code.

Commit

  974f221c84b0 ("x86/boot: Move compressed kernel to the end of the
                 decompression buffer")

added a new symbol _end but did not mark it hidden, which doesn't give
the correct offset on older linkers. This causes the compressed kernel
to be copied beyond the end of the decompression buffer, rather than
flush against it. This region of memory may be reserved or already
allocated for other purposes by the bootloader.

Mark _end as hidden to fix. This changes the relocation from R_386_32 to
R_386_RELATIVE even on the pre-2.26 binutils.

For 64-bit, this is not strictly necessary, as the 64-bit kernel is only
built as PIE if the linker supports -z noreloc-overflow, which implies
binutils-2.27+, but for consistency, mark _end as hidden here too.

The below illustrates the before/after impact of the patch using
binutils-2.25 and gcc-4.6.4 (locally compiled from source) and QEMU.

  Disassembly before patch:
    48:   8b 86 60 02 00 00       mov    0x260(%esi),%eax
    4e:   2d 00 00 00 00          sub    $0x0,%eax
                          4f: R_386_32    _end
  Disassembly after patch:
    48:   8b 86 60 02 00 00       mov    0x260(%esi),%eax
    4e:   2d 00 f0 76 00          sub    $0x76f000,%eax
                          4f: R_386_RELATIVE      *ABS*

Dump from extract_kernel before patch:
	early console in extract_kernel
	input_data: 0x0207c098 <--- this is at output + init_size
	input_len: 0x0074fef1
	output: 0x01000000
	output_len: 0x00fa63d0
	kernel_total_size: 0x0107c000
	needed_size: 0x0107c000

Dump from extract_kernel after patch:
	early console in extract_kernel
	input_data: 0x0190d098 <--- this is at output + init_size - _end
	input_len: 0x0074fef1
	output: 0x01000000
	output_len: 0x00fa63d0
	kernel_total_size: 0x0107c000
	needed_size: 0x0107c000

Fixes: 974f221c84b0 ("x86/boot: Move compressed kernel to the end of the decompression buffer")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200207214926.3564079-1-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/head_32.S | 5 +++--
 arch/x86/boot/compressed/head_64.S | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index ab33070..03557f2 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -49,16 +49,17 @@
  * Position Independent Executable (PIE) so that linker won't optimize
  * R_386_GOT32X relocation to its fixed symbol address.  Older
  * linkers generate R_386_32 relocations against locally defined symbols,
- * _bss, _ebss, _got and _egot, in PIE.  It isn't wrong, just less
+ * _bss, _ebss, _got, _egot and _end, in PIE.  It isn't wrong, just less
  * optimal than R_386_RELATIVE.  But the x86 kernel fails to properly handle
  * R_386_32 relocations when relocating the kernel.  To generate
- * R_386_RELATIVE relocations, we mark _bss, _ebss, _got and _egot as
+ * R_386_RELATIVE relocations, we mark _bss, _ebss, _got, _egot and _end as
  * hidden:
  */
 	.hidden _bss
 	.hidden _ebss
 	.hidden _got
 	.hidden _egot
+	.hidden _end
 
 	__HEAD
 SYM_FUNC_START(startup_32)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 6b11060..e821a7d 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -42,6 +42,7 @@
 	.hidden _ebss
 	.hidden _got
 	.hidden _egot
+	.hidden _end
 
 	__HEAD
 	.code32
