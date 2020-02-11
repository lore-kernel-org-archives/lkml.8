Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FA5C352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3480320733
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QdqXtOYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgBKDBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:01:55 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46415 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbgBKDBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:01:55 -0500
Received: by mail-qk1-f193.google.com with SMTP id g195so8756220qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 19:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDuKz8LG6e/Q6OjAADX6nh47gn2hXYEAHBLoIv0xEDo=;
        b=QdqXtOYRY6N8H8KoXWsYQuIDa5MloudL6cocwRCcO9e9jEeWtDY/GESCG5mAyybMvL
         PzcPSTjcl1i99pQUjxn7zEYH634CSw+jE1UF16LMtcu+NYRbTZXmUrswtiIicCRWhAYl
         NZjCeAhxrhZzKWF6bYFm4rqjy910Nlh60LnMTkjI+MUA3Zn5oQ984Dvev3I0A4D0agRm
         ffZVjuk8VvKsSmpTpUEF3MbU0hwul0SnEb3vKC1RDyBBxL5Op/FsNIz2WkPljsywQMlQ
         LpFj9wyu9QwcU2lqQbEl1Thvvfl8qghMv80IxM6aYZBTOMC8kJ+HxUD8P3iudv66P+ka
         TyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDuKz8LG6e/Q6OjAADX6nh47gn2hXYEAHBLoIv0xEDo=;
        b=KDglWfnIGADeLtLmhGUHdwA+2Ga+4ThT6yvWMrvGDrmK4mcFfZkZNWKa7bQfbFp+hz
         UlY7of5eQIEavfhsI+FPb4SxDW7GLm015l8J0ByJNXh2z/VufXhI0iWA3D3FDh1vcX0H
         qYPUp1ZQTMyW0Rc9N+6sCvs7l+XjRBOm2JFpQF9p4dFOMjGYHbmq1U2nF6p1fq2Ytwx5
         lCwD+ao+RCXJ+i1eng/1dwLuhSLo0cl3XFqVHtWVSmOXFxYnNNvGHGgh6MkwyQb2y1zK
         LRYt0lEcnO5BxRq1SfWEz9WVuMcZj6+xR3j4ViTmiLsgDnn8NPTTRd0BH3JZK3IDjqVm
         HZlQ==
X-Gm-Message-State: APjAAAWnh0YJMeZ9e95iDonLTfkaWoBRSgCNBjg3KTsU7dtE555P2uRh
        CeVZUZZzFxvv+H9+mDQUC3nT/A==
X-Google-Smtp-Source: APXvYqwWgIBKHaGcKaZl3h0ngUDh7ttSd105xW5gy8kceaUNQbNSZx35PytD5R5FOB+GWeSxZPwKIg==
X-Received: by 2002:a05:620a:1fa:: with SMTP id x26mr4439937qkn.311.1581390113130;
        Mon, 10 Feb 2020 19:01:53 -0800 (PST)
Received: from ovpn-120-145.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h13sm1232613qtu.23.2020.02.10.19.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 19:01:52 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2] mm/filemap: fix a data race in filemap_fault()
Date:   Mon, 10 Feb 2020 22:01:34 -0500
Message-Id: <20200211030134.1847-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct file_ra_state ra.mmap_miss could be accessed concurrently during
page faults as noticed by KCSAN,

 BUG: KCSAN: data-race in filemap_fault / filemap_map_pages

 write to 0xffff9b1700a2c1b4 of 4 bytes by task 3292 on cpu 30:
  filemap_fault+0x920/0xfc0
  do_sync_mmap_readahead at mm/filemap.c:2384
  (inlined by) filemap_fault at mm/filemap.c:2486
  __xfs_filemap_fault+0x112/0x3e0 [xfs]
  xfs_filemap_fault+0x74/0x90 [xfs]
  __do_fault+0x9e/0x220
  do_fault+0x4a0/0x920
  __handle_mm_fault+0xc69/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffff9b1700a2c1b4 of 4 bytes by task 3313 on cpu 32:
  filemap_map_pages+0xc2e/0xd80
  filemap_map_pages at mm/filemap.c:2625
  do_fault+0x3da/0x920
  __handle_mm_fault+0xc69/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 32 PID: 3313 Comm: systemd-udevd Tainted: G        W    L 5.5.0-next-20200210+ #1
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

ra.mmap_miss is used to contribute the readahead decisions, a data race
could be undesirable. Both the read and write is only under
non-exclusive mmap_sem, two concurrent writers could even overflow the
counter. Fixing the underflow by writing to a local variable before
committing a final store to ra.mmap_miss given a small inaccuracy of the
counter should be acceptable.

Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: fix the underflow issue pointed out by Matthew.

 mm/filemap.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478270e1..2e298db2e80f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2365,6 +2365,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct address_space *mapping = file->f_mapping;
 	struct file *fpin = NULL;
 	pgoff_t offset = vmf->pgoff;
+	unsigned int mmap_miss;
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
@@ -2380,14 +2381,15 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	}
 
 	/* Avoid banging the cache line if not needed */
-	if (ra->mmap_miss < MMAP_LOTSAMISS * 10)
-		ra->mmap_miss++;
+	mmap_miss = READ_ONCE(ra->mmap_miss);
+	if (mmap_miss < MMAP_LOTSAMISS * 10)
+		WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
 
 	/*
 	 * Do we miss much more than hit in this file? If so,
 	 * stop bothering with read-ahead. It will only hurt.
 	 */
-	if (ra->mmap_miss > MMAP_LOTSAMISS)
+	if (mmap_miss > MMAP_LOTSAMISS)
 		return fpin;
 
 	/*
@@ -2413,13 +2415,15 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
 	struct file *fpin = NULL;
+	unsigned int mmap_miss;
 	pgoff_t offset = vmf->pgoff;
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return fpin;
-	if (ra->mmap_miss > 0)
-		ra->mmap_miss--;
+	mmap_miss = READ_ONCE(ra->mmap_miss);
+	if (mmap_miss)
+		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
 	if (PageReadahead(page)) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_readahead(mapping, ra, file,
@@ -2586,6 +2590,7 @@ void filemap_map_pages(struct vm_fault *vmf,
 	unsigned long max_idx;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct page *page;
+	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, end_pgoff) {
@@ -2622,8 +2627,8 @@ void filemap_map_pages(struct vm_fault *vmf,
 		if (page->index >= max_idx)
 			goto unlock;
 
-		if (file->f_ra.mmap_miss > 0)
-			file->f_ra.mmap_miss--;
+		if (mmap_miss > 0)
+			mmap_miss--;
 
 		vmf->address += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		if (vmf->pte)
@@ -2643,6 +2648,7 @@ void filemap_map_pages(struct vm_fault *vmf,
 			break;
 	}
 	rcu_read_unlock();
+	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
 }
 EXPORT_SYMBOL(filemap_map_pages);
 
-- 
2.21.0 (Apple Git-122.2)

