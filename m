Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2050C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9207520872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgH1Qjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:39:32 -0400
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:43120 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726733AbgH1QjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:39:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0EC9B18026A1B;
        Fri, 28 Aug 2020 16:39:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mark23_2f0837e27077
X-Filterd-Recvd-Size: 21453
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 16:39:15 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ntfs3: Use more common brace style
Date:   Fri, 28 Aug 2020 09:39:04 -0700
Message-Id: <12b6a0e66778715d74fa30f0522a520864f326ba.1598632661.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598632661.git.joe@perches.com>
References: <cover.1598632661.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add open and close braces when if/else arms have multiple statements.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/ntfs3/attrib.c   |  7 ++++---
 fs/ntfs3/attrlist.c |  4 ++--
 fs/ntfs3/bitmap.c   | 43 ++++++++++++++++++++++---------------------
 fs/ntfs3/file.c     | 15 ++++++++-------
 fs/ntfs3/frecord.c  | 32 +++++++++++++++++---------------
 fs/ntfs3/fslog.c    | 18 ++++++++++--------
 fs/ntfs3/fsntfs.c   | 13 +++++++------
 fs/ntfs3/index.c    | 16 ++++++++--------
 fs/ntfs3/inode.c    |  4 ++--
 fs/ntfs3/lznt.c     |  3 ++-
 fs/ntfs3/namei.c    |  3 ++-
 fs/ntfs3/record.c   | 13 +++++++------
 fs/ntfs3/run.c      |  8 ++++----
 fs/ntfs3/super.c    |  6 +++---
 fs/ntfs3/xattr.c    | 24 ++++++++++++------------
 15 files changed, 110 insertions(+), 99 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 3a61dbbe2b5f..566847af3c55 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1071,9 +1071,9 @@ int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
 				return -ENOENT;
 		}
 
-		if (lcn == SPARSE_LCN)
+		if (lcn == SPARSE_LCN) {
 			slen += len;
-		else {
+		} else {
 			if (slen) {
 				/*
 				 * data_clusters + sparse_clusters =
@@ -1091,8 +1091,9 @@ int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
 				 * So it is not compressed
 				 */
 				*clst_data = clst_frame;
-			} else
+			} else {
 				*is_compr = *clst_data < clst_frame;
+			}
 			break;
 		}
 	}
diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 3739572a4eca..95a80fe9756d 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -444,9 +444,9 @@ int al_update(struct ntfs_inode *ni)
 	if (err)
 		goto out;
 
-	if (!attr->non_res)
+	if (!attr->non_res) {
 		memcpy(resident_data(attr), al->le, al->size);
-	else {
+	} else {
 		err = ntfs_sb_write_run(sbi, &al->run, 0, al->le, al->size);
 		if (err)
 			goto out;
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index fe41e010b2eb..6b8b090b3b53 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -133,13 +133,14 @@ static struct rb_node *rb_lookup(struct rb_root *root, size_t v)
 		struct rb_node_key *k;
 
 		k = rb_entry(*p, struct rb_node_key, node);
-		if (v < k->key)
+		if (v < k->key) {
 			p = &(*p)->rb_left;
-		else if (v > k->key) {
+		} else if (v > k->key) {
 			r = &k->node;
 			p = &(*p)->rb_right;
-		} else
+		} else {
 			return &k->node;
+		}
 	}
 
 	return r;
@@ -161,15 +162,15 @@ static inline bool rb_insert_count(struct rb_root *root, struct e_node *e)
 		struct e_node *k =
 			rb_entry(parent = *p, struct e_node, count.node);
 
-		if (e_ckey > k->count.key)
+		if (e_ckey > k->count.key) {
 			p = &(*p)->rb_left;
-		else if (e_ckey < k->count.key)
+		} else if (e_ckey < k->count.key) {
 			p = &(*p)->rb_right;
-		else if (e_skey < k->start.key)
+		} else if (e_skey < k->start.key) {
 			p = &(*p)->rb_left;
-		else if (e_skey > k->start.key)
+		} else if (e_skey > k->start.key) {
 			p = &(*p)->rb_right;
-		else {
+		} else {
 			WARN_ON(1);
 			return false;
 		}
@@ -197,11 +198,11 @@ static inline bool rb_insert_start(struct rb_root *root, struct e_node *e)
 		parent = *p;
 
 		k = rb_entry(parent, struct e_node, start.node);
-		if (e_skey < k->start.key)
+		if (e_skey < k->start.key) {
 			p = &(*p)->rb_left;
-		else if (e_skey > k->start.key)
+		} else if (e_skey > k->start.key) {
 			p = &(*p)->rb_right;
-		else {
+		} else {
 			WARN_ON(1);
 			return false;
 		}
@@ -241,9 +242,9 @@ static void wnd_add_free_ext(struct wnd_bitmap *wnd, size_t bit, size_t len,
 	/* Try to find extent before 'bit' */
 	n = rb_lookup(&wnd->start_tree, bit);
 
-	if (!n)
+	if (!n) {
 		n = rb_first(&wnd->start_tree);
-	else {
+	} else {
 		e = rb_entry(n, struct e_node, start.node);
 
 		n = rb_next(n);
@@ -1100,17 +1101,17 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 		wnd->extent_max = e->count.key;
 
 	if (e->count.key < max_alloc) {
-		if (e->count.key >= to_alloc)
+		if (e->count.key >= to_alloc) {
 			;
-		else if (flags & BITMAP_FIND_FULL) {
+		} else if (flags & BITMAP_FIND_FULL) {
 			if (e->count.key < to_alloc0) {
 				/* Biggest free block is less then requested */
 				goto no_space;
 			}
 			to_alloc = e->count.key;
-		} else if (-1 != wnd->uptodated)
+		} else if (-1 != wnd->uptodated) {
 			to_alloc = e->count.key;
-		else {
+		} else {
 			/* Check if we can use more bits */
 			size_t op, max_check;
 			struct rb_root start_tree;
@@ -1191,9 +1192,9 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
 	}
 
 	if (unlikely(iw + 1 == nwnd)) {
-		if (max_alloc == wnd->nbits)
+		if (max_alloc == wnd->nbits) {
 			wbits = wnd->bits_last;
-		else {
+		} else {
 			size_t t = max_alloc & (wbits - 1);
 
 			if (t) {
@@ -1376,9 +1377,9 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 	if (new_wnd == wnd->nwnd)
 		goto skip_reallocate;
 
-	if (new_wnd <= ARRAY_SIZE(wnd->free_holder))
+	if (new_wnd <= ARRAY_SIZE(wnd->free_holder)) {
 		new_free = wnd->free_holder;
-	else {
+	} else {
 		new_free = ntfs_alloc(new_wnd * sizeof(u16), 0);
 		if (!new_free)
 			return -ENOMEM;
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 52511299b4b7..5cc34f8661cb 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -142,9 +142,9 @@ static int ntfs_extend_initialized_size(struct file *file,
 					goto next;
 				}
 
-				if (vbo < pos)
+				if (vbo < pos) {
 					pos = vbo;
-				else {
+				} else {
 					to = (new_valid >> bits) << bits;
 					if (pos < to) {
 						ni->i_valid = to;
@@ -355,8 +355,9 @@ void ntfs_sparse_cluster(struct inode *inode, struct page *page0, loff_t vbo,
 				if (from <= bh_off && bh_next <= to) {
 					set_buffer_uptodate(bh);
 					mark_buffer_dirty(bh);
-				} else if (!buffer_uptodate(bh))
+				} else if (!buffer_uptodate(bh)) {
 					partial = true;
+				}
 				bh_off = bh_next;
 			} while (head != (bh = bh->b_this_page));
 		}
@@ -995,17 +996,17 @@ static noinline ssize_t ntfs_compress_write(struct kiocb *iocb,
 			if (!bytes || !cp)
 				break;
 
-			if (cp < tail)
+			if (cp < tail) {
 				off += cp;
-			else {
+			} else {
 				ip++;
 				off = 0;
 			}
 		}
 
-		if (!copied)
+		if (!copied) {
 			force_uptodate = true;
-		else {
+		} else {
 			size_t dpages;
 
 			force_uptodate = false;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3402863c8352..77a9a46d1510 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -598,9 +598,9 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	ni->attr_list.size = lsize;
 
 	to_free = le32_to_cpu(rec->used) + lsize + SIZEOF_RESIDENT;
-	if (to_free <= rs)
+	if (to_free <= rs) {
 		to_free = 0;
-	else {
+	} else {
 		to_free -= rs;
 
 		if (to_free > free_b) {
@@ -1303,9 +1303,9 @@ int ni_delete_all(struct ntfs_inode *ni)
 	if (!attr)
 		goto attr_list;
 
-	if (!nt5 || attr->name_len)
+	if (!nt5 || attr->name_len) {
 		;
-	else if (attr->type == ATTR_REPARSE) {
+	} else if (attr->type == ATTR_REPARSE) {
 		get_mi_ref(&ni->mi, &ref);
 		err = ntfs_remove_reparse(sbi, 0, &ref);
 	} else if (attr->type == ATTR_ID) {
@@ -1653,9 +1653,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		}
 
 		flags = FIEMAP_EXTENT_MERGED;
-		if (S_ISDIR(ni->vfs_inode.i_mode))
+		if (S_ISDIR(ni->vfs_inode.i_mode)) {
 			;
-		else if (is_attr_compressed(attr)) {
+		} else if (is_attr_compressed(attr)) {
 			bool is_compr;
 			CLST clst_data;
 
@@ -1666,8 +1666,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 				break;
 			if (is_compr)
 				flags |= FIEMAP_EXTENT_ENCODED;
-		} else if (is_attr_encrypted(attr))
+		} else if (is_attr_encrypted(attr)) {
 			flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
+		}
 
 		vbo = (u64)vcn << cluster_bits;
 		bytes = (u64)clen << cluster_bits;
@@ -1680,11 +1681,11 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			flags |= FIEMAP_EXTENT_LAST;
 		}
 
-		if (vbo + bytes <= valid)
+		if (vbo + bytes <= valid) {
 			;
-		else if (vbo >= valid)
+		} else if (vbo >= valid) {
 			flags |= FIEMAP_EXTENT_UNWRITTEN;
-		else {
+		} else {
 			/* vbo < valid && valid < vbo + bytes */
 			u64 dlen = valid - vbo;
 
@@ -2234,9 +2235,9 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 
 		attr = ni_find_attr(ni, NULL, &le, ATTR_DATA, NULL, 0, NULL,
 				    &mi);
-		if (!attr)
+		if (!attr) {
 			dup.alloc_size = dup.data_size = 0;
-		else if (!attr->non_res) {
+		} else if (!attr->non_res) {
 			u32 data_size = le32_to_cpu(attr->res.data_size);
 
 			dup.alloc_size = cpu_to_le64(QuadAlign(data_size));
@@ -2289,8 +2290,9 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		if (memcmp(&fname->dup, &dup, sizeof(fname->dup))) {
 			memcpy(&fname->dup, &dup, sizeof(fname->dup));
 			mi->dirty = true;
-		} else if (!upd_parent)
+		} else if (!upd_parent) {
 			continue;
+		}
 
 		if (!active)
 			continue; /*avoid __wait_on_freeing_inode(inode); */
@@ -2307,9 +2309,9 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		if (!is_bad_inode(dir)) {
 			struct ntfs_inode *dir_ni = ntfs_i(dir);
 
-			if (!ni_trylock(dir_ni))
+			if (!ni_trylock(dir_ni)) {
 				re_dirty = true;
-			else {
+			} else {
 				indx_update_dup(dir_ni, sbi, fname, &dup, sync);
 				ni_unlock(dir_ni);
 			}
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index f282e96a45cb..c80b5d594d9b 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -841,8 +841,9 @@ static inline struct RESTART_TABLE *extend_rsttbl(struct RESTART_TABLE *tbl,
 	if (tbl->first_free) {
 		rt->first_free = tbl->first_free;
 		*(__le32 *)Add2Ptr(rt, le32_to_cpu(tbl->last_free)) = osize;
-	} else
+	} else {
 		rt->first_free = osize;
+	}
 
 	rt->total = tbl->total;
 
@@ -3735,9 +3736,9 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 			ib->rhdr.lsn = t64;
 	}
 
-	if (inode)
+	if (inode) {
 		err = _ni_write_inode(inode, 0);
-	else if (mi && mi->dirty) {
+	} else if (mi && mi->dirty) {
 		err = mi_write(mi, 0);
 		if (err)
 			goto out;
@@ -4056,9 +4057,9 @@ int log_replay(struct ntfs_inode *ni)
 	log->ra = ra;
 
 	t16 = le16_to_cpu(ra2->client_off);
-	if (t16 == offsetof(struct RESTART_AREA, clients))
+	if (t16 == offsetof(struct RESTART_AREA, clients)) {
 		memcpy(ra, ra2, log->ra_size);
-	else {
+	} else {
 		memcpy(ra, ra2, offsetof(struct RESTART_AREA, clients));
 		memcpy(ra->clients, Add2Ptr(ra2, t16),
 		       le16_to_cpu(ra2->ra_len) - t16);
@@ -4511,11 +4512,11 @@ int log_replay(struct ntfs_inode *ni)
 		 * Calculate the number of clusters per page the system
 		 * which wrote the checkpoint, possibly creating the table
 		 */
-		if (dptbl)
+		if (dptbl) {
 			t32 = 1 + (le16_to_cpu(dptbl->size) -
 				   sizeof(struct DIR_PAGE_ENTRY)) /
 					  sizeof(u64);
-		else {
+		} else {
 			t32 = log->clst_per_page;
 			ntfs_free(dptbl);
 			dptbl = init_rsttbl(sizeof(struct DIR_PAGE_ENTRY) +
@@ -4615,8 +4616,9 @@ int log_replay(struct ntfs_inode *ni)
 			oe->name_len = 0; //oe0.name_len;
 			oe->ref = oe0->ref;
 			oe->open_record_lsn = oe0->open_record_lsn;
-		} else
+		} else {
 			memcpy(oe, Add2Ptr(lrh, t16), bytes_per_attr_entry);
+		}
 
 		t16 = le16_to_cpu(lrh->undo_len);
 		if (t16) {
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index d142b42f2cc2..9c489e8be91a 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -196,9 +196,9 @@ int ntfs_extend_init(struct ntfs_sb_info *sbi)
 	/* Try to find $ObjId */
 	inode2 = dir_search_u(inode, &NAME_OBJID, NULL);
 	if (inode2 && !IS_ERR(inode2)) {
-		if (is_bad_inode(inode2))
+		if (is_bad_inode(inode2)) {
 			iput(inode2);
-		else {
+		} else {
 			sbi->objid.ni = ntfs_i(inode2);
 			sbi->objid_no = inode2->i_ino;
 		}
@@ -690,11 +690,11 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 		sbi->mft.next_free = MFT_REC_USER;
 
 	for (;;) {
-		if (sbi->mft.next_free >= sbi->mft.bitmap.nbits)
+		if (sbi->mft.next_free >= sbi->mft.bitmap.nbits) {
 			;
-		else if (!wnd_find(wnd, 1, MFT_REC_USER, 0, &fr))
+		} else if (!wnd_find(wnd, 1, MFT_REC_USER, 0, &fr)) {
 			sbi->mft.next_free = sbi->mft.bitmap.nbits;
-		else {
+		} else {
 			*rno = fr;
 			sbi->mft.next_free = *rno + 1;
 			break;
@@ -743,8 +743,9 @@ void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno)
 			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 		else
 			wnd_set_free(wnd, rno, 1);
-	} else if (rno >= MFT_REC_RESERVED && sbi->mft.reserved_bitmap_inited)
+	} else if (rno >= MFT_REC_RESERVED && sbi->mft.reserved_bitmap_inited) {
 		__clear_bit(rno - MFT_REC_RESERVED, &sbi->mft.reserved_bitmap);
+	}
 
 	if (rno < wnd_zone_bit(wnd))
 		wnd_zone_set(wnd, rno, 1);
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 43853daa3a48..304d48b4e838 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -388,9 +388,9 @@ static int scan_nres_bitmap(struct ntfs_sb_info *sbi, struct ATTRIB *bitmap,
 			return -EIO;
 
 		vbo = (u64)vblock << sb->s_blocksize_bits;
-		if (vbo >= valid_size)
+		if (vbo >= valid_size) {
 			memset(bh->b_data, 0, blocksize);
-		else if (vbo + blocksize > valid_size) {
+		} else if (vbo + blocksize > valid_size) {
 			u32 voff = valid_size & sbi->block_mask;
 
 			memset(bh->b_data + voff, 0, blocksize - voff);
@@ -1608,9 +1608,9 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}
 
 	n = NULL;
-	if (!to_move)
+	if (!to_move) {
 		re = NULL;
-	else {
+	} else {
 		re = ntfs_memdup(e0, to_move);
 		if (!re) {
 			err = -ENOMEM;
@@ -2327,9 +2327,9 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 		de_set_vbn_le(next, de_get_vbn_le(e));
 		hdr_delete_de(hdr, e);
-		if (level)
+		if (level) {
 			indx_write(indx, ni, n, 0);
-		else {
+		} else {
 			hdr->total = hdr->used;
 
 			/* Shrink resident root attribute */
@@ -2643,9 +2643,9 @@ int indx_update_dup(struct ntfs_inode *ni, struct ntfs_sb_info *sbi,
 
 	memcpy(&e_fname->dup, dup, sizeof(*dup));
 
-	if (fnd->level)
+	if (fnd->level) {
 		err = indx_write(indx, ni, fnd->nodes[fnd->level - 1], sync);
-	else if (sync) {
+	} else if (sync) {
 		mi->dirty = true;
 		err = mi_write(mi, 1);
 	} else {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 117800126c17..3e66ad89d2fd 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -75,9 +75,9 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 
 	rec = ni->mi.mrec;
 
-	if (sbi->flags & NTFS_FLAGS_LOG_REPLAING)
+	if (sbi->flags & NTFS_FLAGS_LOG_REPLAING) {
 		;
-	else if (ref->seq != rec->seq) {
+	} else if (ref->seq != rec->seq) {
 		err = -EINVAL;
 		ntfs_err(sb, "MFT: r=%lx, expect seq=%x instead of %x!",
 			 ino, le16_to_cpu(ref->seq), le16_to_cpu(rec->seq));
diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 123ee648dc38..c9bdecfb1294 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -76,8 +76,9 @@ static size_t longest_match_std(const u8 *src, struct lznt *ctx)
 	if (len1 < len2) {
 		ctx->best_match = hash[1];
 		len1 = len2;
-	} else
+	} else {
 		ctx->best_match = hash[0];
+	}
 
 	hash[1] = hash[0];
 	hash[0] = src;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 55116311ade9..8dd4adf64058 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -515,8 +515,9 @@ static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			if (file->f_mode & FMODE_OPENED) {
 				dput(d);
 				err = 0;
-			} else
+			} else {
 				err = finish_no_open(file, d);
+			}
 			goto out1;
 		}
 		WARN_ON(d);
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 8a3f7af581b7..4dcddc903b0b 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -290,8 +290,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 		if (attr->nres.c_unit)
 			goto out;
-	} else if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+	} else if (asize + 8 < SIZEOF_NONRESIDENT_EX) {
 		goto out;
+	}
 
 	return attr;
 
@@ -370,15 +371,15 @@ int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
 
 	rec = mi->mrec;
 
-	if (rno == MFT_REC_MFT)
+	if (rno == MFT_REC_MFT) {
 		;
-	else if (rno < MFT_REC_FREE)
+	} else if (rno < MFT_REC_FREE) {
 		seq = rno;
-	else if (rno >= sbi->mft.used)
+	} else if (rno >= sbi->mft.used) {
 		;
-	else if (mi_read(mi, is_mft))
+	} else if (mi_read(mi, is_mft)) {
 		;
-	else if (rec->rhdr.sign == NTFS_FILE_SIGNATURE) {
+	} else if (rec->rhdr.sign == NTFS_FILE_SIGNATURE) {
 		/* Record is reused. Update its sequence number */
 		seq = le16_to_cpu(rec->seq) + 1;
 		if (!seq)
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 4c6757b8bb82..90700de3f346 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -401,9 +401,9 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len)
 		struct ntfs_run *new_ptr;
 
 		/* Use power of 2 for 'bytes'*/
-		if (!used)
+		if (!used) {
 			bytes = 64;
-		else if (used <= 16 * PAGE_SIZE) {
+		} else if (used <= 16 * PAGE_SIZE) {
 			if (is_power_of2(run->allocated))
 				bytes = run->allocated << 1;
 			else
@@ -603,9 +603,9 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
 	size_size = run_packed_size(&len64);
 
 	/* offset_size - how much bytes is packed dlcn */
-	if (lcn == SPARSE_LCN)
+	if (lcn == SPARSE_LCN) {
 		offset_size = 0;
-	else {
+	} else {
 		/* NOTE: lcn can be less than prev_lcn! */
 		dlcn = (s64)lcn - prev_lcn;
 		offset_size = run_packed_size(&dlcn);
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 8c8cba759471..f87b91ee04a1 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -128,10 +128,10 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 
 	spin_lock(&s_shared_lock);
 	for (i = 0; i < ARRAY_SIZE(s_shared); i++) {
-		if (!s_shared[i].cnt)
+		if (!s_shared[i].cnt) {
 			j = i;
-		else if (bytes == s_shared[i].len &&
-			 !memcmp(s_shared[i].ptr, ptr, bytes)) {
+		} else if (bytes == s_shared[i].len &&
+			   !memcmp(s_shared[i].ptr, ptr, bytes)) {
 			s_shared[i].cnt += 1;
 			ret = s_shared[i].ptr;
 			break;
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 04e1c74b0e3d..496023b0ba4c 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -756,11 +756,11 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 	if (name_len == sizeof(SYSTEM_DOS_ATTRIB) - 1 &&
 	    !memcmp(name, SYSTEM_DOS_ATTRIB, sizeof(SYSTEM_DOS_ATTRIB))) {
 		/* system.dos_attrib */
-		if (!buffer)
+		if (!buffer) {
 			err = sizeof(u8);
-		else if (size < sizeof(u8))
+		} else if (size < sizeof(u8)) {
 			err = -ENODATA;
-		else {
+		} else {
 			err = sizeof(u8);
 			*(u8 *)buffer = le32_to_cpu(ni->std_fa);
 		}
@@ -770,11 +770,11 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 	if (name_len == sizeof(SYSTEM_NTFS_ATTRIB) - 1 &&
 	    !memcmp(name, SYSTEM_NTFS_ATTRIB, sizeof(SYSTEM_NTFS_ATTRIB))) {
 		/* system.ntfs_attrib */
-		if (!buffer)
+		if (!buffer) {
 			err = sizeof(u32);
-		else if (size < sizeof(u32))
+		} else if (size < sizeof(u32)) {
 			err = -ENODATA;
-		else {
+		} else {
 			err = sizeof(u32);
 			*(u32 *)buffer = le32_to_cpu(ni->std_fa);
 		}
@@ -785,11 +785,11 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 	    !memcmp(name, SYSTEM_NTFS_ATTRIB_BE,
 		    sizeof(SYSTEM_NTFS_ATTRIB_BE))) {
 		/* system.ntfs_attrib_be */
-		if (!buffer)
+		if (!buffer) {
 			err = sizeof(u32);
-		else if (size < sizeof(u32))
+		} else if (size < sizeof(u32)) {
 			err = -ENODATA;
-		else {
+		} else {
 			err = sizeof(u32);
 			*(__be32 *)buffer =
 				cpu_to_be32(le32_to_cpu(ni->std_fa));
@@ -802,11 +802,11 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 		    sizeof(SAMBA_PROCESS_NAME)) &&
 	    !memcmp(name, USER_DOSATTRIB, sizeof(USER_DOSATTRIB))) {
 		/* user.DOSATTRIB */
-		if (!buffer)
+		if (!buffer) {
 			err = 5;
-		else if (size < 5)
+		} else if (size < 5) {
 			err = -ENODATA;
-		else {
+		} else {
 			err = sprintf((char *)buffer, "0x%x",
 				      le32_to_cpu(ni->std_fa) & 0xff) +
 			      1;
-- 
2.26.0

