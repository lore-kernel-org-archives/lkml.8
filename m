Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD58C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E491205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiYty1LL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgELPdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgELPda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:33:30 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BECC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:33:30 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id j21so14482062qtq.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A/fbgfde0XyUO2F69Y6u/rjH6iJE5L1jOqri/XRSNJ0=;
        b=OiYty1LLPBdF9b+KHB2sQJZthi1uyyrFmJ6OMV73nN6Q4lo54stAQRQor8jfW6sCTc
         Jheo5t2EO42la+M4i9sc+hkE2rA0GvVjYQW+u2Ro5JHiTuqnwlRxa48GOgySDwPYN2pO
         0um6Tqg+blJsLtI3JQoZagq1/RzZUhQJAtGJAw7FaMgUayoENLooHv95+lY4HSRXOoaB
         4NZri7zOA151tsPJXto8ruKSn0FfIwd4lE/J99eya7bghAXMNfVgwJ5LmfYGuJwZ3S6f
         wRNrqXxmmplHDmwdfu1lTsk4RudKLZ4YASyfO+XQqb0GZy+W3yaEpGVRM++vy/lP64E4
         ossg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A/fbgfde0XyUO2F69Y6u/rjH6iJE5L1jOqri/XRSNJ0=;
        b=uIaQlpWgxYlhIF+2xiLfbGQtXKrmj858tSKV5NWwJwAsRYUg4bMVdN2AE+T1gUReSz
         UqgQybTBpdwkJcx2uilHJ4xAGzkQ56a/eAYNKYkDREEcUs48YxP4gBXAooBwZhceDf5c
         02YEsVe4nBerCdeyCUu+9DL6h17lJ7lLG8x+qF6/RmZ5E/Tt7y2zxXmcaZlLcL3cgxbn
         iAya6TM8/Cvgt5tOY8NoJvnCTYHSP2aTSxQ4zxqHjxLl6yKAjwYX8loppnPbHcTplBoZ
         bBOm+1GzNrm5CLvPR0cjGuCdgeUYiEQI748vnQn8QG6eezJxqtV36h/ehkWu1QvBSUMB
         IA7w==
X-Gm-Message-State: AGi0PuYFLu6XFmg+Lmmov/zpIPErkgtYLpC1PYqVJL6EZMyhb6p2stT9
        xKC5/YpLgDPK8jy9bYv8nzm0wkpimN/SnfwS
X-Google-Smtp-Source: APiQypIERxlPnFV/TJVvio2/Q0FI1L3ad5PuT996yCjeBj3CqaKpCQfb+sN8sSbhvhX0uf7wDrrwnvfEFDCph/jL
X-Received: by 2002:a05:6214:1812:: with SMTP id o18mr21635775qvw.64.1589297609674;
 Tue, 12 May 2020 08:33:29 -0700 (PDT)
Date:   Tue, 12 May 2020 17:33:21 +0200
In-Reply-To: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
Message-Id: <45b445a76a79208918f0cc44bfabebaea909b54d.1589297433.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 3/3] kasan: add missing functions declarations to kasan.h
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

KASAN is currently missing declarations for __asan_report* and
__hwasan* functions. This can lead to compiler warnings.

Reported-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index e8f37199d885..cfade6413528 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -212,8 +212,6 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 asmlinkage void kasan_unpoison_task_stack_below(const void *watermark);
 void __asan_register_globals(struct kasan_global *globals, size_t size);
 void __asan_unregister_globals(struct kasan_global *globals, size_t size);
-void __asan_loadN(unsigned long addr, size_t size);
-void __asan_storeN(unsigned long addr, size_t size);
 void __asan_handle_no_return(void);
 void __asan_alloca_poison(unsigned long addr, size_t size);
 void __asan_allocas_unpoison(const void *stack_top, const void *stack_bottom);
@@ -228,6 +226,8 @@ void __asan_load8(unsigned long addr);
 void __asan_store8(unsigned long addr);
 void __asan_load16(unsigned long addr);
 void __asan_store16(unsigned long addr);
+void __asan_loadN(unsigned long addr, size_t size);
+void __asan_storeN(unsigned long addr, size_t size);
 
 void __asan_load1_noabort(unsigned long addr);
 void __asan_store1_noabort(unsigned long addr);
@@ -239,6 +239,21 @@ void __asan_load8_noabort(unsigned long addr);
 void __asan_store8_noabort(unsigned long addr);
 void __asan_load16_noabort(unsigned long addr);
 void __asan_store16_noabort(unsigned long addr);
+void __asan_loadN_noabort(unsigned long addr, size_t size);
+void __asan_storeN_noabort(unsigned long addr, size_t size);
+
+void __asan_report_load1_noabort(unsigned long addr);
+void __asan_report_store1_noabort(unsigned long addr);
+void __asan_report_load2_noabort(unsigned long addr);
+void __asan_report_store2_noabort(unsigned long addr);
+void __asan_report_load4_noabort(unsigned long addr);
+void __asan_report_store4_noabort(unsigned long addr);
+void __asan_report_load8_noabort(unsigned long addr);
+void __asan_report_store8_noabort(unsigned long addr);
+void __asan_report_load16_noabort(unsigned long addr);
+void __asan_report_store16_noabort(unsigned long addr);
+void __asan_report_load_n_noabort(unsigned long addr, size_t size);
+void __asan_report_store_n_noabort(unsigned long addr, size_t size);
 
 void __asan_set_shadow_00(const void *addr, size_t size);
 void __asan_set_shadow_f1(const void *addr, size_t size);
@@ -247,4 +262,19 @@ void __asan_set_shadow_f3(const void *addr, size_t size);
 void __asan_set_shadow_f5(const void *addr, size_t size);
 void __asan_set_shadow_f8(const void *addr, size_t size);
 
+void __hwasan_load1_noabort(unsigned long addr);
+void __hwasan_store1_noabort(unsigned long addr);
+void __hwasan_load2_noabort(unsigned long addr);
+void __hwasan_store2_noabort(unsigned long addr);
+void __hwasan_load4_noabort(unsigned long addr);
+void __hwasan_store4_noabort(unsigned long addr);
+void __hwasan_load8_noabort(unsigned long addr);
+void __hwasan_store8_noabort(unsigned long addr);
+void __hwasan_load16_noabort(unsigned long addr);
+void __hwasan_store16_noabort(unsigned long addr);
+void __hwasan_loadN_noabort(unsigned long addr, size_t size);
+void __hwasan_storeN_noabort(unsigned long addr, size_t size);
+
+void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size);
+
 #endif
-- 
2.26.2.645.ge9eca65c58-goog

