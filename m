Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E1C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB94C2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581708598;
	bh=ujUNi1Q3kF2016LN44z3XAc8iGa49FiLOnGxoqIYzwQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ujWJ31Waw4XEDcQEM78yN3iwm6WBkwzS1XYcBHdFJU8vSH7UQwuN+U19kJJIAHZuu
	 nV7yjSDekyiyLo73Nt4/vcgIwmuOQxDrNecugulS2n+XZYLgUSHvGc97XxvgnTYFOl
	 KAUcQnVDZRIwen42114fNaZPArsjyETn175uvV5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbgBNT35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:29:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45554 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbgBNT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:29:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so4074274pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QEs+yW3UJgHk9TnX81qWdQWQN2YyvEyIUmkldm3VYU=;
        b=qFDWtMbFWV7ozT4Nt7HSo4WsK/i4G3BX8JPMEjGMkPKIohuubmhqmM4QOgS6YtjwMX
         olaSiH/8vVklHCOL7IKKjZhDAxwG1sex7a2lh3iwIjasuRhPxTl7ldIvytD7ajiBoGw5
         mK+BdU1y2G1O0oqPX6SNDr5UpbjHMS2+OwFDmofiAaVIXOY/lRVcn5p+yJAat9izqZTr
         HwCNV319rhhBPZWwRHFFBHnYjZH/qydj185qpZcVnDIK2pr+lBO74/6gC4zdovi+88S9
         nnWjQ5TFDwLXFm1b/hDpNLmnRXozFCREjN16xunLu0qZFvRwcuv6PdP1dGP7w71J3Kr5
         i9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4QEs+yW3UJgHk9TnX81qWdQWQN2YyvEyIUmkldm3VYU=;
        b=keG6udOegnn5kkFfdLhAZR5vabJDGxnY3H2+3CyQ73J41sSTfHOyHrkkolO/5qTCyi
         p0oiMhyg0oDNldMm1kxgr5UnCnilyv+eXojm7br0N2HqE6SALcmWVNR9nhqgRgtZqOui
         CGq5XFoe617kB1M5vUhNzwgabytfgjClauO7e2l/8Cvrmh7DdaFqwu17Y74GZraRa1cn
         60O68RHAM2MKPTWn3hf/FkH/1EA5FOBr/jJiObTU1gLJ2MzvWGbzw7uvrG2fs0iGR+4A
         zosyYdAsZ/sCpAaA5K1xrGgfcyItHwiS0F+MpOONTxFXMbhnumQBn4k4VVMIb3bz7jaW
         1oew==
X-Gm-Message-State: APjAAAUNEsPAa2s3VbntAre4IoQ7irtoeegD3vkYd48AFUV1goZyWkBI
        btN/MW2jhn6l/PESwuyMHdOo+vId
X-Google-Smtp-Source: APXvYqw5Tl7xnpOM57l7YLJPyjDNOhD2V/+YRSknZV/B1cYBDS24ZFUTK+re3jnZ5PzqAWMesQxo7g==
X-Received: by 2002:a17:902:45:: with SMTP id 63mr4891442pla.109.1581708595875;
        Fri, 14 Feb 2020 11:29:55 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id d4sm7219795pjz.12.2020.02.14.11.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 11:29:54 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 1/2] mm: make PageReadahead more strict
Date:   Fri, 14 Feb 2020 11:29:50 -0800
Message-Id: <20200214192951.29430-1-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I got some bugreports major page fault takes several seconds
sometime. When I review drop mmap_sem logic, I found several bugs.

   CPU 1                                                        CPU 2
mm_populate
 for ()
   ..
   ret = populate_vma_page_range
     __get_user_pages
       faultin_page
         handle_mm_fault
           filemap_fault
             do_async_mmap_readahead
                                                        shrink_page_list
                                                          pageout
                                                            SetPageReclaim(=SetPageReadahead)
                                                              writepage
                                                                SetPageWriteback
               if (PageReadahead(page))
                 maybe_unlock_mmap_for_io
                   up_read(mmap_sem)
                 page_cache_async_readahead()
                   if (PageWriteback(page))
                     return;

Here, since ret from populate_vma_page_range is zero, the loop continue
to run with same address with previous iteration. It will repeat the
loop until the page's writeout is done(ie, PG_writeback or PG_reclaim
is clear).

We could fix the above specific case via adding PageWriteback

   ret = populate_vma_page_range
           ...
           ...
           filemap_fault
             do_async_mmap_readahead
               if (!PageWriteback(page) && PageReadahead(page))
                 maybe_unlock_mmap_for_io
                   up_read(mmap_sem)
                 page_cache_async_readahead()
                   if (PageWriteback(page))
                     return;

Furthermore, to prevent potential issues caused by sharing PG_readahead
with PG_reclaim, let's make page flag wrapper for PageReadahead
with description. With that, we could remove PageWriteback check
in page_cache_async_readahead, which is more clear for maintenance/
readability.

Fixes: 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/page-flags.h | 28 ++++++++++++++++++++++++++--
 mm/readahead.c             |  6 ------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1bf83c8fcaa7..f91a9b2a49bd 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -363,8 +363,32 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
 PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
-PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
-	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+
+SETPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+CLEARPAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+
+/*
+ * Since PG_readahead is shared with PG_reclaim of the page flags,
+ * PageReadahead should double check whether it's readahead marker
+ * or PG_reclaim. It could be done by PageWriteback check because
+ * PG_reclaim is always with PG_writeback.
+ */
+static inline int PageReadahead(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
+
+	return (page->flags & (1UL << PG_reclaim | 1UL << PG_writeback)) ==
+		(1UL << PG_reclaim);
+}
+
+/* Clear PG_readahead only if it's PG_readahead, not PG_reclaim */
+static inline int TestClearPageReadahead(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
+
+	return !PageWriteback(page) ||
+			test_and_clear_bit(PG_reclaim, &page->flags);
+}
 
 #ifdef CONFIG_HIGHMEM
 /*
diff --git a/mm/readahead.c b/mm/readahead.c
index 2fe72cd29b47..85b15e5a1d7b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -553,12 +553,6 @@ page_cache_async_readahead(struct address_space *mapping,
 	if (!ra->ra_pages)
 		return;
 
-	/*
-	 * Same bit is used for PG_readahead and PG_reclaim.
-	 */
-	if (PageWriteback(page))
-		return;
-
 	ClearPageReadahead(page);
 
 	/*
-- 
2.25.0.265.gbab2e86ba0-goog

