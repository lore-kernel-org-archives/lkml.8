Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55695C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C9320736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBMVtnmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgELPd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgELPd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:33:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258F4C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:33:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x13so15897818ybg.23
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZV8IIs+LNNWl9Sq9YiRd+Sff9ry91f64w9KGyz/EsLo=;
        b=wBMVtnmpQnPmN132/EMY5FMlBGOhjwBX5RVXt4gNjeJGB9tsrz28CNfsJ9EIwua7YP
         +mfVf+iVOyihT5aCxrJgZdq3MnziZ/ENskuXaeqKCWb3MG6IeznpzGDa5xKnphLheJ9d
         nIzYCju6ZLWChECHr01pTRc++aLybxgm/kgW5sFDvc+5v633EqDmwuQh0s37mXnw4UBC
         GveSmPvFhf6A+H28sEgr1GyW+YrW9tw/wIRIHFFcvl0twf/sjidwEF8pPyJWtJ0h6bOc
         9QS4/hHm0hJE+jM3+LnpY2XdS27tGJrbUOgA2Iu0/ex2/D4S538OcGrsQdnMYhAPhLCl
         wXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZV8IIs+LNNWl9Sq9YiRd+Sff9ry91f64w9KGyz/EsLo=;
        b=FOOPXMoMMXxTm7Ez5sqjLHOb/FgYhk+RvVQ/ZJTwNQd6pUyf3Gdb+Ow4bErCYjZ2QF
         ZHgguKooSHd6QB8yGfm6VO19snx7A6isisXq2WxtJ9lkE65oBBiKP/rcy3Hx2AgRDpO0
         Zr8o+T9Ou1BR9mgIJGGHVUsmwg8YSZcdEuLtD8xJjzaRPHTmhoIo7PSGV+UIzXqoa62q
         IA8TWMUusV9iBJ6LAtQw9iWMkNaODQXVkj1gpnm1an+yuIZTOPXw+/22O4fcQDb/zEA2
         Oc7T18k1b+2VnWIwttCDWdSlN39RNpVmou8Pc8/JuIoQhlBYxn7z3jzF5CJ6+HmEO+rz
         f4xw==
X-Gm-Message-State: AGi0PuZlXlXdbv+N4/sBaDadoB7zipzmtnli+XToq8pC1jPppF7ZZdqP
        rQg6JfPlPDd/6sSh3XLd8WKdtITiWzMhVaBP
X-Google-Smtp-Source: APiQypLpeM3Ctza7tPnGaYL142tzszKoydpHlirGrJZZig9qbR7Yi4IhmihdklPUhQY1jTay1tgzcNbWP1CqOKhB
X-Received: by 2002:a5b:2ca:: with SMTP id h10mr28140141ybp.37.1589297607322;
 Tue, 12 May 2020 08:33:27 -0700 (PDT)
Date:   Tue, 12 May 2020 17:33:20 +0200
In-Reply-To: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
Message-Id: <78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 2/3] kasan: move kasan_report() into report.c
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kasan_report() functions belongs to report.c, as it's a common
functions that does error reporting.

Reported-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 19 -------------------
 mm/kasan/report.c | 22 ++++++++++++++++++++--
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 2906358e42f0..757d4074fe28 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -33,7 +33,6 @@
 #include <linux/types.h>
 #include <linux/vmalloc.h>
 #include <linux/bug.h>
-#include <linux/uaccess.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
@@ -613,24 +612,6 @@ void kasan_free_shadow(const struct vm_struct *vm)
 }
 #endif
 
-extern void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip);
-extern bool report_enabled(void);
-
-bool kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
-{
-	unsigned long flags = user_access_save();
-	bool ret = false;
-
-	if (likely(report_enabled())) {
-		__kasan_report(addr, size, is_write, ip);
-		ret = true;
-	}
-
-	user_access_restore(flags);
-
-	return ret;
-}
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 static bool shadow_mapped(unsigned long addr)
 {
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 80f23c9da6b0..51ec45407a0b 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -29,6 +29,7 @@
 #include <linux/kasan.h>
 #include <linux/module.h>
 #include <linux/sched/task_stack.h>
+#include <linux/uaccess.h>
 
 #include <asm/sections.h>
 
@@ -454,7 +455,7 @@ static void print_shadow_for_address(const void *addr)
 	}
 }
 
-bool report_enabled(void)
+static bool report_enabled(void)
 {
 	if (current->kasan_depth)
 		return false;
@@ -479,7 +480,8 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	end_report(&flags);
 }
 
-void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
+static void __kasan_report(unsigned long addr, size_t size, bool is_write,
+				unsigned long ip)
 {
 	struct kasan_access_info info;
 	void *tagged_addr;
@@ -518,6 +520,22 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
 	end_report(&flags);
 }
 
+bool kasan_report(unsigned long addr, size_t size, bool is_write,
+			unsigned long ip)
+{
+	unsigned long flags = user_access_save();
+	bool ret = false;
+
+	if (likely(report_enabled())) {
+		__kasan_report(addr, size, is_write, ip);
+		ret = true;
+	}
+
+	user_access_restore(flags);
+
+	return ret;
+}
+
 #ifdef CONFIG_KASAN_INLINE
 /*
  * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
-- 
2.26.2.645.ge9eca65c58-goog

