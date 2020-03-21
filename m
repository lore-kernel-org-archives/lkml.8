Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0791C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C289620786
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgCUOd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 10:33:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38684 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCUOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 10:33:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFfBl-000455-Kl; Sat, 21 Mar 2020 15:33:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 479541C22BC;
        Sat, 21 Mar 2020 15:33:25 +0100 (CET)
Date:   Sat, 21 Mar 2020 14:33:24 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] mips: vdso: Enable mips to use common headers
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paulburton@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320145351.32292-23-vincenzo.frascino@arm.com>
References: <20200320145351.32292-23-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <158480120493.28353.16624453777499675820.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c135fc875ce363ff8405a8e64408bca0aa2a865b
Gitweb:        https://git.kernel.org/tip/c135fc875ce363ff8405a8e64408bca0aa2a865b
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 20 Mar 2020 14:53:47 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 15:24:02 +01:00

mips: vdso: Enable mips to use common headers

Enable mips to use only the common headers in the implementation of
the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Burton <paulburton@kernel.org>
Link: https://lkml.kernel.org/r/20200320145351.32292-23-vincenzo.frascino@arm.com

---
 arch/mips/include/asm/processor.h         | 16 +-------------
 arch/mips/include/asm/vdso/gettimeofday.h |  4 +---
 arch/mips/include/asm/vdso/processor.h    | 27 ++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 arch/mips/include/asm/vdso/processor.h

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 7619ad3..4c9cc66 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -22,6 +22,7 @@
 #include <asm/dsemul.h>
 #include <asm/mipsregs.h>
 #include <asm/prefetch.h>
+#include <asm/vdso/processor.h>
 
 /*
  * System setup and hardware flags..
@@ -385,21 +386,6 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
 #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
 
-#ifdef CONFIG_CPU_LOONGSON64
-/*
- * Loongson-3's SFB (Store-Fill-Buffer) may buffer writes indefinitely when a
- * tight read loop is executed, because reads take priority over writes & the
- * hardware (incorrectly) doesn't ensure that writes will eventually occur.
- *
- * Since spin loops of any kind should have a cpu_relax() in them, force an SFB
- * flush from cpu_relax() such that any pending writes will become visible as
- * expected.
- */
-#define cpu_relax()	smp_mb()
-#else
-#define cpu_relax()	barrier()
-#endif
-
 /*
  * Return_address is a replacement for __builtin_return_address(count)
  * which on certain architectures cannot reasonably be implemented in GCC
diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index 88c3de1..c63ddca 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -13,12 +13,8 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/compiler.h>
-#include <linux/time.h>
-
 #include <asm/vdso/vdso.h>
 #include <asm/clocksource.h>
-#include <asm/io.h>
 #include <asm/unistd.h>
 #include <asm/vdso.h>
 
diff --git a/arch/mips/include/asm/vdso/processor.h b/arch/mips/include/asm/vdso/processor.h
new file mode 100644
index 0000000..511c95d
--- /dev/null
+++ b/arch/mips/include/asm/vdso/processor.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_VDSO_PROCESSOR_H
+#define __ASM_VDSO_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_CPU_LOONGSON64
+/*
+ * Loongson-3's SFB (Store-Fill-Buffer) may buffer writes indefinitely when a
+ * tight read loop is executed, because reads take priority over writes & the
+ * hardware (incorrectly) doesn't ensure that writes will eventually occur.
+ *
+ * Since spin loops of any kind should have a cpu_relax() in them, force an SFB
+ * flush from cpu_relax() such that any pending writes will become visible as
+ * expected.
+ */
+#define cpu_relax()	smp_mb()
+#else
+#define cpu_relax()	barrier()
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_PROCESSOR_H */
