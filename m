Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF7C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC1F20720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBGVta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:49:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36347 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGVta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:49:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id w25so635239qki.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 13:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WEJk8Oy/CNYv/gkiY9D6Sj5zl9j37288c0ApTKEqrQ=;
        b=ZQgD7a9PpghFRhZcrRPBBbxxABMkUdbR4iQUXu/SvKZBpn5MTQURAAeHS4XWTo/0jD
         DaCDALk1GHpeG90BVRY+tOcCc4SdKem18tS7U66lQs97RLeCfn3LlUdMzU01aMPIglZL
         aEH6I4WZ1irbpWhW9ndNS2dc+QdOR1//ldReGPA4EFI4SBHocoQ2nyOcvGzTSbBF5U+c
         OOFwx3GdYxl91fNtlIOuWYqnlnRV5rHAyx4BP0/xQLkSr8DdIIsuvwjSwt+vFenbmctx
         CHgY0H0TXTZiqwsKuV2K08NIPnfic+0IhbNAeGYJC6oxA9lmLcQWqC2pAauz/JN7q98n
         44gQ==
X-Gm-Message-State: APjAAAWicCutVE9mtf8LiK1QcyD7QDuwRyHkW2S6SbZCp0qfcYZTnkau
        Dqzt510GGjsUoANTF/GFwHTSUNnl0OU=
X-Google-Smtp-Source: APXvYqyYN83J/OjEFtN/ZtI3VLl9UH57dW7zTfg/OCv54KdrJaqk6XCEVsRwzjWBLY0ci+xiu59Mdw==
X-Received: by 2002:ae9:c318:: with SMTP id n24mr1041734qkg.38.1581112167966;
        Fri, 07 Feb 2020 13:49:27 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m27sm2081982qta.21.2020.02.07.13.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 13:49:27 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>
Subject: [PATCH v2] x86/boot: Correct relocation destination on old linkers
Date:   Fri,  7 Feb 2020 16:49:26 -0500
Message-Id: <20200207214926.3564079-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111190015.3257863-1-nivedita@alum.mit.edu>
References: <20200111190015.3257863-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the 32-bit kernel, as described in commit 6d92bc9d483a ("x86/build:
Build compressed x86 kernels as PIE"), pre-2.26 binutils generates
R_386_32 relocations in PIE mode.  Since the startup code does not
perform relocation, any reloc entry with R_386_32 will remain as 0 in
the executing code.

Commit 974f221c84b0 ("x86/boot: Move compressed kernel to the end of the
decompression buffer") added a new symbol _end but did not mark it
hidden, which doesn't give the correct offset on older linkers. This
causes the compressed kernel to be copied beyond the end of the
decompression buffer, rather than flush against it. This region of
memory may be reserved or already allocated for other purposes by the
bootloader.

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
---
Changes from v1: more extensive commit message illustrating the issue

 arch/x86/boot/compressed/head_32.S | 5 +++--
 arch/x86/boot/compressed/head_64.S | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 73f17d0544dd..bf707c989236 100644
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
index 1f1f6c8139b3..949909548b86 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -42,6 +42,7 @@
 	.hidden _ebss
 	.hidden _got
 	.hidden _egot
+	.hidden _end
 
 	__HEAD
 	.code32
-- 
2.24.1

