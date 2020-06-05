Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F055EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCEFF2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591360169;
	bh=apDgnAQBd/K2/3jrja5jP8BCQtPiv1jeDJYxqBqjj+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Trd71ykTUsY5+MRSFcjDVvib+lKZ2JhkHGsqJn77AiI5NBGlctjNqC7UFOVF8mb2T
	 bVs9UUiuzQ9w8/CVs9dgpMB5JLLubKQcf32t0lScsiI6tbgpMYvBkCjUeNc2khE7gd
	 P1dWXtLDgN5gx9tRu/sl/aMFwULUuHU9aZqe9aa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgFEM30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgFEMZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:25:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B273B20835;
        Fri,  5 Jun 2020 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359952;
        bh=apDgnAQBd/K2/3jrja5jP8BCQtPiv1jeDJYxqBqjj+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jisyzQSvJtRQz6WCoTv9TPKO1gBRFDEN04BjIHwqI4fmXFMN8ruWajVNzTKEp6aS2
         9aq09h/Sg2Dmtj24Xw4CnDnVZgQEBfRDUlkA8JWMBS9Eln7qBZCHluOrkNSVWjBAp9
         /nnA7X07FcAKMsg4QZ63Kq8pGiT02gP6Xz8DcCis=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.4 10/14] gfs2: Even more gfs2_find_jhead fixes
Date:   Fri,  5 Jun 2020 08:25:36 -0400
Message-Id: <20200605122540.2882539-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605122540.2882539-1-sashal@kernel.org>
References: <20200605122540.2882539-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 20be493b787cd581c9fffad7fcd6bfbe6af1050c ]

Fix several issues in the previous gfs2_find_jhead fix:
* When updating @blocks_submitted, @block refers to the first block block not
  submitted yet, not the last block submitted, so fix an off-by-one error.
* We want to ensure that @blocks_submitted is far enough ahead of @blocks_read
  to guarantee that there is in-flight I/O.  Otherwise, we'll eventually end up
  waiting for pages that haven't been submitted, yet.
* It's much easier to compare the number of blocks added with the number of
  blocks submitted to limit the maximum bio size.
* Even with bio chaining, we can keep adding blocks until we reach the maximum
  bio size, as long as we stop at a page boundary.  This simplifies the logic.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/lops.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 8303b44a5068..d2ed4dc4434c 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -504,12 +504,12 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 	unsigned int bsize = sdp->sd_sb.sb_bsize, off;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
 	unsigned int shift = PAGE_SHIFT - bsize_shift;
-	unsigned int max_bio_size = 2 * 1024 * 1024;
+	unsigned int max_blocks = 2 * 1024 * 1024 >> bsize_shift;
 	struct gfs2_journal_extent *je;
 	int sz, ret = 0;
 	struct bio *bio = NULL;
 	struct page *page = NULL;
-	bool bio_chained = false, done = false;
+	bool done = false;
 	errseq_t since;
 
 	memset(head, 0, sizeof(*head));
@@ -532,10 +532,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 				off = 0;
 			}
 
-			if (!bio || (bio_chained && !off) ||
-			    bio->bi_iter.bi_size >= max_bio_size) {
-				/* start new bio */
-			} else {
+			if (bio && (off || block < blocks_submitted + max_blocks)) {
 				sector_t sector = dblock << sdp->sd_fsb2bb_shift;
 
 				if (bio_end_sector(bio) == sector) {
@@ -548,19 +545,17 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 						(PAGE_SIZE - off) >> bsize_shift;
 
 					bio = gfs2_chain_bio(bio, blocks);
-					bio_chained = true;
 					goto add_block_to_new_bio;
 				}
 			}
 
 			if (bio) {
-				blocks_submitted = block + 1;
+				blocks_submitted = block;
 				submit_bio(bio);
 			}
 
 			bio = gfs2_log_alloc_bio(sdp, dblock, gfs2_end_log_read);
 			bio->bi_opf = REQ_OP_READ;
-			bio_chained = false;
 add_block_to_new_bio:
 			sz = bio_add_page(bio, page, bsize, off);
 			BUG_ON(sz != bsize);
@@ -568,7 +563,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 			off += bsize;
 			if (off == PAGE_SIZE)
 				page = NULL;
-			if (blocks_submitted < 2 * max_bio_size >> bsize_shift) {
+			if (blocks_submitted <= blocks_read + max_blocks) {
 				/* Keep at least one bio in flight */
 				continue;
 			}
-- 
2.25.1

