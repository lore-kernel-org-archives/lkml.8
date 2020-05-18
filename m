Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F98C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606B320643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826087;
	bh=ZxyMZGot4qCsJCnM/6wDEDK6o+19Yya0ofBttyLsprY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vz90icJoRuohc8hw6Qs2w6p9P7FyNRhJUK7Db2XoSbHOxZYQkMpvUtPiAm7++oBQx
	 keVaMk3f6FAoUISSKV7b2Ac59wopfjXZPeuY6uwgT8OkIazPSODUrhmefJdU3pQ0xz
	 MXR34CswzxyOVA/SqTV6PzQr0czKbNBu86qLzu9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbgERSV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731059AbgERRw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:52:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93F9020674;
        Mon, 18 May 2020 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824376;
        bh=ZxyMZGot4qCsJCnM/6wDEDK6o+19Yya0ofBttyLsprY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaqsu5bymFJkbSL+qry0BkLhIDEti3zaeOL8gGyfdMuUHmPIx5IgHtG8GpAynApFg
         ZgDKaaNCXOjL9J1ofg3hIgKM1bCoOSKO8ZAAaBWQb7WO08/HIg8thEifhZiRsfvzJu
         9bjomXVi9CIvTu+ybrtwpFbYxml7ODDRYxcylwMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 30/80] gfs2: Another gfs2_walk_metadata fix
Date:   Mon, 18 May 2020 19:36:48 +0200
Message-Id: <20200518173456.501252925@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.097837707@linuxfoundation.org>
References: <20200518173450.097837707@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 566a2ab3c9005f62e784bd39022d58d34ef4365c ]

Make sure we don't walk past the end of the metadata in gfs2_walk_metadata: the
inode holds fewer pointers than indirect blocks.

Slightly clean up gfs2_iomap_get.

Fixes: a27a0c9b6a20 ("gfs2: gfs2_walk_metadata fix")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/bmap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 096b479721395..43f53020553b5 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -530,10 +530,12 @@ static int gfs2_walk_metadata(struct inode *inode, struct metapath *mp,
 
 		/* Advance in metadata tree. */
 		(mp->mp_list[hgt])++;
-		if (mp->mp_list[hgt] >= sdp->sd_inptrs) {
-			if (!hgt)
+		if (hgt) {
+			if (mp->mp_list[hgt] >= sdp->sd_inptrs)
+				goto lower_metapath;
+		} else {
+			if (mp->mp_list[hgt] >= sdp->sd_diptrs)
 				break;
-			goto lower_metapath;
 		}
 
 fill_up_metapath:
@@ -879,10 +881,9 @@ static int gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 					ret = -ENOENT;
 					goto unlock;
 				} else {
-					/* report a hole */
 					iomap->offset = pos;
 					iomap->length = length;
-					goto do_alloc;
+					goto hole_found;
 				}
 			}
 			iomap->length = size;
@@ -936,8 +937,6 @@ static int gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 	return ret;
 
 do_alloc:
-	iomap->addr = IOMAP_NULL_ADDR;
-	iomap->type = IOMAP_HOLE;
 	if (flags & IOMAP_REPORT) {
 		if (pos >= size)
 			ret = -ENOENT;
@@ -959,6 +958,9 @@ static int gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 		if (pos < size && height == ip->i_height)
 			ret = gfs2_hole_size(inode, lblock, len, mp, iomap);
 	}
+hole_found:
+	iomap->addr = IOMAP_NULL_ADDR;
+	iomap->type = IOMAP_HOLE;
 	goto out;
 }
 
-- 
2.20.1



