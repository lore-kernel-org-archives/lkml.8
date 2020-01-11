Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A7AC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 19:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872672084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 19:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgAKTAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 14:00:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36402 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730851AbgAKTAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 14:00:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so5069531qkc.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 11:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sladguh/MWEPFdXOX2gUvv7NIFdbKZrPNbZv9Rn+p2w=;
        b=RfnYgmX5aXt4nGx5itAt1pMa5NV1nq8+CEKnEk2UgNXJh4W4/rkULl1xG0wa+tjT9/
         egIl4yv20wwhGJRqAIkqjuJG4rrsu7K5NCRLgsu1vjMfcMJ30KWRMmJv/NP3O05RjdzI
         keJjvJOz8jPFijEAu8bWGHuJrvnGP5LiNUsSfITeQY2xHI4cNXZt5pN8TvgVDLqnkbCz
         cvHeow/yPFGY+OogMsiHsHjeiJy9rRRAOGF1lg+eg9gd9IBBCBr1qLPzCBXtGZl8t8cV
         thjqcUYeUnPXmGvyQOudQUE0pN0UlydoxvpcZFDXgUyec7ocZr5VDrhSHT26xk5F9gaK
         IX9g==
X-Gm-Message-State: APjAAAXa2ABmHGadEMrk677GrmaEdtVfK9EoadK1MSRLLdQUkEHILzR8
        DKJ8/PR7RAA3NzXGGXw568s=
X-Google-Smtp-Source: APXvYqx2ekOCERHJD8IIBA+MA6nFGdpAFyK86diHqEELmRiuUq+UIpcMUhwbSw8i/qQ6+2MD0AbL0A==
X-Received: by 2002:a05:620a:8ca:: with SMTP id z10mr4176340qkz.345.1578769217126;
        Sat, 11 Jan 2020 11:00:17 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s27sm2588518qkm.97.2020.01.11.11.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 11:00:16 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot/compressed: Correct relocation destination on old linkers
Date:   Sat, 11 Jan 2020 14:00:15 -0500
Message-Id: <20200111190015.3257863-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in commit 6d92bc9d483a ("x86/build: Build compressed x86
kernels as PIE"), pre-2.26 binutils generates R_386_32 relocations in
PIE mode.  Since the startup code does not perform relocation, any reloc
entry with R_386_32 will remain as 0 in the executing code.

Commit 974f221c84b0 ("x86/boot: Move compressed kernel to the end of the
decompression buffer") added a new symbol _end but did not mark it
hidden, which doesn't give the correct offset on older linkers. This
doesn't cause a crash, but means the compressed kernel is actually
relocated starting from the end of the decompression buffer, rather than
ending there.

Mark _end as hidden to fix.

Fixes: 974f221c84b0 ("x86/boot: Move compressed kernel to the end of the decompression buffer")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_32.S | 5 +++--
 arch/x86/boot/compressed/head_64.S | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index f2dfd6d083ef..e4d1142f9f65 100644
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
index 6eb30f8a3ce7..206fb95e827c 100644
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

