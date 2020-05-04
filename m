Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D7AC47259
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC1E205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615770;
	bh=WEwk5Tn3HNb38MlMmMN3j2MJ1c2gxoYIDgrf5akhKYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ppu4RV67mYqmT0wtYuvf5JLChT8tfm7hVoO/TwvJ65tcSvixz0OxLS5bu3wwTTs8J
	 3JHbCxDC22UdyqBg4MUTk9ZceAoMuSDwN73SKwyooaJ/qa+Dge5DFt/GNKDAREdVnu
	 kvRbjA1LWEOchU4gyOGpSc5i/PfT4Zi4wJs5m+70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbgEDSJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730884AbgEDSGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:06:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E65D2206B8;
        Mon,  4 May 2020 18:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615594;
        bh=WEwk5Tn3HNb38MlMmMN3j2MJ1c2gxoYIDgrf5akhKYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HiWYxOiW0eSIIkJvW5ju48lICPryL3C+AfITtln0pEjsP38RqoCtxxtnoQjJ7piuO
         +SH12GK2bTCGAOuYi/ErELABpXN8vqPQ5aF7HmINHqvKURHOmpfMVFt6Gh/MLHMw9w
         IDoubUTE98RcyF/ynN0CHGM6ZCRqRhIoBF8ntagY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.6 37/73] dm writecache: fix data corruption when reloading the target
Date:   Mon,  4 May 2020 19:57:40 +0200
Message-Id: <20200504165507.760151938@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 31b22120194b5c0d460f59e0c98504de1d3f1f14 upstream.

The dm-writecache reads metadata in the target constructor. However, when
we reload the target, there could be another active instance running on
the same device. This is the sequence of operations when doing a reload:

1. construct new target
2. suspend old target
3. resume new target
4. destroy old target

Metadata that were written by the old target between steps 1 and 2 would
not be visible by the new target.

Fix the data corruption by loading the metadata in the resume handler.

Also, validate block_size is at least as large as both the devices'
logical block size and only read 1 block from the metadata during
target constructor -- no need to read entirety of metadata now that it
is done during resume.

Fixes: 48debafe4f2f ("dm: add writecache target")
Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-writecache.c |   52 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 15 deletions(-)

--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -882,6 +882,24 @@ static int writecache_alloc_entries(stru
 	return 0;
 }
 
+static int writecache_read_metadata(struct dm_writecache *wc, sector_t n_sectors)
+{
+	struct dm_io_region region;
+	struct dm_io_request req;
+
+	region.bdev = wc->ssd_dev->bdev;
+	region.sector = wc->start_sector;
+	region.count = n_sectors;
+	req.bi_op = REQ_OP_READ;
+	req.bi_op_flags = REQ_SYNC;
+	req.mem.type = DM_IO_VMA;
+	req.mem.ptr.vma = (char *)wc->memory_map;
+	req.client = wc->dm_io;
+	req.notify.fn = NULL;
+
+	return dm_io(&req, 1, &region, NULL);
+}
+
 static void writecache_resume(struct dm_target *ti)
 {
 	struct dm_writecache *wc = ti->private;
@@ -892,8 +910,18 @@ static void writecache_resume(struct dm_
 
 	wc_lock(wc);
 
-	if (WC_MODE_PMEM(wc))
+	if (WC_MODE_PMEM(wc)) {
 		persistent_memory_invalidate_cache(wc->memory_map, wc->memory_map_size);
+	} else {
+		r = writecache_read_metadata(wc, wc->metadata_sectors);
+		if (r) {
+			size_t sb_entries_offset;
+			writecache_error(wc, r, "unable to read metadata: %d", r);
+			sb_entries_offset = offsetof(struct wc_memory_superblock, entries);
+			memset((char *)wc->memory_map + sb_entries_offset, -1,
+			       (wc->metadata_sectors << SECTOR_SHIFT) - sb_entries_offset);
+		}
+	}
 
 	wc->tree = RB_ROOT;
 	INIT_LIST_HEAD(&wc->lru);
@@ -2005,6 +2033,12 @@ static int writecache_ctr(struct dm_targ
 		ti->error = "Invalid block size";
 		goto bad;
 	}
+	if (wc->block_size < bdev_logical_block_size(wc->dev->bdev) ||
+	    wc->block_size < bdev_logical_block_size(wc->ssd_dev->bdev)) {
+		r = -EINVAL;
+		ti->error = "Block size is smaller than device logical block size";
+		goto bad;
+	}
 	wc->block_size_bits = __ffs(wc->block_size);
 
 	wc->max_writeback_jobs = MAX_WRITEBACK_JOBS;
@@ -2093,8 +2127,6 @@ invalid_optional:
 			goto bad;
 		}
 	} else {
-		struct dm_io_region region;
-		struct dm_io_request req;
 		size_t n_blocks, n_metadata_blocks;
 		uint64_t n_bitmap_bits;
 
@@ -2151,19 +2183,9 @@ invalid_optional:
 			goto bad;
 		}
 
-		region.bdev = wc->ssd_dev->bdev;
-		region.sector = wc->start_sector;
-		region.count = wc->metadata_sectors;
-		req.bi_op = REQ_OP_READ;
-		req.bi_op_flags = REQ_SYNC;
-		req.mem.type = DM_IO_VMA;
-		req.mem.ptr.vma = (char *)wc->memory_map;
-		req.client = wc->dm_io;
-		req.notify.fn = NULL;
-
-		r = dm_io(&req, 1, &region, NULL);
+		r = writecache_read_metadata(wc, wc->block_size >> SECTOR_SHIFT);
 		if (r) {
-			ti->error = "Unable to read metadata";
+			ti->error = "Unable to read first block of metadata";
 			goto bad;
 		}
 	}


