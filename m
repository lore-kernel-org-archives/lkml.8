Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF00C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C1321D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098505;
	bh=ijMN7zGtDRhZhmFCYHBwg+B1CSPGxTXzhxwwSlbS9eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dAdBv2BLM3dnvSSzwvszLbxbOQU23Z0q0VIuzJrvsGnmVmWWdwzBEa8XcGb2D0e8+
	 CuA9Q+6FNuKm0Wy3/MCXy/S4qKTcN+oskl/v34Te6jVaFh+cHvPw2rz8TBtrSZ8AB4
	 qZiQNZDDXsnCNMFz4gcoMr9kUxGVqsQliAOiPHiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgD1S2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbgD1S2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:28:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D287E20730;
        Tue, 28 Apr 2020 18:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098490;
        bh=ijMN7zGtDRhZhmFCYHBwg+B1CSPGxTXzhxwwSlbS9eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/yBE9edouRDQfaYQjHI0aJKbbhZM89eMDdiiwixLJ7fNJrBoUyJhgRAmWoLnoL84
         FykbHoTQLxCp8ETnZMc+PNvAZE++cpZ1Qmax9nUZINaZ03uDCM9+/kAZCHslbLNLl8
         ZvadYVHIYBqka87FmaEav8bc7g8exnFJvMr+1AlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Monakhov <dmonakhov@gmail.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 001/131] ext4: fix extent_status fragmentation for plain files
Date:   Tue, 28 Apr 2020 20:23:33 +0200
Message-Id: <20200428182225.686561744@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Monakhov <dmonakhov@gmail.com>

[ Upstream commit 4068664e3cd2312610ceac05b74c4cf1853b8325 ]

Extents are cached in read_extent_tree_block(); as a result, extents
are not cached for inodes with depth == 0 when we try to find the
extent using ext4_find_extent().  The result of the lookup is cached
in ext4_map_blocks() but is only a subset of the extent on disk.  As a
result, the contents of extents status cache can get very badly
fragmented for certain workloads, such as a random 4k read workload.

File size of /mnt/test is 33554432 (8192 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..    8191:      40960..     49151:   8192:             last,eof

$ perf record -e 'ext4:ext4_es_*' /root/bin/fio --name=t --direct=0 --rw=randread --bs=4k --filesize=32M --size=32M --filename=/mnt/test
$ perf script | grep ext4_es_insert_extent | head -n 10
             fio   131 [000]    13.975421:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [494/1) mapped 41454 status W
             fio   131 [000]    13.975939:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [6064/1) mapped 47024 status W
             fio   131 [000]    13.976467:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [6907/1) mapped 47867 status W
             fio   131 [000]    13.976937:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [3850/1) mapped 44810 status W
             fio   131 [000]    13.977440:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [3292/1) mapped 44252 status W
             fio   131 [000]    13.977931:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [6882/1) mapped 47842 status W
             fio   131 [000]    13.978376:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [3117/1) mapped 44077 status W
             fio   131 [000]    13.978957:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [2896/1) mapped 43856 status W
             fio   131 [000]    13.979474:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [7479/1) mapped 48439 status W

Fix this by caching the extents for inodes with depth == 0 in
ext4_find_extent().

[ Renamed ext4_es_cache_extents() to ext4_cache_extents() since this
  newly added function is not in extents_cache.c, and to avoid
  potential visual confusion with ext4_es_cache_extent().  -TYT ]

Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
Link: https://lore.kernel.org/r/20191106122502.19986-1-dmonakhov@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a289f4bcee453..6e8049031c1a2 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -498,6 +498,30 @@ int ext4_ext_check_inode(struct inode *inode)
 	return ext4_ext_check(inode, ext_inode_hdr(inode), ext_depth(inode), 0);
 }
 
+static void ext4_cache_extents(struct inode *inode,
+			       struct ext4_extent_header *eh)
+{
+	struct ext4_extent *ex = EXT_FIRST_EXTENT(eh);
+	ext4_lblk_t prev = 0;
+	int i;
+
+	for (i = le16_to_cpu(eh->eh_entries); i > 0; i--, ex++) {
+		unsigned int status = EXTENT_STATUS_WRITTEN;
+		ext4_lblk_t lblk = le32_to_cpu(ex->ee_block);
+		int len = ext4_ext_get_actual_len(ex);
+
+		if (prev && (prev != lblk))
+			ext4_es_cache_extent(inode, prev, lblk - prev, ~0,
+					     EXTENT_STATUS_HOLE);
+
+		if (ext4_ext_is_unwritten(ex))
+			status = EXTENT_STATUS_UNWRITTEN;
+		ext4_es_cache_extent(inode, lblk, len,
+				     ext4_ext_pblock(ex), status);
+		prev = lblk + len;
+	}
+}
+
 static struct buffer_head *
 __read_extent_tree_block(const char *function, unsigned int line,
 			 struct inode *inode, ext4_fsblk_t pblk, int depth,
@@ -532,26 +556,7 @@ __read_extent_tree_block(const char *function, unsigned int line,
 	 */
 	if (!(flags & EXT4_EX_NOCACHE) && depth == 0) {
 		struct ext4_extent_header *eh = ext_block_hdr(bh);
-		struct ext4_extent *ex = EXT_FIRST_EXTENT(eh);
-		ext4_lblk_t prev = 0;
-		int i;
-
-		for (i = le16_to_cpu(eh->eh_entries); i > 0; i--, ex++) {
-			unsigned int status = EXTENT_STATUS_WRITTEN;
-			ext4_lblk_t lblk = le32_to_cpu(ex->ee_block);
-			int len = ext4_ext_get_actual_len(ex);
-
-			if (prev && (prev != lblk))
-				ext4_es_cache_extent(inode, prev,
-						     lblk - prev, ~0,
-						     EXTENT_STATUS_HOLE);
-
-			if (ext4_ext_is_unwritten(ex))
-				status = EXTENT_STATUS_UNWRITTEN;
-			ext4_es_cache_extent(inode, lblk, len,
-					     ext4_ext_pblock(ex), status);
-			prev = lblk + len;
-		}
+		ext4_cache_extents(inode, eh);
 	}
 	return bh;
 errout:
@@ -899,6 +904,8 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	path[0].p_bh = NULL;
 
 	i = depth;
+	if (!(flags & EXT4_EX_NOCACHE) && depth == 0)
+		ext4_cache_extents(inode, eh);
 	/* walk through the tree */
 	while (i) {
 		ext_debug("depth %d: num %d, max %d\n",
-- 
2.20.1



