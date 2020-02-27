Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4676C35DF9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC4724691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fhU4ZWts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgB0TfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:35:25 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38955 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgB0TfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:35:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so204826plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 11:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZN5E5934TvMDmRyA6YbiUZA3oVW+HYGx9jzlGs1fas=;
        b=fhU4ZWtsMwSX2mupe2qPd38EZqvMNduMdASxFGXOeV4vpARzuW/YSPVaTMFGN08Hhc
         XliIaYkwUiNY8jqwNeYkG4jQoqhhnqvlU2l4wKiF6qSNMzXt1xWnxElExOLM5ZL41m7y
         Z7z1AWZH5EHP1O9W7xlNQcsJwhj4eFUdEyy5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZN5E5934TvMDmRyA6YbiUZA3oVW+HYGx9jzlGs1fas=;
        b=kWWRg8wlfTSpBimExfpSz2vCGisRh0iqyqkFbc8bFdl1OswOCny+8tgxjVrkTPPTq7
         2RnWFrcy86a1TcPrlHBgelEJqGpZptTvMWSPFR9DGLHyDL15orocnRxQ17zWdkJJbnjq
         6xE0gkStfEns53RwPJF4HF+gBM5J0J4Vary/aLOpdppWGhCdT4d1bAeEu/riQttVz7Y7
         2YIxA4UsurOGsClUIVGuP9Tn+Vx1O/xXuEs3TWt3eQFVQ0sXTfVueTLaYM0K4o4FUpny
         66iN/2fawMXkMpXfmuX+A1gf1M7KCOGty+h+Z4z45HK4ZkXPBEy12oPSFKBiEC95sUYt
         ecSQ==
X-Gm-Message-State: APjAAAVJGpjO7Xn6Jc8eqsd9tH+zUI7nonYMz4KH0BhkI2QPYMoQ6ucK
        8OeOQVaBgRqt0lxvoZWizAfUiw==
X-Google-Smtp-Source: APXvYqy8bVQH818HJGFZc2ql+d1GQcz5CnyZ/Lu/Mb9ddeqTtnjcaB2N07vWUnQwqSXTy5cLxuMyQA==
X-Received: by 2002:a17:902:7048:: with SMTP id h8mr383251plt.64.1582832122570;
        Thu, 27 Feb 2020 11:35:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm4244205pgp.0.2020.02.27.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:35:20 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Petrova <lenaptr@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        syzkaller@googlegroups.com
Subject: [PATCH v5 2/6] ubsan: Split "bounds" checker from other options
Date:   Thu, 27 Feb 2020 11:35:12 -0800
Message-Id: <20200227193516.32566-3-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227193516.32566-1-keescook@chromium.org>
References: <20200227193516.32566-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to do kernel builds with the bounds checker individually
available, introduce CONFIG_UBSAN_BOUNDS, with the remaining options
under CONFIG_UBSAN_MISC.

For example, using this, we can start to expand the coverage syzkaller is
providing. Right now, all of UBSan is disabled for syzbot builds because
taken as a whole, it is too noisy. This will let us focus on one feature
at a time.

For the bounds checker specifically, this provides a mechanism to
eliminate an entire class of array overflows with close to zero
performance overhead (I cannot measure a difference). In my (mostly)
defconfig, enabling bounds checking adds ~4200 checks to the kernel.
Performance changes are in the noise, likely due to the branch predictors
optimizing for the non-fail path.

Some notes on the bounds checker:

- it does not instrument {mem,str}*()-family functions, it only
  instruments direct indexed accesses (e.g. "foo[i]"). Dealing with
  the {mem,str}*()-family functions is a work-in-progress around
  CONFIG_FORTIFY_SOURCE[1].

- it ignores flexible array members, including the very old single
  byte (e.g. "int foo[1];") declarations. (Note that GCC's
  implementation appears to ignore _all_ trailing arrays, but Clang only
  ignores empty, 0, and 1 byte arrays[2].)

[1] https://github.com/KSPP/linux/issues/6
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92589

Suggested-by: Elena Petrova <lenaptr@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
 lib/Kconfig.ubsan      | 29 ++++++++++++++++++++++++-----
 scripts/Makefile.ubsan |  7 ++++++-
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 9deb655838b0..48469c95d78e 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -2,7 +2,7 @@
 config ARCH_HAS_UBSAN_SANITIZE_ALL
 	bool
 
-config UBSAN
+menuconfig UBSAN
 	bool "Undefined behaviour sanity checker"
 	help
 	  This option enables the Undefined Behaviour sanity checker.
@@ -10,9 +10,10 @@ config UBSAN
 	  behaviours at runtime. For more details, see:
 	  Documentation/dev-tools/ubsan.rst
 
+if UBSAN
+
 config UBSAN_TRAP
 	bool "On Sanitizer warnings, abort the running kernel code"
-	depends on UBSAN
 	depends on $(cc-option, -fsanitize-undefined-trap-on-error)
 	help
 	  Building kernels with Sanitizer features enabled tends to grow
@@ -25,9 +26,26 @@ config UBSAN_TRAP
 	  the system. For some system builders this is an acceptable
 	  trade-off.
 
+config UBSAN_BOUNDS
+	bool "Perform array index bounds checking"
+	default UBSAN
+	help
+	  This option enables detection of directly indexed out of bounds
+	  array accesses, where the array size is known at compile time.
+	  Note that this does not protect array overflows via bad calls
+	  to the {str,mem}*cpy() family of functions (that is addressed
+	  by CONFIG_FORTIFY_SOURCE).
+
+config UBSAN_MISC
+	bool "Enable all other Undefined Behavior sanity checks"
+	default UBSAN
+	help
+	  This option enables all sanity checks that don't have their
+	  own Kconfig options. Disable this if you only want to have
+	  individually selected checks.
+
 config UBSAN_SANITIZE_ALL
 	bool "Enable instrumentation for the entire kernel"
-	depends on UBSAN
 	depends on ARCH_HAS_UBSAN_SANITIZE_ALL
 
 	# We build with -Wno-maybe-uninitilzed, but we still want to
@@ -44,7 +62,6 @@ config UBSAN_SANITIZE_ALL
 
 config UBSAN_NO_ALIGNMENT
 	bool "Disable checking of pointers alignment"
-	depends on UBSAN
 	default y if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
 	  This option disables the check of unaligned memory accesses.
@@ -57,7 +74,9 @@ config UBSAN_ALIGNMENT
 
 config TEST_UBSAN
 	tristate "Module for testing for undefined behavior detection"
-	depends on m && UBSAN
+	depends on m
 	help
 	  This is a test module for UBSAN.
 	  It triggers various undefined behavior, and detect it.
+
+endif	# if UBSAN
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 668a91510bfe..5b15bc425ec9 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -5,14 +5,19 @@ ifdef CONFIG_UBSAN_ALIGNMENT
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=alignment)
 endif
 
+ifdef CONFIG_UBSAN_BOUNDS
+      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
+endif
+
+ifdef CONFIG_UBSAN_MISC
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=shift)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=integer-divide-by-zero)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=unreachable)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=signed-integer-overflow)
-      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=object-size)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=bool)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=enum)
+endif
 
 ifdef CONFIG_UBSAN_TRAP
       CFLAGS_UBSAN += $(call cc-option, -fsanitize-undefined-trap-on-error)
-- 
2.20.1

