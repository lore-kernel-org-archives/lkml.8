Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E8FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25AFD20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W26cncJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFKWat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKWat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:30:49 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A657C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:30:49 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t6so5843932otk.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=+EahI0YlQUT1/wBvgRJFQZcHP3obsCOagtKe7ySyhrM=;
        b=W26cncJyLH/i2zSIOMrO837pRs3uf2BxQU7IzrLdCgttozbazIeNDlQgCyQFiYpUyY
         Ms4olROFTxfvmQAdemlh52vDy0Ftr89GQMQrDXOir38oNwY8+8gPiDMnQChh/qPvfhj1
         iUsIdILczYmCpO1xqBDBaFflxA4qJYGotgpCt1+gBdruUxe14ckzTnM3+9z+NR3Qkckp
         8bXFzj6IhT3p8E6ZtAmnlH8HwiB/X34paleeTrwi7sO8xUPY1QHO1EqXGNShfQxJUmTK
         oNomeUpR4hUAyI5seihocIFNBhP5T0Ojn22FOBFdo6AgdYqo+CShth6zOvtf4oEc8vZn
         S8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=+EahI0YlQUT1/wBvgRJFQZcHP3obsCOagtKe7ySyhrM=;
        b=KrHD7GYep+OPisuPFnaPrCxlg52xrVjA/GSK0XJ4V/fanH0TCTKWNrvu6dHRmRX/2B
         6VEaXrZj9PqSoiuZu9KvL8pZAeXkzZPGDh9XEzWGt4DapYrMtwuccV5ShsBkGpkDOP2J
         66u7q0Jl1+UhOv85H07WDP8t3tKrhAKc6Ohy4d8MDI5k7Zh8yCq0qdZb9O9M7eDUBWPR
         Xs2k/ux14wZUYEE2yYKsFrdpErRniJUFZ/skXt8n6bIVUj71QEyF3MxbYHvJR4KBGfIS
         eL2MYnPdXZ8TKncYLCR26S+g9GGWI9O2gASwac5QFYkxvZUorzoPGEbw9JKcooDZ5qDi
         6zaw==
X-Gm-Message-State: AOAM531/vWuiOZ9dylbE6zeDYqT1tDkgrIEgLIXNZ7i10qpYk1UNREkL
        xnKIXbgTtlBleLcb30nmDa1UWg==
X-Google-Smtp-Source: ABdhPJzEon9DZKGa7Vpn9RDUNP7chh++P+QM4RhU5y/VWUIMVZUMKcU4pCYumWLy9ZXhRooe4mHeuA==
X-Received: by 2002:a05:6830:1dba:: with SMTP id z26mr8682022oti.180.1591914648150;
        Thu, 11 Jun 2020 15:30:48 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r15sm978948oot.5.2020.06.11.15.30.45
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2020 15:30:47 -0700 (PDT)
Date:   Thu, 11 Jun 2020 15:30:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH alexv12 2/2] mm/compaction: fix call to
 __isolate_lru_page_prepare()
Message-ID: <alpine.LSU.2.11.2006111529010.10801@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isolate_migratepages_block() is calling __isolate_lru_page_prepare()
at a point when it has not yet acquired a reference to the page, and
may not yet hold the right lruvec lock: it has no hold on the page.

trylock_page() is not safe to use at this time: its setting PG_locked
can race with the page being freed or allocated ("Bad page"), and can
also erase flags being set by one of those "sole owners" of a freshly
allocated page who use non-atomic __SetPageFlag().

Though I have tried rcu_read_lock() instead of trylock_page() there
(like in page_evictable()), 054f1d1faaed ("mm/swap_state.c: simplify
total_swapcache_pages() with get_swap_device()") stopped the freeing of
swapper_spaces by RCU; and races against setting PageSwapCache, and the
dereference of mapping->a_ops, and the lack of any page reference: all
make that a more dubious approach.

Just move the call to __isolate_lru_page_prepare() after the call to
get_page_unless_zero(), when using trylock_page() has become safe
(safe given __isolate's  check for PageLRU - unsafe without that).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
I had envisaged this as a separate patch; but once it came down
to just moving the call inside isolate_migratepages_block(), it's
probably best folded into 10/16 or 12/16 (needs isolate_fail_put).

I shall probably want to come along later, to clean up or eliminate
__isolate_lru_page_prepare(): which I found before to have almost
nothing in common between its use by isolate_migratepages_block()
and its use by isolate_lru_pages(). We can then do its safer checks
before the get_page_unless_zero(). But trying that cleanup right
now would just get in the way of this series.

 mm/compaction.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- alexv12/mm/compaction.c	2020-06-11 13:48:10.437046025 -0700
+++ hughd/mm/compaction.c	2020-06-11 13:49:05.570579095 -0700
@@ -960,9 +960,6 @@ isolate_migratepages_block(struct compac
 		if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
 			goto isolate_fail;
 
-		if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
-			goto isolate_fail;
-
 		/*
 		 * Be careful not to clear PageLRU until after we're
 		 * sure the page is not being freed elsewhere -- the
@@ -971,6 +968,9 @@ isolate_migratepages_block(struct compac
 		if (unlikely(!get_page_unless_zero(page)))
 			goto isolate_fail;
 
+		if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
+			goto isolate_fail_put;
+
 		/* Try isolate the page */
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
