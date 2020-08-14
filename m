Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5562420855
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPcBQTWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgHNRag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgHNR1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:27:46 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885C0C061386
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:45 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id c124so3433418wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=np+YjQo4chu4bS0e//GH8nyclC7wFRenYBsdsyZN+zk=;
        b=pPcBQTWcc0pB+A1Qkgyg36kQKBhw6A/0CZ5PXyKV9kUI5he4/+mJy2m/2Z2DVjNjII
         8UZtagmk1MICeu1fM9xQeBBKEXfd3Q/Af6l1AhqGnW02K5SLJndTbN6hxWqsI5U75N/D
         bQVQGpbGqdhv5DDR8Q8C7NbIZhVU0qqjL054jTmF2xIVXVxSE/2IRAn+gYyvT6WL8YIJ
         HVPEqgkP1vHe3O8MQLU1DuWBLaG3kzbf0CtyRYJ4WbL1tBvFoKr0I2IWdVa5PiLx/gA4
         3vm0svprRoNvMg/ImX3wCNl4HgPmXhS6H9WFhvChpekjkLznqiC2BXgy2tmf0g63pXLy
         iKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=np+YjQo4chu4bS0e//GH8nyclC7wFRenYBsdsyZN+zk=;
        b=QnY+k+nt8WoKkLGmEPDnZTIU4xZXjOUnlSeE2Sx1B14ZiAlW8KpyjwKIKFYR6l9ic9
         A8aH3zLAsMJL4ki+c2GbLH3LwYffAhsnmgt+p35V8yYEsoXlt7JzINbAHb0wdB0o43du
         sBcniE7+10KQt/jJk5o7SdyC4PDw/R8o15li7zJgTBAJrX59I7sapmgX9s+i54S0MR+q
         RcASlGYfyS02vbYRmJ88Ii4Zh42Oo/4lEZQgLUuY6KDb0usEw9lxaix74sASBS4leF1f
         3P7p5yb7asyqavsr1WX5Abn1ZYi36h+RJ8aEQREeKjruI5S+TGq75lRuSiamkOQqxk4b
         EY9w==
X-Gm-Message-State: AOAM533Mo2PymPpxcWpUAL1wGckoPaMiLK5KMXaCO2HuT6V8EmU0/Yjb
        KLQFUGDmmaO/ohO7TjeqQ/GHWQeVK9BuQpzW
X-Google-Smtp-Source: ABdhPJxMdFS/yNyg4MwjTnWmhaQzL0z42GnjWIS4vVb2p1bJE9xvcCYCxX7TZZq23RaIt0i+3EFX9Qy944e9OQDZ
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr3553163wml.126.1597426064102;
 Fri, 14 Aug 2020 10:27:44 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:50 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <c628647bade1a8f80dca858b0c0fba74cfa08271.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 08/35] kasan: rename generic/tags_report.c files
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

Rename generic_report.c to report_generic.c and tags_report.c to
report_tags.c, as their content is more relevant to report.c file,
then to generic.c or tags.c.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/Makefile                               | 12 ++++++------
 mm/kasan/report.c                               |  2 +-
 mm/kasan/{generic_report.c => report_generic.c} |  0
 mm/kasan/{tags_report.c => report_tags.c}       |  0
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename mm/kasan/{generic_report.c => report_generic.c} (100%)
 rename mm/kasan/{tags_report.c => report_tags.c} (100%)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 40366d706b7c..007c824f6f43 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -6,13 +6,13 @@ KCOV_INSTRUMENT := n
 # Disable ftrace to avoid recursion.
 CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_generic.o = $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_generic_report.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_quarantine.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_report_generic.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_report_tags.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_shadow.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_tags.o = $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
 
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
@@ -23,14 +23,14 @@ CC_FLAGS_KASAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
 
 CFLAGS_common.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
-CFLAGS_generic_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_init.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_report_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
+CFLAGS_report_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
-CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 
 obj-$(CONFIG_KASAN) := common.o report.o
-obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o generic_report.o shadow.o quarantine.o
-obj-$(CONFIG_KASAN_SW_TAGS) += init.o shadow.o tags.o tags_report.o
+obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
+obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_tags.o shadow.o tags.o
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 7c025d792e2f..f16591ba9e2e 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * This file contains common generic and tag-based KASAN error reporting code.
+ * This file contains common KASAN error reporting code.
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
diff --git a/mm/kasan/generic_report.c b/mm/kasan/report_generic.c
similarity index 100%
rename from mm/kasan/generic_report.c
rename to mm/kasan/report_generic.c
diff --git a/mm/kasan/tags_report.c b/mm/kasan/report_tags.c
similarity index 100%
rename from mm/kasan/tags_report.c
rename to mm/kasan/report_tags.c
-- 
2.28.0.220.ged08abb693-goog

