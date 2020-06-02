Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC1DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CDE207FB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bo8SJMR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgFBSoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:44:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357EC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:44:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k186so18241876ybc.19
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=051VEaYf6qrL8JFuh/5zzz3L2mMvFIzQDHhJf0eGSZs=;
        b=Bo8SJMR+1yrygCRvaywJimf7JrrVS59Dt2LCUT2K8JVmIhbzQ7yVZJMM6nQZ0E+EAW
         fQZf3M2jxFgcgHfb1c66JQFO59GSOnCmiRXJjzLccRbxBNZetMr0c1Ozo147m94PPhb3
         Zoy2pYqc5wUAeBd/OJ/i+p/HdNh9f2P4oqOBmR4APfazA7ImZPSD/itREUPQrFciTvxh
         PC9SZCDTMtxb3oYCQnroUCnOhigQ+1vvm+rc3X8WNVAocWFa24rNe1c5OfeTFjYO1Upd
         v8edIf8wkgkVJlxiTFodSw/TbRwmYgcB83nd42BOJgdU4Im13V3J1IwUc0+qLTF2LVpV
         mmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=051VEaYf6qrL8JFuh/5zzz3L2mMvFIzQDHhJf0eGSZs=;
        b=qB+WzYKGGrmCjTCtMb249NejOYl66IoJNpjNFiBxyKdPHftdRJUjoeWTQ3yHy6wp47
         EsMFMG9PZEui5qevsVv97NHET9jM3ERV49dOJLAXISP0/MZj4t8+d2O4p+yB71SAd9EL
         15w5VLTTDTgFD7ygeJxt/5H2ZloLfAdL98p0QejtM/cngPH0PsaMLfJ+5l0RY9wr8/6b
         Q2hqv9agscR6opGRFKfeCB8mt3jjrdaAWgu6IWkfOu+un/vii3/FkNU6A0EMmAme3TYo
         XwQkGRAXRb05JbSsggtosJBkJE01dR3jp4jgsophUuImxK0nyEbgVOAGZDxj9s+yEhqV
         Q0RQ==
X-Gm-Message-State: AOAM531Qyd4Utaj40NOFGPBC9PP5ZQexHf84YcF4NpOZEHS9PDnhG9fn
        S9UDqWZktfv+8ADU1gV8gSFq+sVK4w==
X-Google-Smtp-Source: ABdhPJyx9WZnwTO1azLZFBnELmiu0iWZ5/ijr+TlPGeVS99K5pGJZsh96OtZOYOeUeYLaueLKJBQvVxyiQ==
X-Received: by 2002:a25:c606:: with SMTP id k6mr31464032ybf.10.1591123453516;
 Tue, 02 Jun 2020 11:44:13 -0700 (PDT)
Date:   Tue,  2 Jun 2020 20:44:08 +0200
Message-Id: <20200602184409.22142-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH -tip 1/2] Kconfig: Bump required compiler version of KASAN and UBSAN
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org,
        clang-built-linux@googlegroups.com, paulmck@kernel.org,
        dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds config variable CC_HAS_WORKING_NOSANITIZE, which will be true if we
have a compiler that does not fail builds due to no_sanitize functions.
This does not yet mean they work as intended, but for automated
build-tests, this is the minimum requirement.

For example, we require that __always_inline functions used from
no_sanitize functions do not generate instrumentation. On GCC <= 7 this
fails to build entirely, therefore we make the minimum version GCC 8.

For KCSAN this is a non-functional change, however, we should add it in
case this variable changes in future.

Link: https://lkml.kernel.org/r/20200602175859.GC2604@hirez.programming.kicks-ass.net
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
Apply after:
https://lkml.kernel.org/r/20200602173103.931412766@infradead.org
---
 init/Kconfig      | 3 +++
 lib/Kconfig.kasan | 1 +
 lib/Kconfig.kcsan | 1 +
 lib/Kconfig.ubsan | 1 +
 4 files changed, 6 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 0f72eb4ffc87..3e8565bc8376 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -39,6 +39,9 @@ config TOOLS_SUPPORT_RELR
 config CC_HAS_ASM_INLINE
 	def_bool $(success,echo 'void foo(void) { asm inline (""); }' | $(CC) -x c - -c -o /dev/null)
 
+config CC_HAS_WORKING_NOSANITIZE
+	def_bool !CC_IS_GCC || GCC_VERSION >= 80000
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 81f5464ea9e1..15e6c4b26a40 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -20,6 +20,7 @@ config KASAN
 	depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
+	depends on CC_HAS_WORKING_NOSANITIZE
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 5ee88e5119c2..2ab4a7f511c9 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -5,6 +5,7 @@ config HAVE_ARCH_KCSAN
 
 config HAVE_KCSAN_COMPILER
 	def_bool CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-distinguish-volatile=1)
+	depends on CC_HAS_WORKING_NOSANITIZE
 	help
 	  For the list of compilers that support KCSAN, please see
 	  <file:Documentation/dev-tools/kcsan.rst>.
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index a5ba2fd51823..f725d126af7d 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -4,6 +4,7 @@ config ARCH_HAS_UBSAN_SANITIZE_ALL
 
 menuconfig UBSAN
 	bool "Undefined behaviour sanity checker"
+	depends on CC_HAS_WORKING_NOSANITIZE
 	help
 	  This option enables the Undefined Behaviour sanity checker.
 	  Compile-time instrumentation is used to detect various undefined
-- 
2.27.0.rc2.251.g90737beb825-goog

