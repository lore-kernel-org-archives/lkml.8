Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C743C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B6F20899
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="zg3yyA1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgEXNn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 09:43:26 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:33966 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgEXNnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 09:43:24 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 77A062E1476;
        Sun, 24 May 2020 16:43:21 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id YtsQiugMXN-hJY4qd4m;
        Sun, 24 May 2020 16:43:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1590327801; bh=3pIP3m8WwwbsJ4SnIjjtWyOI/ntT/CeolRaAW4AnY8Q=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=zg3yyA1AORDir5t5mLzATTqL15mEAKO+fwToV62hSav7ujKDBcTfCzhckdxMXmsvu
         uDmgrBNqzpi1A/NLrqW1OEup5obqipU38YcpDOxiJrTF/QYQW3UKwxD2pyCme+nYMF
         ML4j4LT2APgcccrFzhZWmXbhPc+drFXgfMcKW1TA=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:606::1:1])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4roCE1W5A4-hJX4fh2O;
        Sun, 24 May 2020 16:43:19 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH v2] mm: remove VM_BUG_ON(PageSlab()) from page_mapcount()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sun, 24 May 2020 16:43:18 +0300
Message-ID: <159032779896.957378.7852761411265662220.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace superfluous VM_BUG_ON() with comment about correct usage.

Technically reverts commit 1d148e218a0d0566b1c06f2f45f1436d53b049b2
("mm: add VM_BUG_ON_PAGE() to page_mapcount()"), but context have changed.

Function isolate_migratepages_block() runs some checks out of lru_lock
when choose pages for migration. After checking PageLRU() it checks extra
page references by comparing page_count() and page_mapcount(). Between
these two checks page could be removed from lru, freed and taken by slab.

As a result this race triggers VM_BUG_ON(PageSlab()) in page_mapcount().
Race window is tiny. For certain workload this happens around once a year.


 page:ffffea0105ca9380 count:1 mapcount:0 mapping:ffff88ff7712c180 index:0x0 compound_mapcount: 0
 flags: 0x500000000008100(slab|head)
 raw: 0500000000008100 dead000000000100 dead000000000200 ffff88ff7712c180
 raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
 page dumped because: VM_BUG_ON_PAGE(PageSlab(page))
 ------------[ cut here ]------------
 kernel BUG at ./include/linux/mm.h:628!
 invalid opcode: 0000 [#1] SMP NOPTI
 CPU: 77 PID: 504 Comm: kcompactd1 Tainted: G        W         4.19.109-27 #1
 Hardware name: Yandex T175-N41-Y3N/MY81-EX0-Y3N, BIOS R05 06/20/2019
 RIP: 0010:isolate_migratepages_block+0x986/0x9b0


Code in isolate_migratepages_block() was added in commit 119d6d59dcc0
("mm, compaction: avoid isolating pinned pages") before adding VM_BUG_ON
into page_mapcount().

This race has been predicted in 2015 by Vlastimil Babka (see link below).

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 1d148e218a0d ("mm: add VM_BUG_ON_PAGE() to page_mapcount()")
Link: https://lore.kernel.org/lkml/557710E1.6060103@suse.cz/
Link: https://lore.kernel.org/linux-mm/158937872515.474360.5066096871639561424.stgit@buzz/T/ (v1)
---
 include/linux/mm.h |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..95f777f482ac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -782,6 +782,11 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
 
 extern void kvfree(const void *addr);
 
+/*
+ * Mapcount of compound page as a whole, not includes mapped sub-pages.
+ *
+ * Must be called only for compound pages or any their tail sub-pages.
+ */
 static inline int compound_mapcount(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
@@ -801,10 +806,15 @@ static inline void page_mapcount_reset(struct page *page)
 
 int __page_mapcount(struct page *page);
 
+/*
+ * Mapcount of 0-order page, for sub-page includes compound_mapcount().
+ *
+ * Result is undefined for pages which cannot be mapped into userspace.
+ * For example SLAB or special types of pages. See function page_has_type().
+ * They use this place in struct page differently.
+ */
 static inline int page_mapcount(struct page *page)
 {
-	VM_BUG_ON_PAGE(PageSlab(page), page);
-
 	if (unlikely(PageCompound(page)))
 		return __page_mapcount(page);
 	return atomic_read(&page->_mapcount) + 1;

