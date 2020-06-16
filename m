Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC2DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E9E20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSHE2J4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgFPM4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPM4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:56:33 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D33C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:56:33 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d2so16652641qtw.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JEQhTwQYPsGwAzZzLRu7bODyjB8wxGLamvh49Pujfk0=;
        b=sSHE2J4HPUB3tIDmmWhIklNcdHKql+Uyvzmc6XqZpJzmMGO9f6RWeMHzZrA6nd1tSH
         wMFPzYcAPkUjWTpoSnXWYqcJagGQ/qjFYIRVjH2z9YI/HeVHHQV5Pl3ZS6vTxa7SGj5L
         j+utHFL7hNCvLLPoFB+AbBI8rZHh9d4+uQVvgsOqCTpmGC27qch98mbMkhW9CKDfvNJ8
         c1NsXeSe3lzWr+2hbz2PjJhuS2gJbX8ZKdgrN0uNsF4RMooNpcflAm1VQJlWZ+0I9jie
         0V6sIasNyxIBD6XERhgR0uOqbXiop7Ciwfj1E4eOd1HPeB+YNnkWvso/1bDHoPZ3yCxp
         kg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JEQhTwQYPsGwAzZzLRu7bODyjB8wxGLamvh49Pujfk0=;
        b=raZRygRs7hzzyj7VQrxroBF0+K2hBZPfQGadIDHKu6eqFWlJ8YdQ/4FWaoy/UtBVj4
         JpyGuWALEr6hCbjsPMIN+Nhv8PJIGLCeVWTZ637abt6e4yQdfL9a84N+/IgAubIVYWzq
         Ex0rp+XilR57dx5DP0mzZ8TrWWVKLngfEn12GsEW0oXTPeRy1oKqRYrvjahP5tie/QnR
         PoL5dwjJPLIhrwpcpkxsVuAs78Q3B2I8IcgtgLSlvqkTT0E288VUsmIJnRY/VSeDbczv
         DXFRjxuGxl5p/MptWXLjS2TsbO625SfsIsMpy+PbMY4D5OXIbd04FQrvqQgjVyMpOw56
         s62g==
X-Gm-Message-State: AOAM531C08HqF9tXErSREP96xwUthGdR5XpI3DUcebycmxRhqvXEm3YC
        FaMkiCFcT7UacKjvAVFepVUX1iJuWQ==
X-Google-Smtp-Source: ABdhPJwJECfqDtEzlbRiaVbG9X3exdfTM0hZYMe8eM3LQl2bahV0IpaKa5NjpgAs6dfyJ1u5JrhunEnOKA==
X-Received: by 2002:a0c:e5c1:: with SMTP id u1mr2081593qvm.140.1592312191743;
 Tue, 16 Jun 2020 05:56:31 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:56:17 +0200
Message-Id: <20200616125617.237428-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] mm, kcsan: Instrument SLAB/SLUB free with "ASSERT_EXCLUSIVE_ACCESS"
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the necessary KCSAN checks to assist with debugging racy
use-after-frees. While KASAN is more reliable at generally catching such
use-after-frees (due to its use of a quarantine), it can be difficult to
debug racy use-after-frees. If a reliable reproducer exists, KCSAN can
assist in debugging such issues.

Note: ASSERT_EXCLUSIVE_ACCESS is a convenience wrapper if the size is
simply sizeof(var). Instead, here we just use __kcsan_check_access()
explicitly to pass the correct size.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/slab.c | 4 ++++
 mm/slub.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 9350062ffc1a..4c7013eeacd9 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3426,6 +3426,10 @@ static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
 	if (kasan_slab_free(cachep, objp, _RET_IP_))
 		return;
 
+	/* Use KCSAN to help debug racy use-after-free. */
+	__kcsan_check_access(objp, cachep->object_size,
+			     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
+
 	___cache_free(cachep, objp, caller);
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index b8f798b50d44..57db6ca2e0dc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1470,6 +1470,10 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
 	if (!(s->flags & SLAB_DEBUG_OBJECTS))
 		debug_check_no_obj_freed(x, s->object_size);
 
+	/* Use KCSAN to help debug racy use-after-free. */
+	__kcsan_check_access(x, s->object_size,
+			     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
+
 	/* KASAN might put x into memory quarantine, delaying its reuse */
 	return kasan_slab_free(s, x, _RET_IP_);
 }
-- 
2.27.0.290.gba653c62da-goog

