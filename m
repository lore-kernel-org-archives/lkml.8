Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3253C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE9E206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V7pRW5Z7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgGaXSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgGaXSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:18:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7DEC061757
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t6so16807233pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNMQ3F5q4g/Uk/+s5Q6WGurCwVwunmhXKYzGhkTYsIo=;
        b=V7pRW5Z7AEZ48SyrjJClnXGtKhu5EXaa5sPdFxXji+oSze06iySj2l5uugTpF2w+s6
         /0KYMS5jXvAmb+nfHzJpH6+Sv4YKDO9YCEORcsU3J8MUXjDft+0+ROx3pCqSgYEc/2eY
         VTjWB8RxvO2SCARRO2VidQkHRol/MW6eL3Ot8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNMQ3F5q4g/Uk/+s5Q6WGurCwVwunmhXKYzGhkTYsIo=;
        b=eMkr5d2ysZ5m+GdRxo5+XjQkw418j7e647QXdWOqdgKc/t+FbSXz9lpN+6Gg2fbL/E
         BAo8ZOQpcaWcnOGSSs8MvkQ5O167pwmmLXSMGdFv4qS4ft/1VoUvNrl4uVS0ps4XGHT4
         b5pZOSiOnCt1E2qAv0nKWmKy6DOL9t7gAsksStjuU53FiUDh5Ovj2jjPEf9ETYI2NUPJ
         CbNcCjlS6j2yDrc9nnuypM2Jw+XO8ch1wZYrTGc6g3WjM6Aof3rLzMa6KEgxU4W/LLbY
         yOoXG0QRqH6WtigeNaw7uRqyZuzuy2Oka7Ongxj3EkGDgfaXvFPPFXq8e8T6mrarGZF8
         AA/Q==
X-Gm-Message-State: AOAM533d+yf7S/CksasLqiMNexO13XjKWyYzQlHOw1iugPOjkxiRn+k7
        Ox5JwRAVCeJRhJrVp/16wXlxjA==
X-Google-Smtp-Source: ABdhPJwpWbjUhT+v4CQ5bd/TwU+co0ff+/inssnW2ZyhULRWFzBupBOYdq2zOKBoVuGo6SeuhSgvkA==
X-Received: by 2002:a63:3c55:: with SMTP id i21mr5799731pgn.93.1596237500020;
        Fri, 31 Jul 2020 16:18:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c134sm11221511pfc.115.2020.07.31.16.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 22/36] arm/build: Refactor linker script headers
Date:   Fri, 31 Jul 2020 16:08:06 -0700
Message-Id: <20200731230820.1742553-23-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding --orphan-handling=warn, refactor the linker
script header includes, and extract common macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/{kernel => include/asm}/vmlinux.lds.h | 13 ++++++++-----
 arch/arm/kernel/vmlinux-xip.lds.S              |  4 +---
 arch/arm/kernel/vmlinux.lds.S                  |  4 +---
 3 files changed, 10 insertions(+), 11 deletions(-)
 rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (96%)

diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
similarity index 96%
rename from arch/arm/kernel/vmlinux.lds.h
rename to arch/arm/include/asm/vmlinux.lds.h
index 381a8e105fa5..a08f4301b718 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
@@ -49,8 +50,12 @@
 		EXIT_CALL						\
 		ARM_MMU_DISCARD(*(.text.fixup))				\
 		ARM_MMU_DISCARD(*(__ex_table))				\
-		*(.discard)						\
-		*(.discard.*)
+		COMMON_DISCARDS
+
+#define ARM_STUBS_TEXT							\
+		*(.gnu.warning)						\
+		*(.glue_7)						\
+		*(.glue_7t)
 
 #define ARM_TEXT							\
 		IDMAP_TEXT						\
@@ -64,9 +69,7 @@
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
index 3d4e88f08196..904c31fa20ed 100644
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
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 5592f14b7e35..bb950c896a67 100644
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
 
-- 
2.25.1

