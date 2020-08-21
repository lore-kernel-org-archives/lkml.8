Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04571C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA25D2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGzzA27p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgHUJYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHUJYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:24:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2CAC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:24:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i10so739562pgk.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=xg/gACqe6yLcp+4JQ5M8L6Se46eJjP4rGDwI/pj2lLo=;
        b=nGzzA27pqi0uS8pdR0MpNc0wsazCdAc18TpXjO5XbcXJpMocmkr1bIopoYQVcrXGZD
         OzasuYFUd0aOS8gZOw/ZBPlz3FnFT+p5dnWD08Iev7zlWH0Bqu+lqbkUP9i3LQszZ64J
         qJQ5pTKmNgHN6x6QW/N8+/7t+PQHiTuWeXtvTBAQdLmyqzyPrL+y5S3EE0QhEDDR1/MA
         cLaxynXCfQ78P/RRBYHFQNMwLZ2nr1ea2GSSA7Q4Avwn6m17QwvBhdqgMf+wOzsLPeVI
         K7xYclA6wt8P5xvXusqq/LOTPYyAIrYV3pIS31iITHY+AE4Q/dnmMWUN3pR+JnBHrvCz
         HLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=xg/gACqe6yLcp+4JQ5M8L6Se46eJjP4rGDwI/pj2lLo=;
        b=tEG7B42iO/91kJ1IluteaMelgBzq6pl3k9zP+3+eZdsoQ25uCkZh1KUilTFkzUY4an
         yO4bgTzpD7+dVJwwcFxaYQZVu9Oqa8rVAvcz/3LoBOYblWzeN6OElacny3xo1SE3MO2Y
         wNX26WIVCIqVs0lsyyI4wgGEE+d9o9rEv4uH39X2QWQpJArN3kw3xKCOQQPnz3D2kCpu
         h3teF1lChf3eciwTTgbLqIJYjApxv7yk0HDJW7s3uEvb+SU7L+mt6M4zSKHau4SRivh8
         p9PzOCdl+x5IPnS+g7UlPfaUk6Dendyst4WEgB0R8lEjc+z1eLjUc2PVB/ZlJ7bHwQWW
         /Tig==
X-Gm-Message-State: AOAM531iBu7xVHEXapGJ4qVVCGA7U0dbYO1Kxa2CkIHYJcfXDBqVrbXB
        6yL89daJjyT1qBpwYEn3cFc=
X-Google-Smtp-Source: ABdhPJx3keU6n6DgRKsTkPNHdKD32rR33lye019q9Sne1HPDtkCeJa9hOysnGGW+aCnfK9whT52YTQ==
X-Received: by 2002:aa7:96f4:: with SMTP id i20mr1691543pfq.43.1598001871978;
        Fri, 21 Aug 2020 02:24:31 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b15sm1866376pft.116.2020.08.21.02.24.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 02:24:31 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
X-Google-Original-From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm : sync ra->ra_pages with bdi->ra_pages
Date:   Fri, 21 Aug 2020 17:24:24 +0800
Message-Id: <1598001864-6123-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some system(like android) will turbo read during startup via expanding the
readahead window and then set it back to normal(128kb as usual). However, some
files in the system process context will keep to be opened since it is opened
up and has no chance to sync with the updated value as it is almost impossible
to change the files attached to the inode(processes are unaware of these things)

We sync ra->ra_pages with bdi->ra_pages when read. Furthermore, in consideration
of the scenario of eio and fadvise(...,POSIX_FADV_SEQUENTIAL).We introduce a
seq_read_fact to record the factors of above two cases.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
change from v2:
fix checkpatch error
---
---
 include/linux/fs.h | 17 +++++++++++++++++
 mm/fadvise.c       |  4 +++-
 mm/filemap.c       | 19 +++++++++++++------
 mm/readahead.c     | 37 +++++++++++++++++++++++++++++++++----
 4 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd28e76..e3cdc5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -66,6 +66,7 @@
 struct fscrypt_operations;
 struct fs_context;
 struct fs_parameter_description;
+struct file_ra_state;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -81,6 +82,7 @@
 extern int sysctl_protected_hardlinks;
 extern int sysctl_protected_fifos;
 extern int sysctl_protected_regular;
+extern void ra_pages_sync(struct file_ra_state *ra, struct address_space *mapping);
 
 typedef __kernel_rwf_t rwf_t;
 
@@ -900,11 +902,26 @@ struct file_ra_state {
 					   there are only # of pages ahead */
 
 	unsigned int ra_pages;		/* Maximum readahead window */
+	int seq_read_fact;		/* turbo factor of sequential read */
 	unsigned int mmap_miss;		/* Cache miss stat for mmap accesses */
 	loff_t prev_pos;		/* Cache last read() position */
 };
 
 /*
+ * ra->seq_read_fact == -1 indicates eio happens
+ */
+#define RA_PAGES(ra)					\
+({						\
+	unsigned int ra_pages;			\
+	if (ra->seq_read_fact != -1)		\
+		ra_pages = ra->ra_pages * ra->seq_read_fact;	\
+	else					\
+		ra_pages = ra->ra_pages;	\
+	ra_pages;				\
+})
+
+
+/*
  * Check if @index falls in the readahead windows.
  */
 static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 467bcd0..b06e3ca 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -78,6 +78,7 @@ static int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 	switch (advice) {
 	case POSIX_FADV_NORMAL:
 		file->f_ra.ra_pages = bdi->ra_pages;
+		file->f_ra.seq_read_fact = 1;
 		spin_lock(&file->f_lock);
 		file->f_mode &= ~FMODE_RANDOM;
 		spin_unlock(&file->f_lock);
@@ -88,7 +89,8 @@ static int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 		spin_unlock(&file->f_lock);
 		break;
 	case POSIX_FADV_SEQUENTIAL:
-		file->f_ra.ra_pages = bdi->ra_pages * 2;
+		file->f_ra.ra_pages = bdi->ra_pages;
+		file->f_ra.seq_read_fact = 2;
 		spin_lock(&file->f_lock);
 		file->f_mode &= ~FMODE_RANDOM;
 		spin_unlock(&file->f_lock);
diff --git a/mm/filemap.c b/mm/filemap.c
index d78f577..425d2a2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2048,6 +2048,7 @@ unsigned find_get_entries_tag(struct address_space *mapping, pgoff_t start,
 static void shrink_readahead_size_eio(struct file *filp,
 					struct file_ra_state *ra)
 {
+	ra->seq_read_fact = -1;
 	ra->ra_pages /= 4;
 }
 
@@ -2473,13 +2474,16 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return fpin;
-	if (!ra->ra_pages)
+	if (!RA_PAGES(ra))
 		return fpin;
 
+	/* sync ra->ra_pages with bdi->ra_pages*/
+	ra_pages_sync(ra, mapping);
+
 	if (vmf->vma->vm_flags & VM_SEQ_READ) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_sync_readahead(mapping, ra, file, offset,
-					  ra->ra_pages);
+					  RA_PAGES(ra));
 		return fpin;
 	}
 
@@ -2498,9 +2502,9 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	 * mmap read-around
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	ra->start = max_t(long, 0, offset - ra->ra_pages / 2);
-	ra->size = ra->ra_pages;
-	ra->async_size = ra->ra_pages / 4;
+	ra->start = max_t(long, 0, offset - RA_PAGES(ra) / 2);
+	ra->size = RA_PAGES(ra);
+	ra->async_size = RA_PAGES(ra) / 4;
 	ra_submit(ra, mapping, file);
 	return fpin;
 }
@@ -2519,6 +2523,9 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	struct file *fpin = NULL;
 	pgoff_t offset = vmf->pgoff;
 
+	/* sync ra->ra_pages with bdi->ra_pages*/
+	ra_pages_sync(ra, mapping);
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return fpin;
@@ -2527,7 +2534,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	if (PageReadahead(page)) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_readahead(mapping, ra, file,
-					   page, offset, ra->ra_pages);
+					   page, offset, RA_PAGES(ra));
 	}
 	return fpin;
 }
diff --git a/mm/readahead.c b/mm/readahead.c
index a459365..50fdf1d 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -32,10 +32,26 @@
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 {
 	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
+	ra->seq_read_fact = 1;
 	ra->prev_pos = -1;
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
 
+/*sync ra->ra_pages with bdi->ra_pages*/
+void ra_pages_sync(struct file_ra_state *ra,
+		struct address_space *mapping)
+{
+	unsigned int ra_pages = ra->ra_pages;
+
+	if (ra->seq_read_fact == -1)
+		return;
+
+	ra_pages = inode_to_bdi(mapping->host)->ra_pages * ra->seq_read_fact;
+	if (RA_PAGES(ra) != ra_pages)
+		ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
+}
+EXPORT_SYMBOL_GPL(ra_pages_sync);
+
 /*
  * see if a page needs releasing upon read_cache_pages() failure
  * - the caller of read_cache_pages() may have set PG_private or PG_fscache
@@ -228,11 +244,14 @@ int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
 	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages))
 		return -EINVAL;
 
+	/* sync ra->ra_pages with bdi->ra_pages*/
+	ra_pages_sync(ra, mapping);
+
 	/*
 	 * If the request exceeds the readahead window, allow the read to
 	 * be up to the optimal hardware IO size
 	 */
-	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
+	max_pages = max_t(unsigned long, bdi->io_pages, RA_PAGES(ra));
 	nr_to_read = min(nr_to_read, max_pages);
 	while (nr_to_read) {
 		unsigned long this_chunk = (2 * 1024 * 1024) / PAGE_SIZE;
@@ -384,10 +403,14 @@ static int try_context_readahead(struct address_space *mapping,
 		   unsigned long req_size)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	unsigned long max_pages = ra->ra_pages;
+	unsigned long max_pages;
 	unsigned long add_pages;
 	pgoff_t prev_offset;
 
+	/* sync ra->ra_pages with bdi->ra_pages*/
+	ra_pages_sync(ra, mapping);
+
+	max_pages = RA_PAGES(ra);
 	/*
 	 * If the request exceeds the readahead window, allow the read to
 	 * be up to the optimal hardware IO size
@@ -510,9 +533,12 @@ void page_cache_sync_readahead(struct address_space *mapping,
 			       pgoff_t offset, unsigned long req_size)
 {
 	/* no read-ahead */
-	if (!ra->ra_pages)
+	if (!RA_PAGES(ra))
 		return;
 
+	/* sync ra->ra_pages with bdi->ra_pages*/
+	ra_pages_sync(ra, mapping);
+
 	if (blk_cgroup_congested())
 		return;
 
@@ -549,9 +575,12 @@ void page_cache_sync_readahead(struct address_space *mapping,
 			   unsigned long req_size)
 {
 	/* no read-ahead */
-	if (!ra->ra_pages)
+	if (!RA_PAGES(ra))
 		return;
 
+	/* sync ra->ra_pages with bdi->ra_pages*/
+	ra_pages_sync(ra, mapping);
+
 	/*
 	 * Same bit is used for PG_readahead and PG_reclaim.
 	 */
-- 
1.9.1

