Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5028C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B336320776
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 14:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgCUOdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 10:33:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38754 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgCUOdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 10:33:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFfBt-000481-Ql; Sat, 21 Mar 2020 15:33:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6B8881C22DE;
        Sat, 21 Mar 2020 15:33:28 +0100 (CET)
Date:   Sat, 21 Mar 2020 14:33:28 -0000
From:   "tip-bot2 for Vincenzo Frascino" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] linux/ktime.h: Extract common header for vDSO
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320145351.32292-15-vincenzo.frascino@arm.com>
References: <20200320145351.32292-15-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Message-ID: <158480120810.28353.7915928459752085791.tip-bot2@tip-bot2>
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

Commit-ID:     cc56f32f00154ff3586e8346c91f5253882cd8a5
Gitweb:        https://git.kernel.org/tip/cc56f32f00154ff3586e8346c91f5253882cd8a5
Author:        Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate:    Fri, 20 Mar 2020 14:53:39 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 15:23:59 +01:00

linux/ktime.h: Extract common header for vDSO

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Split ktime.h into linux and common headers to make the latter suitable
for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200320145351.32292-15-vincenzo.frascino@arm.com

---
 include/linux/ktime.h |  9 +--------
 include/vdso/ktime.h  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)
 create mode 100644 include/vdso/ktime.h

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index b2bb44f..1fcfce9 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -253,14 +253,7 @@ static inline __must_check bool ktime_to_timespec64_cond(const ktime_t kt,
 	}
 }
 
-/*
- * The resolution of the clocks. The resolution value is returned in
- * the clock_getres() system call to give application programmers an
- * idea of the (in)accuracy of timers. Timer values are rounded up to
- * this resolution values.
- */
-#define LOW_RES_NSEC		TICK_NSEC
-#define KTIME_LOW_RES		(LOW_RES_NSEC)
+#include <vdso/ktime.h>
 
 static inline ktime_t ns_to_ktime(u64 ns)
 {
diff --git a/include/vdso/ktime.h b/include/vdso/ktime.h
new file mode 100644
index 0000000..a0fd072
--- /dev/null
+++ b/include/vdso/ktime.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_KTIME_H
+#define __VDSO_KTIME_H
+
+#include <vdso/jiffies.h>
+
+/*
+ * The resolution of the clocks. The resolution value is returned in
+ * the clock_getres() system call to give application programmers an
+ * idea of the (in)accuracy of timers. Timer values are rounded up to
+ * this resolution values.
+ */
+#define LOW_RES_NSEC		TICK_NSEC
+#define KTIME_LOW_RES		(LOW_RES_NSEC)
+
+#endif /* __VDSO_KTIME_H */
