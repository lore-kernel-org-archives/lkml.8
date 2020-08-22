Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB11C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 11:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8583C2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 11:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCLPmmZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHVLbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 07:31:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41280 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbgHVLbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 07:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598095867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=NcFdFa4MMpt7rkCCPB7Hpg+82oA9hMXlLxd78N6AXZU=;
        b=FCLPmmZAARG3EmeZ+tluKHg/H1mNuRkiLPiG5nVBwb5u9CWazcL8ciXOD42Wi6zqPSyjjO
        ZiIXGG3/anKJn+ljchL00XCUUKkRr2/OHKztY/5TwjjpDn7mp0L/eiEn9ISs9HQR0i6lqH
        eZBAuaWtAN7oQCD/6OSVlmdzkVpHf6c=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-GQaV44UfNuaVHZKfd0Ggrw-1; Sat, 22 Aug 2020 07:31:04 -0400
X-MC-Unique: GQaV44UfNuaVHZKfd0Ggrw-1
Received: by mail-pg1-f200.google.com with SMTP id k32so2451908pgm.15
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 04:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NcFdFa4MMpt7rkCCPB7Hpg+82oA9hMXlLxd78N6AXZU=;
        b=jwYuLVEbivwXCEQfuUs6Yfzxw0AxqQwViDTlrHidbfIR9rq/jmGxs/LSv3S1ktQ/AS
         4OUukAUIlgT3Xae87Kd651K7V0FMDyOtbMbMUUm0GmjrWR/uOrZcH1rQXv97kwwHmCUu
         RHSGJjTZu2Jt0J7iwinic11w1akN0mjykU8fqOZVZVQBHzGv1vKZNAj8cAVqqiJCCxno
         48DFcyARQerK9viDQbps3WYbIblipG5T746hWvvcHzZwiUn0P9cOiTTJ3oqorIi+BtIG
         qGCV3d0JfxD9rnDkH4KLVTeYuce97vXLlKFKh121iw+LbGKA8hm40uZqpRVAEh2+nTAX
         L/+g==
X-Gm-Message-State: AOAM530sLavd/DCzgwXRTD7YtoAarN+XLGcZc3cXUsEwzHDT9D8DRy4J
        cbfCTrZzD62A6LE9JMtOsJbQYywVGp0tml6aQ4wDRi0Y26F72mYDY66nK9HwBK/xgyr9VFiAd3I
        Ql3yIj7XJH6Vm7ZNq2gr5RKCD
X-Received: by 2002:a17:902:a70c:: with SMTP id w12mr5970806plq.80.1598095863437;
        Sat, 22 Aug 2020 04:31:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyknFIUUSICFQyobsoC9jxZ9OXJzJyyuJ74KZ+5Bi0JtP+TB0rc+KNGkjuZsIyh/FfzDoAEAg==
X-Received: by 2002:a17:902:a70c:: with SMTP id w12mr5970789plq.80.1598095863120;
        Sat, 22 Aug 2020 04:31:03 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d131sm3981066pgc.88.2020.08.22.04.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 04:31:02 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2 rebased] swap: rename SWP_FS to SWAP_FS_OPS to avoid ambiguity
Date:   Sat, 22 Aug 2020 19:30:19 +0800
Message-Id: <20200822113019.11319-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200822090208.24212-1-hsiangkao@redhat.com>
References: <20200822090208.24212-1-hsiangkao@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWP_FS is used to make swap_{read,write}page() go
through the filesystem, and it's only used for swap
files over NFS for now. Otherwise it will directly
submit IO to blockdev according to swapfile extents
reported by filesystems in advance.

As Matthew pointed out [1], SWP_FS naming is somewhat
confusing, so let's rename to SWP_FS_OPS.

[1] https://lore.kernel.org/r/20200820113448.GM17456@casper.infradead.org
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
v2: resolve conflicts with recent merged:
commit 7b37e22675df ("mm/page_io: mark various intentional data races")

 include/linux/swap.h | 2 +-
 mm/page_io.c         | 6 +++---
 mm/swap_state.c      | 2 +-
 mm/swapfile.c        | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 661046994db4..df7ce24bbd8f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -170,7 +170,7 @@ enum {
 	SWP_CONTINUED	= (1 << 5),	/* swap_map has count continuation */
 	SWP_BLKDEV	= (1 << 6),	/* its a block device */
 	SWP_ACTIVATED	= (1 << 7),	/* set after swap_activate success */
-	SWP_FS		= (1 << 8),	/* swap file goes through fs */
+	SWP_FS_OPS	= (1 << 8),	/* swapfile operations go through fs */
 	SWP_AREA_DISCARD = (1 << 9),	/* single-time swap area discards */
 	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
 	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
diff --git a/mm/page_io.c b/mm/page_io.c
index e485a6e8a6cd..dc6de6962612 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -302,7 +302,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	struct swap_info_struct *sis = page_swap_info(page);
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
-	if (data_race(sis->flags & SWP_FS)) {
+	if (data_race(sis->flags & SWP_FS_OPS)) {
 		struct kiocb kiocb;
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
@@ -393,7 +393,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		goto out;
 	}
 
-	if (data_race(sis->flags & SWP_FS)) {
+	if (data_race(sis->flags & SWP_FS_OPS)) {
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
 
@@ -455,7 +455,7 @@ int swap_set_page_dirty(struct page *page)
 {
 	struct swap_info_struct *sis = page_swap_info(page);
 
-	if (data_race(sis->flags & SWP_FS)) {
+	if (data_race(sis->flags & SWP_FS_OPS)) {
 		struct address_space *mapping = sis->swap_file->f_mapping;
 
 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index c16eebb81d8b..7f9449bbffdb 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -631,7 +631,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		goto skip;
 
 	/* Test swap type to make sure the dereference is safe */
-	if (likely(si->flags & (SWP_BLKDEV | SWP_FS))) {
+	if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
 		struct inode *inode = si->swap_file->f_mapping->host;
 		if (inode_read_congested(inode))
 			goto skip;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index debc94155f74..5ba58ee1b378 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2433,7 +2433,7 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 		if (ret >= 0)
 			sis->flags |= SWP_ACTIVATED;
 		if (!ret) {
-			sis->flags |= SWP_FS;
+			sis->flags |= SWP_FS_OPS;
 			ret = add_swap_extent(sis, 0, sis->max, 0);
 			*span = sis->pages;
 		}
-- 
2.18.1

