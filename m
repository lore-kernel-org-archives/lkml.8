Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14484C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BDA24691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eKbq1uyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgB0Tf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:35:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35158 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgB0TfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:35:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so213076plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 11:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouVhJC1LzbMtIjBpkBkXzJDLKbzWPj7ADPmF+3aq9S8=;
        b=eKbq1uyxj9sdlKd8KWlneIzqahwkro68DRX4rRBijPFKNce5ok5QxzJT6Ig9AabiKE
         6wTImMPfJk6hvjOiqFoNJIrRNWOqk/eMQzD3Sn8a3wtYnD8lTY/23SEpWi1CDHEb78B+
         UP8RTZTWnKxekxqZDolSm+CIiKJsffOwIQXck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouVhJC1LzbMtIjBpkBkXzJDLKbzWPj7ADPmF+3aq9S8=;
        b=jffS8rnbkSJT3Nb7pFLZpuxd1899nIrKYrwOfisN4Z0Kkqoc/sWfQAkODXXU4diahf
         g/kgcWLrQWwiN3J9fBclwVTuh85foahh1Fc7T+5UXb4iAs1Ayuh3tzIVWbhQj7SOwtFM
         YMW/SkRM3sKWTU2HXhppAZtztDoY0+Byon9qYmiNhbVUDjJAFROb/O8VgvzPQDxDpjZN
         DqBdQCO4nTvP4CtpJFXYX6+s0MAYgsTVWjJ3Ej9lM2mR7uH5V6ZC860K5uSG4jQkYZf2
         xDElm/2uqJtGp4FsRmYRwrRdk1s/TlWWKfTcqL1TJIpuzQCOre60dIw3hQSK9Jd60hhR
         uEPA==
X-Gm-Message-State: APjAAAVlChVP9mcICpG8k4GeGTmoi1CfT3XXjqbXON/zzNsBKxo4lYW8
        yHrKDuf70eINusDghgQDXCbqQQ==
X-Google-Smtp-Source: APXvYqxTwZu2muMNOSE/MnDg7HrxUrqj2WJlHpWI6A4QY/3Gzc92Hs6WuLhx1gx2liU6bGiSGd3vuA==
X-Received: by 2002:a17:902:ba8a:: with SMTP id k10mr312829pls.333.1582832123523;
        Thu, 27 Feb 2020 11:35:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v22sm4018043pfe.49.2020.02.27.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:35:20 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Petrova <lenaptr@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        syzkaller@googlegroups.com
Subject: [PATCH v5 1/6] ubsan: Add trap instrumentation option
Date:   Thu, 27 Feb 2020 11:35:11 -0800
Message-Id: <20200227193516.32566-2-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227193516.32566-1-keescook@chromium.org>
References: <20200227193516.32566-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Undefined Behavior Sanitizer can operate in two modes: warning
reporting mode via lib/ubsan.c handler calls, or trap mode, which uses
__builtin_trap() as the handler. Using lib/ubsan.c means the kernel
image is about 5% larger (due to all the debugging text and reporting
structures to capture details about the warning conditions). Using the
trap mode, the image size changes are much smaller, though at the loss
of the "warning only" mode.

In order to give greater flexibility to system builders that want
minimal changes to image size and are prepared to deal with kernel code
being aborted and potentially destabilizing the system, this introduces
CONFIG_UBSAN_TRAP. The resulting image sizes comparison:

   text    data     bss       dec       hex     filename
19533663   6183037  18554956  44271656  2a38828 vmlinux.stock
19991849   7618513  18874448  46484810  2c54d4a vmlinux.ubsan
19712181   6284181  18366540  44362902  2a4ec96 vmlinux.ubsan-trap

CONFIG_UBSAN=y:      image +4.8% (text +2.3%, data +18.9%)
CONFIG_UBSAN_TRAP=y: image +0.2% (text +0.9%, data +1.6%)

Additionally adjusts the CONFIG_UBSAN Kconfig help for clarity and
removes the mention of non-existing boot param "ubsan_handle".

Suggested-by: Elena Petrova <lenaptr@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
 lib/Kconfig.ubsan      | 22 ++++++++++++++++++----
 lib/Makefile           |  2 ++
 scripts/Makefile.ubsan |  9 +++++++--
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 0e04fcb3ab3d..9deb655838b0 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -5,11 +5,25 @@ config ARCH_HAS_UBSAN_SANITIZE_ALL
 config UBSAN
 	bool "Undefined behaviour sanity checker"
 	help
-	  This option enables undefined behaviour sanity checker
+	  This option enables the Undefined Behaviour sanity checker.
 	  Compile-time instrumentation is used to detect various undefined
-	  behaviours in runtime. Various types of checks may be enabled
-	  via boot parameter ubsan_handle
-	  (see: Documentation/dev-tools/ubsan.rst).
+	  behaviours at runtime. For more details, see:
+	  Documentation/dev-tools/ubsan.rst
+
+config UBSAN_TRAP
+	bool "On Sanitizer warnings, abort the running kernel code"
+	depends on UBSAN
+	depends on $(cc-option, -fsanitize-undefined-trap-on-error)
+	help
+	  Building kernels with Sanitizer features enabled tends to grow
+	  the kernel size by around 5%, due to adding all the debugging
+	  text on failure paths. To avoid this, Sanitizer instrumentation
+	  can just issue a trap. This reduces the kernel size overhead but
+	  turns all warnings (including potentially harmless conditions)
+	  into full exceptions that abort the running kernel code
+	  (regardless of context, locks held, etc), which may destabilize
+	  the system. For some system builders this is an acceptable
+	  trade-off.
 
 config UBSAN_SANITIZE_ALL
 	bool "Enable instrumentation for the entire kernel"
diff --git a/lib/Makefile b/lib/Makefile
index 611872c06926..55cc8d73cd43 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -279,7 +279,9 @@ quiet_cmd_build_OID_registry = GEN     $@
 clean-files	+= oid_registry_data.c
 
 obj-$(CONFIG_UCS2_STRING) += ucs2_string.o
+ifneq ($(CONFIG_UBSAN_TRAP),y)
 obj-$(CONFIG_UBSAN) += ubsan.o
+endif
 
 UBSAN_SANITIZE_ubsan.o := n
 KASAN_SANITIZE_ubsan.o := n
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 019771b845c5..668a91510bfe 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -1,5 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 ifdef CONFIG_UBSAN
+
+ifdef CONFIG_UBSAN_ALIGNMENT
+      CFLAGS_UBSAN += $(call cc-option, -fsanitize=alignment)
+endif
+
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=shift)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=integer-divide-by-zero)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=unreachable)
@@ -9,8 +14,8 @@ ifdef CONFIG_UBSAN
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=bool)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=enum)
 
-ifdef CONFIG_UBSAN_ALIGNMENT
-      CFLAGS_UBSAN += $(call cc-option, -fsanitize=alignment)
+ifdef CONFIG_UBSAN_TRAP
+      CFLAGS_UBSAN += $(call cc-option, -fsanitize-undefined-trap-on-error)
 endif
 
       # -fsanitize=* options makes GCC less smart than usual and
-- 
2.20.1

