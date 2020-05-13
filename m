Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427BAC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE96F204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="uKlmcMdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbgEMOFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388325AbgEMOFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:05:32 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D491C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:05:31 -0700 (PDT)
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 8DD192E1574;
        Wed, 13 May 2020 17:05:26 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id lDNVHsY2qe-5PpWqbZP;
        Wed, 13 May 2020 17:05:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1589378726; bh=YcgwTTe1UbCJlZpmvqFenHMREDNQ+pyRS2BjsAD24bI=;
        h=Message-ID:Date:To:From:Subject;
        b=uKlmcMdrccVnLpz/QJl9j1Ey7nEKddWJIRk1JUu4m/QIveLUfUYAWEKqDIYGbb800
         mBsTcVVjP+JjseIGcjGGTkrpT3E3d4T0ecgMmvFQfM3RphHi1iibKy1oumAEn23d58
         aQV6jUfXskRAFLYwhM72Uw8k7ErDA1NYw3Z1JXeg=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:8207::1:2])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id MK10jIJZJE-5PXuZchK;
        Wed, 13 May 2020 17:05:25 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH] mm/compaction: avoid VM_BUG_ON(PageSlab()) in page_mapcount()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 13 May 2020 17:05:25 +0300
Message-ID: <158937872515.474360.5066096871639561424.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


To fix just opencode page_mapcount() in racy check for 0-order case and
recheck carefully under lru_lock when page cannot escape from lru.

Also add checking extra references for file pages and swap cache.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 119d6d59dcc0 ("mm, compaction: avoid isolating pinned pages")
Fixes: 1d148e218a0d ("mm: add VM_BUG_ON_PAGE() to page_mapcount()")
---
 mm/compaction.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 46f0fcc93081..91bb87fd9420 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -935,12 +935,16 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}
 
 		/*
-		 * Migration will fail if an anonymous page is pinned in memory,
+		 * Migration will fail if an page is pinned in memory,
 		 * so avoid taking lru_lock and isolating it unnecessarily in an
-		 * admittedly racy check.
+		 * admittedly racy check simplest case for 0-order pages.
+		 *
+		 * Open code page_mapcount() to avoid VM_BUG_ON(PageSlab(page)).
+		 * Page could have extra reference from mapping or swap cache.
 		 */
-		if (!page_mapping(page) &&
-		    page_count(page) > page_mapcount(page))
+		if (!PageCompound(page) &&
+		    page_count(page) > atomic_read(&page->_mapcount) + 1 +
+				(!PageAnon(page) || PageSwapCache(page)))
 			goto isolate_fail;
 
 		/*
@@ -975,6 +979,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 				low_pfn += compound_nr(page) - 1;
 				goto isolate_fail;
 			}
+
+			/* Recheck page extra references under lock */
+			if (page_count(page) > page_mapcount(page) +
+				    (!PageAnon(page) || PageSwapCache(page)))
+				goto isolate_fail;
 		}
 
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);

