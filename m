Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83644C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6780C2137B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390206AbgFXH5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:57:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:35694 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389965AbgFXH5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:57:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAC60AFD5;
        Wed, 24 Jun 2020 07:57:37 +0000 (UTC)
Subject: Re: [PATCH 9/9] mm, slab/slub: move and improve cache_from_obj()
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
References: <20200610163135.17364-1-vbabka@suse.cz>
 <20200610163135.17364-10-vbabka@suse.cz> <202006171039.FBDF2D7F4A@keescook>
 <afeda7ac-748b-33d8-a905-56b708148ad5@suse.cz>
Message-ID: <b33e0fa7-cd28-4788-9e54-5927846329ef@suse.cz>
Date:   Wed, 24 Jun 2020 09:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <afeda7ac-748b-33d8-a905-56b708148ad5@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/20 12:10 PM, Vlastimil Babka wrote:
> ----8<----
> From b8df607d92b37e5329ce7bda62b2b364cc249893 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 18 Jun 2020 11:52:03 +0200
> Subject: [PATCH] mm, slab/slub: improve error reporting and overhead of
>  cache_from_obj()
> 

Another small fixup, please.

----8<----
From 2cd24408828a22a3cd4301afbaf98767b1a14eb1 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 24 Jun 2020 09:49:15 +0200
Subject: [PATCH] mm, slab/slub: improve error reporting and overhead of
 cache_from_obj()-fix

The added VM_WARN_ON_ONCE triggers [1] with CONFIG_SLAB, as SLAB_DEBUG_FLAGS
doesn't include SLAB_CONSISTENCY_CHECKS. Move the check under #ifdef
SLUB_DEBUG.

[1] https://lore.kernel.org/r/20200623090213.GW5535@shao2-debian

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 525260217013..e829d9f5e6ef 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -229,8 +229,8 @@ static inline void print_tracking(struct kmem_cache *s, void *object)
  */
 static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t flags)
 {
-	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
 #ifdef CONFIG_SLUB_DEBUG
+	VM_WARN_ON_ONCE(!(flags & SLAB_DEBUG_FLAGS));
 	if (static_branch_unlikely(&slub_debug_enabled))
 		return s->flags & flags;
 #endif
-- 
2.27.0


