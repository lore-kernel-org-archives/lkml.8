Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41934C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2846C207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgE0PZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgE0PZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:25:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F98C05BD1E;
        Wed, 27 May 2020 08:25:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdxw3-0006uM-OZ; Wed, 27 May 2020 17:25:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 30C291C00ED;
        Wed, 27 May 2020 17:25:39 +0200 (CEST)
Date:   Wed, 27 May 2020 15:25:39 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] compiler_types.h: Optimize
 __unqual_scalar_typeof compilation time
Cc:     Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527103236.148700-1-elver@google.com>
References: <20200527103236.148700-1-elver@google.com>
MIME-Version: 1.0
Message-ID: <159059313900.17951.16258985921157909524.tip-bot2@tip-bot2>
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

Commit-ID:     a5dead405f6be1fb80555bdcb77c406bf133fdc8
Gitweb:        https://git.kernel.org/tip/a5dead405f6be1fb80555bdcb77c406bf133fdc8
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 27 May 2020 12:32:36 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 May 2020 14:03:26 +02:00

compiler_types.h: Optimize __unqual_scalar_typeof compilation time

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

Summary of compile-time benchmarking done by Arnd Bergmann:

  <baseline normalized time>  clang-11   gcc-9
  this patch                      0.78    0.91
  ideal                           0.76    0.86

See https://lkml.kernel.org/r/CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com

Further compile-testing done with:
  gcc 4.8, 4.9, 5.5, 6.4, 7.5, 8.4;
  clang 9, 10.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20200527103236.148700-1-elver@google.com
Link: https://lkml.kernel.org/r/CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com
---
 include/linux/compiler_types.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 5faf68e..a529fa2 100644
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
