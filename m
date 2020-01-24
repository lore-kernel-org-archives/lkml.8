Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A64C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C36221556
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgAXJNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:13:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41849 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgAXJNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:13:35 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iuv1u-0007dG-0r; Fri, 24 Jan 2020 10:13:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 935C31C010B;
        Fri, 24 Jan 2020 10:13:29 +0100 (CET)
Date:   Fri, 24 Jan 2020 09:13:29 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Add __no_kcsan function attribute
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157985720930.396.9116600155349788527.tip-bot2@tip-bot2>
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

Commit-ID:     e33f9a169747880a008dd5e7b934fc592e91cd63
Gitweb:        https://git.kernel.org/tip/e33f9a169747880a008dd5e7b934fc592e91cd63
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 12 Dec 2019 01:07:09 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 07 Jan 2020 07:47:23 -08:00

kcsan: Add __no_kcsan function attribute

Since the use of -fsanitize=thread is an implementation detail of KCSAN,
the name __no_sanitize_thread could be misleading if used widely.
Instead, we introduce the __no_kcsan attribute which is shorter and more
accurate in the context of KCSAN.

This matches the attribute name __no_kcsan_or_inline. The use of
__kcsan_or_inline itself is still required for __always_inline functions
to retain compatibility with older compilers.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/compiler-gcc.h | 3 +--
 include/linux/compiler.h     | 7 +++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 0eb2a1c..cf294fa 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -146,8 +146,7 @@
 #endif
 
 #if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
-#define __no_sanitize_thread                                                   \
-	__attribute__((__noinline__)) __attribute__((no_sanitize_thread))
+#define __no_sanitize_thread __attribute__((no_sanitize_thread))
 #else
 #define __no_sanitize_thread
 #endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ad8c761..8c0beb1 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -207,12 +207,15 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define __no_kasan_or_inline __always_inline
 #endif
 
+#define __no_kcsan __no_sanitize_thread
 #ifdef __SANITIZE_THREAD__
 /*
  * Rely on __SANITIZE_THREAD__ instead of CONFIG_KCSAN, to avoid not inlining in
- * compilation units where instrumentation is disabled.
+ * compilation units where instrumentation is disabled. The attribute 'noinline'
+ * is required for older compilers, where implicit inlining of very small
+ * functions renders __no_sanitize_thread ineffective.
  */
-# define __no_kcsan_or_inline __no_sanitize_thread notrace __maybe_unused
+# define __no_kcsan_or_inline __no_kcsan noinline notrace __maybe_unused
 # define __no_sanitize_or_inline __no_kcsan_or_inline
 #else
 # define __no_kcsan_or_inline __always_inline
