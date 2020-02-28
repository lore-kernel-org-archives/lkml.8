Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763B3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA112469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NdpfQ9E7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgB1AXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:23:07 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40173 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbgB1AW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:22:56 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so498534pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pMXhDd5WkHmc2Nd9+Jjb38fhh7Zetn6tk9gX3pPvjM=;
        b=NdpfQ9E77BQQDeLbRe4C0kneiRaa4BRWlG/661nY6+36gEg6ulvyK6zJdrM6FlpkLx
         rZnuOrOoXJH6eCy0PMi8rot0VETFWym5wj0fDsIe9QVrzJg7KEO+1C0QPBYDgIEB4mcg
         xFYZAsgdnMK5ZAzxXgLUxelkrt9eHsy30qa9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pMXhDd5WkHmc2Nd9+Jjb38fhh7Zetn6tk9gX3pPvjM=;
        b=fQCBhqpa3zeOHDdviRnim5ukNMGbJCHiKZ4lZ6AHNsKr9GnrJXwmR+d8zSR65SFzf2
         68TUlAosANUWFrgsIKkrbi7I+h+TZeZyFPPDHr3IZhvZJZutRBeTAwYLN1ukVjw760QQ
         uSM5TWZD3ArYJPiYPyWZPNANKwohZgiaBP2lZIAD92XPR1xqE6Kx4sxaG9+BLfLHz2q7
         kEMsfH4GwFMT4GYYBrJ0AVYGbEqTispDMPne/pH2VaWryp/s+j+IxrBFsafrXuEG7w9o
         viUS57NAgQz8z6uQBy+fhKD6HLQFy8IRZax6cgtcmrz7P1Qbk6WTpa+PRwSkpq/yuGNt
         AArQ==
X-Gm-Message-State: APjAAAWCgH3WRcFrIRa1zP5MpJIThWhYifUE1FX0r4ozGEt1KCMx371R
        51fZW/1MVsmf3ymTUTwn8YF5LQ==
X-Google-Smtp-Source: APXvYqzuOX0XiyVaOeVuugXOJBvn7E6Nhu05xm90KTUN/qkQ34/SDiQ4lE0A5jOUkXzf88ArP2HuXA==
X-Received: by 2002:a17:902:694b:: with SMTP id k11mr1375405plt.334.1582849375873;
        Thu, 27 Feb 2020 16:22:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 3sm8455845pfi.13.2020.02.27.16.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:22:52 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] arm/boot: Warn on orphan section placement
Date:   Thu, 27 Feb 2020 16:22:44 -0800
Message-Id: <20200228002244.15240-10-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly named in the linker
script.

Use common macros for debug sections, discards, and text stubs. Add
discards for unwanted .note, and .rel sections. Finally, enable orphan
section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/Makefile      |  2 ++
 arch/arm/boot/compressed/vmlinux.lds.S | 17 +++++++----------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index da599c3a1193..7faa2b5e7e16 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -136,6 +136,8 @@ endif
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
 LDFLAGS_vmlinux += -X
+# Report orphan sections
+LDFLAGS_vmlinux += --orphan-handling=warn
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index fc7ed03d8b93..a6a51b5d2328 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -2,6 +2,7 @@
 /*
  *  Copyright (C) 2000 Russell King
  */
+#include <asm/vmlinux.lds.h>
 
 #ifdef CONFIG_CPU_ENDIAN_BE8
 #define ZIMAGE_MAGIC(x) ( (((x) >> 24) & 0x000000ff) | \
@@ -17,8 +18,11 @@ ENTRY(_start)
 SECTIONS
 {
   /DISCARD/ : {
+    ARM_COMMON_DISCARD
     *(.ARM.exidx*)
     *(.ARM.extab*)
+    *(.note.*)
+    *(.rel.*)
     /*
      * Discard any r/w data - this produces a link error if we have any,
      * which is required for PIC decompression.  Local data generates
@@ -37,9 +41,7 @@ SECTIONS
     *(.text)
     *(.text.*)
     *(.fixup)
-    *(.gnu.warning)
-    *(.glue_7t)
-    *(.glue_7)
+    ARM_STUBS_TEXT
   }
   .table : ALIGN(4) {
     _table_start = .;
@@ -124,12 +126,7 @@ SECTIONS
   PROVIDE(__pecoff_data_size = ALIGN(512) - ADDR(.data));
   PROVIDE(__pecoff_end = ALIGN(512));
 
-  .stab 0		: { *(.stab) }
-  .stabstr 0		: { *(.stabstr) }
-  .stab.excl 0		: { *(.stab.excl) }
-  .stab.exclstr 0	: { *(.stab.exclstr) }
-  .stab.index 0		: { *(.stab.index) }
-  .stab.indexstr 0	: { *(.stab.indexstr) }
-  .comment 0		: { *(.comment) }
+  STABS_DEBUG
+  DWARF_DEBUG
 }
 ASSERT(_edata_real == _edata, "error: zImage file size is incorrect");
-- 
2.20.1

