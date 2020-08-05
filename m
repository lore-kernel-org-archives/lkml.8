Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C6AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D0E2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib8UmrRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgHEXGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgHEXGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:06:41 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18060C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 16:06:41 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m20so24269731eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ugpCHrDGvy4dT/GF8AtKUlBa0Dp+LOrlZ5QHzsSHdk=;
        b=Ib8UmrRZpRTaU4RkseJ2F6mqb63ydeGwjzIlINTEI5t3452imxFBNgPe19+nXpt9e7
         vbB6Mhapp8rY64sn6SlaDBF+Pl5QKbSDaXLlzQPkdgaSjXMJie/kelMPU9RGaO4dlrBW
         Nh9z9oC2WofASk8fVHfr0Vh9wkT8tOg4zuw6WRUnOfdOlh3+0HhREC1WKPvJb9yGX/iw
         m/Ak94m5BkJlkfaFhvc4sTBhGwq+32/nF2VlZ9VSi5gqkGJcTEGHZeLBMLJymidIGl1W
         +o6Lu07Cx8RVfqbFcYH3Duup40HMYzvPT+8Z0vhys5q/Y9SwAv6El0Vpjd/j2M/vouL7
         B34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ugpCHrDGvy4dT/GF8AtKUlBa0Dp+LOrlZ5QHzsSHdk=;
        b=pwD6Jqp478ZZevcEHnRlEdOtHqsXm8TlGRGrYqrVHdNXllQtWIVF+mZVhHzc7PuikF
         7QfwfIQbhkskIr5PRAqNvzrrgKGO8v9kQgQr5WGBIRGMBbaTXUvv7HkMD1NuQrUjV37p
         CY/pIcGmkFTTZ1v7fiJA55KgfxR/twLNXbpzv2/CZgcBaFTS/ugt5FbNVrVrMVEMsk4q
         gh8Wb7PgxVDwPvT6E/emYdRZVRuZ10Yut5wvBiHCdWALptbAoBPslDdi0Y/cr3VvAqux
         9SVKSADyC7/HNuwguoXKGz6ydzdD9PnJr0QF8ZBzE9ZlTd/F7jy7hDx+LrqByHd7alpK
         wp0Q==
X-Gm-Message-State: AOAM533jO1XNY4WlbOmrWlcHt+nik/CcqxMNj5tiZeoAGcfaw3YmYtAm
        fRrrCMfdHEnb8ZzkrHyHE7c=
X-Google-Smtp-Source: ABdhPJwXgKYT05nxwoXY0iwa5xEv3QRUQcoeTuiPzXkTjk36/b4J143e3LjRJWsfUX43KvMhd+n9aA==
X-Received: by 2002:a05:6402:16d1:: with SMTP id r17mr1464635edx.79.1596668799116;
        Wed, 05 Aug 2020 16:06:39 -0700 (PDT)
Received: from localhost.localdomain (84-114-45-16.cable.dynamic.surfer.at. [84.114.45.16])
        by smtp.gmail.com with ESMTPSA id a19sm2231687edv.49.2020.08.05.16.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 16:06:38 -0700 (PDT)
From:   Norbert Lange <nolange79@gmail.com>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Petr Malat <oss@malat.biz>,
        Kees Cook <keescook@chromium.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>,
        Norbert Lange <nolange79@gmail.com>
Subject: [PATCH] arm: Add support for ZSTD compressed kernel
Date:   Thu,  6 Aug 2020 01:05:55 +0200
Message-Id: <20200805230555.84214-1-nolange79@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add support for zstd compressed kernel
* Define __DISABLE_EXPORTS in Makefile
* Bump the heap size for zstd.

This replicates the steps taken for x86 support.

Only if ZSTD is selected, heap size for kernel decompression is
increased, this should guarantee no changes in code / sideeffects for
other compressors.

The patch is so far only tested with Qemu, and some 64MB size limit
exists (might be Qemu specific), but this seems not caused by
this patch (upstream 5.8 and GZIP exhibits similar problems).

Signed-off-by: Norbert Lange <nolange79@gmail.com>
---
 arch/arm/Kconfig                      | 1 +
 arch/arm/boot/compressed/Makefile     | 2 ++
 arch/arm/boot/compressed/decompress.c | 4 ++++
 arch/arm/boot/compressed/head.S       | 4 ++++
 4 files changed, 11 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2ac74904a3ce..3e853cdc688d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -93,6 +93,7 @@ config ARM
 	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
+	select HAVE_KERNEL_ZSTD
 	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
 	select HAVE_KRETPROBES if HAVE_KPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 00602a6fba04..61229e93ea4a 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -75,6 +75,7 @@ compress-$(CONFIG_KERNEL_LZO)  = lzo
 compress-$(CONFIG_KERNEL_LZMA) = lzma
 compress-$(CONFIG_KERNEL_XZ)   = xzkern
 compress-$(CONFIG_KERNEL_LZ4)  = lz4
+compress-$(CONFIG_KERNEL_ZSTD) = zstd22
 
 libfdt_objs := fdt_rw.o fdt_ro.o fdt_wip.o fdt.o
 
@@ -102,6 +103,7 @@ targets       := vmlinux vmlinux.lds piggy_data piggy.o \
 clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S hyp-stub.S
 
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index aa075d8372ea..04f77491975a 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -56,6 +56,10 @@ extern char * strchrnul(const char *, int);
 #include "../../../../lib/decompress_unlz4.c"
 #endif
 
+#ifdef CONFIG_KERNEL_ZSTD
+#include "../../../../lib/decompress_unzstd.c"
+#endif
+
 int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
 {
 	return __decompress(input, len, NULL, NULL, output, 0, NULL, error);
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 434a16982e34..1af01bfe6638 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -614,7 +614,11 @@ not_relocated:	mov	r0, #0
  */
 		mov	r0, r4
 		mov	r1, sp			@ malloc space above stack
+#if defined(CONFIG_KERNEL_ZSTD)
+		add	r2, sp, #0x30000	@ Context needs ~160K
+#else
 		add	r2, sp, #0x10000	@ 64k max
+#endif
 		mov	r3, r7
 		bl	decompress_kernel
 
-- 
2.27.0

