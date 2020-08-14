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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50978C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C5C20768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NnWG0R80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgHNR1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgHNR1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:27:35 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A140C061386
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:34 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id gg11so3575516ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yqDvbJRB7ghhYUJnBffV6Wdevt15gkjdAFpaNJ5xwpI=;
        b=NnWG0R80eq9R1RVTHFiLH0+CbG24xMo/Pk8D6hlayJD6/jup0+WhQpn2FfApkw/OLH
         A63ofaKuhmI+m7v2+zIDRG9RtiQN+RQxrkKbeQwebMG1LRwJfphYfEQnq2+fGbTB4g4z
         0ar2+Of0emarFbHb/5bMHP0CN+28ZVQ9W+t+U5OB3hPR/CDoy7ZVdEn9RtcK63/ZFdkY
         s1zGYNIlG0CiuVOTUOXbquRYk/zS85v9JTfIXFwSdH8/mWbGe3nRg0LhqUaJ6IYnJ4n/
         CkC+dT3E3iHy6futQCIpKS3ojibi5A30STpXasKQQLHxZt/PMBf4G/RtJ2x3i91KcLxv
         91nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yqDvbJRB7ghhYUJnBffV6Wdevt15gkjdAFpaNJ5xwpI=;
        b=tEIu7YKLzniUoOWjvVUOOf/44ncH92/9HK2DAZ8CttxaLlL6axEak/KjWZbo7+smiK
         1530nK01nkllrPEt8eKtg1zNkfaz35n7AQ2gvHFo5Q8RhA0oRvw0jqVEbgwi5R1XCXTe
         Y25nmqKdYiS4MafEXLsjMRPLJBno2XtA6XkaLH9I+/141DxvDu5EgZEe5vkiKGv3Yup+
         VIW/sAp+8gBZzixS+e4slSauDfV6knv1Pqx8UlmPq3qmxIRVqIYAKt/qXkDppvobgLkl
         45TTiLRIQZSFPuLhgMA1/67Fe3YQ0hzGUPnzAqEV29Psc7tiKiVgfwb9cVPVZr65Oz2y
         NDkA==
X-Gm-Message-State: AOAM533qtcjtYpYBhvgAoKhA6jkms6Ese/AsdoqEO0j1TTz81YVD+6Of
        TuCi5R0fg8lF9QslcOoQAw8Jenz374oXh53m
X-Google-Smtp-Source: ABdhPJyJZIfoQU8kIAVBaHLf+CE/8nKps8LgSd0/B5y0ypQpapc4GyhKksQd0R944+AQ9wkt5psrYlbDykyLb/2S
X-Received: by 2002:a17:906:c7c8:: with SMTP id dc8mr3324691ejb.285.1597426051207;
 Fri, 14 Aug 2020 10:27:31 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:45 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <272b331db9919432cd6467a0bd5ce73ffc46fc97.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 03/35] kasan: shadow declarations only for software modes
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Group shadow-related KASAN function declarations and only define them
for the two existing software modes.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 44 ++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index bd5b4965a269..44a9aae44138 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -3,16 +3,24 @@
 #define _LINUX_KASAN_H
 
 #include <linux/types.h>
+#include <asm/kasan.h>
 
 struct kmem_cache;
 struct page;
 struct vm_struct;
 struct task_struct;
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 #include <linux/pgtable.h>
-#include <asm/kasan.h>
+
+/* Software KASAN implementations use shadow memory. */
+
+#ifdef CONFIG_KASAN_SW_TAGS
+#define KASAN_SHADOW_INIT 0xFF
+#else
+#define KASAN_SHADOW_INIT 0
+#endif
 
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
@@ -29,6 +37,23 @@ static inline void *kasan_mem_to_shadow(const void *addr)
 		+ KASAN_SHADOW_OFFSET;
 }
 
+int kasan_add_zero_shadow(void *start, unsigned long size);
+void kasan_remove_zero_shadow(void *start, unsigned long size);
+
+#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+static inline int kasan_add_zero_shadow(void *start, unsigned long size)
+{
+	return 0;
+}
+static inline void kasan_remove_zero_shadow(void *start,
+					unsigned long size)
+{}
+
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+#ifdef CONFIG_KASAN
+
 /* Enable reporting bugs after kasan_disable_current() */
 extern void kasan_enable_current(void);
 
@@ -69,9 +94,6 @@ struct kasan_cache {
 	int free_meta_offset;
 };
 
-int kasan_add_zero_shadow(void *start, unsigned long size);
-void kasan_remove_zero_shadow(void *start, unsigned long size);
-
 size_t __ksize(const void *);
 static inline void kasan_unpoison_slab(const void *ptr)
 {
@@ -137,14 +159,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 	return false;
 }
 
-static inline int kasan_add_zero_shadow(void *start, unsigned long size)
-{
-	return 0;
-}
-static inline void kasan_remove_zero_shadow(void *start,
-					unsigned long size)
-{}
-
 static inline void kasan_unpoison_slab(const void *ptr) { }
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
@@ -152,8 +166,6 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #ifdef CONFIG_KASAN_GENERIC
 
-#define KASAN_SHADOW_INIT 0
-
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 void kasan_record_aux_stack(void *ptr);
@@ -168,8 +180,6 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 #ifdef CONFIG_KASAN_SW_TAGS
 
-#define KASAN_SHADOW_INIT 0xFF
-
 void kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
-- 
2.28.0.220.ged08abb693-goog

