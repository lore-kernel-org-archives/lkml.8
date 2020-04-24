Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E77C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132832071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="f9J3gTCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgDXOzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgDXOzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:55:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7319C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:55:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w3so3825161plz.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPgC2WAJzXEPrhZgAELaUlSrwS704anaXCh4Y7pEazI=;
        b=f9J3gTCIMeLayynOnvRWDqT6z8Ior8ocH0kNNu0sS9Hnc20nqieCLIySfvgbNCSC1Q
         urKi/qfsgrC0CxxXmVniTNknxk4RTHZhUxg1BwUsJdn4JyvKPoiKfqiRaKlHWeGnqzxb
         OL7Rz7F585ZqGweSUwJmHUvFtXpW09oYKxy8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPgC2WAJzXEPrhZgAELaUlSrwS704anaXCh4Y7pEazI=;
        b=pbO2ktFI/aJfh5ZBuXByQTbOu2qEI6KO6lxIwdV6Q2RpXEnMI4YeEVjTavNrhBtVRV
         2LXlpb/ozI8I+7fkTxSyYt9oLxDbc951J2WzGRW0vep39KH5nGw4gB4eheNJ1cQWWtEZ
         jMrUf7iedutril4pMOkPsAsCgs1+CtSJpyAgi5sHNKFQrMCLqM1hjbjBmXArh5kH6Atx
         orvZUFYSFSfJUFs8WWjv1KZ9IG2NUj0SMVq6tn6bnlT8ELvickt80JyYHfNU44bTvrdT
         DMDpc/6DurcWY9PlLDruZvtM+lDvU8Wnah22GPChMhV3PEjhD0cqivXvo9AGXkhudwPB
         ErxQ==
X-Gm-Message-State: AGi0PuYSNMWpQadn0uAY0KmDIQWZTToMYJO4S0X/fXDN4h0cVKkrY95K
        0uW5rKYfGVDvcuzoGnrvDt4fWKtLSzs=
X-Google-Smtp-Source: APiQypLwqZvK5rQCzP+j07zTgWcOBOddsMZ9l3lVaEQZ8LUnDI+S9URu5X8NXDudjahObNQtqyW8tw==
X-Received: by 2002:a17:90a:246e:: with SMTP id h101mr6793515pje.83.1587740131771;
        Fri, 24 Apr 2020 07:55:31 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-fd06-aa7b-7508-4b8b.static.ipv6.internode.on.net. [2001:44b8:1113:6700:fd06:aa7b:7508:4b8b])
        by smtp.gmail.com with ESMTPSA id o11sm5123020pgd.58.2020.04.24.07.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:55:30 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com
Cc:     dvyukov@google.com, christophe.leroy@c-s.fr,
        Daniel Axtens <dja@axtens.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        David Gow <davidgow@google.com>
Subject: [PATCH v4 1/2] kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
Date:   Sat, 25 Apr 2020 00:55:20 +1000
Message-Id: <20200424145521.8203-2-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424145521.8203-1-dja@axtens.net>
References: <20200424145521.8203-1-dja@axtens.net>
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
Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v4: I accidentally dropped a memset from kasan_memcmp and then 'fixed' it in patch 3.
    Just don't drop it.

---
 lib/test_kasan.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index e3087d90e00d..dc2c6a51d11a 100644
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
@@ -622,7 +630,7 @@ static noinline void __init kasan_memchr(void)
 	if (!ptr)
 		return;
 
-	memchr(ptr, '1', size + 1);
+	kasan_ptr_result = memchr(ptr, '1', size + 1);
 	kfree(ptr);
 }
 
@@ -638,7 +646,7 @@ static noinline void __init kasan_memcmp(void)
 		return;
 
 	memset(arr, 0, sizeof(arr));
-	memcmp(ptr, arr, size+1);
+	kasan_int_result = memcmp(ptr, arr, size + 1);
 	kfree(ptr);
 }
 
@@ -661,22 +669,22 @@ static noinline void __init kasan_strings(void)
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
@@ -743,11 +751,12 @@ static noinline void __init kasan_bitops(void)
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

