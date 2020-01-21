Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D421C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF15217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEveYDGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgAUQFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:05:41 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:36899 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAUQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:05:40 -0500
Received: by mail-wm1-f73.google.com with SMTP id t4so800924wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 08:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rQnN5kw1tCui7wtVtPb4liBxMrcaouM2L/Dj3ZF7x/U=;
        b=vEveYDGlq4RapLlWOaserIRgSK9CDsyfKU3vmnx8XdRv89p7akoY0T/V3FT18RGMDw
         OnIRpz8GZABv+03aNv6SYWdpma0cOtw9nwvYssWK3KfbfLDiVatxE0ZU6mONsyJ2gVsi
         uUph1vinxudveUkuNN+jZVXoh30xw79QZx/d492IQ/ZJsFu58ixFWPEECOIRa11zW598
         4k41E4HwH4oJuUbSy/y9Vzf1ZfTjNMvyp9/8EXNCZcZ3zUHKkQro+p+EUuLpGaaGn5t3
         bL84bLB/URIi83z+l9RZ5xR4S1qwN1Cfzc9oVp+rnNjvEL2wQ4NlOUKRJ+AqA2/tiu9+
         5rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rQnN5kw1tCui7wtVtPb4liBxMrcaouM2L/Dj3ZF7x/U=;
        b=BCN6u3c8Z/9muwqQho04zkcEOKXJcIbmGHxvRttBOQqcogVYlfDTHzD0CMv0ljZOGx
         4iCBskvtjbpTvQ1yPs4pU5+bp/DIZPNIFqeTRvvRXiDBEXKSZnfRsXXAfIC6aGuEMmQr
         Jmv7wRQIzXKZi0+FEm3eO5/iYcE1S//bULCCZH26DtUYBXoPlzIUARHrombxM1eJMY7o
         v6ljUdjd1Hi1gJG/HklZHHSQuBydnYM+fjsIVgVvq22pCxUDqCc8vuIve1uUAWvwJFLu
         BnLRl/+D7IO4YB3nsZ94qlG+MwZkEgjc+2lw4afTcSTY7nRZwy6+Lc9jA5h7BhVI9gF8
         1t1w==
X-Gm-Message-State: APjAAAUrxHtGWJ8iOYh/AHRk9BbtbiOU4xQQ8aArMvQnhdAVAbgOH36I
        oybP8usVJAQfm6/5gpxqlEVHbAIKsg==
X-Google-Smtp-Source: APXvYqzSYKwCpC+hKJKIhtUj8+J/YqJXlcIiLtIGbS/jcM8OFkz4phDJWMJlx1Zu6jZidhoMoTP5+XYtHA==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr5659732wrx.145.1579622738696;
 Tue, 21 Jan 2020 08:05:38 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:05:12 +0100
In-Reply-To: <20200121160512.70887-1-elver@google.com>
Message-Id: <20200121160512.70887-5-elver@google.com>
Mime-Version: 1.0
References: <20200121160512.70887-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 5/5] copy_to_user, copy_from_user: Use generic instrumented.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        arnd@arndb.de, viro@zeniv.linux.org.uk, dja@axtens.net,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, mhiramat@kernel.org,
        rostedt@goodmis.org, mingo@kernel.org,
        christian.brauner@ubuntu.com, daniel@iogearbox.net,
        keescook@chromium.org, cyphar@cyphar.com,
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
v2:
* Use updated instrumented.h, removing post-hooks for user-copies.
---
 include/linux/uaccess.h | 14 +++++++-------
 lib/usercopy.c          |  7 ++++---
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f016010aad..8a215c5c1aed 100644
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
index cbb4d9ec00f2..4bb1c5e7a3eb 100644
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
2.25.0.341.g760bfbb309-goog

