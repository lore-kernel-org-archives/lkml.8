Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB7DC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F7921D56
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780757;
	bh=ukpScdr/IBgKHT9ol7CmXugjm6McPESPv9J1yjfJ/z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y/8Q+UwUk37GvKdOtfg16eQvMnUkIq01SOj/xb/fE8B/wrHHtN3gn6buE576BDfyf
	 Y5HtCwIDb4zTRgnYid7trXZyJo12108Kyt7OTYl8502IVBY6yInSEPASunfVBmj3Rv
	 NJtSD3S1prpJfZjMWnQz1MUSnZYYszahgqGJHIG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgCITF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbgCITEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 952C524656;
        Mon,  9 Mar 2020 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780664;
        bh=ukpScdr/IBgKHT9ol7CmXugjm6McPESPv9J1yjfJ/z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0g67XEeyc8XUdpfd73I5W25pxNyCcTHvATMXJwveKJV3kAPwNI3nC3tsvNcvTUjz
         AKW8J6ZPH2xVEkBwFyp/RXQTDbrncZsqbwQ2HvsIyTz7SBFxOvP82nT317WyHDPHbI
         iUqvEzW51W1wwYaRnETyIkZXYjC9VBoe/47C6Cuc=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 10/32] copy_to_user, copy_from_user: Use generic instrumented.h
Date:   Mon,  9 Mar 2020 12:03:58 -0700
Message-Id: <20200309190420.6100-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

This replaces the KASAN instrumentation with generic instrumentation,
implicitly adding KCSAN instrumentation support.

For KASAN no functional change is intended.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/uaccess.h | 14 +++++++-------
 lib/usercopy.c          |  7 ++++---
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f01601..8a215c5 100644
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
-- 
2.9.5

