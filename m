Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FBEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2000214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgFRIhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:37:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgFRIhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:37:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4BFCDAD35;
        Thu, 18 Jun 2020 08:37:07 +0000 (UTC)
Subject: Re: [PATCH 7/9] mm, slub: introduce kmem_cache_debug_flags()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vinmenon@codeaurora.org,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-8-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <949b90ed-e0f0-07d7-4d21-e30ec0958a7c@suse.cz>
Date:   Thu, 18 Jun 2020 10:37:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610163135.17364-8-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 6:31 PM, Vlastimil Babka wrote:
> There are few places that call kmem_cache_debug(s) (which tests if any of debug
> flags are enabled for a cache) immediatelly followed by a test for a specific
> flag. The compiler can probably eliminate the extra check, but we can make the
> code nicer by introducing kmem_cache_debug_flags() that works like
> kmem_cache_debug() (including the static key check) but tests for specifig
> flag(s). The next patches will add more users.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Please add this fixup per reviews.
----8<----
From 25793252a31a36f8d1d4ccf0f27ed3e43fba54d8 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 18 Jun 2020 10:34:53 +0200
Subject: [PATCH] mm, slub: introduce kmem_cache_debug_flags()-fix

Change return from int to bool, per Kees.
Add VM_WARN_ON_ONCE() for invalid flags, per Roman.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c8e8b4ae2451..59d19c64069e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -127,16 +127,17 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
  * cache. Use only for flags parsed by setup_slub_debug() as it also enables
  * the static key.
  */
-static inline int kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
+static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
 {
+	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
 #ifdef CONFIG_SLUB_DEBUG
 	if (static_branch_unlikely(&slub_debug_enabled))
 		return s->flags & flags;
 #endif
-	return 0;
+	return false;
 }
 
-static inline int kmem_cache_debug(struct kmem_cache *s)
+static inline bool kmem_cache_debug(struct kmem_cache *s)
 {
 	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
 }
-- 
2.27.0

