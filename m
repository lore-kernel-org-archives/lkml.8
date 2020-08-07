Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD29AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A39C20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fZBxq9b3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgHGSeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:34:03 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13853 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGSeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:34:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2d9e670000>; Fri, 07 Aug 2020 11:33:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Aug 2020 11:34:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Aug 2020 11:34:02 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Aug
 2020 18:34:00 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 7 Aug 2020 18:34:00 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.82.82]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f2d9e980002>; Fri, 07 Aug 2020 11:34:00 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <willy@infradead.org>, <cai@lca.pw>, <kirill@shutemov.name>,
        <rppt@linux.ibm.com>, <vbabka@suse.cz>,
        <william.kucharski@oracle.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] mm, dump_page: rename head_mapcount() --> head_compound_mapcount()
Date:   Fri, 7 Aug 2020 11:33:58 -0700
Message-ID: <20200807183358.105097-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807164805.xm4ingj4crdiemol@box>
References: <20200807164805.xm4ingj4crdiemol@box>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596825191; bh=xxywolx6cKpkt3Msomftif/rasP5xo1w2SGk8DOB1Ps=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=fZBxq9b31FTEisGJAH9HHMttW39VPDGCzdUfoWCduj+6+hL6FFkoISsoLPktjnNFf
         kOpVG1n8D6xGnxTmEOa+gaa2IAyuFVj8pDxa/i5TNat0K6UALDDaAL8Bt15E9QU8l4
         77YU4dRu3D5XZ5876r9PFVosCeBwuX3fdOh/uMTDBrcGZZ5guUJvZXBP5oItI0wTER
         8cKHU/aAc1hJ049pUnb2K7FrP7bPOO9ObSMB/7ARmvbxdYUPdfoYu3EIjuNBm+OHv0
         yCn9vEwbh0z4GUaItJ5F7xeI+fYj+1eYisZjz9ITOYJfdVL+/fGdjPLBIBFoEpBUpk
         s6qH6BmORQCaA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And similarly, rename head_pincount() --> head_compound_pincount().
These names are more accurate (or less misleading) than the original
ones.

Cc: Qian Cai <cai@lca.pw>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

This is a follow-up patch to v2 of "mm, dump_page: do not crash with bad=20
compound_mapcount()", which I see has has already been sent as part of=20
Andrew's pull request. Otherwise I would have sent a v3.

Of course, if it's somehow not too late, then squashing this patch into=20
that one, effectively creating a v3 with the preferred names, would be a=20
nice touch.

thanks,
John Hubbard

 include/linux/mm.h | 8 ++++----
 mm/debug.c         | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ab941cf73f4..98d379d9806f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -776,7 +776,7 @@ static inline void *kvcalloc(size_t n, size_t size, gfp=
_t flags)
 extern void kvfree(const void *addr);
 extern void kvfree_sensitive(const void *addr, size_t len);
=20
-static inline int head_mapcount(struct page *head)
+static inline int head_compound_mapcount(struct page *head)
 {
 	return atomic_read(compound_mapcount_ptr(head)) + 1;
 }
@@ -790,7 +790,7 @@ static inline int compound_mapcount(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 	page =3D compound_head(page);
-	return head_mapcount(page);
+	return head_compound_mapcount(page);
 }
=20
 /*
@@ -903,7 +903,7 @@ static inline bool hpage_pincount_available(struct page=
 *page)
 	return PageCompound(page) && compound_order(page) > 1;
 }
=20
-static inline int head_pincount(struct page *head)
+static inline int head_compound_pincount(struct page *head)
 {
 	return atomic_read(compound_pincount_ptr(head));
 }
@@ -912,7 +912,7 @@ static inline int compound_pincount(struct page *page)
 {
 	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
 	page =3D compound_head(page);
-	return head_pincount(page);
+	return head_compound_pincount(page);
 }
=20
 static inline void set_compound_order(struct page *page, unsigned int orde=
r)
diff --git a/mm/debug.c b/mm/debug.c
index 69b60637112b..a0c060abf1e7 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -102,12 +102,12 @@ void __dump_page(struct page *page, const char *reaso=
n)
 		if (hpage_pincount_available(page)) {
 			pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
 					head, compound_order(head),
-					head_mapcount(head),
-					head_pincount(head));
+					head_compound_mapcount(head),
+					head_compound_pincount(head));
 		} else {
 			pr_warn("head:%p order:%u compound_mapcount:%d\n",
 					head, compound_order(head),
-					head_mapcount(head));
+					head_compound_mapcount(head));
 		}
 	}
 	if (PageKsm(page))
--=20
2.28.0

