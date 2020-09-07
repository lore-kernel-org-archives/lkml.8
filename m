Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF890C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC2120658
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="W3a/pmyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgIGRYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgIGNnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:43:17 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A90CC06179B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:41:26 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id w3so3984416wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sBEgph2pOr6CyODJ1uv8I0m4yR8SDTujVHr8yLlCuyo=;
        b=W3a/pmyA4RP9Ik4+QJ2hBf7+DdC59fjkdllmpsJW+SIiBQPN3kXyd9Kl+hHv33LAO8
         0Rl7721pKfQjoHvZg5qD3ApYcG4ud82WNSxk7OFQ5p/DRxsI/wc1hgGYCDwxpDPlrMau
         1vD8JshMZ5eXQ4eGdi+NX6QBfAAU1zXfaEEcd+/iPcOipwfLCv04EDrJPjCN2JfNQS2n
         hWtjfI6XY4eAGv7F9YdcWmMVOGPddTqLNehEiIxh84gokds7aOpJU/34ej4ZdtXwGqGd
         r7/F6AXB3t228e8XH01xJURnu3n83x2f94oZoI5f1Dg+cwUdzI69z9A1ttcD+jnYVWPP
         2ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sBEgph2pOr6CyODJ1uv8I0m4yR8SDTujVHr8yLlCuyo=;
        b=ieny7ZV2EE0QMteuIdJtM3ig43EBGJOqRIBoMfGrA/WlwmstvAq6KqO6b8tH+Iwupz
         9wT+Nw3FRcNgzvHXuRnCYqV8Fzu6NKKDeEfT0bVKHxYwkXJa7bHrXh0Mu3o6Lw8+6/Oh
         t2Bq1o+PwLMzQlTCDgzkPC2kldO9GCHsgbyth0kKC0EYEdxCv8MP9XTi3I2qkov0/DGx
         z6CHiPmo2sfCSZ/wW1VCm9GFTYHTXocC6WJVFfHS80aV66wS27DMBmgNnG+nZiRG9D/2
         fVda9+4M/u/v/PuXsjmSOQhgdp3b+dq3yWmME++QAYK6p/JbcwQXbUHvkblgw1BrxkV9
         +BWA==
X-Gm-Message-State: AOAM532SFGgKR+QbFA63LDV7FPm7pLWHzgqlyX0kZ6GVpsLG/2MNfn+1
        DWhMt97HEpjyxwGalAV/reOMdH85lA==
X-Google-Smtp-Source: ABdhPJxeJUaJi1Li1DPHii5Sj4LSLAplbFw0CU8QzsUMSMD+wpw59PJfS96CMu44VRwFFVbpHpJk5iEgwg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a7b:c019:: with SMTP id c25mr9339wmb.0.1599486083942;
 Mon, 07 Sep 2020 06:41:23 -0700 (PDT)
Date:   Mon,  7 Sep 2020 15:40:51 +0200
In-Reply-To: <20200907134055.2878499-1-elver@google.com>
Message-Id: <20200907134055.2878499-7-elver@google.com>
Mime-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH RFC 06/10] kfence, kasan: make KFENCE compatible with KASAN
From:   Marco Elver <elver@google.com>
To:     elver@google.com, glider@google.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, mark.rutland@arm.com, penberg@kernel.org
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        jannh@google.com, corbet@lwn.net, keescook@chromium.org,
        peterz@infradead.org, cai@lca.pw, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

We make KFENCE compatible with KASAN for testing KFENCE itself. In
particular, KASAN helps to catch any potential corruptions to KFENCE
state, or other corruptions that may be a result of freepointer
corruptions in the main allocators.

To indicate that the combination of the two is generally discouraged,
CONFIG_EXPERT=y should be set. It also gives us the nice property that
KFENCE will be build-tested by allyesconfig builds.

Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 lib/Kconfig.kfence | 2 +-
 mm/kasan/common.c  | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
index 7ac91162edb0..b080e49e15d4 100644
--- a/lib/Kconfig.kfence
+++ b/lib/Kconfig.kfence
@@ -10,7 +10,7 @@ config HAVE_ARCH_KFENCE_STATIC_POOL
 
 menuconfig KFENCE
 	bool "KFENCE: low-overhead sampling-based memory safety error detector"
-	depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
+	depends on HAVE_ARCH_KFENCE && (!KASAN || EXPERT) && (SLAB || SLUB)
 	depends on JUMP_LABEL # To ensure performance, require jump labels
 	select STACKTRACE
 	help
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 950fd372a07e..f5c49f0fdeff 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
+#include <linux/kfence.h>
 #include <linux/kmemleak.h>
 #include <linux/linkage.h>
 #include <linux/memblock.h>
@@ -396,6 +397,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	tagged_object = object;
 	object = reset_tag(object);
 
+	if (is_kfence_address(object))
+		return false;
+
 	if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
 	    object)) {
 		kasan_report_invalid_free(tagged_object, ip);
@@ -444,6 +448,9 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	if (unlikely(object == NULL))
 		return NULL;
 
+	if (is_kfence_address(object))
+		return (void *)object;
+
 	redzone_start = round_up((unsigned long)(object + size),
 				KASAN_SHADOW_SCALE_SIZE);
 	redzone_end = round_up((unsigned long)object + cache->object_size,
-- 
2.28.0.526.ge36021eeef-goog

