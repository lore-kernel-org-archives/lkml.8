Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74584C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF33206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4BZ4MPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgFDF60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 01:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgFDF6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 01:58:25 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5717FC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 22:58:24 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id h49so4023523qtk.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 22:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Y2WghFK4jI/68L/mvE2beXccHpF2A1uuR6W3fE75YUg=;
        b=I4BZ4MPdBo2uX0tbKFL94CWes+/vNUuGU1U4ZGPUlplte8++cmxNohRBeY1dkqVjsU
         XEdGTMQa2FE2DClh5hcYEXF7E4G5+z82QTgt8Nu81DvEU+u0oc4vrIVZj0XaaUz240To
         HLDVBomzbk2Kesk+FmhAx3/3arCT+kimjgC+sU7F1FMD4XLoPGI2PftvM0jQO9zehi26
         Chn+o/lGDD1dQYQf4NqID53ua5Q6sqz8u7fP6OkwYryvEbGk9FpUtGeFB4VtSb3Hswzx
         ZxQUrx0HarJ6UhNocHEtZoZebF6q2ffpPSvc9xgf05POXb4NMh6EI9k+WPNnInjF7VSg
         qCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Y2WghFK4jI/68L/mvE2beXccHpF2A1uuR6W3fE75YUg=;
        b=YiflNuHCq3fsSqqgD/4uNUsx/OqBxUJJYOdvwlFceCv8A86clAVMB4PF37sLXgpnYi
         foBIZ2nFcbvTqS1VAxCT7inX1GMjPWzUly4zk7GUVGritG4rKMjdPt1L4Z3gtLyOZhjG
         trRllyDSS0ENXJ9lNcuFhgkKUMqDsAsTiHCUeX9on1I5V7B+5kv1XEjb1s00owYOplB8
         j+5rM3P0/IqIfv7qZGXpJIyeFif67eo7hIIJlZAQie5NXiSXy2eoASm/w3jd16NWLkWg
         igZ/03S+eClFE/wi7Qdy2QtjS5DCYYAFmbximlnOySJkCtBsd2Lb+COKzuctjfAWM17V
         sNqg==
X-Gm-Message-State: AOAM533C1hbGfkLZaMph7e9WRZkNPBMm765i+rvFP/n8FMvXK9DepmEg
        homioLlmMY8/b7cqiq+v2uCI37JKpA==
X-Google-Smtp-Source: ABdhPJzdzg5S18qhTPxSvMHohJpK99cpsf7p2wmwX9WCwjv9XZyFLdswgdKoAMdjLXFmqknA8ncwX5I+XQ==
X-Received: by 2002:a05:6214:1842:: with SMTP id d2mr3212300qvy.197.1591250303486;
 Wed, 03 Jun 2020 22:58:23 -0700 (PDT)
Date:   Thu,  4 Jun 2020 07:58:10 +0200
Message-Id: <20200604055811.247298-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH -tip v2 1/2] kasan: Bump required compiler version
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     will@kernel.org, peterz@infradead.org, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org,
        clang-built-linux@googlegroups.com, paulmck@kernel.org,
        dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds config variable CC_HAS_WORKING_NOSANITIZE_ADDRESS, which will be
true if we have a compiler that does not fail builds due to
no_sanitize_address functions. This does not yet mean they work as
intended, but for automated build-tests, this is the minimum
requirement.

For example, we require that __always_inline functions used from
no_sanitize_address functions do not generate instrumentation. On GCC <=
7 this fails to build entirely, therefore we make the minimum version
GCC 8.

Link: https://lkml.kernel.org/r/20200602175859.GC2604@hirez.programming.kicks-ass.net
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
Apply after:
https://lkml.kernel.org/r/20200602173103.931412766@infradead.org

v2:
* No longer restrict UBSAN (and KCSAN), since the attributes behave
  differently for different sanitizers. For UBSAN the above case with GCC
  <= 7 actually works fine (no compiler error). So it seems that only
  KASAN is affected by this -- let's limit our restriction to KASAN.
---
 lib/Kconfig.kasan | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 81f5464ea9e1..af0dd09f91e9 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -15,11 +15,15 @@ config CC_HAS_KASAN_GENERIC
 config CC_HAS_KASAN_SW_TAGS
 	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
 
+config CC_HAS_WORKING_NOSANITIZE_ADDRESS
+	def_bool !CC_IS_GCC || GCC_VERSION >= 80000
+
 config KASAN
 	bool "KASAN: runtime memory debugger"
 	depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
+	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.
-- 
2.27.0.rc2.251.g90737beb825-goog

