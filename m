Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26998C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 01:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B4B2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 01:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHQBep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 21:34:45 -0400
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:54388 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgHQBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 21:34:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BDB63180192F4;
        Mon, 17 Aug 2020 01:34:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: foot51_200e8bf27012
X-Filterd-Recvd-Size: 243066
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Aug 2020 01:34:27 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/6] ceph: Use generic debugging facility
Date:   Sun, 16 Aug 2020 18:34:04 -0700
Message-Id: <5a726fe69d19c66ade0b36c2e1af401bce0e9940.1597626802.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1597626802.git.joe@perches.com>
References: <cover.1597626802.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dout macro duplicates the generic features of pr_debug with
__FILE__ and __func__ output capability when using dynamic_debug.

Convert dout to pr_debug and remove the "pretty" print feature
of dout.

Miscellanea:

o Realign arguments

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/ceph/addr.c                 | 265 +++++++++--------
 fs/ceph/cache.c                |  22 +-
 fs/ceph/caps.c                 | 529 +++++++++++++++++----------------
 fs/ceph/debugfs.c              |   4 +-
 fs/ceph/dir.c                  | 141 ++++-----
 fs/ceph/export.c               |  36 +--
 fs/ceph/file.c                 | 170 ++++++-----
 fs/ceph/inode.c                | 338 +++++++++++----------
 fs/ceph/ioctl.c                |   6 +-
 fs/ceph/locks.c                |  43 +--
 fs/ceph/mds_client.c           | 373 +++++++++++------------
 fs/ceph/mdsmap.c               |  16 +-
 fs/ceph/metric.c               |   4 +-
 fs/ceph/quota.c                |   4 +-
 fs/ceph/snap.c                 | 135 +++++----
 fs/ceph/super.c                |  67 +++--
 fs/ceph/xattr.c                |  63 ++--
 include/linux/ceph/messenger.h |   2 +-
 18 files changed, 1133 insertions(+), 1085 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6ea761c84494..12ae6f7874fb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -84,8 +84,8 @@ static int ceph_set_page_dirty(struct page *page)
 		return !TestSetPageDirty(page);
 
 	if (PageDirty(page)) {
-		dout("%p set_page_dirty %p idx %lu -- already dirty\n",
-		     mapping->host, page, page->index);
+		pr_debug("%p set_page_dirty %p idx %lu -- already dirty\n",
+			 mapping->host, page, page->index);
 		BUG_ON(!PagePrivate(page));
 		return 0;
 	}
@@ -111,12 +111,11 @@ static int ceph_set_page_dirty(struct page *page)
 	if (ci->i_wrbuffer_ref == 0)
 		ihold(inode);
 	++ci->i_wrbuffer_ref;
-	dout("%p set_page_dirty %p idx %lu head %d/%d -> %d/%d "
-	     "snapc %p seq %lld (%d snaps)\n",
-	     mapping->host, page, page->index,
-	     ci->i_wrbuffer_ref-1, ci->i_wrbuffer_ref_head-1,
-	     ci->i_wrbuffer_ref, ci->i_wrbuffer_ref_head,
-	     snapc, snapc->seq, snapc->num_snaps);
+	pr_debug("%p set_page_dirty %p idx %lu head %d/%d -> %d/%d snapc %p seq %lld (%d snaps)\n",
+		 mapping->host, page, page->index,
+		 ci->i_wrbuffer_ref - 1, ci->i_wrbuffer_ref_head - 1,
+		 ci->i_wrbuffer_ref, ci->i_wrbuffer_ref_head,
+		 snapc, snapc->seq, snapc->num_snaps);
 	spin_unlock(&ci->i_ceph_lock);
 
 	/*
@@ -150,8 +149,8 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 	ci = ceph_inode(inode);
 
 	if (offset != 0 || length != PAGE_SIZE) {
-		dout("%p invalidatepage %p idx %lu partial dirty page %u~%u\n",
-		     inode, page, page->index, offset, length);
+		pr_debug("%p invalidatepage %p idx %lu partial dirty page %u~%u\n",
+			 inode, page, page->index, offset, length);
 		return;
 	}
 
@@ -161,8 +160,8 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 	if (!PagePrivate(page))
 		return;
 
-	dout("%p invalidatepage %p idx %lu full dirty page\n",
-	     inode, page, page->index);
+	pr_debug("%p invalidatepage %p idx %lu full dirty page\n",
+		 inode, page, page->index);
 
 	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
 	ceph_put_snap_context(snapc);
@@ -172,8 +171,9 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 
 static int ceph_releasepage(struct page *page, gfp_t g)
 {
-	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
-	     page, page->index, PageDirty(page) ? "" : "not ");
+	pr_debug("%p releasepage %p idx %lu (%sdirty)\n",
+		 page->mapping->host, page, page->index,
+		 PageDirty(page) ? "" : "not ");
 
 	/* Can we release the page from the cache? */
 	if (!ceph_release_fscache_page(page, g))
@@ -198,8 +198,8 @@ static int ceph_sync_readpages(struct ceph_fs_client *fsc,
 	struct ceph_osd_request *req;
 	int rc = 0;
 
-	dout("readpages on ino %llx.%llx on %llu~%llu\n", vino.ino,
-	     vino.snap, off, *plen);
+	pr_debug("readpages on ino %llx.%llx on %llu~%llu\n",
+		 vino.ino, vino.snap, off, *plen);
 	req = ceph_osdc_new_request(osdc, layout, vino, off, plen, 0, 1,
 				    CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
 				    NULL, truncate_seq, truncate_size,
@@ -211,8 +211,8 @@ static int ceph_sync_readpages(struct ceph_fs_client *fsc,
 	osd_req_op_extent_osd_data_pages(req, 0,
 				pages, *plen, page_align, false, false);
 
-	dout("readpages  final extent is %llu~%llu (%llu bytes align %d)\n",
-	     off, *plen, *plen, page_align);
+	pr_debug("readpages final extent is %llu~%llu (%llu bytes align %d)\n",
+		 off, *plen, *plen, page_align);
 
 	rc = ceph_osdc_start_request(osdc, req, false);
 	if (!rc)
@@ -222,7 +222,7 @@ static int ceph_sync_readpages(struct ceph_fs_client *fsc,
 				 req->r_end_latency, rc);
 
 	ceph_osdc_put_request(req);
-	dout("readpages result %d\n", rc);
+	pr_debug("readpages result %d\n", rc);
 	return rc;
 }
 
@@ -260,8 +260,8 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
 	if (err == 0)
 		return -EINPROGRESS;
 
-	dout("readpage inode %p file %p page %p index %lu\n",
-	     inode, filp, page, page->index);
+	pr_debug("readpage inode %p file %p page %p index %lu\n",
+		 inode, filp, page, page->index);
 	err = ceph_sync_readpages(fsc, ceph_vino(inode),
 				  &ci->i_layout, off, &len,
 				  ci->i_truncate_seq, ci->i_truncate_size,
@@ -311,7 +311,8 @@ static void finish_read(struct ceph_osd_request *req)
 	int num_pages;
 	int i;
 
-	dout("finish_read %p req %p rc %d bytes %d\n", inode, req, rc, bytes);
+	pr_debug("finish_read %p req %p rc %d bytes %d\n",
+		 inode, req, rc, bytes);
 	if (rc == -EBLACKLISTED)
 		ceph_inode_to_client(inode)->blacklisted = true;
 
@@ -332,8 +333,8 @@ static void finish_read(struct ceph_osd_request *req)
 			int s = bytes < 0 ? 0 : bytes;
 			zero_user_segment(page, s, PAGE_SIZE);
 		}
- 		dout("finish_read %p uptodate %p idx %lu\n", inode, page,
-		     page->index);
+		pr_debug("finish_read %p uptodate %p idx %lu\n",
+			 inode, page, page->index);
 		flush_dcache_page(page);
 		SetPageUptodate(page);
 		ceph_readpage_to_fscache(inode, page);
@@ -378,9 +379,9 @@ static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
 		ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want,
 					true, &got);
 		if (ret < 0) {
-			dout("start_read %p, error getting cap\n", inode);
+			pr_debug("start_read %p, error getting cap\n", inode);
 		} else if (!(got & want)) {
-			dout("start_read %p, no cache cap\n", inode);
+			pr_debug("start_read %p, no cache cap\n", inode);
 			ret = 0;
 		}
 		if (ret <= 0) {
@@ -408,8 +409,8 @@ static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
 			break;
 	}
 	len = nr_pages << PAGE_SHIFT;
-	dout("start_read %p nr_pages %d is %lld~%lld\n", inode, nr_pages,
-	     off, len);
+	pr_debug("start_read %p nr_pages %d is %lld~%lld\n",
+		 inode, nr_pages, off, len);
 	vino = ceph_vino(inode);
 	req = ceph_osdc_new_request(osdc, &ci->i_layout, vino, off, &len,
 				    0, 1, CEPH_OSD_OP_READ,
@@ -433,14 +434,14 @@ static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
 		BUG_ON(PageLocked(page));
 		list_del(&page->lru);
 
- 		dout("start_read %p adding %p idx %lu\n", inode, page,
-		     page->index);
+		pr_debug("start_read %p adding %p idx %lu\n",
+			 inode, page, page->index);
 		if (add_to_page_cache_lru(page, &inode->i_data, page->index,
 					  GFP_KERNEL)) {
 			ceph_fscache_uncache_page(inode, page);
 			put_page(page);
-			dout("start_read %p add_to_page_cache failed %p\n",
-			     inode, page);
+			pr_debug("start_read %p add_to_page_cache failed %p\n",
+				 inode, page);
 			nr_pages = i;
 			if (nr_pages > 0) {
 				len = nr_pages << PAGE_SHIFT;
@@ -455,7 +456,7 @@ static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
 	req->r_callback = finish_read;
 	req->r_inode = inode;
 
-	dout("start_read %p starting %p %lld~%lld\n", inode, req, off, len);
+	pr_debug("start_read %p starting %p %lld~%lld\n", inode, req, off, len);
 	ret = ceph_osdc_start_request(osdc, req, false);
 	if (ret < 0)
 		goto out_pages;
@@ -508,8 +509,8 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
 
 	rw_ctx = ceph_find_rw_context(fi);
 	max = fsc->mount_options->rsize >> PAGE_SHIFT;
-	dout("readpages %p file %p ctx %p nr_pages %d max %d\n",
-	     inode, file, rw_ctx, nr_pages, max);
+	pr_debug("readpages %p file %p ctx %p nr_pages %d max %d\n",
+		 inode, file, rw_ctx, nr_pages, max);
 	while (!list_empty(page_list)) {
 		rc = start_read(inode, rw_ctx, page_list, max);
 		if (rc < 0)
@@ -518,7 +519,7 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
 out:
 	ceph_fscache_readpages_cancel(inode, page_list);
 
-	dout("readpages %p file %p ret %d\n", inode, file, rc);
+	pr_debug("readpages %p file %p ret %d\n", inode, file, rc);
 	return rc;
 }
 
@@ -545,8 +546,8 @@ get_oldest_context(struct inode *inode, struct ceph_writeback_ctl *ctl,
 
 	spin_lock(&ci->i_ceph_lock);
 	list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
-		dout(" cap_snap %p snapc %p has %d dirty pages\n", capsnap,
-		     capsnap->context, capsnap->dirty_pages);
+		pr_debug("cap_snap %p snapc %p has %d dirty pages\n",
+			 capsnap, capsnap->context, capsnap->dirty_pages);
 		if (!capsnap->dirty_pages)
 			continue;
 
@@ -578,8 +579,8 @@ get_oldest_context(struct inode *inode, struct ceph_writeback_ctl *ctl,
 	}
 	if (!snapc && ci->i_wrbuffer_ref_head) {
 		snapc = ceph_get_snap_context(ci->i_head_snapc);
-		dout(" head snapc %p has %d dirty pages\n",
-		     snapc, ci->i_wrbuffer_ref_head);
+		pr_debug("head snapc %p has %d dirty pages\n",
+			 snapc, ci->i_wrbuffer_ref_head);
 		if (ctl) {
 			ctl->i_size = i_size_read(inode);
 			ctl->truncate_size = ci->i_truncate_size;
@@ -646,7 +647,7 @@ static int ceph_sync_writepages(struct ceph_fs_client *fsc,
 	/* it may be a short write due to an object boundary */
 	osd_req_op_extent_osd_data_pages(req, 0, pages, len, page_align,
 				false, false);
-	dout("writepages %llu~%llu (%llu bytes)\n", off, len, len);
+	pr_debug("writepages %llu~%llu (%llu bytes)\n", off, len, len);
 
 	req->r_mtime = *mtime;
 	rc = ceph_osdc_start_request(osdc, req, true);
@@ -659,7 +660,7 @@ static int ceph_sync_writepages(struct ceph_fs_client *fsc,
 	ceph_osdc_put_request(req);
 	if (rc == 0)
 		rc = len;
-	dout("writepages result %d\n", rc);
+	pr_debug("writepages result %d\n", rc);
 	return rc;
 }
 
@@ -679,7 +680,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	int err, len = PAGE_SIZE;
 	struct ceph_writeback_ctl ceph_wbc;
 
-	dout("writepage %p idx %lu\n", page, page->index);
+	pr_debug("writepage %p idx %lu\n", page, page->index);
 
 	inode = page->mapping->host;
 	ci = ceph_inode(inode);
@@ -688,13 +689,13 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	/* verify this is a writeable snap context */
 	snapc = page_snap_context(page);
 	if (!snapc) {
-		dout("writepage %p page %p not dirty?\n", inode, page);
+		pr_debug("writepage %p page %p not dirty?\n", inode, page);
 		return 0;
 	}
 	oldest = get_oldest_context(inode, &ceph_wbc, snapc);
 	if (snapc->seq > oldest->seq) {
-		dout("writepage %p page %p snapc %p not writeable - noop\n",
-		     inode, page, snapc);
+		pr_debug("writepage %p page %p snapc %p not writeable - noop\n",
+			 inode, page, snapc);
 		/* we should only noop if called by kswapd */
 		WARN_ON(!(current->flags & PF_MEMALLOC));
 		ceph_put_snap_context(oldest);
@@ -705,7 +706,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 
 	/* is this a partial page at end of file? */
 	if (page_off >= ceph_wbc.i_size) {
-		dout("%p page eof %llu\n", page, ceph_wbc.i_size);
+		pr_debug("%p page eof %llu\n", page, ceph_wbc.i_size);
 		page->mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
 		return 0;
 	}
@@ -713,8 +714,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	if (ceph_wbc.i_size < page_off + len)
 		len = ceph_wbc.i_size - page_off;
 
-	dout("writepage %p page %p index %lu on %llu~%u snapc %p seq %lld\n",
-	     inode, page, page->index, page_off, len, snapc, snapc->seq);
+	pr_debug("writepage %p page %p index %lu on %llu~%u snapc %p seq %lld\n",
+		 inode, page, page->index, page_off, len, snapc, snapc->seq);
 
 	if (atomic_long_inc_return(&fsc->writeback_count) >
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
@@ -732,19 +733,19 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 			wbc = &tmp_wbc;
 		if (err == -ERESTARTSYS) {
 			/* killed by SIGKILL */
-			dout("writepage interrupted page %p\n", page);
+			pr_debug("writepage interrupted page %p\n", page);
 			redirty_page_for_writepage(wbc, page);
 			end_page_writeback(page);
 			return err;
 		}
 		if (err == -EBLACKLISTED)
 			fsc->blacklisted = true;
-		dout("writepage setting page/mapping error %d %p\n",
-		     err, page);
+		pr_debug("writepage setting page/mapping error %d %p\n",
+			 err, page);
 		mapping_set_error(&inode->i_data, err);
 		wbc->pages_skipped++;
 	} else {
-		dout("writepage cleaned page %p\n", page);
+		pr_debug("writepage cleaned page %p\n", page);
 		err = 0;  /* vfs expects us to return 0 */
 	}
 	page->private = 0;
@@ -797,7 +798,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	bool remove_page;
 
-	dout("writepages_finish %p rc %d\n", inode, rc);
+	pr_debug("writepages_finish %p rc %d\n", inode, rc);
 	if (rc < 0) {
 		mapping_set_error(mapping, rc);
 		ceph_set_error_write(ci);
@@ -843,7 +844,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 			ceph_put_snap_context(page_snap_context(page));
 			page->private = 0;
 			ClearPagePrivate(page);
-			dout("unlocking %p\n", page);
+			pr_debug("unlocking %p\n", page);
 			end_page_writeback(page);
 
 			if (remove_page)
@@ -852,8 +853,8 @@ static void writepages_finish(struct ceph_osd_request *req)
 
 			unlock_page(page);
 		}
-		dout("writepages_finish %p wrote %llu bytes cleaned %d pages\n",
-		     inode, osd_data->length, rc >= 0 ? num_pages : 0);
+		pr_debug("writepages_finish %p wrote %llu bytes cleaned %d pages\n",
+			 inode, osd_data->length, rc >= 0 ? num_pages : 0);
 
 		release_pages(osd_data->pages, num_pages);
 	}
@@ -888,9 +889,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 	bool should_loop, range_whole = false;
 	bool done = false;
 
-	dout("writepages_start %p (mode=%s)\n", inode,
-	     wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
-	     (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
+	pr_debug("writepages_start %p (mode=%s)\n",
+		 inode,
+		 wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
+		 wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD");
 
 	if (READ_ONCE(fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
 		if (ci->i_wrbuffer_ref > 0) {
@@ -915,11 +917,11 @@ static int ceph_writepages_start(struct address_space *mapping,
 	if (!snapc) {
 		/* hmm, why does writepages get called when there
 		   is no dirty data? */
-		dout(" no snap context with dirty data?\n");
+		pr_debug("no snap context with dirty data?\n");
 		goto out;
 	}
-	dout(" oldest snapc is %p seq %lld (%d snaps)\n",
-	     snapc, snapc->seq, snapc->num_snaps);
+	pr_debug("oldest snapc is %p seq %lld (%d snaps)\n",
+		 snapc, snapc->seq, snapc->num_snaps);
 
 	should_loop = false;
 	if (ceph_wbc.head_snapc && snapc != last_snapc) {
@@ -929,13 +931,13 @@ static int ceph_writepages_start(struct address_space *mapping,
 			end = -1;
 			if (index > 0)
 				should_loop = true;
-			dout(" cyclic, start at %lu\n", index);
+			pr_debug("cyclic, start at %lu\n", index);
 		} else {
 			index = wbc->range_start >> PAGE_SHIFT;
 			end = wbc->range_end >> PAGE_SHIFT;
 			if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 				range_whole = true;
-			dout(" not cyclic, %lu to %lu\n", index, end);
+			pr_debug("not cyclic, %lu to %lu\n", index, end);
 		}
 	} else if (!ceph_wbc.head_snapc) {
 		/* Do not respect wbc->range_{start,end}. Dirty pages
@@ -944,7 +946,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 		 * associated with 'snapc' get written */
 		if (index > 0)
 			should_loop = true;
-		dout(" non-head snapc, range whole\n");
+		pr_debug("non-head snapc, range whole\n");
 	}
 
 	ceph_put_snap_context(last_snapc);
@@ -965,12 +967,12 @@ static int ceph_writepages_start(struct address_space *mapping,
 		pvec_pages = pagevec_lookup_range_nr_tag(&pvec, mapping, &index,
 						end, PAGECACHE_TAG_DIRTY,
 						max_pages - locked_pages);
-		dout("pagevec_lookup_range_tag got %d\n", pvec_pages);
+		pr_debug("pagevec_lookup_range_tag got %d\n", pvec_pages);
 		if (!pvec_pages && !locked_pages)
 			break;
 		for (i = 0; i < pvec_pages && locked_pages < max_pages; i++) {
 			page = pvec.pages[i];
-			dout("? %p idx %lu\n", page, page->index);
+			pr_debug("? %p idx %lu\n", page, page->index);
 			if (locked_pages == 0)
 				lock_page(page);  /* first page */
 			else if (!trylock_page(page))
@@ -979,15 +981,16 @@ static int ceph_writepages_start(struct address_space *mapping,
 			/* only dirty pages, or our accounting breaks */
 			if (unlikely(!PageDirty(page)) ||
 			    unlikely(page->mapping != mapping)) {
-				dout("!dirty or !mapping %p\n", page);
+				pr_debug("!dirty or !mapping %p\n", page);
 				unlock_page(page);
 				continue;
 			}
 			/* only if matching snap context */
 			pgsnapc = page_snap_context(page);
 			if (pgsnapc != snapc) {
-				dout("page snapc %p %lld != oldest %p %lld\n",
-				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
+				pr_debug("page snapc %p %lld != oldest %p %lld\n",
+					 pgsnapc, pgsnapc->seq,
+					 snapc, snapc->seq);
 				if (!should_loop &&
 				    !ceph_wbc.head_snapc &&
 				    wbc->sync_mode != WB_SYNC_NONE)
@@ -996,8 +999,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 				continue;
 			}
 			if (page_offset(page) >= ceph_wbc.i_size) {
-				dout("%p page eof %llu\n",
-				     page, ceph_wbc.i_size);
+				pr_debug("%p page eof %llu\n",
+					 page, ceph_wbc.i_size);
 				if ((ceph_wbc.size_stable ||
 				    page_offset(page) >= i_size_read(inode)) &&
 				    clear_page_dirty_for_io(page))
@@ -1007,22 +1010,22 @@ static int ceph_writepages_start(struct address_space *mapping,
 				continue;
 			}
 			if (strip_unit_end && (page->index > strip_unit_end)) {
-				dout("end of strip unit %p\n", page);
+				pr_debug("end of strip unit %p\n", page);
 				unlock_page(page);
 				break;
 			}
 			if (PageWriteback(page)) {
 				if (wbc->sync_mode == WB_SYNC_NONE) {
-					dout("%p under writeback\n", page);
+					pr_debug("%p under writeback\n", page);
 					unlock_page(page);
 					continue;
 				}
-				dout("waiting on writeback %p\n", page);
+				pr_debug("waiting on writeback %p\n", page);
 				wait_on_page_writeback(page);
 			}
 
 			if (!clear_page_dirty_for_io(page)) {
-				dout("%p !clear_page_dirty_for_io\n", page);
+				pr_debug("%p !clear_page_dirty_for_io\n", page);
 				unlock_page(page);
 				continue;
 			}
@@ -1077,8 +1080,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 			}
 
 			/* note position of first page in pvec */
-			dout("%p will write page %p idx %lu\n",
-			     inode, page, page->index);
+			pr_debug("%p will write page %p idx %lu\n",
+				 inode, page, page->index);
 
 			if (atomic_long_inc_return(&fsc->writeback_count) >
 			    CONGESTION_ON_THRESH(
@@ -1111,7 +1114,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 			if (pvec_pages && i == pvec_pages &&
 			    locked_pages < max_pages) {
-				dout("reached end pvec, trying for more\n");
+				pr_debug("reached end pvec, trying for more\n");
 				pagevec_release(&pvec);
 				goto get_more_pages;
 			}
@@ -1156,8 +1159,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 					break;
 				osd_req_op_extent_dup_last(req, op_idx,
 							   cur_offset - offset);
-				dout("writepages got pages at %llu~%llu\n",
-				     offset, len);
+				pr_debug("writepages got pages at %llu~%llu\n",
+					 offset, len);
 				osd_req_op_extent_osd_data_pages(req, op_idx,
 							data_pages, len, 0,
 							from_pool, false);
@@ -1184,7 +1187,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 							 offset);
 			len = max(len, min_len);
 		}
-		dout("writepages got pages at %llu~%llu\n", offset, len);
+		pr_debug("writepages got pages at %llu~%llu\n", offset, len);
 
 		osd_req_op_extent_osd_data_pages(req, op_idx, data_pages, len,
 						 0, from_pool, false);
@@ -1237,14 +1240,14 @@ static int ceph_writepages_start(struct address_space *mapping,
 			done = true;
 
 release_pvec_pages:
-		dout("pagevec_release on %d pages (%p)\n", (int)pvec.nr,
-		     pvec.nr ? pvec.pages[0] : NULL);
+		pr_debug("pagevec_release on %d pages (%p)\n",
+			 (int)pvec.nr, pvec.nr ? pvec.pages[0] : NULL);
 		pagevec_release(&pvec);
 	}
 
 	if (should_loop && !done) {
 		/* more to do; loop back to beginning of file */
-		dout("writepages looping back to beginning of file\n");
+		pr_debug("writepages looping back to beginning of file\n");
 		end = start_index - 1; /* OK even when start_index == 0 */
 
 		/* to write dirty pages associated with next snapc,
@@ -1280,7 +1283,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 out:
 	ceph_osdc_put_request(req);
 	ceph_put_snap_context(last_snapc);
-	dout("writepages dend - startone, rc = %d\n", rc);
+	pr_debug("writepages dend - startone, rc = %d\n", rc);
 	return rc;
 }
 
@@ -1322,7 +1325,7 @@ static int ceph_update_writeable_page(struct file *file,
 	struct ceph_snap_context *snapc, *oldest;
 
 	if (READ_ONCE(fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
-		dout(" page %p forced umount\n", page);
+		pr_debug("page %p forced umount\n", page);
 		unlock_page(page);
 		return -EIO;
 	}
@@ -1340,8 +1343,8 @@ static int ceph_update_writeable_page(struct file *file,
 		oldest = get_oldest_context(inode, NULL, NULL);
 		if (snapc->seq > oldest->seq) {
 			ceph_put_snap_context(oldest);
-			dout(" page %p snapc %p not current or oldest\n",
-			     page, snapc);
+			pr_debug("page %p snapc %p not current or oldest\n",
+				 page, snapc);
 			/*
 			 * queue for writeback, and wait for snapc to
 			 * be writeable or written
@@ -1359,8 +1362,8 @@ static int ceph_update_writeable_page(struct file *file,
 		ceph_put_snap_context(oldest);
 
 		/* yay, writeable, do it now (without dropping page lock) */
-		dout(" page %p snapc %p not current, but oldest\n",
-		     page, snapc);
+		pr_debug("page %p snapc %p not current, but oldest\n",
+			 page, snapc);
 		if (!clear_page_dirty_for_io(page))
 			goto retry_locked;
 		r = writepage_nounlock(page, NULL);
@@ -1370,7 +1373,7 @@ static int ceph_update_writeable_page(struct file *file,
 	}
 
 	if (PageUptodate(page)) {
-		dout(" page %p already uptodate\n", page);
+		pr_debug("page %p already uptodate\n", page);
 		return 0;
 	}
 
@@ -1384,8 +1387,8 @@ static int ceph_update_writeable_page(struct file *file,
 	if (page_off >= i_size ||
 	    (pos_in_page == 0 && (pos+len) >= i_size &&
 	     end_in_page - pos_in_page != PAGE_SIZE)) {
-		dout(" zeroing %p 0 - %d and %d - %d\n",
-		     page, pos_in_page, end_in_page, (int)PAGE_SIZE);
+		pr_debug("zeroing %p 0 - %d and %d - %d\n",
+			 page, pos_in_page, end_in_page, (int)PAGE_SIZE);
 		zero_user_segments(page,
 				   0, pos_in_page,
 				   end_in_page, PAGE_SIZE);
@@ -1424,8 +1427,8 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 		if (!page)
 			return -ENOMEM;
 
-		dout("write_begin file %p inode %p page %p %d~%d\n", file,
-		     inode, page, (int)pos, (int)len);
+		pr_debug("write_begin file %p inode %p page %p %d~%d\n",
+			 file, inode, page, (int)pos, (int)len);
 
 		r = ceph_update_writeable_page(file, pos, len, page);
 		if (r < 0)
@@ -1448,8 +1451,8 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 	struct inode *inode = file_inode(file);
 	bool check_cap = false;
 
-	dout("write_end file %p inode %p page %p %d~%d (%d)\n", file,
-	     inode, page, (int)pos, (int)copied, (int)len);
+	pr_debug("write_end file %p inode %p page %p %d~%d (%d)\n",
+		 file, inode, page, (int)pos, (int)copied, (int)len);
 
 	/* zero the stale part of the page if we did a short copy */
 	if (!PageUptodate(page)) {
@@ -1529,8 +1532,8 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 
 	ceph_block_sigs(&oldset);
 
-	dout("filemap_fault %p %llx.%llx %llu~%zd trying to get caps\n",
-	     inode, ceph_vinop(inode), off, (size_t)PAGE_SIZE);
+	pr_debug("filemap_fault %p %llx.%llx %llu~%zd trying to get caps\n",
+		 inode, ceph_vinop(inode), off, (size_t)PAGE_SIZE);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
 	else
@@ -1542,8 +1545,8 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 	if (err < 0)
 		goto out_restore;
 
-	dout("filemap_fault %p %llu~%zd got cap refs on %s\n",
-	     inode, off, (size_t)PAGE_SIZE, ceph_cap_string(got));
+	pr_debug("filemap_fault %p %llu~%zd got cap refs on %s\n",
+		 inode, off, (size_t)PAGE_SIZE, ceph_cap_string(got));
 
 	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) ||
 	    ci->i_inline_version == CEPH_INLINE_NONE) {
@@ -1551,9 +1554,9 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		ceph_add_rw_context(fi, &rw_ctx);
 		ret = filemap_fault(vmf);
 		ceph_del_rw_context(fi, &rw_ctx);
-		dout("filemap_fault %p %llu~%zd drop cap refs %s ret %x\n",
-			inode, off, (size_t)PAGE_SIZE,
-				ceph_cap_string(got), ret);
+		pr_debug("filemap_fault %p %llu~%zd drop cap refs %s ret %x\n",
+			 inode, off, (size_t)PAGE_SIZE,
+			 ceph_cap_string(got), ret);
 	} else
 		err = -EAGAIN;
 
@@ -1593,8 +1596,8 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		vmf->page = page;
 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
 out_inline:
-		dout("filemap_fault %p %llu~%zd read inline data ret %x\n",
-		     inode, off, (size_t)PAGE_SIZE, ret);
+		pr_debug("filemap_fault %p %llu~%zd read inline data ret %x\n",
+			 inode, off, (size_t)PAGE_SIZE, ret);
 	}
 out_restore:
 	ceph_restore_sigs(&oldset);
@@ -1647,8 +1650,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	else
 		len = size & ~PAGE_MASK;
 
-	dout("page_mkwrite %p %llx.%llx %llu~%zd getting caps i_size %llu\n",
-	     inode, ceph_vinop(inode), off, len, size);
+	pr_debug("page_mkwrite %p %llx.%llx %llu~%zd getting caps i_size %llu\n",
+		 inode, ceph_vinop(inode), off, len, size);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
 	else
@@ -1660,8 +1663,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	if (err < 0)
 		goto out_free;
 
-	dout("page_mkwrite %p %llu~%zd got cap refs on %s\n",
-	     inode, off, len, ceph_cap_string(got));
+	pr_debug("page_mkwrite %p %llu~%zd got cap refs on %s\n",
+		 inode, off, len, ceph_cap_string(got));
 
 	/* Update time before taking page lock */
 	file_update_time(vma->vm_file);
@@ -1696,8 +1699,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 			__mark_inode_dirty(inode, dirty);
 	}
 
-	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
-	     inode, off, len, ceph_cap_string(got), ret);
+	pr_debug("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
+		 inode, off, len, ceph_cap_string(got), ret);
 	ceph_put_cap_refs(ci, got);
 out_free:
 	ceph_restore_sigs(&oldset);
@@ -1731,8 +1734,8 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 		}
 	}
 
-	dout("fill_inline_data %p %llx.%llx len %zu locked_page %p\n",
-	     inode, ceph_vinop(inode), len, locked_page);
+	pr_debug("fill_inline_data %p %llx.%llx len %zu locked_page %p\n",
+		 inode, ceph_vinop(inode), len, locked_page);
 
 	if (len > 0) {
 		void *kaddr = kmap_atomic(page);
@@ -1767,8 +1770,8 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 	inline_version = ci->i_inline_version;
 	spin_unlock(&ci->i_ceph_lock);
 
-	dout("uninline_data %p %llx.%llx inline_version %llu\n",
-	     inode, ceph_vinop(inode), inline_version);
+	pr_debug("uninline_data %p %llx.%llx inline_version %llu\n",
+		 inode, ceph_vinop(inode), inline_version);
 
 	if (inline_version == 1 || /* initial version, no data */
 	    inline_version == CEPH_INLINE_NONE)
@@ -1884,8 +1887,8 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 			__free_pages(page, 0);
 	}
 
-	dout("uninline_data %p %llx.%llx inline_version %llu = %d\n",
-	     inode, ceph_vinop(inode), inline_version, err);
+	pr_debug("uninline_data %p %llx.%llx inline_version %llu = %d\n",
+		 inode, ceph_vinop(inode), inline_version, err);
 	return err;
 }
 
@@ -1949,10 +1952,11 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 		goto out;
 
 	if (pool_ns)
-		dout("__ceph_pool_perm_get pool %lld ns %.*s no perm cached\n",
-		     pool, (int)pool_ns->len, pool_ns->str);
+		pr_debug("__ceph_pool_perm_get pool %lld ns %.*s no perm cached\n",
+			 pool, (int)pool_ns->len, pool_ns->str);
 	else
-		dout("__ceph_pool_perm_get pool %lld no perm cached\n", pool);
+		pr_debug("__ceph_pool_perm_get pool %lld no perm cached\n",
+			 pool);
 
 	down_write(&mdsc->pool_perm_rwsem);
 	p = &mdsc->pool_perm_tree.rb_node;
@@ -2079,10 +2083,11 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 	if (!err)
 		err = have;
 	if (pool_ns)
-		dout("__ceph_pool_perm_get pool %lld ns %.*s result = %d\n",
-		     pool, (int)pool_ns->len, pool_ns->str, err);
+		pr_debug("__ceph_pool_perm_get pool %lld ns %.*s result = %d\n",
+			 pool, (int)pool_ns->len, pool_ns->str, err);
 	else
-		dout("__ceph_pool_perm_get pool %lld result = %d\n", pool, err);
+		pr_debug("__ceph_pool_perm_get pool %lld result = %d\n",
+			 pool, err);
 	return err;
 }
 
@@ -2113,13 +2118,13 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 check:
 	if (flags & CEPH_I_POOL_PERM) {
 		if ((need & CEPH_CAP_FILE_RD) && !(flags & CEPH_I_POOL_RD)) {
-			dout("ceph_pool_perm_check pool %lld no read perm\n",
-			     pool);
+			pr_debug("ceph_pool_perm_check pool %lld no read perm\n",
+				 pool);
 			return -EPERM;
 		}
 		if ((need & CEPH_CAP_FILE_WR) && !(flags & CEPH_I_POOL_WR)) {
-			dout("ceph_pool_perm_check pool %lld no write perm\n",
-			     pool);
+			pr_debug("ceph_pool_perm_check pool %lld no write perm\n",
+				 pool);
 			return -EPERM;
 		}
 		return 0;
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 2f5cb6bc78e1..59c1083d00dd 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -125,7 +125,7 @@ static enum fscache_checkaux ceph_fscache_inode_check_aux(
 	if (memcmp(data, &aux, sizeof(aux)) != 0)
 		return FSCACHE_CHECKAUX_OBSOLETE;
 
-	dout("ceph inode 0x%p cached okay\n", ci);
+	pr_debug("ceph inode 0x%p cached okay\n", ci);
 	return FSCACHE_CHECKAUX_OKAY;
 }
 
@@ -191,16 +191,16 @@ void ceph_fscache_file_set_cookie(struct inode *inode, struct file *filp)
 		return;
 
 	if (inode_is_open_for_write(inode)) {
-		dout("fscache_file_set_cookie %p %p disabling cache\n",
-		     inode, filp);
+		pr_debug("fscache_file_set_cookie %p %p disabling cache\n",
+			 inode, filp);
 		fscache_disable_cookie(ci->fscache, &ci->i_vino, false);
 		fscache_uncache_all_inode_pages(ci->fscache, inode);
 	} else {
 		fscache_enable_cookie(ci->fscache, &ci->i_vino, i_size_read(inode),
 				      ceph_fscache_can_enable, inode);
 		if (fscache_cookie_enabled(ci->fscache)) {
-			dout("fscache_file_set_cookie %p %p enabling cache\n",
-			     inode, filp);
+			pr_debug("fscache_file_set_cookie %p %p enabling cache\n",
+				 inode, filp);
 		}
 	}
 }
@@ -238,14 +238,14 @@ int ceph_readpage_from_fscache(struct inode *inode, struct page *page)
 
 	switch (ret) {
 		case 0: /* Page found */
-			dout("page read submitted\n");
+			pr_debug("page read submitted\n");
 			return 0;
 		case -ENOBUFS: /* Pages were not found, and can't be */
 		case -ENODATA: /* Pages were not found */
-			dout("page/inode not in cache\n");
+			pr_debug("page/inode not in cache\n");
 			return ret;
 		default:
-			dout("%s: unknown error ret = %i\n", __func__, ret);
+			pr_debug("%s: unknown error ret = %i\n", __func__, ret);
 			return ret;
 	}
 }
@@ -267,14 +267,14 @@ int ceph_readpages_from_fscache(struct inode *inode,
 
 	switch (ret) {
 		case 0: /* All pages found */
-			dout("all-page read submitted\n");
+			pr_debug("all-page read submitted\n");
 			return 0;
 		case -ENOBUFS: /* Some pages were not found, and can't be */
 		case -ENODATA: /* some pages were not found */
-			dout("page/inode not in cache\n");
+			pr_debug("page/inode not in cache\n");
 			return ret;
 		default:
-			dout("%s: unknown error ret = %i\n", __func__, ret);
+			pr_debug("%s: unknown error ret = %i\n", __func__, ret);
 			return ret;
 	}
 }
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 55ccccf77cea..727b71b0ba1e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -184,10 +184,10 @@ static void __ceph_unreserve_caps(struct ceph_mds_client *mdsc, int nr_caps)
 			mdsc->caps_avail_count += nr_caps;
 		}
 
-		dout("%s: caps %d = %d used + %d resv + %d avail\n",
-		     __func__,
-		     mdsc->caps_total_count, mdsc->caps_use_count,
-		     mdsc->caps_reserve_count, mdsc->caps_avail_count);
+		pr_debug("%s: caps %d = %d used + %d resv + %d avail\n",
+			 __func__,
+			 mdsc->caps_total_count, mdsc->caps_use_count,
+			 mdsc->caps_reserve_count, mdsc->caps_avail_count);
 		BUG_ON(mdsc->caps_total_count != mdsc->caps_use_count +
 						 mdsc->caps_reserve_count +
 						 mdsc->caps_avail_count);
@@ -210,7 +210,7 @@ int ceph_reserve_caps(struct ceph_mds_client *mdsc,
 	struct ceph_mds_session *s;
 	LIST_HEAD(newcaps);
 
-	dout("reserve caps ctx=%p need=%d\n", ctx, need);
+	pr_debug("reserve caps ctx=%p need=%d\n", ctx, need);
 
 	/* first reserve any caps that are already allocated */
 	spin_lock(&mdsc->caps_list_lock);
@@ -296,9 +296,9 @@ int ceph_reserve_caps(struct ceph_mds_client *mdsc,
 
 	spin_unlock(&mdsc->caps_list_lock);
 
-	dout("reserve caps ctx=%p %d = %d used + %d resv + %d avail\n",
-	     ctx, mdsc->caps_total_count, mdsc->caps_use_count,
-	     mdsc->caps_reserve_count, mdsc->caps_avail_count);
+	pr_debug("reserve caps ctx=%p %d = %d used + %d resv + %d avail\n",
+		 ctx, mdsc->caps_total_count, mdsc->caps_use_count,
+		 mdsc->caps_reserve_count, mdsc->caps_avail_count);
 	return err;
 }
 
@@ -309,7 +309,7 @@ void ceph_unreserve_caps(struct ceph_mds_client *mdsc,
 	if (!ctx->count)
 		return;
 
-	dout("unreserve caps ctx=%p count=%d\n", ctx, ctx->count);
+	pr_debug("unreserve caps ctx=%p count=%d\n", ctx, ctx->count);
 	spin_lock(&mdsc->caps_list_lock);
 	__ceph_unreserve_caps(mdsc, ctx->count);
 	ctx->count = 0;
@@ -357,9 +357,9 @@ struct ceph_cap *ceph_get_cap(struct ceph_mds_client *mdsc,
 	}
 
 	spin_lock(&mdsc->caps_list_lock);
-	dout("get_cap ctx=%p (%d) %d = %d used + %d resv + %d avail\n",
-	     ctx, ctx->count, mdsc->caps_total_count, mdsc->caps_use_count,
-	     mdsc->caps_reserve_count, mdsc->caps_avail_count);
+	pr_debug("get_cap ctx=%p (%d) %d = %d used + %d resv + %d avail\n",
+		 ctx, ctx->count, mdsc->caps_total_count, mdsc->caps_use_count,
+		 mdsc->caps_reserve_count, mdsc->caps_avail_count);
 	BUG_ON(!ctx->count);
 	BUG_ON(ctx->count > mdsc->caps_reserve_count);
 	BUG_ON(list_empty(&mdsc->caps_list));
@@ -381,9 +381,9 @@ struct ceph_cap *ceph_get_cap(struct ceph_mds_client *mdsc,
 void ceph_put_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap)
 {
 	spin_lock(&mdsc->caps_list_lock);
-	dout("put_cap %p %d = %d used + %d resv + %d avail\n",
-	     cap, mdsc->caps_total_count, mdsc->caps_use_count,
-	     mdsc->caps_reserve_count, mdsc->caps_avail_count);
+	pr_debug("put_cap %p %d = %d used + %d resv + %d avail\n",
+		 cap, mdsc->caps_total_count, mdsc->caps_use_count,
+		 mdsc->caps_reserve_count, mdsc->caps_avail_count);
 	mdsc->caps_use_count--;
 	/*
 	 * Keep some preallocated caps around (ceph_min_count), to
@@ -492,8 +492,8 @@ static void __cap_set_timeouts(struct ceph_mds_client *mdsc,
 	struct ceph_mount_options *opt = mdsc->fsc->mount_options;
 	ci->i_hold_caps_max = round_jiffies(jiffies +
 					    opt->caps_wanted_delay_max * HZ);
-	dout("__cap_set_timeouts %p %lu\n", &ci->vfs_inode,
-	     ci->i_hold_caps_max - jiffies);
+	pr_debug("__cap_set_timeouts %p %lu\n",
+		 &ci->vfs_inode, ci->i_hold_caps_max - jiffies);
 }
 
 /*
@@ -507,8 +507,8 @@ static void __cap_set_timeouts(struct ceph_mds_client *mdsc,
 static void __cap_delay_requeue(struct ceph_mds_client *mdsc,
 				struct ceph_inode_info *ci)
 {
-	dout("__cap_delay_requeue %p flags 0x%lx at %lu\n", &ci->vfs_inode,
-	     ci->i_ceph_flags, ci->i_hold_caps_max);
+	pr_debug("__cap_delay_requeue %p flags 0x%lx at %lu\n",
+		 &ci->vfs_inode, ci->i_ceph_flags, ci->i_hold_caps_max);
 	if (!mdsc->stopping) {
 		spin_lock(&mdsc->cap_delay_lock);
 		if (!list_empty(&ci->i_cap_delay_list)) {
@@ -531,7 +531,7 @@ static void __cap_delay_requeue(struct ceph_mds_client *mdsc,
 static void __cap_delay_requeue_front(struct ceph_mds_client *mdsc,
 				      struct ceph_inode_info *ci)
 {
-	dout("__cap_delay_requeue_front %p\n", &ci->vfs_inode);
+	pr_debug("__cap_delay_requeue_front %p\n", &ci->vfs_inode);
 	spin_lock(&mdsc->cap_delay_lock);
 	ci->i_ceph_flags |= CEPH_I_FLUSH;
 	if (!list_empty(&ci->i_cap_delay_list))
@@ -548,7 +548,7 @@ static void __cap_delay_requeue_front(struct ceph_mds_client *mdsc,
 static void __cap_delay_cancel(struct ceph_mds_client *mdsc,
 			       struct ceph_inode_info *ci)
 {
-	dout("__cap_delay_cancel %p\n", &ci->vfs_inode);
+	pr_debug("__cap_delay_cancel %p\n", &ci->vfs_inode);
 	if (list_empty(&ci->i_cap_delay_list))
 		return;
 	spin_lock(&mdsc->cap_delay_lock);
@@ -584,7 +584,7 @@ static void __check_cap_issue(struct ceph_inode_info *ci, struct ceph_cap *cap,
 		if (issued & CEPH_CAP_FILE_SHARED)
 			atomic_inc(&ci->i_shared_gen);
 		if (S_ISDIR(ci->vfs_inode.i_mode)) {
-			dout(" marking %p NOT complete\n", &ci->vfs_inode);
+			pr_debug("marking %p NOT complete\n", &ci->vfs_inode);
 			__ceph_dir_clear_complete(ci);
 		}
 	}
@@ -642,8 +642,8 @@ void ceph_add_cap(struct inode *inode,
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	dout("add_cap %p mds%d cap %llx %s seq %d\n", inode,
-	     session->s_mds, cap_id, ceph_cap_string(issued), seq);
+	pr_debug("add_cap %p mds%d cap %llx %s seq %d\n",
+		 inode, session->s_mds, cap_id, ceph_cap_string(issued), seq);
 
 	spin_lock(&session->s_gen_ttl_lock);
 	gen = session->s_cap_gen;
@@ -740,9 +740,9 @@ void ceph_add_cap(struct inode *inode,
 	actual_wanted = __ceph_caps_wanted(ci);
 	if ((wanted & ~actual_wanted) ||
 	    (issued & ~actual_wanted & CEPH_CAP_ANY_WR)) {
-		dout(" issued %s, mds wanted %s, actual %s, queueing\n",
-		     ceph_cap_string(issued), ceph_cap_string(wanted),
-		     ceph_cap_string(actual_wanted));
+		pr_debug("issued %s, mds wanted %s, actual %s, queueing\n",
+			 ceph_cap_string(issued), ceph_cap_string(wanted),
+			 ceph_cap_string(actual_wanted));
 		__cap_delay_requeue(mdsc, ci);
 	}
 
@@ -759,9 +759,9 @@ void ceph_add_cap(struct inode *inode,
 		WARN_ON(ci->i_auth_cap == cap);
 	}
 
-	dout("add_cap inode %p (%llx.%llx) cap %p %s now %s seq %d mds%d\n",
-	     inode, ceph_vinop(inode), cap, ceph_cap_string(issued),
-	     ceph_cap_string(issued|cap->issued), seq, mds);
+	pr_debug("add_cap inode %p (%llx.%llx) cap %p %s now %s seq %d mds%d\n",
+		 inode, ceph_vinop(inode), cap, ceph_cap_string(issued),
+		 ceph_cap_string(issued | cap->issued), seq, mds);
 	cap->cap_id = cap_id;
 	cap->issued = issued;
 	cap->implemented |= issued;
@@ -791,9 +791,9 @@ static int __cap_is_valid(struct ceph_cap *cap)
 	spin_unlock(&cap->session->s_gen_ttl_lock);
 
 	if (cap->cap_gen < gen || time_after_eq(jiffies, ttl)) {
-		dout("__cap_is_valid %p cap %p issued %s "
-		     "but STALE (gen %u vs %u)\n", &cap->ci->vfs_inode,
-		     cap, ceph_cap_string(cap->issued), cap->cap_gen, gen);
+		pr_debug("__cap_is_valid %p cap %p issued %s but STALE (gen %u vs %u)\n",
+			 &cap->ci->vfs_inode,
+			 cap, ceph_cap_string(cap->issued), cap->cap_gen, gen);
 		return 0;
 	}
 
@@ -817,8 +817,8 @@ int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented)
 		cap = rb_entry(p, struct ceph_cap, ci_node);
 		if (!__cap_is_valid(cap))
 			continue;
-		dout("__ceph_caps_issued %p cap %p issued %s\n",
-		     &ci->vfs_inode, cap, ceph_cap_string(cap->issued));
+		pr_debug("__ceph_caps_issued %p cap %p issued %s\n",
+			 &ci->vfs_inode, cap, ceph_cap_string(cap->issued));
 		have |= cap->issued;
 		if (implemented)
 			*implemented |= cap->implemented;
@@ -865,12 +865,12 @@ static void __touch_cap(struct ceph_cap *cap)
 
 	spin_lock(&s->s_cap_lock);
 	if (!s->s_cap_iterator) {
-		dout("__touch_cap %p cap %p mds%d\n", &cap->ci->vfs_inode, cap,
-		     s->s_mds);
+		pr_debug("__touch_cap %p cap %p mds%d\n",
+			 &cap->ci->vfs_inode, cap, s->s_mds);
 		list_move_tail(&cap->session_caps, &s->s_caps);
 	} else {
-		dout("__touch_cap %p cap %p mds%d NOP, iterating over caps\n",
-		     &cap->ci->vfs_inode, cap, s->s_mds);
+		pr_debug("__touch_cap %p cap %p mds%d NOP, iterating over caps\n",
+			 &cap->ci->vfs_inode, cap, s->s_mds);
 	}
 	spin_unlock(&s->s_cap_lock);
 }
@@ -887,10 +887,10 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 	int have = ci->i_snap_caps;
 
 	if ((have & mask) == mask) {
-		dout("__ceph_caps_issued_mask ino 0x%lx snap issued %s"
-		     " (mask %s)\n", ci->vfs_inode.i_ino,
-		     ceph_cap_string(have),
-		     ceph_cap_string(mask));
+		pr_debug("__ceph_caps_issued_mask ino 0x%lx snap issued %s (mask %s)\n",
+			 ci->vfs_inode.i_ino,
+			 ceph_cap_string(have),
+			 ceph_cap_string(mask));
 		return 1;
 	}
 
@@ -899,10 +899,10 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 		if (!__cap_is_valid(cap))
 			continue;
 		if ((cap->issued & mask) == mask) {
-			dout("__ceph_caps_issued_mask ino 0x%lx cap %p issued %s"
-			     " (mask %s)\n", ci->vfs_inode.i_ino, cap,
-			     ceph_cap_string(cap->issued),
-			     ceph_cap_string(mask));
+			pr_debug("__ceph_caps_issued_mask ino 0x%lx cap %p issued %s (mask %s)\n",
+				 ci->vfs_inode.i_ino, cap,
+				 ceph_cap_string(cap->issued),
+				 ceph_cap_string(mask));
 			if (touch)
 				__touch_cap(cap);
 			return 1;
@@ -911,10 +911,10 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 		/* does a combination of caps satisfy mask? */
 		have |= cap->issued;
 		if ((have & mask) == mask) {
-			dout("__ceph_caps_issued_mask ino 0x%lx combo issued %s"
-			     " (mask %s)\n", ci->vfs_inode.i_ino,
-			     ceph_cap_string(cap->issued),
-			     ceph_cap_string(mask));
+			pr_debug("__ceph_caps_issued_mask ino 0x%lx combo issued %s (mask %s)\n",
+				 ci->vfs_inode.i_ino,
+				 ceph_cap_string(cap->issued),
+				 ceph_cap_string(mask));
 			if (touch) {
 				struct rb_node *q;
 
@@ -977,8 +977,8 @@ int ceph_caps_revoking(struct ceph_inode_info *ci, int mask)
 	spin_lock(&ci->i_ceph_lock);
 	ret = __ceph_caps_revoking_other(ci, NULL, mask);
 	spin_unlock(&ci->i_ceph_lock);
-	dout("ceph_caps_revoking %p %s = %d\n", inode,
-	     ceph_cap_string(mask), ret);
+	pr_debug("ceph_caps_revoking %p %s = %d\n",
+		 inode, ceph_cap_string(mask), ret);
 	return ret;
 }
 
@@ -1144,7 +1144,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 		ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
 	int removed = 0;
 
-	dout("__ceph_remove_cap %p from %p\n", cap, &ci->vfs_inode);
+	pr_debug("__ceph_remove_cap %p from %p\n", cap, &ci->vfs_inode);
 
 	/* remove from inode's cap rbtree, and clear auth cap */
 	rb_erase(&cap->ci_node, &ci->i_caps);
@@ -1157,8 +1157,8 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	spin_lock(&session->s_cap_lock);
 	if (session->s_cap_iterator == cap) {
 		/* not yet, we are iterating over this very cap */
-		dout("__ceph_remove_cap  delaying %p removal from session %p\n",
-		     cap, cap->session);
+		pr_debug("__ceph_remove_cap  delaying %p removal from session %p\n",
+			 cap, cap->session);
 	} else {
 		list_del_init(&cap->session_caps);
 		session->s_nr_caps--;
@@ -1234,15 +1234,14 @@ static int send_cap_msg(struct cap_msg_args *arg)
 	size_t extra_len;
 	struct ceph_osd_client *osdc = &arg->session->s_mdsc->fsc->client->osdc;
 
-	dout("send_cap_msg %s %llx %llx caps %s wanted %s dirty %s"
-	     " seq %u/%u tid %llu/%llu mseq %u follows %lld size %llu/%llu"
-	     " xattr_ver %llu xattr_len %d\n", ceph_cap_op_name(arg->op),
-	     arg->cid, arg->ino, ceph_cap_string(arg->caps),
-	     ceph_cap_string(arg->wanted), ceph_cap_string(arg->dirty),
-	     arg->seq, arg->issue_seq, arg->flush_tid, arg->oldest_flush_tid,
-	     arg->mseq, arg->follows, arg->size, arg->max_size,
-	     arg->xattr_version,
-	     arg->xattr_buf ? (int)arg->xattr_buf->vec.iov_len : 0);
+	pr_debug("send_cap_msg %s %llx %llx caps %s wanted %s dirty %s seq %u/%u tid %llu/%llu mseq %u follows %lld size %llu/%llu xattr_ver %llu xattr_len %d\n",
+		 ceph_cap_op_name(arg->op),
+		 arg->cid, arg->ino, ceph_cap_string(arg->caps),
+		 ceph_cap_string(arg->wanted), ceph_cap_string(arg->dirty),
+		 arg->seq, arg->issue_seq, arg->flush_tid, arg->oldest_flush_tid,
+		 arg->mseq, arg->follows, arg->size, arg->max_size,
+		 arg->xattr_version,
+		 arg->xattr_buf ? (int)arg->xattr_buf->vec.iov_len : 0);
 
 	/* flock buffer size + inline version + inline data size +
 	 * osd_epoch_barrier + oldest_flush_tid */
@@ -1369,10 +1368,10 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	revoking = cap->implemented & ~cap->issued;
 	retain &= ~revoking;
 
-	dout("%s %p cap %p session %p %s -> %s (revoking %s)\n",
-	     __func__, inode, cap, cap->session,
-	     ceph_cap_string(held), ceph_cap_string(held & retain),
-	     ceph_cap_string(revoking));
+	pr_debug("%s %p cap %p session %p %s -> %s (revoking %s)\n",
+		 __func__, inode, cap, cap->session,
+		 ceph_cap_string(held), ceph_cap_string(held & retain),
+		 ceph_cap_string(revoking));
 	BUG_ON((retain & CEPH_CAP_PIN) == 0);
 
 	ci->i_ceph_flags &= ~CEPH_I_FLUSH;
@@ -1544,7 +1543,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 	u64 oldest_flush_tid = 0;
 	u64 first_tid = 1, last_tid = 0;
 
-	dout("__flush_snaps %p session %p\n", inode, session);
+	pr_debug("__flush_snaps %p session %p\n", inode, session);
 
 	list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
 		/*
@@ -1559,7 +1558,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 
 		/* only flush each capsnap once */
 		if (capsnap->cap_flush.tid > 0) {
-			dout(" already flushed %p, skipping\n", capsnap);
+			pr_debug("already flushed %p, skipping\n", capsnap);
 			continue;
 		}
 
@@ -1591,8 +1590,8 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 		int ret;
 
 		if (!(cap && cap->session == session)) {
-			dout("__flush_snaps %p auth cap %p not mds%d, "
-			     "stop\n", inode, cap, session->s_mds);
+			pr_debug("__flush_snaps %p auth cap %p not mds%d, stop\n",
+				 inode, cap, session->s_mds);
 			break;
 		}
 
@@ -1612,8 +1611,9 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 		refcount_inc(&capsnap->nref);
 		spin_unlock(&ci->i_ceph_lock);
 
-		dout("__flush_snaps %p capsnap %p tid %llu %s\n",
-		     inode, capsnap, cf->tid, ceph_cap_string(capsnap->dirty));
+		pr_debug("__flush_snaps %p capsnap %p tid %llu %s\n",
+			 inode, capsnap, cf->tid,
+			 ceph_cap_string(capsnap->dirty));
 
 		ret = __send_flush_snap(inode, session, capsnap, cap->mseq,
 					oldest_flush_tid);
@@ -1636,23 +1636,23 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 	struct ceph_mds_session *session = NULL;
 	int mds;
 
-	dout("ceph_flush_snaps %p\n", inode);
+	pr_debug("ceph_flush_snaps %p\n", inode);
 	if (psession)
 		session = *psession;
 retry:
 	spin_lock(&ci->i_ceph_lock);
 	if (!(ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS)) {
-		dout(" no capsnap needs flush, doing nothing\n");
+		pr_debug("no capsnap needs flush, doing nothing\n");
 		goto out;
 	}
 	if (!ci->i_auth_cap) {
-		dout(" no auth cap (migrating?), doing nothing\n");
+		pr_debug("no auth cap (migrating?), doing nothing\n");
 		goto out;
 	}
 
 	mds = ci->i_auth_cap->session->s_mds;
 	if (session && session->s_mds != mds) {
-		dout(" oops, wrong session %p mutex\n", session);
+		pr_debug("oops, wrong session %p mutex\n", session);
 		mutex_unlock(&session->s_mutex);
 		ceph_put_mds_session(session);
 		session = NULL;
@@ -1663,7 +1663,8 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 		session = __ceph_lookup_mds_session(mdsc, mds);
 		mutex_unlock(&mdsc->mutex);
 		if (session) {
-			dout(" inverting session/ino locks on %p\n", session);
+			pr_debug("inverting session/ino locks on %p\n",
+				 session);
 			mutex_lock(&session->s_mutex);
 		}
 		goto retry;
@@ -1712,9 +1713,10 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask,
 		return 0;
 	}
 
-	dout("__mark_dirty_caps %p %s dirty %s -> %s\n", &ci->vfs_inode,
-	     ceph_cap_string(mask), ceph_cap_string(was),
-	     ceph_cap_string(was | mask));
+	pr_debug("__mark_dirty_caps %p %s dirty %s -> %s\n",
+		 &ci->vfs_inode,
+		 ceph_cap_string(mask), ceph_cap_string(was),
+		 ceph_cap_string(was | mask));
 	ci->i_dirty_caps |= mask;
 	if (was == 0) {
 		struct ceph_mds_session *session = ci->i_auth_cap->session;
@@ -1727,8 +1729,8 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask,
 			ci->i_head_snapc = ceph_get_snap_context(
 				ci->i_snap_realm->cached_context);
 		}
-		dout(" inode %p now dirty snapc %p auth cap %p\n",
-		     &ci->vfs_inode, ci->i_head_snapc, ci->i_auth_cap);
+		pr_debug("inode %p now dirty snapc %p auth cap %p\n",
+			 &ci->vfs_inode, ci->i_head_snapc, ci->i_auth_cap);
 		BUG_ON(!list_empty(&ci->i_dirty_item));
 		spin_lock(&mdsc->cap_dirty_lock);
 		list_add(&ci->i_dirty_item, &session->s_cap_dirty);
@@ -1825,13 +1827,13 @@ static u64 __mark_caps_flushing(struct inode *inode,
 	BUG_ON(!ci->i_prealloc_cap_flush);
 
 	flushing = ci->i_dirty_caps;
-	dout("__mark_caps_flushing flushing %s, flushing_caps %s -> %s\n",
-	     ceph_cap_string(flushing),
-	     ceph_cap_string(ci->i_flushing_caps),
-	     ceph_cap_string(ci->i_flushing_caps | flushing));
+	pr_debug("__mark_caps_flushing flushing %s, flushing_caps %s -> %s\n",
+		 ceph_cap_string(flushing),
+		 ceph_cap_string(ci->i_flushing_caps),
+		 ceph_cap_string(ci->i_flushing_caps | flushing));
 	ci->i_flushing_caps |= flushing;
 	ci->i_dirty_caps = 0;
-	dout(" inode %p now !dirty\n", inode);
+	pr_debug("inode %p now !dirty\n", inode);
 
 	swap(cf, ci->i_prealloc_cap_flush);
 	cf->caps = flushing;
@@ -1870,12 +1872,12 @@ static int try_nonblocking_invalidate(struct inode *inode)
 	if (inode->i_data.nrpages == 0 &&
 	    invalidating_gen == ci->i_rdcache_gen) {
 		/* success. */
-		dout("try_nonblocking_invalidate %p success\n", inode);
+		pr_debug("try_nonblocking_invalidate %p success\n", inode);
 		/* save any racing async invalidate some trouble */
 		ci->i_rdcache_revoking = ci->i_rdcache_gen - 1;
 		return 0;
 	}
-	dout("try_nonblocking_invalidate %p failed\n", inode);
+	pr_debug("try_nonblocking_invalidate %p failed\n", inode);
 	return -1;
 }
 
@@ -1966,15 +1968,15 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 		}
 	}
 
-	dout("check_caps %p file_want %s used %s dirty %s flushing %s"
-	     " issued %s revoking %s retain %s %s%s\n", inode,
-	     ceph_cap_string(file_wanted),
-	     ceph_cap_string(used), ceph_cap_string(ci->i_dirty_caps),
-	     ceph_cap_string(ci->i_flushing_caps),
-	     ceph_cap_string(issued), ceph_cap_string(revoking),
-	     ceph_cap_string(retain),
-	     (flags & CHECK_CAPS_AUTHONLY) ? " AUTHONLY" : "",
-	     (flags & CHECK_CAPS_FLUSH) ? " FLUSH" : "");
+	pr_debug("check_caps %p file_want %s used %s dirty %s flushing %s issued %s revoking %s retain %s %s%s\n",
+		 inode,
+		 ceph_cap_string(file_wanted),
+		 ceph_cap_string(used), ceph_cap_string(ci->i_dirty_caps),
+		 ceph_cap_string(ci->i_flushing_caps),
+		 ceph_cap_string(issued), ceph_cap_string(revoking),
+		 ceph_cap_string(retain),
+		 (flags & CHECK_CAPS_AUTHONLY) ? " AUTHONLY" : "",
+		 (flags & CHECK_CAPS_FLUSH) ? " FLUSH" : "");
 
 	/*
 	 * If we no longer need to hold onto old our caps, and we may
@@ -1988,9 +1990,9 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 	    (revoking & (CEPH_CAP_FILE_CACHE|
 			 CEPH_CAP_FILE_LAZYIO)) && /*  or revoking cache */
 	    !tried_invalidate) {
-		dout("check_caps trying to invalidate on %p\n", inode);
+		pr_debug("check_caps trying to invalidate on %p\n", inode);
 		if (try_nonblocking_invalidate(inode) < 0) {
-			dout("check_caps queuing invalidate\n");
+			pr_debug("check_caps queuing invalidate\n");
 			queue_invalidate = true;
 			ci->i_rdcache_revoking = ci->i_rdcache_gen;
 		}
@@ -2016,43 +2018,43 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 			cap_used &= ~ci->i_auth_cap->issued;
 
 		revoking = cap->implemented & ~cap->issued;
-		dout(" mds%d cap %p used %s issued %s implemented %s revoking %s\n",
-		     cap->mds, cap, ceph_cap_string(cap_used),
-		     ceph_cap_string(cap->issued),
-		     ceph_cap_string(cap->implemented),
-		     ceph_cap_string(revoking));
+		pr_debug("mds%d cap %p used %s issued %s implemented %s revoking %s\n",
+			 cap->mds, cap, ceph_cap_string(cap_used),
+			 ceph_cap_string(cap->issued),
+			 ceph_cap_string(cap->implemented),
+			 ceph_cap_string(revoking));
 
 		if (cap == ci->i_auth_cap &&
 		    (cap->issued & CEPH_CAP_FILE_WR)) {
 			/* request larger max_size from MDS? */
 			if (ci->i_wanted_max_size > ci->i_max_size &&
 			    ci->i_wanted_max_size > ci->i_requested_max_size) {
-				dout("requesting new max_size\n");
+				pr_debug("requesting new max_size\n");
 				goto ack;
 			}
 
 			/* approaching file_max? */
 			if (__ceph_should_report_size(ci)) {
-				dout("i_size approaching max_size\n");
+				pr_debug("i_size approaching max_size\n");
 				goto ack;
 			}
 		}
 		/* flush anything dirty? */
 		if (cap == ci->i_auth_cap) {
 			if ((flags & CHECK_CAPS_FLUSH) && ci->i_dirty_caps) {
-				dout("flushing dirty caps\n");
+				pr_debug("flushing dirty caps\n");
 				goto ack;
 			}
 			if (ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS) {
-				dout("flushing snap caps\n");
+				pr_debug("flushing snap caps\n");
 				goto ack;
 			}
 		}
 
 		/* completed revocation? going down and there are no caps? */
 		if (revoking && (revoking & cap_used) == 0) {
-			dout("completed revocation of %s\n",
-			     ceph_cap_string(cap->implemented & ~cap->issued));
+			pr_debug("completed revocation of %s\n",
+				 ceph_cap_string(cap->implemented & ~cap->issued));
 			goto ack;
 		}
 
@@ -2070,15 +2072,15 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 
 ack:
 		if (session && session != cap->session) {
-			dout("oops, wrong session %p mutex\n", session);
+			pr_debug("oops, wrong session %p mutex\n", session);
 			mutex_unlock(&session->s_mutex);
 			session = NULL;
 		}
 		if (!session) {
 			session = cap->session;
 			if (mutex_trylock(&session->s_mutex) == 0) {
-				dout("inverting session/ino locks on %p\n",
-				     session);
+				pr_debug("inverting session/ino locks on %p\n",
+					 session);
 				session = ceph_get_mds_session(session);
 				spin_unlock(&ci->i_ceph_lock);
 				if (took_snap_rwsem) {
@@ -2117,8 +2119,8 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 		/* take snap_rwsem after session mutex */
 		if (!took_snap_rwsem) {
 			if (down_read_trylock(&mdsc->snap_rwsem) == 0) {
-				dout("inverting snap/in locks on %p\n",
-				     inode);
+				pr_debug("inverting snap/in locks on %p\n",
+					 inode);
 				spin_unlock(&ci->i_ceph_lock);
 				down_read(&mdsc->snap_rwsem);
 				took_snap_rwsem = 1;
@@ -2286,8 +2288,8 @@ static int unsafe_request_wait(struct inode *inode)
 	}
 	spin_unlock(&ci->i_unsafe_lock);
 
-	dout("unsafe_request_wait %p wait on tid %llu %llu\n",
-	     inode, req1 ? req1->r_tid : 0ULL, req2 ? req2->r_tid : 0ULL);
+	pr_debug("unsafe_request_wait %p wait on tid %llu %llu\n",
+		 inode, req1 ? req1->r_tid : 0ULL, req2 ? req2->r_tid : 0ULL);
 	if (req1) {
 		ret = !wait_for_completion_timeout(&req1->r_safe_completion,
 					ceph_timeout_jiffies(req1->r_timeout));
@@ -2314,7 +2316,7 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret, err;
 	int dirty;
 
-	dout("fsync %p%s\n", inode, datasync ? " datasync" : "");
+	pr_debug("fsync %p%s\n", inode, datasync ? " datasync" : "");
 
 	ret = file_write_and_wait_range(file, start, end);
 	if (datasync)
@@ -2325,7 +2327,7 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 
 	dirty = try_flush_caps(inode, &flush_tid);
-	dout("fsync dirty caps are %s\n", ceph_cap_string(dirty));
+	pr_debug("fsync dirty caps are %s\n", ceph_cap_string(dirty));
 
 	err = unsafe_request_wait(inode);
 
@@ -2351,7 +2353,8 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 			ret = err;
 	}
 out:
-	dout("fsync %p%s result=%d\n", inode, datasync ? " datasync" : "", ret);
+	pr_debug("fsync %p%s result=%d\n",
+		 inode, datasync ? " datasync" : "", ret);
 	return ret;
 }
 
@@ -2369,7 +2372,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 	int dirty;
 	int wait = (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync);
 
-	dout("write_inode %p wait=%d\n", inode, wait);
+	pr_debug("write_inode %p wait=%d\n", inode, wait);
 	if (wait) {
 		dirty = try_flush_caps(inode, &flush_tid);
 		if (dirty)
@@ -2426,8 +2429,8 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 		if (cf->caps) {
 			struct cap_msg_args arg;
 
-			dout("kick_flushing_caps %p cap %p tid %llu %s\n",
-			     inode, cap, cf->tid, ceph_cap_string(cf->caps));
+			pr_debug("kick_flushing_caps %p cap %p tid %llu %s\n",
+				 inode, cap, cf->tid, ceph_cap_string(cf->caps));
 			__prep_cap(&arg, cap, CEPH_CAP_OP_FLUSH,
 					 (cf->tid < last_snap_flush ?
 					  CEPH_CLIENT_CAPS_PENDING_CAPSNAP : 0),
@@ -2441,9 +2444,9 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 			struct ceph_cap_snap *capsnap =
 					container_of(cf, struct ceph_cap_snap,
 						    cap_flush);
-			dout("kick_flushing_caps %p capsnap %p tid %llu %s\n",
-			     inode, capsnap, cf->tid,
-			     ceph_cap_string(capsnap->dirty));
+			pr_debug("kick_flushing_caps %p capsnap %p tid %llu %s\n",
+				 inode, capsnap, cf->tid,
+				 ceph_cap_string(capsnap->dirty));
 
 			refcount_inc(&capsnap->nref);
 			spin_unlock(&ci->i_ceph_lock);
@@ -2472,7 +2475,7 @@ void ceph_early_kick_flushing_caps(struct ceph_mds_client *mdsc,
 	struct ceph_cap *cap;
 	u64 oldest_flush_tid;
 
-	dout("early_kick_flushing_caps mds%d\n", session->s_mds);
+	pr_debug("early_kick_flushing_caps mds%d\n", session->s_mds);
 
 	spin_lock(&mdsc->cap_dirty_lock);
 	oldest_flush_tid = __get_oldest_flush_tid(mdsc);
@@ -2522,7 +2525,7 @@ void ceph_kick_flushing_caps(struct ceph_mds_client *mdsc,
 
 	lockdep_assert_held(&session->s_mutex);
 
-	dout("kick_flushing_caps mds%d\n", session->s_mds);
+	pr_debug("kick_flushing_caps mds%d\n", session->s_mds);
 
 	spin_lock(&mdsc->cap_dirty_lock);
 	oldest_flush_tid = __get_oldest_flush_tid(mdsc);
@@ -2553,8 +2556,9 @@ void ceph_kick_flushing_inode_caps(struct ceph_mds_session *session,
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	dout("%s %p flushing %s\n", __func__, &ci->vfs_inode,
-	     ceph_cap_string(ci->i_flushing_caps));
+	pr_debug("%s %p flushing %s\n",
+		 __func__, &ci->vfs_inode,
+		 ceph_cap_string(ci->i_flushing_caps));
 
 	if (!list_empty(&ci->i_cap_flush_list)) {
 		u64 oldest_flush_tid;
@@ -2598,8 +2602,9 @@ void ceph_take_cap_refs(struct ceph_inode_info *ci, int got,
 		if (ci->i_wb_ref == 0)
 			ihold(&ci->vfs_inode);
 		ci->i_wb_ref++;
-		dout("%s %p wb %d -> %d (?)\n", __func__,
-		     &ci->vfs_inode, ci->i_wb_ref-1, ci->i_wb_ref);
+		pr_debug("%s %p wb %d -> %d (?)\n",
+			 __func__, &ci->vfs_inode,
+			 ci->i_wb_ref - 1, ci->i_wb_ref);
 	}
 }
 
@@ -2631,15 +2636,15 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 	int have, implemented;
 	bool snap_rwsem_locked = false;
 
-	dout("get_cap_refs %p need %s want %s\n", inode,
-	     ceph_cap_string(need), ceph_cap_string(want));
+	pr_debug("get_cap_refs %p need %s want %s\n",
+		 inode, ceph_cap_string(need), ceph_cap_string(want));
 
 again:
 	spin_lock(&ci->i_ceph_lock);
 
 	if ((flags & CHECK_FILELOCK) &&
 	    (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK)) {
-		dout("try_get_cap_refs %p error filelock\n", inode);
+		pr_debug("try_get_cap_refs %p error filelock\n", inode);
 		ret = -EIO;
 		goto out_unlock;
 	}
@@ -2659,8 +2664,8 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 
 	if (have & need & CEPH_CAP_FILE_WR) {
 		if (endoff >= 0 && endoff > (loff_t)ci->i_max_size) {
-			dout("get_cap_refs %p endoff %llu > maxsize %llu\n",
-			     inode, endoff, ci->i_max_size);
+			pr_debug("get_cap_refs %p endoff %llu > maxsize %llu\n",
+				 inode, endoff, ci->i_max_size);
 			if (endoff > ci->i_requested_max_size)
 				ret = ci->i_auth_cap ? -EFBIG : -ESTALE;
 			goto out_unlock;
@@ -2670,7 +2675,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 		 * can get a final snapshot value for size+mtime.
 		 */
 		if (__ceph_have_pending_cap_snap(ci)) {
-			dout("get_cap_refs %p cap_snap_pending\n", inode);
+			pr_debug("get_cap_refs %p cap_snap_pending\n", inode);
 			goto out_unlock;
 		}
 	}
@@ -2684,9 +2689,9 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 		 */
 		int not = want & ~(have & need);
 		int revoking = implemented & ~have;
-		dout("get_cap_refs %p have %s but not %s (revoking %s)\n",
-		     inode, ceph_cap_string(have), ceph_cap_string(not),
-		     ceph_cap_string(revoking));
+		pr_debug("get_cap_refs %p have %s but not %s (revoking %s)\n",
+			 inode, ceph_cap_string(have), ceph_cap_string(not),
+			 ceph_cap_string(revoking));
 		if ((revoking & not) == 0) {
 			if (!snap_rwsem_locked &&
 			    !ci->i_head_snapc &&
@@ -2730,28 +2735,29 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 			spin_unlock(&s->s_cap_lock);
 		}
 		if (session_readonly) {
-			dout("get_cap_refs %p need %s but mds%d readonly\n",
-			     inode, ceph_cap_string(need), ci->i_auth_cap->mds);
+			pr_debug("get_cap_refs %p need %s but mds%d readonly\n",
+				 inode,
+				 ceph_cap_string(need), ci->i_auth_cap->mds);
 			ret = -EROFS;
 			goto out_unlock;
 		}
 
 		if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
-			dout("get_cap_refs %p forced umount\n", inode);
+			pr_debug("get_cap_refs %p forced umount\n", inode);
 			ret = -EIO;
 			goto out_unlock;
 		}
 		mds_wanted = __ceph_caps_mds_wanted(ci, false);
 		if (need & ~mds_wanted) {
-			dout("get_cap_refs %p need %s > mds_wanted %s\n",
-			     inode, ceph_cap_string(need),
-			     ceph_cap_string(mds_wanted));
+			pr_debug("get_cap_refs %p need %s > mds_wanted %s\n",
+				 inode, ceph_cap_string(need),
+				 ceph_cap_string(mds_wanted));
 			ret = -ESTALE;
 			goto out_unlock;
 		}
 
-		dout("get_cap_refs %p have %s need %s\n", inode,
-		     ceph_cap_string(have), ceph_cap_string(need));
+		pr_debug("get_cap_refs %p have %s need %s\n",
+			 inode, ceph_cap_string(have), ceph_cap_string(need));
 	}
 out_unlock:
 
@@ -2766,8 +2772,8 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 	else if (ret == 1)
 		ceph_update_cap_hit(&mdsc->metric);
 
-	dout("get_cap_refs %p ret %d got %s\n", inode,
-	     ret, ceph_cap_string(*got));
+	pr_debug("get_cap_refs %p ret %d got %s\n",
+		 inode, ret, ceph_cap_string(*got));
 	return ret;
 }
 
@@ -2784,8 +2790,8 @@ static void check_max_size(struct inode *inode, loff_t endoff)
 	/* do we need to explicitly request a larger max_size? */
 	spin_lock(&ci->i_ceph_lock);
 	if (endoff >= ci->i_max_size && endoff > ci->i_wanted_max_size) {
-		dout("write %p at large endoff %llu, req max_size\n",
-		     inode, endoff);
+		pr_debug("write %p at large endoff %llu, req max_size\n",
+			 inode, endoff);
 		ci->i_wanted_max_size = endoff;
 	}
 	/* duplicate ceph_check_caps()'s logic */
@@ -2995,8 +3001,8 @@ static int ceph_try_drop_cap_snap(struct ceph_inode_info *ci,
 {
 	if (!capsnap->need_flush &&
 	    !capsnap->writing && !capsnap->dirty_pages) {
-		dout("dropping cap_snap %p follows %llu\n",
-		     capsnap, capsnap->follows);
+		pr_debug("dropping cap_snap %p follows %llu\n",
+			 capsnap, capsnap->follows);
 		BUG_ON(capsnap->cap_flush.tid > 0);
 		ceph_put_snap_context(capsnap->context);
 		if (!list_is_last(&capsnap->ci_item, &ci->i_cap_snaps))
@@ -3041,8 +3047,8 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
 			last++;
 			put++;
 		}
-		dout("put_cap_refs %p wb %d -> %d (?)\n",
-		     inode, ci->i_wb_ref+1, ci->i_wb_ref);
+		pr_debug("put_cap_refs %p wb %d -> %d (?)\n",
+			 inode, ci->i_wb_ref + 1, ci->i_wb_ref);
 	}
 	if (had & CEPH_CAP_FILE_WR)
 		if (--ci->i_wr_ref == 0) {
@@ -3072,8 +3078,9 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
 		}
 	spin_unlock(&ci->i_ceph_lock);
 
-	dout("put_cap_refs %p had %s%s%s\n", inode, ceph_cap_string(had),
-	     last ? " last" : "", put ? " put" : "");
+	pr_debug("put_cap_refs %p had %s%s%s\n",
+		 inode, ceph_cap_string(had),
+		 last ? " last" : "", put ? " put" : "");
 
 	if (last && !skip_checking_caps)
 		ceph_check_caps(ci, 0, NULL);
@@ -3130,11 +3137,11 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 			ceph_put_snap_context(ci->i_head_snapc);
 			ci->i_head_snapc = NULL;
 		}
-		dout("put_wrbuffer_cap_refs on %p head %d/%d -> %d/%d %s\n",
-		     inode,
-		     ci->i_wrbuffer_ref+nr, ci->i_wrbuffer_ref_head+nr,
-		     ci->i_wrbuffer_ref, ci->i_wrbuffer_ref_head,
-		     last ? " LAST" : "");
+		pr_debug("put_wrbuffer_cap_refs on %p head %d/%d -> %d/%d %s\n",
+			 inode,
+			 ci->i_wrbuffer_ref + nr, ci->i_wrbuffer_ref_head + nr,
+			 ci->i_wrbuffer_ref, ci->i_wrbuffer_ref_head,
+			 last ? " LAST" : "");
 	} else {
 		list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
 			if (capsnap->context == snapc) {
@@ -3155,13 +3162,12 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 				}
 			}
 		}
-		dout("put_wrbuffer_cap_refs on %p cap_snap %p "
-		     " snap %lld %d/%d -> %d/%d %s%s\n",
-		     inode, capsnap, capsnap->context->seq,
-		     ci->i_wrbuffer_ref+nr, capsnap->dirty_pages + nr,
-		     ci->i_wrbuffer_ref, capsnap->dirty_pages,
-		     last ? " (wrbuffer last)" : "",
-		     complete_capsnap ? " (complete capsnap)" : "");
+		pr_debug("put_wrbuffer_cap_refs on %p cap_snap %p  snap %lld %d/%d -> %d/%d %s%s\n",
+			 inode, capsnap, capsnap->context->seq,
+			 ci->i_wrbuffer_ref + nr, capsnap->dirty_pages + nr,
+			 ci->i_wrbuffer_ref, capsnap->dirty_pages,
+			 last ? " (wrbuffer last)" : "",
+			 complete_capsnap ? " (complete capsnap)" : "");
 	}
 
 	spin_unlock(&ci->i_ceph_lock);
@@ -3186,7 +3192,7 @@ static void invalidate_aliases(struct inode *inode)
 {
 	struct dentry *dn, *prev = NULL;
 
-	dout("invalidate_aliases inode %p\n", inode);
+	pr_debug("invalidate_aliases inode %p\n", inode);
 	d_prune_aliases(inode);
 	/*
 	 * For non-directory inode, d_find_alias() only returns
@@ -3257,10 +3263,10 @@ static void handle_cap_grant(struct inode *inode,
 	bool deleted_inode = false;
 	bool fill_inline = false;
 
-	dout("handle_cap_grant inode %p cap %p mds%d seq %d %s\n",
-	     inode, cap, session->s_mds, seq, ceph_cap_string(newcaps));
-	dout(" size %llu max_size %llu, i_size %llu\n", size, max_size,
-		inode->i_size);
+	pr_debug("handle_cap_grant inode %p cap %p mds%d seq %d %s\n",
+		 inode, cap, session->s_mds, seq, ceph_cap_string(newcaps));
+	pr_debug("size %llu max_size %llu, i_size %llu\n",
+		 size, max_size, inode->i_size);
 
 
 	/*
@@ -3314,9 +3320,10 @@ static void handle_cap_grant(struct inode *inode,
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(grant->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(grant->gid));
 		ci->i_btime = extra_info->btime;
-		dout("%p mode 0%o uid.gid %d.%d\n", inode, inode->i_mode,
-		     from_kuid(&init_user_ns, inode->i_uid),
-		     from_kgid(&init_user_ns, inode->i_gid));
+		pr_debug("%p mode 0%o uid.gid %d.%d\n",
+			 inode, inode->i_mode,
+			 from_kuid(&init_user_ns, inode->i_uid),
+			 from_kgid(&init_user_ns, inode->i_gid));
 	}
 
 	if ((newcaps & CEPH_CAP_LINK_SHARED) &&
@@ -3333,8 +3340,8 @@ static void handle_cap_grant(struct inode *inode,
 		u64 version = le64_to_cpu(grant->xattr_version);
 
 		if (version > ci->i_xattrs.version) {
-			dout(" got new xattrs v%llu on %p len %d\n",
-			     version, inode, len);
+			pr_debug("got new xattrs v%llu on %p len %d\n",
+				 version, inode, len);
 			if (ci->i_xattrs.blob)
 				ceph_buffer_put(ci->i_xattrs.blob);
 			ci->i_xattrs.blob = ceph_buffer_get(xattr_buf);
@@ -3385,8 +3392,8 @@ static void handle_cap_grant(struct inode *inode,
 
 	if (ci->i_auth_cap == cap && (newcaps & CEPH_CAP_ANY_FILE_WR)) {
 		if (max_size != ci->i_max_size) {
-			dout("max_size %lld -> %llu\n",
-			     ci->i_max_size, max_size);
+			pr_debug("max_size %lld -> %llu\n",
+				 ci->i_max_size, max_size);
 			ci->i_max_size = max_size;
 			if (max_size >= ci->i_wanted_max_size) {
 				ci->i_wanted_max_size = 0;  /* reset */
@@ -3400,10 +3407,10 @@ static void handle_cap_grant(struct inode *inode,
 	wanted = __ceph_caps_wanted(ci);
 	used = __ceph_caps_used(ci);
 	dirty = __ceph_caps_dirty(ci);
-	dout(" my wanted = %s, used = %s, dirty %s\n",
-	     ceph_cap_string(wanted),
-	     ceph_cap_string(used),
-	     ceph_cap_string(dirty));
+	pr_debug("my wanted = %s, used = %s, dirty %s\n",
+		 ceph_cap_string(wanted),
+		 ceph_cap_string(used),
+		 ceph_cap_string(dirty));
 
 	if ((was_stale || le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT) &&
 	    (wanted & ~(cap->mds_wanted | newcaps))) {
@@ -3424,10 +3431,10 @@ static void handle_cap_grant(struct inode *inode,
 	if (cap->issued & ~newcaps) {
 		int revoking = cap->issued & ~newcaps;
 
-		dout("revocation: %s -> %s (revoking %s)\n",
-		     ceph_cap_string(cap->issued),
-		     ceph_cap_string(newcaps),
-		     ceph_cap_string(revoking));
+		pr_debug("revocation: %s -> %s (revoking %s)\n",
+			 ceph_cap_string(cap->issued),
+			 ceph_cap_string(newcaps),
+			 ceph_cap_string(revoking));
 		if (S_ISREG(inode->i_mode) &&
 		    (revoking & used & CEPH_CAP_FILE_BUFFER))
 			writeback = true;  /* initiate writeback; will delay ack */
@@ -3442,11 +3449,13 @@ static void handle_cap_grant(struct inode *inode,
 		cap->issued = newcaps;
 		cap->implemented |= newcaps;
 	} else if (cap->issued == newcaps) {
-		dout("caps unchanged: %s -> %s\n",
-		     ceph_cap_string(cap->issued), ceph_cap_string(newcaps));
+		pr_debug("caps unchanged: %s -> %s\n",
+			 ceph_cap_string(cap->issued),
+			 ceph_cap_string(newcaps));
 	} else {
-		dout("grant: %s -> %s\n", ceph_cap_string(cap->issued),
-		     ceph_cap_string(newcaps));
+		pr_debug("grant: %s -> %s\n",
+			 ceph_cap_string(cap->issued),
+			 ceph_cap_string(newcaps));
 		/* non-auth MDS is revoking the newly grant caps ? */
 		if (cap == ci->i_auth_cap &&
 		    __ceph_caps_revoking_other(ci, cap, newcaps))
@@ -3565,11 +3574,10 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 		}
 	}
 
-	dout("handle_cap_flush_ack inode %p mds%d seq %d on %s cleaned %s,"
-	     " flushing %s -> %s\n",
-	     inode, session->s_mds, seq, ceph_cap_string(dirty),
-	     ceph_cap_string(cleaned), ceph_cap_string(ci->i_flushing_caps),
-	     ceph_cap_string(ci->i_flushing_caps & ~cleaned));
+	pr_debug("handle_cap_flush_ack inode %p mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
+		 inode, session->s_mds, seq, ceph_cap_string(dirty),
+		 ceph_cap_string(cleaned), ceph_cap_string(ci->i_flushing_caps),
+		 ceph_cap_string(ci->i_flushing_caps & ~cleaned));
 
 	if (list_empty(&to_remove) && !cleaned)
 		goto out;
@@ -3585,18 +3593,18 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 		if (list_empty(&ci->i_cap_flush_list)) {
 			list_del_init(&ci->i_flushing_item);
 			if (!list_empty(&session->s_cap_flushing)) {
-				dout(" mds%d still flushing cap on %p\n",
-				     session->s_mds,
-				     &list_first_entry(&session->s_cap_flushing,
-						struct ceph_inode_info,
-						i_flushing_item)->vfs_inode);
+				pr_debug("mds%d still flushing cap on %p\n",
+					 session->s_mds,
+					 &list_first_entry(&session->s_cap_flushing,
+							   struct ceph_inode_info,
+							   i_flushing_item)->vfs_inode);
 			}
 		}
 		mdsc->num_cap_flushing--;
-		dout(" inode %p now !flushing\n", inode);
+		pr_debug("inode %p now !flushing\n", inode);
 
 		if (ci->i_dirty_caps == 0) {
-			dout(" inode %p now clean\n", inode);
+			pr_debug("inode %p now clean\n", inode);
 			BUG_ON(!list_empty(&ci->i_dirty_item));
 			drop = true;
 			if (ci->i_wr_ref == 0 &&
@@ -3647,29 +3655,29 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 	bool wake_ci = false;
 	bool wake_mdsc = false;
 
-	dout("handle_cap_flushsnap_ack inode %p ci %p mds%d follows %lld\n",
-	     inode, ci, session->s_mds, follows);
+	pr_debug("handle_cap_flushsnap_ack inode %p ci %p mds%d follows %lld\n",
+		 inode, ci, session->s_mds, follows);
 
 	spin_lock(&ci->i_ceph_lock);
 	list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
 		if (capsnap->follows == follows) {
 			if (capsnap->cap_flush.tid != flush_tid) {
-				dout(" cap_snap %p follows %lld tid %lld !="
-				     " %lld\n", capsnap, follows,
-				     flush_tid, capsnap->cap_flush.tid);
+				pr_debug("cap_snap %p follows %lld tid %lld != %lld\n",
+					 capsnap, follows,
+					 flush_tid, capsnap->cap_flush.tid);
 				break;
 			}
 			flushed = true;
 			break;
 		} else {
-			dout(" skipping cap_snap %p follows %lld\n",
-			     capsnap, capsnap->follows);
+			pr_debug("skipping cap_snap %p follows %lld\n",
+				 capsnap, capsnap->follows);
 		}
 	}
 	if (flushed) {
 		WARN_ON(capsnap->dirty_pages || capsnap->writing);
-		dout(" removing %p cap_snap %p follows %lld\n",
-		     inode, capsnap, follows);
+		pr_debug("removing %p cap_snap %p follows %lld\n",
+			 inode, capsnap, follows);
 		list_del(&capsnap->ci_item);
 		wake_ci |= __detach_cap_flush_from_ci(ci, &capsnap->cap_flush);
 
@@ -3718,8 +3726,8 @@ static bool handle_cap_trunc(struct inode *inode,
 
 	issued |= implemented | dirty;
 
-	dout("handle_cap_trunc inode %p mds%d seq %d to %lld seq %d\n",
-	     inode, mds, seq, truncate_size, truncate_seq);
+	pr_debug("handle_cap_trunc inode %p mds%d seq %d to %lld seq %d\n",
+		 inode, mds, seq, truncate_size, truncate_seq);
 	queue_trunc = ceph_fill_file_size(inode, issued,
 					  truncate_seq, truncate_size, size);
 	return queue_trunc;
@@ -3757,8 +3765,8 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		target = -1;
 	}
 
-	dout("handle_cap_export inode %p ci %p mds%d mseq %d target %d\n",
-	     inode, ci, mds, mseq, target);
+	pr_debug("handle_cap_export inode %p ci %p mds%d mseq %d target %d\n",
+		 inode, ci, mds, mseq, target);
 retry:
 	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ci, mds);
@@ -3790,7 +3798,8 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		/* already have caps from the target */
 		if (tcap->cap_id == t_cap_id &&
 		    ceph_seq_cmp(tcap->seq, t_seq) < 0) {
-			dout(" updating import cap %p mds%d\n", tcap, target);
+			pr_debug("updating import cap %p mds%d\n",
+				 tcap, target);
 			tcap->cap_id = t_cap_id;
 			tcap->seq = t_seq - 1;
 			tcap->issue_seq = t_seq - 1;
@@ -3889,8 +3898,8 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 		peer = -1;
 	}
 
-	dout("handle_cap_import inode %p ci %p mds%d mseq %d peer %d\n",
-	     inode, ci, mds, mseq, peer);
+	pr_debug("handle_cap_import inode %p ci %p mds%d mseq %d peer %d\n",
+		 inode, ci, mds, mseq, peer);
 retry:
 	cap = __get_cap_for_mds(ci, mds);
 	if (!cap) {
@@ -3916,8 +3925,8 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 
 	ocap = peer >= 0 ? __get_cap_for_mds(ci, peer) : NULL;
 	if (ocap && ocap->cap_id == p_cap_id) {
-		dout(" remove export cap %p mds%d flags %d\n",
-		     ocap, peer, ph->flags);
+		pr_debug("remove export cap %p mds%d flags %d\n",
+			 ocap, peer, ph->flags);
 		if ((ph->flags & CEPH_CAP_FLAG_AUTH) &&
 		    (ocap->seq != le32_to_cpu(ph->seq) ||
 		     ocap->mseq != le32_to_cpu(ph->mseq))) {
@@ -3962,7 +3971,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	struct cap_extra_info extra_info = {};
 	bool queue_trunc;
 
-	dout("handle_caps from mds%d\n", session->s_mds);
+	pr_debug("handle_caps from mds%d\n", session->s_mds);
 
 	/* decode */
 	end = msg->front.iov_base + msg->front.iov_len;
@@ -4060,16 +4069,16 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	/* lookup ino */
 	inode = ceph_find_inode(mdsc->fsc->sb, vino);
 	ci = ceph_inode(inode);
-	dout(" op %s ino %llx.%llx inode %p\n", ceph_cap_op_name(op), vino.ino,
-	     vino.snap, inode);
+	pr_debug("op %s ino %llx.%llx inode %p\n",
+		 ceph_cap_op_name(op), vino.ino, vino.snap, inode);
 
 	mutex_lock(&session->s_mutex);
 	session->s_seq++;
-	dout(" mds%d seq %lld cap seq %u\n", session->s_mds, session->s_seq,
-	     (unsigned)seq);
+	pr_debug("mds%d seq %lld cap seq %u\n",
+		 session->s_mds, session->s_seq, (unsigned int)seq);
 
 	if (!inode) {
-		dout(" i don't have ino %llx\n", vino.ino);
+		pr_debug("i don't have ino %llx\n", vino.ino);
 
 		if (op == CEPH_CAP_OP_IMPORT) {
 			cap = ceph_get_cap(mdsc, NULL);
@@ -4122,9 +4131,9 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ceph_inode(inode), session->s_mds);
 	if (!cap) {
-		dout(" no cap on %p ino %llx.%llx from mds%d\n",
-		     inode, ceph_ino(inode), ceph_snap(inode),
-		     session->s_mds);
+		pr_debug("no cap on %p ino %llx.%llx from mds%d\n",
+			 inode, ceph_ino(inode), ceph_snap(inode),
+			 session->s_mds);
 		spin_unlock(&ci->i_ceph_lock);
 		goto flush_cap_releases;
 	}
@@ -4188,7 +4197,7 @@ void ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 	struct inode *inode;
 	struct ceph_inode_info *ci;
 
-	dout("check_delayed_caps\n");
+	pr_debug("check_delayed_caps\n");
 	spin_lock(&mdsc->cap_delay_lock);
 	while (!list_empty(&mdsc->cap_delay_list)) {
 		ci = list_first_entry(&mdsc->cap_delay_list,
@@ -4202,7 +4211,7 @@ void ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 		inode = igrab(&ci->vfs_inode);
 		if (inode) {
 			spin_unlock(&mdsc->cap_delay_lock);
-			dout("check_delayed_caps on %p\n", inode);
+			pr_debug("check_delayed_caps on %p\n", inode);
 			ceph_check_caps(ci, 0, NULL);
 			/* avoid calling iput_final() in tick thread */
 			ceph_async_iput(inode);
@@ -4221,21 +4230,21 @@ static void flush_dirty_session_caps(struct ceph_mds_session *s)
 	struct ceph_inode_info *ci;
 	struct inode *inode;
 
-	dout("flush_dirty_caps\n");
+	pr_debug("flush_dirty_caps\n");
 	spin_lock(&mdsc->cap_dirty_lock);
 	while (!list_empty(&s->s_cap_dirty)) {
 		ci = list_first_entry(&s->s_cap_dirty, struct ceph_inode_info,
 				      i_dirty_item);
 		inode = &ci->vfs_inode;
 		ihold(inode);
-		dout("flush_dirty_caps %p\n", inode);
+		pr_debug("flush_dirty_caps %p\n", inode);
 		spin_unlock(&mdsc->cap_dirty_lock);
 		ceph_check_caps(ci, CHECK_CAPS_FLUSH, NULL);
 		iput(inode);
 		spin_lock(&mdsc->cap_dirty_lock);
 	}
 	spin_unlock(&mdsc->cap_dirty_lock);
-	dout("flush_dirty_caps done\n");
+	pr_debug("flush_dirty_caps done\n");
 }
 
 static void iterate_sessions(struct ceph_mds_client *mdsc,
@@ -4359,9 +4368,11 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 	used = __ceph_caps_used(ci);
 	dirty = __ceph_caps_dirty(ci);
 
-	dout("encode_inode_release %p mds%d used|dirty %s drop %s unless %s\n",
-	     inode, mds, ceph_cap_string(used|dirty), ceph_cap_string(drop),
-	     ceph_cap_string(unless));
+	pr_debug("encode_inode_release %p mds%d used|dirty %s drop %s unless %s\n",
+		 inode, mds,
+		 ceph_cap_string(used | dirty),
+		 ceph_cap_string(drop),
+		 ceph_cap_string(unless));
 
 	/* only drop unused, clean caps */
 	drop &= ~(used | dirty);
@@ -4383,12 +4394,12 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 		if (force || (cap->issued & drop)) {
 			if (cap->issued & drop) {
 				int wanted = __ceph_caps_wanted(ci);
-				dout("encode_inode_release %p cap %p "
-				     "%s -> %s, wanted %s -> %s\n", inode, cap,
-				     ceph_cap_string(cap->issued),
-				     ceph_cap_string(cap->issued & ~drop),
-				     ceph_cap_string(cap->mds_wanted),
-				     ceph_cap_string(wanted));
+				pr_debug("encode_inode_release %p cap %p %s -> %s, wanted %s -> %s\n",
+					 inode, cap,
+					 ceph_cap_string(cap->issued),
+					 ceph_cap_string(cap->issued & ~drop),
+					 ceph_cap_string(cap->mds_wanted),
+					 ceph_cap_string(wanted));
 
 				cap->issued &= ~drop;
 				cap->implemented &= ~drop;
@@ -4397,9 +4408,9 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 				    !(wanted & CEPH_CAP_ANY_FILE_WR))
 					ci->i_requested_max_size = 0;
 			} else {
-				dout("encode_inode_release %p cap %p %s"
-				     " (force)\n", inode, cap,
-				     ceph_cap_string(cap->issued));
+				pr_debug("encode_inode_release %p cap %p %s (force)\n",
+					 inode, cap,
+					 ceph_cap_string(cap->issued));
 			}
 
 			rel->ino = cpu_to_le64(ceph_ino(inode));
@@ -4414,8 +4425,8 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 			*p += sizeof(*rel);
 			ret = 1;
 		} else {
-			dout("encode_inode_release %p cap %p %s (noop)\n",
-			     inode, cap, ceph_cap_string(cap->issued));
+			pr_debug("encode_inode_release %p cap %p %s (noop)\n",
+				 inode, cap, ceph_cap_string(cap->issued));
 		}
 	}
 	spin_unlock(&ci->i_ceph_lock);
@@ -4452,8 +4463,8 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 
 	spin_lock(&dentry->d_lock);
 	if (ret && di->lease_session && di->lease_session->s_mds == mds) {
-		dout("encode_dentry_release %p mds%d seq %d\n",
-		     dentry, mds, (int)di->lease_seq);
+		pr_debug("encode_dentry_release %p mds%d seq %d\n",
+			 dentry, mds, (int)di->lease_seq);
 		rel->dname_len = cpu_to_le32(dentry->d_name.len);
 		memcpy(*p, dentry->d_name.name, dentry->d_name.len);
 		*p += dentry->d_name.len;
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 97539b497e4c..244428de3c4b 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -324,7 +324,7 @@ DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
 
 void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 {
-	dout("ceph_fs_debugfs_cleanup\n");
+	pr_debug("ceph_fs_debugfs_cleanup\n");
 	debugfs_remove(fsc->debugfs_bdi);
 	debugfs_remove(fsc->debugfs_congestion_kb);
 	debugfs_remove(fsc->debugfs_mdsmap);
@@ -338,7 +338,7 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 {
 	char name[100];
 
-	dout("ceph_fs_debugfs_init\n");
+	pr_debug("ceph_fs_debugfs_init\n");
 	fsc->debugfs_congestion_kb =
 		debugfs_create_file("writeback_congestion_kb",
 				    0600,
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 060bdcc5ce32..911b905cc181 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -120,7 +120,7 @@ static int note_last_dentry(struct ceph_dir_file_info *dfi, const char *name,
 	memcpy(dfi->last_name, name, len);
 	dfi->last_name[len] = 0;
 	dfi->next_offset = next_offset;
-	dout("note_last_dentry '%s'\n", dfi->last_name);
+	pr_debug("note_last_dentry '%s'\n", dfi->last_name);
 	return 0;
 }
 
@@ -142,7 +142,7 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
 		ceph_readdir_cache_release(cache_ctl);
 		cache_ctl->page = find_lock_page(&dir->i_data, ptr_pgoff);
 		if (!cache_ctl->page) {
-			dout(" page %lu not found\n", ptr_pgoff);
+			pr_debug("page %lu not found\n", ptr_pgoff);
 			return ERR_PTR(-EAGAIN);
 		}
 		/* reading/filling the cache are serialized by
@@ -191,7 +191,8 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 	u64 idx = 0;
 	int err = 0;
 
-	dout("__dcache_readdir %p v%u at %llx\n", dir, (unsigned)shared_gen, ctx->pos);
+	pr_debug("__dcache_readdir %p v%u at %llx\n",
+		 dir, (unsigned int)shared_gen, ctx->pos);
 
 	/* search start position */
 	if (ctx->pos > 2) {
@@ -221,7 +222,7 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 			dput(dentry);
 		}
 
-		dout("__dcache_readdir %p cache idx %llu\n", dir, idx);
+		pr_debug("__dcache_readdir %p cache idx %llu\n", dir, idx);
 	}
 
 
@@ -255,8 +256,8 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 		spin_unlock(&dentry->d_lock);
 
 		if (emit_dentry) {
-			dout(" %llx dentry %p %pd %p\n", di->offset,
-			     dentry, dentry, d_inode(dentry));
+			pr_debug("%llx dentry %p %pd %p\n",
+				 di->offset, dentry, dentry, d_inode(dentry));
 			ctx->pos = di->offset;
 			if (!dir_emit(ctx, dentry->d_name.name,
 				      dentry->d_name.len,
@@ -317,13 +318,13 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	unsigned frag = -1;
 	struct ceph_mds_reply_info_parsed *rinfo;
 
-	dout("readdir %p file %p pos %llx\n", inode, file, ctx->pos);
+	pr_debug("readdir %p file %p pos %llx\n", inode, file, ctx->pos);
 	if (dfi->file_info.flags & CEPH_F_ATEND)
 		return 0;
 
 	/* always start with . and .. */
 	if (ctx->pos == 0) {
-		dout("readdir off 0 -> '.'\n");
+		pr_debug("readdir off 0 -> '.'\n");
 		if (!dir_emit(ctx, ".", 1, 
 			    ceph_translate_ino(inode->i_sb, inode->i_ino),
 			    inode->i_mode >> 12))
@@ -332,7 +333,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	}
 	if (ctx->pos == 1) {
 		ino_t ino = parent_ino(file->f_path.dentry);
-		dout("readdir off 1 -> '..'\n");
+		pr_debug("readdir off 1 -> '..'\n");
 		if (!dir_emit(ctx, "..", 2,
 			    ceph_translate_ino(inode->i_sb, ino),
 			    inode->i_mode >> 12))
@@ -384,8 +385,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			frag = fpos_frag(ctx->pos);
 		}
 
-		dout("readdir fetching %llx.%llx frag %x offset '%s'\n",
-		     ceph_vinop(inode), frag, dfi->last_name);
+		pr_debug("readdir fetching %llx.%llx frag %x offset '%s'\n",
+			 ceph_vinop(inode), frag, dfi->last_name);
 		req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
 		if (IS_ERR(req))
 			return PTR_ERR(req);
@@ -428,12 +429,11 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			ceph_mdsc_put_request(req);
 			return err;
 		}
-		dout("readdir got and parsed readdir result=%d on "
-		     "frag %x, end=%d, complete=%d, hash_order=%d\n",
-		     err, frag,
-		     (int)req->r_reply_info.dir_end,
-		     (int)req->r_reply_info.dir_complete,
-		     (int)req->r_reply_info.hash_order);
+		pr_debug("readdir got and parsed readdir result=%d on frag %x, end=%d, complete=%d, hash_order=%d\n",
+			 err, frag,
+			 (int)req->r_reply_info.dir_end,
+			 (int)req->r_reply_info.dir_complete,
+			 (int)req->r_reply_info.hash_order);
 
 		rinfo = &req->r_reply_info;
 		if (le32_to_cpu(rinfo->dir_dir->frag) != frag) {
@@ -463,7 +463,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 				dfi->dir_ordered_count = req->r_dir_ordered_cnt;
 			}
 		} else {
-			dout("readdir !did_prepopulate\n");
+			pr_debug("readdir !did_prepopulate\n");
 			/* disable readdir cache */
 			dfi->readdir_cache_idx = -1;
 			/* preclude from marking dir complete */
@@ -487,9 +487,9 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 	rinfo = &dfi->last_readdir->r_reply_info;
-	dout("readdir frag %x num %d pos %llx chunk first %llx\n",
-	     dfi->frag, rinfo->dir_nr, ctx->pos,
-	     rinfo->dir_nr ? rinfo->dir_entries[0].offset : 0LL);
+	pr_debug("readdir frag %x num %d pos %llx chunk first %llx\n",
+		 dfi->frag, rinfo->dir_nr, ctx->pos,
+		 rinfo->dir_nr ? rinfo->dir_entries[0].offset : 0LL);
 
 	i = 0;
 	/* search start position */
@@ -514,9 +514,9 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		BUG_ON(rde->offset < ctx->pos);
 
 		ctx->pos = rde->offset;
-		dout("readdir (%d/%d) -> %llx '%.*s' %p\n",
-		     i, rinfo->dir_nr, ctx->pos,
-		     rde->name_len, rde->name, &rde->inode.in);
+		pr_debug("readdir (%d/%d) -> %llx '%.*s' %p\n",
+			 i, rinfo->dir_nr, ctx->pos,
+			 rde->name_len, rde->name, &rde->inode.in);
 
 		BUG_ON(!rde->inode.in);
 		ftype = le32_to_cpu(rde->inode.in->mode) >> 12;
@@ -526,7 +526,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 
 		if (!dir_emit(ctx, rde->name, rde->name_len,
 			      ceph_translate_ino(inode->i_sb, ino), ftype)) {
-			dout("filldir stopping us...\n");
+			pr_debug("filldir stopping us...\n");
 			return 0;
 		}
 		ctx->pos++;
@@ -555,7 +555,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			kfree(dfi->last_name);
 			dfi->last_name = NULL;
 		}
-		dout("readdir next frag is %x\n", frag);
+		pr_debug("readdir next frag is %x\n", frag);
 		goto more;
 	}
 	dfi->file_info.flags |= CEPH_F_ATEND;
@@ -570,21 +570,21 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		spin_lock(&ci->i_ceph_lock);
 		if (dfi->dir_ordered_count ==
 				atomic64_read(&ci->i_ordered_count)) {
-			dout(" marking %p complete and ordered\n", inode);
+			pr_debug("marking %p complete and ordered\n", inode);
 			/* use i_size to track number of entries in
 			 * readdir cache */
 			BUG_ON(dfi->readdir_cache_idx < 0);
 			i_size_write(inode, dfi->readdir_cache_idx *
 				     sizeof(struct dentry*));
 		} else {
-			dout(" marking %p complete\n", inode);
+			pr_debug("marking %p complete\n", inode);
 		}
 		__ceph_dir_set_complete(ci, dfi->dir_release_count,
 					dfi->dir_ordered_count);
 		spin_unlock(&ci->i_ceph_lock);
 	}
 
-	dout("readdir %p file %p done.\n", inode, file);
+	pr_debug("readdir %p file %p done\n", inode, file);
 	return 0;
 }
 
@@ -647,7 +647,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 
 	if (offset >= 0) {
 		if (need_reset_readdir(dfi, offset)) {
-			dout("dir_llseek dropping %p content\n", file);
+			pr_debug("dir_llseek dropping %p content\n", file);
 			reset_readdir(dfi);
 		} else if (is_hash_order(offset) && offset > file->f_pos) {
 			/* for hash offset, we don't know if a forward seek
@@ -683,8 +683,8 @@ int ceph_handle_snapdir(struct ceph_mds_request *req,
 	    strcmp(dentry->d_name.name,
 		   fsc->mount_options->snapdir_name) == 0) {
 		struct inode *inode = ceph_get_snapdir(parent);
-		dout("ENOENT on snapdir %p '%pd', linking to snapdir %p\n",
-		     dentry, dentry, inode);
+		pr_debug("ENOENT on snapdir %p '%pd', linking to snapdir %p\n",
+			 dentry, dentry, inode);
 		BUG_ON(!d_unhashed(dentry));
 		d_add(dentry, inode);
 		err = 0;
@@ -710,8 +710,8 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 		/* no trace? */
 		err = 0;
 		if (!req->r_reply_info.head->is_dentry) {
-			dout("ENOENT and no trace, dentry %p inode %p\n",
-			     dentry, d_inode(dentry));
+			pr_debug("ENOENT and no trace, dentry %p inode %p\n",
+				 dentry, d_inode(dentry));
 			if (d_really_is_positive(dentry)) {
 				d_drop(dentry);
 				err = -ENOENT;
@@ -749,8 +749,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	int mask;
 	int err;
 
-	dout("lookup %p dentry %p '%pd'\n",
-	     dir, dentry, dentry);
+	pr_debug("lookup %p dentry %p '%pd'\n", dir, dentry, dentry);
 
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
@@ -761,7 +760,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 		struct ceph_dentry_info *di = ceph_dentry(dentry);
 
 		spin_lock(&ci->i_ceph_lock);
-		dout(" dir %p flags are 0x%lx\n", dir, ci->i_ceph_flags);
+		pr_debug("dir %p flags are 0x%lx\n", dir, ci->i_ceph_flags);
 		if (strncmp(dentry->d_name.name,
 			    fsc->mount_options->snapdir_name,
 			    dentry->d_name.len) &&
@@ -771,7 +770,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 		    __ceph_caps_issued_mask_metric(ci, CEPH_CAP_FILE_SHARED, 1)) {
 			__ceph_touch_fmode(ci, mdsc, CEPH_FILE_MODE_RD);
 			spin_unlock(&ci->i_ceph_lock);
-			dout(" dir %p complete, -ENOENT\n", dir);
+			pr_debug("dir %p complete, -ENOENT\n", dir);
 			d_add(dentry, NULL);
 			di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
 			return NULL;
@@ -798,7 +797,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	err = ceph_handle_snapdir(req, dentry, err);
 	dentry = ceph_finish_lookup(req, dentry, err);
 	ceph_mdsc_put_request(req);  /* will dput(dentry) */
-	dout("lookup result=%p\n", dentry);
+	pr_debug("lookup result=%p\n", dentry);
 	return dentry;
 }
 
@@ -853,8 +852,8 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
 	if (err < 0)
 		goto out;
 
-	dout("mknod in dir %p dentry %p mode 0%ho rdev %d\n",
-	     dir, dentry, mode, rdev);
+	pr_debug("mknod in dir %p dentry %p mode 0%ho rdev %d\n",
+		 dir, dentry, mode, rdev);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_MKNOD, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -912,7 +911,7 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 	if (err < 0)
 		goto out;
 
-	dout("symlink in dir %p dentry %p to '%s'\n", dir, dentry, dest);
+	pr_debug("symlink in dir %p dentry %p to '%s'\n", dir, dentry, dest);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SYMLINK, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -957,10 +956,10 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (ceph_snap(dir) == CEPH_SNAPDIR) {
 		/* mkdir .snap/foo is a MKSNAP */
 		op = CEPH_MDS_OP_MKSNAP;
-		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
-		     dentry, dentry);
+		pr_debug("mksnap dir %p snap '%pd' dn %p\n",
+			 dir, dentry, dentry);
 	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
-		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
+		pr_debug("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
 		op = CEPH_MDS_OP_MKDIR;
 	} else {
 		goto out;
@@ -1023,8 +1022,8 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 	if (ceph_snap(dir) != CEPH_NOSNAP)
 		return -EROFS;
 
-	dout("link in dir %p old_dentry %p dentry %p\n", dir,
-	     old_dentry, dentry);
+	pr_debug("link in dir %p old_dentry %p dentry %p\n",
+		 dir, old_dentry, dentry);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LINK, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		d_drop(dentry);
@@ -1137,11 +1136,11 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (ceph_snap(dir) == CEPH_SNAPDIR) {
 		/* rmdir .snap/foo is RMSNAP */
-		dout("rmsnap dir %p '%pd' dn %p\n", dir, dentry, dentry);
+		pr_debug("rmsnap dir %p '%pd' dn %p\n", dir, dentry, dentry);
 		op = CEPH_MDS_OP_RMSNAP;
 	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
-		dout("unlink/rmdir dir %p dn %p inode %p\n",
-		     dir, dentry, inode);
+		pr_debug("unlink/rmdir dir %p dn %p inode %p\n",
+			 dir, dentry, inode);
 		op = d_is_dir(dentry) ?
 			CEPH_MDS_OP_RMDIR : CEPH_MDS_OP_UNLINK;
 	} else
@@ -1161,9 +1160,10 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (try_async && op == CEPH_MDS_OP_UNLINK &&
 	    (req->r_dir_caps = get_caps_for_async_unlink(dir, dentry))) {
-		dout("async unlink on %lu/%.*s caps=%s", dir->i_ino,
-		     dentry->d_name.len, dentry->d_name.name,
-		     ceph_cap_string(req->r_dir_caps));
+		pr_debug("async unlink on %lu/%.*s caps=%s\n",
+			 dir->i_ino,
+			 dentry->d_name.len, dentry->d_name.name,
+			 ceph_cap_string(req->r_dir_caps));
 		set_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags);
 		req->r_callback = ceph_async_unlink_cb;
 		req->r_old_inode = d_inode(dentry);
@@ -1220,8 +1220,8 @@ static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
 			return err;
 	}
 
-	dout("rename dir %p dentry %p to dir %p dentry %p\n",
-	     old_dir, old_dentry, new_dir, new_dentry);
+	pr_debug("rename dir %p dentry %p to dir %p dentry %p\n",
+		 old_dir, old_dentry, new_dir, new_dentry);
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -1267,7 +1267,7 @@ void __ceph_dentry_lease_touch(struct ceph_dentry_info *di)
 	struct dentry *dn = di->dentry;
 	struct ceph_mds_client *mdsc;
 
-	dout("dentry_lease_touch %p %p '%pd'\n", di, dn, dn);
+	pr_debug("dentry_lease_touch %p %p '%pd'\n", di, dn, dn);
 
 	di->flags |= CEPH_DENTRY_LEASE_LIST;
 	if (di->flags & CEPH_DENTRY_SHRINK_LIST) {
@@ -1301,8 +1301,8 @@ void __ceph_dentry_dir_lease_touch(struct ceph_dentry_info *di)
 	struct dentry *dn = di->dentry;
 	struct ceph_mds_client *mdsc;
 
-	dout("dentry_dir_lease_touch %p %p '%pd' (offset 0x%llx)\n",
-	     di, dn, dn, di->offset);
+	pr_debug("dentry_dir_lease_touch %p %p '%pd' (offset 0x%llx)\n",
+		 di, dn, dn, di->offset);
 
 	if (!list_empty(&di->lease_list)) {
 		if (di->flags & CEPH_DENTRY_LEASE_LIST) {
@@ -1597,7 +1597,7 @@ static int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags)
 					 CEPH_MDS_LEASE_RENEW, seq);
 		ceph_put_mds_session(session);
 	}
-	dout("dentry_lease_is_valid - dentry %p = %d\n", dentry, valid);
+	pr_debug("dentry_lease_is_valid - dentry %p = %d\n", dentry, valid);
 	return valid;
 }
 
@@ -1661,8 +1661,9 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
 			valid = 0;
 		spin_unlock(&dentry->d_lock);
 	}
-	dout("dir_lease_is_valid dir %p v%u dentry %p = %d\n",
-	     dir, (unsigned)atomic_read(&ci->i_shared_gen), dentry, valid);
+	pr_debug("dir_lease_is_valid dir %p v%u dentry %p = %d\n",
+		 dir, (unsigned int)atomic_read(&ci->i_shared_gen),
+		 dentry, valid);
 	return valid;
 }
 
@@ -1688,15 +1689,15 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 		inode = d_inode(dentry);
 	}
 
-	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
-	     dentry, inode, ceph_dentry(dentry)->offset);
+	pr_debug("d_revalidate %p '%pd' inode %p offset 0x%llx\n",
+		 dentry, dentry, inode, ceph_dentry(dentry)->offset);
 
 	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
 	if (ceph_snap(dir) != CEPH_NOSNAP) {
-		dout("d_revalidate %p '%pd' inode %p is SNAPPED\n", dentry,
-		     dentry, inode);
+		pr_debug("d_revalidate %p '%pd' inode %p is SNAPPED\n",
+			 dentry, dentry, inode);
 		valid = 1;
 	} else if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
 		valid = 1;
@@ -1750,14 +1751,14 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 				break;
 			}
 			ceph_mdsc_put_request(req);
-			dout("d_revalidate %p lookup result=%d\n",
-			     dentry, err);
+			pr_debug("d_revalidate %p lookup result=%d\n",
+				 dentry, err);
 		}
 	} else {
 		percpu_counter_inc(&mdsc->metric.d_lease_hit);
 	}
 
-	dout("d_revalidate %p %s\n", dentry, valid ? "valid" : "invalid");
+	pr_debug("d_revalidate %p %s\n", dentry, valid ? "valid" : "invalid");
 	if (!valid)
 		ceph_dir_clear_complete(dir);
 
@@ -1799,7 +1800,7 @@ static void ceph_d_release(struct dentry *dentry)
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
 
-	dout("d_release %p\n", dentry);
+	pr_debug("d_release %p\n", dentry);
 
 	atomic64_dec(&fsc->mdsc->metric.total_dentries);
 
@@ -1824,7 +1825,7 @@ static void ceph_d_prune(struct dentry *dentry)
 	struct ceph_inode_info *dir_ci;
 	struct ceph_dentry_info *di;
 
-	dout("ceph_d_prune %pd %p\n", dentry, dentry);
+	pr_debug("ceph_d_prune %pd %p\n", dentry, dentry);
 
 	/* do we have a valid parent? */
 	if (IS_ROOT(dentry))
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index e088843a7734..fe5c0adb9cc2 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -78,7 +78,7 @@ static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_len,
 	*max_len = snap_handle_length;
 	ret = FILEID_BTRFS_WITH_PARENT;
 out:
-	dout("encode_snapfh %llx.%llx ret=%d\n", ceph_vinop(inode), ret);
+	pr_debug("encode_snapfh %llx.%llx ret=%d\n", ceph_vinop(inode), ret);
 	return ret;
 }
 
@@ -104,15 +104,15 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 
 	if (parent_inode) {
 		struct ceph_nfs_confh *cfh = (void *)rawfh;
-		dout("encode_fh %llx with parent %llx\n",
-		     ceph_ino(inode), ceph_ino(parent_inode));
+		pr_debug("encode_fh %llx with parent %llx\n",
+			 ceph_ino(inode), ceph_ino(parent_inode));
 		cfh->ino = ceph_ino(inode);
 		cfh->parent_ino = ceph_ino(parent_inode);
 		*max_len = connected_handle_length;
 		type = FILEID_INO32_GEN_PARENT;
 	} else {
 		struct ceph_nfs_fh *fh = (void *)rawfh;
-		dout("encode_fh %llx\n", ceph_ino(inode));
+		pr_debug("encode_fh %llx\n", ceph_ino(inode));
 		fh->ino = ceph_ino(inode);
 		*max_len = handle_length;
 		type = FILEID_INO32_GEN;
@@ -255,11 +255,11 @@ static struct dentry *__snapfh_to_dentry(struct super_block *sb,
 	ceph_mdsc_put_request(req);
 
 	if (want_parent) {
-		dout("snapfh_to_parent %llx.%llx\n err=%d\n",
-		     vino.ino, vino.snap, err);
+		pr_debug("snapfh_to_parent %llx.%llx\n err=%d\n",
+			 vino.ino, vino.snap, err);
 	} else {
-		dout("snapfh_to_dentry %llx.%llx parent %llx hash %x err=%d",
-		      vino.ino, vino.snap, sfh->parent_ino, sfh->hash, err);
+		pr_debug("snapfh_to_dentry %llx.%llx parent %llx hash %x err=%d\n",
+			 vino.ino, vino.snap, sfh->parent_ino, sfh->hash, err);
 	}
 	if (!inode)
 		return ERR_PTR(-ESTALE);
@@ -287,7 +287,7 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
 	if (fh_len < sizeof(*fh) / 4)
 		return NULL;
 
-	dout("fh_to_dentry %llx\n", fh->ino);
+	pr_debug("fh_to_dentry %llx\n", fh->ino);
 	return __fh_to_dentry(sb, fh->ino);
 }
 
@@ -379,8 +379,8 @@ static struct dentry *ceph_get_parent(struct dentry *child)
 		dn = __get_parent(child->d_sb, child, 0);
 	}
 out:
-	dout("get_parent %p ino %llx.%llx err=%ld\n",
-	     child, ceph_vinop(inode), (long)PTR_ERR_OR_ZERO(dn));
+	pr_debug("get_parent %p ino %llx.%llx err=%ld\n",
+		 child, ceph_vinop(inode), (long)PTR_ERR_OR_ZERO(dn));
 	return dn;
 }
 
@@ -404,7 +404,7 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 	if (fh_len < sizeof(*cfh) / 4)
 		return NULL;
 
-	dout("fh_to_parent %llx\n", cfh->parent_ino);
+	pr_debug("fh_to_parent %llx\n", cfh->parent_ino);
 	dentry = __get_parent(sb, NULL, cfh->ino);
 	if (unlikely(dentry == ERR_PTR(-ENOENT)))
 		dentry = __fh_to_dentry(sb, cfh->parent_ino);
@@ -503,8 +503,8 @@ static int __get_snap_name(struct dentry *parent, char *name,
 	if (req)
 		ceph_mdsc_put_request(req);
 	kfree(last_name);
-	dout("get_snap_name %p ino %llx.%llx err=%d\n",
-	     child, ceph_vinop(inode), err);
+	pr_debug("get_snap_name %p ino %llx.%llx err=%d\n",
+		 child, ceph_vinop(inode), err);
 	return err;
 }
 
@@ -541,11 +541,11 @@ static int ceph_get_name(struct dentry *parent, char *name,
 		struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
 		memcpy(name, rinfo->dname, rinfo->dname_len);
 		name[rinfo->dname_len] = 0;
-		dout("get_name %p ino %llx.%llx name %s\n",
-		     child, ceph_vinop(inode), name);
+		pr_debug("get_name %p ino %llx.%llx name %s\n",
+			 child, ceph_vinop(inode), name);
 	} else {
-		dout("get_name %p ino %llx.%llx err %d\n",
-		     child, ceph_vinop(inode), err);
+		pr_debug("get_name %p ino %llx.%llx err %d\n",
+			 child, ceph_vinop(inode), err);
 	}
 
 	ceph_mdsc_put_request(req);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d51c3f2fdca0..7d7644f8862c 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -48,7 +48,7 @@ static __le32 ceph_flags_sys2wire(u32 flags)
 #undef ceph_sys2wire
 
 	if (flags)
-		dout("unused open flags: %x\n", flags);
+		pr_debug("unused open flags: %x\n", flags);
 
 	return cpu_to_le32(wire_flags);
 }
@@ -207,8 +207,9 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_info *fi;
 
-	dout("%s %p %p 0%o (%s)\n", __func__, inode, file,
-			inode->i_mode, isdir ? "dir" : "regular");
+	pr_debug("%s %p %p 0%o (%s)\n",
+		 __func__, inode, file, inode->i_mode,
+		 isdir ? "dir" : "regular");
 	BUG_ON(inode->i_fop->release != ceph_release);
 
 	if (isdir) {
@@ -261,13 +262,13 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 		break;
 
 	case S_IFLNK:
-		dout("init_file %p %p 0%o (symlink)\n", inode, file,
-		     inode->i_mode);
+		pr_debug("init_file %p %p 0%o (symlink)\n",
+			 inode, file, inode->i_mode);
 		break;
 
 	default:
-		dout("init_file %p %p 0%o (special)\n", inode, file,
-		     inode->i_mode);
+		pr_debug("init_file %p %p 0%o (special)\n",
+			 inode, file, inode->i_mode);
 		/*
 		 * we need to drop the open ref now, since we don't
 		 * have .release set to ceph_release.
@@ -297,8 +298,10 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap)) {
 		int issued = __ceph_caps_issued(ci, NULL);
 		spin_unlock(&ci->i_ceph_lock);
-		dout("renew caps %p want %s issued %s updating mds_wanted\n",
-		     inode, ceph_cap_string(wanted), ceph_cap_string(issued));
+		pr_debug("renew caps %p want %s issued %s updating mds_wanted\n",
+			 inode,
+			 ceph_cap_string(wanted),
+			 ceph_cap_string(issued));
 		ceph_check_caps(ci, 0, NULL);
 		return 0;
 	}
@@ -329,7 +332,7 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	ceph_mdsc_put_request(req);
 out:
-	dout("renew caps %p open result=%d\n", inode, err);
+	pr_debug("renew caps %p open result=%d\n", inode, err);
 	return err < 0 ? err : 0;
 }
 
@@ -350,7 +353,7 @@ int ceph_open(struct inode *inode, struct file *file)
 	int flags, fmode, wanted;
 
 	if (fi) {
-		dout("open file %p is already opened\n", file);
+		pr_debug("open file %p is already opened\n", file);
 		return 0;
 	}
 
@@ -359,8 +362,8 @@ int ceph_open(struct inode *inode, struct file *file)
 	if (S_ISDIR(inode->i_mode))
 		flags = O_DIRECTORY;  /* mds likes to know */
 
-	dout("open inode %p ino %llx.%llx file %p flags %d (%d)\n", inode,
-	     ceph_vinop(inode), file, flags, file->f_flags);
+	pr_debug("open inode %p ino %llx.%llx file %p flags %d (%d)\n",
+		 inode, ceph_vinop(inode), file, flags, file->f_flags);
 	fmode = ceph_flags_to_mode(flags);
 	wanted = ceph_caps_for_mode(fmode);
 
@@ -384,9 +387,9 @@ int ceph_open(struct inode *inode, struct file *file)
 		int mds_wanted = __ceph_caps_mds_wanted(ci, true);
 		int issued = __ceph_caps_issued(ci, NULL);
 
-		dout("open %p fmode %d want %s issued %s using existing\n",
-		     inode, fmode, ceph_cap_string(wanted),
-		     ceph_cap_string(issued));
+		pr_debug("open %p fmode %d want %s issued %s using existing\n",
+			 inode, fmode, ceph_cap_string(wanted),
+			 ceph_cap_string(issued));
 		__ceph_touch_fmode(ci, mdsc, fmode);
 		spin_unlock(&ci->i_ceph_lock);
 
@@ -406,7 +409,7 @@ int ceph_open(struct inode *inode, struct file *file)
 
 	spin_unlock(&ci->i_ceph_lock);
 
-	dout("open fmode %d wants %s\n", fmode, ceph_cap_string(wanted));
+	pr_debug("open fmode %d wants %s\n", fmode, ceph_cap_string(wanted));
 	req = prepare_open_request(inode->i_sb, flags, 0);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -420,7 +423,7 @@ int ceph_open(struct inode *inode, struct file *file)
 	if (!err)
 		err = ceph_init_file(inode, file, req->r_fmode);
 	ceph_mdsc_put_request(req);
-	dout("open result=%d on %llx.%llx\n", err, ceph_vinop(inode));
+	pr_debug("open result=%d on %llx.%llx\n", err, ceph_vinop(inode));
 out:
 	return err;
 }
@@ -621,7 +624,7 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 	ret = ceph_fill_inode(inode, NULL, &iinfo, NULL, req->r_session,
 			      req->r_fmode, NULL);
 	if (ret) {
-		dout("%s failed to fill inode: %d\n", __func__, ret);
+		pr_debug("%s failed to fill inode: %d\n", __func__, ret);
 		ceph_dir_clear_complete(dir);
 		if (!d_unhashed(dentry))
 			d_drop(dentry);
@@ -630,8 +633,8 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 	} else {
 		struct dentry *dn;
 
-		dout("%s d_adding new inode 0x%llx to 0x%lx/%s\n", __func__,
-			vino.ino, dir->i_ino, dentry->d_name.name);
+		pr_debug("%s d_adding new inode 0x%llx to 0x%lx/%s\n",
+			 __func__, vino.ino, dir->i_ino, dentry->d_name.name);
 		ceph_dir_clear_ordered(dir);
 		ceph_init_inode_acls(inode, as_ctx);
 		if (inode->i_state & I_NEW) {
@@ -672,9 +675,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	int mask;
 	int err;
 
-	dout("atomic_open %p dentry %p '%pd' %s flags %d mode 0%o\n",
-	     dir, dentry, dentry,
-	     d_unhashed(dentry) ? "unhashed" : "hashed", flags, mode);
+	pr_debug("atomic_open %p dentry %p '%pd' %s flags %d mode 0%o\n",
+		 dir, dentry, dentry,
+		 d_unhashed(dentry) ? "unhashed" : "hashed", flags, mode);
 
 	if (dentry->d_name.len > NAME_MAX)
 		return -ENAMETOOLONG;
@@ -761,10 +764,10 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		goto out_req;
 	if (dn || d_really_is_negative(dentry) || d_is_symlink(dentry)) {
 		/* make vfs retry on splice, ENOENT, or symlink */
-		dout("atomic_open finish_no_open on dn %p\n", dn);
+		pr_debug("atomic_open finish_no_open on dn %p\n", dn);
 		err = finish_no_open(file, dn);
 	} else {
-		dout("atomic_open finish_open on dn %p\n", dn);
+		pr_debug("atomic_open finish_open on dn %p\n", dn);
 		if (req->r_op == CEPH_MDS_OP_CREATE && req->r_reply_info.has_create_ino) {
 			struct inode *newino = d_inode(dentry);
 
@@ -778,7 +781,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	ceph_mdsc_put_request(req);
 out_ctx:
 	ceph_release_acl_sec_ctx(&as_ctx);
-	dout("atomic_open result=%d\n", err);
+	pr_debug("atomic_open result=%d\n", err);
 	return err;
 }
 
@@ -788,7 +791,7 @@ int ceph_release(struct inode *inode, struct file *file)
 
 	if (S_ISDIR(inode->i_mode)) {
 		struct ceph_dir_file_info *dfi = file->private_data;
-		dout("release inode %p dir file %p\n", inode, file);
+		pr_debug("release inode %p dir file %p\n", inode, file);
 		WARN_ON(!list_empty(&dfi->file_info.rw_contexts));
 
 		ceph_put_fmode(ci, dfi->file_info.fmode, 1);
@@ -800,7 +803,7 @@ int ceph_release(struct inode *inode, struct file *file)
 		kmem_cache_free(ceph_dir_file_cachep, dfi);
 	} else {
 		struct ceph_file_info *fi = file->private_data;
-		dout("release inode %p regular file %p\n", inode, file);
+		pr_debug("release inode %p regular file %p\n", inode, file);
 		WARN_ON(!list_empty(&fi->rw_contexts));
 
 		ceph_put_fmode(ci, fi->fmode, 1);
@@ -841,8 +844,9 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 	u64 off = iocb->ki_pos;
 	u64 len = iov_iter_count(to);
 
-	dout("sync_read on file %p %llu~%u %s\n", file, off, (unsigned)len,
-	     (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
+	pr_debug("sync_read on file %p %llu~%u%s\n",
+		 file, off, (unsigned int)len,
+		 file->f_flags & O_DIRECT ? " O_DIRECT" : "");
 
 	if (!len)
 		return 0;
@@ -917,16 +921,16 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 		ceph_osdc_put_request(req);
 
 		i_size = i_size_read(inode);
-		dout("sync_read %llu~%llu got %zd i_size %llu%s\n",
-		     off, len, ret, i_size, (more ? " MORE" : ""));
+		pr_debug("sync_read %llu~%llu got %zd i_size %llu%s\n",
+			 off, len, ret, i_size, (more ? " MORE" : ""));
 
 		if (ret == -ENOENT)
 			ret = 0;
 		if (ret >= 0 && ret < len && (off + ret < i_size)) {
 			int zlen = min(len - ret, i_size - off - ret);
 			int zoff = page_off + ret;
-			dout("sync_read zero gap %llu~%llu\n",
-                             off + ret, off + ret + zlen);
+			pr_debug("sync_read zero gap %llu~%llu\n",
+				 off + ret, off + ret + zlen);
 			ceph_zero_page_vector_range(zoff, zlen, pages);
 			ret += zlen;
 		}
@@ -976,7 +980,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 		iocb->ki_pos = off;
 	}
 
-	dout("sync_read result %zd retry_op %d\n", ret, *retry_op);
+	pr_debug("sync_read result %zd retry_op %d\n", ret, *retry_op);
 	return ret;
 }
 
@@ -1016,7 +1020,7 @@ static void ceph_aio_complete(struct inode *inode,
 	if (!ret)
 		ret = aio_req->total_len;
 
-	dout("ceph_aio_complete %p rc %d\n", inode, ret);
+	pr_debug("ceph_aio_complete %p rc %d\n", inode, ret);
 
 	if (ret >= 0 && aio_req->write) {
 		int dirty;
@@ -1058,8 +1062,8 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_BVECS);
 	BUG_ON(!osd_data->num_bvecs);
 
-	dout("ceph_aio_complete_req %p rc %d bytes %u\n",
-	     inode, rc, osd_data->bvec_pos.iter.bi_size);
+	pr_debug("ceph_aio_complete_req %p rc %d bytes %u\n",
+		 inode, rc, osd_data->bvec_pos.iter.bi_size);
 
 	/* r_start_latency == 0 means the request was not submitted */
 	if (req->r_start_latency) {
@@ -1216,16 +1220,17 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
 		return -EROFS;
 
-	dout("sync_direct_%s on file %p %lld~%u snapc %p seq %lld\n",
-	     (write ? "write" : "read"), file, pos, (unsigned)count,
-	     snapc, snapc ? snapc->seq : 0);
+	pr_debug("sync_direct_%s on file %p %lld~%u snapc %p seq %lld\n",
+		 (write ? "write" : "read"), file, pos, (unsigned int)count,
+		 snapc, snapc ? snapc->seq : 0);
 
 	if (write) {
 		int ret2 = invalidate_inode_pages2_range(inode->i_mapping,
 					pos >> PAGE_SHIFT,
 					(pos + count - 1) >> PAGE_SHIFT);
 		if (ret2 < 0)
-			dout("invalidate_inode_pages2_range returned %d\n", ret2);
+			pr_debug("invalidate_inode_pages2_range returned %d\n",
+				 ret2);
 
 		flags = /* CEPH_OSD_FLAG_ORDERSNAP | */ CEPH_OSD_FLAG_WRITE;
 	} else {
@@ -1424,8 +1429,8 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
 		return -EROFS;
 
-	dout("sync_write on file %p %lld~%u snapc %p seq %lld\n",
-	     file, pos, (unsigned)count, snapc, snapc->seq);
+	pr_debug("sync_write on file %p %lld~%u snapc %p seq %lld\n",
+		 file, pos, (unsigned int)count, snapc, snapc->seq);
 
 	ret = filemap_write_and_wait_range(inode->i_mapping,
 					   pos, pos + count - 1);
@@ -1436,7 +1441,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 					    pos >> PAGE_SHIFT,
 					    (pos + count - 1) >> PAGE_SHIFT);
 	if (ret < 0)
-		dout("invalidate_inode_pages2_range returned %d\n", ret);
+		pr_debug("invalidate_inode_pages2_range returned %d\n", ret);
 
 	flags = /* CEPH_OSD_FLAG_ORDERSNAP | */ CEPH_OSD_FLAG_WRITE;
 
@@ -1544,8 +1549,9 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	int retry_op = 0, read = 0;
 
 again:
-	dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
-	     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len, inode);
+	pr_debug("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
+		 inode, ceph_vinop(inode), iocb->ki_pos, (unsigned int)len,
+		 inode);
 
 	if (direct_lock)
 		ceph_start_io_direct(inode);
@@ -1570,9 +1576,9 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	    (iocb->ki_flags & IOCB_DIRECT) ||
 	    (fi->flags & CEPH_F_SYNC)) {
 
-		dout("aio_sync_read %p %llx.%llx %llu~%u got cap refs on %s\n",
-		     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
-		     ceph_cap_string(got));
+		pr_debug("aio_sync_read %p %llx.%llx %llu~%u got cap refs on %s\n",
+			 inode, ceph_vinop(inode), iocb->ki_pos,
+			 (unsigned int)len, ceph_cap_string(got));
 
 		if (ci->i_inline_version == CEPH_INLINE_NONE) {
 			if (!retry_op && (iocb->ki_flags & IOCB_DIRECT)) {
@@ -1588,16 +1594,16 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 	} else {
 		CEPH_DEFINE_RW_CONTEXT(rw_ctx, got);
-		dout("aio_read %p %llx.%llx %llu~%u got cap refs on %s\n",
-		     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
-		     ceph_cap_string(got));
+		pr_debug("aio_read %p %llx.%llx %llu~%u got cap refs on %s\n",
+			 inode, ceph_vinop(inode), iocb->ki_pos,
+			 (unsigned int)len, ceph_cap_string(got));
 		ceph_add_rw_context(fi, &rw_ctx);
 		ret = generic_file_read_iter(iocb, to);
 		ceph_del_rw_context(fi, &rw_ctx);
 	}
 
-	dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
-	     inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
+	pr_debug("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
+		 inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
 	if (pinned_page) {
 		put_page(pinned_page);
 		pinned_page = NULL;
@@ -1661,8 +1667,8 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		/* hit EOF or hole? */
 		if (retry_op == CHECK_EOF && iocb->ki_pos < i_size &&
 		    ret < len) {
-			dout("sync_read hit hole, ppos %lld < size %lld"
-			     ", reading more\n", iocb->ki_pos, i_size);
+			pr_debug("sync_read hit hole, ppos %lld < size %lld, reading more\n",
+				 iocb->ki_pos, i_size);
 
 			read += ret;
 			len -= ret;
@@ -1773,8 +1779,8 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-	dout("aio_write %p %llx.%llx %llu~%zd getting caps. i_size %llu\n",
-	     inode, ceph_vinop(inode), pos, count, i_size_read(inode));
+	pr_debug("aio_write %p %llx.%llx %llu~%zd getting caps. i_size %llu\n",
+		 inode, ceph_vinop(inode), pos, count, i_size_read(inode));
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
 	else
@@ -1785,8 +1791,8 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err < 0)
 		goto out;
 
-	dout("aio_write %p %llx.%llx %llu~%zd got cap refs on %s\n",
-	     inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
+	pr_debug("aio_write %p %llx.%llx %llu~%zd got cap refs on %s\n",
+		 inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
 
 	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
 	    (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC) ||
@@ -1849,14 +1855,14 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ceph_check_caps(ci, 0, NULL);
 	}
 
-	dout("aio_write %p %llx.%llx %llu~%u  dropping cap refs on %s\n",
-	     inode, ceph_vinop(inode), pos, (unsigned)count,
-	     ceph_cap_string(got));
+	pr_debug("aio_write %p %llx.%llx %llu~%u  dropping cap refs on %s\n",
+		 inode, ceph_vinop(inode), pos, (unsigned int)count,
+		 ceph_cap_string(got));
 	ceph_put_cap_refs(ci, got);
 
 	if (written == -EOLDSNAPC) {
-		dout("aio_write %p %llx.%llx %llu~%u" "got EOLDSNAPC, retrying\n",
-		     inode, ceph_vinop(inode), pos, (unsigned)count);
+		pr_debug("aio_write %p %llx.%llx %llu~%ugot EOLDSNAPC, retrying\n",
+			 inode, ceph_vinop(inode), pos, (unsigned int)count);
 		goto retry_snap;
 	}
 
@@ -2207,8 +2213,8 @@ static int is_file_size_ok(struct inode *src_inode, struct inode *dst_inode,
 	 * inode.
 	 */
 	if (src_off + len > size) {
-		dout("Copy beyond EOF (%llu + %zu > %llu)\n",
-		     src_off, len, size);
+		pr_debug("Copy beyond EOF (%llu + %zu > %llu)\n",
+			 src_off, len, size);
 		return -EOPNOTSUPP;
 	}
 	size = i_size_read(dst_inode);
@@ -2271,7 +2277,7 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
 				fsc->have_copy_from2 = false;
 				pr_notice("OSDs don't support copy-from2; disabling copy offload\n");
 			}
-			dout("ceph_osdc_copy_from returned %d\n", ret);
+			pr_debug("ceph_osdc_copy_from returned %d\n", ret);
 			if (!bytes)
 				bytes = ret;
 			goto out;
@@ -2309,8 +2315,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 
 		if (ceph_fsid_compare(&src_fsc->client->fsid,
 				      &dst_fsc->client->fsid)) {
-			dout("Copying files across clusters: src: %pU dst: %pU\n",
-			     &src_fsc->client->fsid, &dst_fsc->client->fsid);
+			pr_debug("Copying files across clusters: src: %pU dst: %pU\n",
+				 &src_fsc->client->fsid, &dst_fsc->client->fsid);
 			return -EXDEV;
 		}
 	}
@@ -2340,7 +2346,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	    (src_ci->i_layout.stripe_count != 1) ||
 	    (dst_ci->i_layout.stripe_count != 1) ||
 	    (src_ci->i_layout.object_size != dst_ci->i_layout.object_size)) {
-		dout("Invalid src/dst files layout\n");
+		pr_debug("Invalid src/dst files layout\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -2354,12 +2360,12 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	/* Start by sync'ing the source and destination files */
 	ret = file_write_and_wait_range(src_file, src_off, (src_off + len));
 	if (ret < 0) {
-		dout("failed to write src file (%zd)\n", ret);
+		pr_debug("failed to write src file (%zd)\n", ret);
 		goto out;
 	}
 	ret = file_write_and_wait_range(dst_file, dst_off, (dst_off + len));
 	if (ret < 0) {
-		dout("failed to write dst file (%zd)\n", ret);
+		pr_debug("failed to write dst file (%zd)\n", ret);
 		goto out;
 	}
 
@@ -2371,7 +2377,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	err = get_rd_wr_caps(src_file, &src_got,
 			     dst_file, (dst_off + len), &dst_got);
 	if (err < 0) {
-		dout("get_rd_wr_caps returned %d\n", err);
+		pr_debug("get_rd_wr_caps returned %d\n", err);
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -2385,7 +2391,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 					    dst_off >> PAGE_SHIFT,
 					    (dst_off + len) >> PAGE_SHIFT);
 	if (ret < 0) {
-		dout("Failed to invalidate inode pages (%zd)\n", ret);
+		pr_debug("Failed to invalidate inode pages (%zd)\n", ret);
 		ret = 0; /* XXX */
 	}
 	ceph_calc_file_object_mapping(&src_ci->i_layout, src_off,
@@ -2406,7 +2412,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	 * starting at the src_off
 	 */
 	if (src_objoff) {
-		dout("Initial partial copy of %u bytes\n", src_objlen);
+		pr_debug("Initial partial copy of %u bytes\n", src_objlen);
 
 		/*
 		 * we need to temporarily drop all caps as we'll be calling
@@ -2417,7 +2423,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 				       &dst_off, src_objlen, flags);
 		/* Abort on short copies or on error */
 		if (ret < src_objlen) {
-			dout("Failed partial copy (%zd)\n", ret);
+			pr_debug("Failed partial copy (%zd)\n", ret);
 			goto out;
 		}
 		len -= ret;
@@ -2439,7 +2445,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 			ret = bytes;
 		goto out_caps;
 	}
-	dout("Copied %zu bytes out of %zu\n", bytes, len);
+	pr_debug("Copied %zu bytes out of %zu\n", bytes, len);
 	len -= bytes;
 	ret += bytes;
 
@@ -2468,13 +2474,13 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	 * there were errors in remote object copies (len >= object_size).
 	 */
 	if (len && (len < src_ci->i_layout.object_size)) {
-		dout("Final partial copy of %zu bytes\n", len);
+		pr_debug("Final partial copy of %zu bytes\n", len);
 		bytes = do_splice_direct(src_file, &src_off, dst_file,
 					 &dst_off, len, flags);
 		if (bytes > 0)
 			ret += bytes;
 		else
-			dout("Failed partial copy (%zd)\n", bytes);
+			pr_debug("Failed partial copy (%zd)\n", bytes);
 	}
 
 out:
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 357c937699d5..b2ff9f03a46e 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -56,11 +56,11 @@ struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 	if (inode->i_state & I_NEW)
-		dout("get_inode created new inode %p %llx.%llx ino %llx\n",
-		     inode, ceph_vinop(inode), (u64)inode->i_ino);
+		pr_debug("get_inode created new inode %p %llx.%llx ino %llx\n",
+			 inode, ceph_vinop(inode), (u64)inode->i_ino);
 
-	dout("get_inode on %lu=%llx.%llx got %p\n", inode->i_ino, vino.ino,
-	     vino.snap, inode);
+	pr_debug("get_inode on %lu=%llx.%llx got %p\n",
+		 inode->i_ino, vino.ino, vino.snap, inode);
 	return inode;
 }
 
@@ -151,8 +151,8 @@ static struct ceph_inode_frag *__get_or_create_frag(struct ceph_inode_info *ci,
 	rb_link_node(&frag->node, parent, p);
 	rb_insert_color(&frag->node, &ci->i_fragtree);
 
-	dout("get_or_create_frag added %llx.%llx frag %x\n",
-	     ceph_vinop(&ci->vfs_inode), f);
+	pr_debug("get_or_create_frag added %llx.%llx frag %x\n",
+		 ceph_vinop(&ci->vfs_inode), f);
 	return frag;
 }
 
@@ -208,8 +208,8 @@ static u32 __ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
 
 		/* choose child */
 		nway = 1 << frag->split_by;
-		dout("choose_frag(%x) %x splits by %d (%d ways)\n", v, t,
-		     frag->split_by, nway);
+		pr_debug("choose_frag(%x) %x splits by %d (%d ways)\n",
+			 v, t, frag->split_by, nway);
 		for (i = 0; i < nway; i++) {
 			n = ceph_frag_make_child(t, frag->split_by, i);
 			if (ceph_frag_contains_value(n, v)) {
@@ -219,7 +219,7 @@ static u32 __ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
 		}
 		BUG_ON(i == nway);
 	}
-	dout("choose_frag(%x) = %x\n", v, t);
+	pr_debug("choose_frag(%x) = %x\n", v, t);
 
 	return t;
 }
@@ -267,14 +267,14 @@ static int ceph_fill_dirfrag(struct inode *inode,
 			goto out;
 		if (frag->split_by == 0) {
 			/* tree leaf, remove */
-			dout("fill_dirfrag removed %llx.%llx frag %x"
-			     " (no ref)\n", ceph_vinop(inode), id);
+			pr_debug("fill_dirfrag removed %llx.%llx frag %x (no ref)\n",
+				 ceph_vinop(inode), id);
 			rb_erase(&frag->node, &ci->i_fragtree);
 			kfree(frag);
 		} else {
 			/* tree branch, keep and clear */
-			dout("fill_dirfrag cleared %llx.%llx frag %x"
-			     " referral\n", ceph_vinop(inode), id);
+			pr_debug("fill_dirfrag cleared %llx.%llx frag %x referral\n",
+				 ceph_vinop(inode), id);
 			frag->mds = -1;
 			frag->ndist = 0;
 		}
@@ -297,8 +297,8 @@ static int ceph_fill_dirfrag(struct inode *inode,
 	frag->ndist = min_t(u32, ndist, CEPH_MAX_DIRFRAG_REP);
 	for (i = 0; i < frag->ndist; i++)
 		frag->dist[i] = le32_to_cpu(dirinfo->dist[i]);
-	dout("fill_dirfrag %llx.%llx frag %x ndist=%d\n",
-	     ceph_vinop(inode), frag->frag, frag->ndist);
+	pr_debug("fill_dirfrag %llx.%llx frag %x ndist=%d\n",
+		 ceph_vinop(inode), frag->frag, frag->ndist);
 
 out:
 	mutex_unlock(&ci->i_fragtree_mutex);
@@ -361,7 +361,7 @@ static int ceph_fill_fragtree(struct inode *inode,
 		     frag_tree_split_cmp, NULL);
 	}
 
-	dout("fill_fragtree %llx.%llx\n", ceph_vinop(inode));
+	pr_debug("fill_fragtree %llx.%llx\n", ceph_vinop(inode));
 	rb_node = rb_first(&ci->i_fragtree);
 	for (i = 0; i < nsplits; i++) {
 		id = le32_to_cpu(fragtree->splits[i].frag);
@@ -401,7 +401,7 @@ static int ceph_fill_fragtree(struct inode *inode,
 		if (frag->split_by == 0)
 			ci->i_fragtree_nsplits++;
 		frag->split_by = split_by;
-		dout(" frag %x split by %d\n", frag->frag, frag->split_by);
+		pr_debug("frag %x split by %d\n", frag->frag, frag->split_by);
 		prev_frag = frag;
 	}
 	while (rb_node) {
@@ -433,7 +433,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	if (!ci)
 		return NULL;
 
-	dout("alloc_inode %p\n", &ci->vfs_inode);
+	pr_debug("alloc_inode %p\n", &ci->vfs_inode);
 
 	spin_lock_init(&ci->i_ceph_lock);
 
@@ -542,7 +542,7 @@ void ceph_evict_inode(struct inode *inode)
 	struct ceph_inode_frag *frag;
 	struct rb_node *n;
 
-	dout("evict_inode %p ino %llx.%llx\n", inode, ceph_vinop(inode));
+	pr_debug("evict_inode %p ino %llx.%llx\n", inode, ceph_vinop(inode));
 
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
@@ -563,8 +563,8 @@ void ceph_evict_inode(struct inode *inode)
 					ceph_inode_to_client(inode)->mdsc;
 		if (ceph_snap(inode) == CEPH_NOSNAP) {
 			struct ceph_snap_realm *realm = ci->i_snap_realm;
-			dout(" dropping residual ref to snap realm %p\n",
-			     realm);
+			pr_debug("dropping residual ref to snap realm %p\n",
+				 realm);
 			spin_lock(&realm->inodes_with_caps_lock);
 			list_del_init(&ci->i_snap_realm_item);
 			ci->i_snap_realm = NULL;
@@ -616,7 +616,7 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 
 	if (ceph_seq_cmp(truncate_seq, ci->i_truncate_seq) > 0 ||
 	    (truncate_seq == ci->i_truncate_seq && size > inode->i_size)) {
-		dout("size %lld -> %llu\n", inode->i_size, size);
+		pr_debug("size %lld -> %llu\n", inode->i_size, size);
 		if (size > 0 && S_ISDIR(inode->i_mode)) {
 			pr_err("fill_file_size non-zero size for directory\n");
 			size = 0;
@@ -625,8 +625,8 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 		inode->i_blocks = calc_inode_blocks(size);
 		ci->i_reported_size = size;
 		if (truncate_seq != ci->i_truncate_seq) {
-			dout("truncate_seq %u -> %u\n",
-			     ci->i_truncate_seq, truncate_seq);
+			pr_debug("truncate_seq %u -> %u\n",
+				 ci->i_truncate_seq, truncate_seq);
 			ci->i_truncate_seq = truncate_seq;
 
 			/* the MDS should have revoked these caps */
@@ -651,8 +651,8 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 	}
 	if (ceph_seq_cmp(truncate_seq, ci->i_truncate_seq) >= 0 &&
 	    ci->i_truncate_size != truncate_size) {
-		dout("truncate_size %lld -> %llu\n", ci->i_truncate_size,
-		     truncate_size);
+		pr_debug("truncate_size %lld -> %llu\n",
+			 ci->i_truncate_size, truncate_size);
 		ci->i_truncate_size = truncate_size;
 	}
 
@@ -676,19 +676,18 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		      CEPH_CAP_XATTR_EXCL)) {
 		if (ci->i_version == 0 ||
 		    timespec64_compare(ctime, &inode->i_ctime) > 0) {
-			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
-			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
-			     ctime->tv_sec, ctime->tv_nsec);
+			pr_debug("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
+				 inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+				 ctime->tv_sec, ctime->tv_nsec);
 			inode->i_ctime = *ctime;
 		}
 		if (ci->i_version == 0 ||
 		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
 			/* the MDS did a utimes() */
-			dout("mtime %lld.%09ld -> %lld.%09ld "
-			     "tw %d -> %d\n",
-			     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
-			     mtime->tv_sec, mtime->tv_nsec,
-			     ci->i_time_warp_seq, (int)time_warp_seq);
+			pr_debug("mtime %lld.%09ld -> %lld.%09ld tw %d -> %d\n",
+				 inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
+				 mtime->tv_sec, mtime->tv_nsec,
+				 ci->i_time_warp_seq, (int)time_warp_seq);
 
 			inode->i_mtime = *mtime;
 			inode->i_atime = *atime;
@@ -696,17 +695,17 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		} else if (time_warp_seq == ci->i_time_warp_seq) {
 			/* nobody did utimes(); take the max */
 			if (timespec64_compare(mtime, &inode->i_mtime) > 0) {
-				dout("mtime %lld.%09ld -> %lld.%09ld inc\n",
-				     inode->i_mtime.tv_sec,
-				     inode->i_mtime.tv_nsec,
-				     mtime->tv_sec, mtime->tv_nsec);
+				pr_debug("mtime %lld.%09ld -> %lld.%09ld inc\n",
+					 inode->i_mtime.tv_sec,
+					 inode->i_mtime.tv_nsec,
+					 mtime->tv_sec, mtime->tv_nsec);
 				inode->i_mtime = *mtime;
 			}
 			if (timespec64_compare(atime, &inode->i_atime) > 0) {
-				dout("atime %lld.%09ld -> %lld.%09ld inc\n",
-				     inode->i_atime.tv_sec,
-				     inode->i_atime.tv_nsec,
-				     atime->tv_sec, atime->tv_nsec);
+				pr_debug("atime %lld.%09ld -> %lld.%09ld inc\n",
+					 inode->i_atime.tv_sec,
+					 inode->i_atime.tv_nsec,
+					 atime->tv_sec, atime->tv_nsec);
 				inode->i_atime = *atime;
 			}
 		} else if (issued & CEPH_CAP_FILE_EXCL) {
@@ -726,8 +725,8 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		}
 	}
 	if (warn) /* time_warp_seq shouldn't go backwards */
-		dout("%p mds time_warp_seq %llu < %u\n",
-		     inode, time_warp_seq, ci->i_time_warp_seq);
+		pr_debug("%p mds time_warp_seq %llu < %u\n",
+			 inode, time_warp_seq, ci->i_time_warp_seq);
 }
 
 /*
@@ -755,9 +754,10 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	bool new_version = false;
 	bool fill_inline = false;
 
-	dout("%s %p ino %llx.%llx v %llu had %llu\n", __func__,
-	     inode, ceph_vinop(inode), le64_to_cpu(info->version),
-	     ci->i_version);
+	pr_debug("%s %p ino %llx.%llx v %llu had %llu\n",
+		 __func__,
+		 inode, ceph_vinop(inode), le64_to_cpu(info->version),
+		 ci->i_version);
 
 	info_caps = le32_to_cpu(info->cap.caps);
 
@@ -828,9 +828,10 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		inode->i_mode = le32_to_cpu(info->mode);
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(info->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(info->gid));
-		dout("%p mode 0%o uid.gid %d.%d\n", inode, inode->i_mode,
-		     from_kuid(&init_user_ns, inode->i_uid),
-		     from_kgid(&init_user_ns, inode->i_gid));
+		pr_debug("%p mode 0%o uid.gid %d.%d\n",
+			 inode, inode->i_mode,
+			 from_kuid(&init_user_ns, inode->i_uid),
+			 from_kgid(&init_user_ns, inode->i_gid));
 		ceph_decode_timespec64(&ci->i_btime, &iinfo->btime);
 		ceph_decode_timespec64(&ci->i_snap_btime, &iinfo->snap_btime);
 	}
@@ -876,8 +877,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		/* only update max_size on auth cap */
 		if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
 		    ci->i_max_size != le64_to_cpu(info->max_size)) {
-			dout("max_size %lld -> %llu\n", ci->i_max_size,
-					le64_to_cpu(info->max_size));
+			pr_debug("max_size %lld -> %llu\n",
+				 ci->i_max_size, le64_to_cpu(info->max_size));
 			ci->i_max_size = le64_to_cpu(info->max_size);
 		}
 	}
@@ -987,7 +988,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 			    (info_caps & CEPH_CAP_FILE_SHARED) &&
 			    (issued & CEPH_CAP_FILE_EXCL) == 0 &&
 			    !__ceph_dir_is_complete(ci)) {
-				dout(" marking %p complete (empty)\n", inode);
+				pr_debug("marking %p complete (empty)\n",
+					 inode);
 				i_size_write(inode, 0);
 				__ceph_dir_set_complete(ci,
 					atomic64_read(&ci->i_release_count),
@@ -996,8 +998,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 			wake = true;
 		} else {
-			dout(" %p got snap_caps %s\n", inode,
-			     ceph_cap_string(info_caps));
+			pr_debug("%p got snap_caps %s\n",
+				 inode, ceph_cap_string(info_caps));
 			ci->i_snap_caps |= info_caps;
 		}
 	}
@@ -1064,8 +1066,8 @@ static void __update_dentry_lease(struct inode *dir, struct dentry *dentry,
 	long unsigned ttl = from_time + (duration * HZ) / 1000;
 	long unsigned half_ttl = from_time + (duration * HZ / 2) / 1000;
 
-	dout("update_dentry_lease %p duration %lu ms ttl %lu\n",
-	     dentry, duration, ttl);
+	pr_debug("update_dentry_lease %p duration %lu ms ttl %lu\n",
+		 dentry, duration, ttl);
 
 	/* only track leases on regular dentries */
 	if (ceph_snap(dir) != CEPH_NOSNAP)
@@ -1205,17 +1207,16 @@ static int splice_dentry(struct dentry **pdn, struct inode *in)
 	}
 
 	if (realdn) {
-		dout("dn %p (%d) spliced with %p (%d) "
-		     "inode %p ino %llx.%llx\n",
-		     dn, d_count(dn),
-		     realdn, d_count(realdn),
-		     d_inode(realdn), ceph_vinop(d_inode(realdn)));
+		pr_debug("dn %p (%d) spliced with %p (%d) inode %p ino %llx.%llx\n",
+			 dn, d_count(dn),
+			 realdn, d_count(realdn),
+			 d_inode(realdn), ceph_vinop(d_inode(realdn)));
 		dput(dn);
 		*pdn = realdn;
 	} else {
 		BUG_ON(!ceph_dentry(dn));
-		dout("dn %p attached to %p ino %llx.%llx\n",
-		     dn, d_inode(dn), ceph_vinop(d_inode(dn)));
+		pr_debug("dn %p attached to %p ino %llx.%llx\n",
+			 dn, d_inode(dn), ceph_vinop(d_inode(dn)));
 	}
 	return 0;
 }
@@ -1240,11 +1241,11 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
 	int err = 0;
 
-	dout("fill_trace %p is_dentry %d is_target %d\n", req,
-	     rinfo->head->is_dentry, rinfo->head->is_target);
+	pr_debug("fill_trace %p is_dentry %d is_target %d\n",
+		 req, rinfo->head->is_dentry, rinfo->head->is_target);
 
 	if (!rinfo->head->is_target && !rinfo->head->is_dentry) {
-		dout("fill_trace reply is empty!\n");
+		pr_debug("fill_trace reply is empty!\n");
 		if (rinfo->head->result == 0 && req->r_parent)
 			ceph_invalidate_dir_request(req);
 		return 0;
@@ -1282,13 +1283,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
 retry_lookup:
 			dn = d_lookup(parent, &dname);
-			dout("d_lookup on parent=%p name=%.*s got %p\n",
-			     parent, dname.len, dname.name, dn);
+			pr_debug("d_lookup on parent=%p name=%.*s got %p\n",
+				 parent, dname.len, dname.name, dn);
 
 			if (!dn) {
 				dn = d_alloc(parent, &dname);
-				dout("d_alloc %p '%.*s' = %p\n", parent,
-				     dname.len, dname.name, dn);
+				pr_debug("d_alloc %p '%.*s' = %p\n",
+					 parent, dname.len, dname.name, dn);
 				if (!dn) {
 					dput(parent);
 					err = -ENOMEM;
@@ -1298,8 +1299,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			} else if (d_really_is_positive(dn) &&
 				   (ceph_ino(d_inode(dn)) != tvino.ino ||
 				    ceph_snap(d_inode(dn)) != tvino.snap)) {
-				dout(" dn %p points to wrong inode %p\n",
-				     dn, d_inode(dn));
+				pr_debug("dn %p points to wrong inode %p\n",
+					 dn, d_inode(dn));
 				ceph_dir_clear_ordered(dir);
 				d_delete(dn);
 				dput(dn);
@@ -1377,36 +1378,37 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		have_lease = have_dir_cap ||
 			le32_to_cpu(rinfo->dlease->duration_ms);
 		if (!have_lease)
-			dout("fill_trace  no dentry lease or dir cap\n");
+			pr_debug("fill_trace  no dentry lease or dir cap\n");
 
 		/* rename? */
 		if (req->r_old_dentry && req->r_op == CEPH_MDS_OP_RENAME) {
 			struct inode *olddir = req->r_old_dentry_dir;
 			BUG_ON(!olddir);
 
-			dout(" src %p '%pd' dst %p '%pd'\n",
-			     req->r_old_dentry,
-			     req->r_old_dentry,
-			     dn, dn);
-			dout("fill_trace doing d_move %p -> %p\n",
-			     req->r_old_dentry, dn);
+			pr_debug("src %p '%pd' dst %p '%pd'\n",
+				 req->r_old_dentry,
+				 req->r_old_dentry,
+				 dn, dn);
+			pr_debug("fill_trace doing d_move %p -> %p\n",
+				 req->r_old_dentry, dn);
 
 			/* d_move screws up sibling dentries' offsets */
 			ceph_dir_clear_ordered(dir);
 			ceph_dir_clear_ordered(olddir);
 
 			d_move(req->r_old_dentry, dn);
-			dout(" src %p '%pd' dst %p '%pd'\n",
-			     req->r_old_dentry,
-			     req->r_old_dentry,
-			     dn, dn);
+			pr_debug("src %p '%pd' dst %p '%pd'\n",
+				 req->r_old_dentry,
+				 req->r_old_dentry,
+				 dn, dn);
 
 			/* ensure target dentry is invalidated, despite
 			   rehashing bug in vfs_rename_dir */
 			ceph_invalidate_dentry_lease(dn);
 
-			dout("dn %p gets new offset %lld\n", req->r_old_dentry,
-			     ceph_dentry(req->r_old_dentry)->offset);
+			pr_debug("dn %p gets new offset %lld\n",
+				 req->r_old_dentry,
+				 ceph_dentry(req->r_old_dentry)->offset);
 
 			/* swap r_dentry and r_old_dentry in case that
 			 * splice_dentry() gets called later. This is safe
@@ -1418,9 +1420,9 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 
 		/* null dentry? */
 		if (!rinfo->head->is_target) {
-			dout("fill_trace null dentry\n");
+			pr_debug("fill_trace null dentry\n");
 			if (d_really_is_positive(dn)) {
-				dout("d_delete %p\n", dn);
+				pr_debug("d_delete %p\n", dn);
 				ceph_dir_clear_ordered(dir);
 				d_delete(dn);
 			} else if (have_lease) {
@@ -1442,9 +1444,9 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				goto done;
 			dn = req->r_dentry;  /* may have spliced */
 		} else if (d_really_is_positive(dn) && d_inode(dn) != in) {
-			dout(" %p links to %p %llx.%llx, not %llx.%llx\n",
-			     dn, d_inode(dn), ceph_vinop(d_inode(dn)),
-			     ceph_vinop(in));
+			pr_debug("%p links to %p %llx.%llx, not %llx.%llx\n",
+				 dn, d_inode(dn), ceph_vinop(d_inode(dn)),
+				 ceph_vinop(in));
 			d_invalidate(dn);
 			have_lease = false;
 		}
@@ -1454,7 +1456,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 					    rinfo->dlease, session,
 					    req->r_request_started);
 		}
-		dout(" final dn %p\n", dn);
+		pr_debug("final dn %p\n", dn);
 	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
 		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
 	           test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
@@ -1465,7 +1467,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		BUG_ON(!dir);
 		BUG_ON(ceph_snap(dir) != CEPH_SNAPDIR);
 		BUG_ON(!req->r_dentry);
-		dout(" linking snapped dir %p to dn %p\n", in, req->r_dentry);
+		pr_debug("linking snapped dir %p to dn %p\n",
+			 in, req->r_dentry);
 		ceph_dir_clear_ordered(dir);
 		ihold(in);
 		err = splice_dentry(&req->r_dentry, in);
@@ -1487,7 +1490,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 					    &dvino, ptvino);
 	}
 done:
-	dout("fill_trace done err=%d\n", err);
+	pr_debug("fill_trace done err=%d\n", err);
 	return err;
 }
 
@@ -1512,7 +1515,7 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
 		in = ceph_get_inode(req->r_dentry->d_sb, vino);
 		if (IS_ERR(in)) {
 			err = PTR_ERR(in);
-			dout("new_inode badness got %d\n", err);
+			pr_debug("new_inode badness got %d\n", err);
 			continue;
 		}
 		rc = ceph_fill_inode(in, NULL, &rde->inode, NULL, session,
@@ -1574,11 +1577,11 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
 
 	if (req->r_dir_release_cnt == atomic64_read(&ci->i_release_count) &&
 	    req->r_dir_ordered_cnt == atomic64_read(&ci->i_ordered_count)) {
-		dout("readdir cache dn %p idx %d\n", dn, ctl->index);
+		pr_debug("readdir cache dn %p idx %d\n", dn, ctl->index);
 		ctl->dentries[idx] = dn;
 		ctl->index++;
 	} else {
-		dout("disable readdir cache\n");
+		pr_debug("disable readdir cache\n");
 		ctl->index = -1;
 	}
 	return 0;
@@ -1618,19 +1621,19 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 	if (rinfo->dir_dir &&
 	    le32_to_cpu(rinfo->dir_dir->frag) != frag) {
-		dout("readdir_prepopulate got new frag %x -> %x\n",
-		     frag, le32_to_cpu(rinfo->dir_dir->frag));
+		pr_debug("readdir_prepopulate got new frag %x -> %x\n",
+			 frag, le32_to_cpu(rinfo->dir_dir->frag));
 		frag = le32_to_cpu(rinfo->dir_dir->frag);
 		if (!rinfo->hash_order)
 			req->r_readdir_offset = 2;
 	}
 
 	if (le32_to_cpu(rinfo->head->op) == CEPH_MDS_OP_LSSNAP) {
-		dout("readdir_prepopulate %d items under SNAPDIR dn %p\n",
-		     rinfo->dir_nr, parent);
+		pr_debug("readdir_prepopulate %d items under SNAPDIR dn %p\n",
+			 rinfo->dir_nr, parent);
 	} else {
-		dout("readdir_prepopulate %d items under dn %p\n",
-		     rinfo->dir_nr, parent);
+		pr_debug("readdir_prepopulate %d items under dn %p\n",
+			 rinfo->dir_nr, parent);
 		if (rinfo->dir_dir)
 			ceph_fill_dirfrag(d_inode(parent), rinfo->dir_dir);
 
@@ -1676,15 +1679,15 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 retry_lookup:
 		dn = d_lookup(parent, &dname);
-		dout("d_lookup on parent=%p name=%.*s got %p\n",
-		     parent, dname.len, dname.name, dn);
+		pr_debug("d_lookup on parent=%p name=%.*s got %p\n",
+			 parent, dname.len, dname.name, dn);
 
 		if (!dn) {
 			dn = d_alloc(parent, &dname);
-			dout("d_alloc %p '%.*s' = %p\n", parent,
-			     dname.len, dname.name, dn);
+			pr_debug("d_alloc %p '%.*s' = %p\n",
+				 parent, dname.len, dname.name, dn);
 			if (!dn) {
-				dout("d_alloc badness\n");
+				pr_debug("d_alloc badness\n");
 				err = -ENOMEM;
 				goto out;
 			}
@@ -1692,8 +1695,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			   (ceph_ino(d_inode(dn)) != tvino.ino ||
 			    ceph_snap(d_inode(dn)) != tvino.snap)) {
 			struct ceph_dentry_info *di = ceph_dentry(dn);
-			dout(" dn %p points to wrong inode %p\n",
-			     dn, d_inode(dn));
+			pr_debug("dn %p points to wrong inode %p\n",
+				 dn, d_inode(dn));
 
 			spin_lock(&dn->d_lock);
 			if (di->offset > 0 &&
@@ -1715,7 +1718,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		} else {
 			in = ceph_get_inode(parent->d_sb, tvino);
 			if (IS_ERR(in)) {
-				dout("new_inode badness\n");
+				pr_debug("new_inode badness\n");
 				d_drop(dn);
 				dput(dn);
 				err = PTR_ERR(in);
@@ -1745,8 +1748,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 		if (d_really_is_negative(dn)) {
 			if (ceph_security_xattr_deadlock(in)) {
-				dout(" skip splicing dn %p to inode %p"
-				     " (security xattr deadlock)\n", dn, in);
+				pr_debug("skip splicing dn %p to inode %p (security xattr deadlock)\n",
+					 dn, in);
 				ceph_async_iput(in);
 				skipped++;
 				goto next_item;
@@ -1778,7 +1781,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		req->r_readdir_cache_idx = cache_ctl.index;
 	}
 	ceph_readdir_cache_release(&cache_ctl);
-	dout("readdir_prepopulate done\n");
+	pr_debug("readdir_prepopulate done\n");
 	return err;
 }
 
@@ -1788,7 +1791,7 @@ bool ceph_inode_set_size(struct inode *inode, loff_t size)
 	bool ret;
 
 	spin_lock(&ci->i_ceph_lock);
-	dout("set_size %p %llu -> %llu\n", inode, inode->i_size, size);
+	pr_debug("set_size %p %llu -> %llu\n", inode, inode->i_size, size);
 	i_size_write(inode, size);
 	inode->i_blocks = calc_inode_blocks(size);
 
@@ -1829,10 +1832,10 @@ void ceph_queue_writeback(struct inode *inode)
 	ihold(inode);
 	if (queue_work(ceph_inode_to_client(inode)->inode_wq,
 		       &ci->i_work)) {
-		dout("ceph_queue_writeback %p\n", inode);
+		pr_debug("ceph_queue_writeback %p\n", inode);
 	} else {
-		dout("ceph_queue_writeback %p already queued, mask=%lx\n",
-		     inode, ci->i_work_mask);
+		pr_debug("ceph_queue_writeback %p already queued, mask=%lx\n",
+			 inode, ci->i_work_mask);
 		iput(inode);
 	}
 }
@@ -1848,10 +1851,10 @@ void ceph_queue_invalidate(struct inode *inode)
 	ihold(inode);
 	if (queue_work(ceph_inode_to_client(inode)->inode_wq,
 		       &ceph_inode(inode)->i_work)) {
-		dout("ceph_queue_invalidate %p\n", inode);
+		pr_debug("ceph_queue_invalidate %p\n", inode);
 	} else {
-		dout("ceph_queue_invalidate %p already queued, mask=%lx\n",
-		     inode, ci->i_work_mask);
+		pr_debug("ceph_queue_invalidate %p already queued, mask=%lx\n",
+			 inode, ci->i_work_mask);
 		iput(inode);
 	}
 }
@@ -1868,10 +1871,10 @@ void ceph_queue_vmtruncate(struct inode *inode)
 	ihold(inode);
 	if (queue_work(ceph_inode_to_client(inode)->inode_wq,
 		       &ci->i_work)) {
-		dout("ceph_queue_vmtruncate %p\n", inode);
+		pr_debug("ceph_queue_vmtruncate %p\n", inode);
 	} else {
-		dout("ceph_queue_vmtruncate %p already queued, mask=%lx\n",
-		     inode, ci->i_work_mask);
+		pr_debug("ceph_queue_vmtruncate %p already queued, mask=%lx\n",
+			 inode, ci->i_work_mask);
 		iput(inode);
 	}
 }
@@ -1895,8 +1898,8 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	}
 
 	spin_lock(&ci->i_ceph_lock);
-	dout("invalidate_pages %p gen %d revoking %d\n", inode,
-	     ci->i_rdcache_gen, ci->i_rdcache_revoking);
+	pr_debug("invalidate_pages %p gen %d revoking %d\n",
+		 inode, ci->i_rdcache_gen, ci->i_rdcache_revoking);
 	if (ci->i_rdcache_revoking != ci->i_rdcache_gen) {
 		if (__ceph_caps_revoking_other(ci, NULL, CEPH_CAP_FILE_CACHE))
 			check = 1;
@@ -1914,14 +1917,14 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	spin_lock(&ci->i_ceph_lock);
 	if (orig_gen == ci->i_rdcache_gen &&
 	    orig_gen == ci->i_rdcache_revoking) {
-		dout("invalidate_pages %p gen %d successful\n", inode,
-		     ci->i_rdcache_gen);
+		pr_debug("invalidate_pages %p gen %d successful\n",
+			 inode, ci->i_rdcache_gen);
 		ci->i_rdcache_revoking--;
 		check = 1;
 	} else {
-		dout("invalidate_pages %p gen %d raced, now %d revoking %d\n",
-		     inode, orig_gen, ci->i_rdcache_gen,
-		     ci->i_rdcache_revoking);
+		pr_debug("invalidate_pages %p gen %d raced, now %d revoking %d\n",
+			 inode, orig_gen, ci->i_rdcache_gen,
+			 ci->i_rdcache_revoking);
 		if (__ceph_caps_revoking_other(ci, NULL, CEPH_CAP_FILE_CACHE))
 			check = 1;
 	}
@@ -1946,7 +1949,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 retry:
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_truncate_pending == 0) {
-		dout("__do_pending_vmtruncate %p none pending\n", inode);
+		pr_debug("__do_pending_vmtruncate %p none pending\n", inode);
 		spin_unlock(&ci->i_ceph_lock);
 		mutex_unlock(&ci->i_truncate_mutex);
 		return;
@@ -1958,8 +1961,8 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	 */
 	if (ci->i_wrbuffer_ref_head < ci->i_wrbuffer_ref) {
 		spin_unlock(&ci->i_ceph_lock);
-		dout("__do_pending_vmtruncate %p flushing snaps first\n",
-		     inode);
+		pr_debug("__do_pending_vmtruncate %p flushing snaps first\n",
+			 inode);
 		filemap_write_and_wait_range(&inode->i_data, 0,
 					     inode->i_sb->s_maxbytes);
 		goto retry;
@@ -1970,8 +1973,8 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 
 	to = ci->i_truncate_size;
 	wrbuffer_refs = ci->i_wrbuffer_ref;
-	dout("__do_pending_vmtruncate %p (%d) to %lld\n", inode,
-	     ci->i_truncate_pending, to);
+	pr_debug("__do_pending_vmtruncate %p (%d) to %lld\n",
+		 inode, ci->i_truncate_pending, to);
 	spin_unlock(&ci->i_ceph_lock);
 
 	truncate_pagecache(inode, to);
@@ -2000,7 +2003,7 @@ static void ceph_inode_work(struct work_struct *work)
 	struct inode *inode = &ci->vfs_inode;
 
 	if (test_and_clear_bit(CEPH_I_WORK_WRITEBACK, &ci->i_work_mask)) {
-		dout("writeback %p\n", inode);
+		pr_debug("writeback %p\n", inode);
 		filemap_fdatawrite(&inode->i_data);
 	}
 	if (test_and_clear_bit(CEPH_I_WORK_INVALIDATE_PAGES, &ci->i_work_mask))
@@ -2061,12 +2064,13 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		}
 	}
 
-	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
+	pr_debug("setattr %p issued %s\n", inode, ceph_cap_string(issued));
 
 	if (ia_valid & ATTR_UID) {
-		dout("setattr %p uid %d -> %d\n", inode,
-		     from_kuid(&init_user_ns, inode->i_uid),
-		     from_kuid(&init_user_ns, attr->ia_uid));
+		pr_debug("setattr %p uid %d -> %d\n",
+			 inode,
+			 from_kuid(&init_user_ns, inode->i_uid),
+			 from_kuid(&init_user_ns, attr->ia_uid));
 		if (issued & CEPH_CAP_AUTH_EXCL) {
 			inode->i_uid = attr->ia_uid;
 			dirtied |= CEPH_CAP_AUTH_EXCL;
@@ -2079,9 +2083,10 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		}
 	}
 	if (ia_valid & ATTR_GID) {
-		dout("setattr %p gid %d -> %d\n", inode,
-		     from_kgid(&init_user_ns, inode->i_gid),
-		     from_kgid(&init_user_ns, attr->ia_gid));
+		pr_debug("setattr %p gid %d -> %d\n",
+			 inode,
+			 from_kgid(&init_user_ns, inode->i_gid),
+			 from_kgid(&init_user_ns, attr->ia_gid));
 		if (issued & CEPH_CAP_AUTH_EXCL) {
 			inode->i_gid = attr->ia_gid;
 			dirtied |= CEPH_CAP_AUTH_EXCL;
@@ -2094,8 +2099,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		}
 	}
 	if (ia_valid & ATTR_MODE) {
-		dout("setattr %p mode 0%o -> 0%o\n", inode, inode->i_mode,
-		     attr->ia_mode);
+		pr_debug("setattr %p mode 0%o -> 0%o\n",
+			 inode, inode->i_mode, attr->ia_mode);
 		if (issued & CEPH_CAP_AUTH_EXCL) {
 			inode->i_mode = attr->ia_mode;
 			dirtied |= CEPH_CAP_AUTH_EXCL;
@@ -2109,9 +2114,10 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	}
 
 	if (ia_valid & ATTR_ATIME) {
-		dout("setattr %p atime %lld.%ld -> %lld.%ld\n", inode,
-		     inode->i_atime.tv_sec, inode->i_atime.tv_nsec,
-		     attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
+		pr_debug("setattr %p atime %lld.%ld -> %lld.%ld\n",
+			 inode,
+			 inode->i_atime.tv_sec, inode->i_atime.tv_nsec,
+			 attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
 			inode->i_atime = attr->ia_atime;
@@ -2131,8 +2137,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		}
 	}
 	if (ia_valid & ATTR_SIZE) {
-		dout("setattr %p size %lld -> %lld\n", inode,
-		     inode->i_size, attr->ia_size);
+		pr_debug("setattr %p size %lld -> %lld\n",
+			 inode, inode->i_size, attr->ia_size);
 		if ((issued & CEPH_CAP_FILE_EXCL) &&
 		    attr->ia_size > inode->i_size) {
 			i_size_write(inode, attr->ia_size);
@@ -2151,9 +2157,10 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		}
 	}
 	if (ia_valid & ATTR_MTIME) {
-		dout("setattr %p mtime %lld.%ld -> %lld.%ld\n", inode,
-		     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
-		     attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
+		pr_debug("setattr %p mtime %lld.%ld -> %lld.%ld\n",
+			 inode,
+			 inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
+			 attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
 			inode->i_mtime = attr->ia_mtime;
@@ -2177,10 +2184,11 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	if (ia_valid & ATTR_CTIME) {
 		bool only = (ia_valid & (ATTR_SIZE|ATTR_MTIME|ATTR_ATIME|
 					 ATTR_MODE|ATTR_UID|ATTR_GID)) == 0;
-		dout("setattr %p ctime %lld.%ld -> %lld.%ld (%s)\n", inode,
-		     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
-		     attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
-		     only ? "ctime only" : "ignored");
+		pr_debug("setattr %p ctime %lld.%ld -> %lld.%ld (%s)\n",
+			 inode,
+			 inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+			 attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
+			 only ? "ctime only" : "ignored");
 		if (only) {
 			/*
 			 * if kernel wants to dirty ctime but nothing else,
@@ -2198,7 +2206,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		}
 	}
 	if (ia_valid & ATTR_FILE)
-		dout("setattr %p ATTR_FILE ... hrm!\n", inode);
+		pr_debug("setattr %p ATTR_FILE ... hrm!\n", inode);
 
 	if (dirtied) {
 		inode_dirty_flags = __ceph_mark_dirty_caps(ci, dirtied,
@@ -2224,8 +2232,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		req->r_stamp = attr->ia_ctime;
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 	}
-	dout("setattr %p result=%d (%s locally, %d remote)\n", inode, err,
-	     ceph_cap_string(dirtied), mask);
+	pr_debug("setattr %p result=%d (%s locally, %d remote)\n",
+		 inode, err, ceph_cap_string(dirtied), mask);
 
 	ceph_mdsc_put_request(req);
 	ceph_free_cap_flush(prealloc_cf);
@@ -2282,12 +2290,12 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 	int err;
 
 	if (ceph_snap(inode) == CEPH_SNAPDIR) {
-		dout("do_getattr inode %p SNAPDIR\n", inode);
+		pr_debug("do_getattr inode %p SNAPDIR\n", inode);
 		return 0;
 	}
 
-	dout("do_getattr inode %p mask %s mode 0%o\n",
-	     inode, ceph_cap_string(mask), inode->i_mode);
+	pr_debug("do_getattr inode %p mask %s mode 0%o\n",
+		 inode, ceph_cap_string(mask), inode->i_mode);
 	if (!force && ceph_caps_issued_mask_metric(ceph_inode(inode), mask, 1))
 			return 0;
 
@@ -2313,7 +2321,7 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 		}
 	}
 	ceph_mdsc_put_request(req);
-	dout("do_getattr result=%d\n", err);
+	pr_debug("do_getattr result=%d\n", err);
 	return err;
 }
 
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 6e061bf62ad4..177417c23962 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -251,11 +251,11 @@ static long ceph_ioctl_lazyio(struct file *file)
 		ci->i_nr_by_mode[ffs(CEPH_FILE_MODE_LAZY)]++;
 		__ceph_touch_fmode(ci, mdsc, fi->fmode);
 		spin_unlock(&ci->i_ceph_lock);
-		dout("ioctl_layzio: file %p marked lazy\n", file);
+		pr_debug("ioctl_layzio: file %p marked lazy\n", file);
 
 		ceph_check_caps(ci, 0, NULL);
 	} else {
-		dout("ioctl_layzio: file %p already lazy\n", file);
+		pr_debug("ioctl_layzio: file %p already lazy\n", file);
 	}
 	return 0;
 }
@@ -270,7 +270,7 @@ static long ceph_ioctl_syncio(struct file *file)
 
 long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	dout("ioctl file %p cmd %u arg %lu\n", file, cmd, arg);
+	pr_debug("ioctl file %p cmd %u arg %lu\n", file, cmd, arg);
 	switch (cmd) {
 	case CEPH_IOC_GET_LAYOUT:
 		return ceph_ioctl_get_layout(file, (void __user *)arg);
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index d6b9166e71e4..8f6819d2dc99 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -98,10 +98,10 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 
 	owner = secure_addr(fl->fl_owner);
 
-	dout("ceph_lock_message: rule: %d, op: %d, owner: %llx, pid: %llu, "
-	     "start: %llu, length: %llu, wait: %d, type: %d\n", (int)lock_type,
-	     (int)operation, owner, (u64)fl->fl_pid, fl->fl_start, length,
-	     wait, fl->fl_type);
+	pr_debug("ceph_lock_message: rule: %d, op: %d, owner: %llx, pid: %llu, start: %llu, length: %llu, wait: %d, type: %d\n",
+		 (int)lock_type,
+		 (int)operation, owner, (u64)fl->fl_pid, fl->fl_start, length,
+		 wait, fl->fl_type);
 
 	req->r_args.filelock_change.rule = lock_type;
 	req->r_args.filelock_change.type = cmd;
@@ -134,10 +134,10 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 
 	}
 	ceph_mdsc_put_request(req);
-	dout("ceph_lock_message: rule: %d, op: %d, pid: %llu, start: %llu, "
-	     "length: %llu, wait: %d, type: %d, err code %d\n", (int)lock_type,
-	     (int)operation, (u64)fl->fl_pid, fl->fl_start,
-	     length, wait, fl->fl_type, err);
+	pr_debug("ceph_lock_message: rule: %d, op: %d, pid: %llu, start: %llu, length: %llu, wait: %d, type: %d, err code %d\n",
+		 (int)lock_type,
+		 (int)operation, (u64)fl->fl_pid, fl->fl_start,
+		 length, wait, fl->fl_type, err);
 	return err;
 }
 
@@ -161,8 +161,8 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 	if (!err)
 		return 0;
 
-	dout("ceph_lock_wait_for_completion: request %llu was interrupted\n",
-	     req->r_tid);
+	pr_debug("ceph_lock_wait_for_completion: request %llu was interrupted\n",
+		 req->r_tid);
 
 	mutex_lock(&mdsc->mutex);
 	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
@@ -244,7 +244,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	if (__mandatory_lock(file->f_mapping->host) && fl->fl_type != F_UNLCK)
 		return -ENOLCK;
 
-	dout("ceph_lock, fl_owner: %p\n", fl->fl_owner);
+	pr_debug("ceph_lock, fl_owner: %p\n", fl->fl_owner);
 
 	/* set wait bit as appropriate, then make command as Ceph expects it*/
 	if (IS_GETLK(cmd))
@@ -279,7 +279,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, inode, lock_cmd, wait, fl);
 	if (!err) {
 		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK != fl->fl_type) {
-			dout("mds locked, locking locally\n");
+			pr_debug("mds locked, locking locally\n");
 			err = posix_lock_file(file, fl, NULL);
 			if (err) {
 				/* undo! This should only happen if
@@ -287,8 +287,8 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 				 * deadlock. */
 				ceph_lock_message(CEPH_LOCK_FCNTL, op, inode,
 						  CEPH_LOCK_UNLOCK, 0, fl);
-				dout("got %d on posix_lock_file, undid lock\n",
-				     err);
+				pr_debug("got %d on posix_lock_file, undid lock\n",
+					 err);
 			}
 		}
 	}
@@ -309,7 +309,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	if (fl->fl_type & LOCK_MAND)
 		return -EOPNOTSUPP;
 
-	dout("ceph_flock, fl_file: %p\n", fl->fl_file);
+	pr_debug("ceph_flock, fl_file: %p\n", fl->fl_file);
 
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
@@ -346,7 +346,8 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 			ceph_lock_message(CEPH_LOCK_FLOCK,
 					  CEPH_MDS_OP_SETFILELOCK,
 					  inode, CEPH_LOCK_UNLOCK, 0, fl);
-			dout("got %d on locks_lock_file_wait, undid lock\n", err);
+			pr_debug("got %d on locks_lock_file_wait, undid lock\n",
+				 err);
 		}
 	}
 	return err;
@@ -373,8 +374,8 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 			++(*flock_count);
 		spin_unlock(&ctx->flc_lock);
 	}
-	dout("counted %d flock locks and %d fcntl locks\n",
-	     *flock_count, *fcntl_count);
+	pr_debug("counted %d flock locks and %d fcntl locks\n",
+		 *flock_count, *fcntl_count);
 }
 
 /*
@@ -401,7 +402,7 @@ static int lock_to_ceph_filelock(struct file_lock *lock,
 		cephlock->type = CEPH_LOCK_UNLOCK;
 		break;
 	default:
-		dout("Have unknown lock type %d\n", lock->fl_type);
+		pr_debug("Have unknown lock type %d\n", lock->fl_type);
 		err = -EINVAL;
 	}
 
@@ -424,8 +425,8 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 	int seen_flock = 0;
 	int l = 0;
 
-	dout("encoding %d flock and %d fcntl locks\n", num_flock_locks,
-	     num_fcntl_locks);
+	pr_debug("encoding %d flock and %d fcntl locks\n",
+		 num_flock_locks, num_fcntl_locks);
 
 	if (!ctx)
 		return 0;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4a26862d7667..1e1c51e396bd 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -369,7 +369,7 @@ static int parse_reply_info_readdir(void **p, void *end,
 		ceph_decode_need(p, end, rde->name_len, bad);
 		rde->name = *p;
 		*p += rde->name_len;
-		dout("parsed dir dname '%.*s'\n", rde->name_len, rde->name);
+		pr_debug("parsed dir dname '%.*s'\n", rde->name_len, rde->name);
 
 		/* dentry lease */
 		err = parse_reply_info_lease(p, end, &rde->lease, features);
@@ -427,7 +427,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 	u32 sets;
 
 	ceph_decode_32_safe(p, end, sets, bad);
-	dout("got %u sets of delegated inodes\n", sets);
+	pr_debug("got %u sets of delegated inodes\n", sets);
 	while (sets--) {
 		u64 start, len, ino;
 
@@ -438,8 +438,8 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 					    DELEGATED_INO_AVAILABLE,
 					    GFP_KERNEL);
 			if (!err) {
-				dout("added delegated inode 0x%llx\n",
-				     start - 1);
+				pr_debug("added delegated inode 0x%llx\n",
+					 start - 1);
 			} else if (err == -EBUSY) {
 				pr_warn("ceph: MDS delegated inode 0x%llx more than once.\n",
 					start - 1);
@@ -643,19 +643,21 @@ const char *ceph_session_state_name(int s)
 struct ceph_mds_session *ceph_get_mds_session(struct ceph_mds_session *s)
 {
 	if (refcount_inc_not_zero(&s->s_ref)) {
-		dout("mdsc get_session %p %d -> %d\n", s,
-		     refcount_read(&s->s_ref)-1, refcount_read(&s->s_ref));
+		pr_debug("mdsc get_session %p %d -> %d\n",
+			 s,
+			 refcount_read(&s->s_ref) - 1,
+			 refcount_read(&s->s_ref));
 		return s;
 	} else {
-		dout("mdsc get_session %p 0 -- FAIL\n", s);
+		pr_debug("mdsc get_session %p 0 -- FAIL\n", s);
 		return NULL;
 	}
 }
 
 void ceph_put_mds_session(struct ceph_mds_session *s)
 {
-	dout("mdsc put_session %p %d -> %d\n", s,
-	     refcount_read(&s->s_ref), refcount_read(&s->s_ref)-1);
+	pr_debug("mdsc put_session %p %d -> %d\n",
+		 s, refcount_read(&s->s_ref), refcount_read(&s->s_ref) - 1);
 	if (refcount_dec_and_test(&s->s_ref)) {
 		if (s->s_auth.authorizer)
 			ceph_auth_destroy_authorizer(s->s_auth.authorizer);
@@ -713,7 +715,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 		int newmax = 1 << get_count_order(mds + 1);
 		struct ceph_mds_session **sa;
 
-		dout("%s: realloc to %d\n", __func__, newmax);
+		pr_debug("%s: realloc to %d\n", __func__, newmax);
 		sa = kcalloc(newmax, sizeof(void *), GFP_NOFS);
 		if (!sa)
 			goto fail_realloc;
@@ -726,7 +728,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 		mdsc->max_sessions = newmax;
 	}
 
-	dout("%s: mds%d\n", __func__, mds);
+	pr_debug("%s: mds%d\n", __func__, mds);
 	s->s_mdsc = mdsc;
 	s->s_mds = mds;
 	s->s_state = CEPH_MDS_SESSION_NEW;
@@ -778,7 +780,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 static void __unregister_session(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_session *s)
 {
-	dout("__unregister_session mds%d %p\n", s->s_mds, s);
+	pr_debug("__unregister_session mds%d %p\n", s->s_mds, s);
 	BUG_ON(mdsc->sessions[s->s_mds] != s);
 	mdsc->sessions[s->s_mds] = NULL;
 	ceph_con_close(&s->s_con);
@@ -888,7 +890,7 @@ static void __register_request(struct ceph_mds_client *mdsc,
 			return;
 		}
 	}
-	dout("__register_request %p tid %lld\n", req, req->r_tid);
+	pr_debug("__register_request %p tid %lld\n", req, req->r_tid);
 	ceph_mdsc_get_request(req);
 	insert_request(&mdsc->request_tree, req);
 
@@ -912,7 +914,7 @@ static void __register_request(struct ceph_mds_client *mdsc,
 static void __unregister_request(struct ceph_mds_client *mdsc,
 				 struct ceph_mds_request *req)
 {
-	dout("__unregister_request %p tid %lld\n", req, req->r_tid);
+	pr_debug("__unregister_request %p tid %lld\n", req, req->r_tid);
 
 	/* Never leave an unregistered request on an unsafe list! */
 	list_del_init(&req->r_unsafe_item);
@@ -1010,8 +1012,8 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 	if (req->r_resend_mds >= 0 &&
 	    (__have_session(mdsc, req->r_resend_mds) ||
 	     ceph_mdsmap_get_state(mdsc->mdsmap, req->r_resend_mds) > 0)) {
-		dout("%s using resend_mds mds%d\n", __func__,
-		     req->r_resend_mds);
+		pr_debug("%s using resend_mds mds%d\n",
+			 __func__, req->r_resend_mds);
 		return req->r_resend_mds;
 	}
 
@@ -1028,7 +1030,8 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			rcu_read_lock();
 			inode = get_nonsnap_parent(req->r_dentry);
 			rcu_read_unlock();
-			dout("%s using snapdir's parent %p\n", __func__, inode);
+			pr_debug("%s using snapdir's parent %p\n",
+				 __func__, inode);
 		}
 	} else if (req->r_dentry) {
 		/* ignore race with rename; old or new d_parent is okay */
@@ -1048,7 +1051,8 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			/* direct snapped/virtual snapdir requests
 			 * based on parent dir inode */
 			inode = get_nonsnap_parent(parent);
-			dout("%s using nonsnap parent %p\n", __func__, inode);
+			pr_debug("%s using nonsnap parent %p\n",
+				 __func__, inode);
 		} else {
 			/* dentry target */
 			inode = d_inode(req->r_dentry);
@@ -1064,8 +1068,8 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		rcu_read_unlock();
 	}
 
-	dout("%s %p is_hash=%d (0x%x) mode %d\n", __func__, inode, (int)is_hash,
-	     hash, mode);
+	pr_debug("%s %p is_hash=%d (0x%x) mode %d\n",
+		 __func__, inode, (int)is_hash, hash, mode);
 	if (!inode)
 		goto random;
 	ci = ceph_inode(inode);
@@ -1083,9 +1087,9 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 				get_random_bytes(&r, 1);
 				r %= frag.ndist;
 				mds = frag.dist[r];
-				dout("%s %p %llx.%llx frag %u mds%d (%d/%d)\n",
-				     __func__, inode, ceph_vinop(inode),
-				     frag.frag, mds, (int)r, frag.ndist);
+				pr_debug("%s %p %llx.%llx frag %u mds%d (%d/%d)\n",
+					 __func__, inode, ceph_vinop(inode),
+					 frag.frag, mds, (int)r, frag.ndist);
 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
 				    CEPH_MDS_STATE_ACTIVE &&
 				    !ceph_mdsmap_is_laggy(mdsc->mdsmap, mds))
@@ -1098,9 +1102,9 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			if (frag.mds >= 0) {
 				/* choose auth mds */
 				mds = frag.mds;
-				dout("%s %p %llx.%llx frag %u mds%d (auth)\n",
-				     __func__, inode, ceph_vinop(inode),
-				     frag.frag, mds);
+				pr_debug("%s %p %llx.%llx frag %u mds%d (auth)\n",
+					 __func__, inode, ceph_vinop(inode),
+					 frag.frag, mds);
 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
 				    CEPH_MDS_STATE_ACTIVE) {
 					if (!ceph_mdsmap_is_laggy(mdsc->mdsmap,
@@ -1124,9 +1128,9 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		goto random;
 	}
 	mds = cap->session->s_mds;
-	dout("%s %p %llx.%llx mds%d (%scap %p)\n", __func__,
-	     inode, ceph_vinop(inode), mds,
-	     cap == ci->i_auth_cap ? "auth " : "", cap);
+	pr_debug("%s %p %llx.%llx mds%d (%scap %p)\n",
+		 __func__, inode, ceph_vinop(inode), mds,
+		 cap == ci->i_auth_cap ? "auth " : "", cap);
 	spin_unlock(&ci->i_ceph_lock);
 out:
 	/* avoid calling iput_final() while holding mdsc->mutex or
@@ -1139,7 +1143,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		*random = true;
 
 	mds = ceph_mdsmap_get_random_mds(mdsc->mdsmap);
-	dout("%s chose random mds%d\n", __func__, mds);
+	pr_debug("%s chose random mds%d\n", __func__, mds);
 	return mds;
 }
 
@@ -1358,8 +1362,8 @@ static int __open_session(struct ceph_mds_client *mdsc,
 
 	/* wait for mds to go active? */
 	mstate = ceph_mdsmap_get_state(mdsc->mdsmap, mds);
-	dout("open_session to mds%d (%s)\n", mds,
-	     ceph_mds_state_name(mstate));
+	pr_debug("open_session to mds%d (%s)\n",
+		 mds, ceph_mds_state_name(mstate));
 	session->s_state = CEPH_MDS_SESSION_OPENING;
 	session->s_renew_requested = jiffies;
 
@@ -1403,7 +1407,7 @@ ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target)
 {
 	struct ceph_mds_session *session;
 
-	dout("open_export_target_session to mds%d\n", target);
+	pr_debug("open_export_target_session to mds%d\n", target);
 
 	mutex_lock(&mdsc->mutex);
 	session = __open_export_target_session(mdsc, target);
@@ -1423,8 +1427,8 @@ static void __open_export_target_sessions(struct ceph_mds_client *mdsc,
 		return;
 
 	mi = &mdsc->mdsmap->m_info[mds];
-	dout("open_export_target_sessions for mds%d (%d targets)\n",
-	     session->s_mds, mi->num_export_targets);
+	pr_debug("open_export_target_sessions for mds%d (%d targets)\n",
+		 session->s_mds, mi->num_export_targets);
 
 	for (i = 0; i < mi->num_export_targets; i++) {
 		ts = __open_export_target_session(mdsc, mi->export_targets[i]);
@@ -1452,7 +1456,7 @@ static void detach_cap_releases(struct ceph_mds_session *session,
 
 	list_splice_init(&session->s_cap_releases, target);
 	session->s_num_cap_releases = 0;
-	dout("dispose_cap_releases mds%d\n", session->s_mds);
+	pr_debug("dispose_cap_releases mds%d\n", session->s_mds);
 }
 
 static void dispose_cap_releases(struct ceph_mds_client *mdsc,
@@ -1474,7 +1478,7 @@ static void cleanup_session_requests(struct ceph_mds_client *mdsc,
 	struct rb_node *p;
 	struct ceph_inode_info *ci;
 
-	dout("cleanup_session_requests mds%d\n", session->s_mds);
+	pr_debug("cleanup_session_requests mds%d\n", session->s_mds);
 	mutex_lock(&mdsc->mutex);
 	while (!list_empty(&session->s_unsafe)) {
 		req = list_first_entry(&session->s_unsafe,
@@ -1521,7 +1525,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 	struct ceph_cap *old_cap = NULL;
 	int ret;
 
-	dout("iterate_session_caps %p mds%d\n", session, session->s_mds);
+	pr_debug("iterate_session_caps %p mds%d\n", session, session->s_mds);
 	spin_lock(&session->s_cap_lock);
 	p = session->s_caps.next;
 	while (p != &session->s_caps) {
@@ -1551,8 +1555,8 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 		spin_lock(&session->s_cap_lock);
 		p = p->next;
 		if (!cap->ci) {
-			dout("iterate_session_caps  finishing cap %p removal\n",
-			     cap);
+			pr_debug("iterate_session_caps  finishing cap %p removal\n",
+				 cap);
 			BUG_ON(cap->session != session);
 			cap->session = NULL;
 			list_del_init(&cap->session_caps);
@@ -1587,8 +1591,8 @@ static int remove_session_caps_cb(struct inode *inode, struct ceph_cap *cap,
 	bool dirty_dropped = false;
 	bool invalidate = false;
 
-	dout("removing cap %p, ci is %p, inode is %p\n",
-	     cap, ci, &ci->vfs_inode);
+	pr_debug("removing cap %p, ci is %p, inode is %p\n",
+		 cap, ci, &ci->vfs_inode);
 	spin_lock(&ci->i_ceph_lock);
 	__ceph_remove_cap(cap, false);
 	if (!ci->i_auth_cap) {
@@ -1684,7 +1688,7 @@ static void remove_session_caps(struct ceph_mds_session *session)
 	struct super_block *sb = fsc->sb;
 	LIST_HEAD(dispose);
 
-	dout("remove_session_caps on %p\n", session);
+	pr_debug("remove_session_caps on %p\n", session);
 	ceph_iterate_session_caps(session, remove_session_caps_cb, fsc);
 
 	wake_up_all(&fsc->mdsc->cap_flushing_wq);
@@ -1765,7 +1769,7 @@ static int wake_up_session_cb(struct inode *inode, struct ceph_cap *cap,
 
 static void wake_up_session_caps(struct ceph_mds_session *session, int ev)
 {
-	dout("wake_up_session_caps %p mds%d\n", session, session->s_mds);
+	pr_debug("wake_up_session_caps %p mds%d\n", session, session->s_mds);
 	ceph_iterate_session_caps(session, wake_up_session_cb,
 				  (void *)(unsigned long)ev);
 }
@@ -1791,13 +1795,13 @@ static int send_renew_caps(struct ceph_mds_client *mdsc,
 	 * with its clients. */
 	state = ceph_mdsmap_get_state(mdsc->mdsmap, session->s_mds);
 	if (state < CEPH_MDS_STATE_RECONNECT) {
-		dout("send_renew_caps ignoring mds%d (%s)\n",
-		     session->s_mds, ceph_mds_state_name(state));
+		pr_debug("send_renew_caps ignoring mds%d (%s)\n",
+			 session->s_mds, ceph_mds_state_name(state));
 		return 0;
 	}
 
-	dout("send_renew_caps to mds%d (%s)\n", session->s_mds,
-		ceph_mds_state_name(state));
+	pr_debug("send_renew_caps to mds%d (%s)\n",
+		 session->s_mds, ceph_mds_state_name(state));
 	msg = create_session_msg(CEPH_SESSION_REQUEST_RENEWCAPS,
 				 ++session->s_renew_seq);
 	if (!msg)
@@ -1811,8 +1815,9 @@ static int send_flushmsg_ack(struct ceph_mds_client *mdsc,
 {
 	struct ceph_msg *msg;
 
-	dout("send_flushmsg_ack to mds%d (%s)s seq %lld\n",
-	     session->s_mds, ceph_session_state_name(session->s_state), seq);
+	pr_debug("send_flushmsg_ack to mds%d (%s)s seq %lld\n",
+		 session->s_mds,
+		 ceph_session_state_name(session->s_state), seq);
 	msg = create_session_msg(CEPH_SESSION_FLUSHMSG_ACK, seq);
 	if (!msg)
 		return -ENOMEM;
@@ -1846,9 +1851,10 @@ static void renewed_caps(struct ceph_mds_client *mdsc,
 			pr_info("mds%d caps still stale\n", session->s_mds);
 		}
 	}
-	dout("renewed_caps mds%d ttl now %lu, was %s, now %s\n",
-	     session->s_mds, session->s_cap_ttl, was_stale ? "stale" : "fresh",
-	     time_before(jiffies, session->s_cap_ttl) ? "stale" : "fresh");
+	pr_debug("renewed_caps mds%d ttl now %lu, was %s, now %s\n",
+		 session->s_mds, session->s_cap_ttl,
+		 was_stale ? "stale" : "fresh",
+		 time_before(jiffies, session->s_cap_ttl) ? "stale" : "fresh");
 	spin_unlock(&session->s_cap_lock);
 
 	if (wake)
@@ -1862,9 +1868,9 @@ static int request_close_session(struct ceph_mds_session *session)
 {
 	struct ceph_msg *msg;
 
-	dout("request_close_session mds%d state %s seq %lld\n",
-	     session->s_mds, ceph_session_state_name(session->s_state),
-	     session->s_seq);
+	pr_debug("request_close_session mds%d state %s seq %lld\n",
+		 session->s_mds, ceph_session_state_name(session->s_state),
+		 session->s_seq);
 	msg = create_session_msg(CEPH_SESSION_REQUEST_CLOSE, session->s_seq);
 	if (!msg)
 		return -ENOMEM;
@@ -1932,9 +1938,9 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 	wanted = __ceph_caps_file_wanted(ci);
 	oissued = __ceph_caps_issued_other(ci, cap);
 
-	dout("trim_caps_cb %p cap %p mine %s oissued %s used %s wanted %s\n",
-	     inode, cap, ceph_cap_string(mine), ceph_cap_string(oissued),
-	     ceph_cap_string(used), ceph_cap_string(wanted));
+	pr_debug("trim_caps_cb %p cap %p mine %s oissued %s used %s wanted %s\n",
+		 inode, cap, ceph_cap_string(mine), ceph_cap_string(oissued),
+		 ceph_cap_string(used), ceph_cap_string(wanted));
 	if (cap == ci->i_auth_cap) {
 		if (ci->i_dirty_caps || ci->i_flushing_caps ||
 		    !list_empty(&ci->i_cap_snaps))
@@ -1974,8 +1980,8 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 			count = atomic_read(&inode->i_count);
 			if (count == 1)
 				(*remaining)--;
-			dout("trim_caps_cb %p cap %p pruned, count now %d\n",
-			     inode, cap, count);
+			pr_debug("trim_caps_cb %p cap %p pruned, count now %d\n",
+				 inode, cap, count);
 		} else {
 			dput(dentry);
 		}
@@ -1996,15 +2002,15 @@ int ceph_trim_caps(struct ceph_mds_client *mdsc,
 {
 	int trim_caps = session->s_nr_caps - max_caps;
 
-	dout("trim_caps mds%d start: %d / %d, trim %d\n",
-	     session->s_mds, session->s_nr_caps, max_caps, trim_caps);
+	pr_debug("trim_caps mds%d start: %d / %d, trim %d\n",
+		 session->s_mds, session->s_nr_caps, max_caps, trim_caps);
 	if (trim_caps > 0) {
 		int remaining = trim_caps;
 
 		ceph_iterate_session_caps(session, trim_caps_cb, &remaining);
-		dout("trim_caps mds%d done: %d / %d, trimmed %d\n",
-		     session->s_mds, session->s_nr_caps, max_caps,
-			trim_caps - remaining);
+		pr_debug("trim_caps mds%d done: %d / %d, trimmed %d\n",
+			 session->s_mds, session->s_nr_caps, max_caps,
+			 trim_caps - remaining);
 	}
 
 	ceph_flush_cap_releases(mdsc, session);
@@ -2022,8 +2028,8 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 			list_first_entry(&mdsc->cap_flush_list,
 					 struct ceph_cap_flush, g_list);
 		if (cf->tid <= want_flush_tid) {
-			dout("check_caps_flush still flushing tid "
-			     "%llu <= %llu\n", cf->tid, want_flush_tid);
+			pr_debug("check_caps_flush still flushing tid %llu <= %llu\n",
+				 cf->tid, want_flush_tid);
 			ret = 0;
 		}
 	}
@@ -2039,12 +2045,12 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 static void wait_caps_flush(struct ceph_mds_client *mdsc,
 			    u64 want_flush_tid)
 {
-	dout("check_caps_flush want %llu\n", want_flush_tid);
+	pr_debug("check_caps_flush want %llu\n", want_flush_tid);
 
 	wait_event(mdsc->cap_flushing_wq,
 		   check_caps_flush(mdsc, want_flush_tid));
 
-	dout("check_caps_flush ok, flushed thru %llu\n", want_flush_tid);
+	pr_debug("check_caps_flush ok, flushed thru %llu\n", want_flush_tid);
 }
 
 /*
@@ -2111,7 +2117,8 @@ static void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 			msg->front.iov_len += sizeof(*cap_barrier);
 
 			msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
-			dout("send_cap_releases mds%d %p\n", session->s_mds, msg);
+			pr_debug("send_cap_releases mds%d %p\n",
+				 session->s_mds, msg);
 			ceph_con_send(&session->s_con, msg);
 			msg = NULL;
 		}
@@ -2131,7 +2138,7 @@ static void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 		msg->front.iov_len += sizeof(*cap_barrier);
 
 		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
-		dout("send_cap_releases mds%d %p\n", session->s_mds, msg);
+		pr_debug("send_cap_releases mds%d %p\n", session->s_mds, msg);
 		ceph_con_send(&session->s_con, msg);
 	}
 	return;
@@ -2166,10 +2173,10 @@ void ceph_flush_cap_releases(struct ceph_mds_client *mdsc,
 	ceph_get_mds_session(session);
 	if (queue_work(mdsc->fsc->cap_wq,
 		       &session->s_cap_release_work)) {
-		dout("cap release work queued\n");
+		pr_debug("cap release work queued\n");
 	} else {
 		ceph_put_mds_session(session);
-		dout("failed to queue cap release work\n");
+		pr_debug("failed to queue cap release work\n");
 	}
 }
 
@@ -2201,9 +2208,9 @@ void ceph_queue_cap_reclaim_work(struct ceph_mds_client *mdsc)
 		return;
 
         if (queue_work(mdsc->fsc->cap_wq, &mdsc->cap_reclaim_work)) {
-                dout("caps reclaim work queued\n");
+		pr_debug("caps reclaim work queued\n");
         } else {
-                dout("failed to queue caps release work\n");
+		pr_debug("failed to queue caps release work\n");
         }
 }
 
@@ -2351,8 +2358,8 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 		spin_lock(&temp->d_lock);
 		inode = d_inode(temp);
 		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
-			dout("build_path path+%d: %p SNAPDIR\n",
-			     pos, temp);
+			pr_debug("build_path path+%d: %p SNAPDIR\n",
+				 pos, temp);
 		} else if (stop_on_nosnap && inode && dentry != temp &&
 			   ceph_snap(inode) == CEPH_NOSNAP) {
 			spin_unlock(&temp->d_lock);
@@ -2397,8 +2404,8 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 
 	*pbase = base;
 	*plen = PATH_MAX - 1 - pos;
-	dout("build_path on %p %d built %llx '%.*s'\n",
-	     dentry, d_count(dentry), base, *plen, path + pos);
+	pr_debug("build_path on %p %d built %llx '%.*s'\n",
+		 dentry, d_count(dentry), base, *plen, path + pos);
 	return path + pos;
 }
 
@@ -2462,18 +2469,18 @@ static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
 
 	if (rinode) {
 		r = build_inode_path(rinode, ppath, pathlen, ino, freepath);
-		dout(" inode %p %llx.%llx\n", rinode, ceph_ino(rinode),
-		     ceph_snap(rinode));
+		pr_debug("inode %p %llx.%llx\n",
+			 rinode, ceph_ino(rinode), ceph_snap(rinode));
 	} else if (rdentry) {
 		r = build_dentry_path(rdentry, rdiri, ppath, pathlen, ino,
 					freepath, parent_locked);
-		dout(" dentry %p %llx/%.*s\n", rdentry, *ino, *pathlen,
-		     *ppath);
+		pr_debug("dentry %p %llx/%.*s\n",
+			 rdentry, *ino, *pathlen, *ppath);
 	} else if (rpath || rino) {
 		*ino = rino;
 		*ppath = rpath;
 		*pathlen = rpath ? strlen(rpath) : 0;
-		dout(" path %.*s\n", *pathlen, rpath);
+		pr_debug("path %.*s\n", *pathlen, rpath);
 	}
 
 	return r;
@@ -2656,8 +2663,8 @@ static int __prepare_send_request(struct ceph_mds_client *mdsc,
 		else
 			req->r_sent_on_mseq = -1;
 	}
-	dout("prepare_send_request %p tid %lld %s (attempt %d)\n", req,
-	     req->r_tid, ceph_mds_op_name(req->r_op), req->r_attempts);
+	pr_debug("prepare_send_request %p tid %lld %s (attempt %d)\n",
+		 req, req->r_tid, ceph_mds_op_name(req->r_op), req->r_attempts);
 
 	if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags)) {
 		void *p;
@@ -2718,7 +2725,7 @@ static int __prepare_send_request(struct ceph_mds_client *mdsc,
 	rhead->num_fwd = req->r_num_fwd;
 	rhead->num_retry = req->r_attempts - 1;
 
-	dout(" r_parent = %p\n", req->r_parent);
+	pr_debug("r_parent = %p\n", req->r_parent);
 	return 0;
 }
 
@@ -2761,23 +2768,23 @@ static void __do_request(struct ceph_mds_client *mdsc,
 
 	if (req->r_timeout &&
 	    time_after_eq(jiffies, req->r_started + req->r_timeout)) {
-		dout("do_request timed out\n");
+		pr_debug("do_request timed out\n");
 		err = -ETIMEDOUT;
 		goto finish;
 	}
 	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
-		dout("do_request forced umount\n");
+		pr_debug("do_request forced umount\n");
 		err = -EIO;
 		goto finish;
 	}
 	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_MOUNTING) {
 		if (mdsc->mdsmap_err) {
 			err = mdsc->mdsmap_err;
-			dout("do_request mdsmap err %d\n", err);
+			pr_debug("do_request mdsmap err %d\n", err);
 			goto finish;
 		}
 		if (mdsc->mdsmap->m_epoch == 0) {
-			dout("do_request no mdsmap, waiting for map\n");
+			pr_debug("do_request no mdsmap, waiting for map\n");
 			list_add(&req->r_wait, &mdsc->waiting_for_map);
 			return;
 		}
@@ -2798,7 +2805,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 			err = -EJUKEBOX;
 			goto finish;
 		}
-		dout("do_request no mds or not active, waiting for map\n");
+		pr_debug("do_request no mds or not active, waiting for map\n");
 		list_add(&req->r_wait, &mdsc->waiting_for_map);
 		return;
 	}
@@ -2814,8 +2821,8 @@ static void __do_request(struct ceph_mds_client *mdsc,
 	}
 	req->r_session = ceph_get_mds_session(session);
 
-	dout("do_request mds%d session %p state %s\n", mds, session,
-	     ceph_session_state_name(session->s_state));
+	pr_debug("do_request mds%d session %p state %s\n",
+		 mds, session, ceph_session_state_name(session->s_state));
 	if (session->s_state != CEPH_MDS_SESSION_OPEN &&
 	    session->s_state != CEPH_MDS_SESSION_HUNG) {
 		if (session->s_state == CEPH_MDS_SESSION_REJECTED) {
@@ -2856,7 +2863,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 	ceph_put_mds_session(session);
 finish:
 	if (err) {
-		dout("__do_request early error %d\n", err);
+		pr_debug("__do_request early error %d\n", err);
 		req->r_err = err;
 		complete_request(mdsc, req);
 		__unregister_request(mdsc, req);
@@ -2879,7 +2886,7 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
 		req = list_entry(tmp_list.next,
 				 struct ceph_mds_request, r_wait);
 		list_del_init(&req->r_wait);
-		dout(" wake request %p tid %llu\n", req, req->r_tid);
+		pr_debug("wake request %p tid %llu\n", req, req->r_tid);
 		__do_request(mdsc, req);
 	}
 }
@@ -2893,7 +2900,7 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 	struct ceph_mds_request *req;
 	struct rb_node *p = rb_first(&mdsc->request_tree);
 
-	dout("kick_requests mds%d\n", mds);
+	pr_debug("kick_requests mds%d\n", mds);
 	while (p) {
 		req = rb_entry(p, struct ceph_mds_request, r_node);
 		p = rb_next(p);
@@ -2903,7 +2910,7 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 			continue; /* only new requests */
 		if (req->r_session &&
 		    req->r_session->s_mds == mds) {
-			dout(" kicking tid %llu\n", req->r_tid);
+			pr_debug("kicking tid %llu\n", req->r_tid);
 			list_del_init(&req->r_wait);
 			__do_request(mdsc, req);
 		}
@@ -2935,8 +2942,8 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 	if (req->r_inode) {
 		err = ceph_wait_on_async_create(req->r_inode);
 		if (err) {
-			dout("%s: wait for async create returned: %d\n",
-			     __func__, err);
+			pr_debug("%s: wait for async create returned: %d\n",
+				 __func__, err);
 			return err;
 		}
 	}
@@ -2944,13 +2951,13 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 	if (!err && req->r_old_inode) {
 		err = ceph_wait_on_async_create(req->r_old_inode);
 		if (err) {
-			dout("%s: wait for async create returned: %d\n",
-			     __func__, err);
+			pr_debug("%s: wait for async create returned: %d\n",
+				 __func__, err);
 			return err;
 		}
 	}
 
-	dout("submit_request on %p for inode %p\n", req, dir);
+	pr_debug("submit_request on %p for inode %p\n", req, dir);
 	mutex_lock(&mdsc->mutex);
 	__register_request(mdsc, req, dir);
 	__do_request(mdsc, req);
@@ -2965,7 +2972,7 @@ static int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
 	int err;
 
 	/* wait */
-	dout("do_request waiting\n");
+	pr_debug("do_request waiting\n");
 	if (!req->r_timeout && req->r_wait_for_completion) {
 		err = req->r_wait_for_completion(mdsc, req);
 	} else {
@@ -2979,14 +2986,14 @@ static int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
 		else
 			err = timeleft;  /* killed */
 	}
-	dout("do_request waited, got %d\n", err);
+	pr_debug("do_request waited, got %d\n", err);
 	mutex_lock(&mdsc->mutex);
 
 	/* only abort if we didn't race with a real reply */
 	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
 		err = le32_to_cpu(req->r_reply_info.head->result);
 	} else if (err < 0) {
-		dout("aborted request %lld with %d\n", req->r_tid, err);
+		pr_debug("aborted request %lld with %d\n", req->r_tid, err);
 
 		/*
 		 * ensure we aren't running concurrently with
@@ -3019,13 +3026,13 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
 {
 	int err;
 
-	dout("do_request on %p\n", req);
+	pr_debug("do_request on %p\n", req);
 
 	/* issue */
 	err = ceph_mdsc_submit_request(mdsc, dir, req);
 	if (!err)
 		err = ceph_mdsc_wait_request(mdsc, req);
-	dout("do_request %p done, result %d\n", req, err);
+	pr_debug("do_request %p done, result %d\n", req, err);
 	return err;
 }
 
@@ -3038,7 +3045,8 @@ void ceph_invalidate_dir_request(struct ceph_mds_request *req)
 	struct inode *dir = req->r_parent;
 	struct inode *old_dir = req->r_old_dentry_dir;
 
-	dout("invalidate_dir_request %p %p (complete, lease(s))\n", dir, old_dir);
+	pr_debug("invalidate_dir_request %p %p (complete, lease(s))\n",
+		 dir, old_dir);
 
 	ceph_dir_clear_complete(dir);
 	if (old_dir)
@@ -3078,11 +3086,11 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	mutex_lock(&mdsc->mutex);
 	req = lookup_get_request(mdsc, tid);
 	if (!req) {
-		dout("handle_reply on unknown tid %llu\n", tid);
+		pr_debug("handle_reply on unknown tid %llu\n", tid);
 		mutex_unlock(&mdsc->mutex);
 		return;
 	}
-	dout("handle_reply %p\n", req);
+	pr_debug("handle_reply %p\n", req);
 
 	/* correct session? */
 	if (req->r_session != session) {
@@ -3118,10 +3126,10 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	 * Otherwise we just have to return an ESTALE
 	 */
 	if (result == -ESTALE) {
-		dout("got ESTALE on request %llu\n", req->r_tid);
+		pr_debug("got ESTALE on request %llu\n", req->r_tid);
 		req->r_resend_mds = -1;
 		if (req->r_direct_mode != USE_AUTH_MDS) {
-			dout("not using auth, setting for that now\n");
+			pr_debug("not using auth, setting for that now\n");
 			req->r_direct_mode = USE_AUTH_MDS;
 			__do_request(mdsc, req);
 			mutex_unlock(&mdsc->mutex);
@@ -3129,13 +3137,13 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 		} else  {
 			int mds = __choose_mds(mdsc, req, NULL);
 			if (mds >= 0 && mds != req->r_session->s_mds) {
-				dout("but auth changed, so resending\n");
+				pr_debug("but auth changed, so resending\n");
 				__do_request(mdsc, req);
 				mutex_unlock(&mdsc->mutex);
 				goto out;
 			}
 		}
-		dout("have to return ESTALE on request %llu\n", req->r_tid);
+		pr_debug("have to return ESTALE on request %llu\n", req->r_tid);
 	}
 
 
@@ -3155,7 +3163,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			 * response.  And even if it did, there is nothing
 			 * useful we could do with a revised return value.
 			 */
-			dout("got safe reply %llu, mds%d\n", tid, mds);
+			pr_debug("got safe reply %llu, mds%d\n", tid, mds);
 
 			mutex_unlock(&mdsc->mutex);
 			goto out;
@@ -3165,7 +3173,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 		list_add_tail(&req->r_unsafe_item, &req->r_session->s_unsafe);
 	}
 
-	dout("handle_reply tid %lld result %d\n", tid, result);
+	pr_debug("handle_reply tid %lld result %d\n", tid, result);
 	rinfo = &req->r_reply_info;
 	if (test_bit(CEPHFS_FEATURE_REPLY_ENCODING, &session->s_features))
 		err = parse_reply_info(session, msg, rinfo, (u64)-1);
@@ -3232,7 +3240,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			set_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags);
 		}
 	} else {
-		dout("reply arrived after request %lld was aborted\n", tid);
+		pr_debug("reply arrived after request %lld was aborted\n", tid);
 	}
 	mutex_unlock(&mdsc->mutex);
 
@@ -3272,19 +3280,21 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 	mutex_lock(&mdsc->mutex);
 	req = lookup_get_request(mdsc, tid);
 	if (!req) {
-		dout("forward tid %llu to mds%d - req dne\n", tid, next_mds);
+		pr_debug("forward tid %llu to mds%d - req dne\n",
+			 tid, next_mds);
 		goto out;  /* dup reply? */
 	}
 
 	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
-		dout("forward tid %llu aborted, unregistering\n", tid);
+		pr_debug("forward tid %llu aborted, unregistering\n", tid);
 		__unregister_request(mdsc, req);
 	} else if (fwd_seq <= req->r_num_fwd) {
-		dout("forward tid %llu to mds%d - old seq %d <= %d\n",
-		     tid, next_mds, req->r_num_fwd, fwd_seq);
+		pr_debug("forward tid %llu to mds%d - old seq %d <= %d\n",
+			 tid, next_mds, req->r_num_fwd, fwd_seq);
 	} else {
 		/* resend. forward race not possible; mds would drop */
-		dout("forward tid %llu to mds%d (we resend)\n", tid, next_mds);
+		pr_debug("forward tid %llu to mds%d (we resend)\n",
+			 tid, next_mds);
 		BUG_ON(req->r_err);
 		BUG_ON(test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags));
 		req->r_attempts = 0;
@@ -3375,9 +3385,9 @@ static void handle_session(struct ceph_mds_session *session,
 
 	mutex_lock(&session->s_mutex);
 
-	dout("handle_session mds%d %s %p state %s seq %llu\n",
-	     mds, ceph_session_op_name(op), session,
-	     ceph_session_state_name(session->s_state), seq);
+	pr_debug("handle_session mds%d %s %p state %s seq %llu\n",
+		 mds, ceph_session_op_name(op), session,
+		 ceph_session_state_name(session->s_state), seq);
 
 	if (session->s_state == CEPH_MDS_SESSION_HUNG) {
 		session->s_state = CEPH_MDS_SESSION_OPEN;
@@ -3432,7 +3442,7 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_FORCE_RO:
-		dout("force_session_readonly %p\n", session);
+		pr_debug("force_session_readonly %p\n", session);
 		spin_lock(&session->s_cap_lock);
 		session->s_readonly = true;
 		spin_unlock(&session->s_cap_lock);
@@ -3480,7 +3490,7 @@ void ceph_mdsc_release_dir_caps(struct ceph_mds_request *req)
 
 	dcaps = xchg(&req->r_dir_caps, 0);
 	if (dcaps) {
-		dout("releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
+		pr_debug("releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
 		ceph_put_cap_refs(ceph_inode(req->r_parent), dcaps);
 	}
 }
@@ -3491,7 +3501,7 @@ void ceph_mdsc_release_dir_caps_no_check(struct ceph_mds_request *req)
 
 	dcaps = xchg(&req->r_dir_caps, 0);
 	if (dcaps) {
-		dout("releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
+		pr_debug("releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
 		ceph_put_cap_refs_no_check_caps(ceph_inode(req->r_parent),
 						dcaps);
 	}
@@ -3506,7 +3516,7 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 	struct ceph_mds_request *req, *nreq;
 	struct rb_node *p;
 
-	dout("replay_unsafe_requests mds%d\n", session->s_mds);
+	pr_debug("replay_unsafe_requests mds%d\n", session->s_mds);
 
 	mutex_lock(&mdsc->mutex);
 	list_for_each_entry_safe(req, nreq, &session->s_unsafe, r_unsafe_item)
@@ -3628,9 +3638,9 @@ static int reconnect_caps_cb(struct inode *inode, struct ceph_cap *cap,
 	int err;
 	u64 snap_follows;
 
-	dout(" adding %p ino %llx.%llx cap %p %lld %s\n",
-	     inode, ceph_vinop(inode), cap, cap->cap_id,
-	     ceph_cap_string(cap->issued));
+	pr_debug("adding %p ino %llx.%llx cap %p %lld %s\n",
+		 inode, ceph_vinop(inode), cap, cap->cap_id,
+		 ceph_cap_string(cap->issued));
 
 	spin_lock(&ci->i_ceph_lock);
 	cap->seq = 0;        /* reset cap seq */
@@ -3838,8 +3848,8 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 			ceph_pagelist_encode_32(pagelist, sizeof(sr_rec));
 		}
 
-		dout(" adding snap realm %llx seq %lld parent %llx\n",
-		     realm->ino, realm->seq, realm->parent_ino);
+		pr_debug("adding snap realm %llx seq %lld parent %llx\n",
+			 realm->ino, realm->seq, realm->parent_ino);
 		sr_rec.ino = cpu_to_le64(realm->ino);
 		sr_rec.seq = cpu_to_le64(realm->seq);
 		sr_rec.parent = cpu_to_le64(realm->parent_ino);
@@ -3892,8 +3902,8 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
-	dout("session %p state %s\n", session,
-	     ceph_session_state_name(session->s_state));
+	pr_debug("session %p state %s\n",
+		 session, ceph_session_state_name(session->s_state));
 
 	spin_lock(&session->s_gen_ttl_lock);
 	session->s_cap_gen++;
@@ -4048,8 +4058,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 	int oldstate, newstate;
 	struct ceph_mds_session *s;
 
-	dout("check_new_map new %u old %u\n",
-	     newmap->m_epoch, oldmap->m_epoch);
+	pr_debug("check_new_map new %u old %u\n",
+		 newmap->m_epoch, oldmap->m_epoch);
 
 	for (i = 0; i < oldmap->possible_max_rank && i < mdsc->max_sessions; i++) {
 		if (!mdsc->sessions[i])
@@ -4058,12 +4068,12 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		oldstate = ceph_mdsmap_get_state(oldmap, i);
 		newstate = ceph_mdsmap_get_state(newmap, i);
 
-		dout("check_new_map mds%d state %s%s -> %s%s (session %s)\n",
-		     i, ceph_mds_state_name(oldstate),
-		     ceph_mdsmap_is_laggy(oldmap, i) ? " (laggy)" : "",
-		     ceph_mds_state_name(newstate),
-		     ceph_mdsmap_is_laggy(newmap, i) ? " (laggy)" : "",
-		     ceph_session_state_name(s->s_state));
+		pr_debug("check_new_map mds%d state %s%s -> %s%s (session %s)\n",
+			 i, ceph_mds_state_name(oldstate),
+			 ceph_mdsmap_is_laggy(oldmap, i) ? " (laggy)" : "",
+			 ceph_mds_state_name(newstate),
+			 ceph_mdsmap_is_laggy(newmap, i) ? " (laggy)" : "",
+			 ceph_session_state_name(s->s_state));
 
 		if (i >= newmap->possible_max_rank) {
 			/* force close session for stopped mds */
@@ -4135,8 +4145,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		if (s->s_state == CEPH_MDS_SESSION_OPEN ||
 		    s->s_state == CEPH_MDS_SESSION_HUNG ||
 		    s->s_state == CEPH_MDS_SESSION_CLOSING) {
-			dout(" connecting to export targets of laggy mds%d\n",
-			     i);
+			pr_debug("connecting to export targets of laggy mds%d\n",
+				 i);
 			__open_export_target_sessions(mdsc, s);
 		}
 	}
@@ -4174,7 +4184,7 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 	struct qstr dname;
 	int release = 0;
 
-	dout("handle_lease from mds%d\n", mds);
+	pr_debug("handle_lease from mds%d\n", mds);
 
 	/* decode */
 	if (msg->front.iov_len < sizeof(*h) + sizeof(u32))
@@ -4189,22 +4199,22 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 
 	/* lookup inode */
 	inode = ceph_find_inode(sb, vino);
-	dout("handle_lease %s, ino %llx %p %.*s\n",
-	     ceph_lease_op_name(h->action), vino.ino, inode,
-	     dname.len, dname.name);
+	pr_debug("handle_lease %s, ino %llx %p %.*s\n",
+		 ceph_lease_op_name(h->action), vino.ino, inode,
+		 dname.len, dname.name);
 
 	mutex_lock(&session->s_mutex);
 	session->s_seq++;
 
 	if (!inode) {
-		dout("handle_lease no inode %llx\n", vino.ino);
+		pr_debug("handle_lease no inode %llx\n", vino.ino);
 		goto release;
 	}
 
 	/* dentry */
 	parent = d_find_alias(inode);
 	if (!parent) {
-		dout("no parent dentry on inode %p\n", inode);
+		pr_debug("no parent dentry on inode %p\n", inode);
 		WARN_ON(1);
 		goto release;  /* hrm... */
 	}
@@ -4274,8 +4284,8 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
 	struct inode *dir;
 	int len = sizeof(*lease) + sizeof(u32) + NAME_MAX;
 
-	dout("lease_send_msg identry %p %s to mds%d\n",
-	     dentry, ceph_lease_op_name(action), session->s_mds);
+	pr_debug("lease_send_msg identry %p %s to mds%d\n",
+		 dentry, ceph_lease_op_name(action), session->s_mds);
 
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_LEASE, len, GFP_NOFS, false);
 	if (!msg)
@@ -4349,8 +4359,8 @@ static void maybe_recover_session(struct ceph_mds_client *mdsc)
 bool check_session_state(struct ceph_mds_session *s)
 {
 	if (s->s_state == CEPH_MDS_SESSION_CLOSING) {
-		dout("resending session close request for mds%d\n",
-				s->s_mds);
+		pr_debug("resending session close request for mds%d\n",
+			 s->s_mds);
 		request_close_session(s);
 		return false;
 	}
@@ -4388,7 +4398,7 @@ static void delayed_work(struct work_struct *work)
 	int renew_interval;
 	int renew_caps;
 
-	dout("mdsc delayed_work\n");
+	pr_debug("mdsc delayed_work\n");
 
 	if (mdsc->stopping)
 		return;
@@ -4532,21 +4542,21 @@ static void wait_requests(struct ceph_mds_client *mdsc)
 	if (__get_oldest_req(mdsc)) {
 		mutex_unlock(&mdsc->mutex);
 
-		dout("wait_requests waiting for requests\n");
+		pr_debug("wait_requests waiting for requests\n");
 		wait_for_completion_timeout(&mdsc->safe_umount_waiters,
 				    ceph_timeout_jiffies(opts->mount_timeout));
 
 		/* tear down remaining requests */
 		mutex_lock(&mdsc->mutex);
 		while ((req = __get_oldest_req(mdsc))) {
-			dout("wait_requests timed out on tid %llu\n",
-			     req->r_tid);
+			pr_debug("wait_requests timed out on tid %llu\n",
+				 req->r_tid);
 			list_del_init(&req->r_wait);
 			__unregister_request(mdsc, req);
 		}
 	}
 	mutex_unlock(&mdsc->mutex);
-	dout("wait_requests done\n");
+	pr_debug("wait_requests done\n");
 }
 
 /*
@@ -4555,7 +4565,7 @@ static void wait_requests(struct ceph_mds_client *mdsc)
  */
 void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 {
-	dout("pre_umount\n");
+	pr_debug("pre_umount\n");
 	mdsc->stopping = 1;
 
 	lock_unlock_sessions(mdsc);
@@ -4580,7 +4590,7 @@ static void wait_unsafe_requests(struct ceph_mds_client *mdsc, u64 want_tid)
 	struct rb_node *n;
 
 	mutex_lock(&mdsc->mutex);
-	dout("wait_unsafe_requests want %lld\n", want_tid);
+	pr_debug("wait_unsafe_requests want %lld\n", want_tid);
 restart:
 	req = __get_oldest_req(mdsc);
 	while (req && req->r_tid <= want_tid) {
@@ -4597,8 +4607,8 @@ static void wait_unsafe_requests(struct ceph_mds_client *mdsc, u64 want_tid)
 			if (nextreq)
 				ceph_mdsc_get_request(nextreq);
 			mutex_unlock(&mdsc->mutex);
-			dout("wait_unsafe_requests  wait on %llu (want %llu)\n",
-			     req->r_tid, want_tid);
+			pr_debug("wait_unsafe_requests  wait on %llu (want %llu)\n",
+				 req->r_tid, want_tid);
 			wait_for_completion(&req->r_safe_completion);
 			mutex_lock(&mdsc->mutex);
 			ceph_mdsc_put_request(req);
@@ -4614,7 +4624,7 @@ static void wait_unsafe_requests(struct ceph_mds_client *mdsc, u64 want_tid)
 		req = nextreq;
 	}
 	mutex_unlock(&mdsc->mutex);
-	dout("wait_unsafe_requests done\n");
+	pr_debug("wait_unsafe_requests done\n");
 }
 
 void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
@@ -4624,7 +4634,7 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_SHUTDOWN)
 		return;
 
-	dout("sync\n");
+	pr_debug("sync\n");
 	mutex_lock(&mdsc->mutex);
 	want_tid = mdsc->last_tid;
 	mutex_unlock(&mdsc->mutex);
@@ -4640,8 +4650,7 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 	}
 	spin_unlock(&mdsc->cap_dirty_lock);
 
-	dout("sync want tid %lld flush_seq %lld\n",
-	     want_tid, want_flush);
+	pr_debug("sync want tid %lld flush_seq %lld\n", want_tid, want_flush);
 
 	wait_unsafe_requests(mdsc, want_tid);
 	wait_caps_flush(mdsc, want_flush);
@@ -4667,7 +4676,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	int i;
 	int skipped = 0;
 
-	dout("close_sessions\n");
+	pr_debug("close_sessions\n");
 
 	/* close sessions */
 	mutex_lock(&mdsc->mutex);
@@ -4685,7 +4694,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	}
 	mutex_unlock(&mdsc->mutex);
 
-	dout("waiting for sessions to close\n");
+	pr_debug("waiting for sessions to close\n");
 	wait_event_timeout(mdsc->session_close_wq,
 			   done_closing_sessions(mdsc, skipped),
 			   ceph_timeout_jiffies(opts->mount_timeout));
@@ -4713,7 +4722,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	cancel_work_sync(&mdsc->cap_reclaim_work);
 	cancel_delayed_work_sync(&mdsc->delayed_work); /* cancel timer */
 
-	dout("stopped\n");
+	pr_debug("stopped\n");
 }
 
 void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
@@ -4721,7 +4730,7 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 	struct ceph_mds_session *session;
 	int mds;
 
-	dout("force umount\n");
+	pr_debug("force umount\n");
 
 	mutex_lock(&mdsc->mutex);
 	for (mds = 0; mds < mdsc->max_sessions; mds++) {
@@ -4752,7 +4761,7 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 
 static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 {
-	dout("stop\n");
+	pr_debug("stop\n");
 	/*
 	 * Make sure the delayed work stopped before releasing
 	 * the resources.
@@ -4773,7 +4782,7 @@ static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 {
 	struct ceph_mds_client *mdsc = fsc->mdsc;
-	dout("mdsc_destroy %p\n", mdsc);
+	pr_debug("mdsc_destroy %p\n", mdsc);
 
 	if (!mdsc)
 		return;
@@ -4788,7 +4797,7 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 	flush_delayed_work(&mdsc->metric.delayed_work);
 	fsc->mdsc = NULL;
 	kfree(mdsc);
-	dout("mdsc_destroy %p done\n", mdsc);
+	pr_debug("mdsc_destroy %p done\n", mdsc);
 }
 
 void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
@@ -4807,7 +4816,7 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	ceph_decode_need(&p, end, sizeof(u32), bad);
 	epoch = ceph_decode_32(&p);
 
-	dout("handle_fsmap epoch %u\n", epoch);
+	pr_debug("handle_fsmap epoch %u\n", epoch);
 
 	ceph_decode_need(&p, end, 2 + sizeof(u32), bad);
 	struct_v = ceph_decode_8(&p);
@@ -4886,13 +4895,13 @@ void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 		return;
 	epoch = ceph_decode_32(&p);
 	maplen = ceph_decode_32(&p);
-	dout("handle_map epoch %u len %d\n", epoch, (int)maplen);
+	pr_debug("handle_map epoch %u len %d\n", epoch, (int)maplen);
 
 	/* do we need it? */
 	mutex_lock(&mdsc->mutex);
 	if (mdsc->mdsmap && epoch <= mdsc->mdsmap->m_epoch) {
-		dout("handle_map epoch %u <= our %u\n",
-		     epoch, mdsc->mdsmap->m_epoch);
+		pr_debug("handle_map epoch %u <= our %u\n",
+			 epoch, mdsc->mdsmap->m_epoch);
 		mutex_unlock(&mdsc->mutex);
 		return;
 	}
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index e4aba6c6d3b5..50c3f7f60409 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -231,11 +231,11 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
 			*p = info_end;
 		}
 
-		dout("mdsmap_decode %d/%d %lld mds%d.%d %s %s%s\n",
-		     i+1, n, global_id, mds, inc,
-		     ceph_pr_addr(&addr),
-		     ceph_mds_state_name(state),
-		     laggy ? "(laggy)" : "");
+		pr_debug("mdsmap_decode %d/%d %lld mds%d.%d %s %s%s\n",
+			 i + 1, n, global_id, mds, inc,
+			 ceph_pr_addr(&addr),
+			 ceph_mds_state_name(state),
+			 laggy ? "(laggy)" : "");
 
 		if (mds < 0 || mds >= m->possible_max_rank) {
 			pr_warn("mdsmap_decode got incorrect mds(%d)\n", mds);
@@ -368,10 +368,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
 		m->m_damaged = false;
 	}
 bad_ext:
-	dout("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
-	     !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
+	pr_debug("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
+		 !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
 	*p = end;
-	dout("mdsmap_decode success epoch %u\n", m->m_epoch);
+	pr_debug("mdsmap_decode success epoch %u\n", m->m_epoch);
 	return m;
 nomem:
 	err = -ENOMEM;
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index 2466b261fba2..cb257eee48f8 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -88,8 +88,8 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 	msg->hdr.version = cpu_to_le16(1);
 	msg->hdr.compat_version = cpu_to_le16(1);
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
-	dout("client%llu send metrics to mds%d\n",
-	     ceph_client_gid(mdsc->fsc->client), s->s_mds);
+	pr_debug("client%llu send metrics to mds%d\n",
+		 ceph_client_gid(mdsc->fsc->client), s->s_mds);
 	ceph_con_send(&s->s_con, msg);
 
 	return true;
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 198ddde5c1e6..55bd95f86444 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -159,8 +159,8 @@ static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
 	}
 
 	if (IS_ERR(in)) {
-		dout("Can't lookup inode %llx (err: %ld)\n",
-		     realm->ino, PTR_ERR(in));
+		pr_debug("Can't lookup inode %llx (err: %ld)\n",
+			 realm->ino, PTR_ERR(in));
 		qri->timeout = jiffies + msecs_to_jiffies(60 * 1000); /* XXX */
 	} else {
 		qri->timeout = 0;
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 923be9399b21..73ccfd4172ac 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -65,8 +65,9 @@
 void ceph_get_snap_realm(struct ceph_mds_client *mdsc,
 			 struct ceph_snap_realm *realm)
 {
-	dout("get_realm %p %d -> %d\n", realm,
-	     atomic_read(&realm->nref), atomic_read(&realm->nref)+1);
+	pr_debug("get_realm %p %d -> %d\n",
+		 realm,
+		 atomic_read(&realm->nref), atomic_read(&realm->nref) + 1);
 	/*
 	 * since we _only_ increment realm refs or empty the empty
 	 * list with snap_rwsem held, adjusting the empty list here is
@@ -128,7 +129,7 @@ static struct ceph_snap_realm *ceph_create_snap_realm(
 	__insert_snap_realm(&mdsc->snap_realms, realm);
 	mdsc->num_snap_realms++;
 
-	dout("create_snap_realm %llx %p\n", realm->ino, realm);
+	pr_debug("create_snap_realm %llx %p\n", realm->ino, realm);
 	return realm;
 }
 
@@ -150,7 +151,7 @@ static struct ceph_snap_realm *__lookup_snap_realm(struct ceph_mds_client *mdsc,
 		else if (ino > r->ino)
 			n = n->rb_right;
 		else {
-			dout("lookup_snap_realm %llx %p\n", r->ino, r);
+			pr_debug("lookup_snap_realm %llx %p\n", r->ino, r);
 			return r;
 		}
 	}
@@ -176,7 +177,7 @@ static void __put_snap_realm(struct ceph_mds_client *mdsc,
 static void __destroy_snap_realm(struct ceph_mds_client *mdsc,
 				 struct ceph_snap_realm *realm)
 {
-	dout("__destroy_snap_realm %p %llx\n", realm, realm->ino);
+	pr_debug("__destroy_snap_realm %p %llx\n", realm, realm->ino);
 
 	rb_erase(&realm->node, &mdsc->snap_realms);
 	mdsc->num_snap_realms--;
@@ -198,8 +199,9 @@ static void __destroy_snap_realm(struct ceph_mds_client *mdsc,
 static void __put_snap_realm(struct ceph_mds_client *mdsc,
 			     struct ceph_snap_realm *realm)
 {
-	dout("__put_snap_realm %llx %p %d -> %d\n", realm->ino, realm,
-	     atomic_read(&realm->nref), atomic_read(&realm->nref)-1);
+	pr_debug("__put_snap_realm %llx %p %d -> %d\n",
+		 realm->ino, realm,
+		 atomic_read(&realm->nref), atomic_read(&realm->nref) - 1);
 	if (atomic_dec_and_test(&realm->nref))
 		__destroy_snap_realm(mdsc, realm);
 }
@@ -210,8 +212,9 @@ static void __put_snap_realm(struct ceph_mds_client *mdsc,
 void ceph_put_snap_realm(struct ceph_mds_client *mdsc,
 			 struct ceph_snap_realm *realm)
 {
-	dout("put_snap_realm %llx %p %d -> %d\n", realm->ino, realm,
-	     atomic_read(&realm->nref), atomic_read(&realm->nref)-1);
+	pr_debug("put_snap_realm %llx %p %d -> %d\n",
+		 realm->ino, realm,
+		 atomic_read(&realm->nref), atomic_read(&realm->nref) - 1);
 	if (!atomic_dec_and_test(&realm->nref))
 		return;
 
@@ -278,9 +281,9 @@ static int adjust_snap_realm_parent(struct ceph_mds_client *mdsc,
 		if (IS_ERR(parent))
 			return PTR_ERR(parent);
 	}
-	dout("adjust_snap_realm_parent %llx %p: %llx %p -> %llx %p\n",
-	     realm->ino, realm, realm->parent_ino, realm->parent,
-	     parentino, parent);
+	pr_debug("adjust_snap_realm_parent %llx %p: %llx %p -> %llx %p\n",
+		 realm->ino, realm, realm->parent_ino, realm->parent,
+		 parentino, parent);
 	if (realm->parent) {
 		list_del_init(&realm->child_item);
 		ceph_put_snap_realm(mdsc, realm->parent);
@@ -335,11 +338,10 @@ static int build_snap_context(struct ceph_snap_realm *realm,
 	    realm->cached_context->seq == realm->seq &&
 	    (!parent ||
 	     realm->cached_context->seq >= parent->cached_context->seq)) {
-		dout("build_snap_context %llx %p: %p seq %lld (%u snaps)"
-		     " (unchanged)\n",
-		     realm->ino, realm, realm->cached_context,
-		     realm->cached_context->seq,
-		     (unsigned int)realm->cached_context->num_snaps);
+		pr_debug("build_snap_context %llx %p: %p seq %lld (%u snaps) (unchanged)\n",
+			 realm->ino, realm, realm->cached_context,
+			 realm->cached_context->seq,
+			 (unsigned int)realm->cached_context->num_snaps);
 		return 0;
 	}
 
@@ -376,9 +378,9 @@ static int build_snap_context(struct ceph_snap_realm *realm,
 
 	sort(snapc->snaps, num, sizeof(u64), cmpu64_rev, NULL);
 	snapc->num_snaps = num;
-	dout("build_snap_context %llx %p: %p seq %lld (%u snaps)\n",
-	     realm->ino, realm, snapc, snapc->seq,
-	     (unsigned int) snapc->num_snaps);
+	pr_debug("build_snap_context %llx %p: %p seq %lld (%u snaps)\n",
+		 realm->ino, realm, snapc, snapc->seq,
+		 (unsigned int)snapc->num_snaps);
 
 	ceph_put_snap_context(realm->cached_context);
 	realm->cached_context = snapc;
@@ -408,7 +410,7 @@ static void rebuild_snap_realms(struct ceph_snap_realm *realm,
 {
 	struct ceph_snap_realm *child;
 
-	dout("rebuild_snap_realms %llx %p\n", realm->ino, realm);
+	pr_debug("rebuild_snap_realms %llx %p\n", realm->ino, realm);
 	build_snap_context(realm, dirty_realms);
 
 	list_for_each_entry(child, &realm->children, child_item)
@@ -494,12 +496,12 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
 		   as no new writes are allowed to start when pending, so any
 		   writes in progress now were started before the previous
 		   cap_snap.  lucky us. */
-		dout("queue_cap_snap %p already pending\n", inode);
+		pr_debug("queue_cap_snap %p already pending\n", inode);
 		goto update_snapc;
 	}
 	if (ci->i_wrbuffer_ref_head == 0 &&
 	    !(dirty & (CEPH_CAP_ANY_EXCL|CEPH_CAP_FILE_WR))) {
-		dout("queue_cap_snap %p nothing dirty|writing\n", inode);
+		pr_debug("queue_cap_snap %p nothing dirty|writing\n", inode);
 		goto update_snapc;
 	}
 
@@ -519,15 +521,15 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
 	} else {
 		if (!(used & CEPH_CAP_FILE_WR) &&
 		    ci->i_wrbuffer_ref_head == 0) {
-			dout("queue_cap_snap %p "
-			     "no new_snap|dirty_page|writing\n", inode);
+			pr_debug("queue_cap_snap %p no new_snap|dirty_page|writing\n",
+				 inode);
 			goto update_snapc;
 		}
 	}
 
-	dout("queue_cap_snap %p cap_snap %p queuing under %p %s %s\n",
-	     inode, capsnap, old_snapc, ceph_cap_string(dirty),
-	     capsnap->need_flush ? "" : "no_flush");
+	pr_debug("queue_cap_snap %p cap_snap %p queuing under %p %s %s\n",
+		 inode, capsnap, old_snapc, ceph_cap_string(dirty),
+		 capsnap->need_flush ? "" : "no_flush");
 	ihold(inode);
 
 	refcount_set(&capsnap->nref, 1);
@@ -562,9 +564,8 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
 	list_add_tail(&capsnap->ci_item, &ci->i_cap_snaps);
 
 	if (used & CEPH_CAP_FILE_WR) {
-		dout("queue_cap_snap %p cap_snap %p snapc %p"
-		     " seq %llu used WR, now pending\n", inode,
-		     capsnap, old_snapc, old_snapc->seq);
+		pr_debug("queue_cap_snap %p cap_snap %p snapc %p seq %llu used WR, now pending\n",
+			 inode, capsnap, old_snapc, old_snapc->seq);
 		capsnap->writing = 1;
 	} else {
 		/* note mtime, size NOW. */
@@ -581,7 +582,7 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
                ci->i_head_snapc = NULL;
        } else {
 		ci->i_head_snapc = ceph_get_snap_context(new_snapc);
-		dout(" new snapc is %p\n", new_snapc);
+		pr_debug("new snapc is %p\n", new_snapc);
 	}
 	spin_unlock(&ci->i_ceph_lock);
 
@@ -615,19 +616,19 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 	capsnap->truncate_size = ci->i_truncate_size;
 	capsnap->truncate_seq = ci->i_truncate_seq;
 	if (capsnap->dirty_pages) {
-		dout("finish_cap_snap %p cap_snap %p snapc %p %llu %s s=%llu "
-		     "still has %d dirty pages\n", inode, capsnap,
-		     capsnap->context, capsnap->context->seq,
-		     ceph_cap_string(capsnap->dirty), capsnap->size,
-		     capsnap->dirty_pages);
+		pr_debug("finish_cap_snap %p cap_snap %p snapc %p %llu %s s=%llu still has %d dirty pages\n",
+			 inode, capsnap,
+			 capsnap->context, capsnap->context->seq,
+			 ceph_cap_string(capsnap->dirty), capsnap->size,
+			 capsnap->dirty_pages);
 		return 0;
 	}
 
 	ci->i_ceph_flags |= CEPH_I_FLUSH_SNAPS;
-	dout("finish_cap_snap %p cap_snap %p snapc %p %llu %s s=%llu\n",
-	     inode, capsnap, capsnap->context,
-	     capsnap->context->seq, ceph_cap_string(capsnap->dirty),
-	     capsnap->size);
+	pr_debug("finish_cap_snap %p cap_snap %p snapc %p %llu %s s=%llu\n",
+		 inode, capsnap, capsnap->context,
+		 capsnap->context->seq, ceph_cap_string(capsnap->dirty),
+		 capsnap->size);
 
 	spin_lock(&mdsc->snap_flush_lock);
 	if (list_empty(&ci->i_snap_flush_item))
@@ -645,7 +646,7 @@ static void queue_realm_cap_snaps(struct ceph_snap_realm *realm)
 	struct ceph_inode_info *ci;
 	struct inode *lastinode = NULL;
 
-	dout("queue_realm_cap_snaps %p %llx inodes\n", realm, realm->ino);
+	pr_debug("queue_realm_cap_snaps %p %llx inodes\n", realm, realm->ino);
 
 	spin_lock(&realm->inodes_with_caps_lock);
 	list_for_each_entry(ci, &realm->inodes_with_caps, i_snap_realm_item) {
@@ -663,7 +664,7 @@ static void queue_realm_cap_snaps(struct ceph_snap_realm *realm)
 	spin_unlock(&realm->inodes_with_caps_lock);
 	ceph_async_iput(lastinode);
 
-	dout("queue_realm_cap_snaps %p %llx done\n", realm, realm->ino);
+	pr_debug("queue_realm_cap_snaps %p %llx done\n", realm, realm->ino);
 }
 
 /*
@@ -686,7 +687,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 	int err = -ENOMEM;
 	LIST_HEAD(dirty_realms);
 
-	dout("update_snap_trace deletion=%d\n", deletion);
+	pr_debug("update_snap_trace deletion=%d\n", deletion);
 more:
 	ceph_decode_need(&p, e, sizeof(*ri), bad);
 	ri = p;
@@ -714,8 +715,8 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 	invalidate += err;
 
 	if (le64_to_cpu(ri->seq) > realm->seq) {
-		dout("update_snap_trace updating %llx %p %lld -> %lld\n",
-		     realm->ino, realm, realm->seq, le64_to_cpu(ri->seq));
+		pr_debug("update_snap_trace updating %llx %p %lld -> %lld\n",
+			 realm->ino, realm, realm->seq, le64_to_cpu(ri->seq));
 		/* update realm parameters, snap lists */
 		realm->seq = le64_to_cpu(ri->seq);
 		realm->created = le64_to_cpu(ri->created);
@@ -738,16 +739,16 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 
 		invalidate = 1;
 	} else if (!realm->cached_context) {
-		dout("update_snap_trace %llx %p seq %lld new\n",
-		     realm->ino, realm, realm->seq);
+		pr_debug("update_snap_trace %llx %p seq %lld new\n",
+			 realm->ino, realm, realm->seq);
 		invalidate = 1;
 	} else {
-		dout("update_snap_trace %llx %p seq %lld unchanged\n",
-		     realm->ino, realm, realm->seq);
+		pr_debug("update_snap_trace %llx %p seq %lld unchanged\n",
+			 realm->ino, realm, realm->seq);
 	}
 
-	dout("done with %llx %p, invalidated=%d, %p %p\n", realm->ino,
-	     realm, invalidate, p, e);
+	pr_debug("done with %llx %p, invalidated=%d, %p %p\n",
+		 realm->ino, realm, invalidate, p, e);
 
 	/* invalidate when we reach the _end_ (root) of the trace */
 	if (invalidate && p >= e)
@@ -804,7 +805,7 @@ static void flush_snaps(struct ceph_mds_client *mdsc)
 	struct inode *inode;
 	struct ceph_mds_session *session = NULL;
 
-	dout("flush_snaps\n");
+	pr_debug("flush_snaps\n");
 	spin_lock(&mdsc->snap_flush_lock);
 	while (!list_empty(&mdsc->snap_flush_list)) {
 		ci = list_first_entry(&mdsc->snap_flush_list,
@@ -824,7 +825,7 @@ static void flush_snaps(struct ceph_mds_client *mdsc)
 		mutex_unlock(&session->s_mutex);
 		ceph_put_mds_session(session);
 	}
-	dout("flush_snaps done\n");
+	pr_debug("flush_snaps done\n");
 }
 
 
@@ -869,8 +870,8 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	trace_len = le32_to_cpu(h->trace_len);
 	p += sizeof(*h);
 
-	dout("handle_snap from mds%d op %s split %llx tracelen %d\n", mds,
-	     ceph_snap_op_name(op), split, trace_len);
+	pr_debug("handle_snap from mds%d op %s split %llx tracelen %d\n",
+		 mds, ceph_snap_op_name(op), split, trace_len);
 
 	mutex_lock(&session->s_mutex);
 	session->s_seq++;
@@ -905,7 +906,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 				goto out;
 		}
 
-		dout("splitting snap_realm %llx %p\n", realm->ino, realm);
+		pr_debug("splitting snap_realm %llx %p\n", realm->ino, realm);
 		for (i = 0; i < num_split_inos; i++) {
 			struct ceph_vino vino = {
 				.ino = le64_to_cpu(split_inos[i]),
@@ -931,13 +932,13 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 			 */
 			if (ci->i_snap_realm->created >
 			    le64_to_cpu(ri->created)) {
-				dout(" leaving %p in newer realm %llx %p\n",
-				     inode, ci->i_snap_realm->ino,
-				     ci->i_snap_realm);
+				pr_debug("leaving %p in newer realm %llx %p\n",
+					 inode, ci->i_snap_realm->ino,
+					 ci->i_snap_realm);
 				goto skip_inode;
 			}
-			dout(" will move %p to split realm %llx %p\n",
-			     inode, realm->ino, realm);
+			pr_debug("will move %p to split realm %llx %p\n",
+				 inode, realm->ino, realm);
 			/*
 			 * Move the inode to the new realm
 			 */
@@ -1032,7 +1033,8 @@ struct ceph_snapid_map* ceph_get_snapid_map(struct ceph_mds_client *mdsc,
 	}
 	spin_unlock(&mdsc->snapid_map_lock);
 	if (exist) {
-		dout("found snapid map %llx -> %x\n", exist->snap, exist->dev);
+		pr_debug("found snapid map %llx -> %x\n",
+			 exist->snap, exist->dev);
 		return exist;
 	}
 
@@ -1076,11 +1078,12 @@ struct ceph_snapid_map* ceph_get_snapid_map(struct ceph_mds_client *mdsc,
 	if (exist) {
 		free_anon_bdev(sm->dev);
 		kfree(sm);
-		dout("found snapid map %llx -> %x\n", exist->snap, exist->dev);
+		pr_debug("found snapid map %llx -> %x\n",
+			 exist->snap, exist->dev);
 		return exist;
 	}
 
-	dout("create snapid map %llx -> %x\n", sm->snap, sm->dev);
+	pr_debug("create snapid map %llx -> %x\n", sm->snap, sm->dev);
 	return sm;
 }
 
@@ -1126,7 +1129,7 @@ void ceph_trim_snapid_map(struct ceph_mds_client *mdsc)
 	while (!list_empty(&to_free)) {
 		sm = list_first_entry(&to_free, struct ceph_snapid_map, lru);
 		list_del(&sm->lru);
-		dout("trim snapid map %llx -> %x\n", sm->snap, sm->dev);
+		pr_debug("trim snapid map %llx -> %x\n", sm->snap, sm->dev);
 		free_anon_bdev(sm->dev);
 		kfree(sm);
 	}
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 7ec0e6d03d10..08dc6052d2b6 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -43,7 +43,7 @@ static void ceph_put_super(struct super_block *s)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
 
-	dout("put_super\n");
+	pr_debug("put_super\n");
 	ceph_mdsc_close_sessions(fsc->mdsc);
 }
 
@@ -62,7 +62,7 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 		data_pool = CEPH_NOPOOL;
 	}
 
-	dout("statfs\n");
+	pr_debug("statfs\n");
 	err = ceph_monc_do_statfs(monc, data_pool, &st);
 	if (err < 0)
 		return err;
@@ -115,16 +115,16 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
 
 	if (!wait) {
-		dout("sync_fs (non-blocking)\n");
+		pr_debug("sync_fs (non-blocking)\n");
 		ceph_flush_dirty_caps(fsc->mdsc);
-		dout("sync_fs (non-blocking) done\n");
+		pr_debug("sync_fs (non-blocking) done\n");
 		return 0;
 	}
 
-	dout("sync_fs (blocking)\n");
+	pr_debug("sync_fs (blocking)\n");
 	ceph_osdc_sync(&fsc->client->osdc);
 	ceph_mdsc_sync(fsc->mdsc);
-	dout("sync_fs (blocking) done\n");
+	pr_debug("sync_fs (blocking) done\n");
 	return 0;
 }
 
@@ -243,7 +243,7 @@ static int ceph_parse_source(struct fs_parameter *param, struct fs_context *fc)
 	char *dev_name = param->string, *dev_name_end;
 	int ret;
 
-	dout("%s '%s'\n", __func__, dev_name);
+	pr_debug("%s '%s'\n", __func__, dev_name);
 	if (!dev_name || !*dev_name)
 		return invalfc(fc, "Empty source");
 
@@ -267,9 +267,10 @@ static int ceph_parse_source(struct fs_parameter *param, struct fs_context *fc)
 	if (dev_name_end < dev_name || *dev_name_end != ':')
 		return invalfc(fc, "No path or : separator in source");
 
-	dout("device name '%.*s'\n", (int)(dev_name_end - dev_name), dev_name);
+	pr_debug("device name '%.*s'\n",
+		 (int)(dev_name_end - dev_name), dev_name);
 	if (fsopt->server_path)
-		dout("server path '%s'\n", fsopt->server_path);
+		pr_debug("server path '%s'\n", fsopt->server_path);
 
 	ret = ceph_parse_mon_ips(param->string, dev_name_end - dev_name,
 				 pctx->copts, fc->log.log);
@@ -295,7 +296,7 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 		return ret;
 
 	token = fs_parse(fc, ceph_mount_parameters, param, &result);
-	dout("%s fs_parse '%s' token %d\n", __func__, param->key, token);
+	pr_debug("%s fs_parse '%s' token %d\n", __func__, param->key, token);
 	if (token < 0)
 		return token;
 
@@ -466,7 +467,7 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 
 static void destroy_mount_options(struct ceph_mount_options *args)
 {
-	dout("destroy_mount_options %p\n", args);
+	pr_debug("destroy_mount_options %p\n", args);
 	if (!args)
 		return;
 
@@ -710,7 +711,7 @@ static void flush_fs_workqueues(struct ceph_fs_client *fsc)
 
 static void destroy_fs_client(struct ceph_fs_client *fsc)
 {
-	dout("destroy_fs_client %p\n", fsc);
+	pr_debug("destroy_fs_client %p\n", fsc);
 
 	spin_lock(&ceph_fsc_lock);
 	list_del(&fsc->metric_wakeup);
@@ -725,7 +726,7 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
 	ceph_destroy_client(fsc->client);
 
 	kfree(fsc);
-	dout("destroy_fs_client %p done\n", fsc);
+	pr_debug("destroy_fs_client %p done\n", fsc);
 }
 
 /*
@@ -840,7 +841,7 @@ static void ceph_umount_begin(struct super_block *sb)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
 
-	dout("ceph_umount_begin - starting forced umount\n");
+	pr_debug("ceph_umount_begin - starting forced umount\n");
 	if (!fsc)
 		return;
 	fsc->mount_state = CEPH_MOUNT_SHUTDOWN;
@@ -876,7 +877,7 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
 	struct dentry *root;
 
 	/* open dir */
-	dout("open_root_inode opening '%s'\n", path);
+	pr_debug("open_root_inode opening '%s'\n", path);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR, USE_ANY_MDS);
 	if (IS_ERR(req))
 		return ERR_CAST(req);
@@ -896,13 +897,13 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
 	if (err == 0) {
 		struct inode *inode = req->r_target_inode;
 		req->r_target_inode = NULL;
-		dout("open_root_inode success\n");
+		pr_debug("open_root_inode success\n");
 		root = d_make_root(inode);
 		if (!root) {
 			root = ERR_PTR(-ENOMEM);
 			goto out;
 		}
-		dout("open_root_inode success, root dentry is %p\n", root);
+		pr_debug("open_root_inode success, root dentry is %p\n", root);
 	} else {
 		root = ERR_PTR(err);
 	}
@@ -921,7 +922,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 	unsigned long started = jiffies;  /* note the start time */
 	struct dentry *root;
 
-	dout("mount start %p\n", fsc);
+	pr_debug("mount start %p\n", fsc);
 	mutex_lock(&fsc->client->mount_mutex);
 
 	if (!fsc->sb->s_root) {
@@ -939,7 +940,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 				goto out;
 		}
 
-		dout("mount opening path '%s'\n", path);
+		pr_debug("mount opening path '%s'\n", path);
 
 		ceph_fs_debugfs_init(fsc);
 
@@ -954,7 +955,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 	}
 
 	fsc->mount_state = CEPH_MOUNT_MOUNTED;
-	dout("mount success\n");
+	pr_debug("mount success\n");
 	mutex_unlock(&fsc->client->mount_mutex);
 	return root;
 
@@ -968,7 +969,7 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	struct ceph_fs_client *fsc = s->s_fs_info;
 	int ret;
 
-	dout("set_super %p\n", s);
+	pr_debug("set_super %p\n", s);
 
 	s->s_maxbytes = MAX_LFS_FILESIZE;
 
@@ -1000,19 +1001,19 @@ static int ceph_compare_super(struct super_block *sb, struct fs_context *fc)
 	struct ceph_options *opt = new->client->options;
 	struct ceph_fs_client *other = ceph_sb_to_client(sb);
 
-	dout("ceph_compare_super %p\n", sb);
+	pr_debug("ceph_compare_super %p\n", sb);
 
 	if (compare_mount_options(fsopt, opt, other)) {
-		dout("monitor(s)/mount options don't match\n");
+		pr_debug("monitor(s)/mount options don't match\n");
 		return 0;
 	}
 	if ((opt->flags & CEPH_OPT_FSID) &&
 	    ceph_fsid_compare(&opt->fsid, &other->client->fsid)) {
-		dout("fsid doesn't match\n");
+		pr_debug("fsid doesn't match\n");
 		return 0;
 	}
 	if (fc->sb_flags != (sb->s_flags & ~SB_BORN)) {
-		dout("flags differ\n");
+		pr_debug("flags differ\n");
 		return 0;
 	}
 	return 1;
@@ -1051,7 +1052,7 @@ static int ceph_get_tree(struct fs_context *fc)
 		ceph_compare_super;
 	int err;
 
-	dout("ceph_get_tree\n");
+	pr_debug("ceph_get_tree\n");
 
 	if (!fc->source)
 		return invalfc(fc, "No source");
@@ -1083,9 +1084,9 @@ static int ceph_get_tree(struct fs_context *fc)
 	if (ceph_sb_to_client(sb) != fsc) {
 		destroy_fs_client(fsc);
 		fsc = ceph_sb_to_client(sb);
-		dout("get_sb got existing client %p\n", fsc);
+		pr_debug("get_sb got existing client %p\n", fsc);
 	} else {
-		dout("get_sb using new client %p\n", fsc);
+		pr_debug("get_sb using new client %p\n", fsc);
 		err = ceph_setup_bdi(sb, fsc);
 		if (err < 0)
 			goto out_splat;
@@ -1096,8 +1097,8 @@ static int ceph_get_tree(struct fs_context *fc)
 		err = PTR_ERR(res);
 		goto out_splat;
 	}
-	dout("root %p inode %p ino %llx.%llx\n", res,
-	     d_inode(res), ceph_vinop(d_inode(res)));
+	pr_debug("root %p inode %p ino %llx.%llx\n",
+		 res, d_inode(res), ceph_vinop(d_inode(res)));
 	fc->root = fsc->sb->s_root;
 	return 0;
 
@@ -1114,7 +1115,7 @@ static int ceph_get_tree(struct fs_context *fc)
 out:
 	destroy_fs_client(fsc);
 out_final:
-	dout("ceph_get_tree fail %d\n", err);
+	pr_debug("ceph_get_tree fail %d\n", err);
 	return err;
 }
 
@@ -1207,7 +1208,7 @@ static void ceph_kill_sb(struct super_block *s)
 	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
 	dev_t dev = s->s_dev;
 
-	dout("kill_sb %p\n", s);
+	pr_debug("kill_sb %p\n", s);
 
 	ceph_mdsc_pre_umount(fsc->mdsc);
 	flush_fs_workqueues(fsc);
@@ -1282,7 +1283,7 @@ static int __init init_ceph(void)
 
 static void __exit exit_ceph(void)
 {
-	dout("exit_ceph\n");
+	pr_debug("exit_ceph\n");
 	unregister_filesystem(&ceph_fs_type);
 	destroy_caches();
 }
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 3a733ac33d9b..503d1edeb28d 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -68,7 +68,7 @@ static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 
 	pool_ns = ceph_try_get_string(ci->i_layout.pool_ns);
 
-	dout("ceph_vxattrcb_layout %p\n", &ci->vfs_inode);
+	pr_debug("ceph_vxattrcb_layout %p\n", &ci->vfs_inode);
 	down_read(&osdc->lock);
 	pool_name = ceph_pg_pool_name_by_id(osdc->osdmap, pool);
 	if (pool_name) {
@@ -492,7 +492,7 @@ static int __set_xattr(struct ceph_inode_info *ci,
 		xattr->should_free_name = update_xattr;
 
 		ci->i_xattrs.count++;
-		dout("__set_xattr count=%d\n", ci->i_xattrs.count);
+		pr_debug("__set_xattr count=%d\n", ci->i_xattrs.count);
 	} else {
 		kfree(*newxattr);
 		*newxattr = NULL;
@@ -520,11 +520,12 @@ static int __set_xattr(struct ceph_inode_info *ci,
 	if (new) {
 		rb_link_node(&xattr->node, parent, p);
 		rb_insert_color(&xattr->node, &ci->i_xattrs.index);
-		dout("__set_xattr_val p=%p\n", p);
+		pr_debug("__set_xattr_val p=%p\n", p);
 	}
 
-	dout("__set_xattr_val added %llx.%llx xattr %p %.*s=%.*s\n",
-	     ceph_vinop(&ci->vfs_inode), xattr, name_len, name, val_len, val);
+	pr_debug("__set_xattr_val added %llx.%llx xattr %p %.*s=%.*s\n",
+		 ceph_vinop(&ci->vfs_inode), xattr,
+		 name_len, name, val_len, val);
 
 	return 0;
 }
@@ -550,13 +551,13 @@ static struct ceph_inode_xattr *__get_xattr(struct ceph_inode_info *ci,
 		else if (c > 0)
 			p = &(*p)->rb_right;
 		else {
-			dout("__get_xattr %s: found %.*s\n", name,
-			     xattr->val_len, xattr->val);
+			pr_debug("__get_xattr %s: found %.*s\n",
+				 name, xattr->val_len, xattr->val);
 			return xattr;
 		}
 	}
 
-	dout("__get_xattr %s: not found\n", name);
+	pr_debug("__get_xattr %s: not found\n", name);
 
 	return NULL;
 }
@@ -601,15 +602,16 @@ static char *__copy_xattr_names(struct ceph_inode_info *ci,
 	struct ceph_inode_xattr *xattr = NULL;
 
 	p = rb_first(&ci->i_xattrs.index);
-	dout("__copy_xattr_names count=%d\n", ci->i_xattrs.count);
+	pr_debug("__copy_xattr_names count=%d\n", ci->i_xattrs.count);
 
 	while (p) {
 		xattr = rb_entry(p, struct ceph_inode_xattr, node);
 		memcpy(dest, xattr->name, xattr->name_len);
 		dest[xattr->name_len] = '\0';
 
-		dout("dest=%s %p (%s) (%d/%d)\n", dest, xattr, xattr->name,
-		     xattr->name_len, ci->i_xattrs.names_size);
+		pr_debug("dest=%s %p (%s) (%d/%d)\n",
+			 dest, xattr, xattr->name,
+			 xattr->name_len, ci->i_xattrs.names_size);
 
 		dest += xattr->name_len + 1;
 		p = rb_next(p);
@@ -625,14 +627,14 @@ void __ceph_destroy_xattrs(struct ceph_inode_info *ci)
 
 	p = rb_first(&ci->i_xattrs.index);
 
-	dout("__ceph_destroy_xattrs p=%p\n", p);
+	pr_debug("__ceph_destroy_xattrs p=%p\n", p);
 
 	while (p) {
 		xattr = rb_entry(p, struct ceph_inode_xattr, node);
 		tmp = p;
 		p = rb_next(tmp);
-		dout("__ceph_destroy_xattrs next p=%p (%.*s)\n", p,
-		     xattr->name_len, xattr->name);
+		pr_debug("__ceph_destroy_xattrs next p=%p (%.*s)\n",
+			 p, xattr->name_len, xattr->name);
 		rb_erase(tmp, &ci->i_xattrs.index);
 
 		__free_xattr(xattr);
@@ -660,8 +662,8 @@ static int __build_xattrs(struct inode *inode)
 	int err = 0;
 	int i;
 
-	dout("__build_xattrs() len=%d\n",
-	     ci->i_xattrs.blob ? (int)ci->i_xattrs.blob->vec.iov_len : 0);
+	pr_debug("__build_xattrs() len=%d\n",
+		 ci->i_xattrs.blob ? (int)ci->i_xattrs.blob->vec.iov_len : 0);
 
 	if (ci->i_xattrs.index_version >= ci->i_xattrs.version)
 		return 0; /* already built */
@@ -743,9 +745,9 @@ static int __get_required_blob_size(struct ceph_inode_info *ci, int name_size,
 	int size = 4 + ci->i_xattrs.count*(4 + 4) +
 			     ci->i_xattrs.names_size +
 			     ci->i_xattrs.vals_size;
-	dout("__get_required_blob_size c=%d names.size=%d vals.size=%d\n",
-	     ci->i_xattrs.count, ci->i_xattrs.names_size,
-	     ci->i_xattrs.vals_size);
+	pr_debug("__get_required_blob_size c=%d names.size=%d vals.size=%d\n",
+		 ci->i_xattrs.count, ci->i_xattrs.names_size,
+		 ci->i_xattrs.vals_size);
 
 	if (name_size)
 		size += 4 + 4 + name_size + val_size;
@@ -766,7 +768,7 @@ struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci)
 	struct ceph_buffer *old_blob = NULL;
 	void *dest;
 
-	dout("__build_xattrs_blob %p\n", &ci->vfs_inode);
+	pr_debug("__build_xattrs_blob %p\n", &ci->vfs_inode);
 	if (ci->i_xattrs.dirty) {
 		int need = __get_required_blob_size(ci, 0, 0);
 
@@ -851,8 +853,8 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 	req_mask = __get_request_mask(inode);
 
 	spin_lock(&ci->i_ceph_lock);
-	dout("getxattr %p name '%s' ver=%lld index_ver=%lld\n", inode, name,
-	     ci->i_xattrs.version, ci->i_xattrs.index_version);
+	pr_debug("getxattr %p name '%s' ver=%lld index_ver=%lld\n",
+		 inode, name, ci->i_xattrs.version, ci->i_xattrs.index_version);
 
 	if (ci->i_xattrs.version == 0 ||
 	    !((req_mask & CEPH_CAP_XATTR_SHARED) ||
@@ -910,8 +912,8 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	int err;
 
 	spin_lock(&ci->i_ceph_lock);
-	dout("listxattr %p ver=%lld index_ver=%lld\n", inode,
-	     ci->i_xattrs.version, ci->i_xattrs.index_version);
+	pr_debug("listxattr %p ver=%lld index_ver=%lld\n",
+		 inode, ci->i_xattrs.version, ci->i_xattrs.index_version);
 
 	if (ci->i_xattrs.version == 0 ||
 	    !__ceph_caps_issued_mask_metric(ci, CEPH_CAP_XATTR_SHARED, 1)) {
@@ -969,7 +971,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			flags |= CEPH_XATTR_REMOVE;
 	}
 
-	dout("setxattr value=%.*s\n", (int)size, value);
+	pr_debug("setxattr value=%.*s\n", (int)size, value);
 
 	/* do request */
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
@@ -996,10 +998,10 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 	req->r_num_caps = 1;
 	req->r_inode_drop = CEPH_CAP_XATTR_SHARED;
 
-	dout("xattr.ver (before): %lld\n", ci->i_xattrs.version);
+	pr_debug("xattr.ver (before): %lld\n", ci->i_xattrs.version);
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	ceph_mdsc_put_request(req);
-	dout("xattr.ver (after): %lld\n", ci->i_xattrs.version);
+	pr_debug("xattr.ver (after): %lld\n", ci->i_xattrs.version);
 
 out:
 	if (pagelist)
@@ -1078,8 +1080,8 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 		}
 	}
 
-	dout("setxattr %p name '%s' issued %s\n", inode, name,
-	     ceph_cap_string(issued));
+	pr_debug("setxattr %p name '%s' issued %s\n",
+		 inode, name, ceph_cap_string(issued));
 	__build_xattrs(inode);
 
 	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
@@ -1090,7 +1092,8 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 
 		spin_unlock(&ci->i_ceph_lock);
 		ceph_buffer_put(old_blob); /* Shouldn't be required */
-		dout(" pre-allocating new blob size=%d\n", required_blob_size);
+		pr_debug("pre-allocating new blob size=%d\n",
+			 required_blob_size);
 		blob = ceph_buffer_new(required_blob_size, GFP_NOFS);
 		if (!blob)
 			goto do_sync_unlocked;
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 76371aaae2d1..0a69a4cb8583 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -98,7 +98,7 @@ struct ceph_bio_iter {
 		(void)(STEP);						      \
 		bio_advance_iter((it)->bio, &(it)->iter, __cur_n);	      \
 		if (!(it)->iter.bi_size && (it)->bio->bi_next) {	      \
-			dout("__ceph_bio_iter_advance_step next bio\n");      \
+			pr_debug("__ceph_bio_iter_advance_step next bio\n");  \
 			(it)->bio = (it)->bio->bi_next;			      \
 			(it)->iter = (it)->bio->bi_iter;		      \
 		}							      \
-- 
2.26.0

