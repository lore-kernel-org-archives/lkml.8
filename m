Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B220C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4D62469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SxadLoRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgB1AW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:22:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40050 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbgB1AW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:22:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id t24so539331pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwIdnSLxc1IQxbb7lR9quaS2Zk4ZIexbe3LplVopvDU=;
        b=SxadLoRdLQDFU2sMtSW2VbvnGgGtZ9nCv8JDVG6dgim+vwQxXd5tD6x6EYwmtVgnK9
         g0afBGuHNACAm2YpVUqCMSfGYmfEu6veqLTy8Q0Ov4wLLVzwWKqU96E24PsO03T2q6E/
         qQhzi6HA8L+yEMS6HEOrD8/pM84qK/Fk9wGbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwIdnSLxc1IQxbb7lR9quaS2Zk4ZIexbe3LplVopvDU=;
        b=aHwQbvVx5eEXZMmirsbKy6lC7Kz7r2wPXisEn6yNg1DNWd/nskV41+HN7JQnWHalM9
         0KnVZnL7xGuQjteOB2qVS8L7/HnclZkHMvBQ5jkamknb2AbpvLSVSrpGcKx5NcnjZoPP
         +efX+6laLUSl3HxbpRHwl6GaAiNpPO0ld0k6zxIEQdHgTgD3DP3NKSh6cb3yVNmtXdGJ
         PnRQY+77bKrxcBwtt4guLR2QPxQt01s8J9CFQ2HTkmeC4EBNdBYKQR+1s5sQSJSj8u5j
         1+dV32BU0SIyU1IdRy3XDuq3PQtfpU0+7IOeqMj5/pN9E/rk7TLJZvLy96i+J454dUZD
         Ui3Q==
X-Gm-Message-State: APjAAAUVt/EQIJ6m3VOa+7AJTn3rhg1g3CqLfIesXr1bTAdmKe8vpkod
        9/eOD3VW2mRTbz3bitZiMRmDOg==
X-Google-Smtp-Source: APXvYqyXge8yxc0byOAFcYYogqDHBcP8WReHRi7mz3K+YWkdQcq5DXiV06dtqt1g148mFGy5LeYCug==
X-Received: by 2002:a63:ef03:: with SMTP id u3mr1816813pgh.77.1582849374784;
        Thu, 27 Feb 2020 16:22:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r11sm8163080pgi.9.2020.02.27.16.22.50
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
Subject: [PATCH 8/9] arm/build: Warn on orphan section placement
Date:   Thu, 27 Feb 2020 16:22:43 -0800
Message-Id: <20200228002244.15240-9-keescook@chromium.org>
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

Specifically, this would have made a recently fixed bug very obvious:

ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'

Refactor linker script include file for use in standard and XIP linker
scripts, as well as in the coming boot linker script changes. Add debug
sections explicitly. Create ARM_COMMON_DISCARD macro with unneeded
sections .ARM.attributes, .iplt, .rel.iplt, .igot.plt, and .modinfo.
Create ARM_STUBS_TEXT macro with missed text stub sections .vfp11_veneer,
and .v4_bx. Finally enable orphan section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Makefile                             |  4 ++++
 .../arm/{kernel => include/asm}/vmlinux.lds.h | 22 ++++++++++++++-----
 arch/arm/kernel/vmlinux-xip.lds.S             |  5 ++---
 arch/arm/kernel/vmlinux.lds.S                 |  5 ++---
 4 files changed, 25 insertions(+), 11 deletions(-)
 rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (92%)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index db857d07114f..f1622bea987a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,10 @@ LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
 KBUILD_LDS_MODULE	+= $(srctree)/arch/arm/kernel/module.lds
 endif
diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
similarity index 92%
rename from arch/arm/kernel/vmlinux.lds.h
rename to arch/arm/include/asm/vmlinux.lds.h
index 8247bc15addc..3ae2cf2e351b 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
@@ -46,6 +47,13 @@
 		*(.hyp.idmap.text)					\
 		__hyp_idmap_text_end = .;
 
+#define ARM_COMMON_DISCARD						\
+		*(.ARM.attributes)					\
+		*(.iplt) *(.rel.iplt) *(.igot.plt)			\
+		*(.modinfo)						\
+		*(.discard)						\
+		*(.discard.*)
+
 #define ARM_DISCARD							\
 		*(.ARM.exidx.exit.text)					\
 		*(.ARM.extab.exit.text)					\
@@ -58,8 +66,14 @@
 		EXIT_CALL						\
 		ARM_MMU_DISCARD(*(.text.fixup))				\
 		ARM_MMU_DISCARD(*(__ex_table))				\
-		*(.discard)						\
-		*(.discard.*)
+		ARM_COMMON_DISCARD
+
+#define ARM_STUBS_TEXT							\
+		*(.gnu.warning)						\
+		*(.glue_7t)						\
+		*(.glue_7)						\
+		*(.vfp11_veneer)					\
+		*(.v4_bx)
 
 #define ARM_TEXT							\
 		IDMAP_TEXT						\
@@ -74,9 +88,7 @@
 		LOCK_TEXT						\
 		HYPERVISOR_TEXT						\
 		KPROBES_TEXT						\
-		*(.gnu.warning)						\
-		*(.glue_7)						\
-		*(.glue_7t)						\
+		ARM_STUBS_TEXT						\
 		. = ALIGN(4);						\
 		*(.got)			/* Global offset table */	\
 		ARM_CPU_KEEP(PROC_INFO)
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 21b8b271c80d..8e9ac99a4335 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -9,15 +9,13 @@
 
 #include <linux/sizes.h>
 
-#include <asm-generic/vmlinux.lds.h>
+#include <asm/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/mpu.h>
 #include <asm/page.h>
 
-#include "vmlinux.lds.h"
-
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 
@@ -152,6 +150,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 }
 
 /*
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 319ccb10846a..f1c6f66e8e6c 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -8,7 +8,7 @@
 #include "vmlinux-xip.lds.S"
 #else
 
-#include <asm-generic/vmlinux.lds.h>
+#include <asm/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
@@ -16,8 +16,6 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
-#include "vmlinux.lds.h"
-
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 
@@ -151,6 +149,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-- 
2.20.1

