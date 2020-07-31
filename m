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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9728C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910B82245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jrdVI+Gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbgGaNUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgGaNUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:20:52 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A864FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 06:20:52 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id n12so2993050qtr.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RlSgKw0WaVPNPMJUtAR6IXtLReCVIjzNVv/S08XnLBI=;
        b=jrdVI+GqTxgA9hZqHbzpLWJLWfVIE9QekpGjHxYrEudEbxBY7QMNQrgeCpkUg5LkmQ
         eXTMUrrM/5o50zNnRTiTMrEbgBSzCPrS+pMt/VzDAYlQ5hCUWMO4rgrgTe9wTc9WzDjt
         yVVaBUGXvIkH2mXii1LTq5R7Uno85gLoAhxVhC0T9khb6ZyC/CxiqVjGFL0kCEJgWM9b
         YqUEgf3dPV+PFSiKBBVpNk3lA3vpAYlRBxZpzz0zqeFggEJfIlNh+f3r1HdJSfCwgC1C
         +2N6ukc3ohBjlfozUpubiwL1aaF1S5iNGuYk5jU44+NmYGYsEJ5/Q6eFNYxKJvg0pa5b
         VV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RlSgKw0WaVPNPMJUtAR6IXtLReCVIjzNVv/S08XnLBI=;
        b=qGzw8762BY1udklAy6KRb2EbalZlgb0zkta7RpB/B+4lwhuADGxsTIgXXC+dcXghwm
         oszLkg1pkcpfvOGNI0SaZeH3Bly+vTXldP3+fAszXfoya8jN4NtYCO+FIwlrlEOl5qfC
         4pUZeYLBlZPrb42G732PRr4iIaIdyd3vEI1kl8iyEJosY8H9gWzQ1JPhXbbPSsjec6oQ
         MBxK3tYKvh3opayhFRJxuPJmUcb5m0YQTsyogI0jLwom4A6h/5aqrIydSxu4v7aQ3HJI
         CYllkIIoLzFJNDUzJAu5VzKoxq6G7EqecdvyljzIIozWtdiRAhF14EBDHCVXoOvlL9m1
         ZjyQ==
X-Gm-Message-State: AOAM533Bz4RTIElzfBxDAf6wW5+8HTG+T3scKXZfhQgBB+H5yEyaFc6h
        IfZyyHsLTdfFyhKseiNxH7A5jLLGzV0mc6Ye
X-Google-Smtp-Source: ABdhPJx3HXBXn8SZsqgIUbyWhyba7Bd+WiRjFmLNSp8HElgnnStw91f4GBcwMeRt6NhnDO1hVA2GYUm2iS/Zt/i0
X-Received: by 2002:a0c:aac8:: with SMTP id g8mr4079969qvb.70.1596201651864;
 Fri, 31 Jul 2020 06:20:51 -0700 (PDT)
Date:   Fri, 31 Jul 2020 15:20:38 +0200
In-Reply-To: <cover.1596199677.git.andreyknvl@google.com>
Message-Id: <01c678b877755bcf29009176592402cdf6f2cb15.1596199677.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1596199677.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 1/4] kasan: don't tag stacks allocated with pagealloc
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prepares Software Tag-Based KASAN for stack tagging support.

With Tag-Based KASAN when kernel stacks are allocated via pagealloc
(which happens when CONFIG_VMAP_STACK is not enabled), they get tagged.
KASAN instrumentation doesn't expect the sp register to be tagged, and
this leads to false-positive reports.

Fix by resetting the tag of kernel stack pointers after allocation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/fork.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d03c9586d342..9cea2265e677 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -261,7 +261,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 					     THREAD_SIZE_ORDER);
 
 	if (likely(page)) {
-		tsk->stack = page_address(page);
+		tsk->stack = kasan_reset_tag(page_address(page));
 		return tsk->stack;
 	}
 	return NULL;
@@ -302,6 +302,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk,
 {
 	unsigned long *stack;
 	stack = kmem_cache_alloc_node(thread_stack_cache, THREADINFO_GFP, node);
+	stack = kasan_reset_tag(stack);
 	tsk->stack = stack;
 	return stack;
 }
-- 
2.28.0.163.g6104cc2f0b6-goog

