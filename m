Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F754C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694A02067C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRJadN1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHUXuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:50:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55413 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726719AbgHUXuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598053806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJMoESJi1CzsGXjZoMet0uu1x4mJs/R0x5g01SKUlC0=;
        b=eRJadN1VWkzw5AKANibH7MRg/8xPdjVBMAtLauEzBXgZsNeEW0qxdSOHddkK07QgB1fiLi
        EkcNGVAAmQlqt+2NAswENLVTDhK8NP7KaBdCpSRl6UmW5xSzSeUDSHju/yf+kN7OOLad2V
        ckoU1BKTRX8e9FEdlKmznfTXHWhipQA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-Pf1vEi5jPBmQieZiUI6bUQ-1; Fri, 21 Aug 2020 19:50:04 -0400
X-MC-Unique: Pf1vEi5jPBmQieZiUI6bUQ-1
Received: by mail-qt1-f199.google.com with SMTP id f59so2413769qtb.22
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJMoESJi1CzsGXjZoMet0uu1x4mJs/R0x5g01SKUlC0=;
        b=ecHwnHzQSezmk5p0hqfQfGN2AQkovTllIVYPDKb7NwhpVH99wm5IKXyPNl3DZojIBq
         XRZaUGjSGJN1wTBfaXm/jEfzVXkfEHZmiTUKSTqUDxPo38iYJh+br48EyjRiHM9Lm6YW
         eloQwTC98cN3B7GTwY9BX9dBArDJaU0IXfGMnSe+0k9JKF90B/gTGpuHRFrrAUDpFZs0
         YQ+oJJcias8seFZObMBzYr2XtW8HO9ec01HWfNzdh2sTg4htaLTU4t7Lsl8kClnELi39
         ktqSiI/fE/eapRDC16w4dziLR34dE6AADZEm9N29mVYMVmFS4nJFPdt/de3P+326N/os
         l30Q==
X-Gm-Message-State: AOAM5306ck9B7vECzEpxeqgyqVi2ipIKYpJIhr26HK5eJfphhEXgRBwy
        SmthSnZKeQ613mlXjLbKcS/7DjLuRPguK3yjoi2GM0R4+rgc8P9uuY9NeKUaSr/xPCssIAGiJa1
        cuAZiTfjPqXnMmEjXxc7Rsjde
X-Received: by 2002:a37:bd46:: with SMTP id n67mr5209833qkf.190.1598053804360;
        Fri, 21 Aug 2020 16:50:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym38019X0MXzuv14+yatNymJFgB7Qx8TRrssQJ+S40n02yV1nQKW5PQNvdNrKhPQZr5dzc8g==
X-Received: by 2002:a37:bd46:: with SMTP id n67mr5209812qkf.190.1598053804062;
        Fri, 21 Aug 2020 16:50:04 -0700 (PDT)
Received: from localhost.localdomain (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id t69sm2821600qka.73.2020.08.21.16.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 16:50:03 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>, peterx@redhat.com,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/4] mm: Trial do_wp_page() simplification
Date:   Fri, 21 Aug 2020 19:49:55 -0400
Message-Id: <20200821234958.7896-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821234958.7896-1-peterx@redhat.com>
References: <20200821234958.7896-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

How about we just make sure we're the only possible valid user fo the
page before we bother to reuse it?

Simplify, simplify, simplify.

And get rid of the nasty serialization on the page lock at the same time.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[peterx: add subject prefix]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 59 +++++++++++++++--------------------------------------
 1 file changed, 17 insertions(+), 42 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 602f4283122f..cb9006189d22 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2927,50 +2927,25 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	 * not dirty accountable.
 	 */
 	if (PageAnon(vmf->page)) {
-		int total_map_swapcount;
-		if (PageKsm(vmf->page) && (PageSwapCache(vmf->page) ||
-					   page_count(vmf->page) != 1))
+		struct page *page = vmf->page;
+
+		/* PageKsm() doesn't necessarily raise the page refcount */
+		if (PageKsm(page) || page_count(page) != 1)
+			goto copy;
+		if (!trylock_page(page))
+			goto copy;
+		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
+			unlock_page(page);
 			goto copy;
-		if (!trylock_page(vmf->page)) {
-			get_page(vmf->page);
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			lock_page(vmf->page);
-			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					vmf->address, &vmf->ptl);
-			if (!pte_same(*vmf->pte, vmf->orig_pte)) {
-				update_mmu_tlb(vma, vmf->address, vmf->pte);
-				unlock_page(vmf->page);
-				pte_unmap_unlock(vmf->pte, vmf->ptl);
-				put_page(vmf->page);
-				return 0;
-			}
-			put_page(vmf->page);
-		}
-		if (PageKsm(vmf->page)) {
-			bool reused = reuse_ksm_page(vmf->page, vmf->vma,
-						     vmf->address);
-			unlock_page(vmf->page);
-			if (!reused)
-				goto copy;
-			wp_page_reuse(vmf);
-			return VM_FAULT_WRITE;
-		}
-		if (reuse_swap_page(vmf->page, &total_map_swapcount)) {
-			if (total_map_swapcount == 1) {
-				/*
-				 * The page is all ours. Move it to
-				 * our anon_vma so the rmap code will
-				 * not search our parent or siblings.
-				 * Protected against the rmap code by
-				 * the page lock.
-				 */
-				page_move_anon_rmap(vmf->page, vma);
-			}
-			unlock_page(vmf->page);
-			wp_page_reuse(vmf);
-			return VM_FAULT_WRITE;
 		}
-		unlock_page(vmf->page);
+		/*
+		 * Ok, we've got the only map reference, and the only
+		 * page count reference, and the page is locked,
+		 * it's dark out, and we're wearing sunglasses. Hit it.
+		 */
+		wp_page_reuse(vmf);
+		unlock_page(page);
+		return VM_FAULT_WRITE;
 	} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
 					(VM_WRITE|VM_SHARED))) {
 		return wp_page_shared(vmf);
-- 
2.26.2

