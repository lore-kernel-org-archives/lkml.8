Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206F6C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30B12469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgB1PrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:47:09 -0500
Received: from shelob.surriel.com ([96.67.55.147]:49878 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgB1PrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:47:09 -0500
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1j7hqw-0007MR-U8; Fri, 28 Feb 2020 10:47:02 -0500
Date:   Fri, 28 Feb 2020 10:47:00 -0500
From:   Rik van Riel <riel@surriel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, linux-mm@kvack.org, mhocko@kernel.org,
        mgorman@techsingularity.net, rientjes@google.com,
        aarcange@redhat.com, ziy@nvidia.com
Subject: [PATCH] fix
 mmthpcompactioncma-allow-thp-migration-for-cma-allocations.patch
Message-ID: <20200228104700.0af2f18d@imladris.surriel.com>
In-Reply-To: <ceacd12e-a005-8035-7d88-f79a45a05975@suse.cz>
References: <cover.1582321646.git.riel@surriel.com>
        <20200227213238.1298752-2-riel@surriel.com>
        <df83c62f-209f-b1fd-3a5c-c81c82cb2606@oracle.com>
        <7800e98e3688c124ac3672284b87d67321e1c29e.camel@surriel.com>
        <67185d77-87aa-400d-475c-4435d8b7be11@suse.cz>
        <47198271414db19cecbfa1a6ea685577dad3a72c.camel@surriel.com>
        <ceacd12e-a005-8035-7d88-f79a45a05975@suse.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Mike & Vlastimil!

---8<---

commit 27f3cd5473d8bbf591b61d8b93b98bc333980d0d
Author: Rik van Riel <riel@surriel.com>
Date:   Fri Feb 28 10:41:48 2020 -0500

Subject: fix mmthpcompactioncma-allow-thp-migration-for-cma-allocations.patch
    
Mike Kravetz pointed out that the second if condition could do the
wrong thing for hugetlbfs pages, and that check really only needs
to run on THPs.
    
Cleanup suggested by Vlastimil.
  
Thank you both!
    
Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Rik van Riel <riel@surriel.com>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4afa13dd3738..71f78a590236 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8274,12 +8274,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 			struct page *head = compound_head(page);
 			unsigned int skip_pages;
 
-			if (PageHuge(page) &&
-			    !hugepage_migration_supported(page_hstate(head)))
-				return page;
-
-			if (!PageLRU(head) && !__PageMovable(head))
+			if (PageHuge(page)) {
+				if (!hugepage_migration_supported(page_hstate(head)))
+					return page;
+			} else if (!PageLRU(head) && !__PageMovable(head)) {
 				return page;
+			}
 
 			skip_pages = compound_nr(head) - (page - head);
 			iter += skip_pages - 1;
