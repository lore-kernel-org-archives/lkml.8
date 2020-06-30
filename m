Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1198C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0FC20759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdcNZMBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbgF3Owe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgF3Owd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:52:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE77C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:52:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 207so9342633pfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=e5weAmxeHY/HZDcuo/a+y01NxEAlRLsWW0XwibE2AXc=;
        b=KdcNZMBcgu/1NT3Ui/X+l4Mzw5QlqI0Z1yCzhaCTJWNTMtdQR3mAzGCiLB6wkxhKjx
         LVP5/VaZ4tmkuS9XoLLpYjyL9qMD0Jgzxa8Epa0po6wJCAa0gUGYt3R6lhB7D+l/PgCI
         ZWfEeaxdyzER1jNfZWSvN03UPEyUn76Nwbp7W2ncJAQ+MKFR96aSu5bQI5y1u5G8acx9
         goh3HkSTo7/PtptU7s34od9XBe+NWYGC7v8+TqkqCq34RJRD7fg5YeuKjo/JHu/BafrY
         baKSkvbyQZsp9GG0Wod3pACnvCXsa5YcpE3BydYcgZZmS7qwYqCibzpCjAYNfY81prUO
         J8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e5weAmxeHY/HZDcuo/a+y01NxEAlRLsWW0XwibE2AXc=;
        b=rKz12ZpbS8TRPPizy6a1r45Rg/pxNsO2azFtLRiyFbkpMn8ujufZap+CEZdvlUDbJ7
         JW+ImosbMTrvqd2+9aDLsodvO5Mhi+tWRNv9n8i1Bxj+R+xqFZ9zpOlomHBag+wgzvwg
         4yPMGtPhIUY1U5tsvWdGj66OfPlBiu/XHn9dOuzNwpkg3kD8FOUX3B5zbQn7wH2G/mu8
         ck0hDkkl7LasIA92dxUgSvX8PemQ4z45GFVgXpik0HCcKBBd58S8GG7PQRVzrXogD1Mj
         s+bAS0V92CScDcemFQX1aHAAG+YEX2YN1gJcyA01sr0qWNaT57OtDSNLefj8RQJECweS
         l9Bw==
X-Gm-Message-State: AOAM530BRSdzBVQ1TqAKxNCLBNc4E0Fd93BwZBGQrAqiXY+sLaLjkaKi
        Jm84hxcbWCIp3b4emaFxmFYO6WygyiI=
X-Google-Smtp-Source: ABdhPJxTsrQbRQvGqP0lLFh19GhfoXBIdE6Pe+sS9b4dz0E8IfPtWxbDZDGbv4uImfsTzdBDPKsfdQ==
X-Received: by 2002:a63:6bc5:: with SMTP id g188mr14604148pgc.395.1593528752965;
        Tue, 30 Jun 2020 07:52:32 -0700 (PDT)
Received: from localhost ([144.34.187.180])
        by smtp.gmail.com with ESMTPSA id k100sm2618702pjb.57.2020.06.30.07.52.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 07:52:32 -0700 (PDT)
Date:   Tue, 30 Jun 2020 14:51:55 +0000
From:   Long Li <lonuxli.64@gmail.com>
To:     willy@infradead.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm, slab: Check GFP_SLAB_BUG_MASK before alloc_pages in
 kmalloc_order
Message-ID: <20200630145155.GA52108@lilong>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the ARM32 environment with highmem enabled. Using flag of kmalloc()
with __GFP_HIGHMEM to allocate large memory, it will go through the
kmalloc_order() path and return NULL. The __GFP_HIGHMEM flag will
cause alloc_pages() to allocate highmem memory and pages cannot be
directly converted to a virtual address, kmalloc_order() will return
NULL and the page has been allocated.

After modification, GFP_SLAB_BUG_MASK has been checked before
allocating pages, refer to the new_slab().

Signed-off-by: Long Li <lonuxli.64@gmail.com>
---

Changes in v2:
- patch is rebased againest "[PATCH] mm: Free unused pages in
kmalloc_order()" [1]
- check GFP_SLAB_BUG_MASK and generate warnings before alloc_pages
in kmalloc_order()

[1] https://lkml.org/lkml/2020/6/27/16

 mm/slab_common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index a143a8c8f874..3548f4f8374b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -27,6 +27,7 @@
 #include <trace/events/kmem.h>
 
 #include "slab.h"
+#include "internal.h"
 
 enum slab_state slab_state;
 LIST_HEAD(slab_caches);
@@ -815,6 +816,15 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	void *ret = NULL;
 	struct page *page;
 
+	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
+		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
+
+		flags &= ~GFP_SLAB_BUG_MASK;
+		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
+				invalid_mask, &invalid_mask, flags, &flags);
+		dump_stack();
+	}
+
 	flags |= __GFP_COMP;
 	page = alloc_pages(flags, order);
 	if (likely(page)) {
-- 
2.17.1

