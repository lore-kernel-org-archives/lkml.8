Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DAAC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAE32083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEGQ0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:26:37 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40329 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEGQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:26:36 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MWRe1-1jeBD910tn-00Xufr; Thu, 07 May 2020 18:26:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] ubsan, kcsan: don't combine sanitizer with kcov on clang
Date:   Thu,  7 May 2020 18:25:31 +0200
Message-Id: <20200507162617.2472578-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <CANpmjNPCZ2r9V7t50_yy+F_-roBWJdiQWgmvvcqTFxzdzOwKhg@mail.gmail.com>
References: <CANpmjNPCZ2r9V7t50_yy+F_-roBWJdiQWgmvvcqTFxzdzOwKhg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Wu355d2keiT+DomNoCv1+GG6rk5RbqLzx+vkGjzDKtS+V3yIyQG
 6ihXPPX397wJmWAjP409EOBm8Lb7F4b5kdcec4kIwwwPQ3FN9b+jjt07gItE5RG+npOFhnF
 AtoA281a5IOmWhWqiiCkA8G/24I7wTZjfyMeqvC3+U5TxLO3coNrS27G7XjimIPp7D7H7O0
 AYIUgrAAEr4H3ddktCgrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bhWFnq9NWHo=:5tJlgXF+2Bv3nOEYTE0p9j
 NPqVpsQ/jxgKgi/vuEMU/q0I1znfnkbRj0TaJf7uMzprYNs6Z8WavH+Z0aIicQn7Qd1FAwuFA
 Xu3bmkkHmAjseqOjycwICf00icuCxzQFsCLKadIjQnpkZHLArutNStKOOg/rD/m9Zj7WEdEVs
 w1EWLd8ATnolfxyZfLfwGsaGV6zrpcSgy+wmQwCmKaa+7pQKxMzCvINVssmZxTaARcZJGb4kV
 UzfQ0DYqOigKSL8pC1Xt+piE5vr0Iwu0xfZzgiuzHUMnhQ37ra6wWPVkX2rPjuAHG+K1mPzfW
 aXC+84ux4k7hrjI5CmAQbb6VO8aTQE8k0fHTYoTTDMD+6Uo/XhkjQxe80wJWNBOomNtJ3nkD+
 3Z2MlGwgb892a/RLG/q9E3dDrsaAaRm0YarN0ljlJMhmeNA3oNMJDfK/1j2KI05P8Z6ynWsjr
 FFGd4tEXMOQHYZyp658iTwKGTpNtUDIz+NPtj3gFUd+OaBAU8t03wupeM5cUzyCsKwU92jGvr
 UEMvAhCl0mfH/Jh0wgfYydHKyJ6Gu2EV3cEjvf+J4TlKdE4sQvDDxcqoHXYvd3+lRPFNMOXBJ
 8Rxayg6e5/Upae+M7PwLfv89k1XL2VTeyz6Th/E30Dq71RUqt1rsPVmWg7nFnQ1Vyq1TTYauU
 6csJmqx1idVdulaXD70scaCmRvzLsI2pXDKhifXGNCEbJxeZGVpNRjdps2bdmpunI2PA57K5g
 fZ90kS53ULz00soz5VfAUg4LcH85CoZwE8YJWrYr9o0M8BgD0emMo8PmqGMyQIICOAvs/dXKF
 QJZfjlEvR8vhPJaFCyjkQX+mXRROG0zX7xkjfNm1qVeAM12amA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang does not allow -fsanitize-coverage=trace-{pc,cmp} together
with -fsanitize=bounds or with ubsan:

clang: error: argument unused during compilation: '-fsanitize-coverage=trace-pc' [-Werror,-Wunused-command-line-argument]
clang: error: argument unused during compilation: '-fsanitize-coverage=trace-cmp' [-Werror,-Wunused-command-line-argument]

To avoid the warning, check whether clang can handle this correctly
or disallow ubsan and kcsan when kcov is enabled.

Link: https://bugs.llvm.org/show_bug.cgi?id=45831
Link: https://lore.kernel.org/lkml/20200505142341.1096942-1-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: this implements Marco's suggestion to check what the compiler
actually supports, and references the bug report I now opened.

Let's wait for replies on that bug report before this gets applied,
in case the feedback there changes the conclusion.
---
 lib/Kconfig.kcsan | 11 +++++++++++
 lib/Kconfig.ubsan | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index ea28245c6c1d..a7276035ca0d 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -3,9 +3,20 @@
 config HAVE_ARCH_KCSAN
 	bool
 
+config KCSAN_KCOV_BROKEN
+	def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
+	depends on CC_IS_CLANG
+	depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=thread -fsanitize-coverage=trace-pc)
+	help
+	  Some versions of clang support either KCSAN and KCOV but not the
+	  combination of the two.
+	  See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
+	  in newer releases.
+
 menuconfig KCSAN
 	bool "KCSAN: dynamic data race detector"
 	depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
+	depends on !KCSAN_KCOV_BROKEN
 	select STACKTRACE
 	help
 	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 929211039bac..a5ba2fd51823 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -26,9 +26,20 @@ config UBSAN_TRAP
 	  the system. For some system builders this is an acceptable
 	  trade-off.
 
+config UBSAN_KCOV_BROKEN
+	def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
+	depends on CC_IS_CLANG
+	depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=bounds -fsanitize-coverage=trace-pc)
+	help
+	  Some versions of clang support either UBSAN or KCOV but not the
+	  combination of the two.
+	  See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
+	  in newer releases.
+
 config UBSAN_BOUNDS
 	bool "Perform array index bounds checking"
 	default UBSAN
+	depends on !UBSAN_KCOV_BROKEN
 	help
 	  This option enables detection of directly indexed out of bounds
 	  array accesses, where the array size is known at compile time.
-- 
2.26.0

