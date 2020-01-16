Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0124C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781982087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 06:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="C+UNMN/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgAPG0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:26:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33557 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbgAPG0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 01:26:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so9388228pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 22:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcisanTgJm2Q3K0/rpShD/S/gMp/LV+S7q0SnsZ5eZA=;
        b=C+UNMN/n21Z+KKPWTfdkIPpgJbCp3mGvMCgNhHm92fuQmkPRxe8JFhLupRWnAl3BwY
         h4nyTZzX4mKEfs9QRe+aUDa/7XzgnYI3nzON1Ohb5efUL0C15DI/G5D7rqbRgrqYl5Ef
         h9i+GdntCOUA9SGQQCKWLxSGfDECudeCS5xHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcisanTgJm2Q3K0/rpShD/S/gMp/LV+S7q0SnsZ5eZA=;
        b=pkC0dr3zzHD4zG7fTTv1ee5QnJIzKgO0qTQ/PNnLF8JPaxDB0eT0Y7G/7NjU0Zz2XJ
         jrVTA8Y9TqGoD72nQAqPmzj62tfggMCfAbg9HjfyvfBlonAFH9ArSFVpY0q6dfEhgsb0
         zTgF2Vyv7G+WMhNuMiqQwXMkglUJHKQoVhphByCd8y07dRrkzwxgrjKsxTzALtSkQuzo
         yaByOSTT/ngte/qTQ75G4W2ypdY8gcLmKSjYyOKIL+QOPUYJFhz3Jk5+kNupscBN3xCm
         NzRO0Ssp1aYY9uzM9MKG5lJ4mj91Oc7b5Gt97GorS0JC9Yo+lx4l7a73DHzo00uyRQmh
         UvrA==
X-Gm-Message-State: APjAAAV5JhmlLTy8CVX4OKuJ+E4ghzVY0ZGwmFqxapa4h19OfogijXaY
        SaZpiRQ272miKtMiTEi4iqpTiqkAmQ8=
X-Google-Smtp-Source: APXvYqzZNecZWkElAjCkhku46ZLAEt1HILfHwFxN9cP8hb0d/spt/ieWbkSQrR4axqy4NHudIk+/7A==
X-Received: by 2002:a63:220b:: with SMTP id i11mr36948573pgi.50.1579155995165;
        Wed, 15 Jan 2020 22:26:35 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-097c-7eed-afd4-cd15.static.ipv6.internode.on.net. [2001:44b8:1113:6700:97c:7eed:afd4:cd15])
        by smtp.gmail.com with ESMTPSA id c68sm24184359pfc.156.2020.01.15.22.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:26:34 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org, dvyukov@google.com,
        christophe.leroy@c-s.fr, Daniel Axtens <dja@axtens.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH v2 1/3] kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
Date:   Thu, 16 Jan 2020 17:26:23 +1100
Message-Id: <20200116062625.32692-2-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116062625.32692-1-dja@axtens.net>
References: <20200116062625.32692-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
memchr, memcmp and strlen.

When FORTIFY_SOURCE is on, a number of functions are replaced with
fortified versions, which attempt to check the sizes of the operands.
However, these functions often directly invoke __builtin_foo() once they
have performed the fortify check. The compiler can detect that the results
of these functions are not used, and knows that they have no other side
effects, and so can eliminate them as dead code.

Why are only memchr, memcmp and strlen affected?
================================================

Of string and string-like functions, kasan_test tests:

 * strchr  ->  not affected, no fortified version
 * strrchr ->  likewise
 * strcmp  ->  likewise
 * strncmp ->  likewise

 * strnlen ->  not affected, the fortify source implementation calls the
               underlying strnlen implementation which is instrumented, not
               a builtin

 * strlen  ->  affected, the fortify souce implementation calls a __builtin
               version which the compiler can determine is dead.

 * memchr  ->  likewise
 * memcmp  ->  likewise

 * memset ->   not affected, the compiler knows that memset writes to its
	       first argument and therefore is not dead.

Why does this not affect the functions normally?
================================================

In string.h, these functions are not marked as __pure, so the compiler
cannot know that they do not have side effects. If relevant functions are
marked as __pure in string.h, we see the following warnings and the
functions are elided:

lib/test_kasan.c: In function ‘kasan_memchr’:
lib/test_kasan.c:606:2: warning: statement with no effect [-Wunused-value]
  memchr(ptr, '1', size + 1);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
lib/test_kasan.c: In function ‘kasan_memcmp’:
lib/test_kasan.c:622:2: warning: statement with no effect [-Wunused-value]
  memcmp(ptr, arr, size+1);
  ^~~~~~~~~~~~~~~~~~~~~~~~
lib/test_kasan.c: In function ‘kasan_strings’:
lib/test_kasan.c:645:2: warning: statement with no effect [-Wunused-value]
  strchr(ptr, '1');
  ^~~~~~~~~~~~~~~~
...

This annotation would make sense to add and could be added at any point, so
the behaviour of test_kasan.c should change.

The fix
=======

Make all the functions that are pure write their results to a global,
which makes them live. The strlen and memchr tests now pass.

The memcmp test still fails to trigger, which is addressed in the next
patch.

Cc: Daniel Micay <danielmicay@gmail.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Fixes: 0c96350a2d2f ("lib/test_kasan.c: add tests for several string/memory API functions")
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v2: rename variables to have kasan_ prefixes
---
 lib/test_kasan.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 328d33beae36..a130d75b9385 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -23,6 +23,14 @@
 
 #include <asm/page.h>
 
+/*
+ * We assign some test results to these globals to make sure the tests
+ * are not eliminated as dead code.
+ */
+
+int kasan_int_result;
+void *kasan_ptr_result;
+
 /*
  * Note: test functions are marked noinline so that their names appear in
  * reports.
@@ -603,7 +611,7 @@ static noinline void __init kasan_memchr(void)
 	if (!ptr)
 		return;
 
-	memchr(ptr, '1', size + 1);
+	kasan_ptr_result = memchr(ptr, '1', size + 1);
 	kfree(ptr);
 }
 
@@ -618,8 +626,7 @@ static noinline void __init kasan_memcmp(void)
 	if (!ptr)
 		return;
 
-	memset(arr, 0, sizeof(arr));
-	memcmp(ptr, arr, size+1);
+	kasan_int_result = memcmp(ptr, arr, size + 1);
 	kfree(ptr);
 }
 
@@ -642,22 +649,22 @@ static noinline void __init kasan_strings(void)
 	 * will likely point to zeroed byte.
 	 */
 	ptr += 16;
-	strchr(ptr, '1');
+	kasan_ptr_result = strchr(ptr, '1');
 
 	pr_info("use-after-free in strrchr\n");
-	strrchr(ptr, '1');
+	kasan_ptr_result = strrchr(ptr, '1');
 
 	pr_info("use-after-free in strcmp\n");
-	strcmp(ptr, "2");
+	kasan_int_result = strcmp(ptr, "2");
 
 	pr_info("use-after-free in strncmp\n");
-	strncmp(ptr, "2", 1);
+	kasan_int_result = strncmp(ptr, "2", 1);
 
 	pr_info("use-after-free in strlen\n");
-	strlen(ptr);
+	kasan_int_result = strlen(ptr);
 
 	pr_info("use-after-free in strnlen\n");
-	strnlen(ptr, 1);
+	kasan_int_result = strnlen(ptr, 1);
 }
 
 static noinline void __init kasan_bitops(void)
@@ -724,11 +731,12 @@ static noinline void __init kasan_bitops(void)
 	__test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
 
 	pr_info("out-of-bounds in test_bit\n");
-	(void)test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+	kasan_int_result = test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
 
 #if defined(clear_bit_unlock_is_negative_byte)
 	pr_info("out-of-bounds in clear_bit_unlock_is_negative_byte\n");
-	clear_bit_unlock_is_negative_byte(BITS_PER_LONG + BITS_PER_BYTE, bits);
+	kasan_int_result = clear_bit_unlock_is_negative_byte(BITS_PER_LONG +
+		BITS_PER_BYTE, bits);
 #endif
 	kfree(bits);
 }
-- 
2.20.1

