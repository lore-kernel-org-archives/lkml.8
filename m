Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA2020715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825027;
	bh=y7ri0T3VsAoCqHNlvv+DHPx9EnBdK9XAZxmV8cFAfNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MxgtsOp/MuTA2sw3uX5lTvBcHRfa8g+15XSC1OahKzNP/7ztyLJigVcl2haP3wZWC
	 uKkysFLfAzAJh0tcie9KL2OSo8teY1yWRh0j1+pVkh99RwZ150UBGdi0clJpz5vZCi
	 YUJ22Yz1CV5WqGpSCfBUll7xmLVuSy3jjgsrpUOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgERSDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732655AbgERSDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:03:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0111E2083E;
        Mon, 18 May 2020 18:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825010;
        bh=y7ri0T3VsAoCqHNlvv+DHPx9EnBdK9XAZxmV8cFAfNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9qp6sg6S7PnX+EocUffDNJnsEs59xdzMc0A0cFG54pShFHwgVXzScnU2xNMxIhwV
         mY3t9T7fvyORYYi2xpvcS7HVsNwnYZlUI8YF4Kd80A5TiSQpfIqBOdwDhbSQnaT/1F
         T+c8KmhXNzLfltxPVIlsy6omWWe4rFPkfKyxwdHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 094/194] gfs2: More gfs2_find_jhead fixes
Date:   Mon, 18 May 2020 19:36:24 +0200
Message-Id: <20200518173539.965917703@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit aa83da7f47b26c9587bade6c4bc4736ffa308f0a ]

It turns out that when extending an existing bio, gfs2_find_jhead fails to
check if the block number is consecutive, which leads to incorrect reads for
fragmented journals.

In addition, limit the maximum bio size to an arbitrary value of 2 megabytes:
since commit 07173c3ec276 ("block: enable multipage bvecs"), if we just keep
adding pages until bio_add_page fails, bios will grow much larger than useful,
which pins more memory than necessary with barely any additional performance
gains.

Fixes: f4686c26ecc3 ("gfs2: read journal in large chunks")
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/lops.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index c090d5ad3f221..3a020bdc358cd 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -259,7 +259,7 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
 	struct super_block *sb = sdp->sd_vfs;
 	struct bio *bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
 
-	bio->bi_iter.bi_sector = blkno << (sb->s_blocksize_bits - 9);
+	bio->bi_iter.bi_sector = blkno << sdp->sd_fsb2bb_shift;
 	bio_set_dev(bio, sb->s_bdev);
 	bio->bi_end_io = end_io;
 	bio->bi_private = sdp;
@@ -505,7 +505,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 	unsigned int bsize = sdp->sd_sb.sb_bsize, off;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
 	unsigned int shift = PAGE_SHIFT - bsize_shift;
-	unsigned int readahead_blocks = BIO_MAX_PAGES << shift;
+	unsigned int max_bio_size = 2 * 1024 * 1024;
 	struct gfs2_journal_extent *je;
 	int sz, ret = 0;
 	struct bio *bio = NULL;
@@ -533,12 +533,17 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 				off = 0;
 			}
 
-			if (!bio || (bio_chained && !off)) {
+			if (!bio || (bio_chained && !off) ||
+			    bio->bi_iter.bi_size >= max_bio_size) {
 				/* start new bio */
 			} else {
-				sz = bio_add_page(bio, page, bsize, off);
-				if (sz == bsize)
-					goto block_added;
+				sector_t sector = dblock << sdp->sd_fsb2bb_shift;
+
+				if (bio_end_sector(bio) == sector) {
+					sz = bio_add_page(bio, page, bsize, off);
+					if (sz == bsize)
+						goto block_added;
+				}
 				if (off) {
 					unsigned int blocks =
 						(PAGE_SIZE - off) >> bsize_shift;
@@ -564,7 +569,7 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head,
 			off += bsize;
 			if (off == PAGE_SIZE)
 				page = NULL;
-			if (blocks_submitted < blocks_read + readahead_blocks) {
+			if (blocks_submitted < 2 * max_bio_size >> bsize_shift) {
 				/* Keep at least one bio in flight */
 				continue;
 			}
-- 
2.20.1



