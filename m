Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55D5C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8967D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20150623.gappssmtp.com header.i=@malat-biz.20150623.gappssmtp.com header.b="Sg1XXHyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbgCPNvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:51:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39623 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbgCPNvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:51:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id h6so994716wrs.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ge1v5SoZ4c0uyH9O7PvXoiep6L9R1FBx/GzKX9NhShA=;
        b=Sg1XXHytvqAgJE7n1w5KVE7apK8UFRVdipU/0l9Itxod9Q1p8/JhOc8uHuWWBk3h/r
         4RkIlm18t6g8VVqDj7MQf517lvpldYqBwpv4VXH+0dJd9DSgy6FAEA8Yu+v/X4p5eMfS
         e1pqRGmcJQooibQ8CjPCx/EuDHDrFT/6ZufyJTkSwVcD2VosAduQCQAmzy5TckHE1m4Y
         6dQDBewt/llSWiaDkxvRaLtL5xxwWYlN66HKXE+Ln57XDyNzCBBQdku7eKlDSJjnP/Lk
         n86ED75k5ZDkCYqr0k3DPXUy0GJit3TTJEKbGmmBeBI6seTgvgCl8MUkdwJubEeJMuG+
         xoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ge1v5SoZ4c0uyH9O7PvXoiep6L9R1FBx/GzKX9NhShA=;
        b=QZbHsF4XvSQXs2IaqE2PjH4aWeBVkua5Rf8hk+hhnmgex4LYu8iWAeGJUAafdczPOY
         3Itf2JKr4PpAfNG+4RipXB8Sc/ooQilpdBSJ9DG09CoPWYkDWmQpCg/V3dTCNU+TSjqW
         D9rySnny4vvptCqQ6+ej4d2O9iDTFRfJVFzw9XmrH4TgGKQH5SB/5mySB0LjGgb/uchY
         gSYmb4Lwg4iVV6UzMuVup0+XkaCvFRmN8H+5KRFHNHQdOGufVqGXsX02wvGH1O0MCJjN
         41eRu5sHYDX4+rwf60d+65LoiqNr7Rr4Y+/aUH3Owjw9iqwBFLspOZlx508LgJl+PaNa
         7YVg==
X-Gm-Message-State: ANhLgQ2dzD6U7FAW/R4Oa4Vt3e5jFCEiQAjhbObKsRZhodUbL4DhG5qr
        boYWbvA2TnOl4dlqiSOFms7+QDxRGnoS3XGW
X-Google-Smtp-Source: ADFU+vs1Hupx5GIjQTLmMRbeS/3fOQ1JyamtNRuwcnDPbk/DCpcAouTiU5pPAuVWgMPEE2sXpMIHGw==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr5252516wrl.38.1584366671735;
        Mon, 16 Mar 2020 06:51:11 -0700 (PDT)
Received: from ntb.Speedport_W_921V_1_46_000 (p57AF9474.dip0.t-ipconnect.de. [87.175.148.116])
        by smtp.googlemail.com with ESMTPSA id p10sm93818060wrx.81.2020.03.16.06.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 06:51:09 -0700 (PDT)
From:   Petr Malat <oss@malat.biz>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        x86@kernel.org
Cc:     terrelln@fb.com, clm@fb.com, gregkh@linuxfoundation.org,
        keescook@chromium.org, Petr Malat <oss@malat.biz>
Subject: [PATCH 2/2] x86: Enable support for ZSTD-compressed kernel
Date:   Mon, 16 Mar 2020 14:50:25 +0100
Message-Id: <20200316135025.7579-2-oss@malat.biz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316135025.7579-1-oss@malat.biz>
References: <20200316135025.7579-1-oss@malat.biz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Petr Malat <oss@malat.biz>
---
 arch/x86/Kconfig                  | 1 +
 arch/x86/boot/compressed/Makefile | 5 ++++-
 arch/x86/boot/compressed/misc.c   | 4 ++++
 arch/x86/include/asm/boot.h       | 4 ++--
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e8949953660..b22312aae674 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -180,6 +180,7 @@ config X86
 	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
+	select HAVE_KERNEL_ZSTD
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 1dac210f7d44..a87dc1e41772 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -24,7 +24,7 @@ OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT		:= n
 
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
-	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
+	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst
 
 KBUILD_CFLAGS := -m$(BITS) -O2
 KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
@@ -145,6 +145,8 @@ $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lzo)
 $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lz4)
+$(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
+	$(call if_changed,zstd)
 
 suffix-$(CONFIG_KERNEL_GZIP)	:= gz
 suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
@@ -152,6 +154,7 @@ suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
 suffix-$(CONFIG_KERNEL_XZ)	:= xz
 suffix-$(CONFIG_KERNEL_LZO) 	:= lzo
 suffix-$(CONFIG_KERNEL_LZ4) 	:= lz4
+suffix-$(CONFIG_KERNEL_ZSTD) 	:= zst
 
 quiet_cmd_mkpiggy = MKPIGGY $@
       cmd_mkpiggy = $(obj)/mkpiggy $< > $@
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 9652d5c2afda..39e592d0e0b4 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -77,6 +77,10 @@ static int lines, cols;
 #ifdef CONFIG_KERNEL_LZ4
 #include "../../../../lib/decompress_unlz4.c"
 #endif
+
+#ifdef CONFIG_KERNEL_ZSTD
+#include "../../../../lib/decompress_unzstd.c"
+#endif
 /*
  * NOTE: When adding a new decompressor, please update the analysis in
  * ../header.S.
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 680c320363db..9838c183e9a8 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -24,9 +24,9 @@
 # error "Invalid value for CONFIG_PHYSICAL_ALIGN"
 #endif
 
-#ifdef CONFIG_KERNEL_BZIP2
+#if CONFIG_KERNEL_BZIP2 || CONFIG_KERNEL_ZSTD
 # define BOOT_HEAP_SIZE		0x400000
-#else /* !CONFIG_KERNEL_BZIP2 */
+#else /* !(CONFIG_KERNEL_BZIP2 || CONFIG_KERNEL_ZSTD)  */
 # define BOOT_HEAP_SIZE		 0x10000
 #endif
 
-- 
2.20.1

