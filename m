Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62576C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36AC322D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915757;
	bh=kWnBaufKUqvCtbG/HZ7TugvbLVyRRBhbOYdabkB1sKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B8+/KC1eMJgcwTu556aXJBnWvL3g0WRBBixkzszgkRW5rSpARZ303Q/8Z7GwC3jyP
	 /fGZ0I18C4XuzGNEfJWBRzOpGeeyb4V/MNsY1iqms5uDWX5KNAgoJKlcLMLt2Z+W8Y
	 flpnpD3H+HcbefotUu8iLfZc1kw8oYRiZ7y0IhIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHTJ3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgHTJ2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:28:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE6421744;
        Thu, 20 Aug 2020 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915706;
        bh=kWnBaufKUqvCtbG/HZ7TugvbLVyRRBhbOYdabkB1sKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6TjaJO7PHpmagGMuHiTwW+I8bT9IWd6LeAuPmuNPpALs3yxKH2dolbdB8ujjPqRl
         uXfiFvFsb/Q/UhUMXwSiNexgQAkzrSrlj0jk77ExVJ/yLrbLd5CGDBlLMrl5sf1Csh
         1eXIXMp0NiLddCuGb/xcW5sCiU3yqKlwzKXQlB04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 5.8 107/232] gfs2: Never call gfs2_block_zero_range with an open transaction
Date:   Thu, 20 Aug 2020 11:19:18 +0200
Message-Id: <20200820091618.004892206@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

commit 70499cdfeb3625c87eebe4f7a7ea06fa7447e5df upstream.

Before this patch, some functions started transactions then they called
gfs2_block_zero_range. However, gfs2_block_zero_range, like writes, can
start transactions, which results in a recursive transaction error.
For example:

do_shrink
   trunc_start
      gfs2_trans_begin <------------------------------------------------
         gfs2_block_zero_range
            iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops);
               iomap_apply ... iomap_zero_range_actor
                  iomap_begin
                     gfs2_iomap_begin
                        gfs2_iomap_begin_write
                  actor (iomap_zero_range_actor)
		     iomap_zero
			iomap_write_begin
			   gfs2_iomap_page_prepare
			      gfs2_trans_begin <------------------------

This patch reorders the callers of gfs2_block_zero_range so that they
only start their transactions after the call. It also adds a BUG_ON to
ensure this doesn't happen again.

Fixes: 2257e468a63b ("gfs2: implement gfs2_block_zero_range using iomap_zero_range")
Cc: stable@vger.kernel.org # v5.5+
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/bmap.c |   69 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1351,9 +1351,15 @@ int gfs2_extent_map(struct inode *inode,
 	return ret;
 }
 
+/*
+ * NOTE: Never call gfs2_block_zero_range with an open transaction because it
+ * uses iomap write to perform its actions, which begin their own transactions
+ * (iomap_begin, page_prepare, etc.)
+ */
 static int gfs2_block_zero_range(struct inode *inode, loff_t from,
 				 unsigned int length)
 {
+	BUG_ON(current->journal_info);
 	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops);
 }
 
@@ -1414,6 +1420,16 @@ static int trunc_start(struct inode *ino
 	u64 oldsize = inode->i_size;
 	int error;
 
+	if (!gfs2_is_stuffed(ip)) {
+		unsigned int blocksize = i_blocksize(inode);
+		unsigned int offs = newsize & (blocksize - 1);
+		if (offs) {
+			error = gfs2_block_zero_range(inode, newsize,
+						      blocksize - offs);
+			if (error)
+				return error;
+		}
+	}
 	if (journaled)
 		error = gfs2_trans_begin(sdp, RES_DINODE + RES_JDATA, GFS2_JTRUNC_REVOKES);
 	else
@@ -1427,19 +1443,10 @@ static int trunc_start(struct inode *ino
 
 	gfs2_trans_add_meta(ip->i_gl, dibh);
 
-	if (gfs2_is_stuffed(ip)) {
+	if (gfs2_is_stuffed(ip))
 		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode) + newsize);
-	} else {
-		unsigned int blocksize = i_blocksize(inode);
-		unsigned int offs = newsize & (blocksize - 1);
-		if (offs) {
-			error = gfs2_block_zero_range(inode, newsize,
-						      blocksize - offs);
-			if (error)
-				goto out;
-		}
+	else
 		ip->i_diskflags |= GFS2_DIF_TRUNC_IN_PROG;
-	}
 
 	i_size_write(inode, newsize);
 	ip->i_inode.i_mtime = ip->i_inode.i_ctime = current_time(&ip->i_inode);
@@ -2448,25 +2455,7 @@ int __gfs2_punch_hole(struct file *file,
 	loff_t start, end;
 	int error;
 
-	start = round_down(offset, blocksize);
-	end = round_up(offset + length, blocksize) - 1;
-	error = filemap_write_and_wait_range(inode->i_mapping, start, end);
-	if (error)
-		return error;
-
-	if (gfs2_is_jdata(ip))
-		error = gfs2_trans_begin(sdp, RES_DINODE + 2 * RES_JDATA,
-					 GFS2_JTRUNC_REVOKES);
-	else
-		error = gfs2_trans_begin(sdp, RES_DINODE, 0);
-	if (error)
-		return error;
-
-	if (gfs2_is_stuffed(ip)) {
-		error = stuffed_zero_range(inode, offset, length);
-		if (error)
-			goto out;
-	} else {
+	if (!gfs2_is_stuffed(ip)) {
 		unsigned int start_off, end_len;
 
 		start_off = offset & (blocksize - 1);
@@ -2489,6 +2478,26 @@ int __gfs2_punch_hole(struct file *file,
 		}
 	}
 
+	start = round_down(offset, blocksize);
+	end = round_up(offset + length, blocksize) - 1;
+	error = filemap_write_and_wait_range(inode->i_mapping, start, end);
+	if (error)
+		return error;
+
+	if (gfs2_is_jdata(ip))
+		error = gfs2_trans_begin(sdp, RES_DINODE + 2 * RES_JDATA,
+					 GFS2_JTRUNC_REVOKES);
+	else
+		error = gfs2_trans_begin(sdp, RES_DINODE, 0);
+	if (error)
+		return error;
+
+	if (gfs2_is_stuffed(ip)) {
+		error = stuffed_zero_range(inode, offset, length);
+		if (error)
+			goto out;
+	}
+
 	if (gfs2_is_jdata(ip)) {
 		BUG_ON(!current->journal_info);
 		gfs2_journaled_truncate_range(inode, offset, length);


