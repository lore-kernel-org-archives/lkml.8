Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ACDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33911207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0acVnUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgEULJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgEULJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:09:53 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB4FC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:09:53 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 19so7263966qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rd50Ui3HZ2EL9EcMGbbjqrEeCeIHgbARzkGzMmh8b1c=;
        b=D0acVnUvPpHqZi1ra6du734zmpv6yVFU3/efTAR5N2r4IpiHU+SSOTgbwEWCQqfUs2
         revDXHnBzK+NXaF2UHSjuKJCQ77/IgaXtsZylYLywHeNyk9wXYZAZB7VQK/tHpd8Q+Do
         n9jZUozLt4+JpA7P9ChyqKg8emvdR2wGm76NgLqBlQCYKldcy5o0QWA7typQ+fDFTqk2
         eKN78gn47W5huB0Syz2xBI0R6kBTFvMPf7BmsRb/CS80ktKDx1mz8hig+Rrh81diF7RM
         1jmRT6NraZ1L0Fp1pgvjdRsvJUBkmxIXoDY1WvJ364efEn1kn2vtL3Ox3cpogeUgeyk4
         ucoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rd50Ui3HZ2EL9EcMGbbjqrEeCeIHgbARzkGzMmh8b1c=;
        b=ZMDfC0qlar4UUfTLSEYm0J0IdrE9c+hhsu7mmVyw6hF2E1yt8IZYK8CogYLF41gvXj
         OPgorSUaROk6IUFN/OXVa9rEVG22N9UHH6XFn8q/Vza+XGGXjfezAOTcnmSsoX032gMw
         WDz3hG50RY2G0spZ4s/x2D/mYqic1DnUZvzFnhWb71Tgby3Ah21nwsDjRcda7eGlrQ8/
         ErEt84W7LRjoFiUh3eW1Bu8JrKSwhnQuZvQKVtwGDfpSIMt1FgE9IDwR3HvrrjZPykkf
         tO+Kt0jGDP30UKoN8r40jByX+FxkJ1lXCAHkbsg13x/N2wM4MqB7ytXREqJiA4duDwTG
         7J8g==
X-Gm-Message-State: AOAM5304hgvZ22WQH3p09i2ZIC4A6FA8aMmmRcG6hgbIiSC8csT0dcGC
        3kJ6+3BrJ4BJXTwChTdfM7S68PK/Vg==
X-Google-Smtp-Source: ABdhPJzJjZKDLLsloZRY3sc91o87JNo+ehQaTrHzqeOrKdIausooI7fNzioNbPCSuG+eGJ9yzfb6Ncaevw==
X-Received: by 2002:a0c:e744:: with SMTP id g4mr9331224qvn.55.1590059391368;
 Thu, 21 May 2020 04:09:51 -0700 (PDT)
Date:   Thu, 21 May 2020 13:08:44 +0200
In-Reply-To: <20200521110854.114437-1-elver@google.com>
Message-Id: <20200521110854.114437-2-elver@google.com>
Mime-Version: 1.0
References: <20200521110854.114437-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v2 01/11] ubsan, kcsan: don't combine sanitizer with kcov
 on clang
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com, bp@alien8.de,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang does not allow -fsanitize-coverage=trace-{pc,cmp} together
with -fsanitize=bounds or with ubsan:

clang: error: argument unused during compilation: '-fsanitize-coverage=trace-pc' [-Werror,-Wunused-command-line-argument]
clang: error: argument unused during compilation: '-fsanitize-coverage=trace-cmp' [-Werror,-Wunused-command-line-argument]

To avoid the warning, check whether clang can handle this correctly
or disallow ubsan and kcsan when kcov is enabled.

Link: https://bugs.llvm.org/show_bug.cgi?id=45831
Link: https://lore.kernel.org/lkml/20200505142341.1096942-1-arnd@arndb.de
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
---
This patch is already in -rcu tree, but since since the series is based
on -tip, to avoid conflict it is required for the subsequent patches.
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
index 48469c95d78e..3baea77bf37f 100644
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
2.26.2.761.g0e0b3e54be-goog

