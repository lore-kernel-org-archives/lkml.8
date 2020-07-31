Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2B6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC19020829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfWMXUHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbgGaIRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbgGaIRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:17:45 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802BFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:45 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id dl10so19880524qvb.20
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tNfU9OUwAoAvypXurhc04zFcnAktGmnq+u5MEjWOcsc=;
        b=GfWMXUHrUjBtH8cuuov+sPsTvOXVpluW4yvNJGPkfwtVF2l+3sStR6SSU8DLCUPgZa
         sK4CqLF1Jp0lNCgjtoN+FsiSBWw17O/TZO/LRUhBStT9xJBnAwg4Vjhm7Q8dgQqcsYnZ
         kmP6WKpoiFZjknSsaLXRZEvl4V1ImEPfUBxgsg+VPRGISwbdFttJohXvf1mZ/I/1MJQZ
         nNE1VbU/hpryBZwMpucAs0LLMa2+xVzTAxItO5cdx+05t/qr/+qOGCuclteApWW/q9Zw
         njWyNSWg/Jr7A4cR6vcMkQtqif62FsMZp9WVnGmdPw6iWiWWaizRKUVFbPZdU9YoC5ne
         jJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tNfU9OUwAoAvypXurhc04zFcnAktGmnq+u5MEjWOcsc=;
        b=qEFjFlgjnLFyHKbiXhWmVYQ77Uyjhpo8mp0ZXLTeFmCXo0AMLLrVOVgJ1syrvx0O7K
         okMELSNV0149sGtl7h/U2seTyW7nGtfP3aohZSZ3BmGDP4ZIFHIrUlIHqjXqi3I5NpEf
         VD0dEZqpsw4pjmZ484qvECQwsP/VAvDWX/tvDE0LlcO1FqxQKiiauIi6QHkRgi2cL6iJ
         YCNMBNnkztzR/lkcaQkLbmNtI4seL9eJOaPRy91jb1BhzcpQIhgr9XrUWp9gsTjdZVmZ
         5VC6Tu/6urPudT3sWdFqqEcgd+MgELOXlbKnWzbrBiZNutSq884ZST5Y+CVoSUI5W8Zq
         XQ+g==
X-Gm-Message-State: AOAM5303PCoVJx3fQzQEJr8n7HRj3iFlNjAiVyIfgPa1d5bxRhMbPQdj
        EhAWLci11sscT3G7T4aDM1MVE4RdKg==
X-Google-Smtp-Source: ABdhPJz/xHtU0OtEbI++u7uKwjpuw9mCw7u+UHcXVZHrPW4COPImLmNe4ARli2b9WVpP5UdvWT1x4pkUVw==
X-Received: by 2002:a0c:e30c:: with SMTP id s12mr2979100qvl.138.1596183464651;
 Fri, 31 Jul 2020 01:17:44 -0700 (PDT)
Date:   Fri, 31 Jul 2020 10:17:22 +0200
In-Reply-To: <20200731081723.2181297-1-elver@google.com>
Message-Id: <20200731081723.2181297-5-elver@google.com>
Mime-Version: 1.0
References: <20200731081723.2181297-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 4/5] kcsan: Show message if enabled early
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show a message in the kernel log if KCSAN was enabled early.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index e43a55643e00..23d0c4e4cd3a 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "kcsan: " fmt
+
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
@@ -442,7 +444,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 
 	if (IS_ENABLED(CONFIG_KCSAN_DEBUG)) {
 		kcsan_disable_current();
-		pr_err("KCSAN: watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
+		pr_err("watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
 		       is_write ? "write" : "read", size, ptr,
 		       watchpoint_slot((unsigned long)ptr),
 		       encode_watchpoint((unsigned long)ptr, size, is_write));
@@ -601,8 +603,10 @@ void __init kcsan_init(void)
 	 * We are in the init task, and no other tasks should be running;
 	 * WRITE_ONCE without memory barrier is sufficient.
 	 */
-	if (kcsan_early_enable)
+	if (kcsan_early_enable) {
+		pr_info("enabled early\n");
 		WRITE_ONCE(kcsan_enabled, true);
+	}
 }
 
 /* === Exported interface =================================================== */
-- 
2.28.0.163.g6104cc2f0b6-goog

