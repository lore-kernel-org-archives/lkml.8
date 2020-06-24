Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A05C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982B82077D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404915AbgFXTOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:14:52 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51590 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404563AbgFXTOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:14:51 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from build.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 21606589-1500050 
        for multiple; Wed, 24 Jun 2020 20:14:22 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
Date:   Wed, 24 Jun 2020 20:14:17 +0100
Message-Id: <20200624191417.16735-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A general rule of thumb is that shrinkers should be fast and effective.
They are called from direct reclaim at the most incovenient of times when
the caller is waiting for a page. If we attempt to reclaim a page being
pinned for active dma [pin_user_pages()], we will incur far greater
latency than a normal anonymous page mapped multiple times. Worse the
page may be in use indefinitely by the HW and unable to be reclaimed
in a timely manner.

A side effect of the LRU shrinker not being dma aware is that we will
often attempt to perform direct reclaim on the persistent group of dma
pages while continuing to use the dma HW (an issue as the HW may already
be actively waiting for the next user request), and even attempt to
reclaim a partially allocated dma object in order to satisfy pinning
the next user page for that object.

It is to be expected that such pages are made available for reclaim at
the end of the dma operation [unpin_user_pages()], and for truly
longterm pins to be proactively recovered via device specific shrinkers
[i.e. stop the HW, allow the pages to be returned to the system, and
then compete again for the memory].

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
---
This seems perhaps a little devious and overzealous. Is there a more
appropriate TTU flag? Would there be a way to limit its effect to say
FOLL_LONGTERM? Doing the migration first would seem to be sensible if
we disable opportunistic migration for the duration of the pin.
---
 mm/rmap.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index 5fe2dedce1fc..374c6e65551b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1393,6 +1393,22 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	    is_zone_device_page(page) && !is_device_private_page(page))
 		return true;
 
+	/*
+	 * Try and fail early to revoke a costly DMA pinned page.
+	 *
+	 * Reclaiming an active DMA page requires stopping the hardware
+	 * and flushing access. [Hardware that does support pagefaulting,
+	 * and so can quickly revoke DMA pages at any time, does not need
+	 * to pin the DMA page.] At worst, the page may be indefinitely in
+	 * use by the hardware. Even at best it will take far longer to
+	 * revoke the access via the mmu notifier, forcing that latency
+	 * onto our callers rather than the consumer of the HW. As we are
+	 * called during opportunistic direct reclaim, declare the
+	 * opportunity cost too high and ignore the page.
+	 */
+	if (page_maybe_dma_pinned(page))
+		return true;
+
 	if (flags & TTU_SPLIT_HUGE_PMD) {
 		split_huge_pmd_address(vma, address,
 				flags & TTU_SPLIT_FREEZE, page);
-- 
2.20.1

