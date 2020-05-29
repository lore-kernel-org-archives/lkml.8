Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAEBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39CFF20723
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgFYRSTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgE2TMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE2TMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:12:31 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE04C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:12:30 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id j16so2724420qka.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Moz+9hZdr2Y6CaabpiR/TuFRSQrzGhwHDxQkw4rcCBs=;
        b=tgFYRSTNnV3spDr4H1Hi5Lfz0giFk/SJM09817593AOsdZr0x3XfEwFp0pByB16/aL
         3ksy0uFpH3BuJIe1W2lVsR+PXcblDTtV299uZ/FEc8JJall73SPiDPadl05vxkxQAhtZ
         zVrJKIQZGRhq6zzPlbTD1ZluJgL3pdGd2AleezNXcsawoidoQ8Plno0yZJirojigZ2o/
         awa0DWVAEtSuVxbgIXTTK9sS+uYbtSKrgbh/OfZSE2YAkPqCm6lKj3dg6nMXih5p+yZU
         amX0UVbzp7PG7p55p+j08qobTXncIzVDiIFGJdGawXOloI4Y5WHoQH5zN2g+FL+ocKDv
         53Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Moz+9hZdr2Y6CaabpiR/TuFRSQrzGhwHDxQkw4rcCBs=;
        b=XrjqsXYAuWdPd2TX9l7Z7j5UbA4c+a7VFoxrboRQ1rWpLajYaU3kW7+zQ3RxoxAslQ
         XVOylea5EODalk9hwEWPAy0JZ2rLgbjK3UaOPqTD298IjZjI42uwprEuGJzE8x1ldcaz
         gO37OJd9tO1V35K44spkNr7/rsnmWwCiZBZux16z1+1mkBtuhkmIvSPFZHZyp1/3C2RU
         f412lgza966nBP8Dl9D9qC5CqMqfKJG4aNSkBH+8AeaDSpv8puIAI2g6p+11vOk6m+so
         Af21SDepKB/HdiuORI+PL3dO+/Q8SU3CDtjB8T6SE11yBNMO/Jiyi1UHKEaKvJkhGjtX
         lirg==
X-Gm-Message-State: AOAM531eZEo8nPTlcPg6j9Mms21n0stR6Yuu73DM0nZg2NBMcEdt4J4B
        jKrDrl8SRTFiFjxUFF16pz11YDY9unkn4fbN
X-Google-Smtp-Source: ABdhPJx2b8wV6giO/jWiz+C5eY7dwhwCsd85SuheR7SnUNrgx7aJBfqCN+dnKFghPX+sokqHbYWhZSsDTl0065kF
X-Received: by 2002:a0c:e4d3:: with SMTP id g19mr9444906qvm.42.1590779549611;
 Fri, 29 May 2020 12:12:29 -0700 (PDT)
Date:   Fri, 29 May 2020 21:12:25 +0200
Message-Id: <c2f0c8e4048852ae014f4a391d96ca42d27e3255.1590779332.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2] kasan: fix clang compilation warning due to stack protector
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN uses a single cc-option invocation to disable both conserve-stack
and stack-protector flags. The former flag is not present in Clang, which
causes cc-option to fail, and results in stack-protector being enabled.

Fix by using separate cc-option calls for each flag. Also collect all
flags in a variable to avoid calling cc-option multiple times for
different files.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---

Changes v1 -> v2:
- Renamed CC_FLAGS_KASAN_CONFLICT to CC_FLAGS_KASAN_RUNTIME.

---
 mm/kasan/Makefile | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index de3121848ddf..d532c2587731 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -15,14 +15,19 @@ CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
 
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
-CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
-CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
-CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
-CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
-CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
-CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
-CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
-CFLAGS_tags_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector) -DDISABLE_BRANCH_PROFILING
+CC_FLAGS_KASAN_RUNTIME := $(call cc-option, -fno-conserve-stack)
+CC_FLAGS_KASAN_RUNTIME += $(call cc-option, -fno-stack-protector)
+# Disable branch tracing to avoid recursion.
+CC_FLAGS_KASAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
+
+CFLAGS_common.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_generic_report.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_init.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 
 obj-$(CONFIG_KASAN) := common.o init.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
-- 
2.27.0.rc0.183.gde8f92d652-goog

