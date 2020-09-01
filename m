Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B646FC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B77220767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E2XsYAc/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BCl3MeSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIALyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:54:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39500 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgIALs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:28 -0400
Date:   Tue, 01 Sep 2020 11:47:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960877;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1W+gzF2dq+sPfQDcm02M/X9bFttVx4TQ8CW7z+ylRc8=;
        b=E2XsYAc/ZK28pJCqZRiwRlbs+GBiIBax8Td6qbRFQ7UUtJHwy4AyPtyYGX6PiqE0H2M69O
        7GURC8XG/oif8c8U6dbo7g/iYwJIfo8LzsDGQ18apOjzl7PlSNStif/DkRPVSp2AdQyJsO
        nlcivXpfmZ8Kg8dYqUqS6KVsekIZBUrAy9l9zjKOZFMDYFZEkHewiNt9+tNGnJIHMOYOX/
        hQDLOb879RJe/8jlB7g2IqJywDL8yl7d+7g/8dKhEbr/fX9ViXGuXLmNhq9kybC0N1KefO
        E1Y9Nm6b0Wa5YAPlz1d0/rd21QSWAAAZ10sSe52PgpiS6CR3/Kvwjiw63Ktnyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960877;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1W+gzF2dq+sPfQDcm02M/X9bFttVx4TQ8CW7z+ylRc8=;
        b=BCl3MeSDOIM8UkujLtMewZdacvmca6NNCfEbiLsv6/FHLpNxof29Di7+uwhYEgMgBgZ9PV
        dmVeQYwL+L/ljxBQ==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] arm/build: Refactor linker script headers
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Russell King <linux@armlinux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-16-keescook@chromium.org>
References: <20200821194310.3089815-16-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087633.20229.2621632057594945460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     d7e3b065dc98e95f2dae6d2da031dd4c243bd7be
Gitweb:        https://git.kernel.org/tip/d7e3b065dc98e95f2dae6d2da031dd4c243bd7be
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:56 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 10:03:17 +02:00

arm/build: Refactor linker script headers

In preparation for adding --orphan-handling=warn, refactor the linker
script header includes, and extract common macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Link: https://lore.kernel.org/r/20200821194310.3089815-16-keescook@chromium.org
---
 arch/arm/include/asm/vmlinux.lds.h | 130 ++++++++++++++++++++++++++++-
 arch/arm/kernel/vmlinux-xip.lds.S  |   4 +-
 arch/arm/kernel/vmlinux.lds.S      |   4 +-
 arch/arm/kernel/vmlinux.lds.h      | 127 +---------------------------
 4 files changed, 132 insertions(+), 133 deletions(-)
 create mode 100644 arch/arm/include/asm/vmlinux.lds.h
 delete mode 100644 arch/arm/kernel/vmlinux.lds.h

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
new file mode 100644
index 0000000..a08f430
--- /dev/null
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/vmlinux.lds.h>
+
+#ifdef CONFIG_HOTPLUG_CPU
+#define ARM_CPU_DISCARD(x)
+#define ARM_CPU_KEEP(x)		x
+#else
+#define ARM_CPU_DISCARD(x)	x
+#define ARM_CPU_KEEP(x)
+#endif
+
+#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
+	defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL)
+#define ARM_EXIT_KEEP(x)	x
+#define ARM_EXIT_DISCARD(x)
+#else
+#define ARM_EXIT_KEEP(x)
+#define ARM_EXIT_DISCARD(x)	x
+#endif
+
+#ifdef CONFIG_MMU
+#define ARM_MMU_KEEP(x)		x
+#define ARM_MMU_DISCARD(x)
+#else
+#define ARM_MMU_KEEP(x)
+#define ARM_MMU_DISCARD(x)	x
+#endif
+
+#define PROC_INFO							\
+		. = ALIGN(4);						\
+		__proc_info_begin = .;					\
+		*(.proc.info.init)					\
+		__proc_info_end = .;
+
+#define IDMAP_TEXT							\
+		ALIGN_FUNCTION();					\
+		__idmap_text_start = .;					\
+		*(.idmap.text)						\
+		__idmap_text_end = .;					\
+
+#define ARM_DISCARD							\
+		*(.ARM.exidx.exit.text)					\
+		*(.ARM.extab.exit.text)					\
+		*(.ARM.exidx.text.exit)					\
+		*(.ARM.extab.text.exit)					\
+		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))		\
+		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))		\
+		ARM_EXIT_DISCARD(EXIT_TEXT)				\
+		ARM_EXIT_DISCARD(EXIT_DATA)				\
+		EXIT_CALL						\
+		ARM_MMU_DISCARD(*(.text.fixup))				\
+		ARM_MMU_DISCARD(*(__ex_table))				\
+		COMMON_DISCARDS
+
+#define ARM_STUBS_TEXT							\
+		*(.gnu.warning)						\
+		*(.glue_7)						\
+		*(.glue_7t)
+
+#define ARM_TEXT							\
+		IDMAP_TEXT						\
+		__entry_text_start = .;					\
+		*(.entry.text)						\
+		__entry_text_end = .;					\
+		IRQENTRY_TEXT						\
+		SOFTIRQENTRY_TEXT					\
+		TEXT_TEXT						\
+		SCHED_TEXT						\
+		CPUIDLE_TEXT						\
+		LOCK_TEXT						\
+		KPROBES_TEXT						\
+		ARM_STUBS_TEXT						\
+		. = ALIGN(4);						\
+		*(.got)			/* Global offset table */	\
+		ARM_CPU_KEEP(PROC_INFO)
+
+/* Stack unwinding tables */
+#define ARM_UNWIND_SECTIONS						\
+	. = ALIGN(8);							\
+	.ARM.unwind_idx : {						\
+		__start_unwind_idx = .;					\
+		*(.ARM.exidx*)						\
+		__stop_unwind_idx = .;					\
+	}								\
+	.ARM.unwind_tab : {						\
+		__start_unwind_tab = .;					\
+		*(.ARM.extab*)						\
+		__stop_unwind_tab = .;					\
+	}
+
+/*
+ * The vectors and stubs are relocatable code, and the
+ * only thing that matters is their relative offsets
+ */
+#define ARM_VECTORS							\
+	__vectors_start = .;						\
+	.vectors 0xffff0000 : AT(__vectors_start) {			\
+		*(.vectors)						\
+	}								\
+	. = __vectors_start + SIZEOF(.vectors);				\
+	__vectors_end = .;						\
+									\
+	__stubs_start = .;						\
+	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {		\
+		*(.stubs)						\
+	}								\
+	. = __stubs_start + SIZEOF(.stubs);				\
+	__stubs_end = .;						\
+									\
+	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
+
+#define ARM_TCM								\
+	__itcm_start = ALIGN(4);					\
+	.text_itcm ITCM_OFFSET : AT(__itcm_start - LOAD_OFFSET) {	\
+		__sitcm_text = .;					\
+		*(.tcm.text)						\
+		*(.tcm.rodata)						\
+		. = ALIGN(4);						\
+		__eitcm_text = .;					\
+	}								\
+	. = __itcm_start + SIZEOF(.text_itcm);				\
+									\
+	__dtcm_start = .;						\
+	.data_dtcm DTCM_OFFSET : AT(__dtcm_start - LOAD_OFFSET) {	\
+		__sdtcm_data = .;					\
+		*(.tcm.data)						\
+		. = ALIGN(4);						\
+		__edtcm_data = .;					\
+	}								\
+	. = __dtcm_start + SIZEOF(.data_dtcm);
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 3d4e88f..904c31f 100644
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
index 5592f14..bb950c8 100644
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
 
diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
deleted file mode 100644
index 381a8e1..0000000
--- a/arch/arm/kernel/vmlinux.lds.h
+++ /dev/null
@@ -1,127 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifdef CONFIG_HOTPLUG_CPU
-#define ARM_CPU_DISCARD(x)
-#define ARM_CPU_KEEP(x)		x
-#else
-#define ARM_CPU_DISCARD(x)	x
-#define ARM_CPU_KEEP(x)
-#endif
-
-#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
-	defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL)
-#define ARM_EXIT_KEEP(x)	x
-#define ARM_EXIT_DISCARD(x)
-#else
-#define ARM_EXIT_KEEP(x)
-#define ARM_EXIT_DISCARD(x)	x
-#endif
-
-#ifdef CONFIG_MMU
-#define ARM_MMU_KEEP(x)		x
-#define ARM_MMU_DISCARD(x)
-#else
-#define ARM_MMU_KEEP(x)
-#define ARM_MMU_DISCARD(x)	x
-#endif
-
-#define PROC_INFO							\
-		. = ALIGN(4);						\
-		__proc_info_begin = .;					\
-		*(.proc.info.init)					\
-		__proc_info_end = .;
-
-#define IDMAP_TEXT							\
-		ALIGN_FUNCTION();					\
-		__idmap_text_start = .;					\
-		*(.idmap.text)						\
-		__idmap_text_end = .;					\
-
-#define ARM_DISCARD							\
-		*(.ARM.exidx.exit.text)					\
-		*(.ARM.extab.exit.text)					\
-		*(.ARM.exidx.text.exit)					\
-		*(.ARM.extab.text.exit)					\
-		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))		\
-		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))		\
-		ARM_EXIT_DISCARD(EXIT_TEXT)				\
-		ARM_EXIT_DISCARD(EXIT_DATA)				\
-		EXIT_CALL						\
-		ARM_MMU_DISCARD(*(.text.fixup))				\
-		ARM_MMU_DISCARD(*(__ex_table))				\
-		*(.discard)						\
-		*(.discard.*)
-
-#define ARM_TEXT							\
-		IDMAP_TEXT						\
-		__entry_text_start = .;					\
-		*(.entry.text)						\
-		__entry_text_end = .;					\
-		IRQENTRY_TEXT						\
-		SOFTIRQENTRY_TEXT					\
-		TEXT_TEXT						\
-		SCHED_TEXT						\
-		CPUIDLE_TEXT						\
-		LOCK_TEXT						\
-		KPROBES_TEXT						\
-		*(.gnu.warning)						\
-		*(.glue_7)						\
-		*(.glue_7t)						\
-		. = ALIGN(4);						\
-		*(.got)			/* Global offset table */	\
-		ARM_CPU_KEEP(PROC_INFO)
-
-/* Stack unwinding tables */
-#define ARM_UNWIND_SECTIONS						\
-	. = ALIGN(8);							\
-	.ARM.unwind_idx : {						\
-		__start_unwind_idx = .;					\
-		*(.ARM.exidx*)						\
-		__stop_unwind_idx = .;					\
-	}								\
-	.ARM.unwind_tab : {						\
-		__start_unwind_tab = .;					\
-		*(.ARM.extab*)						\
-		__stop_unwind_tab = .;					\
-	}
-
-/*
- * The vectors and stubs are relocatable code, and the
- * only thing that matters is their relative offsets
- */
-#define ARM_VECTORS							\
-	__vectors_start = .;						\
-	.vectors 0xffff0000 : AT(__vectors_start) {			\
-		*(.vectors)						\
-	}								\
-	. = __vectors_start + SIZEOF(.vectors);				\
-	__vectors_end = .;						\
-									\
-	__stubs_start = .;						\
-	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {		\
-		*(.stubs)						\
-	}								\
-	. = __stubs_start + SIZEOF(.stubs);				\
-	__stubs_end = .;						\
-									\
-	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
-
-#define ARM_TCM								\
-	__itcm_start = ALIGN(4);					\
-	.text_itcm ITCM_OFFSET : AT(__itcm_start - LOAD_OFFSET) {	\
-		__sitcm_text = .;					\
-		*(.tcm.text)						\
-		*(.tcm.rodata)						\
-		. = ALIGN(4);						\
-		__eitcm_text = .;					\
-	}								\
-	. = __itcm_start + SIZEOF(.text_itcm);				\
-									\
-	__dtcm_start = .;						\
-	.data_dtcm DTCM_OFFSET : AT(__dtcm_start - LOAD_OFFSET) {	\
-		__sdtcm_data = .;					\
-		*(.tcm.data)						\
-		. = ALIGN(4);						\
-		__edtcm_data = .;					\
-	}								\
-	. = __dtcm_start + SIZEOF(.data_dtcm);
