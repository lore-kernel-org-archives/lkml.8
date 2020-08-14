Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A2AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCA620774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iN00ACnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgHNR3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgHNR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:25 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9319C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:24 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id v8so3419978wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G1m+mBc5DHN9N1yWiSk6nb4X2zq+d5nDMgJyTLNPPRc=;
        b=iN00ACnXSigVftuw0EX8zS6BlCZnflPn/Q/U+4zt3OGmV18sNHa8QInILgUE3bS1S3
         +uaZ0yTubCRhMfO57RaPHcuTDWncpDx0+fuTlmzvwx/KHz0kyKif5pbWIpihjJ7pDOyI
         FkHIfnJt0HsbPI80RU8DfmVLmHCInLIlVsNUFfjboDUt80RBuDkFyDZt2ZqnFr7TOSWK
         VaVuQLtjwRVXX69n6Y9ra/d6a1d8BAdl8bpvGHA14kF8zqvCgMUPZr68ys/Y3JBy/FAA
         kk3ZPayQN2mg/AatquaXwle9h+/8OfNC1Bo52nN96Tf9POfPQHBPOCHfs9K+l84SbCvP
         E6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G1m+mBc5DHN9N1yWiSk6nb4X2zq+d5nDMgJyTLNPPRc=;
        b=p+dmjb/KITiHLVRWLMmQzufO2SCn6wRGGL/RzRWkMQ0hX7Z+l4aQVG6hqbF0H8IpeS
         oyKSAbW3yVmX/8+GnN8cTGxFNWAaN0ivjtMK93CNUgXdSCQTTkZsI7krHAooLmlDyc8o
         KC1CNxgHq3/ADNYlOwVAsLw1zROpZK7pQciCx8BIs+Si0NIsWhaikmJOEmbcA3wK/Avh
         a6LBwLpsuGlKbP4TZ8S+WI6UCp61BwXE9TkW+o3rPQLQMI/FfC+4jyB/AzkRuAgRgUBI
         9pfOhWwACb6l+QWrLkMyTu7+5XyAYMEm2JMMxEYgSizWWj0tvlKulqkQAYa8SWkfeoOV
         ueHQ==
X-Gm-Message-State: AOAM5323WFcEyjaOazs+voe2ICUdTKYpKdQK8CkpyXcM2rc+DN/3ryDR
        b388NzZ1gmRukBjbfP7ukV9hLD9PbchFBYjY
X-Google-Smtp-Source: ABdhPJwmPyfcBdf/Nisj5qqVZNt2nZ+O/Vnc7pjOKCV5aU3t/ELZ7Z9s59RcLiYOKvcmEwq9jb4R/mo0VgSbpBiG
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr3400306wmy.15.1597426103272;
 Fri, 14 Aug 2020 10:28:23 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:07 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <8a499341bbe4767a4ee1d3b8acb8bd83420ce3a5.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 25/35] kasan: introduce CONFIG_KASAN_HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a configuration option for a new KASAN mode called
hardware tag-based KASAN. This mode uses the memory tagging approach
like the software tag-based mode, but relies on arm64 Memory Tagging
Extension feature for tag management and access checking.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/Kconfig.kasan | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index e500c18cbe79..0d4160ce5ee8 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -6,7 +6,10 @@ config HAVE_ARCH_KASAN
 config HAVE_ARCH_KASAN_SW_TAGS
 	bool
 
-config	HAVE_ARCH_KASAN_VMALLOC
+config HAVE_ARCH_KASAN_HW_TAGS
+	bool
+
+config HAVE_ARCH_KASAN_VMALLOC
 	bool
 
 config CC_HAS_KASAN_GENERIC
@@ -20,10 +23,11 @@ config CC_HAS_WORKING_NOSANITIZE_ADDRESS
 
 menuconfig KASAN
 	bool "KASAN: runtime memory debugger"
-	depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
-		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
+	depends on (((HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
+		     (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) && \
+		    CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
+		   HAVE_ARCH_KASAN_HW_TAGS
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
-	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
 	select STACKDEPOT
@@ -38,13 +42,18 @@ choice
 	prompt "KASAN mode"
 	default KASAN_GENERIC
 	help
-	  KASAN has two modes: generic KASAN (similar to userspace ASan,
-	  x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC) and
-	  software tag-based KASAN (a version based on software memory
-	  tagging, arm64 only, similar to userspace HWASan, enabled with
-	  CONFIG_KASAN_SW_TAGS).
+	  KASAN has three modes:
+	  1. generic KASAN (similar to userspace ASan,
+	     x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC),
+	  2. software tag-based KASAN (arm64 only, based on software
+	     memory tagging (similar to userspace HWASan), enabled with
+	     CONFIG_KASAN_SW_TAGS), and
+	  3. hardware tag-based KASAN (arm64-only, based hardware
+	     memory tagging (MTE), enabled with CONFIG_KASAN_HW_TAGS).
+
+	  All KASAN modes are strictly debugging features.
 
-	  Both generic and tag-based KASAN are strictly debugging features.
+	  For better error detection enable CONFIG_STACKTRACE.
 
 config KASAN_GENERIC
 	bool "Generic mode"
@@ -61,8 +70,6 @@ config KASAN_GENERIC
 	  and introduces an overhead of ~x1.5 for the rest of the allocations.
 	  The performance slowdown is ~x3.
 
-	  For better error detection enable CONFIG_STACKTRACE.
-
 	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
 	  (the resulting kernel does not boot).
 
@@ -83,15 +90,25 @@ config KASAN_SW_TAGS
 	  casting and comparison, as it embeds tags into the top byte of each
 	  pointer.
 
-	  For better error detection enable CONFIG_STACKTRACE.
-
 	  Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
 	  (the resulting kernel does not boot).
 
+config KASAN_HW_TAGS
+	bool "Hardware tag-based mode"
+	depends on HAVE_ARCH_KASAN_HW_TAGS
+	depends on SLUB
+	help
+	  Enables hardware tag-based KASAN mode.
+
+	  This mode requires both Memory Tagging Extension and Top Byte Ignore
+	  support by the CPU and therefore is only supported for modern arm64
+	  CPUs (MTE added in ARMv8.5 ISA).
+
 endchoice
 
 choice
 	prompt "Instrumentation type"
+	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	default KASAN_OUTLINE
 
 config KASAN_OUTLINE
@@ -115,6 +132,7 @@ endchoice
 
 config KASAN_STACK_ENABLE
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
+	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	help
 	  The LLVM stack address sanitizer has a know problem that
 	  causes excessive stack usage in a lot of functions, see
-- 
2.28.0.220.ged08abb693-goog

