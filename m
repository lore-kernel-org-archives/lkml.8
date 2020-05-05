Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C075BC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A23206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgEEOYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:24:07 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgEEOX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:23:59 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MacjC-1izfbf1FxC-00c78g; Tue, 05 May 2020 16:23:45 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ubsan, kcsan: don't combine sanitizer with kcov
Date:   Tue,  5 May 2020 16:23:24 +0200
Message-Id: <20200505142341.1096942-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JkuyWhciBA/aX1Zn4ELUz4dlGvSAU8bKJNTZp0muHfNY70Is8/z
 PQV0xJ+scnfPXeY8VAGsx2N/Y2vXgGDZheALBVwZUXDSKdy2bdNc8Z2PrkSNFFxkx37YLNh
 Z8uFSR+Q7ZjuSdBRCdR+4L7yllPzaAJwmQMpAN3CrAdUbrJKkmJ6Yo+c3wz3JnveMWcxobE
 SMNSE9VDqfPQ8hFKI4AlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tgXZYycAEVU=:lPwOc28vx5ScJrO1pHRcB0
 rxw0c5/ZDaDv7RJ/qbwYGydXNqqS6uzeVUc8MMG6ZeFq8tvKV9VIQc94u0AUEJjq6ImT5Ergq
 rQxaX/chIPGX53mBVBYn5xBOCx81eKmeB1EdXqJzVg7JqFW28UAA9cF59rYJ+gE3SIdVE/nIF
 SokPSHNDCMEspvYRh2CrNorucNVYsEL/AgJXbpn0PZl9zEzBI/djdSgv9/LrxhTmZHy6RNLUE
 0XwXuejTHjC9EKHXgxGmyIUKmcS1mLFyNsb+DxbdrfVMpE+7sgaqvu+wu/hPojVWMIQjmLQbw
 va+xgLG/Q6wh540kMi4yAggUI1qc+YuH3XnvyvGWm2EaSZiGURifJrwzJxYs+AKd6GMY3+3xx
 zsL2tW4o/QFVkXVNR5JSV3Gu/lrOox2IkJ/5AU+5kja6VhXCRbRnwK5syP3xa5FrLAa90z7GG
 KNGS1FYIS9p3t30+hicKEV5lf0yAA5vL0qUdN1K3S4R/r3h85XmgmeGlUrrcVOfjUpZYA2dk9
 zyS+Yy009Ly3gp687W8jivoGTTrxYJZYlepNS6lt/8vDb/J7ImpIIdirdhF/M54Hi8mLahoX7
 g8zh43nDHnieM2fROES6HZX+c0J9kkqV93/zcCVqpNhkDhw3WXoG5WeNSe67smre82rl1zcVA
 5LXl/C86XYD+LkZA9jjKLiW5xzOyR51h9YDAo1kKdMaxGYkMb/H7k3r8glnjcp9ECirj7K+Qe
 QfHceo3s8uzaulP7M3XrRegVhnYM9NriiEa192ZQQ2KEDUHhvlVvyy+FLDJHDDwAZ7rl3MTQ9
 3itAByRmtW1leBvDn6VsH+KZvYoOScPZVHB3svSQALiyIgicBA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang does not allow -fsanitize-coverage=trace-{pc,cmp} together
with -fsanitize=bounds or with ubsan:

clang: error: argument unused during compilation: '-fsanitize-coverage=trace-pc' [-Werror,-Wunused-command-line-argument]
clang: error: argument unused during compilation: '-fsanitize-coverage=trace-cmp' [-Werror,-Wunused-command-line-argument]

To avoid that case, add a Kconfig dependency. The dependency could
go either way, disabling CONFIG_KCOV or CONFIG_UBSAN_BOUNDS when the
other is set. I picked the second option here as this seems to have
a smaller impact on the resulting kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.kcsan | 2 +-
 lib/Kconfig.ubsan | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index ea28245c6c1d..8f856c8828d5 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -5,7 +5,7 @@ config HAVE_ARCH_KCSAN
 
 menuconfig KCSAN
 	bool "KCSAN: dynamic data race detector"
-	depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
+	depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !KCOV
 	select STACKTRACE
 	help
 	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 929211039bac..f98ef029553e 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -29,6 +29,7 @@ config UBSAN_TRAP
 config UBSAN_BOUNDS
 	bool "Perform array index bounds checking"
 	default UBSAN
+	depends on !(CC_IS_CLANG && KCOV)
 	help
 	  This option enables detection of directly indexed out of bounds
 	  array accesses, where the array size is known at compile time.
-- 
2.26.0

