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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D1AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DE820708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k29AXaVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgHNR1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgHNR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:27:31 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC6C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:31 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id s4so3427915wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5tE8GLGo7vmJDiQkkrzIva7DqUQiT7j3QisIKP5hp8U=;
        b=k29AXaVlF0T/FkCI0V18F7tGLqyph9ZWjrkRy+Yp4GBF5QHuKk+1UDxiS0QGZwDhgr
         4mvkZJBn0Q2JKXiT1ET1DKNiGBup6NEAMQIlyuyloCrLoZ3VRrslYm3MHMm3K7/whnPr
         9Lw2RNicSPeGjrZKvfNn2Pc2JCdZ66nd7M7yNhPUS2r4uD1ZruLyog3OBuzT/llx4NLr
         +sKc6J6trviPUvnfKQP6OljfnJO1IpIl1vG1wQpGnJYQ/lZLT+kHZw/RQj4C3mgJl6CB
         n68guOZokpGmwMJ6vVczj2eOSvrb0qA/HV6ChduNS1X/RDXHfvbID5oVsfLmPimXvb0h
         rFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5tE8GLGo7vmJDiQkkrzIva7DqUQiT7j3QisIKP5hp8U=;
        b=NAkSpkhNmM6IPhnizNE4xrn01z07a4Pz2XpvIicC+3mttJKro8sO6Eob7x92oDxcvf
         MAi31jeRFivp4IAY9KT3z0g+47tbbSfagEALoGnj+AX/3CqdO6txjvf+PiKHzTQwD0C7
         o+xEzH0D8TT1rlSMWzTsxL6Uz+3Idp/Dw8GqeNastGxHD6sTvfhCvRk/MPFcE7ZjoTNl
         wvqDZnjxt+asl3zshIqx7BKZ3qATFBp24IQsqjpZBs6SukhspKGRYoYc5a+xZgDnbjD8
         7uVhOU7oYkT+2BPu9ZpW/E+Z/LzqSAxkgVvjWARuur62dYACQhKnIW2DiAv4clQT83jr
         sD0Q==
X-Gm-Message-State: AOAM5333+jfpbU4Tt5reEWXr/EUNPASTN1iqB5vC5eVjas+vMF70usq3
        /i8HbgwsDTzLKYzDbh0TenHaXb5qQH00qhiF
X-Google-Smtp-Source: ABdhPJySP4aGBaeyjTDPLPUCBIHwV36/swUURoIlekpxnyfJOrAdkKpfASLlmOWhIrMGIYGzLcDpspku5wwOXmYs
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr423861wmm.1.1597426048519;
 Fri, 14 Aug 2020 10:27:28 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:44 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <b8fbbb6078e50065c3942aefd5cbc83ee7bf9d0c.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 02/35] kasan: group vmalloc code
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

Group all vmalloc-related function declarations in include/linux/kasan.h,
and their implementations in mm/kasan/common.c.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 41 +++++++++++++----------
 mm/kasan/common.c     | 78 ++++++++++++++++++++++---------------------
 2 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 087fba34b209..bd5b4965a269 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -69,19 +69,6 @@ struct kasan_cache {
 	int free_meta_offset;
 };
 
-/*
- * These functions provide a special case to support backing module
- * allocations with real shadow memory. With KASAN vmalloc, the special
- * case is unnecessary, as the work is handled in the generic case.
- */
-#ifndef CONFIG_KASAN_VMALLOC
-int kasan_module_alloc(void *addr, size_t size);
-void kasan_free_shadow(const struct vm_struct *vm);
-#else
-static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
-static inline void kasan_free_shadow(const struct vm_struct *vm) {}
-#endif
-
 int kasan_add_zero_shadow(void *start, unsigned long size);
 void kasan_remove_zero_shadow(void *start, unsigned long size);
 
@@ -150,9 +137,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 	return false;
 }
 
-static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
-static inline void kasan_free_shadow(const struct vm_struct *vm) {}
-
 static inline int kasan_add_zero_shadow(void *start, unsigned long size)
 {
 	return 0;
@@ -205,13 +189,16 @@ static inline void *kasan_reset_tag(const void *addr)
 #endif /* CONFIG_KASAN_SW_TAGS */
 
 #ifdef CONFIG_KASAN_VMALLOC
+
 int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
 void kasan_poison_vmalloc(const void *start, unsigned long size);
 void kasan_unpoison_vmalloc(const void *start, unsigned long size);
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end);
-#else
+
+#else /* CONFIG_KASAN_VMALLOC */
+
 static inline int kasan_populate_vmalloc(unsigned long start,
 					unsigned long size)
 {
@@ -226,7 +213,25 @@ static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long end,
 					 unsigned long free_region_start,
 					 unsigned long free_region_end) {}
-#endif
+
+#endif /* CONFIG_KASAN_VMALLOC */
+
+#if defined(CONFIG_KASAN) && !defined(CONFIG_KASAN_VMALLOC)
+
+/*
+ * These functions provide a special case to support backing module
+ * allocations with real shadow memory. With KASAN vmalloc, the special
+ * case is unnecessary, as the work is handled in the generic case.
+ */
+int kasan_module_alloc(void *addr, size_t size);
+void kasan_free_shadow(const struct vm_struct *vm);
+
+#else /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
+
+static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
+static inline void kasan_free_shadow(const struct vm_struct *vm) {}
+
+#endif /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
 
 #ifdef CONFIG_KASAN_INLINE
 void kasan_non_canonical_hook(unsigned long addr);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 950fd372a07e..d1c987f324cd 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -541,44 +541,6 @@ void kasan_kfree_large(void *ptr, unsigned long ip)
 	/* The object will be poisoned by page_alloc. */
 }
 
-#ifndef CONFIG_KASAN_VMALLOC
-int kasan_module_alloc(void *addr, size_t size)
-{
-	void *ret;
-	size_t scaled_size;
-	size_t shadow_size;
-	unsigned long shadow_start;
-
-	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
-	scaled_size = (size + KASAN_SHADOW_MASK) >> KASAN_SHADOW_SCALE_SHIFT;
-	shadow_size = round_up(scaled_size, PAGE_SIZE);
-
-	if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
-		return -EINVAL;
-
-	ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
-			shadow_start + shadow_size,
-			GFP_KERNEL,
-			PAGE_KERNEL, VM_NO_GUARD, NUMA_NO_NODE,
-			__builtin_return_address(0));
-
-	if (ret) {
-		__memset(ret, KASAN_SHADOW_INIT, shadow_size);
-		find_vm_area(addr)->flags |= VM_KASAN;
-		kmemleak_ignore(ret);
-		return 0;
-	}
-
-	return -ENOMEM;
-}
-
-void kasan_free_shadow(const struct vm_struct *vm)
-{
-	if (vm->flags & VM_KASAN)
-		vfree(kasan_mem_to_shadow(vm->addr));
-}
-#endif
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 static bool shadow_mapped(unsigned long addr)
 {
@@ -690,6 +652,7 @@ core_initcall(kasan_memhotplug_init);
 #endif
 
 #ifdef CONFIG_KASAN_VMALLOC
+
 static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 				      void *unused)
 {
@@ -928,4 +891,43 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 				       (unsigned long)shadow_end);
 	}
 }
+
+#else /* CONFIG_KASAN_VMALLOC */
+
+int kasan_module_alloc(void *addr, size_t size)
+{
+	void *ret;
+	size_t scaled_size;
+	size_t shadow_size;
+	unsigned long shadow_start;
+
+	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
+	scaled_size = (size + KASAN_SHADOW_MASK) >> KASAN_SHADOW_SCALE_SHIFT;
+	shadow_size = round_up(scaled_size, PAGE_SIZE);
+
+	if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
+		return -EINVAL;
+
+	ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
+			shadow_start + shadow_size,
+			GFP_KERNEL,
+			PAGE_KERNEL, VM_NO_GUARD, NUMA_NO_NODE,
+			__builtin_return_address(0));
+
+	if (ret) {
+		__memset(ret, KASAN_SHADOW_INIT, shadow_size);
+		find_vm_area(addr)->flags |= VM_KASAN;
+		kmemleak_ignore(ret);
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+void kasan_free_shadow(const struct vm_struct *vm)
+{
+	if (vm->flags & VM_KASAN)
+		vfree(kasan_mem_to_shadow(vm->addr));
+}
+
 #endif
-- 
2.28.0.220.ged08abb693-goog

