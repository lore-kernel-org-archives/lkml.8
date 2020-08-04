Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1651C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B600A22B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Tq+6LFpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgHDVsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:48:21 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19643 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgHDVsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:48:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f29d7970001>; Tue, 04 Aug 2020 14:48:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Aug 2020 14:48:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Aug 2020 14:48:20 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Aug
 2020 21:48:17 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Aug 2020 21:48:16 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.56.157]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f29d7a00005>; Tue, 04 Aug 2020 14:48:16 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <willy@infradead.org>, <cai@lca.pw>, <kirill@shutemov.name>,
        <rppt@linux.ibm.com>, <vbabka@suse.cz>,
        <william.kucharski@oracle.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2] mm, dump_page: do not crash with bad compound_mapcount()
Date:   Tue, 4 Aug 2020 14:48:07 -0700
Message-ID: <20200804214807.169256-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596577687; bh=Ott22dEKyPzKHXaU24WZCFZK+o8PEJC4KK56yLCYqeo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=Tq+6LFplcMvjUhQVmrwLIXDkpFmMsjKL3HrQgxUbvOKyGQ2ZuODKRhrFEh/TF+ilr
         nIFCSl4VH21pJ7EGs8/im/YXpt5svwNcKq2Gzfg4F5ctdLLTVEsRroigKnKSEN2Kr7
         QlKARf1YQ0Cb3ZMpBLENx98L2Nn36PAW3FaJ4LsQU7pCyibfWh+chLvLMpe1JH6cO/
         Ha4yAVdj6NezDvMLXZz1qwwUg1Gz0PnAq7YE9fMyFW5d4if7i6QxIqp9vLvwhnNA/u
         /Xuz6KVF4Dsk+dcF2aM9NkKXqALsIdxfMSM+OE9KgG49keNmYR0i0al9U0fwYEfT6L
         dr2zIh3nSDQVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a compound page is being split while dump_page() is being run on that
page, we can end up calling compound_mapcount() on a page that is no
longer compound. This leads to a crash (already seen at least once in
the field), due to the VM_BUG_ON_PAGE() assertion inside
compound_mapcount().

(The above is from Matthew Wilcox's analysis of Qian Cai's bug report.)

A similar problem is possible, via compound_pincount() instead of
compound_mapcount().

In order to avoid this kind of crash, make dump_page() slightly more
robust, by providing a pair of simpler routines that don't contain
assertions: head_mapcount() and head_pincount().

For debug tools, we don't want to go *too* far in this direction, but
this is a simple small fix, and the crash has already been seen, so it's
a good trade-off.

Reported-by: Qian Cai <cai@lca.pw>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
Hi,

I'm assuming that a fix is not required for -stable, but let me know if
others feel differently. The dump_page() code has changed a lot in that
area.

Changes since v1 [1]:

1) Rebased onto mmotm

2) Used a simpler head_*count() approach.

3) Added Matthew's Suggested-by: tag

4) Support pincount as well as mapcount.

[1] https://lore.kernel.org/linux-mm/20200804183943.1244828-1-jhubbard@nvid=
ia.com/

thanks,
John Hubbard

 include/linux/mm.h | 14 ++++++++++++--
 mm/debug.c         |  6 +++---
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4f12b2465e80..8ab941cf73f4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -776,6 +776,11 @@ static inline void *kvcalloc(size_t n, size_t size, gf=
p_t flags)
 extern void kvfree(const void *addr);
 extern void kvfree_sensitive(const void *addr, size_t len);
=20
+static inline int head_mapcount(struct page *head)
+{
+	return atomic_read(compound_mapcount_ptr(head)) + 1;
+}
+
 /*
  * Mapcount of compound page as a whole, does not include mapped sub-pages=
.
  *
@@ -785,7 +790,7 @@ static inline int compound_mapcount(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 	page =3D compound_head(page);
-	return atomic_read(compound_mapcount_ptr(page)) + 1;
+	return head_mapcount(page);
 }
=20
 /*
@@ -898,11 +903,16 @@ static inline bool hpage_pincount_available(struct pa=
ge *page)
 	return PageCompound(page) && compound_order(page) > 1;
 }
=20
+static inline int head_pincount(struct page *head)
+{
+	return atomic_read(compound_pincount_ptr(head));
+}
+
 static inline int compound_pincount(struct page *page)
 {
 	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
 	page =3D compound_head(page);
-	return atomic_read(compound_pincount_ptr(page));
+	return head_pincount(page);
 }
=20
 static inline void set_compound_order(struct page *page, unsigned int orde=
r)
diff --git a/mm/debug.c b/mm/debug.c
index c27fff1e3ca8..69b60637112b 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -102,12 +102,12 @@ void __dump_page(struct page *page, const char *reaso=
n)
 		if (hpage_pincount_available(page)) {
 			pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
 					head, compound_order(head),
-					compound_mapcount(head),
-					compound_pincount(head));
+					head_mapcount(head),
+					head_pincount(head));
 		} else {
 			pr_warn("head:%p order:%u compound_mapcount:%d\n",
 					head, compound_order(head),
-					compound_mapcount(head));
+					head_mapcount(head));
 		}
 	}
 	if (PageKsm(page))
--=20
2.28.0

