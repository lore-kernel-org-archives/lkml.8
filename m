Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423C5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1031B20678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LSSEn3c2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgATOT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:19:58 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:35284 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgATOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:19:56 -0500
Received: by mail-wr1-f73.google.com with SMTP id f15so14303292wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 06:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sfeBMXRfbNdJgAnQzXh8K2r3zlp1l0BIMpCBNTG8NB8=;
        b=LSSEn3c2vjZu0hxjSiwTarnKg/7zNzHUTp6W7Ip9UWrzRVuZnDkSlhhXZowqJXjtzg
         urMYjrs99RlbOKWjpR219PjE4j0BGuSZn8EVeIa93/+grY7qQJq/0WiwXbIrjVxgOm1U
         RpYw3P/PfAAqTwkQUIp50nOZEQAL84wLy3/uQ6bLtMNh7/DiAIbBrfKA30BsVdqZW4q7
         skKvreC085/NbB3Gk4pzNbXRzJTqQB6ZcMvJJVks+ihIp7O9W+jjY/yGnEzov7U2GzL2
         ox30Q3SZ6FxqWLqaQMtCN34JN1gnd1e0rOsBy+wlefIlQxRUnasgGBOaecV6fIfXPuda
         z1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sfeBMXRfbNdJgAnQzXh8K2r3zlp1l0BIMpCBNTG8NB8=;
        b=tLtGABx/mhpJUfAWHrbjhUMa2YjM4/R4cVW1xR2Qab58rVwblCsO5JV6N18GioHha8
         aRrB8tadK0Yd8AW4dxsBZyKCbhyZZIF5lPNKgektVVG/K9NmRPhDUv746k/F+vllyA65
         x2U00nA93n70dP3Cd9KkxYLoKfo2SJmZHQ0rlc0VcJZh/NOUJKw+8t4GcdGShoCOQTHB
         dcpy5iXMgBNVK7+Vf7uAn7At0sczYEeAgC1gtTzTpRoJ2XtZiDIphJYl57yqk3mIhWUG
         bafXlg3syHbOL3zSdM4SjwumTsOi2vkZPgoz/bzcPfvyiHpRu2V3q7nwsy102WxCzFIl
         LJ2Q==
X-Gm-Message-State: APjAAAXlksBvXbVULQ4huX9jF3MHf1tx7qM6FF2f1cmz04NqnBqtag9s
        cBSVleXFoYkZvDBmmuZKOTpq+7vO5A==
X-Google-Smtp-Source: APXvYqzovcsGc038QWfGiGHCHo+z/bqiMy5fCLYOpIhcGqbJvd6Ceb9haRPFXz9ZOWkOe+tnEfMRkeuGbQ==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr18199365wrv.259.1579529993355;
 Mon, 20 Jan 2020 06:19:53 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:19:27 +0100
In-Reply-To: <20200120141927.114373-1-elver@google.com>
Message-Id: <20200120141927.114373-5-elver@google.com>
Mime-Version: 1.0
References: <20200120141927.114373-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 5/5] copy_to_user, copy_from_user: Use generic instrumented.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        arnd@arndb.de, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr,
        dja@axtens.net, mpe@ellerman.id.au, rostedt@goodmis.org,
        mhiramat@kernel.org, mingo@kernel.org,
        christian.brauner@ubuntu.com, daniel@iogearbox.net,
        cyphar@cyphar.com, keescook@chromium.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces the KASAN instrumentation with generic instrumentation,
implicitly adding KCSAN instrumentation support.

For KASAN no functional change is intended.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/uaccess.h | 46 +++++++++++++++++++++++++++++------------
 lib/usercopy.c          | 14 ++++++++-----
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f016010aad..d3f2d9a8cae3 100644
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
 
@@ -58,18 +58,26 @@
 static __always_inline __must_check unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
-	kasan_check_write(to, n);
+	unsigned long res;
+
 	check_object_size(to, n, false);
-	return raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_pre(to, n);
+	res = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_post(to, n, res);
+	return res;
 }
 
 static __always_inline __must_check unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	unsigned long res;
+
 	might_fault();
-	kasan_check_write(to, n);
 	check_object_size(to, n, false);
-	return raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_pre(to, n);
+	res = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_post(to, n, res);
+	return res;
 }
 
 /**
@@ -88,18 +96,26 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 static __always_inline __must_check unsigned long
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
-	kasan_check_read(from, n);
+	unsigned long res;
+
 	check_object_size(from, n, true);
-	return raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_pre(from, n);
+	res = raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_post(from, n, res);
+	return res;
 }
 
 static __always_inline __must_check unsigned long
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long res;
+
 	might_fault();
-	kasan_check_read(from, n);
 	check_object_size(from, n, true);
-	return raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_pre(from, n);
+	res = raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_post(from, n, res);
+	return res;
 }
 
 #ifdef INLINE_COPY_FROM_USER
@@ -109,8 +125,9 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user_pre(to, n);
 		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_post(to, n, res);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
@@ -125,12 +142,15 @@ _copy_from_user(void *, const void __user *, unsigned long);
 static inline __must_check unsigned long
 _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long res = n;
+
 	might_fault();
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
-		n = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_pre(from, n);
+		res = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_post(from, n, res);
 	}
-	return n;
+	return res;
 }
 #else
 extern __must_check unsigned long
diff --git a/lib/usercopy.c b/lib/usercopy.c
index cbb4d9ec00f2..1c20d4423b86 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/uaccess.h>
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
+#include <linux/uaccess.h>
 
 /* out-of-line parts */
 
@@ -10,8 +11,9 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
 	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user_pre(to, n);
 		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_post(to, n, res);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
@@ -23,12 +25,14 @@ EXPORT_SYMBOL(_copy_from_user);
 #ifndef INLINE_COPY_TO_USER
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(to, n))) {
-		kasan_check_read(from, n);
-		n = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_pre(from, n);
+		res = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_post(from, n, res);
 	}
-	return n;
+	return res;
 }
 EXPORT_SYMBOL(_copy_to_user);
 #endif
-- 
2.25.0.341.g760bfbb309-goog

