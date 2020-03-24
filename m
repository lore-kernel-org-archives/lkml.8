Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068B9C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E612070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgCXJL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:11:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43783 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgCXJLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaS-0007Xx-QA; Tue, 24 Mar 2020 10:11:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D9CA11C0481;
        Tue, 24 Mar 2020 10:10:59 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:10:59 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] copy_to_user, copy_from_user: Use generic instrumented.h
Cc:     Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504105957.28353.10836597651287975970.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     76d6f06c36a3b5cc402eeeb709613cb211fdaa8f
Gitweb:        https://git.kernel.org/tip/76d6f06c36a3b5cc402eeeb709613cb211fdaa8f
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 21 Jan 2020 17:05:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:41:59 +01:00

copy_to_user, copy_from_user: Use generic instrumented.h

This replaces the KASAN instrumentation with generic instrumentation,
implicitly adding KCSAN instrumentation support.

For KASAN no functional change is intended.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/uaccess.h | 14 +++++++-------
 lib/usercopy.c          |  7 ++++---
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f0160..8a215c5 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,9 +2,9 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
+#include <linux/instrumented.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
-#include <linux/kasan-checks.h>
 
 #define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
 
@@ -58,7 +58,7 @@
 static __always_inline __must_check unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
-	kasan_check_write(to, n);
+	instrument_copy_from_user(to, from, n);
 	check_object_size(to, n, false);
 	return raw_copy_from_user(to, from, n);
 }
@@ -67,7 +67,7 @@ static __always_inline __must_check unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	might_fault();
-	kasan_check_write(to, n);
+	instrument_copy_from_user(to, from, n);
 	check_object_size(to, n, false);
 	return raw_copy_from_user(to, from, n);
 }
@@ -88,7 +88,7 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 static __always_inline __must_check unsigned long
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
-	kasan_check_read(from, n);
+	instrument_copy_to_user(to, from, n);
 	check_object_size(from, n, true);
 	return raw_copy_to_user(to, from, n);
 }
@@ -97,7 +97,7 @@ static __always_inline __must_check unsigned long
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
-	kasan_check_read(from, n);
+	instrument_copy_to_user(to, from, n);
 	check_object_size(from, n, true);
 	return raw_copy_to_user(to, from, n);
 }
@@ -109,7 +109,7 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 	}
 	if (unlikely(res))
@@ -127,7 +127,7 @@ _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = raw_copy_to_user(to, from, n);
 	}
 	return n;
diff --git a/lib/usercopy.c b/lib/usercopy.c
index cbb4d9e..4bb1c5e 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/uaccess.h>
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
+#include <linux/uaccess.h>
 
 /* out-of-line parts */
 
@@ -10,7 +11,7 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
 	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 	}
 	if (unlikely(res))
@@ -25,7 +26,7 @@ unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
 	if (likely(access_ok(to, n))) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = raw_copy_to_user(to, from, n);
 	}
 	return n;
