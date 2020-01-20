Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85325C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440ED24125
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2jwDAsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgATOTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:19:51 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:45200 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgATOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:19:49 -0500
Received: by mail-vk1-f202.google.com with SMTP id 128so12873441vka.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 06:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1yb9KPpW163F2PxwvPiqbffL92UYcGBzOHlCQNKTfHs=;
        b=b2jwDAsCeJU5iIMo0rSbO37AtBS9q9Z0S0plF8VO2b9yFaTJ5LMqhzL7abs5SULGQg
         l5Tu39+teSTaja/o4VOeUTBedcjdeZjKSFBsqdugW/CtMfgK+wPS+wJOKbSmbw3dHp8r
         Xbkera6hkQnkUSic82XGb2Dfu11MwunxaoPhHdCIIqRtG4NOoRAKnWMxY3y/mNaUmFmQ
         CbD1DV2ynGZ41KOOiukdkgCPMDsg8MZUIwqW/nupndjq29NVdvesJi3B7GXydbefjHYT
         PA/EoJ/w1i6QkU6s0TywqXXgYW0DBIXyvG++C1fnRElNCFY7CnDt7abBt1qj/uLIaKaQ
         0Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1yb9KPpW163F2PxwvPiqbffL92UYcGBzOHlCQNKTfHs=;
        b=iZixExkrLmb0nMS8zqjMBQxngPP8iPY8dTbf2VzElcfs3EH2aB4andLnnX4AyB+SjC
         ufZpmdvi5C/AZx0O+U/0C7pAG8Yo7k3K1TCNeEpFDrstirhW5/unCrPNBJhZCCa27nPF
         qeruF36gjmXuIS71jkQWUIFHglR8ihTHKytMfF8R+NfOQhZmRRbjxDS9H7/npf6r5S8D
         B9OQZbuZcSkb+JcDeUEc6kdqKotVWV/qCXXe81/9zqM8RNICQDA7EuX0K70XnfBLciE5
         yjYKckYcJihaxDz1D7I5jEdSUmVp1FAIfkvtZG7rqewgPRKlqXUWrvWJUzPExwzWcC9p
         mYdw==
X-Gm-Message-State: APjAAAXJwHAXsllN4VhihmaJgnCEmhPAK5rymgt49zFpdhutBEMClFgm
        HOWtSDya3y11lOj8oit8tm4WGPpEQA==
X-Google-Smtp-Source: APXvYqxF777Tn6EppPm/3GI7vxy5W4cByrlhbBVDHUEyffNMB7s9NVKl5TFoGebiBNzkPtvSgPlIW/A6Lw==
X-Received: by 2002:ab0:2ea8:: with SMTP id y8mr10878454uay.23.1579529987496;
 Mon, 20 Jan 2020 06:19:47 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:19:25 +0100
In-Reply-To: <20200120141927.114373-1-elver@google.com>
Message-Id: <20200120141927.114373-3-elver@google.com>
Mime-Version: 1.0
References: <20200120141927.114373-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 3/5] asm-generic, kcsan: Add KCSAN instrumentation for bitops
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

Add explicit KCSAN checks for bitops.

Note that test_bit() is an atomic bitop, and we instrument it as such,
although it is in the non-atomic header. Currently it cannot be moved:
 http://lkml.kernel.org/r/87pnh5dlmn.fsf@dja-thinkpad.axtens.net

Signed-off-by: Marco Elver <elver@google.com>
---
 include/asm-generic/bitops/instrumented-atomic.h | 14 +++++++-------
 include/asm-generic/bitops/instrumented-lock.h   | 10 +++++-----
 .../asm-generic/bitops/instrumented-non-atomic.h | 16 ++++++++--------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index 18ce3c9e8eec..fb2cb33a4013 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H
 
-#include <linux/kasan-checks.h>
+#include <linux/instrumented.h>
 
 /**
  * set_bit - Atomically set a bit in memory
@@ -25,7 +25,7 @@
  */
 static inline void set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_set_bit(nr, addr);
 }
 
@@ -38,7 +38,7 @@ static inline void set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit(nr, addr);
 }
 
@@ -54,7 +54,7 @@ static inline void clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_change_bit(nr, addr);
 }
 
@@ -67,7 +67,7 @@ static inline void change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit(nr, addr);
 }
 
@@ -80,7 +80,7 @@ static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_clear_bit(nr, addr);
 }
 
@@ -93,7 +93,7 @@ static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_change_bit(nr, addr);
 }
 
diff --git a/include/asm-generic/bitops/instrumented-lock.h b/include/asm-generic/bitops/instrumented-lock.h
index ec53fdeea9ec..b9bec468ae03 100644
--- a/include/asm-generic/bitops/instrumented-lock.h
+++ b/include/asm-generic/bitops/instrumented-lock.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H
 
-#include <linux/kasan-checks.h>
+#include <linux/instrumented.h>
 
 /**
  * clear_bit_unlock - Clear a bit in memory, for unlock
@@ -22,7 +22,7 @@
  */
 static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit_unlock(nr, addr);
 }
 
@@ -37,7 +37,7 @@ static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
  */
 static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit_unlock(nr, addr);
 }
 
@@ -52,7 +52,7 @@ static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit_lock(nr, addr);
 }
 
@@ -71,7 +71,7 @@ static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 static inline bool
 clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_clear_bit_unlock_is_negative_byte(nr, addr);
 }
 /* Let everybody know we have it. */
diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index 95ff28d128a1..20f788a25ef9 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 
-#include <linux/kasan-checks.h>
+#include <linux/instrumented.h>
 
 /**
  * __set_bit - Set a bit in memory
@@ -24,7 +24,7 @@
  */
 static inline void __set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___set_bit(nr, addr);
 }
 
@@ -39,7 +39,7 @@ static inline void __set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit(nr, addr);
 }
 
@@ -54,7 +54,7 @@ static inline void __clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___change_bit(nr, addr);
 }
 
@@ -68,7 +68,7 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -82,7 +82,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -96,7 +96,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_change_bit(nr, addr);
 }
 
@@ -107,7 +107,7 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_bit(long nr, const volatile unsigned long *addr)
 {
-	kasan_check_read(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_bit(nr, addr);
 }
 
-- 
2.25.0.341.g760bfbb309-goog

