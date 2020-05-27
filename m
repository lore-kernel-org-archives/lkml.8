Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434C6207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9B95SbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgE0KdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgE0KdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:33:12 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A02C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 03:33:12 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e44so25364922qta.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DosOYF3ps8rgQKGpMQeCZ1cwpGKFHV+Ez1qTc9wvzYQ=;
        b=h9B95SbKbShNt1lB+ySn2GyjP+UgZXssfV8mgIcHh91KiWoQD1RFqGw610hkzIMyVt
         oEr7U4NQaBt2sU9PhCOavnznY0CNYUp/jgZC1eIaeHP3U9qslxxuvuCZ8riTmZTGHu4M
         xwO+B07QB7X1mqLaG3UL0ZC5u6rDyl4J2QVObU/d9uSUSxnPR2R6jn398mwlYdWkDRNn
         9uIHzTCcwNSIiasWnmlK+qfzJqoqrOmNDRfAXNedcWwSLDjI4HN/M9D1SZ4Ow5WIfs4A
         M67Xq+Tu0TONXoKQ0dQSH9gyp5TUv38XEhAnypzN9cv3qOeORY5zCyECVnNKvABgxxCW
         iwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DosOYF3ps8rgQKGpMQeCZ1cwpGKFHV+Ez1qTc9wvzYQ=;
        b=fZyhmqmqQ+W1LmkPjuD927fswx2Ldx1zT5jK0OFLAW9U3TiJmjLMofTTE1fxg8pMOV
         cN7U2vtRcEp0zEP2fuDI0pc5UKimvS0IekXKrUbYsem3v4Y+FC+mDX0wHBu/8arbWyxn
         5OS5T9WKIV2oR92dt0PTzSgkIFc+bZ9Q5CEqP25k1VkBhP394nrOSH/wMTxq4nkY9ZkM
         lPUABCASPyU8iW6FW1oqLqhFbpCn7YMkkolF2YuMd6N/p+4tmSmKlIOmKSy586o90PP+
         DzCEuHkAONZL8nEJd8YS2/ewii/9mHN3XIQs1xu/m3mhSBxrHyAniVSZXCeCji33p/B4
         MazQ==
X-Gm-Message-State: AOAM533O3gC2KCqSY4CoTTGHFbNXgH32KnSO/oTbo+Q40kqznVPBt8lG
        TjfbbFTTNajBKOR3zMvLO9CWHymv0A==
X-Google-Smtp-Source: ABdhPJxvfelEMXwZaKB7gs9ih4rm9wIPB8phhU0IKJFxv9yWUrZ/N3ifxlF9JyN+UOHWjmy9xXYvNvJizw==
X-Received: by 2002:ad4:5684:: with SMTP id bc4mr24918443qvb.85.1590575591788;
 Wed, 27 May 2020 03:33:11 -0700 (PDT)
Date:   Wed, 27 May 2020 12:32:36 +0200
Message-Id: <20200527103236.148700-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH -tip] compiler_types.h: Optimize __unqual_scalar_typeof
 compilation time
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org,
        clang-built-linux@googlegroups.com, paulmck@kernel.org,
        dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the compiler supports C11's _Generic, use it to speed up compilation
times of __unqual_scalar_typeof(). GCC version 4.9 or later and
all supported versions of Clang support the feature (the oldest
supported compiler that doesn't support _Generic is GCC 4.8, for which
we use the slower alternative).

The non-_Generic variant relies on multiple expansions of
__pick_integer_type -> __pick_scalar_type -> __builtin_choose_expr,
which increases pre-processed code size, and can cause compile times to
increase in files with numerous expansions of READ_ONCE(), or other
users of __unqual_scalar_typeof().

Summary of compile-time benchmarking done by Arnd Bergmann [1]:

	<baseline normalized time>  clang-11   gcc-9
	this patch                      0.78    0.91
	ideal                           0.76    0.86

[1] https://lkml.kernel.org/r/CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com

Further compile-testing done with:
	gcc 4.8, 4.9, 5.5, 6.4, 7.5, 8.4;
	clang 9, 10.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com
---
Same version as in:
https://lkml.kernel.org/r/20200526173312.GA30240@google.com
---
 include/linux/compiler_types.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 5faf68eae204..a529fa263906 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -245,7 +245,9 @@ struct ftrace_likely_data {
 /*
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
- *
+ */
+#if defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900
+/*
  * We build this out of a couple of helper macros in a vain attempt to
  * help you keep your lunch down while reading it.
  */
@@ -267,6 +269,24 @@ struct ftrace_likely_data {
 			__pick_integer_type(x, int,				\
 				__pick_integer_type(x, long,			\
 					__pick_integer_type(x, long long, x))))))
+#else
+/*
+ * If supported, prefer C11 _Generic for better compile-times. As above, 'char'
+ * is not type-compatible with 'signed char', and we define a separate case.
+ */
+#define __scalar_type_to_expr_cases(type)				\
+		type: (type)0, unsigned type: (unsigned type)0
+
+#define __unqual_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			 __scalar_type_to_expr_cases(char),		\
+			 signed char: (signed char)0,			\
+			 __scalar_type_to_expr_cases(short),		\
+			 __scalar_type_to_expr_cases(int),		\
+			 __scalar_type_to_expr_cases(long),		\
+			 __scalar_type_to_expr_cases(long long),	\
+			 default: (x)))
+#endif
 
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
-- 
2.27.0.rc0.183.gde8f92d652-goog

