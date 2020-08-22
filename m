Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715DEC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0C720825
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKTATSAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgHVJDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:03:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50963 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbgHVJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598086976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=A2WK+odm/xLarW17J7+toz/4bY7f8TVl8y0DPG0SgCM=;
        b=bKTATSABw+7rXTtzh6SDwve7cuMyWhM0Tfl2Z0L7Le6w8JGTdqe0G1rSKWFEu7frUHLLOu
        DvZmkhNIV3Fn+V2UbNb8eGi2WKyAQ1dSJzVBX2jIcPH7AerjagUXRLCw+1IEGACSkTHIpZ
        qr+i6tpc3CZKqj+gn9RnNMhB94kmQtw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-EsnXPl1MOryYBjMCjy_3gA-1; Sat, 22 Aug 2020 05:02:54 -0400
X-MC-Unique: EsnXPl1MOryYBjMCjy_3gA-1
Received: by mail-pg1-f199.google.com with SMTP id 16so2316458pgc.19
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A2WK+odm/xLarW17J7+toz/4bY7f8TVl8y0DPG0SgCM=;
        b=dYTZ5VEMXkQ7lULwtnnD2lO2ZuGyHVYGcbsG2ycqHlUq14u0U6TrLUMh6NyBVMslAL
         /mAtK22znB/BHsEdqwqsy3D9pZ3Pq+RMMsRT4e1sPh7cOF8QYIZIIczT6/u+rz0qAEaI
         zEc/oKhwGGTWgzgrwR+Z248norcCD5KoA1WW9ipga922mVioeV0IAVRQ55H9Wnn7JWkh
         GkKd5I440MbM/I9HQhIBRI79n9r8baXZ9+liyEmNV+0MZ6idPHhkssb8SiHVHavJf1JO
         TurYF1JH88H36wjYBPGFVb7mhLTQMO6v/nhZTJq1h5xLyn3Pdv1Wb7cSM21ZZZ6v+ebG
         u4BA==
X-Gm-Message-State: AOAM531cNwo5irlaaBg9XHpdpWlRDSWhZy0Tgq4DyVgx9VYZrYl7h5ni
        pCPNiuFlo/l2VmrCq23pSKaE4DqMpjE/lvtelaOLe50yfYsFsa2nP55nFlvOeKGRDj1JhV2/S6N
        DFIQ37GbKk5pphQxvGahjmrrn
X-Received: by 2002:a17:90a:a401:: with SMTP id y1mr5681298pjp.199.1598086972287;
        Sat, 22 Aug 2020 02:02:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE3TlY0agf/LpfwoxRlqSwc0vYF9UraA5RD84nzYV03YvPzcs2nnflzpIOMCv9ttFlrFpIGw==
X-Received: by 2002:a17:90a:a401:: with SMTP id y1mr5681286pjp.199.1598086971994;
        Sat, 22 Aug 2020 02:02:51 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m190sm351571pfm.184.2020.08.22.02.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 02:02:51 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH] swap: rename SWP_FS to SWAP_FS_OPS to avoid ambiguity
Date:   Sat, 22 Aug 2020 17:02:08 +0800
Message-Id: <20200822090208.24212-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
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
A follow-on thread / patch here.

 include/linux/swap.h | 2 +-
 mm/page_io.c         | 6 +++---
 mm/swap_state.c      | 2 +-
 mm/swapfile.c        | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 7eb59bc552a5..51029a5f57be 100644
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
index 9e362567d454..72e0b5a5a41f 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -302,7 +302,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	struct swap_info_struct *sis = page_swap_info(page);
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
-	if (sis->flags & SWP_FS) {
+	if (sis->flags & SWP_FS_OPS) {
 		struct kiocb kiocb;
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
@@ -393,7 +393,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		goto out;
 	}
 
-	if (sis->flags & SWP_FS) {
+	if (sis->flags & SWP_FS_OPS) {
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
 
@@ -455,7 +455,7 @@ int swap_set_page_dirty(struct page *page)
 {
 	struct swap_info_struct *sis = page_swap_info(page);
 
-	if (sis->flags & SWP_FS) {
+	if (sis->flags & SWP_FS_OPS) {
 		struct address_space *mapping = sis->swap_file->f_mapping;
 
 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index e82f4f8b1f63..135a5d9fad5d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -573,7 +573,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		goto skip;
 
 	/* Test swap type to make sure the dereference is safe */
-	if (likely(si->flags & (SWP_BLKDEV | SWP_FS))) {
+	if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
 		struct inode *inode = si->swap_file->f_mapping->host;
 		if (inode_read_congested(inode))
 			goto skip;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2937daf3ca02..75681682bec8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2426,7 +2426,7 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
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

