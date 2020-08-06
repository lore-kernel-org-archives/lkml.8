Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD80C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F23E2311B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ye1VrZbm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WOxDiAq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgHFRM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:12:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58916 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbgHFRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:06 -0400
Date:   Thu, 06 Aug 2020 17:10:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqGPH07pzHO47/xm9n06evZRKuSJhzUmUKmbO1v96+E=;
        b=Ye1VrZbm2fG74IfDotWAi5nfNJSP1bi31yteIDYG9HWKtdvY2JxF8ZliICEcb1P8cnBokq
        C/aJkO9shrF1RFok2C8Nd7RRiN9pWHsfchHnbJ47JByoKo4yLVNvQL5xph1KNOimvUSAgv
        /XPSJzk0zC0rXM8ImENqSSwgB+Y2QApjMM46y5VwsUFdsl2dt2I0SIfaP718NgPh/5Bxw8
        lkNJPPTmAWdV3zfa3oVG6lJK1ufJUj6D9Ife104+d9g18OB3GwKQumKKEih9Zfo6JDp0T/
        Ygjx2HEMX+r8Qmjih19PQ4wMx2XMHKxAvZ9WAhT5/GdmvM2o1iTmGFNbBNguUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqGPH07pzHO47/xm9n06evZRKuSJhzUmUKmbO1v96+E=;
        b=WOxDiAq+txKabkOs0K+aE484kQD5IEVOtUIk3SESpDUr0NfwNtjagRkbUsf7dageqCPL+Z
        VnFdsSKB1CzKU1Aw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping/vsyscall: Provide vdso_update_begin/end()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sven Schnelle <svens@linux.ibm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200804150124.41692-3-svens@linux.ibm.com>
References: <20200804150124.41692-3-svens@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <159673380118.3192.11120762582178305899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     19d0070a2792181f79df01277fe00b83b9f7eda7
Gitweb:        https://git.kernel.org/tip/19d0070a2792181f79df01277fe00b83b9f7eda7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 04 Aug 2020 17:01:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 06 Aug 2020 10:57:30 +02:00

timekeeping/vsyscall: Provide vdso_update_begin/end()

Architectures can have the requirement to add additional architecture
specific data to the VDSO data page which needs to be updated independent
of the timekeeper updates.

To protect these updates vs. concurrent readers and a conflicting update
through timekeeping, provide helper functions to make such updates safe.

vdso_update_begin() takes the timekeeper_lock to protect against a
potential update from timekeeper code and increments the VDSO sequence
count to signal data inconsistency to concurrent readers. vdso_update_end()
makes the sequence count even again to signal data consistency and drops
the timekeeper lock.

[ Sven: Add interrupt disable handling to the functions ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200804150124.41692-3-svens@linux.ibm.com

---
 include/vdso/vsyscall.h            |  3 ++-
 kernel/time/timekeeping.c          |  2 +-
 kernel/time/timekeeping_internal.h | 11 +++++---
 kernel/time/vsyscall.c             | 41 +++++++++++++++++++++++++++++-
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/vdso/vsyscall.h b/include/vdso/vsyscall.h
index 2c6134e..b0fdc9c 100644
--- a/include/vdso/vsyscall.h
+++ b/include/vdso/vsyscall.h
@@ -6,6 +6,9 @@
 
 #include <asm/vdso/vsyscall.h>
 
+unsigned long vdso_update_begin(void);
+void vdso_update_end(unsigned long flags);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __VDSO_VSYSCALL_H */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 63a632f..4c7212f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -50,7 +50,7 @@ static struct {
 	.seq = SEQCNT_ZERO(tk_core.seq),
 };
 
-static DEFINE_RAW_SPINLOCK(timekeeper_lock);
+DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
 
 /**
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index bcbb52d..4ca2787 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -1,12 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _TIMEKEEPING_INTERNAL_H
 #define _TIMEKEEPING_INTERNAL_H
-/*
- * timekeeping debug functions
- */
+
 #include <linux/clocksource.h>
+#include <linux/spinlock.h>
 #include <linux/time.h>
 
+/*
+ * timekeeping debug functions
+ */
 #ifdef CONFIG_DEBUG_FS
 extern void tk_debug_account_sleep_time(const struct timespec64 *t);
 #else
@@ -31,4 +33,7 @@ static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 }
 #endif
 
+/* Semi public for serialization of non timekeeper VDSO updates. */
+extern raw_spinlock_t timekeeper_lock;
+
 #endif /* _TIMEKEEPING_INTERNAL_H */
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 54ce6eb..88e6b8e 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -13,6 +13,8 @@
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
 
+#include "timekeeping_internal.h"
+
 static inline void update_vdso_data(struct vdso_data *vdata,
 				    struct timekeeper *tk)
 {
@@ -127,3 +129,42 @@ void update_vsyscall_tz(void)
 
 	__arch_sync_vdso_data(vdata);
 }
+
+/**
+ * vdso_update_begin - Start of a VDSO update section
+ *
+ * Allows architecture code to safely update the architecture specific VDSO
+ * data. Disables interrupts, acquires timekeeper lock to serialize against
+ * concurrent updates from timekeeping and invalidates the VDSO data
+ * sequence counter to prevent concurrent readers from accessing
+ * inconsistent data.
+ *
+ * Returns: Saved interrupt flags which need to be handed in to
+ * vdso_update_end().
+ */
+unsigned long vdso_update_begin(void)
+{
+	struct vdso_data *vdata = __arch_get_k_vdso_data();
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	vdso_write_begin(vdata);
+	return flags;
+}
+
+/**
+ * vdso_update_end - End of a VDSO update section
+ * @flags:	Interrupt flags as returned from vdso_update_begin()
+ *
+ * Pairs with vdso_update_begin(). Marks vdso data consistent, invokes data
+ * synchronization if the architecture requires it, drops timekeeper lock
+ * and restores interrupt flags.
+ */
+void vdso_update_end(unsigned long flags)
+{
+	struct vdso_data *vdata = __arch_get_k_vdso_data();
+
+	vdso_write_end(vdata);
+	__arch_sync_vdso_data(vdata);
+	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+}
