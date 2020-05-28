Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71288C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7DB207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxS6qz7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405534AbgE1RUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405353AbgE1RUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:20:34 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61253C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:20:34 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id dh11so8738067qvb.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0xESSglLWrwf3x8cJUVzOxtDGHF6QQgQ1x5DUGqwYW8=;
        b=cxS6qz7n7nK73o0Lj+qJGFAhUn+UOhTx6ZA+eY+Sg2neSU9N5rTgx2cQotnSgqWiOf
         03ok3uW7ESY94XpGrPatKYoKP0//btqhv2svqBYYeaLe4r2x99BBSIZ7WxImPQBYIP7y
         McCoCNjghMl+YGwgLyhEX8ZUIhXcEavFNjBq1UT8Y0FQ2Fes+WtrVkqCnwEO7kin8dRx
         kPjVfxBMsM0LRUcNtKA6NVJyNhDRWABotgLHqR/tzEju5e/KzbVV0fsA1XaLMpg7xZZc
         dqgxovGf7WprQk1BYrPge2Ch9VfYI+350LZRf3nB9xaz9Uh5DV0Tl0w1UbhtXkdbOTOs
         1Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0xESSglLWrwf3x8cJUVzOxtDGHF6QQgQ1x5DUGqwYW8=;
        b=kgr/4CkRyVNdVrYK5/b8TgKEG0Yr1hejTA8UvpuQeTC21AeODtxSIFlWetfnu+T31A
         yZO/Td56UUekFnA89jw+8shX2K7ciy5lTSEy2idEbq0ytRqvrPvJzjPTBDHftyrw1OIP
         ySOFWUQl3fZxgjxXg1WpS/SBjAEK7Lc55/Wsy1g0cwU45UNzWqdBoPfWT+bne538DTkT
         Sao1DtK1mAg3NSk6nfFVo9oz1IfNrrR+Ggn8weqWhdac1mIVYZu6YEtnV8iqJiYUaxKJ
         292VxjlSDNgkIeCDHyYdYZvnCAcfL1T98t5FkQgC/zDDQP5zvrEowLKL0p5omkcrV4Pw
         08kA==
X-Gm-Message-State: AOAM530De/z51EeqSu/edBPcni2D4wuI7dF1tFQUosro9HhAoYxQb045
        OSS0EWRYwKIUvAvxCj1K2SpxMUHu+SAiBntL
X-Google-Smtp-Source: ABdhPJxwa5ISh+kbTLHHgwv4Bzn0zVfZaYols4w+3NSmpBbER4mllDE+WJYDXGJia5vp6ey7tJX9kkm2WKJMx0OL
X-Received: by 2002:a0c:c3cf:: with SMTP id p15mr4264539qvi.10.1590686432904;
 Thu, 28 May 2020 10:20:32 -0700 (PDT)
Date:   Thu, 28 May 2020 19:20:29 +0200
Message-Id: <ced83584eec86a1a9ce264013cf6c0da5e0add6a.1590686292.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] kasan: fix clang compilation warning due to stack protector
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
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
 mm/kasan/Makefile | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index de3121848ddf..bf6f7b1f6b18 100644
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
+CC_FLAGS_KASAN_CONFLICT := $(call cc-option, -fno-conserve-stack)
+CC_FLAGS_KASAN_CONFLICT += $(call cc-option, -fno-stack-protector)
+# Disable branch tracing to avoid recursion.
+CC_FLAGS_KASAN_CONFLICT += -DDISABLE_BRANCH_PROFILING
+
+CFLAGS_common.o := $(CC_FLAGS_KASAN_CONFLICT)
+CFLAGS_generic.o := $(CC_FLAGS_KASAN_CONFLICT)
+CFLAGS_generic_report.o := $(CC_FLAGS_KASAN_CONFLICT)
+CFLAGS_init.o := $(CC_FLAGS_KASAN_CONFLICT)
+CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_CONFLICT)
+CFLAGS_report.o := $(CC_FLAGS_KASAN_CONFLICT)
+CFLAGS_tags.o := $(CC_FLAGS_KASAN_CONFLICT)
+CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_CONFLICT)
 
 obj-$(CONFIG_KASAN) := common.o init.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
-- 
2.27.0.rc0.183.gde8f92d652-goog

