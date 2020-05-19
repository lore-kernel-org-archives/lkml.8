Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B274BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A1220715
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bSQ34rpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgESAV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 20:21:28 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9203 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgESAV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:21:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec325f90002>; Mon, 18 May 2020 17:19:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 May 2020 17:21:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 May 2020 17:21:27 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 May
 2020 00:21:27 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 May 2020 00:21:27 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.55.90]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec326860000>; Mon, 18 May 2020 17:21:26 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/4] mm/gup: move __get_user_pages_fast() down a few lines in gup.c
Date:   Mon, 18 May 2020 17:21:21 -0700
Message-ID: <20200519002124.2025955-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519002124.2025955-1-jhubbard@nvidia.com>
References: <20200519002124.2025955-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589847546; bh=rovyqRvoWmUY8LZ787X+YkZeUTez+YCYnMbA60VZKSY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=bSQ34rpRpEOByCzljfvC/zfc+UVQ2Rn8RyR8bdgPZR2DNTrpl8PkavKtjTEuscWrd
         JXJB008sQjaDiHiaipNpC7QRm3/xF0SR7xUuIz6f9FUne9lgD47lmRB40+OWyCy5gj
         mF7WTWbg/vfo7D17F9f2Roho+MrbfURPvNvvYVUNF6lX7Al0oraHZhMjiWHn6zqjaF
         ExjbImR95YFfmlP/Z8W7f1wb8ABXmC9OpXQZQ1kUxMifYC1qqdbjdcl7fq2CScM3uw
         X1hIFk76ZaYn5DST5AfgzCqeXzXV2vhyorhVCH1kG+7fccAblz6n8S/vtBqYbpRiGb
         5JsazZgU3xcrw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is in order to avoid a forward declaration of
internal_get_user_pages_fast(), in the next patch.

This is code movement only--all generated code should
be identical.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 112 +++++++++++++++++++++++++++----------------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 50cd9323efff..4502846d57f9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2666,62 +2666,6 @@ static bool gup_fast_permitted(unsigned long start, =
unsigned long end)
 }
 #endif
=20
-/*
- * Like get_user_pages_fast() except it's IRQ-safe in that it won't fall b=
ack to
- * the regular GUP.
- * Note a difference with get_user_pages_fast: this always returns the
- * number of pages pinned, 0 if no pages were pinned.
- *
- * If the architecture does not support this function, simply return with =
no
- * pages pinned.
- */
-int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
-			  struct page **pages)
-{
-	unsigned long len, end;
-	unsigned long flags;
-	int nr_pinned =3D 0;
-	/*
-	 * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
-	 * because gup fast is always a "pin with a +1 page refcount" request.
-	 */
-	unsigned int gup_flags =3D FOLL_GET;
-
-	if (write)
-		gup_flags |=3D FOLL_WRITE;
-
-	start =3D untagged_addr(start) & PAGE_MASK;
-	len =3D (unsigned long) nr_pages << PAGE_SHIFT;
-	end =3D start + len;
-
-	if (end <=3D start)
-		return 0;
-	if (unlikely(!access_ok((void __user *)start, len)))
-		return 0;
-
-	/*
-	 * Disable interrupts.  We use the nested form as we can already have
-	 * interrupts disabled by get_futex_key.
-	 *
-	 * With interrupts disabled, we block page table pages from being
-	 * freed from under us. See struct mmu_table_batch comments in
-	 * include/asm-generic/tlb.h for more details.
-	 *
-	 * We do not adopt an rcu_read_lock(.) here as we also want to
-	 * block IPIs that come from THPs splitting.
-	 */
-
-	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
-	    gup_fast_permitted(start, end)) {
-		local_irq_save(flags);
-		gup_pgd_range(start, end, gup_flags, pages, &nr_pinned);
-		local_irq_restore(flags);
-	}
-
-	return nr_pinned;
-}
-EXPORT_SYMBOL_GPL(__get_user_pages_fast);
-
 static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
 				   unsigned int gup_flags, struct page **pages)
 {
@@ -2794,6 +2738,62 @@ static int internal_get_user_pages_fast(unsigned lon=
g start, int nr_pages,
 	return ret;
 }
=20
+/*
+ * Like get_user_pages_fast() except it's IRQ-safe in that it won't fall b=
ack to
+ * the regular GUP.
+ * Note a difference with get_user_pages_fast: this always returns the
+ * number of pages pinned, 0 if no pages were pinned.
+ *
+ * If the architecture does not support this function, simply return with =
no
+ * pages pinned.
+ */
+int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
+			  struct page **pages)
+{
+	unsigned long len, end;
+	unsigned long flags;
+	int nr_pinned =3D 0;
+	/*
+	 * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
+	 * because gup fast is always a "pin with a +1 page refcount" request.
+	 */
+	unsigned int gup_flags =3D FOLL_GET;
+
+	if (write)
+		gup_flags |=3D FOLL_WRITE;
+
+	start =3D untagged_addr(start) & PAGE_MASK;
+	len =3D (unsigned long) nr_pages << PAGE_SHIFT;
+	end =3D start + len;
+
+	if (end <=3D start)
+		return 0;
+	if (unlikely(!access_ok((void __user *)start, len)))
+		return 0;
+
+	/*
+	 * Disable interrupts.  We use the nested form as we can already have
+	 * interrupts disabled by get_futex_key.
+	 *
+	 * With interrupts disabled, we block page table pages from being
+	 * freed from under us. See struct mmu_table_batch comments in
+	 * include/asm-generic/tlb.h for more details.
+	 *
+	 * We do not adopt an rcu_read_lock(.) here as we also want to
+	 * block IPIs that come from THPs splitting.
+	 */
+
+	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
+	    gup_fast_permitted(start, end)) {
+		local_irq_save(flags);
+		gup_pgd_range(start, end, gup_flags, pages, &nr_pinned);
+		local_irq_restore(flags);
+	}
+
+	return nr_pinned;
+}
+EXPORT_SYMBOL_GPL(__get_user_pages_fast);
+
 /**
  * get_user_pages_fast() - pin user pages in memory
  * @start:      starting user address
--=20
2.26.2

