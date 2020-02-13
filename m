Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B487C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE3F206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RAijAi60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBMQqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:46:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbgBMQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RlRyWk3E8pkBUtHLFUeOH4N5v7dJu49BRvdJ8idw5ts=; b=RAijAi60OPDofbcLxMVuPZq+t+
        Cypt8b6Bit6Dv4ryHyCIzdG621bwRX/emryr5xouM+3f5xCZXOd1ODi8UXF/do16/xoA2q9EsIIiI
        nPPhdC5xvmdn4dJN/62FyJIUOt180f5WJOyyVKp8IJyssOodRu2p4eZQbmYBUulItVFPeipeO3oRO
        u9P8+YGoAd94cIQ1MD09XFewO4SAkADFgcaVYPE7YlZ/cr1GQ36cd1XJMlNSeNR1r3T7t6xDBbn2m
        i1xQraD9QYmwCsCfaQIMYXVrd8XF7UBzwx9cjODgApGYj6lzmLnwf3NsO011PwPzqNmQSprE9EnIW
        Dlnx4kVw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2Hct-0003mW-D6; Thu, 13 Feb 2020 16:46:07 +0000
Date:   Thu, 13 Feb 2020 08:46:07 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200213164607.GR7778@bombadil.infradead.org>
References: <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org>
 <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org>
 <20200128081712.GA18145@dhcp22.suse.cz>
 <20200128083044.GB6615@bombadil.infradead.org>
 <20200128091352.GC18145@dhcp22.suse.cz>
 <20200128104857.GC6615@bombadil.infradead.org>
 <20200128113953.GA24244@dhcp22.suse.cz>
 <20200213074847.GB31689@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213074847.GB31689@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 08:48:47AM +0100, Michal Hocko wrote:
> Can we pursue on this please? An explicit NOFS scope annotation with a
> reference to compaction potentially locking up on pages in the readahead
> would be a great start.

How about this (on top of the current readahead series):

diff --git a/mm/readahead.c b/mm/readahead.c
index 29ca25c8f01e..32fd32b913da 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -160,6 +160,16 @@ unsigned long page_cache_readahead_limit(struct address_space *mapping,
 		.nr_pages = 0,
 	};
 
+	/*
+	 * Partway through the readahead operation, we will have added
+	 * locked pages to the page cache, but will not yet have submitted
+	 * them for I/O.  Adding another page may need to allocate
+	 * memory, which can trigger memory migration.	Telling the VM
+	 * we're in the middle of a filesystem operation will cause it
+	 * to not touch file-backed pages, preventing a deadlock.
+	 */
+	unsigned int nofs = memalloc_nofs_save();
+
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
@@ -217,6 +227,7 @@ unsigned long page_cache_readahead_limit(struct address_space *mapping,
 	 */
 	read_pages(&rac, &page_pool);
 	BUG_ON(!list_empty(&page_pool));
+	memalloc_nofs_restore(nofs);
 	return rac.nr_pages;
 }
 EXPORT_SYMBOL_GPL(page_cache_readahead_limit);
