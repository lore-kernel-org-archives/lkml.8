Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525B8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FAF820639
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/2W25yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHMDRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 23:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgHMDRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:17:16 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3362CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 20:17:16 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id r6so930240oon.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 20:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=d5gM963jXgjoG9xSkVthzNFdGJ4ytytBPjGpdNfGwQE=;
        b=j/2W25yrTTTJa0lxgxJG+ghzhZ7OSp8SEds1Qz1gC1lDAfGWdRKzSnU9ZDd0tlVpg1
         dwF3sBJmqO0/UhaKTXEsXbsKrcXcGZDjqBaWEMWp40j4ryEIGBzDxyOO8nlQZNq+zLK7
         TKx2rkqUEMRF6hQsjmnfxlXDK/iMFAhbsexlq2lYgjCMvl3giIXtf3mIwnQb0x4eHS1b
         U2sHqoTUa3RzXlOzKz9HkcxjDEEL22k+w++oTqxtGWddSuDC5h+6Y/8DO64Owyi4htmJ
         ZMeR+G/d4jk+nXOcz3by/QX77MMpF6NvnZptI6Mi1kVQdLZNZl3N0yFzcZXAQ2+HK8By
         YRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=d5gM963jXgjoG9xSkVthzNFdGJ4ytytBPjGpdNfGwQE=;
        b=C3ULY7VgCRPxEjz/UOkRhha4U8NRTSIgJ2j/KNf0yJ3HZUvNszYLVhrDpVw9fz3mE+
         DpiWsxikBYECySD4SI7jdqAZp/NJI6IayAwL/vBMHIZV25o83S7gzI5XaN0mqH6VJJYM
         CeMpei+/LwHTtRLnevT5ZDnD0WxpJFVzMV/BSxnK+0Z9ySImfkIV8wqLuHScVn7iHuDW
         wpjHjxAlcLFcbVemDPe1ALg2BZeZqWUe3Pzojcz0nC6I5p5nzCXn8+3vhk2KnajU21XL
         Knm6iqbiGN6fBBFD+S18RpIxDG39YC79s6Wsy/dPMnakslhb6emhJZZlM1A4r7cBr/zj
         Iwsg==
X-Gm-Message-State: AOAM53301QoeX4xeNF6c0OH17Lsy6qTALkIpnCwJqWdHdHAdtWkMDCTj
        Z2fMKSzCXyFRh/NZ1RXLhIQS1w==
X-Google-Smtp-Source: ABdhPJz3Ahiq/PDZ7De+xF095uaVH1Vh3EB/+6umE8wxr7Ev1HWhGWS6bGlZEUajwVigJFocX+Qi2A==
X-Received: by 2002:a4a:ac0e:: with SMTP id p14mr2860150oon.26.1597288635333;
        Wed, 12 Aug 2020 20:17:15 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p9sm861601oti.22.2020.08.12.20.17.13
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 12 Aug 2020 20:17:14 -0700 (PDT)
Date:   Wed, 12 Aug 2020 20:17:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Christoph Hellwig <hch@lst.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Hugh Dickins <hughd@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] dma-debug: fix debug_dma_assert_idle(), use
 rcu_read_lock()
Message-ID: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
improved unlock_page(), it has become more noticeable how cow_user_page()
in a kernel with CONFIG_DMA_API_DEBUG=y can create and suffer from heavy
contention on DMA debug's radix_lock in debug_dma_assert_idle().

It is only doing a lookup: use rcu_read_lock() and rcu_read_unlock()
instead; though that does require the static ents[] to be moved onstack...

...but, hold on, isn't that radix_tree_gang_lookup() and loop doing quite
the wrong thing: searching CACHELINES_PER_PAGE entries for an exact match
with the first cacheline of the page in question?  radix_tree_gang_lookup()
is the right tool for the job, but we need nothing more than to check the
first entry it can find, reporting if that falls anywhere within the page.

(Is RCU safe here?  As safe as using the spinlock was.  The entries are
never freed, so don't need to be freed by RCU.  They may be reused, and
there is a faint chance of a race, with an offending entry reused while
printing its error info; but the spinlock did not prevent that either,
and I agree that it's not worth worrying about.)

Fixes: 3b7a6418c749 ("dma debug: account for cachelines and read-only mappings in overlap tracking")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 kernel/dma/debug.c |   27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

--- v5.9-rc/kernel/dma/debug.c	2020-08-05 18:17:57.544203766 -0700
+++ linux/kernel/dma/debug.c	2020-08-12 19:53:33.159070245 -0700
@@ -565,11 +565,8 @@ static void active_cacheline_remove(stru
  */
 void debug_dma_assert_idle(struct page *page)
 {
-	static struct dma_debug_entry *ents[CACHELINES_PER_PAGE];
-	struct dma_debug_entry *entry = NULL;
-	void **results = (void **) &ents;
-	unsigned int nents, i;
-	unsigned long flags;
+	struct dma_debug_entry *entry;
+	unsigned long pfn;
 	phys_addr_t cln;
 
 	if (dma_debug_disabled())
@@ -578,20 +575,14 @@ void debug_dma_assert_idle(struct page *
 	if (!page)
 		return;
 
-	cln = (phys_addr_t) page_to_pfn(page) << CACHELINE_PER_PAGE_SHIFT;
-	spin_lock_irqsave(&radix_lock, flags);
-	nents = radix_tree_gang_lookup(&dma_active_cacheline, results, cln,
-				       CACHELINES_PER_PAGE);
-	for (i = 0; i < nents; i++) {
-		phys_addr_t ent_cln = to_cacheline_number(ents[i]);
+	pfn = page_to_pfn(page);
+	cln = (phys_addr_t) pfn << CACHELINE_PER_PAGE_SHIFT;
 
-		if (ent_cln == cln) {
-			entry = ents[i];
-			break;
-		} else if (ent_cln >= cln + CACHELINES_PER_PAGE)
-			break;
-	}
-	spin_unlock_irqrestore(&radix_lock, flags);
+	rcu_read_lock();
+	if (!radix_tree_gang_lookup(&dma_active_cacheline, (void **) &entry,
+				    cln, 1) || entry->pfn != pfn)
+		entry = NULL;
+	rcu_read_unlock();
 
 	if (!entry)
 		return;
