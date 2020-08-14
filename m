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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4B3C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026CD20791
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNwZunoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgHNR1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgHNR1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:27:50 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2941EC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id j8so6517978qvu.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1rxlsTFeHZWa6ONOeuQ+mv6OBF5H+hBIiaZ8LmsUVlw=;
        b=aNwZunoi3mHHGlkooltBIe1Qkubi/Wo4oN/aIQ8lJRAMl5UdW3bTgJ7rzr67Ve3nb9
         NmIv70kXBmf9zj7wn/wHi1N+LQlkhMMIAhFqieQWyYW0N8bY+pORzmxtURdzki0k4eXa
         7jMkkdZvld9iNJ6dSN1lwxzvAL+ufKxNXVbH6ohxLnW5O6OdvxyRZ/5SQvizoh0g0U6b
         PWK5aOsiCFlMDuHtC5AhpdDaMonU4i2ODCGn6wtzxS0yoh4RG/AmFrygZ2yS/xZRPhth
         RpX6GO6SuWsFFoAVqp3S1UBnm51SNGIhYykTHVzhrTqcmklo+ppF2q0ZpFwCl2fGiFR6
         puPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1rxlsTFeHZWa6ONOeuQ+mv6OBF5H+hBIiaZ8LmsUVlw=;
        b=Q+xsYHpBPIge5PrJG8bpxoUyrIUldl+dWVgWSc80onhuNNArkOLktuVAir+X+7TeC5
         VZV7XCsescpxlkkmpAEoa2B6Ldv4bB6PBqq1wSiT5gbdmjO/r6e1nOvyiUQFROhNg9Lh
         1Nvpl9Xs1PIwsAXDKoViTtWDZwR2692s4qdCGb3/uHR3fd1PG0ilBJlrupUyFSw09qAV
         ASIga0Jyn1A+65FpMdi9tKEwJl29jw5KUZT/0EjJwFR62j92mfQnAKXdnPn4Z5XdkLkV
         NyEkNwNboQcmHmXK0exZyHvlNP+D9gpMqcEgex5W8j4NGUXz58s7Uh72TTv678S0dIVV
         5lnQ==
X-Gm-Message-State: AOAM533F4jx6hIpqBaXtmZOvGaYooKD37zw2VI+zZIUuhbdn3RG3VTiX
        kdaCMdUK+uytJI6+OsYELKstXUiyIm4WLu7A
X-Google-Smtp-Source: ABdhPJy/gdFog9RJ52TaUpDFLL7rB+IrSCdsGbxbhfQp7k8XhqJjvVdS5NHx1ANpYjQ7pe2eSAgalurK612nOYGV
X-Received: by 2002:ad4:40cb:: with SMTP id x11mr3720078qvp.176.1597426068373;
 Fri, 14 Aug 2020 10:27:48 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:52 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <5a3f6b39567f2b7270e8d45bf1b909796259d3d1.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 10/35] kasan: hide invalid free check implementation
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

For software KASAN modes the check is based on the value in the shadow
memory. Hardware tag-based KASAN won't be using shadow, so hide the
implementation of the check in check_invalid_free().

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c  | 19 +------------------
 mm/kasan/generic.c |  7 +++++++
 mm/kasan/kasan.h   |  2 ++
 mm/kasan/tags.c    | 12 ++++++++++++
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 43a927e70067..a2321d35390e 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -277,25 +277,9 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
 	return (void *)object;
 }
 
-static inline bool shadow_invalid(u8 tag, s8 shadow_byte)
-{
-	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
-		return shadow_byte < 0 ||
-			shadow_byte >= KASAN_GRANULE_SIZE;
-
-	/* else CONFIG_KASAN_SW_TAGS: */
-	if ((u8)shadow_byte == KASAN_TAG_INVALID)
-		return true;
-	if ((tag != KASAN_TAG_KERNEL) && (tag != (u8)shadow_byte))
-		return true;
-
-	return false;
-}
-
 static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 			      unsigned long ip, bool quarantine)
 {
-	s8 shadow_byte;
 	u8 tag;
 	void *tagged_object;
 	unsigned long rounded_up_size;
@@ -314,8 +298,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
 		return false;
 
-	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
-	if (shadow_invalid(tag, shadow_byte)) {
+	if (check_invalid_free(tagged_object)) {
 		kasan_report_invalid_free(tagged_object, ip);
 		return true;
 	}
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index f6d68aa9872f..73f4d786ad5d 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -192,6 +192,13 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 	return check_memory_region_inline(addr, size, write, ret_ip);
 }
 
+bool check_invalid_free(void *addr)
+{
+	s8 shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
+
+	return shadow_byte < 0 || shadow_byte >= KASAN_GRANULE_SIZE;
+}
+
 void kasan_cache_shrink(struct kmem_cache *cache)
 {
 	quarantine_remove_cache(cache);
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index c31e2c739301..cf6a135860f2 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -163,6 +163,8 @@ void kasan_poison_memory(const void *address, size_t size, u8 value);
 bool check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip);
 
+bool check_invalid_free(void *addr);
+
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 4d5a1fe8251f..feb42c1763b8 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -126,6 +126,18 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 	return true;
 }
 
+bool check_invalid_free(void *addr)
+{
+	u8 tag = get_tag(addr);
+	u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(reset_tag(addr)));
+
+	if (shadow_byte == KASAN_TAG_INVALID)
+		return true;
+	if (tag != KASAN_TAG_KERNEL && tag != shadow_byte)
+		return true;
+	return false;
+}
+
 #define DEFINE_HWASAN_LOAD_STORE(size)					\
 	void __hwasan_load##size##_noabort(unsigned long addr)		\
 	{								\
-- 
2.28.0.220.ged08abb693-goog

