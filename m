Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49623C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EFC22CA1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgHDJgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:36:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10008 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727997AbgHDJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:36:36 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0749L9gL104465;
        Tue, 4 Aug 2020 05:36:32 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32q4yf8brf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 05:36:32 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0749ZpU2016724;
        Tue, 4 Aug 2020 09:36:30 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 32n01835kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 09:36:30 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0749aRSJ26149246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 09:36:27 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CC16A4054;
        Tue,  4 Aug 2020 09:36:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 724DDA4065;
        Tue,  4 Aug 2020 09:36:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  4 Aug 2020 09:36:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 29A69E1347; Tue,  4 Aug 2020 11:36:27 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 2/3] timekeeping/vsyscall: Provide vdso_update_begin/end()
Date:   Tue,  4 Aug 2020 11:36:06 +0200
Message-Id: <20200804093607.69841-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804093607.69841-1-svens@linux.ibm.com>
References: <20200804093607.69841-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_03:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=703 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/vdso/vsyscall.h            |  3 +++
 kernel/time/timekeeping.c          |  2 +-
 kernel/time/timekeeping_internal.h | 11 +++++++---
 kernel/time/vsyscall.c             | 32 ++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/vdso/vsyscall.h b/include/vdso/vsyscall.h
index 2c6134e0c23d..b0fdc9c6bf43 100644
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
index d20d489841c8..8459aa87986f 100644
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
index bcbb52db2256..4ca2787d1642 100644
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
index 54ce6eb2ca36..e8806eda6874 100644
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
@@ -127,3 +129,33 @@ void update_vsyscall_tz(void)
 
 	__arch_sync_vdso_data(vdata);
 }
+
+/**
+ * vdso_update_begin - Start of a VDSO update section
+ *
+ * Allows architecture code to safely update the architecture specific VDSO
+ * data.
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
+ *
+ * Pairs with vdso_update_begin().
+ */
+void vdso_update_end(unsigned long flags)
+{
+	struct vdso_data *vdata = __arch_get_k_vdso_data();
+
+	vdso_write_end(vdata);
+	__arch_sync_vdso_data(vdata);
+	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+}
-- 
2.17.1

