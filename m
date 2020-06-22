Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C12C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A3D20767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DooDqOpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgFVUt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgFVUtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:49:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38D5C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:49:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ne5so411184pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5ovQdOa53Wq08SUrbeqBNAB7olZAVfsR3FjDV/m7eY=;
        b=DooDqOpDKT5GVcqKI+NdzbhpsVG5cTPTjRWDvCnalSZ78TU0BflJKcy0+WjXQdzJUd
         nui1jCUlJ5fbIJxzP0agAYsi+h5M9y+IvvMzBHAjbP668AnpRIx8aWNsQNZgS/aY6d/d
         u8xLfqbEWCv1etHLm0M4ZsogtMdBgDAhDGbc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5ovQdOa53Wq08SUrbeqBNAB7olZAVfsR3FjDV/m7eY=;
        b=OJ5hf0AeRSDWY1zuJM/jVD/oolYvZLJlprKuN99sl8ETgVvmSTwlg1hBED4dMiFDKk
         HaQAZ/AErB+N5Fx7vQxNAPQ/kmlc010aonwdAJxrJbAxQCmF63cCo9tZeUxZthkiG98r
         TT2qvx94aqu7d44JlEP7fRQZRVO6hipFHwY0DqjCBcRltKA0mvg+HRCI7Pe9lOg8FBxB
         nkZ0l2yHgm67CGgFr13E02si2QKoH9W+JCnifE7AYT4zRizN0BLjOkrz69aawh5+JQF5
         uhc8TwT/o2qm8WzgpIgb3dU5dWf/+eE8CRbbgJ01RTYoOFeIkIvZIXMl/Dd/iUeEYG2U
         0ACg==
X-Gm-Message-State: AOAM531uthNGBIJvMI9Xa5tFYfCBBiiWPVfW2QoKzz3rBigloLmFn0dt
        5ltkHBmQ7MKU6PRoULAAuCsgE9ePek8=
X-Google-Smtp-Source: ABdhPJxWLjAN3LTRor3CItyiankVSVFYUWavtWYs3XzWIhWViymp1qIM+aN6nQqNjlDW1cBjx8Fkxg==
X-Received: by 2002:a17:90a:5c82:: with SMTP id r2mr9732950pji.161.1592858959245;
        Mon, 22 Jun 2020 13:49:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u26sm2152216pgo.71.2020.06.22.13.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:49:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm/build: Warn on orphan section placement
Date:   Mon, 22 Jun 2020 13:49:14 -0700
Message-Id: <20200622204915.2987555-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622204915.2987555-1-keescook@chromium.org>
References: <20200622204915.2987555-1-keescook@chromium.org>
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
index 59fde2d598d8..e414e3732b3a 100644
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
index 381a8e105fa5..3d88ea74f4cd 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
@@ -37,6 +38,13 @@
 		*(.idmap.text)						\
 		__idmap_text_end = .;					\
 
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
@@ -49,8 +57,14 @@
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
@@ -64,9 +78,7 @@
 		CPUIDLE_TEXT						\
 		LOCK_TEXT						\
 		KPROBES_TEXT						\
-		*(.gnu.warning)						\
-		*(.glue_7)						\
-		*(.glue_7t)						\
+		ARM_STUBS_TEXT						\
 		. = ALIGN(4);						\
 		*(.got)			/* Global offset table */	\
 		ARM_CPU_KEEP(PROC_INFO)
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 6d2be994ae58..0807f40844a2 100644
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
index 7f24bc08403e..969205f125ca 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -9,15 +9,13 @@
 #else
 
 #include <linux/pgtable.h>
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
 
@@ -151,6 +149,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-- 
2.25.1

