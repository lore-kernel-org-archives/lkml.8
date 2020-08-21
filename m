Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C1AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F75820656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="LtU5MAKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgHUQ0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:26:11 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:59042 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728567AbgHUQZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:25:38 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 5CE1D82080;
        Fri, 21 Aug 2020 19:25:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598027104;
        bh=d9mePfLPiDOQyw4COwNwbkRGYt7CFBIhO4PRzCCRqmw=;
        h=From:To:CC:Subject:Date;
        b=LtU5MAKD2GcOzZqum/4YSJXsNMg/lhuunMHSXt7TnCWejkJ3DMx0NZku+OvTZXMj7
         1JEKi/K8bAzrcj+mVeFbHuN2ucDAAe2G5T0kbgZWklaqZV6/57F+jeSxwTuRyMAz5c
         9z9O8W1jPd7VBtfmijvAFKpXlOniRt9/4YbcWpAU=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 21 Aug 2020 19:25:03 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 21 Aug 2020 19:25:03 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
Thread-Topic: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
Thread-Index: AdZ30tAfM9dNSlAKR92rLVrbgJq3AA==
Date:   Fri, 21 Aug 2020 16:25:03 +0000
Message-ID: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization of super block for fs/ntfs3

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com=
>
---
 fs/ntfs3/fsntfs.c | 2196 +++++++++++++++++++++++++++++++++++++
 fs/ntfs3/index.c  | 2640 +++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/inode.c  | 2068 +++++++++++++++++++++++++++++++++++
 fs/ntfs3/super.c  | 1409 ++++++++++++++++++++++++
 4 files changed, 8313 insertions(+)
 create mode 100644 fs/ntfs3/fsntfs.c
 create mode 100644 fs/ntfs3/index.c
 create mode 100644 fs/ntfs3/inode.c
 create mode 100644 fs/ntfs3/super.c

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
new file mode 100644
index 000000000000..47d6498094df
--- /dev/null
+++ b/fs/ntfs3/fsntfs.c
@@ -0,0 +1,2196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/fsntfs.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/nls.h>
+#include <linux/sched/signal.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+const struct cpu_str NAME_MFT =3D { 4, 0, { '$', 'M', 'F', 'T' } };
+const struct cpu_str NAME_MIRROR =3D { 8,
+				     0,
+				     { '$', 'M', 'F', 'T', 'M', 'i', 'r',
+				       'r' } };
+const struct cpu_str NAME_LOGFILE =3D { 8,
+				      0,
+				      { '$', 'L', 'o', 'g', 'F', 'i', 'l',
+					'e' } };
+const struct cpu_str NAME_VOLUME =3D { 7,
+				     0,
+				     { '$', 'V', 'o', 'l', 'u', 'm', 'e' } };
+const struct cpu_str NAME_ATTRDEF =3D { 8,
+				      0,
+				      { '$', 'A', 't', 't', 'r', 'D', 'e',
+					'f' } };
+const struct cpu_str NAME_ROOT =3D { 1, 0, { '.' } };
+const struct cpu_str NAME_BITMAP =3D { 7,
+				     0,
+				     { '$', 'B', 'i', 't', 'm', 'a', 'p' } };
+const struct cpu_str NAME_BOOT =3D { 5, 0, { '$', 'B', 'o', 'o', 't' } };
+const struct cpu_str NAME_BADCLUS =3D { 8,
+				      0,
+				      { '$', 'B', 'a', 'd', 'C', 'l', 'u',
+					's' } };
+const struct cpu_str NAME_QUOTA =3D { 6, 0, { '$', 'Q', 'u', 'o', 't', 'a'=
 } };
+const struct cpu_str NAME_SECURE =3D { 7,
+				     0,
+				     { '$', 'S', 'e', 'c', 'u', 'r', 'e' } };
+const struct cpu_str NAME_UPCASE =3D { 7,
+				     0,
+				     { '$', 'U', 'p', 'C', 'a', 's', 'e' } };
+const struct cpu_str NAME_EXTEND =3D { 7,
+				     0,
+				     { '$', 'E', 'x', 't', 'e', 'n', 'd' } };
+const struct cpu_str NAME_OBJID =3D { 6, 0, { '$', 'O', 'b', 'j', 'I', 'd'=
 } };
+const struct cpu_str NAME_REPARSE =3D { 8,
+				      0,
+				      { '$', 'R', 'e', 'p', 'a', 'r', 's',
+					'e' } };
+const struct cpu_str NAME_USNJRNL =3D { 8,
+				      0,
+				      { '$', 'U', 's', 'n', 'J', 'r', 'n',
+					'l' } };
+const __le16 BAD_NAME[4] =3D { cpu_to_le16('$'), cpu_to_le16('B'),
+			     cpu_to_le16('a'), cpu_to_le16('d') };
+const __le16 I30_NAME[4] =3D { cpu_to_le16('$'), cpu_to_le16('I'),
+			     cpu_to_le16('3'), cpu_to_le16('0') };
+const __le16 SII_NAME[4] =3D { cpu_to_le16('$'), cpu_to_le16('S'),
+			     cpu_to_le16('I'), cpu_to_le16('I') };
+const __le16 SDH_NAME[4] =3D { cpu_to_le16('$'), cpu_to_le16('S'),
+			     cpu_to_le16('D'), cpu_to_le16('H') };
+const __le16 SDS_NAME[4] =3D { cpu_to_le16('$'), cpu_to_le16('S'),
+			     cpu_to_le16('D'), cpu_to_le16('S') };
+const __le16 SO_NAME[2] =3D { cpu_to_le16('$'), cpu_to_le16('O') };
+const __le16 SQ_NAME[2] =3D { cpu_to_le16('$'), cpu_to_le16('Q') };
+const __le16 SR_NAME[2] =3D { cpu_to_le16('$'), cpu_to_le16('R') };
+//const __le16 EFS_NAME[4] =3D { '$', 'E', 'F', 'S' };
+
+//const __le16 WOF_NAME[17] =3D { 'W', 'o', 'f', 'C', 'o', 'm', 'p', 'r', =
'e',
+//			      'S', 'S', 'e', 'd', 'D', 'a', 't', 'a' };
+//const __le16 J_NAME[2] =3D { '$', 'J' };
+//const __le16 MAX_NAME[4] =3D { '$', 'M', 'a', 'x' };
+
+/*
+ * ntfs_fix_pre_write
+ *
+ * inserts fixups into 'rhdr' before writing to disk
+ */
+bool ntfs_fix_pre_write(NTFS_RECORD_HEADER *rhdr, size_t bytes)
+{
+	u16 *fixup, *ptr;
+	u16 sample;
+	u16 fo =3D le16_to_cpu(rhdr->fix_off);
+	u16 fn =3D le16_to_cpu(rhdr->fix_num);
+
+	if ((fo & 1) || fo + fn * sizeof(short) > bytes || !fn-- ||
+	    fn * SECTOR_SIZE > bytes) {
+		return false;
+	}
+
+	/* Get fixup pointer */
+	fixup =3D Add2Ptr(rhdr, fo);
+
+	if (*fixup >=3D 0x7FFF)
+		*fixup =3D 1;
+	else
+		*fixup +=3D 1;
+
+	sample =3D *fixup;
+
+	ptr =3D Add2Ptr(rhdr, SECTOR_SIZE - sizeof(short));
+
+	while (fn--) {
+		*++fixup =3D *ptr;
+		*ptr =3D sample;
+		ptr +=3D SECTOR_SIZE / sizeof(short);
+	}
+	return true;
+}
+
+/*
+ * ntfs_fix_post_read
+ *
+ * remove fixups after reading from disk
+ * Returns < 0 if error, 0 if ok, 1 if need to update fixups
+ */
+int ntfs_fix_post_read(NTFS_RECORD_HEADER *rhdr, size_t bytes, bool simple=
)
+{
+	int ret;
+	u16 *fixup, *ptr;
+	u16 sample, fo, fn;
+
+	fo =3D le16_to_cpu(rhdr->fix_off);
+	fn =3D simple ? ((bytes >> SECTOR_SHIFT) + 1) :
+		      le16_to_cpu(rhdr->fix_num);
+
+	/* Check errors */
+	if ((fo & 1) || fo + fn * sizeof(short) > bytes || !fn-- ||
+	    fn * SECTOR_SIZE > bytes) {
+		return -EINVAL; /* native chkntfs returns ok! */
+	}
+
+	/* Get fixup pointer */
+	fixup =3D Add2Ptr(rhdr, fo);
+	sample =3D *fixup;
+	ptr =3D Add2Ptr(rhdr, SECTOR_SIZE - sizeof(short));
+	ret =3D 0;
+
+	while (fn--) {
+		/* Test current word */
+		if (*ptr !=3D sample)
+			ret =3D 1;
+
+		/* Replace fixup */
+		*ptr =3D *++fixup;
+		ptr +=3D SECTOR_SIZE / sizeof(short);
+	}
+
+	return ret;
+}
+
+/*
+ * ntfs_extend_init
+ *
+ * loads $Extend file
+ */
+int ntfs_extend_init(ntfs_sb_info *sbi)
+{
+	int err;
+	struct super_block *sb =3D sbi->sb;
+	struct inode *inode, *inode2;
+	ntfs_inode *ni;
+	MFT_REF ref;
+
+	if (sbi->volume.major_ver < 3) {
+		ntfs_trace(sb, "Skip $Extend 'cause NTFS version");
+		return 0;
+	}
+
+	ref.low =3D cpu_to_le32(MFT_REC_EXTEND);
+	ref.high =3D 0;
+	ref.seq =3D cpu_to_le16(MFT_REC_EXTEND);
+	inode =3D ntfs_iget5(sb, &ref, &NAME_EXTEND);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		ntfs_error(sbi->sb, "Failed to load $Extend.");
+		inode =3D NULL;
+		goto out;
+	}
+
+	/* if ntfs_iget5 reads from disk it never returns bad inode */
+	ni =3D ntfs_i(inode);
+	if (!S_ISDIR(inode->i_mode)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* Try to find $ObjId */
+	inode2 =3D dir_search_u(inode, &NAME_OBJID, NULL);
+	if (inode2 && !IS_ERR(inode2)) {
+		if (is_bad_inode(inode2))
+			iput(inode2);
+		else {
+			sbi->objid.ni =3D ntfs_i(inode2);
+			sbi->objid_no =3D inode2->i_ino;
+		}
+	}
+
+	/* Try to find $Quota */
+	inode2 =3D dir_search_u(inode, &NAME_QUOTA, NULL);
+	if (inode2 && !IS_ERR(inode2)) {
+		sbi->quota_no =3D inode2->i_ino;
+		iput(inode2);
+	}
+
+	/* Try to find $Reparse */
+	inode2 =3D dir_search_u(inode, &NAME_REPARSE, NULL);
+	if (inode2 && !IS_ERR(inode2)) {
+		sbi->reparse.ni =3D ntfs_i(inode2);
+		sbi->reparse_no =3D inode2->i_ino;
+	}
+
+	/* Try to find $UsnJrnl */
+	inode2 =3D dir_search_u(inode, &NAME_USNJRNL, NULL);
+	if (inode2 && !IS_ERR(inode2)) {
+		sbi->usn_jrnl_no =3D inode2->i_ino;
+		iput(inode2);
+	}
+
+	err =3D 0;
+out:
+	iput(inode);
+	return err;
+}
+
+int ntfs_loadlog_and_replay(ntfs_inode *ni, ntfs_sb_info *sbi)
+{
+	int err =3D 0;
+	struct super_block *sb =3D sbi->sb;
+	struct inode *inode;
+	MFT_REF ref;
+	u32 idx, log_size;
+	CLST lcn, len;
+
+	inode =3D &ni->vfs_inode;
+
+	/* Check for 4GB */
+	if (inode->i_size >=3D 0x100000000ull) {
+		ntfs_error(sb, "$LogFile is too big");
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	log_size =3D inode->i_size;
+	sbi->flags |=3D NTFS_FLAGS_LOG_REPLAING;
+
+	ref.low =3D cpu_to_le32(MFT_REC_MFT);
+	ref.high =3D 0;
+	ref.seq =3D cpu_to_le16(1);
+
+	inode =3D ntfs_iget5(sb, &ref, NULL);
+
+	if (IS_ERR(inode))
+		inode =3D NULL;
+
+	if (!inode) {
+		/* Try to use mft copy */
+		u64 t64 =3D sbi->mft.lbo;
+
+		sbi->mft.lbo =3D sbi->mft.lbo2;
+		inode =3D ntfs_iget5(sb, &ref, NULL);
+		sbi->mft.lbo =3D t64;
+		if (IS_ERR(inode))
+			inode =3D NULL;
+	}
+
+	if (!inode) {
+		err =3D -EINVAL;
+		ntfs_error(sb, "Failed to load $MFT.");
+		goto out;
+	}
+
+	sbi->mft.ni =3D ntfs_i(inode);
+
+	err =3D ni_load_all_mi(sbi->mft.ni);
+	if (!err)
+		err =3D log_replay(ni);
+
+	iput(inode);
+	sbi->mft.ni =3D NULL;
+
+	sync_blockdev(sb->s_bdev);
+	invalidate_bdev(sb->s_bdev);
+
+	/* reinit MFT */
+	if (sbi->flags & NTFS_FLAGS_NEED_REPLAY) {
+		err =3D 0;
+		goto out;
+	}
+
+	if (sb_rdonly(sb))
+		goto out;
+
+	idx =3D 0;
+	while (run_get_entry(&ni->file.run, idx++, NULL, &lcn, &len)) {
+		u64 lbo =3D (u64)lcn << sbi->cluster_bits;
+		u64 bytes =3D (u64)len << sbi->cluster_bits;
+
+		err =3D ntfs_sb_write(sb, lbo, bytes, NULL, 0);
+		if (err)
+			goto out;
+	}
+
+out:
+	sbi->flags &=3D ~NTFS_FLAGS_LOG_REPLAING;
+
+	return err;
+}
+
+/*
+ * ntfs_query_def
+ *
+ * returns current ATTR_DEF_ENTRY for given attribute type
+ */
+const ATTR_DEF_ENTRY *ntfs_query_def(ntfs_sb_info *sbi, ATTR_TYPE type)
+{
+	int type_in =3D le32_to_cpu(type);
+	size_t min_idx =3D 0;
+	size_t max_idx =3D sbi->def_entries - 1;
+
+	while (min_idx <=3D max_idx) {
+		size_t i =3D min_idx + ((max_idx - min_idx) >> 1);
+		const ATTR_DEF_ENTRY *entry =3D sbi->def_table + i;
+		int diff =3D le32_to_cpu(entry->type) - type_in;
+
+		if (!diff)
+			return entry;
+		if (diff < 0)
+			min_idx =3D i + 1;
+		else if (i)
+			max_idx =3D i - 1;
+		else
+			return NULL;
+	}
+	return NULL;
+}
+
+/*
+ * ntfs_look_for_free_space
+ *
+ * looks for a free space in bitmap
+ */
+int ntfs_look_for_free_space(ntfs_sb_info *sbi, CLST lcn, CLST len,
+			     CLST *new_lcn, CLST *new_len,
+			     enum ALLOCATE_OPT opt)
+{
+	int err;
+	struct super_block *sb =3D sbi->sb;
+	size_t a_lcn, zlen, zeroes, zlcn, zlen2, ztrim, new_zlen;
+	wnd_bitmap *wnd =3D &sbi->used.bitmap;
+
+	down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
+	if (opt & ALLOCATE_MFT) {
+		CLST alen;
+
+		zlen =3D wnd_zone_len(wnd);
+
+		if (!zlen) {
+			err =3D ntfs_refresh_zone(sbi);
+			if (err)
+				goto out;
+
+			zlen =3D wnd_zone_len(wnd);
+
+			if (!zlen) {
+				ntfs_error(sbi->sb,
+					   "no free space to extend mft");
+				err =3D -ENOSPC;
+				goto out;
+			}
+		}
+
+		lcn =3D wnd_zone_bit(wnd);
+		alen =3D zlen > len ? len : zlen;
+
+		wnd_zone_set(wnd, lcn + alen, zlen - alen);
+
+		err =3D wnd_set_used(wnd, lcn, alen);
+		if (err)
+			goto out;
+
+		*new_lcn =3D lcn;
+		*new_len =3D alen;
+		goto ok;
+	}
+
+	/*
+	 * 'Cause cluster 0 is always used this value means that we should use
+	 * cached value of 'next_free_lcn' to improve performance
+	 */
+	if (!lcn)
+		lcn =3D sbi->used.next_free_lcn;
+
+	if (lcn >=3D wnd->nbits)
+		lcn =3D 0;
+
+	*new_len =3D wnd_find(wnd, len, lcn, BITMAP_FIND_MARK_AS_USED, &a_lcn);
+	if (*new_len) {
+		*new_lcn =3D a_lcn;
+		goto ok;
+	}
+
+	/* Try to use clusters from MftZone */
+	zlen =3D wnd_zone_len(wnd);
+	zeroes =3D wnd_zeroes(wnd);
+
+	/* Check too big request */
+	if (len > zeroes + zlen)
+		goto no_space;
+
+	if (zlen <=3D NTFS_MIN_MFT_ZONE)
+		goto no_space;
+
+	/* How many clusters to cat from zone */
+	zlcn =3D wnd_zone_bit(wnd);
+	zlen2 =3D zlen >> 1;
+	ztrim =3D len > zlen ? zlen : (len > zlen2 ? len : zlen2);
+	new_zlen =3D zlen - ztrim;
+
+	if (new_zlen < NTFS_MIN_MFT_ZONE) {
+		new_zlen =3D NTFS_MIN_MFT_ZONE;
+		if (new_zlen > zlen)
+			new_zlen =3D zlen;
+	}
+
+	wnd_zone_set(wnd, zlcn, new_zlen);
+
+	/* allocate continues clusters */
+	*new_len =3D
+		wnd_find(wnd, len, 0,
+			 BITMAP_FIND_MARK_AS_USED | BITMAP_FIND_FULL, &a_lcn);
+	if (*new_len) {
+		*new_lcn =3D a_lcn;
+		goto ok;
+	}
+
+no_space:
+	ntfs_trace(
+		sb,
+		"Can not allocate %x cluster(s), Zone: %zx, free %zx, flags %d",
+		(u32)len, zlen, wnd_zeroes(wnd), (int)opt);
+
+	up_write(&wnd->rw_lock);
+
+	return -ENOSPC;
+
+ok:
+	err =3D 0;
+
+	ntfs_unmap_meta(sb, *new_lcn, *new_len);
+
+	if (opt & ALLOCATE_MFT)
+		goto out;
+
+	/* Set hint for next requests */
+	sbi->used.next_free_lcn =3D *new_lcn + *new_len;
+
+out:
+	up_write(&wnd->rw_lock);
+	return err;
+}
+
+/*
+ * ntfs_extend_mft
+ *
+ * allocates additional MFT records
+ * sbi->mft.bitmap is locked for write
+ *
+ * NOTE: recursive:
+ *	ntfs_look_free_mft ->
+ *	ntfs_extend_mft ->
+ *	attr_set_size ->
+ *	ni_insert_nonresident ->
+ *	ni_insert_attr ->
+ *	ni_ins_attr_ext ->
+ *	ntfs_look_free_mft ->
+ *	ntfs_extend_mft
+ * To avoid recursive always allocate space for two new mft records
+ * see attrib.c: "at least two mft to avoid recursive loop"
+ */
+static int ntfs_extend_mft(ntfs_sb_info *sbi)
+{
+	int err;
+	ntfs_inode *ni =3D sbi->mft.ni;
+	size_t new_mft_total;
+	u64 new_mft_bytes, new_bitmap_bytes;
+	ATTRIB *attr;
+	wnd_bitmap *wnd =3D &sbi->mft.bitmap;
+
+	new_mft_total =3D (wnd->nbits + MFT_INCREASE_CHUNK + 127) & (CLST)~127;
+	new_mft_bytes =3D (u64)new_mft_total << sbi->record_bits;
+
+	/* Step 1: Resize $MFT::DATA */
+	down_write(&ni->file.run_lock);
+	err =3D attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run,
+			    new_mft_bytes, NULL, false, &attr);
+
+	if (err) {
+		up_write(&ni->file.run_lock);
+		goto out;
+	}
+
+	attr->nres.valid_size =3D attr->nres.data_size;
+	new_mft_total =3D le64_to_cpu(attr->nres.alloc_size) >> sbi->record_bits;
+	ni->mi.dirty =3D true;
+
+	/* Step 2: Resize $MFT::BITMAP */
+	new_bitmap_bytes =3D bitmap_size(new_mft_total);
+
+	err =3D attr_set_size(ni, ATTR_BITMAP, NULL, 0, &sbi->mft.bitmap.run,
+			    new_bitmap_bytes, &new_bitmap_bytes, true, NULL);
+
+	/* Refresh Mft Zone if necessary */
+	down_write_nested(&sbi->used.bitmap.rw_lock, BITMAP_MUTEX_CLUSTERS);
+
+	ntfs_refresh_zone(sbi);
+
+	up_write(&sbi->used.bitmap.rw_lock);
+	up_write(&ni->file.run_lock);
+
+	if (err)
+		goto out;
+
+	err =3D wnd_extend(wnd, new_mft_total);
+
+	if (err)
+		goto out;
+
+	ntfs_clear_mft_tail(sbi, sbi->mft.used, new_mft_total);
+
+	err =3D _ni_write_inode(&ni->vfs_inode, 0);
+out:
+	return err;
+}
+
+/*
+ * ntfs_look_free_mft
+ *
+ * looks for a free MFT record
+ */
+int ntfs_look_free_mft(ntfs_sb_info *sbi, CLST *rno, bool mft, ntfs_inode =
*ni,
+		       mft_inode **mi)
+{
+	int err =3D 0;
+	size_t zbit, zlen, from, to, fr;
+	size_t mft_total;
+	MFT_REF ref;
+	struct super_block *sb =3D sbi->sb;
+	wnd_bitmap *wnd =3D &sbi->mft.bitmap;
+	u32 ir;
+
+	static_assert(sizeof(sbi->mft.reserved_bitmap) * 8 >=3D
+		      MFT_REC_FREE - MFT_REC_RESERVED);
+
+	if (!mft)
+		down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_MFT);
+
+	zlen =3D wnd_zone_len(wnd);
+
+	/* Always reserve space for MFT */
+	if (zlen) {
+		if (mft) {
+			zbit =3D wnd_zone_bit(wnd);
+			*rno =3D zbit;
+			wnd_zone_set(wnd, zbit + 1, zlen - 1);
+		}
+		goto found;
+	}
+
+	/* No MFT zone. find the nearest to '0' free MFT */
+	if (!wnd_find(wnd, 1, MFT_REC_FREE, 0, &zbit)) {
+		/* Resize MFT */
+		mft_total =3D wnd->nbits;
+
+		err =3D ntfs_extend_mft(sbi);
+		if (!err) {
+			zbit =3D mft_total;
+			goto reserve_mft;
+		}
+
+		if (!mft || MFT_REC_FREE =3D=3D sbi->mft.next_reserved)
+			goto out;
+
+		err =3D 0;
+
+		/*
+		 * Look for free record reserved area [11-16) =3D=3D
+		 * [MFT_REC_RESERVED, MFT_REC_FREE ) MFT bitmap always
+		 * marks it as used
+		 */
+		if (sbi->mft.reserved_bitmap)
+			goto scan_zone;
+
+		/* Once per session create internal bitmap for 5 bits */
+		sbi->mft.reserved_bitmap =3D 0xFF;
+
+		ref.high =3D 0;
+		for (ir =3D MFT_REC_RESERVED; ir < MFT_REC_FREE; ir++) {
+			struct inode *i;
+			ntfs_inode *ni;
+			MFT_REC *mrec;
+
+			ref.low =3D cpu_to_le32(ir);
+			ref.seq =3D cpu_to_le16(ir);
+
+			i =3D ntfs_iget5(sb, &ref, NULL);
+			if (IS_ERR(i)) {
+next:
+				ntfs_trace(sb, "Invalid reserved record %x",
+					   ref.low);
+				continue;
+			}
+			if (is_bad_inode(i)) {
+				iput(i);
+				goto next;
+			}
+
+			ni =3D ntfs_i(i);
+
+			mrec =3D ni->mi.mrec;
+
+			if (!is_rec_base(mrec))
+				goto next;
+
+			if (mrec->hard_links)
+				goto next;
+
+			if (!ni_std(ni))
+				goto next;
+
+			if (ni_find_attr(ni, NULL, NULL, ATTR_NAME, NULL, 0,
+					 NULL, NULL))
+				goto next;
+
+			__clear_bit(ir - MFT_REC_RESERVED,
+				    &sbi->mft.reserved_bitmap);
+		}
+
+scan_zone:
+		/* Scan 5 bits for zero. Bit 0 =3D=3D MFT_REC_RESERVED */
+		zbit =3D find_next_zero_bit(&sbi->mft.reserved_bitmap,
+					  MFT_REC_FREE, MFT_REC_RESERVED);
+		if (zbit >=3D MFT_REC_FREE) {
+			sbi->mft.next_reserved =3D MFT_REC_FREE;
+			goto out;
+		}
+
+		zlen =3D 1;
+		sbi->mft.next_reserved =3D zbit;
+	} else {
+reserve_mft:
+		zlen =3D zbit =3D=3D MFT_REC_FREE ? (MFT_REC_USER - MFT_REC_FREE) : 4;
+		if (zbit + zlen > wnd->nbits)
+			zlen =3D wnd->nbits - zbit;
+
+		while (zlen > 1 && !wnd_is_free(wnd, zbit, zlen))
+			zlen -=3D 1;
+
+		/* [zbit, zbit + zlen) will be used for Mft itself */
+		from =3D sbi->mft.used;
+		if (from < zbit)
+			from =3D zbit;
+		to =3D zbit + zlen;
+		if (from < to) {
+			ntfs_clear_mft_tail(sbi, from, to);
+			sbi->mft.used =3D to;
+		}
+	}
+
+	if (mft) {
+		*rno =3D zbit;
+		zbit +=3D 1;
+		zlen -=3D 1;
+	}
+
+	wnd_zone_set(wnd, zbit, zlen);
+
+found:
+	if (mft)
+		goto mark_used;
+
+	/* The request to get record for general purpose */
+	if (sbi->mft.next_free < MFT_REC_USER)
+		sbi->mft.next_free =3D MFT_REC_USER;
+
+	for (;;) {
+		if (sbi->mft.next_free >=3D sbi->mft.bitmap.nbits)
+			;
+		else if (!wnd_find(wnd, 1, MFT_REC_USER, 0, &fr))
+			sbi->mft.next_free =3D sbi->mft.bitmap.nbits;
+		else {
+			*rno =3D fr;
+			sbi->mft.next_free =3D *rno + 1;
+			break;
+		}
+
+		err =3D ntfs_extend_mft(sbi);
+		if (err)
+			goto out;
+	}
+
+mark_used:
+
+	if (ni && !ni_add_subrecord(ni, *rno, mi)) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	/* We have found a record that are not reserved for next MFT */
+	if (*rno >=3D MFT_REC_FREE)
+		wnd_set_used(wnd, *rno, 1);
+	else if (*rno >=3D MFT_REC_RESERVED && sbi->mft.reserved_bitmap_inited)
+		__set_bit(*rno - MFT_REC_RESERVED, &sbi->mft.reserved_bitmap);
+
+out:
+	if (!mft)
+		up_write(&wnd->rw_lock);
+
+	return err;
+}
+
+/*
+ * ntfs_mark_rec_free
+ *
+ * marks record as free
+ */
+void ntfs_mark_rec_free(ntfs_sb_info *sbi, CLST rno)
+{
+	wnd_bitmap *wnd =3D &sbi->mft.bitmap;
+
+	down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_MFT);
+	if (rno >=3D wnd->nbits)
+		goto out;
+
+	if (rno >=3D MFT_REC_FREE) {
+		if (!wnd_is_used(wnd, rno, 1))
+			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		else
+			wnd_set_free(wnd, rno, 1);
+	} else if (rno >=3D MFT_REC_RESERVED && sbi->mft.reserved_bitmap_inited)
+		__clear_bit(rno - MFT_REC_RESERVED, &sbi->mft.reserved_bitmap);
+
+	if (rno < wnd_zone_bit(wnd))
+		wnd_zone_set(wnd, rno, 1);
+	else if (rno < sbi->mft.next_free && rno >=3D MFT_REC_USER)
+		sbi->mft.next_free =3D rno;
+
+out:
+	up_write(&wnd->rw_lock);
+}
+
+/*
+ * ntfs_clear_mft_tail
+ *
+ * formats empty records [from, to)
+ * sbi->mft.bitmap is locked for write
+ */
+int ntfs_clear_mft_tail(ntfs_sb_info *sbi, size_t from, size_t to)
+{
+	int err;
+	u32 rs;
+	u64 vbo;
+	struct runs_tree *run;
+	ntfs_inode *ni;
+
+	if (from >=3D to)
+		return 0;
+
+	rs =3D sbi->record_size;
+	ni =3D sbi->mft.ni;
+	run =3D &ni->file.run;
+
+	down_read(&ni->file.run_lock);
+	vbo =3D (u64)from * rs;
+	for (; from < to; from++, vbo +=3D rs) {
+		struct ntfs_buffers nb;
+
+		err =3D ntfs_get_bh(sbi, run, vbo, rs, &nb);
+		if (err)
+			goto out;
+
+		err =3D ntfs_write_bh_ex(sbi, &sbi->new_rec->rhdr, &nb, 0);
+		nb_put(&nb);
+		if (err)
+			goto out;
+	}
+
+out:
+	sbi->mft.used =3D from;
+	up_read(&ni->file.run_lock);
+
+	return err;
+}
+
+/*
+ * ntfs_refresh_zone
+ *
+ * refreshes Mft zone
+ * sbi->used.bitmap is locked for rw
+ * sbi->mft.bitmap is locked for write
+ * sbi->mft.ni->file.run_lock for write
+ */
+int ntfs_refresh_zone(ntfs_sb_info *sbi)
+{
+	CLST zone_limit, zone_max, lcn, vcn, len;
+	size_t lcn_s, zlen;
+	wnd_bitmap *wnd =3D &sbi->used.bitmap;
+	ntfs_inode *ni =3D sbi->mft.ni;
+
+	/* Do not change anything unless we have non empty Mft zone */
+	if (wnd_zone_len(wnd))
+		return 0;
+
+	/*
+	 * Compute the mft zone at two steps
+	 * It would be nice if we are able to allocate
+	 * 1/8 of total clusters for MFT but not more then 512 MB
+	 */
+	zone_limit =3D (512 * 1024 * 1024) >> sbi->cluster_bits;
+	zone_max =3D wnd->nbits >> 3;
+	if (zone_max > zone_limit)
+		zone_max =3D zone_limit;
+
+	vcn =3D bytes_to_cluster(sbi,
+			       (u64)sbi->mft.bitmap.nbits << sbi->record_bits);
+
+	if (!run_lookup_entry(&ni->file.run, vcn - 1, &lcn, &len, NULL))
+		lcn =3D SPARSE_LCN;
+
+	/* We should always find Last Lcn for MFT */
+	if (lcn =3D=3D SPARSE_LCN)
+		return -EINVAL;
+
+	lcn_s =3D lcn + 1;
+
+	/* Try to allocate clusters after last MFT run */
+	zlen =3D wnd_find(wnd, zone_max, lcn_s, 0, &lcn_s);
+	if (!zlen) {
+		ntfs_trace(sbi->sb, "MftZone: unavailable");
+		return 0;
+	}
+
+	/* Truncate too large zone */
+	wnd_zone_set(wnd, lcn_s, zlen);
+
+	return 0;
+}
+
+/*
+ * ntfs_update_mftmirr
+ *
+ * updates $MFTMirr data
+ */
+int ntfs_update_mftmirr(ntfs_sb_info *sbi, int wait)
+{
+	int err;
+	struct super_block *sb =3D sbi->sb;
+	u32 blocksize =3D sb->s_blocksize;
+	struct buffer_head *bh1, *bh2;
+	sector_t block1, block2;
+	u32 bytes;
+
+	if (!(sbi->flags & NTFS_FLAGS_MFTMIRR))
+		return 0;
+
+	bytes =3D sbi->mft.recs_mirr << sbi->record_bits;
+	block1 =3D sbi->mft.lbo >> sb->s_blocksize_bits;
+	block2 =3D sbi->mft.lbo2 >> sb->s_blocksize_bits;
+
+next_bh:
+	bh1 =3D sb_bread(sb, block1);
+	if (!bh1) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	bh2 =3D sb_getblk(sb, block2);
+	if (!bh2) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	memcpy(bh2->b_data, bh1->b_data, blocksize);
+
+	put_bh(bh1);
+	bh1 =3D NULL;
+
+	set_buffer_uptodate(bh2);
+	mark_buffer_dirty(bh2);
+
+	if (wait) {
+		err =3D sync_dirty_buffer(bh2);
+		if (err)
+			goto out;
+	}
+
+	put_bh(bh2);
+	bh2 =3D NULL;
+
+	if (bytes > blocksize) {
+		bytes -=3D blocksize;
+		block1 +=3D 1;
+		block2 +=3D 1;
+		goto next_bh;
+	}
+
+	err =3D 0;
+
+	sbi->flags &=3D ~NTFS_FLAGS_MFTMIRR;
+
+out:
+	if (bh1)
+		put_bh(bh1);
+	if (bh2)
+		put_bh(bh2);
+
+	return err;
+}
+
+/*
+ * ntfs_set_state
+ *
+ * mount: ntfs_set_state(NTFS_DIRTY_DIRTY)
+ * umount: ntfs_set_state(NTFS_DIRTY_CLEAR)
+ * ntfs error: ntfs_set_state(NTFS_DIRTY_ERROR)
+ */
+int ntfs_set_state(ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty)
+{
+	int err;
+	ATTRIB *attr;
+	VOLUME_INFO *info;
+	mft_inode *mi;
+	ntfs_inode *ni;
+
+	/*
+	 * do not change state if fs was real_dirty
+	 * do not change state if fs already dirty(clear)
+	 * do not change any thing if mounted read only
+	 */
+	if (sbi->volume.real_dirty || sb_rdonly(sbi->sb))
+		return 0;
+
+	/* Check cached value */
+	if ((dirty =3D=3D NTFS_DIRTY_CLEAR ? 0 : VOLUME_FLAG_DIRTY) =3D=3D
+	    (sbi->volume.flags & VOLUME_FLAG_DIRTY))
+		return 0;
+
+	ni =3D sbi->volume.ni;
+	if (!ni)
+		return -EINVAL;
+
+	inode_lock(&ni->vfs_inode);
+
+	attr =3D ni_find_attr(ni, NULL, NULL, ATTR_VOL_INFO, NULL, 0, NULL, &mi);
+	if (!attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	info =3D resident_data_ex(attr, SIZEOF_ATTRIBUTE_VOLUME_INFO);
+	if (!info) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	switch (dirty) {
+	case NTFS_DIRTY_ERROR:
+		ntfs_trace(sbi->sb, "Mark volume as dirty due to NTFS errors");
+		sbi->volume.real_dirty =3D true;
+		fallthrough;
+	case NTFS_DIRTY_DIRTY:
+		info->flags |=3D VOLUME_FLAG_DIRTY;
+		break;
+	case NTFS_DIRTY_CLEAR:
+		info->flags &=3D ~VOLUME_FLAG_DIRTY;
+		break;
+	}
+	/* cache current volume flags*/
+	sbi->volume.flags =3D info->flags;
+	mi->dirty =3D true;
+	err =3D 0;
+
+out:
+	inode_unlock(&ni->vfs_inode);
+	if (err)
+		return err;
+
+	mark_inode_dirty(&ni->vfs_inode);
+	/*verify(!ntfs_update_mftmirr()); */
+	err =3D sync_inode_metadata(&ni->vfs_inode, 1);
+
+	return err;
+}
+
+/*
+ * security_hash
+ *
+ * calculates a hash of security descriptor
+ */
+static inline __le32 security_hash(const void *sd, size_t bytes)
+{
+	u32 hash =3D 0;
+	const __le32 *ptr =3D sd;
+
+	bytes >>=3D 2;
+	while (bytes--)
+		hash =3D ((hash >> 0x1D) | (hash << 3)) + le32_to_cpu(*ptr++);
+	return cpu_to_le32(hash);
+}
+
+int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buff=
er)
+{
+	struct block_device *bdev =3D sb->s_bdev;
+	u32 blocksize =3D sb->s_blocksize;
+	u64 block =3D lbo >> sb->s_blocksize_bits;
+	u32 off =3D lbo & (blocksize - 1);
+	u32 op =3D blocksize - off;
+
+	for (; bytes; block +=3D 1, off =3D 0, op =3D blocksize) {
+		struct buffer_head *bh =3D __bread(bdev, block, blocksize);
+
+		if (!bh)
+			return -EIO;
+
+		if (op > bytes)
+			op =3D bytes;
+
+		memcpy(buffer, bh->b_data + off, op);
+
+		put_bh(bh);
+
+		bytes -=3D op;
+		buffer =3D Add2Ptr(buffer, op);
+	}
+
+	return 0;
+}
+
+int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
+		  const void *buf, int wait)
+{
+	u32 blocksize =3D sb->s_blocksize;
+	struct block_device *bdev =3D sb->s_bdev;
+	sector_t block =3D lbo >> sb->s_blocksize_bits;
+	u32 off =3D lbo & (blocksize - 1);
+	u32 op =3D blocksize - off;
+	struct buffer_head *bh;
+
+	if (!wait && (sb->s_flags & SB_SYNCHRONOUS))
+		wait =3D 1;
+
+	for (; bytes; block +=3D 1, off =3D 0, op =3D blocksize) {
+		if (op > bytes)
+			op =3D bytes;
+
+		if (op < blocksize) {
+			bh =3D __bread(bdev, block, blocksize);
+			if (!bh) {
+				ntfs_error(sb, "failed to read block %llx",
+					   (u64)block);
+				return -EIO;
+			}
+		} else {
+			bh =3D __getblk(bdev, block, blocksize);
+			if (!bh)
+				return -ENOMEM;
+		}
+
+		if (buffer_locked(bh))
+			__wait_on_buffer(bh);
+
+		lock_buffer(bh);
+		if (buf) {
+			memcpy(bh->b_data + off, buf, op);
+			buf =3D Add2Ptr(buf, op);
+		} else {
+			memset(bh->b_data + off, -1, op);
+		}
+
+		set_buffer_uptodate(bh);
+		mark_buffer_dirty(bh);
+		unlock_buffer(bh);
+
+		if (wait) {
+			int err =3D sync_dirty_buffer(bh);
+
+			if (err) {
+				ntfs_error(
+					sb,
+					"failed to sync buffer at block %llx, error %d",
+					(u64)block, err);
+				put_bh(bh);
+				return err;
+			}
+		}
+
+		put_bh(bh);
+
+		bytes -=3D op;
+	}
+	return 0;
+}
+
+int ntfs_sb_write_run(ntfs_sb_info *sbi, struct runs_tree *run, u64 vbo,
+		      const void *buf, size_t bytes)
+{
+	struct super_block *sb =3D sbi->sb;
+	u8 cluster_bits =3D sbi->cluster_bits;
+	u32 off =3D vbo & sbi->cluster_mask;
+	CLST lcn, clen;
+	u64 lbo, len;
+	size_t idx;
+
+	if (!run_lookup_entry(run, vbo >> cluster_bits, &lcn, &clen, &idx))
+		return -ENOENT;
+
+	if (lcn =3D=3D SPARSE_LCN)
+		return -EINVAL;
+
+	lbo =3D ((u64)lcn << cluster_bits) + off;
+	len =3D ((u64)clen << cluster_bits) - off;
+
+	for (;;) {
+		u32 op =3D len < bytes ? len : bytes;
+		int err =3D ntfs_sb_write(sb, lbo, op, buf, 0);
+
+		if (err)
+			return err;
+
+		bytes -=3D op;
+		if (!bytes)
+			break;
+
+		if (!run_get_entry(run, ++idx, NULL, &lcn, &clen))
+			return -ENOENT;
+
+		if (lcn =3D=3D SPARSE_LCN)
+			return -EINVAL;
+
+		if (buf)
+			buf =3D Add2Ptr(buf, op);
+
+		lbo =3D ((u64)lcn << cluster_bits) + off;
+		len =3D ((u64)clen << cluster_bits) - off;
+	}
+
+	return 0;
+}
+
+struct buffer_head *ntfs_bread_run(ntfs_sb_info *sbi, struct runs_tree *ru=
n,
+				   u64 vbo)
+{
+	struct super_block *sb =3D sbi->sb;
+	u8 cluster_bits =3D sbi->cluster_bits;
+	CLST lcn;
+	u64 lbo;
+
+	if (!run_lookup_entry(run, vbo >> cluster_bits, &lcn, NULL, NULL))
+		return ERR_PTR(-ENOENT);
+
+	lbo =3D ((u64)lcn << cluster_bits) + (vbo & sbi->cluster_mask);
+
+	return ntfs_bread(sb, lbo >> sb->s_blocksize_bits);
+}
+
+int ntfs_read_run_nb(ntfs_sb_info *sbi, struct runs_tree *run, u64 vbo,
+		     void *buf, u32 bytes, struct ntfs_buffers *nb)
+{
+	int err;
+	struct super_block *sb =3D sbi->sb;
+	u32 blocksize =3D sb->s_blocksize;
+	u8 cluster_bits =3D sbi->cluster_bits;
+	u32 off =3D vbo & sbi->cluster_mask;
+	u32 nbh =3D 0;
+	CLST lcn, clen;
+	u64 lbo, len;
+	size_t idx;
+	struct buffer_head *bh;
+
+	if (!run) {
+		/* first reading of $Volume + $MFTMirr + $LogFile goes here*/
+		if (vbo > MFT_REC_VOL * sbi->record_size) {
+			err =3D -ENOENT;
+			goto out;
+		}
+
+		/* use absolute boot's 'MFTCluster' to read record */
+		lbo =3D vbo + sbi->mft.lbo;
+		len =3D sbi->record_size;
+	} else if (!run_lookup_entry(run, vbo >> cluster_bits, &lcn, &clen,
+				     &idx)) {
+		err =3D -ENOENT;
+		goto out;
+	} else {
+		if (lcn =3D=3D SPARSE_LCN) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		lbo =3D ((u64)lcn << cluster_bits) + off;
+		len =3D ((u64)clen << cluster_bits) - off;
+	}
+
+	off =3D lbo & (blocksize - 1);
+	if (nb) {
+		nb->off =3D off;
+		nb->bytes =3D bytes;
+	}
+
+	for (;;) {
+		u32 len32 =3D len >=3D bytes ? bytes : len;
+		sector_t block =3D lbo >> sb->s_blocksize_bits;
+
+		do {
+			u32 op =3D blocksize - off;
+
+			if (op > len32)
+				op =3D len32;
+
+			bh =3D ntfs_bread(sb, block);
+			if (!bh) {
+				err =3D -EIO;
+				goto out;
+			}
+
+			if (buf) {
+				memcpy(buf, bh->b_data + off, op);
+				buf =3D Add2Ptr(buf, op);
+			}
+
+			if (!nb) {
+				put_bh(bh);
+			} else if (nbh >=3D ARRAY_SIZE(nb->bh)) {
+				err =3D -EINVAL;
+				goto out;
+			} else {
+				nb->bh[nbh++] =3D bh;
+				nb->nbufs =3D nbh;
+			}
+
+			bytes -=3D op;
+			if (!bytes)
+				return 0;
+			len32 -=3D op;
+			block +=3D 1;
+			off =3D 0;
+
+		} while (len32);
+
+		if (!run_get_entry(run, ++idx, NULL, &lcn, &clen)) {
+			err =3D -ENOENT;
+			goto out;
+		}
+
+		if (lcn =3D=3D SPARSE_LCN) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		lbo =3D ((u64)lcn << cluster_bits);
+		len =3D ((u64)clen << cluster_bits);
+	}
+
+out:
+	if (!nbh)
+		return err;
+
+	while (nbh) {
+		put_bh(nb->bh[--nbh]);
+		nb->bh[nbh] =3D NULL;
+	}
+
+	nb->nbufs =3D 0;
+	return err;
+}
+
+/* Returns < 0 if error, 0 if ok, 1 if need to update fixups */
+int ntfs_read_bh_ex(ntfs_sb_info *sbi, struct runs_tree *run, u64 vbo,
+		    NTFS_RECORD_HEADER *rhdr, u32 bytes,
+		    struct ntfs_buffers *nb)
+{
+	int err =3D ntfs_read_run_nb(sbi, run, vbo, rhdr, bytes, nb);
+
+	if (err)
+		return err;
+
+	return ntfs_fix_post_read(rhdr, nb->bytes, true);
+}
+
+int ntfs_get_bh(ntfs_sb_info *sbi, struct runs_tree *run, u64 vbo, u32 byt=
es,
+		struct ntfs_buffers *nb)
+{
+	int err =3D 0;
+	struct super_block *sb =3D sbi->sb;
+	u32 blocksize =3D sb->s_blocksize;
+	u8 cluster_bits =3D sbi->cluster_bits;
+	u32 off;
+	u32 nbh =3D 0;
+	CLST lcn, clen;
+	u64 lbo, len;
+	size_t idx;
+
+	nb->bytes =3D bytes;
+
+	if (!run_lookup_entry(run, vbo >> cluster_bits, &lcn, &clen, &idx)) {
+		err =3D -ENOENT;
+		goto out;
+	}
+
+	off =3D vbo & sbi->cluster_mask;
+	lbo =3D ((u64)lcn << cluster_bits) + off;
+	len =3D ((u64)clen << cluster_bits) - off;
+
+	nb->off =3D off =3D lbo & (blocksize - 1);
+
+	for (;;) {
+		u32 len32 =3D len < bytes ? len : bytes;
+		sector_t block =3D lbo >> sb->s_blocksize_bits;
+
+		do {
+			u32 op;
+			struct buffer_head *bh;
+
+			if (nbh >=3D ARRAY_SIZE(nb->bh)) {
+				err =3D -EINVAL;
+				goto out;
+			}
+
+			op =3D blocksize - off;
+			if (op > len32)
+				op =3D len32;
+
+			if (op =3D=3D blocksize) {
+				bh =3D sb_getblk(sb, block);
+				if (!bh) {
+					err =3D -ENOMEM;
+					goto out;
+				}
+				if (buffer_locked(bh))
+					__wait_on_buffer(bh);
+				set_buffer_uptodate(bh);
+			} else {
+				bh =3D ntfs_bread(sb, block);
+				if (!bh) {
+					err =3D -EIO;
+					goto out;
+				}
+			}
+
+			nb->bh[nbh++] =3D bh;
+			bytes -=3D op;
+			if (!bytes) {
+				nb->nbufs =3D nbh;
+				return 0;
+			}
+
+			block +=3D 1;
+			len32 -=3D op;
+			off =3D 0;
+		} while (len32);
+
+		if (!run_get_entry(run, ++idx, NULL, &lcn, &clen)) {
+			err =3D -ENOENT;
+			goto out;
+		}
+
+		lbo =3D ((u64)lcn << cluster_bits);
+		len =3D ((u64)clen << cluster_bits);
+	}
+
+out:
+	while (nbh) {
+		put_bh(nb->bh[--nbh]);
+		nb->bh[nbh] =3D NULL;
+	}
+
+	nb->nbufs =3D 0;
+
+	return err;
+}
+
+static int ntfs_write_bh(ntfs_sb_info *sbi, const void *buf,
+			 struct ntfs_buffers *nb, int sync)
+
+{
+	int err =3D 0;
+	struct super_block *sb =3D sbi->sb;
+	u32 idx;
+	u32 bytes =3D nb->bytes;
+	u32 off =3D nb->off;
+
+	for (idx =3D 0; bytes; idx +=3D 1, off =3D 0) {
+		u32 op =3D sb->s_blocksize - off;
+		struct buffer_head *bh =3D nb->bh[idx];
+
+		if (!bh)
+			return err;
+
+		if (op > bytes)
+			op =3D bytes;
+		if (buffer_locked(bh))
+			__wait_on_buffer(bh);
+
+		lock_buffer(bh);
+
+		if (buf) {
+			memcpy(Add2Ptr(bh->b_data, off), buf, op);
+			buf =3D Add2Ptr(buf, op);
+		} else {
+			memset(Add2Ptr(bh->b_data, off), 0, op);
+		}
+
+		set_buffer_uptodate(bh);
+		mark_buffer_dirty(bh);
+		unlock_buffer(bh);
+
+		if (sync) {
+			int err2 =3D sync_dirty_buffer(bh);
+
+			if (!err && err2)
+				err =3D err2;
+		}
+
+		bytes -=3D op;
+	}
+
+	return err;
+}
+
+int ntfs_write_bh_ex(ntfs_sb_info *sbi, NTFS_RECORD_HEADER *rhdr,
+		     struct ntfs_buffers *nb, int sync)
+{
+	int err;
+
+	ntfs_fix_pre_write(rhdr, nb->bytes);
+
+	err =3D ntfs_write_bh(sbi, rhdr, nb, sync);
+
+	if (ntfs_fix_post_read(rhdr, nb->bytes, true))
+		err =3D 1;
+
+	return err;
+}
+
+int ntfs_vbo_to_pbo(ntfs_sb_info *sbi, struct runs_tree *run, u64 vbo, u64=
 *pbo,
+		    u64 *bytes)
+{
+	u32 off;
+	CLST lcn, len;
+	u8 cluster_bits =3D sbi->cluster_bits;
+
+	if (!run_lookup_entry(run, vbo >> cluster_bits, &lcn, &len, NULL))
+		return -ENOENT;
+
+	off =3D vbo & sbi->cluster_mask;
+	*pbo =3D lcn =3D=3D SPARSE_LCN ? -1 : (((u64)lcn << cluster_bits) + off);
+	*bytes =3D ((u64)len << cluster_bits) - off;
+
+	return 0;
+}
+
+ntfs_inode *ntfs_new_inode(ntfs_sb_info *sbi, CLST rno, bool dir)
+{
+	int err =3D 0;
+	struct super_block *sb =3D sbi->sb;
+	struct inode *inode =3D new_inode(sb);
+	ntfs_inode *ni;
+
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	ni =3D ntfs_i(inode);
+
+	err =3D mi_format_new(&ni->mi, sbi, rno, dir ? RECORD_FLAG_DIR : 0,
+			    false);
+	if (err)
+		goto out;
+
+	inode->i_ino =3D rno;
+	__insert_inode_hash(inode, rno);
+
+out:
+	if (err) {
+		iput(inode);
+		ni =3D ERR_PTR(err);
+	}
+	return ni;
+}
+
+/* O:BAG:BAD:(A;OICI;FA;;;WD) */
+const u8 s_dir_security[] __aligned(8) =3D {
+	0x01, 0x00, 0x04, 0x80, 0x30, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x02, 0x00, 0x1C, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x03, 0x14, 0x00, 0xFF, 0x01, 0x1F, 0x00,
+	0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x20, 0x00, 0x00, 0x00,
+	0x20, 0x02, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05,
+	0x20, 0x00, 0x00, 0x00, 0x20, 0x02, 0x00, 0x00,
+};
+
+static_assert(sizeof(s_dir_security) =3D=3D 0x50);
+
+const u8 s_file_security[] __aligned(8) =3D {
+	0x01, 0x00, 0x04, 0x94, 0x30, 0x00, 0x00, 0x00, 0x3c, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x02, 0x00,
+	0x1c, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0xff,
+	0x01, 0x1f, 0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x05, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x05, 0x15, 0x00, 0x00, 0x00, 0x1b, 0x70, 0x7d, 0x76, 0x9d,
+	0x84, 0xb0, 0xf7, 0x79, 0x42, 0x1c, 0xeb, 0x01, 0x02, 0x00, 0x00,
+};
+
+static_assert(sizeof(s_file_security) =3D=3D 0x58);
+
+/*
+ * ntfs_security_init
+ *
+ * loads and parse $Secure
+ */
+int ntfs_security_init(ntfs_sb_info *sbi)
+{
+	int err;
+	struct super_block *sb =3D sbi->sb;
+	struct inode *inode;
+	ntfs_inode *ni;
+	MFT_REF ref;
+	ATTRIB *attr;
+	ATTR_LIST_ENTRY *le;
+	u64 sds_size;
+	size_t cnt, off;
+	NTFS_DE *ne;
+	NTFS_DE_SII *sii_e;
+	struct ntfs_fnd *fnd_sii =3D NULL;
+	const INDEX_ROOT *root_sii;
+	const INDEX_ROOT *root_sdh;
+	ntfs_index *indx_sdh =3D &sbi->security.index_sdh;
+	ntfs_index *indx_sii =3D &sbi->security.index_sii;
+
+	ref.low =3D cpu_to_le32(MFT_REC_SECURE);
+	ref.high =3D 0;
+	ref.seq =3D cpu_to_le16(MFT_REC_SECURE);
+
+	inode =3D ntfs_iget5(sb, &ref, &NAME_SECURE);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		ntfs_error(sbi->sb, "Failed to load $Secure.");
+		inode =3D NULL;
+		goto out;
+	}
+
+	ni =3D ntfs_i(inode);
+
+	le =3D NULL;
+
+	attr =3D ni_find_attr(ni, NULL, &le, ATTR_ROOT, SDH_NAME,
+			    ARRAY_SIZE(SDH_NAME), NULL, NULL);
+	if (!attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	root_sdh =3D resident_data(attr);
+	if (root_sdh->type !=3D ATTR_ZERO ||
+	    root_sdh->rule !=3D NTFS_COLLATION_TYPE_SECURITY_HASH) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	err =3D indx_init(indx_sdh, sbi, attr, INDEX_MUTEX_SDH);
+	if (err)
+		goto out;
+
+	attr =3D ni_find_attr(ni, attr, &le, ATTR_ROOT, SII_NAME,
+			    ARRAY_SIZE(SII_NAME), NULL, NULL);
+	if (!attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	root_sii =3D resident_data(attr);
+	if (root_sii->type !=3D ATTR_ZERO ||
+	    root_sii->rule !=3D NTFS_COLLATION_TYPE_UINT) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	err =3D indx_init(indx_sii, sbi, attr, INDEX_MUTEX_SII);
+	if (err)
+		goto out;
+
+	fnd_sii =3D fnd_get(indx_sii);
+	if (!fnd_sii) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	sds_size =3D inode->i_size;
+
+	/* Find the last valid Id */
+	sbi->security.next_id =3D SECURITY_ID_FIRST;
+	/* Always write new security at the end of bucket */
+	sbi->security.next_off =3D
+		Quad2Align(sds_size - SecurityDescriptorsBlockSize);
+
+	cnt =3D 0;
+	off =3D 0;
+	ne =3D NULL;
+
+	for (;;) {
+		u32 next_id;
+
+		err =3D indx_find_raw(indx_sii, ni, root_sii, &ne, &off, fnd_sii);
+		if (err || !ne)
+			break;
+
+		sii_e =3D (NTFS_DE_SII *)ne;
+		if (le16_to_cpu(ne->View.data_size) < SIZEOF_SECURITY_HDR)
+			continue;
+
+		next_id =3D le32_to_cpu(sii_e->sec_id) + 1;
+		if (next_id >=3D sbi->security.next_id)
+			sbi->security.next_id =3D next_id;
+
+		cnt +=3D 1;
+	}
+
+	sbi->security.ni =3D ni;
+	inode =3D NULL;
+out:
+	iput(inode);
+	fnd_put(fnd_sii);
+
+	return err;
+}
+
+/*
+ * ntfs_get_security_by_id
+ *
+ * reads security descriptor by id
+ */
+int ntfs_get_security_by_id(ntfs_sb_info *sbi, u32 security_id, void **sd,
+			    size_t *size)
+{
+	int err;
+	int diff;
+	ntfs_inode *ni =3D sbi->security.ni;
+	ntfs_index *indx =3D &sbi->security.index_sii;
+	void *p =3D NULL;
+	NTFS_DE_SII *sii_e;
+	struct ntfs_fnd *fnd_sii;
+	SECURITY_HDR d_security;
+	const INDEX_ROOT *root_sii;
+	u32 t32;
+
+	*sd =3D NULL;
+
+	inode_lock_shared(&ni->vfs_inode);
+
+	fnd_sii =3D fnd_get(indx);
+	if (!fnd_sii) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	root_sii =3D indx_get_root(indx, ni, NULL, NULL);
+	if (!root_sii) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* Try to find this SECURITY descriptor in SII and SDH indexes */
+	err =3D indx_find(indx, ni, root_sii, &security_id, sizeof(security_id),
+			NULL, &diff, (NTFS_DE **)&sii_e, fnd_sii);
+	if (err)
+		goto out;
+
+	if (diff)
+		goto out;
+
+	t32 =3D le32_to_cpu(sii_e->sec_hdr.size);
+	if (t32 < SIZEOF_SECURITY_HDR) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	*size =3D t32 - SIZEOF_SECURITY_HDR;
+
+	p =3D ntfs_alloc(*size, 0);
+	if (p) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	err =3D ntfs_read_run_nb(sbi, &ni->file.run,
+			       le64_to_cpu(sii_e->sec_hdr.off), &d_security,
+			       sizeof(d_security), NULL);
+	if (err)
+		goto out;
+
+	if (memcmp(&d_security, &sii_e->sec_hdr, SIZEOF_SECURITY_HDR)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	err =3D ntfs_read_run_nb(sbi, &ni->file.run,
+			       le64_to_cpu(sii_e->sec_hdr.off) +
+				       SIZEOF_SECURITY_HDR,
+			       p, *size, NULL);
+	if (err)
+		goto out;
+
+	*sd =3D p;
+	p =3D NULL;
+
+out:
+	ntfs_free(p);
+	fnd_put(fnd_sii);
+	inode_unlock_shared(&ni->vfs_inode);
+
+	return err;
+}
+
+/*
+ * ntfs_insert_security
+ *
+ * inserts security descriptor into $Secure::SDS
+ *
+ * SECURITY Descriptor Stream data is organized into chunks of 256K bytes
+ * and it contains a mirror copy of each security descriptor.  When writin=
g
+ * to a security descriptor at location X, another copy will be written at
+ * location (X+256K).
+ * When writing a security descriptor that will cross the 256K boundary,
+ * the pointer will be advanced by 256K to skip
+ * over the mirror portion.
+ */
+int ntfs_insert_security(ntfs_sb_info *sbi, const void *sd, u32 size_sd,
+			 __le32 *security_id, bool *inserted)
+{
+	int err, diff;
+	ntfs_inode *ni =3D sbi->security.ni;
+	ntfs_index *indx_sdh =3D &sbi->security.index_sdh;
+	ntfs_index *indx_sii =3D &sbi->security.index_sii;
+	NTFS_DE_SDH *e;
+	NTFS_DE_SDH sdh_e;
+	NTFS_DE_SII sii_e;
+	SECURITY_HDR *d_security;
+	u32 new_sec_size =3D size_sd + SIZEOF_SECURITY_HDR;
+	u32 aligned_sec_size =3D Quad2Align(new_sec_size);
+	SECURITY_KEY hash_key;
+	struct ntfs_fnd *fnd_sdh =3D NULL;
+	const INDEX_ROOT *root_sdh;
+	const INDEX_ROOT *root_sii;
+	u64 mirr_off, new_sds_size;
+	u32 used, next, left;
+
+	static_assert((1 << Log2OfSecurityDescriptorsBlockSize) =3D=3D
+		      SecurityDescriptorsBlockSize);
+
+	hash_key.hash =3D security_hash(sd, size_sd);
+	hash_key.sec_id =3D SECURITY_ID_INVALID;
+
+	if (inserted)
+		*inserted =3D false;
+	*security_id =3D SECURITY_ID_INVALID;
+
+	/* Allocate a temporal buffer*/
+	d_security =3D ntfs_alloc(aligned_sec_size, 1);
+	if (!d_security)
+		return -ENOMEM;
+
+	inode_lock(&ni->vfs_inode);
+
+	fnd_sdh =3D fnd_get(indx_sdh);
+	if (!fnd_sdh) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	root_sdh =3D indx_get_root(indx_sdh, ni, NULL, NULL);
+	if (!root_sdh) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	root_sii =3D indx_get_root(indx_sii, ni, NULL, NULL);
+	if (!root_sii) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Check if such security already exists
+	 * use "SDH" and hash -> to get the offset in "SDS"
+	 */
+	err =3D indx_find(indx_sdh, ni, root_sdh, &hash_key, sizeof(hash_key),
+			&d_security->key.sec_id, &diff, (NTFS_DE **)&e,
+			fnd_sdh);
+	if (err)
+		goto out;
+
+	while (e) {
+		if (le32_to_cpu(e->sec_hdr.size) =3D=3D new_sec_size) {
+			err =3D ntfs_read_run_nb(sbi, &ni->file.run,
+					       le64_to_cpu(e->sec_hdr.off),
+					       d_security, new_sec_size, NULL);
+			if (err)
+				goto out;
+
+			if (le32_to_cpu(d_security->size) =3D=3D new_sec_size &&
+			    d_security->key.hash =3D=3D hash_key.hash &&
+			    !memcmp(d_security + 1, sd, size_sd)) {
+				*security_id =3D d_security->key.sec_id;
+				/*such security already exists*/
+				err =3D 0;
+				goto out;
+			}
+		}
+
+		err =3D indx_find_sort(indx_sdh, ni, root_sdh, (NTFS_DE **)&e,
+				     fnd_sdh);
+		if (err)
+			goto out;
+
+		if (!e || e->key.hash !=3D hash_key.hash)
+			break;
+	}
+
+	/* Zero unused space */
+	next =3D sbi->security.next_off & (SecurityDescriptorsBlockSize - 1);
+	left =3D SecurityDescriptorsBlockSize - next;
+
+	/* Zero gap until SecurityDescriptorsBlockSize */
+	if (left < new_sec_size) {
+		/* zero "left" bytes from sbi->security.next_off */
+		sbi->security.next_off +=3D SecurityDescriptorsBlockSize + left;
+	}
+
+	/* Zero tail of previous security */
+	used =3D ni->vfs_inode.i_size & (SecurityDescriptorsBlockSize - 1);
+
+	/*
+	 * Example:
+	 * 0x40438 =3D=3D ni->vfs_inode.i_size
+	 * 0x00440 =3D=3D sbi->security.next_off
+	 * need to zero [0x438-0x440)
+	 * if (next > used) {
+	 *  u32 tozero =3D next - used;
+	 *  zero "tozero" bytes from sbi->security.next_off - tozero
+	 */
+
+	/* format new security descriptor */
+	d_security->key.hash =3D hash_key.hash;
+	d_security->key.sec_id =3D cpu_to_le32(sbi->security.next_id);
+	d_security->off =3D cpu_to_le64(sbi->security.next_off);
+	d_security->size =3D cpu_to_le32(new_sec_size);
+	memcpy(d_security + 1, sd, size_sd);
+
+	/* Write main SDS bucket */
+	err =3D ntfs_sb_write_run(sbi, &ni->file.run, sbi->security.next_off,
+				d_security, aligned_sec_size);
+
+	if (err)
+		goto out;
+
+	mirr_off =3D sbi->security.next_off + SecurityDescriptorsBlockSize;
+	new_sds_size =3D mirr_off + aligned_sec_size;
+
+	if (new_sds_size > ni->vfs_inode.i_size) {
+		err =3D attr_set_size(ni, ATTR_DATA, SDS_NAME,
+				    ARRAY_SIZE(SDS_NAME), &ni->file.run,
+				    new_sds_size, &new_sds_size, false, NULL);
+		if (err)
+			goto out;
+	}
+
+	/* Write copy SDS bucket */
+	err =3D ntfs_sb_write_run(sbi, &ni->file.run, mirr_off, d_security,
+				aligned_sec_size);
+	if (err)
+		goto out;
+
+	/* Fill SII entry */
+	sii_e.de.View.data_off =3D cpu_to_le16(offsetof(NTFS_DE_SII, sec_hdr));
+	sii_e.de.View.data_size =3D cpu_to_le16(SIZEOF_SECURITY_HDR);
+	sii_e.de.View.Res =3D 0; //??
+	sii_e.de.size =3D cpu_to_le16(SIZEOF_SII_DIRENTRY);
+	sii_e.de.key_size =3D cpu_to_le16(sizeof(d_security->key.sec_id));
+	sii_e.de.flags =3D 0;
+	sii_e.de.Reserved =3D 0;
+	sii_e.sec_id =3D d_security->key.sec_id;
+	memcpy(&sii_e.sec_hdr, d_security, SIZEOF_SECURITY_HDR);
+
+	err =3D indx_insert_entry(indx_sii, ni, &sii_e.de, NULL, NULL);
+	if (err)
+		goto out;
+
+	/* Fill SDH entry */
+	sdh_e.de.View.data_off =3D cpu_to_le16(offsetof(NTFS_DE_SDH, sec_hdr));
+	sdh_e.de.View.data_size =3D cpu_to_le16(SIZEOF_SECURITY_HDR);
+	sdh_e.de.View.Res =3D 0;
+	sdh_e.de.size =3D cpu_to_le16(SIZEOF_SDH_DIRENTRY);
+	sdh_e.de.key_size =3D cpu_to_le16(sizeof(sdh_e.key));
+	sdh_e.de.flags =3D 0;
+	sdh_e.de.Reserved =3D 0;
+	sdh_e.key.hash =3D d_security->key.hash;
+	sdh_e.key.sec_id =3D d_security->key.sec_id;
+	memcpy(&sdh_e.sec_hdr, d_security, SIZEOF_SECURITY_HDR);
+	sdh_e.magic[0] =3D cpu_to_le16('I');
+	sdh_e.magic[1] =3D cpu_to_le16('I');
+
+	fnd_clear(fnd_sdh);
+	err =3D indx_insert_entry(indx_sdh, ni, &sdh_e.de, (void *)(size_t)1,
+				fnd_sdh);
+	if (err)
+		goto out;
+
+	*security_id =3D d_security->key.sec_id;
+	if (inserted)
+		*inserted =3D true;
+
+	/* Update Id and offset for next descriptor */
+	sbi->security.next_id +=3D 1;
+	sbi->security.next_off +=3D aligned_sec_size;
+
+out:
+	fnd_put(fnd_sdh);
+	inode_unlock(&ni->vfs_inode);
+	ntfs_free(d_security);
+
+	return err;
+}
+
+/*
+ * ntfs_reparse_init
+ *
+ * loads and parse $Extend/$Reparse
+ */
+int ntfs_reparse_init(ntfs_sb_info *sbi)
+{
+	int err;
+	ntfs_inode *ni =3D sbi->reparse.ni;
+	ntfs_index *indx =3D &sbi->reparse.index_r;
+	ATTRIB *attr;
+	ATTR_LIST_ENTRY *le;
+	const INDEX_ROOT *root_r;
+
+	if (!ni)
+		return 0;
+
+	le =3D NULL;
+	attr =3D ni_find_attr(ni, NULL, &le, ATTR_ROOT, SR_NAME,
+			    ARRAY_SIZE(SR_NAME), NULL, NULL);
+	if (!attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	root_r =3D resident_data(attr);
+	if (root_r->type !=3D ATTR_ZERO ||
+	    root_r->rule !=3D NTFS_COLLATION_TYPE_UINTS) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	err =3D indx_init(indx, sbi, attr, INDEX_MUTEX_SR);
+	if (err)
+		goto out;
+
+out:
+	return err;
+}
+
+/*
+ * ntfs_objid_init
+ *
+ * loads and parse $Extend/$ObjId
+ */
+int ntfs_objid_init(ntfs_sb_info *sbi)
+{
+	int err;
+	ntfs_inode *ni =3D sbi->objid.ni;
+	ntfs_index *indx =3D &sbi->objid.index_o;
+	ATTRIB *attr;
+	ATTR_LIST_ENTRY *le;
+	const INDEX_ROOT *root;
+
+	if (!ni)
+		return 0;
+
+	le =3D NULL;
+	attr =3D ni_find_attr(ni, NULL, &le, ATTR_ROOT, SO_NAME,
+			    ARRAY_SIZE(SO_NAME), NULL, NULL);
+	if (!attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	root =3D resident_data(attr);
+	if (root->type !=3D ATTR_ZERO ||
+	    root->rule !=3D NTFS_COLLATION_TYPE_UINTS) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	err =3D indx_init(indx, sbi, attr, INDEX_MUTEX_SO);
+	if (err)
+		goto out;
+
+out:
+	return err;
+}
+
+int ntfs_objid_remove(ntfs_sb_info *sbi, GUID *guid)
+{
+	int err;
+	ntfs_inode *ni =3D sbi->objid.ni;
+	ntfs_index *indx =3D &sbi->objid.index_o;
+
+	if (!ni)
+		return -EINVAL;
+
+	inode_lock(&ni->vfs_inode);
+
+	err =3D indx_delete_entry(indx, ni, guid, sizeof(*guid), NULL);
+
+	inode_unlock(&ni->vfs_inode);
+
+	return err;
+}
+
+int ntfs_insert_reparse(ntfs_sb_info *sbi, __le32 rtag, const MFT_REF *ref=
)
+{
+	int err;
+	ntfs_inode *ni =3D sbi->reparse.ni;
+	ntfs_index *indx =3D &sbi->reparse.index_r;
+	NTFS_DE_R re;
+
+	if (!ni)
+		return -EINVAL;
+
+	memset(&re, 0, sizeof(re));
+
+	re.Key.ReparseTag =3D rtag;
+	memcpy(&re.Key.ref, ref, sizeof(*ref));
+
+	re.de.View.data_off =3D cpu_to_le16(offsetof(NTFS_DE_R, Key));
+	re.de.size =3D cpu_to_le16(QuadAlign(SIZEOF_R_DIRENTRY));
+	re.de.key_size =3D cpu_to_le16(sizeof(re.Key));
+
+	inode_lock(&ni->vfs_inode);
+
+	err =3D indx_insert_entry(indx, ni, &re.de, NULL, NULL);
+
+	inode_unlock(&ni->vfs_inode);
+
+	return err;
+}
+
+int ntfs_remove_reparse(ntfs_sb_info *sbi, __le32 rtag, const MFT_REF *ref=
)
+{
+	int err;
+	ntfs_inode *ni =3D sbi->reparse.ni;
+	ntfs_index *indx =3D &sbi->reparse.index_r;
+	REPARSE_KEY rkey;
+	int diff;
+	NTFS_DE_R *re;
+	struct ntfs_fnd *fnd =3D NULL;
+	INDEX_ROOT *root_r;
+
+	if (!ni)
+		return -EINVAL;
+
+	rkey.ReparseTag =3D rtag;
+	rkey.ref =3D *ref;
+
+	inode_lock(&ni->vfs_inode);
+
+	if (rtag) {
+		err =3D indx_delete_entry(indx, ni, &rkey, sizeof(rkey), NULL);
+		goto out1;
+	}
+
+	fnd =3D fnd_get(indx);
+	if (!fnd) {
+		err =3D -ENOMEM;
+		goto out1;
+	}
+
+	root_r =3D indx_get_root(indx, ni, NULL, NULL);
+	if (!root_r) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	err =3D indx_find(indx, ni, root_r, &rkey, sizeof(rkey), NULL, &diff,
+			(NTFS_DE **)&re, fnd);
+	if (err)
+		goto out;
+
+	if (memcmp(&re->Key.ref, ref, sizeof(*ref)))
+		goto out;
+
+	memcpy(&rkey, &re->Key, sizeof(rkey));
+
+	fnd_put(fnd);
+	fnd =3D NULL;
+
+	err =3D indx_delete_entry(indx, ni, &rkey, sizeof(rkey), NULL);
+	if (err)
+		goto out;
+
+out:
+	fnd_put(fnd);
+
+out1:
+	inode_unlock(&ni->vfs_inode);
+
+	return err;
+}
+
+static inline void ntfs_unmap_and_discard(ntfs_sb_info *sbi, CLST lcn, CLS=
T len)
+{
+	ntfs_unmap_meta(sbi->sb, lcn, len);
+	ntfs_discard(sbi, lcn, len);
+}
+
+void mark_as_free_ex(ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim)
+{
+	CLST end, i;
+	wnd_bitmap *wnd =3D &sbi->used.bitmap;
+
+	down_write_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
+	if (!wnd_is_used(wnd, lcn, len)) {
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+
+		end =3D lcn + len;
+		len =3D 0;
+		for (i =3D lcn; i < end; i++) {
+			if (wnd_is_used(wnd, i, 1)) {
+				if (!len)
+					lcn =3D i;
+				len +=3D 1;
+				continue;
+			}
+
+			if (!len)
+				continue;
+
+			if (trim)
+				ntfs_unmap_and_discard(sbi, lcn, len);
+
+			wnd_set_free(wnd, lcn, len);
+			len =3D 0;
+		}
+
+		if (!len)
+			goto out;
+	}
+
+	if (trim)
+		ntfs_unmap_and_discard(sbi, lcn, len);
+	wnd_set_free(wnd, lcn, len);
+
+out:
+	up_write(&wnd->rw_lock);
+}
+
+/*
+ * run_deallocate
+ *
+ * deallocate clusters
+ */
+int run_deallocate(ntfs_sb_info *sbi, struct runs_tree *run, bool trim)
+{
+	CLST lcn, len;
+	size_t idx =3D 0;
+
+	while (run_get_entry(run, idx++, NULL, &lcn, &len)) {
+		if (lcn =3D=3D SPARSE_LCN)
+			continue;
+
+		mark_as_free_ex(sbi, lcn, len, trim);
+	}
+
+	return 0;
+}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
new file mode 100644
index 000000000000..1c1903b2c670
--- /dev/null
+++ b/fs/ntfs3/index.c
@@ -0,0 +1,2640 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/index.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/nls.h>
+#include <linux/sched/signal.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+static const struct INDEX_NAMES {
+	const __le16 *name;
+	u8 name_len;
+} s_index_names[INDEX_MUTEX_TOTAL] =3D {
+	{ I30_NAME, ARRAY_SIZE(I30_NAME) }, { SII_NAME, ARRAY_SIZE(SII_NAME) },
+	{ SDH_NAME, ARRAY_SIZE(SDH_NAME) }, { SO_NAME, ARRAY_SIZE(SO_NAME) },
+	{ SQ_NAME, ARRAY_SIZE(SQ_NAME) },   { SR_NAME, ARRAY_SIZE(SR_NAME) },
+};
+
+static int cmp_fnames(const ATTR_FILE_NAME *f1, size_t l1,
+		      const ATTR_FILE_NAME *f2, size_t l2,
+		      const ntfs_sb_info *sbi)
+{
+	int diff;
+	u16 fsize2;
+	const u16 *upcase =3D sbi->upcase;
+	const struct cpu_str *s1;
+	const struct le_str *s2;
+
+	if (l2 <=3D offsetof(ATTR_FILE_NAME, name))
+		return -1;
+
+	fsize2 =3D fname_full_size(f2);
+	if (l2 < fsize2)
+		return -1;
+
+	if (l1)
+		goto compare_fnames;
+
+	s1 =3D (struct cpu_str *)f1;
+	s2 =3D (struct le_str *)&f2->name_len;
+
+	diff =3D ntfs_cmp_names_cpu(s1, s2, upcase);
+
+	if (diff)
+		goto out1;
+
+	/*
+	 * If names are equal (case insensitive)
+	 * try to compare it case sensitive
+	 */
+	if (/*sbi->options.nocase || */ f2->type =3D=3D FILE_NAME_DOS)
+		goto out1;
+
+	diff =3D ntfs_cmp_names_cpu(s1, s2, NULL);
+
+out1:
+	return diff;
+
+compare_fnames:
+
+	diff =3D ntfs_cmp_names(f1->name, f1->name_len, f2->name, f2->name_len,
+			      upcase);
+
+	if (diff)
+		goto out2;
+
+	/*
+	 * If names are equal (case insensitive)
+	 * try to compare it case sensitive
+	 */
+	if (/*sbi->options.nocase || */ f2->type =3D=3D FILE_NAME_DOS)
+		goto out2;
+
+	diff =3D ntfs_cmp_names(f1->name, f1->name_len, f2->name, f2->name_len,
+			      NULL);
+
+out2:
+	return diff;
+}
+
+static int cmp_uint(const u32 *k1, size_t l1, const u32 *k2, size_t l2,
+		    const void *p)
+{
+	if (l2 < sizeof(u32))
+		return -1;
+
+	if (*k1 < *k2)
+		return -1;
+	if (*k1 > *k2)
+		return 1;
+	return 0;
+}
+
+static int cmp_sdh(const SECURITY_KEY *k1, size_t l1, const SECURITY_KEY *=
k2,
+		   size_t l2, const void *p)
+{
+	u32 t1, t2;
+
+	if (l2 < sizeof(SECURITY_KEY))
+		return -1;
+
+	t1 =3D le32_to_cpu(k1->hash);
+	t2 =3D le32_to_cpu(k2->hash);
+
+	/* First value is a hash value itself */
+	if (t1 < t2)
+		return -1;
+	if (t1 > t2)
+		return 1;
+
+	/* Second value is security Id */
+	if (p) {
+		t1 =3D le32_to_cpu(k1->sec_id);
+		t2 =3D le32_to_cpu(k2->sec_id);
+		if (t1 < t2)
+			return -1;
+		if (t1 > t2)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int cmp_uints(const __le32 *k1, size_t l1, const __le32 *k2, size_t=
 l2,
+		     const void *p)
+{
+	size_t count;
+
+	if (l2 < sizeof(int))
+		return -1;
+
+	for (count =3D min(l1, l2) >> 2; count > 0; --count, ++k1, ++k2) {
+		u32 t1 =3D le32_to_cpu(*k1);
+		u32 t2 =3D le32_to_cpu(*k2);
+
+		if (t1 > t2)
+			return 1;
+		if (t1 < t2)
+			return -1;
+	}
+
+	if (l1 > l2)
+		return 1;
+	if (l1 < l2)
+		return -1;
+
+	return 0;
+}
+
+static inline NTFS_CMP_FUNC get_cmp_func(const INDEX_ROOT *root)
+{
+	switch (root->type) {
+	case ATTR_NAME:
+		if (root->rule =3D=3D NTFS_COLLATION_TYPE_FILENAME)
+			return (NTFS_CMP_FUNC)&cmp_fnames;
+		break;
+	case ATTR_ZERO:
+		switch (root->rule) {
+		case NTFS_COLLATION_TYPE_UINT:
+			return (NTFS_CMP_FUNC)&cmp_uint;
+		case NTFS_COLLATION_TYPE_SECURITY_HASH:
+			return (NTFS_CMP_FUNC)&cmp_sdh;
+		case NTFS_COLLATION_TYPE_UINTS:
+			return (NTFS_CMP_FUNC)&cmp_uints;
+		default:
+			break;
+		}
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
+struct bmp_buf {
+	ATTRIB *b;
+	mft_inode *mi;
+	struct buffer_head *bh;
+	ulong *buf;
+	size_t bit;
+	u32 nbits;
+	u64 new_valid;
+};
+
+static int bmp_buf_get(ntfs_index *indx, ntfs_inode *ni, size_t bit,
+		       struct bmp_buf *bbuf)
+{
+	ATTRIB *b;
+	size_t data_size, valid_size, vbo, off =3D bit >> 3;
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+	CLST vcn =3D off >> sbi->cluster_bits;
+	ATTR_LIST_ENTRY *le =3D NULL;
+	struct buffer_head *bh;
+	struct super_block *sb;
+	u32 blocksize;
+	const struct INDEX_NAMES *in =3D &s_index_names[indx->type];
+
+	bbuf->bh =3D NULL;
+
+	b =3D ni_find_attr(ni, NULL, &le, ATTR_BITMAP, in->name, in->name_len,
+			 &vcn, &bbuf->mi);
+	bbuf->b =3D b;
+	if (!b)
+		return -EINVAL;
+
+	if (!b->non_res) {
+		data_size =3D le32_to_cpu(b->res.data_size);
+
+		if (off >=3D data_size)
+			return -EINVAL;
+
+		bbuf->buf =3D (ulong *)resident_data(b);
+		bbuf->bit =3D 0;
+		bbuf->nbits =3D data_size * 8;
+
+		return 0;
+	}
+
+	data_size =3D le64_to_cpu(b->nres.data_size);
+	if (off >=3D data_size) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	valid_size =3D le64_to_cpu(b->nres.valid_size);
+
+	bh =3D ntfs_bread_run(sbi, &indx->bitmap_run, off);
+	if (!bh)
+		return -EIO;
+
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+
+	bbuf->bh =3D bh;
+
+	if (buffer_locked(bh))
+		__wait_on_buffer(bh);
+
+	lock_buffer(bh);
+
+	sb =3D sbi->sb;
+	blocksize =3D sb->s_blocksize;
+
+	vbo =3D off & ~(size_t)sbi->block_mask;
+
+	bbuf->new_valid =3D vbo + blocksize;
+	if (bbuf->new_valid <=3D valid_size)
+		bbuf->new_valid =3D 0;
+	else if (bbuf->new_valid > data_size)
+		bbuf->new_valid =3D data_size;
+
+	if (vbo >=3D valid_size) {
+		memset(bh->b_data, 0, blocksize);
+	} else if (vbo + blocksize > valid_size) {
+		u32 voff =3D valid_size & sbi->block_mask;
+
+		memset(bh->b_data + voff, 0, blocksize - voff);
+	}
+
+	bbuf->buf =3D (ulong *)bh->b_data;
+	bbuf->bit =3D 8 * (off & ~(size_t)sbi->block_mask);
+	bbuf->nbits =3D 8 * blocksize;
+
+	return 0;
+}
+
+static void bmp_buf_put(struct bmp_buf *bbuf, bool dirty)
+{
+	struct buffer_head *bh =3D bbuf->bh;
+	ATTRIB *b =3D bbuf->b;
+
+	if (!bh) {
+		if (b && !b->non_res && dirty)
+			bbuf->mi->dirty =3D true;
+		return;
+	}
+
+	if (!dirty)
+		goto out;
+
+	if (bbuf->new_valid) {
+		b->nres.valid_size =3D cpu_to_le64(bbuf->new_valid);
+		bbuf->mi->dirty =3D true;
+	}
+
+	set_buffer_uptodate(bh);
+	mark_buffer_dirty(bh);
+
+out:
+	unlock_buffer(bh);
+	put_bh(bh);
+}
+
+/*
+ * indx_mark_used
+ *
+ * marks the bit 'bit' as used
+ */
+static int indx_mark_used(ntfs_index *indx, ntfs_inode *ni, size_t bit)
+{
+	int err;
+	struct bmp_buf bbuf;
+
+	err =3D bmp_buf_get(indx, ni, bit, &bbuf);
+	if (err)
+		return err;
+
+	__set_bit(bit - bbuf.bit, bbuf.buf);
+
+	bmp_buf_put(&bbuf, true);
+
+	return 0;
+}
+
+/*
+ * indx_mark_free
+ *
+ * the bit 'bit' as free
+ */
+static int indx_mark_free(ntfs_index *indx, ntfs_inode *ni, size_t bit)
+{
+	int err;
+	struct bmp_buf bbuf;
+
+	err =3D bmp_buf_get(indx, ni, bit, &bbuf);
+	if (err)
+		return err;
+
+	__clear_bit(bit - bbuf.bit, bbuf.buf);
+
+	bmp_buf_put(&bbuf, true);
+
+	return 0;
+}
+
+static int scan_nres_bitmap(ntfs_sb_info *sbi, ATTRIB *bitmap,
+			    struct runs_tree *run, size_t from,
+			    bool (*fn)(const ulong *buf, u32 bit, u32 bits,
+				       size_t *ret),
+			    size_t *ret)
+{
+	struct super_block *sb =3D sbi->sb;
+	u32 nbits =3D sb->s_blocksize * 8;
+	u32 blocksize =3D sb->s_blocksize;
+	u64 valid_size =3D le64_to_cpu(bitmap->nres.valid_size);
+	u64 data_size =3D le64_to_cpu(bitmap->nres.data_size);
+	sector_t eblock =3D bytes_to_block(sb, data_size);
+	size_t vbo =3D from >> 3;
+	sector_t blk =3D (vbo & sbi->cluster_mask) >> sb->s_blocksize_bits;
+	sector_t vblock =3D vbo >> sb->s_blocksize_bits;
+	sector_t blen, block;
+	CLST lcn, len;
+	size_t idx;
+	struct buffer_head *bh;
+
+	*ret =3D MINUS_ONE_T;
+
+	if (vblock >=3D eblock)
+		return 0;
+
+	from &=3D nbits - 1;
+
+	if (!run_lookup_entry(run, vbo >> sbi->cluster_bits, &lcn, &len,
+			      &idx)) {
+		return -ENOENT;
+	}
+
+	blen =3D (sector_t)len * sbi->blocks_per_cluster;
+	block =3D (sector_t)lcn * sbi->blocks_per_cluster;
+
+next_run:
+	for (; blk < blen; blk++, from =3D 0) {
+		bool ok;
+
+		bh =3D ntfs_bread(sb, block + blk);
+
+		if (!bh)
+			return -EIO;
+
+		vbo =3D (u64)vblock << sb->s_blocksize_bits;
+		if (vbo >=3D valid_size)
+			memset(bh->b_data, 0, blocksize);
+		else if (vbo + blocksize > valid_size) {
+			u32 voff =3D valid_size & sbi->block_mask;
+
+			memset(bh->b_data + voff, 0, blocksize - voff);
+		}
+
+		if (vbo + blocksize > data_size)
+			nbits =3D 8 * (data_size - vbo);
+
+		ok =3D nbits > from ?
+			     (*fn)((ulong *)bh->b_data, from, nbits, ret) :
+			     false;
+		put_bh(bh);
+
+		if (ok) {
+			*ret +=3D 8 * vbo;
+			return 0;
+		}
+
+		if (++vblock >=3D eblock) {
+			*ret =3D MINUS_ONE_T;
+			return 0;
+		}
+	}
+
+	if (!run_get_entry(run, ++idx, NULL, &lcn, &len))
+		return -ENOENT;
+
+	blk =3D 0;
+	blen =3D (sector_t)len * sbi->blocks_per_cluster;
+	block =3D (sector_t)lcn * sbi->blocks_per_cluster;
+	goto next_run;
+}
+
+static bool scan_for_free(const ulong *buf, u32 bit, u32 bits, size_t *ret=
)
+{
+	size_t pos =3D find_next_zero_bit(buf, bits, bit);
+
+	if (pos >=3D bits)
+		return false;
+	*ret =3D pos;
+	return true;
+}
+
+/*
+ * indx_find_free
+ *
+ * looks for free bit
+ * returns -1 if no free bits
+ */
+static int indx_find_free(ntfs_index *indx, ntfs_inode *ni, size_t *bit,
+			  ATTRIB **bitmap)
+{
+	ATTRIB *b;
+	ATTR_LIST_ENTRY *le =3D NULL;
+	const struct INDEX_NAMES *in =3D &s_index_names[indx->type];
+
+	b =3D ni_find_attr(ni, NULL, &le, ATTR_BITMAP, in->name, in->name_len,
+			 NULL, NULL);
+
+	if (!b)
+		return -ENOENT;
+
+	*bitmap =3D b;
+	*bit =3D MINUS_ONE_T;
+
+	if (!b->non_res) {
+		u32 nbits =3D 8 * le32_to_cpu(b->res.data_size);
+		size_t pos =3D find_next_zero_bit(resident_data(b), nbits, 0);
+
+		if (pos < nbits)
+			*bit =3D pos;
+	} else {
+		int err =3D scan_nres_bitmap(ni->mi.sbi, b, &indx->bitmap_run, 0,
+					   &scan_for_free, bit);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static bool scan_for_used(const ulong *buf, u32 bit, u32 bits, size_t *ret=
)
+{
+	size_t pos =3D find_next_bit(buf, bits, bit);
+
+	if (pos >=3D bits)
+		return false;
+	*ret =3D pos;
+	return true;
+}
+
+/*
+ * indx_used_bit
+ *
+ * looks for used bit
+ * returns MINUS_ONE_T if no used bits
+ */
+int indx_used_bit(ntfs_index *indx, ntfs_inode *ni, size_t *bit)
+{
+	ATTRIB *b;
+	ATTR_LIST_ENTRY *le =3D NULL;
+	size_t from =3D *bit;
+	const struct INDEX_NAMES *in =3D &s_index_names[indx->type];
+
+	b =3D ni_find_attr(ni, NULL, &le, ATTR_BITMAP, in->name, in->name_len,
+			 NULL, NULL);
+
+	if (!b)
+		return -ENOENT;
+
+	*bit =3D MINUS_ONE_T;
+
+	if (!b->non_res) {
+		u32 nbits =3D le32_to_cpu(b->res.data_size) * 8;
+		size_t pos =3D find_next_bit(resident_data(b), nbits, from);
+
+		if (pos < nbits)
+			*bit =3D pos;
+	} else {
+		int err =3D scan_nres_bitmap(ni->mi.sbi, b, &indx->bitmap_run,
+					   from, &scan_for_used, bit);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * hdr_find_split
+ *
+ * finds a point at which the index allocation buffer would like to
+ * be split.
+ * NOTE: This function should never return 'END' entry NULL returns on err=
or
+ */
+static inline const NTFS_DE *hdr_find_split(const INDEX_HDR *hdr)
+{
+	size_t o;
+	const NTFS_DE *e =3D hdr_first_de(hdr);
+	u32 used_2 =3D le32_to_cpu(hdr->used) >> 1;
+	u16 esize =3D le16_to_cpu(e->size);
+
+	if (!e || de_is_last(e))
+		return NULL;
+
+	for (o =3D le32_to_cpu(hdr->de_off) + esize; o < used_2; o +=3D esize) {
+		const NTFS_DE *p =3D e;
+
+		e =3D Add2Ptr(hdr, o);
+
+		/* We must not return END entry */
+		if (de_is_last(e))
+			return p;
+
+		esize =3D le16_to_cpu(e->size);
+	}
+
+	return e;
+}
+
+/*
+ * hdr_insert_head
+ *
+ * inserts some entries at the beginning of the buffer.
+ * It is used to insert entries into a newly-created buffer.
+ */
+static inline const NTFS_DE *hdr_insert_head(INDEX_HDR *hdr, const void *i=
ns,
+					     u32 ins_bytes)
+{
+	u32 to_move;
+	NTFS_DE *e =3D hdr_first_de(hdr);
+	u32 used =3D le32_to_cpu(hdr->used);
+
+	if (!e)
+		return NULL;
+
+	/* Now we just make room for the inserted entries and jam it in. */
+	to_move =3D used - le32_to_cpu(hdr->de_off);
+	memmove(Add2Ptr(e, ins_bytes), e, to_move);
+	memcpy(e, ins, ins_bytes);
+	hdr->used =3D cpu_to_le32(used + ins_bytes);
+
+	return e;
+}
+
+void fnd_clear(struct ntfs_fnd *fnd)
+{
+	int i;
+
+	for (i =3D 0; i < fnd->level; i++) {
+		struct indx_node *n =3D fnd->nodes[i];
+
+		if (!n)
+			continue;
+
+		put_indx_node(n);
+		fnd->nodes[i] =3D NULL;
+	}
+	fnd->level =3D 0;
+	fnd->root_de =3D NULL;
+}
+
+static int fnd_push(struct ntfs_fnd *fnd, struct indx_node *n, NTFS_DE *e)
+{
+	int i;
+
+	i =3D fnd->level;
+	if (i < 0 || i >=3D ARRAY_SIZE(fnd->nodes))
+		return -EINVAL;
+	fnd->nodes[i] =3D n;
+	fnd->de[i] =3D e;
+	fnd->level +=3D 1;
+	return 0;
+}
+
+static struct indx_node *fnd_pop(struct ntfs_fnd *fnd)
+{
+	struct indx_node *n;
+	int i =3D fnd->level;
+
+	i -=3D 1;
+	n =3D fnd->nodes[i];
+	fnd->nodes[i] =3D NULL;
+	fnd->level =3D i;
+
+	return n;
+}
+
+static bool fnd_is_empty(struct ntfs_fnd *fnd)
+{
+	if (!fnd->level)
+		return !fnd->root_de;
+
+	return !fnd->de[fnd->level - 1];
+}
+
+struct ntfs_fnd *fnd_get(ntfs_index *indx)
+{
+	struct ntfs_fnd *fnd =3D ntfs_alloc(sizeof(struct ntfs_fnd), 1);
+
+	if (!fnd)
+		return NULL;
+
+	return fnd;
+}
+
+void fnd_put(struct ntfs_fnd *fnd)
+{
+	if (!fnd)
+		return;
+	fnd_clear(fnd);
+	ntfs_free(fnd);
+}
+
+/*
+ * hdr_find_e
+ *
+ * locates an entry the index buffer.
+ * If no matching entry is found, it returns the first entry which is grea=
ter
+ * than the desired entry If the search key is greater than all the entrie=
s the
+ * buffer, it returns the 'end' entry. This function does a binary search =
of the
+ * current index buffer, for the first entry that is <=3D to the search va=
lue
+ * Returns NULL if error
+ */
+static NTFS_DE *hdr_find_e(const ntfs_index *indx, const INDEX_HDR *hdr,
+			   const void *key, size_t key_len, const void *ctx,
+			   int *diff)
+{
+	NTFS_DE *e;
+	NTFS_CMP_FUNC cmp =3D indx->cmp;
+	u32 e_size, e_key_len;
+	u32 end =3D le32_to_cpu(hdr->used);
+	u32 off =3D le32_to_cpu(hdr->de_off);
+
+#ifdef NTFS3_INDEX_BINARY_SEARCH
+	int max_idx =3D 0, fnd, min_idx;
+	int nslots =3D 64;
+	u16 *offs;
+
+	if (end > 0x10000)
+		goto next;
+
+	offs =3D ntfs_alloc(sizeof(u16) * nslots, 0);
+	if (!offs)
+		goto next;
+
+	/* use binary search algorithm */
+next1:
+	if (off + sizeof(NTFS_DE) > end) {
+		e =3D NULL;
+		goto out1;
+	}
+	e =3D Add2Ptr(hdr, off);
+	e_size =3D le16_to_cpu(e->size);
+
+	if (e_size < sizeof(NTFS_DE) || off + e_size > end) {
+		e =3D NULL;
+		goto out1;
+	}
+
+	if (max_idx >=3D nslots) {
+		u16 *ptr;
+		int new_slots =3D QuadAlign(2 * nslots);
+
+		ptr =3D ntfs_alloc(sizeof(u16) * new_slots, 0);
+		if (ptr)
+			memcpy(ptr, offs, sizeof(u16) * max_idx);
+		ntfs_free(offs);
+		offs =3D ptr;
+		nslots =3D new_slots;
+		if (!ptr)
+			goto next;
+	}
+
+	/* Store entry table */
+	offs[max_idx] =3D off;
+
+	if (!de_is_last(e)) {
+		off +=3D e_size;
+		max_idx +=3D 1;
+		goto next1;
+	}
+
+	/*
+	 * Table of pointers is created
+	 * Use binary search to find entry that is <=3D to the search value
+	 */
+	fnd =3D -1;
+	min_idx =3D 0;
+
+	while (min_idx <=3D max_idx) {
+		int mid_idx =3D min_idx + ((max_idx - min_idx) >> 1);
+		int diff2;
+
+		e =3D Add2Ptr(hdr, offs[mid_idx]);
+
+		e_key_len =3D le16_to_cpu(e->key_size);
+
+		diff2 =3D (*cmp)(key, key_len, e + 1, e_key_len, ctx);
+
+		if (!diff2) {
+			*diff =3D 0;
+			goto out1;
+		}
+
+		if (diff2 < 0) {
+			max_idx =3D mid_idx - 1;
+			fnd =3D mid_idx;
+			if (!fnd)
+				break;
+		} else {
+			min_idx =3D mid_idx + 1;
+		}
+	}
+
+	if (fnd =3D=3D -1) {
+		e =3D NULL;
+		goto out1;
+	}
+
+	*diff =3D -1;
+	e =3D Add2Ptr(hdr, offs[fnd]);
+
+out1:
+	ntfs_free(offs);
+
+	return e;
+#endif
+
+next:
+	/*
+	 * Entries index are sorted
+	 * Enumerate all entries until we find entry that is <=3D to the search v=
alue
+	 */
+	if (off + sizeof(NTFS_DE) > end)
+		return NULL;
+
+	e =3D Add2Ptr(hdr, off);
+	e_size =3D le16_to_cpu(e->size);
+
+	if (e_size < sizeof(NTFS_DE) || off + e_size > end)
+		return NULL;
+
+	off +=3D e_size;
+
+	e_key_len =3D le16_to_cpu(e->key_size);
+
+	*diff =3D (*cmp)(key, key_len, e + 1, e_key_len, ctx);
+	if (!*diff)
+		return e;
+
+	if (*diff <=3D 0)
+		return e;
+
+	if (de_is_last(e)) {
+		*diff =3D 1;
+		return e;
+	}
+	goto next;
+}
+
+/*
+ * hdr_insert_de
+ *
+ * inserts an index entry into the buffer.
+ * 'before' should be a pointer previously returned from hdr_find_e
+ */
+static NTFS_DE *hdr_insert_de(const ntfs_index *indx, INDEX_HDR *hdr,
+			      const NTFS_DE *de, NTFS_DE *before,
+			      const void *ctx)
+{
+	int diff;
+	size_t off =3D PtrOffset(hdr, before);
+	u32 used =3D le32_to_cpu(hdr->used);
+	u32 total =3D le32_to_cpu(hdr->total);
+	u16 de_size =3D le16_to_cpu(de->size);
+
+	/* First, check to see if there's enough room */
+	if (used + de_size > total)
+		return NULL;
+
+	/* We know there's enough space, so we know we'll succeed. */
+	if (before) {
+		/* Check that before is inside Index */
+		if (off >=3D used || off < le32_to_cpu(hdr->de_off) ||
+		    off + le16_to_cpu(before->size) > total) {
+			return NULL;
+		}
+		goto ok;
+	}
+	/* No insert point is applied. Get it manually */
+	before =3D hdr_find_e(indx, hdr, de + 1, le16_to_cpu(de->key_size), ctx,
+			    &diff);
+	if (!before)
+		return NULL;
+	off =3D PtrOffset(hdr, before);
+
+ok:
+	/* Now we just make room for the entry and jam it in. */
+	memmove(Add2Ptr(before, de_size), before, used - off);
+
+	hdr->used =3D cpu_to_le32(used + de_size);
+	memcpy(before, de, de_size);
+
+	return before;
+}
+
+/*
+ * hdr_delete_de
+ *
+ * removes an entry from the index buffer
+ */
+static inline NTFS_DE *hdr_delete_de(INDEX_HDR *hdr, NTFS_DE *re)
+{
+	u32 used =3D le32_to_cpu(hdr->used);
+	u16 esize =3D le16_to_cpu(re->size);
+	u32 off =3D PtrOffset(hdr, re);
+	int bytes =3D used - (off + esize);
+
+	if (off >=3D used || esize < sizeof(NTFS_DE) || bytes < sizeof(NTFS_DE))
+		return NULL;
+
+	hdr->used =3D cpu_to_le32(used - esize);
+	memmove(re, Add2Ptr(re, esize), bytes);
+
+	return re;
+}
+
+void indx_clear(ntfs_index *indx)
+{
+	run_close(&indx->alloc_run);
+	run_close(&indx->bitmap_run);
+}
+
+int indx_init(ntfs_index *indx, ntfs_sb_info *sbi, const ATTRIB *attr,
+	      enum index_mutex_classed type)
+{
+	u32 t32;
+	const INDEX_ROOT *root =3D resident_data(attr);
+
+	/* Check root fields */
+	if (!root->index_block_clst)
+		return -EINVAL;
+
+	indx->type =3D type;
+	indx->idx2vbn_bits =3D __ffs(root->index_block_clst);
+
+	t32 =3D le32_to_cpu(root->index_block_size);
+	indx->index_bits =3D blksize_bits(t32);
+
+	/* Check index record size */
+	if (t32 < sbi->cluster_size) {
+		/* index record is smaller than a cluster, use 512 blocks */
+		if (t32 !=3D root->index_block_clst * SECTOR_SIZE)
+			return -EINVAL;
+
+		/* Check alignment to a cluster */
+		if ((sbi->cluster_size >> SECTOR_SHIFT) &
+		    (root->index_block_clst - 1)) {
+			return -EINVAL;
+		}
+
+		indx->vbn2vbo_bits =3D SECTOR_SHIFT;
+	} else {
+		/* index record must be a multiple of cluster size */
+		if (t32 !=3D root->index_block_clst << sbi->cluster_bits)
+			return -EINVAL;
+
+		indx->vbn2vbo_bits =3D sbi->cluster_bits;
+	}
+
+	indx->cmp =3D get_cmp_func(root);
+
+	return indx->cmp ? 0 : -EINVAL;
+}
+
+static struct indx_node *indx_new(ntfs_index *indx, ntfs_inode *ni, CLST v=
bn,
+				  const __le64 *sub_vbn)
+{
+	int err;
+	NTFS_DE *e;
+	struct indx_node *r;
+	INDEX_HDR *hdr;
+	INDEX_BUFFER *index;
+	u64 vbo =3D (u64)vbn << indx->vbn2vbo_bits;
+	u32 bytes =3D 1u << indx->index_bits;
+	u16 fn;
+	u32 eo;
+
+	r =3D ntfs_alloc(sizeof(struct indx_node), 1);
+	if (!r)
+		return ERR_PTR(-ENOMEM);
+
+	index =3D ntfs_alloc(bytes, 1);
+	if (!index) {
+		ntfs_free(r);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err =3D ntfs_get_bh(ni->mi.sbi, &indx->alloc_run, vbo, bytes, &r->nb);
+
+	if (err) {
+		ntfs_free(index);
+		ntfs_free(r);
+		return ERR_PTR(err);
+	}
+
+	/* Create header */
+	index->rhdr.sign =3D NTFS_INDX_SIGNATURE;
+	index->rhdr.fix_off =3D cpu_to_le16(sizeof(INDEX_BUFFER)); // 0x28
+	fn =3D (bytes >> SECTOR_SHIFT) + 1; // 9
+	index->rhdr.fix_num =3D cpu_to_le16(fn);
+	index->vbn =3D cpu_to_le64(vbn);
+	hdr =3D &index->ihdr;
+	eo =3D QuadAlign(sizeof(INDEX_BUFFER) + fn * sizeof(short));
+	hdr->de_off =3D cpu_to_le32(eo);
+
+	e =3D Add2Ptr(hdr, eo);
+
+	if (sub_vbn) {
+		e->flags =3D NTFS_IE_LAST | NTFS_IE_HAS_SUBNODES;
+		e->size =3D cpu_to_le16(sizeof(NTFS_DE) + sizeof(u64));
+		hdr->used =3D cpu_to_le32(eo + sizeof(NTFS_DE) + sizeof(u64));
+		de_set_vbn_le(e, *sub_vbn);
+		hdr->flags =3D 1;
+	} else {
+		e->size =3D cpu_to_le16(sizeof(NTFS_DE));
+		hdr->used =3D cpu_to_le32(eo + sizeof(NTFS_DE));
+		e->flags =3D NTFS_IE_LAST;
+	}
+
+	hdr->total =3D cpu_to_le32(bytes - offsetof(INDEX_BUFFER, ihdr));
+
+	r->index =3D index;
+	return r;
+}
+
+INDEX_ROOT *indx_get_root(ntfs_index *indx, ntfs_inode *ni, ATTRIB **attr,
+			  mft_inode **mi)
+{
+	ATTR_LIST_ENTRY *le =3D NULL;
+	ATTRIB *a;
+	const struct INDEX_NAMES *in =3D &s_index_names[indx->type];
+
+	a =3D ni_find_attr(ni, NULL, &le, ATTR_ROOT, in->name, in->name_len, NULL=
,
+			 mi);
+	if (!a)
+		return NULL;
+
+	if (attr)
+		*attr =3D a;
+
+	return resident_data_ex(a, sizeof(INDEX_ROOT));
+}
+
+static int indx_write(ntfs_index *indx, ntfs_inode *ni, struct indx_node *=
node,
+		      int sync)
+{
+	int err;
+	INDEX_BUFFER *ib =3D node->index;
+
+	err =3D ntfs_write_bh_ex(ni->mi.sbi, &ib->rhdr, &node->nb, sync);
+
+	return err;
+}
+
+int indx_read(ntfs_index *indx, ntfs_inode *ni, CLST vbn,
+	      struct indx_node **node)
+{
+	int err;
+	INDEX_BUFFER *ib;
+	u64 vbo =3D (u64)vbn << indx->vbn2vbo_bits;
+	u32 bytes =3D 1u << indx->index_bits;
+	struct indx_node *in =3D *node;
+	const struct INDEX_NAMES *name;
+
+	if (!in) {
+		in =3D ntfs_alloc(sizeof(struct indx_node), 1);
+		if (!in)
+			return -ENOMEM;
+	} else {
+		nb_put(&in->nb);
+	}
+
+	ib =3D in->index;
+	if (!ib) {
+		ib =3D ntfs_alloc(bytes, 0);
+		if (!ib) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+	}
+
+	err =3D ntfs_read_bh_ex(ni->mi.sbi, &indx->alloc_run, vbo, &ib->rhdr,
+			      bytes, &in->nb);
+
+	if (!err)
+		goto ok;
+
+	if (err =3D=3D 1)
+		goto ok;
+
+	if (err !=3D -ENOENT)
+		goto out;
+
+	name =3D &s_index_names[indx->type];
+	err =3D attr_load_runs_vcn(ni, ATTR_ALLOC, name->name, name->name_len,
+				 &indx->alloc_run,
+				 vbo >> ni->mi.sbi->cluster_bits);
+	if (err)
+		goto out;
+
+	err =3D ntfs_read_bh_ex(ni->mi.sbi, &indx->alloc_run, vbo, &ib->rhdr,
+			      bytes, &in->nb);
+	if (err =3D=3D 1)
+		goto ok;
+
+	if (err)
+		goto out;
+
+ok:
+	if (err =3D=3D 1)
+		ntfs_write_bh_ex(ni->mi.sbi, &ib->rhdr, &in->nb, 0);
+	in->index =3D ib;
+	*node =3D in;
+
+out:
+	if (ib !=3D in->index)
+		ntfs_free(ib);
+
+	if (*node !=3D in) {
+		nb_put(&in->nb);
+		ntfs_free(in);
+	}
+
+	return err;
+}
+
+/*
+ * indx_find
+ *
+ * scans NTFS directory for given entry
+ */
+int indx_find(ntfs_index *indx, ntfs_inode *ni, const INDEX_ROOT *root,
+	      const void *key, size_t key_len, const void *ctx, int *diff,
+	      NTFS_DE **entry, struct ntfs_fnd *fnd)
+{
+	int err;
+	NTFS_DE *e;
+	const INDEX_HDR *hdr;
+	struct indx_node *node;
+
+	if (!root)
+		root =3D indx_get_root(&ni->dir, ni, NULL, NULL);
+
+	if (!root) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	hdr =3D &root->ihdr;
+
+	/* Check cache */
+	e =3D fnd->level ? fnd->de[fnd->level - 1] : fnd->root_de;
+	if (e && !de_is_last(e) &&
+	    !(*indx->cmp)(key, key_len, e + 1, le16_to_cpu(e->key_size), ctx)) {
+		*entry =3D e;
+		*diff =3D 0;
+		return 0;
+	}
+
+	/* Soft finder reset */
+	fnd_clear(fnd);
+
+	/* Lookup entry that is <=3D to the search value */
+	e =3D hdr_find_e(indx, hdr, key, key_len, ctx, diff);
+	if (!e)
+		return -EINVAL;
+
+	if (fnd)
+		fnd->root_de =3D e;
+
+	err =3D 0;
+	node =3D NULL;
+next:
+	if (*diff >=3D 0 || !de_has_vcn_ex(e)) {
+		*entry =3D e;
+		goto out;
+	}
+
+	/* Read next level. */
+	err =3D indx_read(indx, ni, de_get_vbn(e), &node);
+	if (err)
+		goto out;
+
+	/* Lookup entry that is <=3D to the search value */
+	e =3D hdr_find_e(indx, &node->index->ihdr, key, key_len, ctx, diff);
+	if (!e) {
+		err =3D -EINVAL;
+		put_indx_node(node);
+		goto out;
+	}
+
+	fnd_push(fnd, node, e);
+	node =3D NULL;
+	goto next;
+
+out:
+	return err;
+}
+
+int indx_find_sort(ntfs_index *indx, ntfs_inode *ni, const INDEX_ROOT *roo=
t,
+		   NTFS_DE **entry, struct ntfs_fnd *fnd)
+{
+	int err;
+	struct indx_node *n =3D NULL;
+	NTFS_DE *e;
+	size_t iter =3D 0;
+	int level =3D fnd->level;
+
+	if (!*entry) {
+		/* Start find */
+		e =3D hdr_first_de(&root->ihdr);
+		if (!e)
+			return 0;
+		fnd_clear(fnd);
+		fnd->root_de =3D e;
+	} else if (!level) {
+		if (de_is_last(fnd->root_de)) {
+			*entry =3D NULL;
+			return 0;
+		}
+
+		e =3D hdr_next_de(&root->ihdr, fnd->root_de);
+		if (!e)
+			return -EINVAL;
+		fnd->root_de =3D e;
+	} else {
+		n =3D fnd->nodes[level - 1];
+		e =3D fnd->de[level - 1];
+
+		if (de_is_last(e))
+			goto PopLevel;
+
+		e =3D hdr_next_de(&n->index->ihdr, e);
+		if (!e)
+			return -EINVAL;
+
+		fnd->de[level - 1] =3D e;
+	}
+
+	/* Just to avoid tree cycle */
+next_iter:
+	if (iter++ >=3D 1000)
+		return -EINVAL;
+
+	while (de_has_vcn_ex(e)) {
+		if (le16_to_cpu(e->size) < sizeof(NTFS_DE) + sizeof(u64)) {
+			if (n) {
+				fnd_pop(fnd);
+				ntfs_free(n);
+			}
+			return -EINVAL;
+		}
+
+		/* Read next level */
+		err =3D indx_read(indx, ni, de_get_vbn(e), &n);
+
+		/* Try next level */
+		e =3D hdr_first_de(&n->index->ihdr);
+		if (!e) {
+			ntfs_free(n);
+			return -EINVAL;
+		}
+
+		fnd_push(fnd, n, e);
+	}
+
+	if (le16_to_cpu(e->size) > sizeof(NTFS_DE)) {
+		*entry =3D e;
+		return 0;
+	}
+
+PopLevel:
+	if (!de_is_last(e))
+		goto next_iter;
+
+	/* Pop one level */
+	if (n) {
+		fnd_pop(fnd);
+		ntfs_free(n);
+	}
+
+	level =3D fnd->level;
+
+	if (level) {
+		n =3D fnd->nodes[level - 1];
+		e =3D fnd->de[level - 1];
+	} else if (fnd->root_de) {
+		n =3D NULL;
+		e =3D fnd->root_de;
+		fnd->root_de =3D NULL;
+	} else {
+		*entry =3D NULL;
+		return 0;
+	}
+
+	if (le16_to_cpu(e->size) > sizeof(NTFS_DE)) {
+		*entry =3D e;
+		if (!fnd->root_de)
+			fnd->root_de =3D e;
+		return 0;
+	}
+	goto PopLevel;
+}
+
+int indx_find_raw(ntfs_index *indx, ntfs_inode *ni, const INDEX_ROOT *root=
,
+		  NTFS_DE **entry, size_t *off, struct ntfs_fnd *fnd)
+{
+	int err;
+	struct indx_node *n =3D NULL;
+	NTFS_DE *e =3D NULL;
+	NTFS_DE *e2;
+	size_t bit;
+	CLST next_used_vbn;
+	CLST next_vbn;
+	u32 record_size =3D ni->mi.sbi->record_size;
+
+	/* Use non sorted algorithm */
+	if (!*entry) {
+		/* This is the first call */
+		e =3D hdr_first_de(&root->ihdr);
+		if (!e)
+			return 0;
+		fnd_clear(fnd);
+		fnd->root_de =3D e;
+
+		if (!*off)
+			goto enum_hdr;
+
+		/* The first call with setup of initial element */
+		if (*off < record_size) {
+			/* Start enumeration from root */
+			*off =3D 0;
+			goto enum_hdr;
+		}
+		next_vbn =3D (((*off - record_size) >> indx->index_bits))
+			   << indx->idx2vbn_bits;
+		goto Next;
+	}
+
+	if (!fnd->root_de)
+		return -EINVAL;
+
+enum_hdr:
+	/* Check if current entry can be used */
+	if (e && le16_to_cpu(e->size) > sizeof(NTFS_DE))
+		goto ok;
+
+	if (!fnd->level) {
+		/* Continue to enumerate root */
+		if (!de_is_last(fnd->root_de)) {
+			e =3D hdr_next_de(&root->ihdr, fnd->root_de);
+			if (!e)
+				return -EINVAL;
+			fnd->root_de =3D e;
+			goto enum_hdr;
+		}
+
+		/* Start to enumerate indexes from 0 */
+		next_vbn =3D 0;
+		goto Next;
+	}
+
+	/* Continue to enumerate indexes */
+	e2 =3D fnd->de[fnd->level - 1];
+
+	n =3D fnd->nodes[fnd->level - 1];
+
+	if (!de_is_last(e2)) {
+		e =3D hdr_next_de(&n->index->ihdr, e2);
+		if (!e)
+			return -EINVAL;
+		fnd->de[fnd->level - 1] =3D e;
+		goto enum_hdr;
+	}
+
+	/* Continue with next index */
+	next_vbn =3D le64_to_cpu(n->index->vbn) + root->index_block_clst;
+
+Next:
+	/* Release current index */
+	if (n) {
+		fnd_pop(fnd);
+		put_indx_node(n);
+		n =3D NULL;
+	}
+
+	/* Skip all free indexes */
+	bit =3D next_vbn >> indx->idx2vbn_bits;
+	err =3D indx_used_bit(indx, ni, &bit);
+	if (err =3D=3D -ENOENT || bit =3D=3D MINUS_ONE_T) {
+		/* No used indexes */
+		*entry =3D NULL;
+		return 0;
+	}
+
+	next_used_vbn =3D bit << indx->idx2vbn_bits;
+
+	/* Read buffer into memory */
+	err =3D indx_read(indx, ni, next_used_vbn, &n);
+	if (err)
+		return err;
+
+	e =3D hdr_first_de(&n->index->ihdr);
+	fnd_push(fnd, n, e);
+	if (!e)
+		return -EINVAL;
+
+	goto enum_hdr;
+
+ok:
+	/* return offset to restore enumerator if necessary */
+	if (!n) {
+		/* 'e' points in root */
+		*off =3D PtrOffset(&root->ihdr, e);
+	} else {
+		/* 'e' points in index */
+		*off =3D (le64_to_cpu(n->index->vbn) << indx->vbn2vbo_bits) +
+		       record_size + PtrOffset(&n->index->ihdr, e);
+	}
+
+	*entry =3D e;
+	return 0;
+}
+
+/*
+ * indx_create_allocate
+ *
+ * create "Allocation + Bitmap" attributes
+ */
+static int indx_create_allocate(ntfs_index *indx, ntfs_inode *ni, CLST *vb=
n)
+{
+	int err =3D -ENOMEM;
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+
+	ATTRIB *bitmap;
+	ATTRIB *alloc;
+	u32 alloc_size =3D ntfs_up_cluster(sbi, 1u << indx->index_bits);
+	CLST len =3D alloc_size >> sbi->cluster_bits;
+	const struct INDEX_NAMES *in =3D &s_index_names[indx->type];
+	CLST alen;
+	struct runs_tree run;
+
+	run_init(&run);
+
+	err =3D attr_allocate_clusters(sbi, &run, 0, 0, len, NULL, 0, &alen, 0,
+				     NULL);
+	if (err)
+		goto out;
+
+	err =3D ni_insert_nonresident(ni, ATTR_ALLOC, in->name, in->name_len,
+				    &run, 0, len, 0, &alloc, NULL);
+	if (err)
+		goto out1;
+
+	err =3D ni_insert_resident(ni, QuadAlign(1), ATTR_BITMAP, in->name,
+				 in->name_len, &bitmap, NULL);
+	if (err)
+		goto out2;
+
+	memcpy(&indx->alloc_run, &run, sizeof(run));
+
+	*vbn =3D 0;
+
+	if (in->name =3D=3D I30_NAME)
+		ni->vfs_inode.i_size =3D alloc_size;
+
+	return 0;
+
+out2:
+	mi_remove_attr(&ni->mi, alloc);
+
+out1:
+	run_deallocate(sbi, &run, false);
+
+out:
+	return err;
+}
+
+/*
+ * indx_add_allocate
+ *
+ * add clusters to index
+ */
+static int indx_add_allocate(ntfs_index *indx, ntfs_inode *ni, CLST *vbn)
+{
+	int err;
+	size_t bit;
+	u64 data_size, alloc_size;
+	u64 bpb, vbpb;
+	ATTRIB *bmp, *alloc;
+	mft_inode *mi;
+	const struct INDEX_NAMES *in =3D &s_index_names[indx->type];
+
+	err =3D indx_find_free(indx, ni, &bit, &bmp);
+	if (err)
+		goto out1;
+
+	if (bit !=3D MINUS_ONE_T) {
+		bmp =3D NULL;
+	} else {
+		if (bmp->non_res) {
+			bpb =3D le64_to_cpu(bmp->nres.data_size);
+			vbpb =3D le64_to_cpu(bmp->nres.valid_size);
+		} else {
+			bpb =3D vbpb =3D le32_to_cpu(bmp->res.data_size);
+		}
+
+		/* Increase bitmap */
+		err =3D attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
+				    &indx->bitmap_run, QuadAlign(bpb + 8), NULL,
+				    true, NULL);
+		if (err)
+			goto out1;
+
+		bit =3D bpb << 3;
+	}
+
+	alloc =3D ni_find_attr(ni, NULL, NULL, ATTR_ALLOC, in->name, in->name_len=
,
+			     NULL, &mi);
+	if (!alloc) {
+		if (bmp)
+			goto out2;
+		goto out1;
+	}
+
+	data_size =3D (u64)(bit + 1) << indx->index_bits;
+	alloc_size =3D ntfs_up_cluster(ni->mi.sbi, data_size);
+
+	if (alloc_size > le64_to_cpu(alloc->nres.alloc_size)) {
+		/* Increase allocation */
+		err =3D attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
+				    &indx->alloc_run, alloc_size, &alloc_size,
+				    true, NULL);
+		if (err) {
+			if (bmp)
+				goto out2;
+			goto out1;
+		}
+
+		if (in->name =3D=3D I30_NAME)
+			ni->vfs_inode.i_size =3D alloc_size;
+	} else if (data_size > le64_to_cpu(alloc->nres.data_size)) {
+		alloc->nres.data_size =3D alloc->nres.valid_size =3D
+			cpu_to_le64(data_size);
+		mi->dirty =3D true;
+	}
+
+	*vbn =3D bit << indx->idx2vbn_bits;
+
+	return 0;
+
+out2:
+	/* Ops (no space?) */
+	attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
+		      &indx->bitmap_run, bpb, &vbpb, false, NULL);
+
+out1:
+	return err;
+}
+
+/*
+ * indx_insert_into_root
+ *
+ * attempts to insert an entry into the index root
+ * If necessary, it will twiddle the index b-tree.
+ */
+static int indx_insert_into_root(ntfs_index *indx, ntfs_inode *ni,
+				 const NTFS_DE *new_de, NTFS_DE *root_de,
+				 const void *ctx, struct ntfs_fnd *fnd)
+{
+	int err =3D 0;
+	NTFS_DE *e, *e0, *re;
+	mft_inode *mi;
+	ATTRIB *attr;
+	MFT_REC *rec;
+	INDEX_HDR *hdr;
+	struct indx_node *n;
+	CLST new_vbn;
+	__le64 *sub_vbn, t_vbn;
+	u16 new_de_size;
+	u32 hdr_used, hdr_total, asize, tail, used, aoff, to_move;
+	u32 root_size, new_root_size;
+	ntfs_sb_info *sbi;
+	char *next;
+	int ds_root;
+	INDEX_ROOT *root, *a_root =3D NULL;
+
+	/* Get the record this root placed in */
+	root =3D indx_get_root(indx, ni, &attr, &mi);
+	if (!root)
+		goto out;
+
+	/*
+	 * Try easy case:
+	 * hdr_insert_de will succeed if there's room the root for the new entry.
+	 */
+	hdr =3D &root->ihdr;
+	sbi =3D ni->mi.sbi;
+	rec =3D mi->mrec;
+	aoff =3D PtrOffset(rec, attr);
+	used =3D le32_to_cpu(rec->used);
+	new_de_size =3D le16_to_cpu(new_de->size);
+	hdr_used =3D le32_to_cpu(hdr->used);
+	hdr_total =3D le32_to_cpu(hdr->total);
+	asize =3D le32_to_cpu(attr->size);
+	next =3D Add2Ptr(attr, asize);
+	tail =3D used - aoff - asize;
+	root_size =3D le32_to_cpu(attr->res.data_size);
+
+	ds_root =3D new_de_size + hdr_used - hdr_total;
+
+	if (used + ds_root < sbi->max_bytes_per_attr) {
+		/* make a room for new elements */
+		memmove(next + ds_root, next, used - aoff - asize);
+		hdr->total =3D cpu_to_le32(hdr_total + ds_root);
+		e =3D hdr_insert_de(indx, hdr, new_de, root_de, ctx);
+		WARN_ON(!e);
+		fnd_clear(fnd);
+		fnd->root_de =3D e;
+		attr->size =3D cpu_to_le32(asize + ds_root);
+		attr->res.data_size =3D cpu_to_le32(root_size + ds_root);
+		rec->used =3D cpu_to_le32(used + ds_root);
+
+		return 0;
+	}
+
+	/* Make a copy of root attribute to restore if error */
+	a_root =3D ntfs_memdup(attr, asize);
+	if (!a_root) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	/* copy all the non-end entries from the index root to the new buffer.*/
+	to_move =3D 0;
+	e0 =3D hdr_first_de(hdr);
+
+	/* Calculate the size to copy */
+	for (e =3D e0;; e =3D hdr_next_de(hdr, e)) {
+		if (!e) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		if (de_is_last(e))
+			break;
+		to_move +=3D le16_to_cpu(e->size);
+	}
+
+	n =3D NULL;
+	if (!to_move)
+		re =3D NULL;
+	else {
+		re =3D ntfs_memdup(e0, to_move);
+		if (!re) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+	}
+
+	sub_vbn =3D NULL;
+	if (de_has_vcn(e)) {
+		t_vbn =3D de_get_vbn_le(e);
+		sub_vbn =3D &t_vbn;
+	}
+
+	new_root_size =3D sizeof(INDEX_ROOT) + sizeof(NTFS_DE) + sizeof(u64);
+	ds_root =3D new_root_size - root_size;
+
+	if (ds_root > 0 && used + ds_root > sbi->max_bytes_per_attr) {
+		/* make root external */
+		err =3D -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (ds_root) {
+		memmove(next + ds_root, next, tail);
+		used +=3D ds_root;
+		asize +=3D ds_root;
+		rec->used =3D cpu_to_le32(used);
+		attr->size =3D cpu_to_le32(asize);
+		attr->res.data_size =3D cpu_to_le32(new_root_size);
+		mi->dirty =3D true;
+	}
+
+	/* Fill first entry (vcn will be set later) */
+	e =3D (NTFS_DE *)(root + 1);
+	memset(e, 0, sizeof(NTFS_DE));
+	e->size =3D cpu_to_le16(sizeof(NTFS_DE) + sizeof(u64));
+	e->flags =3D NTFS_IE_HAS_SUBNODES | NTFS_IE_LAST;
+
+	hdr->flags =3D 1;
+	hdr->used =3D hdr->total =3D
+		cpu_to_le32(new_root_size - offsetof(INDEX_ROOT, ihdr));
+
+	fnd->root_de =3D hdr_first_de(hdr);
+
+	/* Create alloc and bitmap attributes (if not) */
+	if (run_is_empty(&indx->alloc_run)) {
+		err =3D indx_create_allocate(indx, ni, &new_vbn);
+		if (err) {
+			/* restore root after 'indx_create_allocate' */
+			memmove(next - ds_root, next, tail);
+			used -=3D ds_root;
+			rec->used =3D cpu_to_le32(used);
+			memcpy(attr, a_root, asize);
+			goto out1;
+		}
+	} else {
+		err =3D indx_add_allocate(indx, ni, &new_vbn);
+		if (err)
+			goto out1;
+	}
+
+	root =3D indx_get_root(indx, ni, &attr, &mi);
+	if (!root) {
+		err =3D -EINVAL;
+		goto out1;
+	}
+
+	e =3D (NTFS_DE *)(root + 1);
+	*(__le64 *)(e + 1) =3D cpu_to_le64(new_vbn);
+
+	/* now we can create/format the new buffer and copy the entries into */
+	n =3D indx_new(indx, ni, new_vbn, sub_vbn);
+	if (IS_ERR(n)) {
+		err =3D PTR_ERR(n);
+		goto out1;
+	}
+
+	hdr =3D &n->index->ihdr;
+	hdr_used =3D le32_to_cpu(hdr->used);
+	hdr_total =3D le32_to_cpu(hdr->total);
+
+	/* Copy root entries into new buffer */
+	hdr_insert_head(hdr, re, to_move);
+
+	/* Update bitmap attribute */
+	indx_mark_used(indx, ni, new_vbn >> indx->idx2vbn_bits);
+
+	/* Check if we can insert new entry new index buffer */
+	if (hdr_used + new_de_size > hdr_total) {
+		/*
+		 * This occurs if mft record is the same or bigger than index
+		 * buffer. Move all root new index and have no space to add
+		 * new entry classic case when mft record is 1K and index
+		 * buffer 4K the problem should not occurs
+		 */
+		ntfs_trace(sbi->sb,
+			   "Failed: root + new entry > index. Reinsert");
+		ntfs_free(re);
+		indx_write(indx, ni, n, 0);
+
+		put_indx_node(n);
+		fnd_clear(fnd);
+		err =3D indx_insert_entry(indx, ni, new_de, ctx, fnd);
+		goto out;
+	}
+
+	/*
+	 * Now root is a parent for new index buffer
+	 * Insert NewEntry a new buffer
+	 */
+	e =3D hdr_insert_de(indx, hdr, new_de, NULL, ctx);
+	if (!e) {
+		err =3D -EINVAL;
+		goto out1;
+	}
+	fnd_push(fnd, n, e);
+
+	/* Just write updates index into disk */
+	indx_write(indx, ni, n, 0);
+
+	n =3D NULL;
+
+out1:
+	ntfs_free(re);
+	if (n)
+		put_indx_node(n);
+
+out:
+	ntfs_free(a_root);
+	return err;
+}
+
+/*
+ * indx_insert_into_buffer
+ *
+ * attempts to insert an entry into an Index Allocation Buffer.
+ * If necessary, it will split the buffer.
+ */
+static int indx_insert_into_buffer(ntfs_index *indx, ntfs_inode *ni,
+				   INDEX_ROOT *root, const NTFS_DE *new_de,
+				   const void *ctx, int level,
+				   struct ntfs_fnd *fnd)
+{
+	int err;
+	const NTFS_DE *sp;
+	NTFS_DE *e, *de_t, *up_e =3D NULL;
+	struct indx_node *n2 =3D NULL;
+	struct indx_node *n1 =3D fnd->nodes[level];
+	INDEX_HDR *hdr1 =3D &n1->index->ihdr;
+	INDEX_HDR *hdr2;
+	u32 to_copy, used;
+	CLST new_vbn;
+	__le64 t_vbn, *sub_vbn;
+	u16 sp_size;
+
+	/* Try the most easy case */
+	e =3D fnd->level - 1 =3D=3D level ? fnd->de[level] : NULL;
+	e =3D hdr_insert_de(indx, hdr1, new_de, e, ctx);
+	fnd->de[level] =3D e;
+	if (e) {
+		/* Just write updated index into disk */
+		indx_write(indx, ni, n1, 0);
+		return 0;
+	}
+
+	/*
+	 * No space to insert into buffer. Split it.
+	 * To split we:
+	 *  - Save split point ('cause index buffers will be changed)
+	 * - Allocate NewBuffer and copy all entries <=3D sp into new buffer
+	 * - Remove all entries (sp including) from TargetBuffer
+	 * - Insert NewEntry into left or right buffer (depending on sp <=3D>
+	 *     NewEntry)
+	 * - Insert sp into parent buffer (or root)
+	 * - Make sp a parent for new buffer
+	 */
+	sp =3D hdr_find_split(hdr1);
+	if (!sp)
+		return -EINVAL;
+
+	sp_size =3D le16_to_cpu(sp->size);
+	up_e =3D ntfs_alloc(sp_size + sizeof(u64), 0);
+	if (!up_e)
+		return -ENOMEM;
+	memcpy(up_e, sp, sp_size);
+
+	if (!hdr1->flags) {
+		up_e->flags |=3D NTFS_IE_HAS_SUBNODES;
+		up_e->size =3D cpu_to_le16(sp_size + sizeof(u64));
+		sub_vbn =3D NULL;
+	} else {
+		t_vbn =3D de_get_vbn_le(up_e);
+		sub_vbn =3D &t_vbn;
+	}
+
+	/* Allocate on disk a new index allocation buffer. */
+	err =3D indx_add_allocate(indx, ni, &new_vbn);
+	if (err)
+		goto out;
+
+	/* Allocate and format memory a new index buffer */
+	n2 =3D indx_new(indx, ni, new_vbn, sub_vbn);
+	if (IS_ERR(n2)) {
+		err =3D PTR_ERR(n2);
+		goto out;
+	}
+
+	hdr2 =3D &n2->index->ihdr;
+
+	/* Make sp a parent for new buffer */
+	de_set_vbn(up_e, new_vbn);
+
+	/* copy all the entries <=3D sp into the new buffer. */
+	de_t =3D hdr_first_de(hdr1);
+	to_copy =3D PtrOffset(de_t, sp);
+	hdr_insert_head(hdr2, de_t, to_copy);
+
+	/* remove all entries (sp including) from hdr1 */
+	used =3D le32_to_cpu(hdr1->used) - to_copy - sp_size;
+	memmove(de_t, Add2Ptr(sp, sp_size), used - le32_to_cpu(hdr1->de_off));
+	hdr1->used =3D cpu_to_le32(used);
+
+	/* Insert new entry into left or right buffer (depending on sp <=3D> new_=
de) */
+	hdr_insert_de(indx,
+		      (*indx->cmp)(new_de + 1, le16_to_cpu(new_de->key_size),
+				   up_e + 1, le16_to_cpu(up_e->key_size),
+				   ctx) < 0 ?
+			      hdr2 :
+			      hdr1,
+		      new_de, NULL, ctx);
+
+	indx_mark_used(indx, ni, new_vbn >> indx->idx2vbn_bits);
+
+	indx_write(indx, ni, n1, 0);
+	indx_write(indx, ni, n2, 0);
+
+	put_indx_node(n2);
+
+	/*
+	 * we've finished splitting everybody, so we are ready to
+	 * insert the promoted entry into the parent.
+	 */
+	if (!level) {
+		/* Insert in root */
+		err =3D indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd);
+		if (err)
+			goto out;
+	} else {
+		/*
+		 * The target buffer's parent is another index buffer
+		 * TODO: Remove recursion
+		 */
+		err =3D indx_insert_into_buffer(indx, ni, root, up_e, ctx,
+					      level - 1, fnd);
+		if (err)
+			goto out;
+	}
+
+out:
+	ntfs_free(up_e);
+
+	return err;
+}
+
+/*
+ * indx_insert_entry
+ *
+ * inserts new entry into index
+ */
+int indx_insert_entry(ntfs_index *indx, ntfs_inode *ni, const NTFS_DE *new=
_de,
+		      const void *ctx, struct ntfs_fnd *fnd)
+{
+	int err;
+	int diff;
+	NTFS_DE *e;
+	struct ntfs_fnd *fnd_a =3D NULL;
+	INDEX_ROOT *root;
+
+	if (!fnd) {
+		fnd_a =3D fnd_get(indx);
+		if (!fnd_a) {
+			err =3D -ENOMEM;
+			goto out1;
+		}
+		fnd =3D fnd_a;
+	}
+
+	root =3D indx_get_root(indx, ni, NULL, NULL);
+	if (!root) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (!fnd_is_empty(fnd))
+		goto insert_step;
+
+	/* Find the spot the tree where we want to insert the new entry. */
+	err =3D indx_find(indx, ni, root, new_de + 1,
+			le16_to_cpu(new_de->key_size), ctx, &diff, &e, fnd);
+	if (err)
+		goto out;
+
+	if (!diff) {
+		err =3D -EEXIST;
+		goto out;
+	}
+
+insert_step:
+	if (!fnd->level) {
+		/* The root is also a leaf, so we'll insert the new entry into it. */
+		err =3D indx_insert_into_root(indx, ni, new_de, fnd->root_de, ctx,
+					    fnd);
+		if (err)
+			goto out;
+	} else {
+		/* found a leaf buffer, so we'll insert the new entry into it.*/
+		err =3D indx_insert_into_buffer(indx, ni, root, new_de, ctx,
+					      fnd->level - 1, fnd);
+		if (err)
+			goto out;
+	}
+
+out:
+	indx->changed =3D true;
+	fnd_put(fnd_a);
+out1:
+
+	return err;
+}
+
+/*
+ * indx_find_buffer
+ *
+ * locates a buffer the tree.
+ */
+static struct indx_node *indx_find_buffer(ntfs_index *indx, ntfs_inode *ni=
,
+					  const INDEX_ROOT *root, __le64 vbn,
+					  struct indx_node *n)
+{
+	int err;
+	const NTFS_DE *e;
+	struct indx_node *r;
+	const INDEX_HDR *hdr =3D n ? &n->index->ihdr : &root->ihdr;
+
+	/* Step 1: Scan one level */
+	for (e =3D hdr_first_de(hdr);; e =3D hdr_next_de(hdr, e)) {
+		if (!e)
+			return ERR_PTR(-EINVAL);
+
+		if (de_has_vcn(e) && vbn =3D=3D de_get_vbn_le(e))
+			return n;
+
+		if (de_is_last(e))
+			break;
+	}
+
+	/* Step2: Do recursion */
+	e =3D Add2Ptr(hdr, le32_to_cpu(hdr->de_off));
+	for (;;) {
+		if (de_has_vcn_ex(e)) {
+			err =3D indx_read(indx, ni, de_get_vbn(e), &n);
+			if (err)
+				return ERR_PTR(err);
+
+			r =3D indx_find_buffer(indx, ni, root, vbn, n);
+			if (r)
+				return r;
+		}
+
+		if (de_is_last(e))
+			break;
+
+		e =3D Add2Ptr(e, le16_to_cpu(e->size));
+	}
+
+	return NULL;
+}
+
+/*
+ * indx_shrink
+ *
+ * deallocates unused tail indexes
+ */
+static int indx_shrink(ntfs_index *indx, ntfs_inode *ni, size_t bit)
+{
+	int err =3D 0;
+	u64 bpb, new_alloc;
+	size_t nbits;
+	ATTRIB *b;
+	ATTR_LIST_ENTRY *le =3D NULL;
+	const struct INDEX_NAMES *in =3D &s_index_names[indx->type];
+
+	b =3D ni_find_attr(ni, NULL, &le, ATTR_BITMAP, in->name, in->name_len,
+			 NULL, NULL);
+
+	if (!b)
+		return -ENOENT;
+
+	if (!b->non_res) {
+		unsigned long pos;
+		const unsigned long *bm =3D resident_data(b);
+
+		nbits =3D le32_to_cpu(b->res.data_size) * 8;
+
+		if (bit >=3D nbits)
+			return 0;
+
+		pos =3D find_next_bit(bm, nbits, bit);
+		if (pos < nbits)
+			return 0;
+	} else {
+		size_t used =3D MINUS_ONE_T;
+
+		nbits =3D le64_to_cpu(b->nres.data_size) * 8;
+
+		if (bit >=3D nbits)
+			return 0;
+
+		err =3D scan_nres_bitmap(ni->mi.sbi, b, &indx->bitmap_run, bit,
+				       &scan_for_used, &used);
+		if (err)
+			return err;
+
+		if (used !=3D MINUS_ONE_T)
+			return 0;
+	}
+
+	new_alloc =3D (u64)bit << indx->index_bits;
+
+	err =3D attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
+			    &indx->alloc_run, new_alloc, &new_alloc, false,
+			    NULL);
+	if (err)
+		return err;
+
+	if (in->name =3D=3D I30_NAME)
+		ni->vfs_inode.i_size =3D new_alloc;
+
+	bpb =3D bitmap_size(bit);
+	if (bpb * 8 =3D=3D nbits)
+		return 0;
+
+	err =3D attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
+			    &indx->bitmap_run, bpb, &bpb, false, NULL);
+
+	return err;
+}
+
+static int indx_free_children(ntfs_index *indx, ntfs_inode *ni,
+			      const NTFS_DE *e, bool trim)
+{
+	int err;
+	struct indx_node *n;
+	INDEX_HDR *hdr;
+	CLST vbn =3D de_get_vbn(e);
+	size_t i;
+
+	err =3D indx_read(indx, ni, vbn, &n);
+	if (err)
+		return err;
+
+	hdr =3D &n->index->ihdr;
+	/* First, recurse into the children, if any.*/
+	if (!hdr_has_subnode(hdr))
+		goto putnode;
+
+	for (e =3D hdr_first_de(hdr); e; e =3D hdr_next_de(hdr, e)) {
+		indx_free_children(indx, ni, e, false);
+		if (de_is_last(e))
+			break;
+	}
+
+putnode:
+	put_indx_node(n);
+
+	i =3D vbn >> indx->idx2vbn_bits;
+	/* We've gotten rid of the children; add this buffer to the free list. */
+	indx_mark_free(indx, ni, i);
+
+	if (!trim)
+		return 0;
+
+	/*
+	 * If there are no used indexes after current free index
+	 * then we can truncate allocation and bitmap
+	 * Use bitmap to estimate the case
+	 */
+	indx_shrink(indx, ni, i + 1);
+	return 0;
+}
+
+/*
+ * indx_get_entry_to_replace
+ *
+ * finds a replacement entry for a deleted entry
+ * always returns a node entry:
+ * NTFS_IE_HAS_SUBNODES is set the flags and the size includes the sub_vcn
+ */
+static int indx_get_entry_to_replace(ntfs_index *indx, ntfs_inode *ni,
+				     const NTFS_DE *de_next,
+				     NTFS_DE **de_to_replace,
+				     struct ntfs_fnd *fnd)
+{
+	int err;
+	int level =3D -1;
+	CLST vbn;
+	NTFS_DE *e, *te, *re;
+	struct indx_node *n;
+	INDEX_BUFFER *ib;
+
+	*de_to_replace =3D NULL;
+
+	/* Find first leaf entry down from de_next */
+	vbn =3D de_get_vbn(de_next);
+	for (;;) {
+		n =3D NULL;
+		err =3D indx_read(indx, ni, vbn, &n);
+		if (err)
+			goto out;
+
+		e =3D hdr_first_de(&n->index->ihdr);
+		fnd_push(fnd, n, e);
+
+		if (!de_is_last(e)) {
+			/*
+			 * This buffer is non-empty, so its first entry could be used as the
+			 * replacement entry.
+			 */
+			level =3D fnd->level - 1;
+		}
+
+		if (!de_has_vcn(e))
+			break;
+
+		/* This buffer is a node. Continue to go down */
+		vbn =3D de_get_vbn(e);
+	}
+
+	if (level =3D=3D -1)
+		goto out;
+
+	n =3D fnd->nodes[level];
+	te =3D hdr_first_de(&n->index->ihdr);
+	/* Copy the candidate entry into the replacement entry buffer. */
+	re =3D ntfs_alloc(le16_to_cpu(te->size) + sizeof(u64), 0);
+	if (!re) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	*de_to_replace =3D re;
+	memcpy(re, te, le16_to_cpu(te->size));
+
+	if (!de_has_vcn(re)) {
+		/*
+		 * The replacement entry we found doesn't have a sub_vcn. increase its s=
ize
+		 * to hold one.
+		 */
+		le16_add_cpu(&re->size, sizeof(u64));
+		re->flags |=3D NTFS_IE_HAS_SUBNODES;
+	} else {
+		/*
+		 * The replacement entry we found was a node entry, which means that all
+		 * its child buffers are empty. Return them to the free pool.
+		 */
+		indx_free_children(indx, ni, te, true);
+	}
+
+	/*
+	 * Expunge the replacement entry from its former location,
+	 * and then write that buffer.
+	 */
+	ib =3D n->index;
+	e =3D hdr_delete_de(&ib->ihdr, te);
+
+	fnd->de[level] =3D e;
+	indx_write(indx, ni, n, 0);
+
+	/* Check to see if this action created an empty leaf. */
+	if (ib_is_leaf(ib) && ib_is_empty(ib))
+		return 0;
+
+out:
+	fnd_clear(fnd);
+
+	return err;
+}
+
+/*
+ * indx_delete_entry
+ *
+ * deletes an entry from the index.
+ */
+int indx_delete_entry(ntfs_index *indx, ntfs_inode *ni, const void *key,
+		      u32 key_len, const void *ctx)
+{
+	int err, diff;
+	INDEX_ROOT *root;
+	INDEX_HDR *hdr;
+	struct ntfs_fnd *fnd, *fnd2;
+	INDEX_BUFFER *ib;
+	NTFS_DE *e, *re, *next, *prev, *me;
+	struct indx_node *n, *n2d =3D NULL;
+	__le64 sub_vbn;
+	int level, level2;
+	ATTRIB *attr;
+	mft_inode *mi;
+	u32 e_size, root_size, new_root_size;
+	size_t trim_bit;
+	const struct INDEX_NAMES *in;
+
+	fnd =3D fnd_get(indx);
+	if (!fnd) {
+		err =3D -ENOMEM;
+		goto out2;
+	}
+
+	fnd2 =3D fnd_get(NULL);
+	if (!fnd2) {
+		err =3D -ENOMEM;
+		goto out1;
+	}
+
+	root =3D indx_get_root(indx, ni, &attr, &mi);
+	if (!root) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* Locate the entry to remove. */
+	err =3D indx_find(indx, ni, root, key, key_len, ctx, &diff, &e, fnd);
+	if (err)
+		goto out;
+
+	if (!e || diff) {
+		err =3D -ENOENT;
+		goto out;
+	}
+
+	level =3D fnd->level;
+
+	if (level) {
+		n =3D fnd->nodes[level - 1];
+		e =3D fnd->de[level - 1];
+		ib =3D n->index;
+		hdr =3D &ib->ihdr;
+	} else {
+		hdr =3D &root->ihdr;
+		e =3D fnd->root_de;
+		n =3D NULL;
+	}
+
+	e_size =3D le16_to_cpu(e->size);
+
+	if (!de_has_vcn_ex(e)) {
+		/* The entry to delete is a leaf, so we can just rip it out */
+		hdr_delete_de(hdr, e);
+
+		if (level) {
+			indx_write(indx, ni, n, 0);
+
+			/*
+			 * Check to see if removing that entry made
+			 * the leaf empty.
+			 */
+			if (ib_is_leaf(ib) && ib_is_empty(ib)) {
+				fnd_pop(fnd);
+				fnd_push(fnd2, n, e);
+			}
+			goto delete_branch;
+		}
+
+		hdr->total =3D hdr->used;
+
+		/* Shrink resident root attribute */
+		mi_resize_attr(mi, attr, 0 - e_size);
+		goto out;
+	}
+
+	/*
+	 * The entry we wish to delete is a node buffer, so we
+	 * have to find a replacement for it.
+	 */
+	next =3D de_get_next(e);
+
+	err =3D indx_get_entry_to_replace(indx, ni, next, &re, fnd2);
+	if (err)
+		goto out;
+
+	if (re) {
+		de_set_vbn_le(re, de_get_vbn_le(e));
+		hdr_delete_de(hdr, e);
+
+		err =3D level ? indx_insert_into_buffer(indx, ni, root, re, ctx,
+						      fnd->level - 1, fnd) :
+			      indx_insert_into_root(indx, ni, re, e, ctx, fnd);
+		ntfs_free(re);
+
+		if (err)
+			goto out;
+	} else {
+		/*
+		 * There is no replacement for the current entry.
+		 * This means that the subtree rooted at its node is empty,
+		 * and can be deleted, which turn means that the node can
+		 * just inherit the deleted entry sub_vcn
+		 */
+		indx_free_children(indx, ni, next, true);
+
+		de_set_vbn_le(next, de_get_vbn_le(e));
+		hdr_delete_de(hdr, e);
+		if (level)
+			indx_write(indx, ni, n, 0);
+		else {
+			hdr->total =3D hdr->used;
+
+			/* Shrink resident root attribute */
+			mi_resize_attr(mi, attr, 0 - e_size);
+		}
+	}
+
+delete_branch:
+
+	/* Delete a branch of tree */
+	if (!fnd2 || !fnd2->level)
+		goto out;
+
+	/* Reinit root 'cause it can be changed */
+	root =3D indx_get_root(indx, ni, &attr, &mi);
+	if (!root) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	n2d =3D NULL;
+	sub_vbn =3D fnd2->nodes[0]->index->vbn;
+	level2 =3D 0;
+	level =3D fnd->level;
+
+	hdr =3D level ? &fnd->nodes[level - 1]->index->ihdr : &root->ihdr;
+
+	/* Scan current level */
+	for (e =3D hdr_first_de(hdr);; e =3D hdr_next_de(hdr, e)) {
+		if (!e) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		if (de_has_vcn(e) && sub_vbn =3D=3D de_get_vbn_le(e))
+			break;
+
+		if (de_is_last(e)) {
+			e =3D NULL;
+			break;
+		}
+	}
+
+	if (!e) {
+		/* Do slow search from root */
+		struct indx_node *in;
+
+		fnd_clear(fnd);
+
+		in =3D indx_find_buffer(indx, ni, root, sub_vbn, NULL);
+		if (IS_ERR(in)) {
+			err =3D PTR_ERR(in);
+			goto out;
+		}
+
+		if (in)
+			fnd_push(fnd, in, NULL);
+	}
+
+	/* Merge fnd2 -> fnd */
+	for (level =3D 0; level < fnd2->level; level++) {
+		fnd_push(fnd, fnd2->nodes[level], fnd2->de[level]);
+		fnd2->nodes[level] =3D NULL;
+	}
+	fnd2->level =3D 0;
+
+	hdr =3D NULL;
+	for (level =3D fnd->level; level; level--) {
+		struct indx_node *in =3D fnd->nodes[level - 1];
+
+		ib =3D in->index;
+		if (ib_is_empty(ib)) {
+			sub_vbn =3D ib->vbn;
+		} else {
+			hdr =3D &ib->ihdr;
+			n2d =3D in;
+			level2 =3D level;
+			break;
+		}
+	}
+
+	if (!hdr)
+		hdr =3D &root->ihdr;
+
+	e =3D hdr_first_de(hdr);
+	if (!e) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (hdr =3D=3D &root->ihdr && de_is_last(e))
+		goto collapse_tree;
+
+	prev =3D NULL;
+	while (!de_is_last(e)) {
+		if (de_has_vcn(e) && sub_vbn =3D=3D de_get_vbn_le(e))
+			break;
+		prev =3D e;
+		e =3D hdr_next_de(hdr, e);
+		if (!e) {
+			err =3D -EINVAL;
+			goto out;
+		}
+	}
+
+	if (sub_vbn !=3D de_get_vbn_le(e)) {
+		/*
+		 * Didn't find the parent entry, although this buffer is the parent trai=
l.
+		 * Something is corrupt.
+		 */
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (de_is_last(e)) {
+		/*
+		 * Since we can't remove the end entry, we'll remove its
+		 * predecessor instead. This means we have to transfer the
+		 * predecessor's sub_vcn to the end entry.
+		 * Note: that this index block is not empty, so the
+		 * predecessor must exist
+		 */
+		if (!prev) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		if (de_has_vcn(prev)) {
+			de_set_vbn_le(e, de_get_vbn_le(prev));
+		} else if (de_has_vcn(e)) {
+			le16_sub_cpu(&e->size, sizeof(u64));
+			e->flags &=3D ~NTFS_IE_HAS_SUBNODES;
+			le32_sub_cpu(&hdr->used, sizeof(u64));
+		}
+		e =3D prev;
+	}
+
+	/*
+	 * Copy the current entry into a temporary buffer (stripping off its
+	 * down-pointer, if any) and delete it from the current buffer or root,
+	 * as appropriate.
+	 */
+	e_size =3D le16_to_cpu(e->size);
+	me =3D ntfs_memdup(e, e_size);
+	if (!me) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	if (de_has_vcn(me)) {
+		me->flags &=3D ~NTFS_IE_HAS_SUBNODES;
+		le16_sub_cpu(&me->size, sizeof(u64));
+	}
+
+	hdr_delete_de(hdr, e);
+
+	if (hdr =3D=3D &root->ihdr) {
+		level =3D 0;
+		hdr->total =3D hdr->used;
+
+		/* Shrink resident root attribute */
+		mi_resize_attr(mi, attr, 0 - e_size);
+	} else {
+		indx_write(indx, ni, n2d, 0);
+		level =3D level2;
+	}
+
+	/* Mark unused buffers as free */
+	trim_bit =3D -1;
+	for (; level < fnd->level; level++) {
+		ib =3D fnd->nodes[level]->index;
+		if (ib_is_empty(ib)) {
+			size_t k =3D le64_to_cpu(ib->vbn) >> indx->idx2vbn_bits;
+
+			indx_mark_free(indx, ni, k);
+			if (k < trim_bit)
+				trim_bit =3D k;
+		}
+	}
+
+	fnd_clear(fnd);
+	/*fnd->root_de =3D NULL;*/
+
+	/*
+	 * Re-insert the entry into the tree.
+	 * Find the spot the tree where we want to insert the new entry.
+	 */
+	err =3D indx_insert_entry(indx, ni, me, ctx, fnd);
+	ntfs_free(me);
+	if (err)
+		goto out;
+
+	if (trim_bit !=3D -1)
+		indx_shrink(indx, ni, trim_bit);
+	goto out;
+
+collapse_tree:
+
+	/*
+	 * This tree needs to be collapsed down to an empty root.
+	 * Recreate the index root as an empty leaf and free all the bits the
+	 * index allocation bitmap.
+	 */
+	fnd_clear(fnd);
+	fnd_clear(fnd2);
+
+	in =3D &s_index_names[indx->type];
+
+	err =3D attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
+			    &indx->alloc_run, 0, NULL, false, NULL);
+	err =3D ni_remove_attr(ni, ATTR_ALLOC, in->name, in->name_len, false,
+			     NULL);
+	run_close(&indx->alloc_run);
+
+	err =3D attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
+			    &indx->bitmap_run, 0, NULL, false, NULL);
+	err =3D ni_remove_attr(ni, ATTR_BITMAP, in->name, in->name_len, false,
+			     NULL);
+	run_close(&indx->bitmap_run);
+
+	root =3D indx_get_root(indx, ni, &attr, &mi);
+	if (!root) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	root_size =3D le32_to_cpu(attr->res.data_size);
+	new_root_size =3D sizeof(INDEX_ROOT) + sizeof(NTFS_DE);
+
+	if (new_root_size !=3D root_size &&
+	    !mi_resize_attr(mi, attr, new_root_size - root_size)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* Fill first entry */
+	e =3D (NTFS_DE *)(root + 1);
+	e->ref.low =3D 0;
+	e->ref.high =3D 0;
+	e->ref.seq =3D 0;
+	e->size =3D cpu_to_le16(sizeof(NTFS_DE));
+	e->flags =3D NTFS_IE_LAST; // 0x02
+	e->key_size =3D 0;
+	e->Reserved =3D 0;
+
+	hdr =3D &root->ihdr;
+	hdr->flags =3D 0;
+	hdr->used =3D hdr->total =3D
+		cpu_to_le32(new_root_size - offsetof(INDEX_ROOT, ihdr));
+	mi->dirty =3D true;
+
+	if (in->name =3D=3D I30_NAME)
+		ni->vfs_inode.i_size =3D 0;
+
+out:
+	fnd_put(fnd2);
+out1:
+	indx->changed =3D true;
+	fnd_put(fnd);
+
+out2:
+	return err;
+}
+
+int indx_update_dup(ntfs_inode *ni, ntfs_sb_info *sbi,
+		    const ATTR_FILE_NAME *fname, const NTFS_DUP_INFO *dup,
+		    int sync)
+{
+	int err, diff;
+	NTFS_DE *e =3D NULL;
+	ATTR_FILE_NAME *e_fname;
+	struct ntfs_fnd *fnd;
+	INDEX_ROOT *root;
+	mft_inode *mi;
+	ntfs_index *indx =3D &ni->dir;
+
+	fnd =3D fnd_get(indx);
+	if (!fnd) {
+		err =3D -ENOMEM;
+		goto out1;
+	}
+
+	root =3D indx_get_root(indx, ni, NULL, &mi);
+
+	if (!root) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* Find entries tree and on disk */
+	err =3D indx_find(indx, ni, root, fname, fname_full_size(fname), sbi,
+			&diff, &e, fnd);
+	if (err)
+		goto out;
+
+	if (!e) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (diff) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	e_fname =3D (ATTR_FILE_NAME *)(e + 1);
+
+	if (!memcmp(&e_fname->dup, dup, sizeof(*dup)))
+		goto out;
+
+	memcpy(&e_fname->dup, dup, sizeof(*dup));
+
+	if (fnd->level) {
+		err =3D indx_write(indx, ni, fnd->nodes[fnd->level - 1], sync);
+	} else if (sync) {
+		mi->dirty =3D true;
+		err =3D mi_write(mi, 1);
+	} else {
+		mi->dirty =3D true;
+		mark_inode_dirty(&ni->vfs_inode);
+	}
+
+out:
+	fnd_put(fnd);
+
+out1:
+	return err;
+}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
new file mode 100644
index 000000000000..e34c2f241cd6
--- /dev/null
+++ b/fs/ntfs3/inode.c
@@ -0,0 +1,2068 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/inode.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/iversion.h>
+#include <linux/mpage.h>
+#include <linux/nls.h>
+#include <linux/uio.h>
+#include <linux/version.h>
+#include <linux/writeback.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+/*
+ * ntfs_read_mft
+ *
+ * reads record and parses MFT
+ */
+static struct inode *ntfs_read_mft(struct inode *inode,
+				   const struct cpu_str *name,
+				   const MFT_REF *ref)
+{
+	int err =3D 0;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	mode_t mode =3D 0;
+	ATTR_STD_INFO5 *std5 =3D NULL;
+	ATTR_LIST_ENTRY *le;
+	ATTRIB *attr;
+	bool is_encrypted =3D false;
+	bool is_match =3D false;
+	bool is_root =3D false;
+	bool is_dir;
+	unsigned long ino =3D inode->i_ino;
+	u32 rp_fa =3D 0, asize, t32;
+	u16 roff, rsize, names =3D 0;
+	const ATTR_FILE_NAME *fname =3D NULL;
+	const INDEX_ROOT *root;
+	REPARSE_DATA_BUFFER rp; // 0x18 bytes
+	u64 t64;
+	MFT_REC *rec;
+	struct runs_tree *run;
+
+	inode->i_op =3D NULL;
+
+	err =3D mi_init(&ni->mi, sbi, ino);
+	if (err)
+		goto out;
+
+	if (!sbi->mft.ni && ino =3D=3D MFT_REC_MFT && !sb->s_root) {
+		t64 =3D sbi->mft.lbo >> sbi->cluster_bits;
+		t32 =3D bytes_to_cluster(sbi, MFT_REC_VOL * sbi->record_size);
+		sbi->mft.ni =3D ni;
+		init_rwsem(&ni->file.run_lock);
+
+		if (!run_add_entry(&ni->file.run, 0, t64, t32)) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+	}
+
+	err =3D mi_read(&ni->mi, ino =3D=3D MFT_REC_MFT);
+
+	if (err)
+		goto out;
+
+	rec =3D ni->mi.mrec;
+
+	if (sbi->flags & NTFS_FLAGS_LOG_REPLAING)
+		;
+	else if (ref->seq !=3D rec->seq) {
+		err =3D -EINVAL;
+		ntfs_error(sb, "MFT: r=3D%lx, expect seq=3D%x instead of %x!", ino,
+			   le16_to_cpu(ref->seq), le16_to_cpu(rec->seq));
+		goto out;
+	} else if (!is_rec_inuse(rec)) {
+		err =3D -EINVAL;
+		ntfs_error(sb, "Inode r=3D%x is not in use!", (u32)ino);
+		goto out;
+	}
+
+	if (le32_to_cpu(rec->total) !=3D sbi->record_size) {
+		// bad inode?
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (!is_rec_base(rec))
+		goto Ok;
+
+	/* record should contain $I30 root */
+	is_dir =3D rec->flags & RECORD_FLAG_DIR;
+
+	inode->i_generation =3D le16_to_cpu(rec->seq);
+
+	/* Enumerate all struct Attributes MFT */
+	le =3D NULL;
+	attr =3D NULL;
+next_attr:
+	err =3D -EINVAL;
+	attr =3D ni_enum_attr_ex(ni, attr, &le);
+	if (!attr)
+		goto end_enum;
+
+	if (le && le->vcn) {
+		if (ino =3D=3D MFT_REC_MFT && attr->type =3D=3D ATTR_DATA) {
+			run =3D &ni->file.run;
+			asize =3D le32_to_cpu(attr->size);
+			goto attr_unpack_run;
+		}
+		goto next_attr;
+	}
+
+	roff =3D attr->non_res ? 0 : le16_to_cpu(attr->res.data_off);
+	rsize =3D attr->non_res ? 0 : le32_to_cpu(attr->res.data_size);
+	asize =3D le32_to_cpu(attr->size);
+
+	if (attr->type !=3D ATTR_STD)
+		goto check_list;
+
+	if (attr->non_res)
+		goto out;
+
+	if (asize < sizeof(ATTR_STD_INFO) + roff)
+		goto out;
+	if (rsize < sizeof(ATTR_STD_INFO))
+		goto out;
+
+	if (std5)
+		goto next_attr;
+
+	std5 =3D Add2Ptr(attr, roff);
+
+#ifdef STATX_BTIME
+	nt2kernel(std5->cr_time, &ni->i_crtime);
+#endif
+	nt2kernel(std5->a_time, &inode->i_atime);
+	nt2kernel(std5->c_time, &inode->i_ctime);
+	nt2kernel(std5->m_time, &inode->i_mtime);
+
+	ni->std_fa =3D std5->fa;
+
+	if (asize < sizeof(ATTR_STD_INFO5) + roff)
+		goto next_attr;
+	if (rsize < sizeof(ATTR_STD_INFO5))
+		goto next_attr;
+
+	ni->std_security_id =3D std5->security_id;
+	goto next_attr;
+
+check_list:
+	if (attr->type !=3D ATTR_LIST)
+		goto check_name;
+
+	if (attr->name_len)
+		goto out;
+
+	if (le)
+		goto out;
+
+	if (ino =3D=3D MFT_REC_LOG)
+		goto out;
+
+	err =3D ntfs_load_attr_list(ni, attr);
+	if (err)
+		goto out;
+
+	le =3D NULL;
+	attr =3D NULL;
+	goto next_attr;
+
+check_name:
+	if (attr->type !=3D ATTR_NAME)
+		goto check_data;
+
+	if (attr->non_res)
+		goto out;
+	if (asize < SIZEOF_ATTRIBUTE_FILENAME + roff)
+		goto out;
+	if (rsize < SIZEOF_ATTRIBUTE_FILENAME)
+		goto out;
+
+	fname =3D Add2Ptr(attr, roff);
+	if (fname->type =3D=3D FILE_NAME_DOS)
+		goto next_attr;
+
+	names +=3D 1;
+	if (!name || name->len !=3D fname->name_len)
+		goto next_attr;
+
+	if (!ntfs_cmp_names_cpu(name, (struct le_str *)&fname->name_len, NULL))
+		is_match =3D true;
+
+	goto next_attr;
+
+check_data:
+	run =3D NULL;
+	if (attr->type !=3D ATTR_DATA)
+		goto check_root;
+
+	if (is_dir)
+		goto next_attr;
+
+	if (ino =3D=3D MFT_REC_BADCLUST && !attr->non_res)
+		goto next_attr;
+
+	if (!attr->name_len)
+		goto check_data_attr;
+
+	if ((ino !=3D MFT_REC_BADCLUST || !attr->non_res ||
+	     attr->name_len !=3D ARRAY_SIZE(BAD_NAME) ||
+	     memcmp(attr_name(attr), BAD_NAME, sizeof(BAD_NAME))) &&
+	    (ino !=3D MFT_REC_SECURE || !attr->non_res ||
+	     attr->name_len !=3D ARRAY_SIZE(SDS_NAME) ||
+	     memcmp(attr_name(attr), SDS_NAME, sizeof(SDS_NAME)))) {
+		goto next_attr;
+	}
+
+	/* $Secure::SDS, $BadClus::$Bad */
+check_data_attr:
+
+	if (is_attr_sparsed(attr))
+		ni->std_fa |=3D FILE_ATTRIBUTE_SPARSE_FILE;
+	else
+		ni->std_fa &=3D ~FILE_ATTRIBUTE_SPARSE_FILE;
+
+	if (is_attr_compressed(attr))
+		ni->std_fa |=3D FILE_ATTRIBUTE_COMPRESSED;
+	else
+		ni->std_fa &=3D ~FILE_ATTRIBUTE_COMPRESSED;
+
+	if (is_attr_encrypted(attr))
+		ni->std_fa |=3D FILE_ATTRIBUTE_ENCRYPTED;
+	else
+		ni->std_fa &=3D ~FILE_ATTRIBUTE_ENCRYPTED;
+
+	if (!attr->non_res) {
+		ni->i_valid =3D inode->i_size =3D rsize;
+		inode_set_bytes(inode, rsize);
+		t32 =3D asize;
+	} else {
+		t32 =3D le16_to_cpu(attr->nres.run_off);
+	}
+
+	if (sbi->options.fmask) {
+		/* use mount options "fmask" or "umask" */
+		mode =3D S_IFREG | (0777 & sbi->options.fs_fmask);
+	} else {
+		/* by default ~(current->fs->umask) */
+		mode =3D S_IFREG | (0777 & sbi->options.fs_fmask);
+	}
+
+	if (!attr->non_res) {
+		ni->ni_flags |=3D NI_FLAG_RESIDENT;
+		goto next_attr;
+	}
+
+	inode_set_bytes(inode, attr_ondisk_size(attr));
+
+	ni->i_valid =3D le64_to_cpu(attr->nres.valid_size);
+	inode->i_size =3D le64_to_cpu(attr->nres.data_size);
+	if (!attr->nres.alloc_size)
+		goto next_attr;
+
+	run =3D ino =3D=3D MFT_REC_BITMAP ? &sbi->used.bitmap.run : &ni->file.run=
;
+	goto attr_unpack_run;
+
+check_root:
+	if (attr->type !=3D ATTR_ROOT)
+		goto check_alloc;
+
+	if (attr->non_res)
+		goto out;
+
+	root =3D Add2Ptr(attr, roff);
+	is_root =3D true;
+
+	if (attr->name_len !=3D ARRAY_SIZE(I30_NAME))
+		goto next_attr;
+
+	if (memcmp(attr_name(attr), I30_NAME, sizeof(I30_NAME)))
+		goto next_attr;
+
+	if (root->type !=3D ATTR_NAME ||
+	    root->rule !=3D NTFS_COLLATION_TYPE_FILENAME)
+		goto out;
+
+	if (!is_dir)
+		goto next_attr;
+
+	ni->ni_flags |=3D NI_FLAG_DIR;
+
+	err =3D indx_init(&ni->dir, sbi, attr, INDEX_MUTEX_I30);
+	if (err)
+		goto out;
+
+	if (sbi->options.dmask) {
+		/* use mount options "dmask" or "umask" */
+		mode =3D S_IFDIR | (0777 & sbi->options.fs_dmask);
+	} else if (!sb->s_root) {
+		/* Read root inode while mounting */
+		mode =3D S_IFDIR | 0777;
+	} else {
+		/* by default ~(current->fs->umask) */
+		mode =3D S_IFDIR | (0777 & sbi->options.fs_dmask);
+	}
+
+	goto next_attr;
+
+check_alloc:
+	if (attr->type !=3D ATTR_ALLOC)
+		goto check_bitmap;
+	if (!is_root)
+		goto next_attr;
+
+	if (attr->name_len !=3D ARRAY_SIZE(I30_NAME))
+		goto next_attr;
+
+	if (memcmp(attr_name(attr), I30_NAME, sizeof(I30_NAME)))
+		goto next_attr;
+
+	inode->i_size =3D le64_to_cpu(attr->nres.data_size);
+	ni->i_valid =3D le64_to_cpu(attr->nres.valid_size);
+	inode_set_bytes(inode, le64_to_cpu(attr->nres.alloc_size));
+
+	run =3D &ni->dir.alloc_run;
+	goto attr_unpack_run;
+
+check_bitmap:
+	if (attr->type !=3D ATTR_BITMAP)
+		goto check_reparse;
+
+	if (ino !=3D MFT_REC_MFT)
+		goto check_dir_bitmap;
+
+	if (!attr->non_res)
+		goto out;
+#ifndef NTFS3_64BIT_CLUSTER
+	/* 0x20000000 =3D 2^32 / 8 */
+	if (le64_to_cpu(attr->nres.alloc_size) >=3D 0x20000000)
+		goto out;
+#endif
+	run =3D &sbi->mft.bitmap.run;
+	goto attr_unpack_run;
+
+check_dir_bitmap:
+	if (!is_dir)
+		goto next_attr;
+
+	if (attr->name_len !=3D ARRAY_SIZE(I30_NAME))
+		goto next_attr;
+	if (memcmp(attr_name(attr), I30_NAME, sizeof(I30_NAME)))
+		goto next_attr;
+
+	if (!attr->non_res)
+		goto next_attr;
+	run =3D &ni->dir.bitmap_run;
+	goto attr_unpack_run;
+
+check_reparse:
+	if (attr->type !=3D ATTR_REPARSE)
+		goto check_ea;
+
+	if (attr->name_len)
+		goto next_attr;
+
+	rp_fa =3D ni_parse_reparse(ni, attr, &rp);
+	switch (rp_fa) {
+	case REPARSE_LINK:
+		if (!attr->non_res) {
+			inode->i_size =3D rsize;
+			inode_set_bytes(inode, rsize);
+			t32 =3D asize;
+		} else {
+			inode->i_size =3D le64_to_cpu(attr->nres.data_size);
+			t32 =3D le16_to_cpu(attr->nres.run_off);
+		}
+
+		/* Looks like normal symlink */
+		ni->i_valid =3D inode->i_size;
+
+		/* Clear directory bit */
+		if (ni->ni_flags & NI_FLAG_DIR) {
+			indx_clear(&ni->dir);
+			memset(&ni->dir, 0, sizeof(ni->dir));
+			ni->ni_flags &=3D ~NI_FLAG_DIR;
+		} else {
+			run_close(&ni->file.run);
+		}
+		mode =3D S_IFLNK | 0777;
+		is_dir =3D false;
+		if (attr->non_res) {
+			run =3D &ni->file.run;
+			goto attr_unpack_run;
+		}
+		break;
+
+	case REPARSE_COMPRESSED:
+		break;
+
+	case REPARSE_DEDUPLICATED:
+		break;
+	}
+	goto next_attr;
+
+check_ea:
+	if (attr->type !=3D ATTR_EA_INFO)
+		goto check_logged;
+
+	if (!attr->name_len)
+		ni->ni_flags |=3D NI_FLAG_EA;
+	goto next_attr;
+
+check_logged:
+	if (attr->type !=3D ATTR_LOGGED_UTILITY_STREAM)
+		goto next_attr;
+
+	if (attr->name_len !=3D ARRAY_SIZE(EFS_NAME))
+		goto next_attr;
+	if (memcmp(EFS_NAME, attr_name(attr), sizeof(EFS_NAME)))
+		goto next_attr;
+	is_encrypted =3D true;
+	goto next_attr;
+
+attr_unpack_run:
+	if (!run)
+		goto next_attr;
+
+	roff =3D le16_to_cpu(attr->nres.run_off);
+
+	err =3D run_unpack_ex(run, sbi, ino, le64_to_cpu(attr->nres.svcn),
+			    le64_to_cpu(attr->nres.evcn), Add2Ptr(attr, roff),
+			    asize - roff);
+	if (err < 0)
+		goto out;
+	err =3D 0;
+	goto next_attr;
+
+end_enum:
+
+	if (!std5)
+		goto out;
+
+	if (!is_match && name) {
+		/* reuse rec as buffer for ascii name */
+		err =3D -ENOENT;
+		goto out;
+	}
+
+	if (std5->fa & FILE_ATTRIBUTE_READONLY)
+		mode &=3D ~0222;
+
+	/* Setup 'uid' and 'gid' */
+	inode->i_uid =3D sbi->options.fs_uid;
+	inode->i_gid =3D sbi->options.fs_gid;
+
+	if (!names) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (S_ISDIR(mode)) {
+		ni->std_fa |=3D FILE_ATTRIBUTE_DIRECTORY;
+
+		/*
+		 * dot and dot-dot should be included in count but was not
+		 * included in enumeration.
+		 * Usually a hard links to directories are disabled
+		 */
+		set_nlink(inode, 1);
+		inode->i_op =3D &ntfs_dir_inode_operations;
+		inode->i_fop =3D &ntfs_dir_operations;
+		ni->i_valid =3D 0;
+	} else if (S_ISLNK(mode)) {
+		ni->std_fa &=3D ~FILE_ATTRIBUTE_DIRECTORY;
+		inode->i_op =3D &ntfs_link_inode_operations;
+		inode->i_fop =3D NULL;
+		inode_nohighmem(inode); // ??
+		set_nlink(inode, names);
+	} else if (S_ISREG(mode)) {
+		ni->std_fa &=3D ~FILE_ATTRIBUTE_DIRECTORY;
+
+		set_nlink(inode, names);
+
+		inode->i_op =3D &ntfs_file_inode_operations;
+		inode->i_fop =3D &ntfs_file_operations;
+		inode->i_mapping->a_ops =3D
+			is_compressed(ni) ? &ntfs_aops_cmpr : &ntfs_aops;
+
+		if (ino !=3D MFT_REC_MFT)
+			init_rwsem(&ni->file.run_lock);
+	} else if (fname && fname->home.low =3D=3D cpu_to_le32(MFT_REC_EXTEND) &&
+		   fname->home.seq =3D=3D cpu_to_le16(MFT_REC_EXTEND)) {
+		/* Records in $Extend are not a files or general directories */
+	} else {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if ((sbi->options.sys_immutable &&
+	     (std5->fa & FILE_ATTRIBUTE_SYSTEM)) &&
+	    !S_ISFIFO(mode) && !S_ISSOCK(mode) && !S_ISLNK(mode)) {
+		inode->i_flags |=3D S_IMMUTABLE;
+	} else {
+		inode->i_flags &=3D ~S_IMMUTABLE;
+	}
+
+	inode->i_mode =3D mode;
+
+Ok:
+	if (ino =3D=3D MFT_REC_MFT && !sb->s_root)
+		sbi->mft.ni =3D NULL;
+
+	unlock_new_inode(inode);
+
+	return inode;
+
+out:
+	if (ino =3D=3D MFT_REC_MFT && !sb->s_root)
+		sbi->mft.ni =3D NULL;
+
+	iget_failed(inode);
+
+	return ERR_PTR(err);
+}
+
+/* returns 1 if match */
+static int ntfs_test_inode(struct inode *inode, const MFT_REF *ref)
+{
+	return ino_get(ref) =3D=3D inode->i_ino &&
+	       ref->seq =3D=3D ntfs_i(inode)->mi.mrec->seq;
+}
+
+static int ntfs_set_inode(struct inode *inode, const MFT_REF *ref)
+{
+	inode->i_ino =3D ino_get(ref);
+
+	return 0;
+}
+
+struct inode *ntfs_iget5(struct super_block *sb, const MFT_REF *ref,
+			 const struct cpu_str *name)
+{
+	struct inode *inode;
+
+	inode =3D iget5_locked(sb, ino_get(ref),
+			     (int (*)(struct inode *, void *))ntfs_test_inode,
+			     (int (*)(struct inode *, void *))ntfs_set_inode,
+			     (void *)ref);
+	if (unlikely(!inode))
+		return ERR_PTR(-ENOMEM);
+
+	/* If this is a freshly allocated inode, need to read it now. */
+	if (!(inode->i_state & I_NEW))
+		return inode;
+
+	return ntfs_read_mft(inode, name, ref);
+}
+
+enum get_block_ctx {
+	GET_BLOCK_GENERAL =3D 0,
+	GET_BLOCK_WRITE_BEGIN =3D 1,
+	GET_BLOCK_DIRECT_IO_R =3D 2,
+	GET_BLOCK_DIRECT_IO_W =3D 3,
+	GET_BLOCK_BMAP =3D 4,
+};
+
+static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
+				       struct buffer_head *bh, int create,
+				       enum get_block_ctx ctx)
+{
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	struct page *page;
+	u64 bytes, pbo;
+	u32 off;
+	int err;
+	CLST vcn, lcn, len;
+	u8 cluster_bits =3D sbi->cluster_bits;
+	bool new;
+
+	/*clear previous state*/
+	clear_buffer_new(bh);
+	clear_buffer_uptodate(bh);
+
+	/* direct write uses 'create=3D0'*/
+	if (!create && vbo >=3D ni->i_valid && ctx !=3D GET_BLOCK_DIRECT_IO_W)
+		return 0;
+
+	vcn =3D vbo >> cluster_bits;
+	off =3D vbo & sbi->cluster_mask;
+	new =3D false;
+
+	err =3D attr_data_get_block(ni, vcn, &lcn, &len, create ? &new : NULL);
+	if (err)
+		goto out;
+
+	bytes =3D ((u64)len << cluster_bits) - off;
+
+	if (lcn =3D=3D SPARSE_LCN) {
+		if (!create) {
+			if (bh->b_size > bytes)
+				bh->b_size =3D bytes;
+
+			return 0;
+		}
+		WARN_ON(1);
+	}
+
+	WARN_ON(lcn =3D=3D RESIDENT_LCN);
+
+	if (new) {
+		set_buffer_new(bh);
+		ntfs_sparse_cluster(inode, bh->b_page,
+				    (loff_t)vcn << sbi->cluster_bits,
+				    sbi->cluster_size);
+	}
+
+	pbo =3D ((u64)lcn << cluster_bits) + off;
+
+	set_buffer_mapped(bh);
+	bh->b_bdev =3D sb->s_bdev;
+	bh->b_blocknr =3D pbo >> sb->s_blocksize_bits;
+
+	if (ctx =3D=3D GET_BLOCK_DIRECT_IO_W) {
+		/*ntfs_direct_IO will update ni->i_valid */
+		if (vbo >=3D ni->i_valid)
+			set_buffer_new(bh);
+	} else if (create && ctx =3D=3D GET_BLOCK_WRITE_BEGIN &&
+		   vbo + bh->b_size > ni->i_valid) {
+		u32 voff =3D ni->i_valid > vbo ? (ni->i_valid - vbo) : 0;
+
+		off =3D bh_offset(bh);
+		page =3D bh->b_page;
+
+		zero_user_segment(page, off + voff, off + bh->b_size);
+		set_buffer_uptodate(bh);
+		ni->i_valid =3D vbo + bh->b_size;
+
+		/* ntfs_write_end will update ni->i_valid*/
+	} else if (create) {
+		/*normal write*/
+		if (vbo >=3D ni->i_valid) {
+			set_buffer_new(bh);
+			if (bytes > bh->b_size)
+				bytes =3D bh->b_size;
+			ni->i_valid =3D vbo + bytes;
+			mark_inode_dirty(inode);
+		}
+	} else if (vbo >=3D ni->i_valid) {
+		/* read out of valid data*/
+		/* should never be here 'cause already checked */
+		clear_buffer_mapped(bh);
+	} else if (vbo + bytes <=3D ni->i_valid) {
+		/* normal read */
+	} else {
+		/* here: vbo <=3D ni->i_valid && ni->i_valid < vbo + bytes */
+		u64 valid_up =3D
+			(ni->i_valid + PAGE_SIZE - 1) & ~(u64)(PAGE_SIZE - 1);
+
+		bytes =3D valid_up - vbo;
+		if (bytes < sb->s_blocksize)
+			bytes =3D sb->s_blocksize;
+	}
+
+	if (bh->b_size > bytes)
+		bh->b_size =3D bytes;
+
+#ifndef __LP64__
+	if (ctx =3D=3D GET_BLOCK_DIRECT_IO_W || ctx =3D=3D GET_BLOCK_DIRECT_IO_R)=
 {
+		static_assert(sizeof(size_t) < sizeof(loff_t));
+		if (bytes > 0x40000000u)
+			bh->b_size =3D 0x40000000u;
+	}
+#endif
+
+	return 0;
+
+out:
+	return err;
+}
+
+/*ntfs_readpage*/
+/*ntfs_readpages*/
+/*ntfs_writepage*/
+/*ntfs_writepages*/
+/*ntfs_block_truncate_page*/
+int ntfs_get_block(struct inode *inode, sector_t vbn,
+		   struct buffer_head *bh_result, int create)
+{
+	return ntfs_get_block_vbo(inode, (u64)vbn << inode->i_blkbits,
+				  bh_result, create, GET_BLOCK_GENERAL);
+}
+
+/*ntfs_bmap*/
+static int ntfs_get_block_bmap(struct inode *inode, sector_t vsn,
+			       struct buffer_head *bh_result, int create)
+{
+	return ntfs_get_block_vbo(inode, (u64)vsn << 9, bh_result, create,
+				  GET_BLOCK_BMAP);
+}
+
+static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
+{
+	return generic_block_bmap(mapping, block, ntfs_get_block_bmap);
+}
+
+int ntfs_readpage(struct file *file, struct page *page)
+{
+	int err;
+	struct address_space *mapping =3D page->mapping;
+	struct inode *inode =3D mapping->host;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	u64 vbo =3D (u64)page->index << PAGE_SHIFT;
+	u64 valid;
+	ATTRIB *attr;
+	const char *data;
+	u32 data_size;
+
+	if (!ni_has_resident_data(ni))
+		goto read_non_resident;
+
+	ni_lock(ni);
+
+	if (!ni_has_resident_data(ni)) {
+		ni_unlock(ni);
+		goto read_non_resident;
+	}
+
+	attr =3D ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL, NULL);
+	if (!attr) {
+		err =3D -EINVAL;
+		ni_unlock(ni);
+		unlock_page(page);
+		goto out;
+	}
+
+	WARN_ON(attr->non_res);
+
+	vbo =3D page->index << PAGE_SHIFT;
+	data =3D resident_data(attr);
+	data_size =3D le32_to_cpu(attr->res.data_size);
+
+	if (vbo < data_size) {
+		void *kaddr =3D kmap_atomic(page);
+
+		err =3D data_size - vbo;
+		if (err > PAGE_SIZE)
+			err =3D PAGE_SIZE;
+
+		memcpy(kaddr, data + vbo, err);
+		flush_dcache_page(page);
+		kunmap_atomic(kaddr);
+		zero_user_segment(page, err, PAGE_SIZE);
+		SetPageUptodate(page);
+	} else if (!PageUptodate(page)) {
+		zero_user_segment(page, 0, PAGE_SIZE);
+		SetPageUptodate(page);
+	}
+
+	ni_unlock(ni);
+	unlock_page(page);
+	return 0;
+
+read_non_resident:
+	if (is_compressed(ni)) {
+		ni_lock(ni);
+		err =3D ni_readpage_cmpr(ni, page);
+		ni_unlock(ni);
+
+		return err;
+	}
+
+	/* normal + sparse files */
+	err =3D mpage_readpage(page, ntfs_get_block);
+	if (err)
+		goto out;
+
+	valid =3D ni->i_valid;
+	if (vbo < valid && valid < vbo + PAGE_SIZE) {
+		if (PageLocked(page))
+			wait_on_page_bit(page, PG_locked);
+		if (PageError(page)) {
+			ntfs_inode_warning(inode, "file garbadge at 0x%llx",
+					   valid);
+			goto out;
+		}
+		zero_user_segment(page, valid & (PAGE_SIZE - 1), PAGE_SIZE);
+	}
+
+out:
+	return err;
+}
+
+static void ntfs_readahead(struct readahead_control *rac)
+{
+	struct address_space *mapping =3D rac->mapping;
+	struct inode *inode =3D mapping->host;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	u64 valid;
+	loff_t pos;
+
+	if (ni_has_resident_data(ni))
+		return;
+
+	WARN_ON(is_compressed(ni));
+
+	valid =3D ni->i_valid;
+	pos =3D readahead_pos(rac);
+
+	if (pos <=3D valid && valid < pos + readahead_length(rac))
+		return;
+
+	mpage_readahead(rac, ntfs_get_block);
+}
+
+/*ntfs_direct_IO*/
+static int ntfs_get_block_direct_IO_R(struct inode *inode, sector_t iblock=
,
+				      struct buffer_head *bh_result, int create)
+{
+	return ntfs_get_block_vbo(inode, (u64)iblock << inode->i_blkbits,
+				  bh_result, create, GET_BLOCK_DIRECT_IO_R);
+}
+
+static int ntfs_get_block_direct_IO_W(struct inode *inode, sector_t iblock=
,
+				      struct buffer_head *bh_result, int create)
+{
+	return ntfs_get_block_vbo(inode, (u64)iblock << inode->i_blkbits,
+				  bh_result, create, GET_BLOCK_DIRECT_IO_W);
+}
+
+static void ntfs_write_failed(struct address_space *mapping, loff_t to)
+{
+	struct inode *inode =3D mapping->host;
+
+	if (to > inode->i_size) {
+		truncate_pagecache(inode, inode->i_size);
+		ntfs_truncate_blocks(inode, inode->i_size);
+	}
+}
+
+static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file =3D iocb->ki_filp;
+	struct address_space *mapping =3D file->f_mapping;
+	struct inode *inode =3D mapping->host;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	size_t count =3D iov_iter_count(iter);
+	loff_t vbo =3D iocb->ki_pos;
+	loff_t end =3D vbo + count;
+	int wr =3D iov_iter_rw(iter) & WRITE;
+	const struct iovec *iov =3D iter->iov;
+	unsigned long nr_segs =3D iter->nr_segs;
+	loff_t valid;
+	ssize_t ret;
+
+	ret =3D blockdev_direct_IO(iocb, inode, iter,
+				 wr ? ntfs_get_block_direct_IO_W :
+				      ntfs_get_block_direct_IO_R);
+	valid =3D ni->i_valid;
+	if (wr) {
+		if (ret < 0)
+			ntfs_write_failed(mapping, end);
+		if (ret <=3D 0)
+			goto out;
+
+		vbo +=3D ret;
+		if (vbo > valid && !S_ISBLK(inode->i_mode)) {
+			ni->i_valid =3D vbo;
+			mark_inode_dirty(inode);
+		}
+	} else if (vbo < valid && valid < end) {
+		/* fix page */
+		unsigned long uaddr =3D ~0ul;
+		struct page *page;
+		long i, npages;
+		size_t dvbo =3D valid - vbo;
+		size_t off =3D 0;
+
+		/*Find user address*/
+		for (i =3D 0; i < nr_segs; i++) {
+			if (off <=3D dvbo && dvbo < off + iov[i].iov_len) {
+				uaddr =3D (unsigned long)iov[i].iov_base + dvbo -
+					off;
+				break;
+			}
+			off +=3D iov[i].iov_len;
+		}
+
+		if (uaddr =3D=3D ~0ul)
+			goto fix_error;
+
+		npages =3D get_user_pages_unlocked(uaddr, 1, &page, FOLL_WRITE);
+
+		if (npages <=3D 0)
+			goto fix_error;
+
+		zero_user_segment(page, valid & (PAGE_SIZE - 1), PAGE_SIZE);
+		put_page(page);
+	}
+
+out:
+	return ret;
+fix_error:
+	ntfs_inode_warning(inode, "file garbadge at 0x%llx", valid);
+	goto out;
+}
+
+int ntfs_set_size(struct inode *inode, u64 new_size)
+{
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	int err;
+
+	/* Check for maximum file size */
+	if (is_sparsed(ni) || is_compressed(ni)) {
+		if (new_size > sbi->maxbytes_sparse) {
+			err =3D -EFBIG;
+			goto out;
+		}
+	} else if (new_size > sbi->maxbytes) {
+		err =3D -EFBIG;
+		goto out;
+	}
+
+	ni_lock(ni);
+	down_write(&ni->file.run_lock);
+
+	err =3D attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
+			    &ni->i_valid, true, NULL);
+
+	up_write(&ni->file.run_lock);
+	ni_unlock(ni);
+
+	mark_inode_dirty(inode);
+
+out:
+	return err;
+}
+
+static int ntfs_writepage(struct page *page, struct writeback_control *wbc=
)
+{
+	return block_write_full_page(page, ntfs_get_block, wbc);
+}
+
+static int ntfs_writepage_cmpr(struct page *page, struct writeback_control=
 *wbc)
+{
+	int err;
+	struct address_space *mapping =3D page->mapping;
+	struct inode *inode =3D mapping->host;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	int sync =3D wbc->sync_mode =3D=3D WB_SYNC_ALL;
+
+	if (current->flags & PF_MEMALLOC) {
+redirty:
+		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
+		return 0;
+	}
+
+	if (sync)
+		ni_lock(ni);
+	else if (!ni_trylock(ni))
+		goto redirty;
+
+	err =3D ni_writepage_cmpr(page, sync);
+	ni_unlock(ni);
+
+	return err;
+}
+
+static int ntfs_writepages(struct address_space *mapping,
+			   struct writeback_control *wbc)
+{
+	return mpage_writepages(mapping, wbc, ntfs_get_block);
+}
+
+/*ntfs_write_begin*/
+static int ntfs_get_block_write_begin(struct inode *inode, sector_t vbn,
+				      struct buffer_head *bh_result, int create)
+{
+	return ntfs_get_block_vbo(inode, (u64)vbn << inode->i_blkbits,
+				  bh_result, create, GET_BLOCK_WRITE_BEGIN);
+}
+
+static int ntfs_write_begin(struct file *file, struct address_space *mappi=
ng,
+			    loff_t pos, u32 len, u32 flags, struct page **pagep,
+			    void **fsdata)
+{
+	int err;
+
+	*pagep =3D NULL;
+
+	err =3D block_write_begin(mapping, pos, len, flags, pagep,
+				ntfs_get_block_write_begin);
+	if (err < 0)
+		ntfs_write_failed(mapping, pos + len);
+
+	return err;
+}
+
+/* address_space_operations::write_end */
+static int ntfs_write_end(struct file *file, struct address_space *mapping=
,
+			  loff_t pos, u32 len, u32 copied, struct page *page,
+			  void *fsdata)
+
+{
+	struct inode *inode =3D mapping->host;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	u64 valid =3D ni->i_valid;
+	int err;
+
+	err =3D generic_write_end(file, mapping, pos, len, copied, page, fsdata);
+
+	if (err < len)
+		ntfs_write_failed(mapping, pos + len);
+	if (err >=3D 0) {
+		bool dirty =3D false;
+
+		if (!(ni->std_fa & FILE_ATTRIBUTE_ARCHIVE)) {
+			inode->i_ctime =3D inode->i_mtime =3D current_time(inode);
+			ni->std_fa |=3D FILE_ATTRIBUTE_ARCHIVE;
+			dirty =3D true;
+		}
+
+		if (valid !=3D ni->i_valid) {
+			/* ni->i_valid is changed in ntfs_get_block_vbo */
+			dirty =3D true;
+		}
+
+		if (dirty)
+			mark_inode_dirty(inode);
+	}
+
+	return err;
+}
+
+int reset_log_file(struct inode *inode)
+{
+	int err;
+	loff_t pos =3D 0;
+	u32 log_size =3D inode->i_size;
+	struct address_space *mapping =3D inode->i_mapping;
+
+	for (;;) {
+		u32 len;
+		void *kaddr;
+		struct page *page;
+
+		len =3D pos + PAGE_SIZE > log_size ? (log_size - pos) : PAGE_SIZE;
+
+		err =3D block_write_begin(mapping, pos, len, 0, &page,
+					ntfs_get_block_write_begin);
+		if (err)
+			goto out;
+
+		kaddr =3D kmap_atomic(page);
+		memset(kaddr, -1, len);
+		kunmap_atomic(kaddr);
+		flush_dcache_page(page);
+
+		err =3D block_write_end(NULL, mapping, pos, len, len, page, NULL);
+		if (err < 0)
+			goto out;
+		pos +=3D len;
+
+		if (pos >=3D log_size)
+			break;
+		balance_dirty_pages_ratelimited(mapping);
+	}
+out:
+	mark_inode_dirty_sync(inode);
+
+	return err;
+}
+
+int ntfs_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC) ||
+	    sb_rdonly(inode->i_sb))
+		return 0;
+
+	return _ni_write_inode(inode, wbc->sync_mode =3D=3D WB_SYNC_ALL);
+}
+
+int ntfs_sync_inode(struct inode *inode)
+{
+	return _ni_write_inode(inode, 1);
+}
+
+/*
+ * helper function for ntfs_flush_inodes.  This writes both the inode
+ * and the file data blocks, waiting for in flight data blocks before
+ * the start of the call.  It does not wait for any io started
+ * during the call
+ */
+static int writeback_inode(struct inode *inode)
+{
+	int ret =3D sync_inode_metadata(inode, 0);
+
+	if (!ret)
+		ret =3D filemap_fdatawrite(inode->i_mapping);
+	return ret;
+}
+
+/*
+ * write data and metadata corresponding to i1 and i2.  The io is
+ * started but we do not wait for any of it to finish.
+ *
+ * filemap_flush is used for the block device, so if there is a dirty
+ * page for a block already in flight, we will not wait and start the
+ * io over again
+ */
+int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
+		      struct inode *i2)
+{
+	int ret =3D 0;
+
+	if (i1)
+		ret =3D writeback_inode(i1);
+	if (!ret && i2)
+		ret =3D writeback_inode(i2);
+	if (!ret)
+		ret =3D filemap_flush(sb->s_bdev->bd_inode->i_mapping);
+	return ret;
+}
+
+int inode_write_data(struct inode *inode, const void *data, size_t bytes)
+{
+	pgoff_t idx;
+
+	/* Write non resident data */
+	for (idx =3D 0; bytes; idx++) {
+		size_t op =3D bytes > PAGE_SIZE ? PAGE_SIZE : bytes;
+		struct page *page =3D ntfs_map_page(inode->i_mapping, idx);
+
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+
+		lock_page(page);
+		WARN_ON(!PageUptodate(page));
+		ClearPageUptodate(page);
+
+		memcpy(page_address(page), data, op);
+
+		flush_dcache_page(page);
+		SetPageUptodate(page);
+		unlock_page(page);
+
+		ntfs_unmap_page(page);
+
+		bytes -=3D op;
+		data =3D Add2Ptr(data, PAGE_SIZE);
+	}
+	return 0;
+}
+
+int ntfs_create_inode(struct inode *dir, struct dentry *dentry,
+		      struct file *file, umode_t mode, dev_t dev,
+		      const char *symname, unsigned int size, int excl,
+		      struct ntfs_fnd *fnd, struct inode **new_inode)
+{
+	int err;
+	struct super_block *sb =3D dir->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	const struct qstr *name =3D &dentry->d_name;
+	CLST ino =3D 0;
+	ntfs_inode *dir_ni =3D ntfs_i(dir);
+	ntfs_inode *ni =3D NULL;
+	struct inode *inode =3D NULL;
+	ATTRIB *attr;
+	ATTR_STD_INFO5 *std5;
+	ATTR_FILE_NAME *fname;
+	MFT_REC *rec;
+	u32 asize, dsize, sd_size;
+	FILE_ATTRIBUTE fa;
+	__le32 security_id =3D SECURITY_ID_INVALID;
+	__le32 *def_security;
+	CLST vcn;
+	const void *sd;
+	u16 t16, nsize =3D 0, aid =3D 0;
+	INDEX_ROOT *root, *dir_root;
+	NTFS_DE *e, *new_de =3D NULL;
+	REPARSE_DATA_BUFFER *rp =3D NULL;
+	typeof(rp->SymbolicLink2ReparseBuffer) *rb;
+	__le16 *rp_name;
+	bool is_dir =3D S_ISDIR(mode);
+	bool rp_inserted =3D false;
+	bool is_sp =3D S_ISCHR(mode) || S_ISBLK(mode) || S_ISFIFO(mode) ||
+		     S_ISSOCK(mode);
+
+	if (is_sp)
+		return -EOPNOTSUPP;
+
+	dir_root =3D indx_get_root(&dir_ni->dir, dir_ni, NULL, NULL);
+	if (!dir_root)
+		return -EINVAL;
+
+	fa =3D (is_dir ? (dir_ni->std_fa | FILE_ATTRIBUTE_DIRECTORY) :
+		       S_ISLNK(mode) ?
+		       FILE_ATTRIBUTE_REPARSE_POINT :
+		       sbi->options.sparse ?
+		       FILE_ATTRIBUTE_SPARSE_FILE :
+		       (dir_ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) ?
+		       FILE_ATTRIBUTE_COMPRESSED :
+		       0) |
+	     FILE_ATTRIBUTE_ARCHIVE;
+
+	if (!(mode & 0222)) {
+		mode &=3D ~0222;
+		fa |=3D FILE_ATTRIBUTE_READONLY;
+	}
+
+	new_de =3D __getname();
+	if (!new_de) {
+		err =3D -ENOMEM;
+		goto out1;
+	}
+
+	/*mark rw ntfs as dirty. it will be cleared at umount*/
+	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
+
+	/* Step 1: allocate and fill new mft record */
+	err =3D ntfs_look_free_mft(sbi, &ino, false, NULL, NULL);
+	if (err)
+		goto out2;
+
+	ni =3D ntfs_new_inode(sbi, ino, is_dir);
+	if (IS_ERR(ni)) {
+		err =3D PTR_ERR(ni);
+		ni =3D NULL;
+		goto out3;
+	}
+	inode =3D &ni->vfs_inode;
+
+	inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D ni->i_crtime =3D
+		current_time(inode);
+
+	rec =3D ni->mi.mrec;
+	rec->hard_links =3D cpu_to_le16(1);
+	attr =3D Add2Ptr(rec, le16_to_cpu(rec->attr_off));
+
+	/* Get default security id */
+	if (is_dir) {
+		sd =3D s_dir_security;
+		sd_size =3D sizeof(s_dir_security);
+		def_security =3D &sbi->security.def_dir_id;
+	} else {
+		sd =3D s_file_security;
+		sd_size =3D sizeof(s_file_security);
+		def_security =3D &sbi->security.def_file_id;
+	}
+
+	if (!is_nt5(sbi))
+		goto insert_std;
+
+	security_id =3D dir_ni->std_security_id;
+	if (le32_to_cpu(security_id) >=3D SECURITY_ID_FIRST)
+		goto insert_std;
+
+	security_id =3D *def_security;
+
+	if (security_id =3D=3D SECURITY_ID_INVALID &&
+	    !ntfs_insert_security(sbi, sd, sd_size, &security_id, NULL))
+		*def_security =3D security_id;
+
+insert_std:
+	/* Insert standard info */
+	std5 =3D Add2Ptr(attr, SIZEOF_RESIDENT);
+
+	if (security_id =3D=3D SECURITY_ID_INVALID) {
+		dsize =3D sizeof(ATTR_STD_INFO);
+	} else {
+		dsize =3D sizeof(ATTR_STD_INFO5);
+		std5->security_id =3D security_id;
+	}
+	asize =3D SIZEOF_RESIDENT + dsize;
+
+	attr->type =3D ATTR_STD;
+	attr->size =3D cpu_to_le32(asize);
+	attr->id =3D cpu_to_le16(aid++);
+	attr->res.data_off =3D SIZEOF_RESIDENT_LE;
+	attr->res.data_size =3D cpu_to_le32(dsize);
+
+	std5->cr_time =3D std5->m_time =3D std5->c_time =3D std5->a_time =3D
+		kernel2nt(&inode->i_atime);
+
+	ni->std_fa =3D fa;
+	std5->fa =3D fa;
+
+	attr =3D Add2Ptr(attr, asize);
+
+	/* Insert file name */
+	err =3D fill_name_de(sbi, new_de, name);
+	if (err)
+		goto out4;
+
+	fname =3D (ATTR_FILE_NAME *)(new_de + 1);
+
+	new_de->ref.low =3D cpu_to_le32(ino);
+#ifdef NTFS3_64BIT_CLUSTER
+	new_de->ref.high =3D cpu_to_le16(ino >> 32);
+	fname->home.high =3D cpu_to_le16(dir->i_ino >> 32);
+#endif
+	new_de->ref.seq =3D rec->seq;
+
+	fname->home.low =3D cpu_to_le32(dir->i_ino & 0xffffffff);
+	fname->home.seq =3D dir_ni->mi.mrec->seq;
+
+	fname->dup.cr_time =3D fname->dup.m_time =3D fname->dup.c_time =3D
+		fname->dup.a_time =3D std5->cr_time;
+	fname->dup.alloc_size =3D fname->dup.data_size =3D 0;
+	fname->dup.fa =3D std5->fa;
+	fname->dup.ea_size =3D fname->dup.reparse =3D 0;
+
+	dsize =3D le16_to_cpu(new_de->key_size);
+	asize =3D QuadAlign(SIZEOF_RESIDENT + dsize);
+
+	attr->type =3D ATTR_NAME;
+	attr->size =3D cpu_to_le32(asize);
+	attr->res.data_off =3D SIZEOF_RESIDENT_LE;
+	attr->res.flags =3D RESIDENT_FLAG_INDEXED;
+	attr->id =3D cpu_to_le16(aid++);
+	attr->res.data_size =3D cpu_to_le32(dsize);
+	memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), fname, dsize);
+
+	attr =3D Add2Ptr(attr, asize);
+
+	if (security_id =3D=3D SECURITY_ID_INVALID) {
+		/* Insert security attribute */
+		asize =3D SIZEOF_RESIDENT + QuadAlign(sd_size);
+
+		attr->type =3D ATTR_SECURE;
+		attr->size =3D cpu_to_le32(asize);
+		attr->id =3D cpu_to_le16(aid++);
+		attr->res.data_off =3D SIZEOF_RESIDENT_LE;
+		attr->res.data_size =3D cpu_to_le32(sd_size);
+		memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), sd, sd_size);
+
+		attr =3D Add2Ptr(attr, asize);
+	}
+
+	if (is_dir) {
+		/* Create root of directory */
+		dsize =3D sizeof(INDEX_ROOT) + sizeof(NTFS_DE);
+		asize =3D sizeof(I30_NAME) + SIZEOF_RESIDENT + dsize;
+
+		attr->type =3D ATTR_ROOT;
+		attr->size =3D cpu_to_le32(asize);
+		attr->id =3D cpu_to_le16(aid++);
+
+		attr->name_len =3D ARRAY_SIZE(I30_NAME);
+		attr->name_off =3D SIZEOF_RESIDENT_LE;
+		attr->res.data_off =3D
+			cpu_to_le16(sizeof(I30_NAME) + SIZEOF_RESIDENT);
+		attr->res.data_size =3D cpu_to_le32(dsize);
+		memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), I30_NAME,
+		       sizeof(I30_NAME));
+
+		root =3D Add2Ptr(attr, sizeof(I30_NAME) + SIZEOF_RESIDENT);
+		memcpy(root, dir_root, offsetof(INDEX_ROOT, ihdr));
+		root->ihdr.de_off =3D cpu_to_le32(sizeof(INDEX_HDR)); // 0x10
+		root->ihdr.used =3D
+			cpu_to_le32(sizeof(INDEX_HDR) + sizeof(NTFS_DE));
+		root->ihdr.total =3D root->ihdr.used;
+
+		e =3D Add2Ptr(root, sizeof(INDEX_ROOT));
+		e->size =3D cpu_to_le16(sizeof(NTFS_DE));
+		e->flags =3D NTFS_IE_LAST;
+
+		ni->ni_flags |=3D NI_FLAG_DIR;
+
+		err =3D indx_init(&ni->dir, sbi, attr, INDEX_MUTEX_I30);
+		if (err)
+			goto out4;
+	} else if (S_ISLNK(mode)) {
+		/* Create symlink */
+		dsize =3D 0;
+		asize =3D SIZEOF_RESIDENT;
+
+		/* insert empty ATTR_DATA */
+		attr->type =3D ATTR_DATA;
+		attr->size =3D cpu_to_le32(SIZEOF_RESIDENT);
+		attr->id =3D cpu_to_le16(aid++);
+		attr->name_off =3D SIZEOF_RESIDENT_LE;
+		attr->res.data_off =3D SIZEOF_RESIDENT_LE;
+
+		attr =3D Add2Ptr(attr, asize);
+
+		/*
+		 * Insert ATTR_REPARSE
+		 * Assume each symbol is coded with 2 unicodes and zero
+		 */
+		rp =3D ntfs_alloc(ntfs_reparse_bytes(2 * size + 2), 1);
+		if (!rp) {
+			err =3D -ENOMEM;
+			goto out4;
+		}
+		rb =3D &rp->SymbolicLink2ReparseBuffer;
+		rp_name =3D rb->PathBuffer;
+
+		/* Convert link name to unicode */
+		err =3D x8_to_uni(sbi, symname, size,
+				(struct cpu_str *)(rp_name - 1), 2 * size,
+				UTF16_LITTLE_ENDIAN);
+		if (err < 0)
+			goto out4;
+
+		if (err > 2 * size) {
+			/* Convert to UTF16 requires more than 4 bytes per symbol? */
+			err =3D -EINVAL;
+			goto out4;
+		}
+
+		/* err =3D the length of unicode name of symlink */
+		nsize =3D ntfs_reparse_bytes(err);
+
+		if (nsize > sbi->reparse.max_size) {
+			ntfs_warning(sb, "Symbolic link %u is too big", size);
+			err =3D -EFBIG;
+			goto out4;
+		}
+
+		rp->ReparseTag =3D IO_REPARSE_TAG_SYMLINK;
+		rp->ReparseDataLength =3D cpu_to_le16(
+			(nsize - offsetof(REPARSE_DATA_BUFFER,
+					  SymbolicLink2ReparseBuffer)));
+		rb =3D &rp->SymbolicLink2ReparseBuffer;
+		rb->SubstituteNameOffset =3D cpu_to_le16(sizeof(short) * err);
+		rb->SubstituteNameLength =3D cpu_to_le16(sizeof(short) * err + 8);
+		rb->PrintNameLength =3D rb->SubstituteNameOffset;
+		rb->Flags =3D 0;
+
+		memmove(rp_name + err + 4, rp_name, sizeof(short) * err);
+
+		rp_name +=3D err;
+		rp_name[0] =3D cpu_to_le16('\\');
+		rp_name[1] =3D cpu_to_le16('?');
+		rp_name[2] =3D cpu_to_le16('?');
+		rp_name[3] =3D cpu_to_le16('\\');
+
+		attr->type =3D ATTR_REPARSE;
+		attr->id =3D cpu_to_le16(aid++);
+
+		/* resident or non resident? */
+		asize =3D QuadAlign(SIZEOF_RESIDENT + nsize);
+		t16 =3D PtrOffset(rec, attr);
+
+		if (asize + t16 + 8 > sbi->record_size) {
+			CLST alen;
+			CLST clst =3D bytes_to_cluster(sbi, nsize);
+
+			/* bytes per runs */
+			t16 =3D sbi->record_size - t16 - SIZEOF_NONRESIDENT;
+
+			attr->non_res =3D 1;
+			attr->nres.evcn =3D cpu_to_le64(clst - 1);
+			attr->name_off =3D SIZEOF_NONRESIDENT_LE;
+			attr->nres.run_off =3D attr->name_off;
+			attr->nres.data_size =3D cpu_to_le64(nsize);
+			attr->nres.valid_size =3D attr->nres.data_size;
+			attr->nres.alloc_size =3D
+				cpu_to_le64(ntfs_up_cluster(sbi, nsize));
+
+			err =3D attr_allocate_clusters(sbi, &ni->file.run, 0, 0,
+						     clst, NULL, 0, &alen, 0,
+						     NULL);
+			if (err)
+				goto out5;
+
+			err =3D run_pack(&ni->file.run, 0, clst,
+				       Add2Ptr(attr, SIZEOF_NONRESIDENT), t16,
+				       &vcn);
+			if (err < 0)
+				goto out5;
+
+			if (vcn !=3D clst) {
+				err =3D -EINVAL;
+				goto out5;
+			}
+
+			asize =3D SIZEOF_NONRESIDENT + QuadAlign(err);
+			inode->i_size =3D nsize;
+		} else {
+			attr->res.data_off =3D SIZEOF_RESIDENT_LE;
+			attr->res.data_size =3D cpu_to_le32(nsize);
+			memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), rp, nsize);
+			inode->i_size =3D nsize;
+			nsize =3D 0;
+		}
+
+		attr->size =3D cpu_to_le32(asize);
+
+		err =3D ntfs_insert_reparse(sbi, IO_REPARSE_TAG_SYMLINK,
+					  &new_de->ref);
+		if (err)
+			goto out5;
+
+		rp_inserted =3D true;
+	} else {
+		attr->type =3D ATTR_DATA;
+		attr->id =3D cpu_to_le16(aid++);
+		/* Create non resident data attribute */
+		attr->non_res =3D 1;
+		attr->nres.evcn =3D cpu_to_le64(-1ll);
+		if (fa & FILE_ATTRIBUTE_SPARSE_FILE) {
+			attr->size =3D cpu_to_le32(SIZEOF_NONRESIDENT_EX + 8);
+			attr->name_off =3D SIZEOF_NONRESIDENT_EX_LE;
+			attr->flags =3D ATTR_FLAG_SPARSED;
+			asize =3D SIZEOF_NONRESIDENT_EX + 8;
+		} else if (fa & FILE_ATTRIBUTE_COMPRESSED) {
+			attr->size =3D cpu_to_le32(SIZEOF_NONRESIDENT_EX + 8);
+			attr->name_off =3D SIZEOF_NONRESIDENT_EX_LE;
+			attr->flags =3D ATTR_FLAG_COMPRESSED;
+			attr->nres.c_unit =3D COMPRESSION_UNIT;
+			asize =3D SIZEOF_NONRESIDENT_EX + 8;
+		} else {
+			attr->size =3D cpu_to_le32(SIZEOF_NONRESIDENT + 8);
+			attr->name_off =3D SIZEOF_NONRESIDENT_LE;
+			asize =3D SIZEOF_NONRESIDENT + 8;
+		}
+		attr->nres.run_off =3D attr->name_off;
+	}
+
+	attr =3D Add2Ptr(attr, asize);
+	attr->type =3D ATTR_END;
+
+	rec->used =3D cpu_to_le32(PtrOffset(rec, attr) + 8);
+	rec->next_attr_id =3D cpu_to_le16(aid);
+
+	/* Step 2: Add new name in index */
+	err =3D indx_insert_entry(&dir_ni->dir, dir_ni, new_de, sbi, fnd);
+	if (err)
+		goto out6;
+
+	/* Update current directory record */
+	mark_inode_dirty(dir);
+
+	/* Fill vfs inode fields */
+	inode->i_uid =3D sbi->options.uid ? sbi->options.fs_uid : current_fsuid()=
;
+	inode->i_gid =3D
+		sbi->options.gid ?
+			sbi->options.fs_gid :
+			(dir->i_mode & S_ISGID) ? dir->i_gid : current_fsgid();
+	inode->i_generation =3D le16_to_cpu(rec->seq);
+
+	inode->i_mode =3D mode;
+
+	dir->i_mtime =3D dir->i_ctime =3D inode->i_atime;
+
+	if (is_dir) {
+		inode->i_op =3D &ntfs_dir_inode_operations;
+		inode->i_fop =3D &ntfs_dir_operations;
+	} else if (S_ISLNK(mode)) {
+		inode->i_op =3D &ntfs_link_inode_operations;
+		inode->i_fop =3D NULL;
+		inode->i_mapping->a_ops =3D &ntfs_aops;
+	} else {
+		inode->i_op =3D &ntfs_file_inode_operations;
+		inode->i_fop =3D &ntfs_file_operations;
+		inode->i_mapping->a_ops =3D
+			is_compressed(ni) ? &ntfs_aops_cmpr : &ntfs_aops;
+		init_rwsem(&ni->file.run_lock);
+	}
+
+	/* call 'd_instantiate' after inode->i_op is set */
+	d_instantiate(dentry, inode);
+
+	/* Write non resident data */
+	if (nsize) {
+		err =3D ntfs_sb_write_run(sbi, &ni->file.run, 0, rp, nsize);
+		if (err)
+			goto out7;
+	}
+
+#ifdef NTFS_COUNT_CONTAINED
+	if (S_ISDIR(mode))
+		inc_nlink(dir);
+#endif
+	if (file) {
+		if (is_dir)
+			err =3D finish_no_open(file, NULL);
+		else
+			err =3D finish_open(file, dentry, ntfs_file_open);
+
+		if (err)
+			goto out7;
+		file->f_mode |=3D FMODE_CREATED;
+	}
+
+	/* normal exit */
+	mark_inode_dirty(inode);
+	goto out2;
+
+out7:
+
+	/* undo 'indx_insert_entry' */
+	indx_delete_entry(&dir_ni->dir, dir_ni, new_de + 1,
+			  le16_to_cpu(new_de->key_size), sbi);
+out6:
+	if (rp_inserted)
+		ntfs_remove_reparse(sbi, IO_REPARSE_TAG_SYMLINK, &new_de->ref);
+
+out5:
+	if (is_dir || run_is_empty(&ni->file.run))
+		goto out4;
+
+	run_deallocate(sbi, &ni->file.run, false);
+
+out4:
+	clear_rec_inuse(rec);
+	iput(inode);
+out3:
+	ntfs_mark_rec_free(sbi, ino);
+
+out2:
+	__putname(new_de);
+	ntfs_free(rp);
+
+out1:
+	if (err)
+		return err;
+
+	*new_inode =3D inode;
+	return 0;
+}
+
+int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
+{
+	int err;
+	struct inode *dir =3D d_inode(dentry->d_parent);
+	ntfs_inode *dir_ni =3D ntfs_i(dir);
+	ntfs_inode *ni =3D ntfs_i(inode);
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	const struct qstr *name =3D &dentry->d_name;
+	NTFS_DE *new_de =3D NULL;
+	ATTR_FILE_NAME *fname;
+	ATTRIB *attr;
+	u16 key_size;
+	INDEX_ROOT *dir_root;
+
+	dir_root =3D indx_get_root(&dir_ni->dir, dir_ni, NULL, NULL);
+	if (!dir_root)
+		return -EINVAL;
+
+	new_de =3D __getname();
+	if (!new_de)
+		return -ENOMEM;
+
+	/*mark rw ntfs as dirty. it will be cleared at umount*/
+	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_DIRTY);
+
+	// Insert file name
+	err =3D fill_name_de(sbi, new_de, name);
+	if (err)
+		goto out;
+
+	key_size =3D le16_to_cpu(new_de->key_size);
+	fname =3D (ATTR_FILE_NAME *)(new_de + 1);
+
+	err =3D ni_insert_resident(ni, key_size, ATTR_NAME, NULL, 0, &attr, NULL)=
;
+	if (err)
+		goto out;
+
+	new_de->ref.low =3D cpu_to_le32(inode->i_ino);
+#ifdef NTFS3_64BIT_CLUSTER
+	new_de->ref.high =3D cpu_to_le16(inode->i_ino >> 32);
+	fname->home.high =3D cpu_to_le16(dir->i_ino >> 32);
+#endif
+	new_de->ref.seq =3D ni->mi.mrec->seq;
+
+	fname->home.low =3D cpu_to_le32(dir->i_ino & 0xffffffff);
+	fname->home.seq =3D dir_ni->mi.mrec->seq;
+
+	fname->dup.cr_time =3D fname->dup.m_time =3D fname->dup.c_time =3D
+		fname->dup.a_time =3D kernel2nt(&inode->i_ctime);
+	fname->dup.alloc_size =3D fname->dup.data_size =3D 0;
+	fname->dup.fa =3D ni->std_fa;
+	fname->dup.ea_size =3D fname->dup.reparse =3D 0;
+
+	memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), fname, key_size);
+
+	err =3D indx_insert_entry(&dir_ni->dir, dir_ni, new_de, sbi, NULL);
+	if (err)
+		goto out;
+
+	le16_add_cpu(&ni->mi.mrec->hard_links, 1);
+	ni->mi.dirty =3D true;
+
+out:
+	__putname(new_de);
+	return err;
+}
+
+/*
+ * ntfs_unlink_inode
+ *
+ * inode_operations::unlink
+ * inode_operations::rmdir
+ */
+int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
+{
+	int err;
+	struct super_block *sb =3D dir->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	struct inode *inode =3D d_inode(dentry);
+	ntfs_inode *ni =3D ntfs_i(inode);
+	const struct qstr *name =3D &dentry->d_name;
+	ntfs_inode *dir_ni =3D ntfs_i(dir);
+	ntfs_index *indx =3D &dir_ni->dir;
+	struct cpu_str *uni =3D NULL;
+	ATTR_FILE_NAME *fname;
+	u8 name_type;
+	ATTR_LIST_ENTRY *le;
+	MFT_REF ref;
+	bool is_dir =3D S_ISDIR(inode->i_mode);
+	INDEX_ROOT *dir_root;
+
+	dir_root =3D indx_get_root(indx, dir_ni, NULL, NULL);
+	if (!dir_root)
+		return -EINVAL;
+
+	if (is_dir && !dir_is_empty(inode)) {
+		err =3D -ENOTEMPTY;
+		goto out1;
+	}
+
+	if (ntfs_is_meta_file(sbi, inode->i_ino)) {
+		err =3D -EINVAL;
+		goto out1;
+	}
+
+	uni =3D __getname();
+	if (!uni) {
+		err =3D -ENOMEM;
+		goto out1;
+	}
+
+	/* Convert input string to unicode */
+	err =3D x8_to_uni(sbi, name->name, name->len, uni, NTFS_NAME_LEN,
+			UTF16_HOST_ENDIAN);
+	if (err < 0)
+		goto out4;
+
+	le =3D NULL;
+
+	/*mark rw ntfs as dirty. it will be cleared at umount*/
+	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
+
+	/* find name in record */
+#ifdef NTFS3_64BIT_CLUSTER
+	ref.low =3D cpu_to_le32(dir->i_ino & 0xffffffff);
+	ref.high =3D cpu_to_le16(dir->i_ino >> 32);
+#else
+	ref.low =3D cpu_to_le32(dir->i_ino & 0xffffffff);
+	ref.high =3D 0;
+#endif
+	ref.seq =3D dir_ni->mi.mrec->seq;
+
+	fname =3D ni_fname_name(ni, uni, &ref, &le);
+	if (!fname) {
+		err =3D -ENOENT;
+		goto out3;
+	}
+
+	name_type =3D paired_name(fname->type);
+
+	err =3D indx_delete_entry(indx, dir_ni, fname, fname_full_size(fname),
+				sbi);
+	if (err)
+		goto out4;
+
+	/* Then remove name from mft */
+	ni_remove_attr_le(ni, attr_from_name(fname), le);
+
+	le16_add_cpu(&ni->mi.mrec->hard_links, -1);
+	ni->mi.dirty =3D true;
+
+	if (name_type =3D=3D FILE_NAME_POSIX)
+		goto skip_short;
+
+	/* Now we should delete name by type */
+	fname =3D ni_fname_type(ni, name_type, &le);
+	if (!fname)
+		goto skip_short;
+
+	err =3D indx_delete_entry(indx, dir_ni, fname, fname_full_size(fname),
+				sbi);
+	if (err)
+		goto out4;
+
+	ni_remove_attr_le(ni, attr_from_name(fname), le);
+
+	le16_add_cpu(&ni->mi.mrec->hard_links, -1);
+
+skip_short:
+out4:
+	switch (err) {
+	case 0:
+		drop_nlink(inode);
+	case -ENOTEMPTY:
+	case -ENOSPC:
+	case -EROFS:
+		break;
+	default:
+		make_bad_inode(inode);
+	}
+
+	dir->i_mtime =3D dir->i_ctime =3D current_time(dir);
+	mark_inode_dirty(dir);
+	inode->i_ctime =3D dir->i_ctime;
+	if (inode->i_nlink)
+		mark_inode_dirty(inode);
+
+#ifdef NTFS_COUNT_CONTAINED
+	if (is_dir) {
+		clear_nlink(inode);
+		drop_nlink(dir);
+		mark_inode_dirty(dir);
+	}
+#endif
+
+out3:
+	__putname(uni);
+out1:
+	return err;
+}
+
+void ntfs_evict_inode(struct inode *inode)
+{
+	truncate_inode_pages_final(&inode->i_data);
+
+	if (inode->i_nlink)
+		_ni_write_inode(inode, inode_needs_sync(inode));
+
+	invalidate_inode_buffers(inode);
+	clear_inode(inode);
+
+	ni_clear(ntfs_i(inode));
+}
+
+static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,
+				      int buflen)
+{
+	int err =3D 0;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	u64 i_size =3D inode->i_size;
+	u16 nlen =3D 0;
+	void *to_free =3D NULL;
+	REPARSE_DATA_BUFFER *rp;
+	struct le_str *uni;
+	ATTRIB *attr;
+
+	/* Reparse data present. Try to parse it */
+	static_assert(!offsetof(REPARSE_DATA_BUFFER, ReparseTag));
+	static_assert(sizeof(u32) =3D=3D sizeof(rp->ReparseTag));
+
+	*buffer =3D 0;
+
+	/* Read into temporal buffer */
+	if (i_size > sbi->reparse.max_size || i_size <=3D sizeof(u32)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	attr =3D ni_find_attr(ni, NULL, NULL, ATTR_REPARSE, NULL, 0, NULL, NULL);
+	if (!attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (!attr->non_res) {
+		rp =3D resident_data_ex(attr, i_size);
+		if (!rp) {
+			err =3D -EINVAL;
+			goto out;
+		}
+	} else {
+		rp =3D ntfs_alloc(i_size, 0);
+		if (!rp) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+		to_free =3D rp;
+		err =3D ntfs_read_run_nb(sbi, &ni->file.run, 0, rp, i_size, NULL);
+		if (err)
+			goto out;
+	}
+
+	err =3D -EINVAL;
+
+	/* Microsoft Tag */
+	switch (rp->ReparseTag) {
+	case IO_REPARSE_TAG_MICROSOFT | IO_REPARSE_TAG_SYMBOLIC_LINK:
+		/* Symbolic link */
+		/* Can we use 'Rp->SymbolicLinkReparseBuffer.PrintNameLength'? */
+		if (i_size <=3D offsetof(REPARSE_DATA_BUFFER,
+				       SymbolicLinkReparseBuffer.PathBuffer))
+			goto out;
+		uni =3D Add2Ptr(rp,
+			      offsetof(REPARSE_DATA_BUFFER,
+				       SymbolicLinkReparseBuffer.PathBuffer) +
+				      le16_to_cpu(rp->SymbolicLinkReparseBuffer
+							  .PrintNameOffset) -
+				      2);
+		nlen =3D le16_to_cpu(
+			rp->SymbolicLinkReparseBuffer.PrintNameLength);
+		goto check_result;
+
+	case IO_REPARSE_TAG_MOUNT_POINT:
+		/* Mount points and junctions */
+		/* Can we use 'Rp->MountPointReparseBuffer.PrintNameLength'? */
+		if (i_size <=3D offsetof(REPARSE_DATA_BUFFER,
+				       MountPointReparseBuffer.PathBuffer))
+			goto out;
+		uni =3D Add2Ptr(rp,
+			      offsetof(REPARSE_DATA_BUFFER,
+				       MountPointReparseBuffer.PathBuffer) +
+				      le16_to_cpu(rp->MountPointReparseBuffer
+							  .PrintNameOffset) -
+				      2);
+		nlen =3D le16_to_cpu(rp->MountPointReparseBuffer.PrintNameLength);
+		goto check_result;
+
+	case IO_REPARSE_TAG_SYMLINK:
+		/* FolderSymbolicLink */
+		/* Can we use 'Rp->SymbolicLink2ReparseBuffer.PrintNameLength'? */
+		if (i_size <=3D offsetof(REPARSE_DATA_BUFFER,
+				       SymbolicLink2ReparseBuffer.PathBuffer))
+			goto out;
+		uni =3D Add2Ptr(rp,
+			      offsetof(REPARSE_DATA_BUFFER,
+				       SymbolicLink2ReparseBuffer.PathBuffer) +
+				      le16_to_cpu(rp->SymbolicLink2ReparseBuffer
+							  .PrintNameOffset) -
+				      2);
+		nlen =3D le16_to_cpu(
+			rp->SymbolicLink2ReparseBuffer.PrintNameLength);
+		goto check_result;
+
+	case IO_REPARSE_TAG_CLOUD:
+	case IO_REPARSE_TAG_CLOUD_1:
+	case IO_REPARSE_TAG_CLOUD_2:
+	case IO_REPARSE_TAG_CLOUD_3:
+	case IO_REPARSE_TAG_CLOUD_4:
+	case IO_REPARSE_TAG_CLOUD_5:
+	case IO_REPARSE_TAG_CLOUD_6:
+	case IO_REPARSE_TAG_CLOUD_7:
+	case IO_REPARSE_TAG_CLOUD_8:
+	case IO_REPARSE_TAG_CLOUD_9:
+	case IO_REPARSE_TAG_CLOUD_A:
+	case IO_REPARSE_TAG_CLOUD_B:
+	case IO_REPARSE_TAG_CLOUD_C:
+	case IO_REPARSE_TAG_CLOUD_D:
+	case IO_REPARSE_TAG_CLOUD_E:
+	case IO_REPARSE_TAG_CLOUD_F:
+		err =3D sizeof("OneDrive") - 1;
+		if (err > buflen)
+			err =3D buflen;
+		memcpy(buffer, "OneDrive", err);
+		goto out;
+
+	default:
+		if (IsReparseTagMicrosoft(rp->ReparseTag))
+			goto out;
+	}
+
+	if (!IsReparseTagNameSurrogate(rp->ReparseTag) ||
+	    i_size <=3D sizeof(REPARSE_POINT)) {
+		goto out;
+	}
+
+	/* Users tag */
+	uni =3D Add2Ptr(rp, sizeof(REPARSE_POINT) - 2);
+	nlen =3D le16_to_cpu(((REPARSE_POINT *)rp)->ReparseDataLength) -
+	       sizeof(REPARSE_POINT);
+
+check_result:
+	/* Convert nlen from bytes to UNICODE chars */
+	nlen >>=3D 1;
+
+	/* Check that name is available */
+	if (!nlen || &uni->name[nlen] > (__le16 *)Add2Ptr(rp, i_size))
+		goto out;
+
+	/* If name is already zero terminated then truncate it now */
+	if (!uni->name[nlen - 1])
+		nlen -=3D 1;
+	uni->len =3D nlen;
+
+	err =3D uni_to_x8(sbi, uni, buffer, buflen);
+
+	if (err < 0)
+		goto out;
+
+	/* Always set last zero */
+	buffer[err] =3D 0;
+
+out:
+	ntfs_free(to_free);
+
+	return err;
+}
+
+static const char *ntfs_get_link(struct dentry *de, struct inode *inode,
+				 struct delayed_call *done)
+{
+	int err;
+	char *ret;
+
+	if (!de)
+		return ERR_PTR(-ECHILD);
+
+	ret =3D kmalloc(PAGE_SIZE, GFP_NOFS);
+	if (!ret)
+		return ERR_PTR(-ENOMEM);
+
+	err =3D ntfs_readlink_hlp(inode, ret, PAGE_SIZE);
+	if (err < 0) {
+		kfree(ret);
+		return ERR_PTR(err);
+	}
+
+	set_delayed_call(done, kfree_link, ret);
+
+	return ret;
+}
+
+const struct inode_operations ntfs_link_inode_operations =3D {
+	.get_link =3D ntfs_get_link,
+	.setattr =3D ntfs_setattr,
+	.listxattr =3D ntfs_listxattr,
+	.permission =3D ntfs_permission,
+	.get_acl =3D ntfs_get_acl,
+	.set_acl =3D ntfs_set_acl,
+};
+
+const struct address_space_operations ntfs_aops =3D { .readpage =3D ntfs_r=
eadpage,
+						    .readahead =3D ntfs_readahead,
+						    .writepage =3D ntfs_writepage,
+						    .writepages =3D
+							    ntfs_writepages,
+						    .write_begin =3D
+							    ntfs_write_begin,
+						    .write_end =3D ntfs_write_end,
+						    .direct_IO =3D ntfs_direct_IO,
+						    .bmap =3D ntfs_bmap };
+
+const struct address_space_operations ntfs_aops_cmpr =3D {
+	.readpage =3D ntfs_readpage,
+	.writepage =3D ntfs_writepage_cmpr,
+	.set_page_dirty =3D __set_page_dirty_nobuffers,
+};
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
new file mode 100644
index 000000000000..af41aec384b1
--- /dev/null
+++ b/fs/ntfs3/super.c
@@ -0,0 +1,1409 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/super.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ *
+ *                 terminology
+ *
+ * vcn - virtual cluster number - offset inside the file in clusters
+ * vbo - virtual byte offset    - offset inside the file in bytes
+ * lcn - logical cluster number - 0 based cluster in clusters heap
+ * pbo - physical byte offset   - absolute position inside volume
+ *
+ */
+
+#include <linux/backing-dev.h>
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/exportfs.h>
+#include <linux/fs.h>
+#include <linux/iversion.h>
+#include <linux/module.h>
+#include <linux/nls.h>
+#include <linux/parser.h>
+#include <linux/seq_file.h>
+#include <linux/statfs.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+/**
+ * ntfs_trace() - print preformated ntfs specific messages.
+ */
+void __ntfs_trace(const struct super_block *sb, const char *level,
+		  const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt =3D fmt;
+	vaf.va =3D &args;
+	if (!sb)
+		printk("%sntfs3: %pV", level, &vaf);
+	else
+		printk("%sntfs3: %s: %pV", level, sb->s_id, &vaf);
+	va_end(args);
+}
+
+/* prints info about inode using dentry case if */
+void __ntfs_inode_trace(struct inode *inode, const char *level, const char=
 *fmt,
+			...)
+{
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	struct dentry *dentry;
+	const char *name =3D "?";
+	char buf[48];
+	va_list args;
+	struct va_format vaf;
+
+	if (!__ratelimit(&sbi->ratelimit))
+		return;
+
+	dentry =3D d_find_alias(inode);
+	if (dentry) {
+		spin_lock(&dentry->d_lock);
+		name =3D (const char *)dentry->d_name.name;
+	} else {
+		snprintf(buf, sizeof(buf), "r=3D%lx", inode->i_ino);
+		name =3D buf;
+	}
+
+	va_start(args, fmt);
+	vaf.fmt =3D fmt;
+	vaf.va =3D &args;
+	printk("%s%s on %s: %pV", level, name, sb->s_id, &vaf);
+	va_end(args);
+
+	if (dentry) {
+		spin_unlock(&dentry->d_lock);
+		dput(dentry);
+	}
+}
+
+void __ntfs_fs_error(struct super_block *sb, int report, const char *fmt, =
...)
+{
+	va_list args;
+	struct va_format vaf;
+
+	if (report) {
+		va_start(args, fmt);
+		vaf.fmt =3D fmt;
+		vaf.va =3D &args;
+		ntfs_error(sb, "%pV", &vaf);
+		va_end(args);
+	}
+	sb->s_flags |=3D SB_RDONLY;
+	ntfs_error(sb, "**** filesystem has been set read-only");
+}
+
+/*
+ * Shared memory struct.
+ * Used to share memory between volumes (e.g. big memory for upcase)
+ */
+static DEFINE_SPINLOCK(s_shared_lock);
+
+static struct {
+	void *ptr;
+	u32 len;
+	int cnt;
+} s_shared[8];
+
+/*
+ * ntfs_set_shared
+ *
+ * Returns 'ptr' if pointer was saved in shared memory
+ * Returns NULL if pointer was not shared
+ */
+void *ntfs_set_shared(void *ptr, u32 bytes)
+{
+	void *ret =3D NULL;
+	int i, j =3D -1;
+
+	spin_lock(&s_shared_lock);
+	for (i =3D 0; i < ARRAY_SIZE(s_shared); i++) {
+		if (!s_shared[i].cnt)
+			j =3D i;
+		else if (bytes =3D=3D s_shared[i].len &&
+			 !memcmp(s_shared[i].ptr, ptr, bytes)) {
+			s_shared[i].cnt +=3D 1;
+			ret =3D s_shared[i].ptr;
+			break;
+		}
+	}
+
+	if (!ret && -1 !=3D j) {
+		s_shared[j].ptr =3D ptr;
+		s_shared[j].len =3D bytes;
+		s_shared[j].cnt =3D 1;
+		ret =3D ptr;
+	}
+	spin_unlock(&s_shared_lock);
+
+	return ret;
+}
+
+/*
+ * ntfs_put_shared
+ *
+ * Returns 'ptr' if pointer is not shared anymore
+ * Returns NULL if pointer is still shared
+ */
+void *ntfs_put_shared(void *ptr)
+{
+	void *ret =3D ptr;
+	int i;
+
+	spin_lock(&s_shared_lock);
+	for (i =3D 0; i < ARRAY_SIZE(s_shared); i++) {
+		if (s_shared[i].cnt && s_shared[i].ptr =3D=3D ptr) {
+			if (--s_shared[i].cnt)
+				ret =3D NULL;
+			break;
+		}
+	}
+	spin_unlock(&s_shared_lock);
+
+	return ret;
+}
+
+static int ntfs_remount(struct super_block *sb, int *flags, char *data)
+{
+	*flags |=3D SB_NODIRATIME | SB_NOATIME;
+	sync_filesystem(sb);
+	return 0;
+}
+
+static struct kmem_cache *ntfs_inode_cachep;
+
+static struct inode *ntfs_alloc_inode(struct super_block *sb)
+{
+	ntfs_inode *ni =3D kmem_cache_alloc(ntfs_inode_cachep, GFP_NOFS);
+
+	if (!ni)
+		return NULL;
+
+	memset(ni, 0, offsetof(ntfs_inode, vfs_inode));
+
+	mutex_init(&ni->ni_lock);
+
+	return &ni->vfs_inode;
+}
+
+static void ntfs_i_callback(struct rcu_head *head)
+{
+	struct inode *inode =3D container_of(head, struct inode, i_rcu);
+	ntfs_inode *ni =3D ntfs_i(inode);
+
+	mutex_destroy(&ni->ni_lock);
+
+	kmem_cache_free(ntfs_inode_cachep, ni);
+}
+
+static void ntfs_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, ntfs_i_callback);
+}
+
+static void init_once(void *foo)
+{
+	ntfs_inode *ni =3D foo;
+
+	inode_init_once(&ni->vfs_inode);
+}
+
+static void close_ntfs(ntfs_sb_info *sbi)
+{
+	ntfs_free(sbi->new_rec);
+	ntfs_free(ntfs_put_shared(sbi->upcase));
+	ntfs_free(sbi->def_table);
+
+	wnd_close(&sbi->mft.bitmap);
+	wnd_close(&sbi->used.bitmap);
+
+	if (sbi->mft.ni)
+		iput(&sbi->mft.ni->vfs_inode);
+
+	if (sbi->security.ni)
+		iput(&sbi->security.ni->vfs_inode);
+
+	if (sbi->reparse.ni)
+		iput(&sbi->reparse.ni->vfs_inode);
+
+	if (sbi->objid.ni)
+		iput(&sbi->objid.ni->vfs_inode);
+
+	if (sbi->volume.ni)
+		iput(&sbi->volume.ni->vfs_inode);
+
+	ntfs_update_mftmirr(sbi, 0);
+
+	indx_clear(&sbi->security.index_sii);
+	indx_clear(&sbi->security.index_sdh);
+	indx_clear(&sbi->reparse.index_r);
+	indx_clear(&sbi->objid.index_o);
+	ntfs_free(sbi->compress.frame_unc);
+	ntfs_free(sbi->compress.ctx);
+
+	unload_nls(sbi->nls);
+
+	ntfs_free(sbi);
+}
+
+extern struct timezone sys_tz;
+
+/*
+ * time_str
+ *
+ * returns current time to print
+ */
+static int time_str(char *buffer, int buffer_len)
+{
+	struct timespec64 ts;
+	struct tm tm;
+
+	ktime_get_coarse_real_ts64(&ts);
+	time64_to_tm(ts.tv_sec, -sys_tz.tz_minuteswest * 60, &tm);
+	return snprintf(buffer, buffer_len, "%ld-%02d-%02d %02d:%02d:%02d",
+			1900 + tm.tm_year, tm.tm_mon + 1, tm.tm_mday,
+			tm.tm_hour, tm.tm_min, tm.tm_sec);
+}
+
+static void ntfs_put_super(struct super_block *sb)
+{
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	char buf[32];
+
+	/*mark rw ntfs as clear, if possible*/
+	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
+
+	close_ntfs(sbi);
+	ntfs_trace(sb, "is unmounted at %.*s\n", time_str(buf, sizeof(buf)),
+		   buf);
+}
+
+static int ntfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	struct super_block *sb =3D dentry->d_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	wnd_bitmap *wnd =3D &sbi->used.bitmap;
+
+	buf->f_type =3D sb->s_magic;
+	buf->f_bsize =3D sbi->cluster_size;
+	buf->f_blocks =3D wnd->nbits;
+
+	buf->f_bfree =3D buf->f_bavail =3D wnd_zeroes(wnd);
+	buf->f_fsid.val[0] =3D (u32)sbi->volume.ser_num;
+	buf->f_fsid.val[1] =3D (u32)(sbi->volume.ser_num >> 32);
+	buf->f_namelen =3D NTFS_NAME_LEN;
+
+	trace_mem_report(0);
+
+	return 0;
+}
+
+static int ntfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	ntfs_sb_info *sbi =3D root->d_sb->s_fs_info;
+	struct mount_options *opts =3D &sbi->options;
+
+	if (opts->uid)
+		seq_printf(m, ",uid=3D%u",
+			   from_kuid_munged(&init_user_ns, opts->fs_uid));
+	if (opts->gid)
+		seq_printf(m, ",gid=3D%u",
+			   from_kgid_munged(&init_user_ns, opts->fs_gid));
+	if (opts->fmask)
+		seq_printf(m, ",fmask=3D%04o", opts->fs_fmask);
+	if (opts->dmask)
+		seq_printf(m, ",dmask=3D%04o", opts->fs_dmask);
+	if (sbi->nls)
+		seq_printf(m, ",nls=3D%s", sbi->nls->charset);
+	if (opts->quiet)
+		seq_puts(m, ",quiet");
+	if (opts->sys_immutable)
+		seq_puts(m, ",sys_immutable");
+	if (opts->discard)
+		seq_puts(m, ",discard");
+	return 0;
+}
+
+/*super_operations::sync_fs*/
+static int ntfs_sync_fs(struct super_block *sb, int wait)
+{
+	int err =3D 0, err2;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	ntfs_inode *ni;
+	struct inode *inode;
+
+	ni =3D sbi->security.ni;
+	if (ni) {
+		inode =3D &ni->vfs_inode;
+		err2 =3D _ni_write_inode(inode, wait);
+		if (err2 && !err)
+			err =3D err2;
+	}
+
+	ni =3D sbi->objid.ni;
+	if (ni) {
+		inode =3D &ni->vfs_inode;
+		err2 =3D _ni_write_inode(inode, wait);
+		if (err2 && !err)
+			err =3D err2;
+	}
+
+	ni =3D sbi->reparse.ni;
+	if (ni) {
+		inode =3D &ni->vfs_inode;
+		err2 =3D _ni_write_inode(inode, wait);
+		if (err2 && !err)
+			err =3D err2;
+	}
+
+	if (!err)
+		ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
+
+	ntfs_update_mftmirr(sbi, wait);
+
+	return err;
+}
+
+static const struct super_operations ntfs_sops =3D {
+	.alloc_inode =3D ntfs_alloc_inode,
+	.destroy_inode =3D ntfs_destroy_inode,
+	.evict_inode =3D ntfs_evict_inode,
+	.put_super =3D ntfs_put_super,
+	.statfs =3D ntfs_statfs,
+	.show_options =3D ntfs_show_options,
+	.sync_fs =3D ntfs_sync_fs,
+	.remount_fs =3D ntfs_remount,
+	.write_inode =3D ntfs_write_inode,
+};
+
+static struct inode *ntfs_export_get_inode(struct super_block *sb, u64 ino=
,
+					   u32 generation)
+{
+	struct inode *inode =3D ilookup(sb, ino);
+
+	if (inode && generation && inode->i_generation !=3D generation) {
+		iput(inode);
+		inode =3D NULL;
+	}
+
+	return inode;
+}
+
+static struct dentry *ntfs_fh_to_dentry(struct super_block *sb, struct fid=
 *fid,
+					int fh_len, int fh_type)
+{
+	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
+				    ntfs_export_get_inode);
+}
+
+static struct dentry *ntfs_fh_to_parent(struct super_block *sb, struct fid=
 *fid,
+					int fh_len, int fh_type)
+{
+	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
+				    ntfs_export_get_inode);
+}
+
+/* TODO: =3D=3D ntfs_sync_inode */
+static int ntfs_nfs_commit_metadata(struct inode *inode)
+{
+	return _ni_write_inode(inode, 1);
+}
+
+static const struct export_operations ntfs_export_ops =3D {
+	.fh_to_dentry =3D ntfs_fh_to_dentry,
+	.fh_to_parent =3D ntfs_fh_to_parent,
+	.get_parent =3D ntfs_get_parent,
+	.commit_metadata =3D ntfs_nfs_commit_metadata,
+};
+
+/* Returns Gb,Mb to print with "%u.%02u Gb" */
+static u32 format_size_gb(const u64 bytes, u32 *mb)
+{
+	/* Do simple right 30 bit shift of 64 bit value */
+	u64 kbytes =3D bytes >> 10;
+	u32 kbytes32 =3D (u32)kbytes;
+
+	*mb =3D (100 * (kbytes32 & 0xfffff) + 0x7ffff) >> 20;
+	if (*mb >=3D 100)
+		*mb =3D 99;
+
+	return (kbytes32 >> 20) | (((u32)(kbytes >> 32)) << 12);
+}
+
+static u32 true_sectors_per_clst(const struct NTFS_BOOT *boot)
+{
+	return boot->sectors_per_clusters <=3D 0x80 ?
+		       boot->sectors_per_clusters :
+		       (1u << (0 - boot->sectors_per_clusters));
+}
+
+/* inits internal info from on-disk boot sector*/
+static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
+			       u64 dev_size)
+{
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	int err;
+	u32 mb, gb, boot_sector_size, sct_per_clst, record_size;
+	u64 sectors, clusters, fs_size, mlcn, mlcn2;
+	struct NTFS_BOOT *boot;
+	struct buffer_head *bh;
+	MFT_REC *rec;
+	u16 fn, ao;
+
+	sbi->volume.blocks =3D dev_size >> PAGE_SHIFT;
+
+	bh =3D ntfs_bread(sb, 0);
+	if (!bh)
+		return -EIO;
+
+	err =3D -EINVAL;
+	boot =3D (struct NTFS_BOOT *)bh->b_data;
+
+	if ('N' !=3D boot->system_id[0] || 'T' !=3D boot->system_id[1] ||
+	    'F' !=3D boot->system_id[2] || 'S' !=3D boot->system_id[3] ||
+	    ' ' !=3D boot->system_id[4] || ' ' !=3D boot->system_id[5] ||
+	    ' ' !=3D boot->system_id[6] || ' ' !=3D boot->system_id[7]) {
+		goto out;
+	}
+
+	/* 0x55AA is not mandaroty. Thanks Maxim Suhanov <no.spam.c@mail.ru>*/
+	/*if (0x55 !=3D boot->boot_magic[0] || 0xAA !=3D boot->boot_magic[1])
+	 *	goto out;
+	 */
+
+	boot_sector_size =3D (u32)boot->bytes_per_sector[1] << 8;
+	if (boot->bytes_per_sector[0] || boot_sector_size < SECTOR_SIZE ||
+	    !is_power_of2(boot_sector_size)) {
+		goto out;
+	}
+
+	sct_per_clst =3D true_sectors_per_clst(boot);
+	if (!is_power_of2(sct_per_clst))
+		goto out;
+
+	mlcn =3D le64_to_cpu(boot->mft_clst);
+	mlcn2 =3D le64_to_cpu(boot->mft2_clst);
+	sectors =3D le64_to_cpu(boot->sectors_per_volume);
+
+	if (mlcn * sct_per_clst >=3D sectors)
+		goto out;
+
+	if (mlcn2 * sct_per_clst >=3D sectors)
+		goto out;
+
+	/* Check MFT record size */
+	if ((boot->record_size < 0 &&
+	     SECTOR_SIZE > (2U << (-boot->record_size))) ||
+	    (boot->record_size >=3D 0 && !is_power_of2(boot->record_size))) {
+		goto out;
+	}
+
+	/* Check index record size */
+	if ((boot->index_size < 0 &&
+	     SECTOR_SIZE > (2U << (-boot->index_size))) ||
+	    (boot->index_size >=3D 0 && !is_power_of2(boot->index_size))) {
+		goto out;
+	}
+
+	sbi->sector_size =3D boot_sector_size;
+	sbi->sector_bits =3D blksize_bits(boot_sector_size);
+	fs_size =3D (sectors + 1) << sbi->sector_bits;
+
+	gb =3D format_size_gb(fs_size, &mb);
+
+	/*
+	 * - Volume formatted and mounted with the same sector size
+	 * - Volume formatted 4K and mounted as 512
+	 * - Volume formatted 512 and mounted as 4K
+	 */
+	if (sbi->sector_size !=3D sector_size) {
+		ntfs_warning(
+			sb,
+			"Different NTFS' sector size and media sector size");
+		dev_size +=3D sector_size - 1;
+	}
+
+	sbi->cluster_size =3D boot_sector_size * sct_per_clst;
+	sbi->cluster_bits =3D blksize_bits(sbi->cluster_size);
+
+	sbi->mft.lbo =3D mlcn << sbi->cluster_bits;
+	sbi->mft.lbo2 =3D mlcn2 << sbi->cluster_bits;
+
+	if (sbi->cluster_size < sbi->sector_size)
+		goto out;
+
+	sbi->cluster_mask =3D sbi->cluster_size - 1;
+	sbi->cluster_mask_inv =3D ~(u64)sbi->cluster_mask;
+	sbi->record_size =3D record_size =3D boot->record_size < 0 ?
+						 1 << (-boot->record_size) :
+						 (u32)boot->record_size
+							 << sbi->cluster_bits;
+
+	if (record_size > MAXIMUM_BYTES_PER_MFT)
+		goto out;
+
+	sbi->record_bits =3D blksize_bits(record_size);
+	sbi->attr_size_tr =3D (5 * record_size >> 4); // ~320 bytes
+
+	sbi->max_bytes_per_attr =3D
+		record_size - QuadAlign(MFTRECORD_FIXUP_OFFSET_1) -
+		QuadAlign(((record_size >> SECTOR_SHIFT) * sizeof(short))) -
+		QuadAlign(sizeof(ATTR_TYPE));
+
+	sbi->index_size =3D boot->index_size < 0 ?
+				  1u << (-boot->index_size) :
+				  (u32)boot->index_size << sbi->cluster_bits;
+
+	sbi->volume.ser_num =3D le64_to_cpu(boot->serial_num);
+	sbi->volume.size =3D sectors << sbi->sector_bits;
+
+	/* warning if RAW volume */
+	if (dev_size < fs_size) {
+		u32 mb0, gb0;
+
+		gb0 =3D format_size_gb(dev_size, &mb0);
+		ntfs_warning(
+			sb,
+			"RAW NTFS volume: Filesystem size %u.%02u Gb > volume size %u.%02u Gb. =
Mount in read-only",
+			gb, mb, gb0, mb0);
+		sb->s_flags |=3D SB_RDONLY;
+	}
+
+	clusters =3D sbi->volume.size >> sbi->cluster_bits;
+#ifdef NTFS3_64BIT_CLUSTER
+#if BITS_PER_LONG < 64
+#error "NTFS3_64BIT_CLUSTER incompatible in 32 bit OS"
+#endif
+#else
+	/* 32 bits per cluster */
+	if (clusters >> 32) {
+		ntfs_trace(
+			sb,
+			"NTFS %u.%02u Gb is too big to use 32 bits per cluster",
+			gb, mb);
+		goto out;
+	}
+#endif
+
+	sbi->used.bitmap.nbits =3D clusters;
+
+	rec =3D ntfs_alloc(record_size, 1);
+	if (!rec) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	sbi->new_rec =3D rec;
+	rec->rhdr.sign =3D NTFS_FILE_SIGNATURE;
+	rec->rhdr.fix_off =3D cpu_to_le16(MFTRECORD_FIXUP_OFFSET_1);
+	fn =3D (sbi->record_size >> SECTOR_SHIFT) + 1;
+	rec->rhdr.fix_num =3D cpu_to_le16(fn);
+	ao =3D QuadAlign(MFTRECORD_FIXUP_OFFSET_1 + sizeof(short) * fn);
+	rec->attr_off =3D cpu_to_le16(ao);
+	rec->used =3D cpu_to_le32(ao + QuadAlign(sizeof(ATTR_TYPE)));
+	rec->total =3D cpu_to_le32(sbi->record_size);
+	((ATTRIB *)Add2Ptr(rec, ao))->type =3D ATTR_END;
+
+	if (sbi->cluster_size < PAGE_SIZE)
+		sb_set_blocksize(sb, sbi->cluster_size);
+
+	sbi->block_mask =3D sb->s_blocksize - 1;
+	sbi->blocks_per_cluster =3D sbi->cluster_size >> sb->s_blocksize_bits;
+	sbi->volume.blocks =3D sbi->volume.size >> sb->s_blocksize_bits;
+
+	/* Maximum size for normal files */
+	sbi->maxbytes =3D (clusters << sbi->cluster_bits) - 1;
+
+#ifdef NTFS3_64BIT_CLUSTER
+	if (clusters >=3D (1ull << (64 - sbi->cluster_bits)))
+		sbi->maxbytes =3D -1;
+	sbi->maxbytes_sparse =3D -1;
+#else
+	/* Maximum size for sparse file */
+	sbi->maxbytes_sparse =3D (1ull << (sbi->cluster_bits + 32)) - 1;
+#endif
+
+	err =3D 0;
+
+out:
+	brelse(bh);
+
+	return err;
+}
+
+enum Opt {
+	Opt_uid,
+	Opt_gid,
+	Opt_umask,
+	Opt_dmask,
+	Opt_fmask,
+	Opt_quiet,
+	Opt_debug,
+	Opt_immutable,
+	Opt_discard,
+	Opt_force,
+	Opt_sparse,
+	Opt_nohidden,
+	Opt_showmeta,
+	Opt_nls,
+	Opt_err,
+};
+
+static const match_table_t fat_tokens =3D { { Opt_uid, "uid=3D%u" },
+					  { Opt_gid, "gid=3D%u" },
+					  { Opt_umask, "umask=3D%o" },
+					  { Opt_dmask, "dmask=3D%o" },
+					  { Opt_fmask, "fmask=3D%o" },
+					  { Opt_quiet, "quiet" },
+					  { Opt_debug, "debug" },
+					  { Opt_immutable, "sys_immutable" },
+					  { Opt_discard, "discard" },
+					  { Opt_force, "force" },
+					  { Opt_sparse, "sparse" },
+					  { Opt_nohidden, "nohidden" },
+					  { Opt_showmeta, "showmeta" },
+					  { Opt_nls, "nls=3D%s" },
+					  { Opt_err, NULL } };
+
+static int ntfs_parse_options(struct super_block *sb, char *options, int s=
ilent,
+			      int *debug, struct mount_options *opts)
+{
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int option;
+	char nls_name[30];
+
+	opts->fs_uid =3D current_uid();
+	opts->fs_gid =3D current_gid();
+	opts->fs_fmask =3D opts->fs_dmask =3D ~current_umask();
+	opts->quiet =3D opts->sys_immutable =3D 0;
+	nls_name[0] =3D 0;
+
+	*debug =3D 0;
+
+	if (!options)
+		goto out;
+
+	while ((p =3D strsep(&options, ","))) {
+		int token;
+
+		if (!*p)
+			continue;
+
+		token =3D match_token(p, fat_tokens, args);
+		switch (token) {
+		case Opt_quiet:
+			opts->quiet =3D 1;
+			break;
+		case Opt_debug:
+			*debug =3D 1;
+			break;
+		case Opt_immutable:
+			opts->sys_immutable =3D 1;
+			break;
+		case Opt_uid:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			opts->fs_uid =3D make_kuid(current_user_ns(), option);
+			if (!uid_valid(opts->fs_uid))
+				return -EINVAL;
+			opts->uid =3D 1;
+			break;
+		case Opt_gid:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			opts->fs_gid =3D make_kgid(current_user_ns(), option);
+			if (!gid_valid(opts->fs_gid))
+				return -EINVAL;
+			opts->gid =3D 1;
+			break;
+		case Opt_umask:
+			if (match_octal(&args[0], &option))
+				return -EINVAL;
+			opts->fs_fmask =3D opts->fs_dmask =3D option;
+			opts->fmask =3D opts->dmask =3D 1;
+			break;
+		case Opt_dmask:
+			if (match_octal(&args[0], &option))
+				return -EINVAL;
+			opts->fs_dmask =3D option;
+			opts->dmask =3D 1;
+			break;
+		case Opt_fmask:
+			if (match_octal(&args[0], &option))
+				return -EINVAL;
+			opts->fs_fmask =3D option;
+			opts->fmask =3D 1;
+			break;
+		case Opt_discard:
+			opts->discard =3D 1;
+			break;
+		case Opt_force:
+			opts->force =3D 1;
+			break;
+		case Opt_sparse:
+			opts->sparse =3D 1;
+			break;
+		case Opt_nohidden:
+			opts->nohidden =3D 1;
+			break;
+		case Opt_showmeta:
+			opts->showmeta =3D 1;
+			break;
+		case Opt_nls:
+			match_strlcpy(nls_name, &args[0], sizeof(nls_name));
+			break;
+
+		/* unknown option */
+		default:
+			if (!silent)
+				ntfs_error(
+					sb,
+					"Unrecognized mount option \"%s\" or missing value",
+					p);
+			//return -EINVAL;
+		}
+	}
+
+out:
+	if (nls_name[0]) {
+		sbi->nls =3D load_nls(nls_name);
+		if (!sbi->nls) {
+			/* critical ?*/
+			ntfs_error(sb, "failed to load \"%s\"\n", nls_name);
+			//return -EINVAL;
+		}
+	}
+
+	if (!sbi->nls) {
+		sbi->nls =3D load_nls_default();
+		if (!sbi->nls) {
+			/* critical */
+			ntfs_error(sb, "failed to load default nls");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/* try to mount*/
+static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	int err;
+	ntfs_sb_info *sbi;
+	struct block_device *bdev =3D sb->s_bdev;
+	struct inode *bd_inode =3D bdev->bd_inode;
+	struct request_queue *rq =3D bdev_get_queue(bdev);
+	char buf[32];
+	int debug =3D 0;
+	struct inode *inode =3D NULL;
+	ntfs_inode *ni;
+	size_t i, tt;
+	CLST vcn, lcn, len;
+	ATTRIB *attr;
+	const VOLUME_INFO *info;
+	u32 idx, done, bytes;
+	ATTR_DEF_ENTRY *t;
+	u16 *upcase =3D NULL;
+	u16 *shared;
+	bool is_ro;
+	MFT_REF ref;
+
+	ref.high =3D 0;
+
+	sbi =3D ntfs_alloc(sizeof(ntfs_sb_info), true);
+	if (!sbi)
+		return -ENOMEM;
+
+	sb->s_fs_info =3D sbi;
+	sbi->sb =3D sb;
+	sb->s_flags |=3D SB_NODIRATIME;
+	sb->s_magic =3D 0x337366746e; // "ntfs3"
+	sb->s_op =3D &ntfs_sops;
+	sb->s_export_op =3D &ntfs_export_ops;
+	sb->s_time_gran =3D NTFS_TIME_GRAN; // 100 nsec
+	sb->s_xattr =3D ntfs_xattr_handlers;
+	sb->s_maxbytes =3D MAX_LFS_FILESIZE;
+
+	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
+			     DEFAULT_RATELIMIT_BURST);
+
+	err =3D ntfs_parse_options(sb, data, silent, &debug, &sbi->options);
+	if (err)
+		goto out;
+
+	if (!rq || !blk_queue_discard(rq) || !rq->limits.discard_granularity) {
+		;
+	} else {
+		sbi->discard_granularity =3D rq->limits.discard_granularity;
+		sbi->discard_granularity_mask_inv =3D
+			~(u64)(sbi->discard_granularity - 1);
+	}
+
+	sb_set_blocksize(sb, PAGE_SIZE);
+
+	/* parse boot */
+	err =3D ntfs_init_from_boot(sb, rq ? queue_logical_block_size(rq) : 512,
+				  bd_inode->i_size);
+	if (err)
+		goto out;
+
+	spin_lock_init(&sbi->compress.lock);
+	if (sbi->cluster_size <=3D NTFS_LZNT_MAX_CLUSTER) {
+		sbi->compress.frame_unc =3D
+			ntfs_alloc(sbi->cluster_size << NTFS_LZNT_CUNIT, 0);
+		if (!sbi->compress.frame_unc) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+
+		sbi->compress.ctx =3D get_compression_ctx(true);
+		if (!sbi->compress.ctx) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+	}
+
+	/*
+	 * Load $Volume. This should be done before $LogFile
+	 * 'cause 'sbi->volume.ni' is used 'ntfs_set_state'
+	 */
+	ref.low =3D cpu_to_le32(MFT_REC_VOL);
+	ref.seq =3D cpu_to_le16(MFT_REC_VOL);
+	inode =3D ntfs_iget5(sb, &ref, &NAME_VOLUME);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		ntfs_error(sb, "Failed to load $Volume.");
+		inode =3D NULL;
+		goto out;
+	}
+
+	ni =3D ntfs_i(inode);
+
+	/* Load and save label (not necessary) */
+	attr =3D ni_find_attr(ni, NULL, NULL, ATTR_LABEL, NULL, 0, NULL, NULL);
+
+	if (!attr) {
+	} else if (!attr->non_res && !is_attr_ext(attr)) {
+		/* $AttrDef allows labels to be up to 128 symbols */
+		err =3D utf16s_to_utf8s(resident_data(attr),
+				      le32_to_cpu(attr->res.data_size) >> 1,
+				      UTF16_LITTLE_ENDIAN, sbi->volume.label,
+				      sizeof(sbi->volume.label));
+		if (err < 0)
+			sbi->volume.label[0] =3D 0;
+	} else {
+		/* should we break mounting here? */
+		// err =3D -EINVAL;
+		// goto out;
+	}
+
+	attr =3D ni_find_attr(ni, attr, NULL, ATTR_VOL_INFO, NULL, 0, NULL, NULL)=
;
+	if (!attr || is_attr_ext(attr)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	info =3D resident_data_ex(attr, SIZEOF_ATTRIBUTE_VOLUME_INFO);
+	if (!info) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	sbi->volume.major_ver =3D info->major_ver;
+	sbi->volume.minor_ver =3D info->minor_ver;
+	sbi->volume.flags =3D info->flags;
+
+	sbi->volume.ni =3D ni;
+	inode =3D NULL;
+
+	/* Load $MFTMirr to estimate recs_mirr */
+	ref.low =3D cpu_to_le32(MFT_REC_MIRR);
+	ref.seq =3D cpu_to_le16(MFT_REC_MIRR);
+	inode =3D ntfs_iget5(sb, &ref, &NAME_MIRROR);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		ntfs_error(sb, "Failed to load $MFTMirr.");
+		inode =3D NULL;
+		goto out;
+	}
+
+	sbi->mft.recs_mirr =3D
+		ntfs_up_cluster(sbi, inode->i_size) >> sbi->record_bits;
+
+	iput(inode);
+
+	/* Load $LogFile to replay */
+	ref.low =3D cpu_to_le32(MFT_REC_LOG);
+	ref.seq =3D cpu_to_le16(MFT_REC_LOG);
+	inode =3D ntfs_iget5(sb, &ref, &NAME_LOGFILE);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		ntfs_error(sb, "Failed to load $LogFile.");
+		inode =3D NULL;
+		goto out;
+	}
+
+	ni =3D ntfs_i(inode);
+
+	err =3D ntfs_loadlog_and_replay(ni, sbi);
+	if (err)
+		goto out;
+
+	iput(inode);
+	inode =3D NULL;
+
+	is_ro =3D sb_rdonly(sbi->sb);
+
+	if (sbi->flags & NTFS_FLAGS_NEED_REPLAY) {
+		if (!is_ro) {
+			ntfs_warning(
+				sb,
+				"failed to replay log file. Can't mount rw!");
+			err =3D -EINVAL;
+			goto out;
+		}
+	} else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
+		if (!is_ro && !sbi->options.force) {
+			ntfs_warning(
+				sb,
+				"volume is dirty and \"force\" flag is not set!");
+			err =3D -EINVAL;
+			goto out;
+		}
+	}
+
+	/* Load $MFT */
+	ref.low =3D cpu_to_le32(MFT_REC_MFT);
+	ref.seq =3D cpu_to_le16(1);
+
+	inode =3D ntfs_iget5(sb, &ref, &NAME_MFT);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		ntfs_error(sb, "Failed to load $MFT.");
+		inode =3D NULL;
+		goto out;
+	}
+
+	ni =3D ntfs_i(inode);
+
+	sbi->mft.used =3D ni->i_valid >> sbi->record_bits;
+	tt =3D inode->i_size >> sbi->record_bits;
+	sbi->mft.next_free =3D MFT_REC_USER;
+
+	err =3D wnd_init(&sbi->mft.bitmap, sb, tt);
+	if (err)
+		goto out;
+
+	err =3D ni_load_all_mi(ni);
+	if (err)
+		goto out;
+
+	sbi->mft.ni =3D ni;
+
+	/* Load $BadClus */
+	ref.low =3D cpu_to_le32(MFT_REC_BADCLUST);
+	ref.seq =3D cpu_to_le16(MFT_REC_BADCLUST);
+	inode =3D ntfs_iget5(sb, &ref, &NAME_BADCLUS);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		ntfs_error(sb, "Failed to load $BadClus.");
+		inode =3D NULL;
+		goto out;
+	}
+
+	ni =3D ntfs_i(inode);
+
+	for (i =3D 0; run_get_entry(&ni->file.run, i, &vcn, &lcn, &len); i++) {
+		if (lcn =3D=3D SPARSE_LCN)
+			continue;
+
+		if (!sbi->bad_clusters)
+			ntfs_trace(sb, "Volume contains bad blocks");
+
+		sbi->bad_clusters +=3D len;
+	}
+
+	iput(inode);
+
+	/* Load $Bitmap */
+	ref.low =3D cpu_to_le32(MFT_REC_BITMAP);
+	ref.seq =3D cpu_to_le16(MFT_REC_BITMAP);
+	inode =3D ntfs_iget5(sb, &ref, &NAME_BITMAP);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		ntfs_error(sbi->sb, "Failed to load $Bitmap.");
+		inode =3D NULL;
+		goto out;
+	}
+
+	ni =3D ntfs_i(inode);
+
+#ifndef NTFS3_64BIT_CLUSTER
+	if (inode->i_size >> 32) {
+		err =3D -EINVAL;
+		goto out;
+	}
+#endif
+
+	/* Check bitmap boundary */
+	tt =3D sbi->used.bitmap.nbits;
+	if (inode->i_size < bitmap_size(tt)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* Not necessary */
+	sbi->used.bitmap.set_tail =3D true;
+	err =3D wnd_init(&sbi->used.bitmap, sbi->sb, tt);
+	if (err)
+		goto out;
+
+	iput(inode);
+
+	/* Compute the mft zone */
+	err =3D ntfs_refresh_zone(sbi);
+	if (err)
+		goto out;
+
+	/* Load $AttrDef */
+	ref.low =3D cpu_to_le32(MFT_REC_ATTR);
+	ref.seq =3D cpu_to_le16(MFT_REC_ATTR);
+	inode =3D ntfs_iget5(sbi->sb, &ref, &NAME_ATTRDEF);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		ntfs_error(sbi->sb, "Failed to load $AttrDef -> %d", err);
+		inode =3D NULL;
+		goto out;
+	}
+
+	if (inode->i_size < sizeof(ATTR_DEF_ENTRY)) {
+		err =3D -EINVAL;
+		goto out;
+	}
+	bytes =3D inode->i_size;
+	sbi->def_table =3D t =3D ntfs_alloc(bytes, 0);
+	if (!t) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	for (done =3D idx =3D 0; done < bytes; done +=3D PAGE_SIZE, idx++) {
+		unsigned long tail =3D bytes - done;
+		struct page *page =3D ntfs_map_page(inode->i_mapping, idx);
+
+		if (IS_ERR(page)) {
+			err =3D PTR_ERR(page);
+			goto out;
+		}
+		memcpy(Add2Ptr(t, done), page_address(page),
+		       min(PAGE_SIZE, tail));
+		ntfs_unmap_page(page);
+
+		if (!idx && ATTR_STD !=3D t->type) {
+			err =3D -EINVAL;
+			goto out;
+		}
+	}
+
+	t +=3D 1;
+	sbi->def_entries =3D 1;
+	done =3D sizeof(ATTR_DEF_ENTRY);
+	sbi->reparse.max_size =3D MAXIMUM_REPARSE_DATA_BUFFER_SIZE;
+
+	while (done + sizeof(ATTR_DEF_ENTRY) <=3D bytes) {
+		u32 t32 =3D le32_to_cpu(t->type);
+
+		if ((t32 & 0xF) || le32_to_cpu(t[-1].type) >=3D t32)
+			break;
+
+		if (t->type =3D=3D ATTR_REPARSE)
+			sbi->reparse.max_size =3D le64_to_cpu(t->max_sz);
+
+		done +=3D sizeof(ATTR_DEF_ENTRY);
+		t +=3D 1;
+		sbi->def_entries +=3D 1;
+	}
+	iput(inode);
+
+	/* Load $UpCase */
+	ref.low =3D cpu_to_le32(MFT_REC_UPCASE);
+	ref.seq =3D cpu_to_le16(MFT_REC_UPCASE);
+	inode =3D ntfs_iget5(sb, &ref, &NAME_UPCASE);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		ntfs_error(sbi->sb, "Failed to load $LogFile.");
+		inode =3D NULL;
+		goto out;
+	}
+
+	ni =3D ntfs_i(inode);
+
+	if (0x10000 * sizeof(short) !=3D inode->i_size) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	page_cache_readahead_unbounded(inode->i_mapping, NULL, 0,
+				       0x10000 * sizeof(short) / PAGE_SIZE, 0);
+
+	sbi->upcase =3D upcase =3D ntfs_alloc(0x10000 * sizeof(short), 0);
+	if (!upcase) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	for (idx =3D 0; idx < (0x10000 * sizeof(short) >> PAGE_SHIFT); idx++) {
+		const u16 *src;
+		u16 *dst =3D Add2Ptr(upcase, idx << PAGE_SHIFT);
+		struct page *page =3D ntfs_map_page(inode->i_mapping, idx);
+
+		if (IS_ERR(page)) {
+			err =3D PTR_ERR(page);
+			goto out;
+		}
+
+		src =3D page_address(page);
+
+#ifdef __BIG_ENDIAN
+		{
+			u32 k;
+
+			for (k =3D 0; k < PAGE_SIZE / sizeof(u16); k++)
+				*dst++ =3D le16_to_cpu(*src++);
+		}
+#else
+		memcpy(dst, src, PAGE_SIZE);
+#endif
+		ntfs_unmap_page(page);
+	}
+
+	shared =3D ntfs_set_shared(upcase, 0x10000 * sizeof(short));
+	if (shared && upcase !=3D shared) {
+		sbi->upcase =3D shared;
+		ntfs_free(upcase);
+	}
+
+	iput(inode);
+	inode =3D NULL;
+
+	if (!is_nt5(sbi))
+		goto skip_extend;
+
+	/* Load $Secure */
+	err =3D ntfs_security_init(sbi);
+	if (err)
+		goto out;
+
+	/* Load $Extend */
+	err =3D ntfs_extend_init(sbi);
+	if (err)
+		goto skip_extend;
+
+	/* Load $Extend\$Reparse */
+	err =3D ntfs_reparse_init(sbi);
+	if (err)
+		goto skip_extend;
+
+	/* Load $Extend\$ObjId */
+	err =3D ntfs_objid_init(sbi);
+	if (err)
+		goto skip_extend;
+
+skip_extend:
+
+	/* Load root */
+	ref.low =3D cpu_to_le32(MFT_REC_ROOT);
+	ref.seq =3D cpu_to_le16(MFT_REC_ROOT);
+	inode =3D ntfs_iget5(sb, &ref, &NAME_ROOT);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		ntfs_error(sb, "Failed to load root.");
+		inode =3D NULL;
+		goto out;
+	}
+
+	ni =3D ntfs_i(inode);
+
+	sb->s_root =3D d_make_root(inode);
+
+	if (!sb->s_root) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	ntfs_trace(sb, "is mounted as NTFS at %.*s", time_str(buf, sizeof(buf)),
+		   buf);
+
+	return 0;
+
+out:
+	iput(inode);
+
+	if (sb->s_root) {
+		d_drop(sb->s_root);
+		sb->s_root =3D NULL;
+	}
+
+	close_ntfs(sbi);
+
+	sb->s_fs_info =3D NULL;
+	return err;
+}
+
+void ntfs_unmap_meta(struct super_block *sb, CLST lcn, CLST len)
+{
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	struct block_device *bdev =3D sb->s_bdev;
+	sector_t devblock =3D (u64)lcn * sbi->blocks_per_cluster;
+	unsigned long blocks =3D (u64)len * sbi->blocks_per_cluster;
+	unsigned long cnt =3D 0;
+	unsigned long limit =3D global_zone_page_state(NR_FREE_PAGES)
+			      << (PAGE_SHIFT - sb->s_blocksize_bits);
+
+	if (limit >=3D 0x2000)
+		limit -=3D 0x1000;
+	else if (limit < 32)
+		limit =3D 32;
+	else
+		limit >>=3D 1;
+
+	while (blocks--) {
+		clean_bdev_aliases(bdev, devblock++, 1);
+		if (cnt++ >=3D limit) {
+			sync_blockdev(bdev);
+			cnt =3D 0;
+		}
+	}
+}
+
+/*
+ * ntfs_discard
+ *
+ * issue a discard request (trim for SSD)
+ */
+int ntfs_discard(ntfs_sb_info *sbi, CLST lcn, CLST len)
+{
+	int err;
+	u64 lbo, bytes, start, end;
+	struct super_block *sb;
+
+	if (sbi->used.next_free_lcn =3D=3D lcn + len)
+		sbi->used.next_free_lcn =3D lcn;
+
+	if (sbi->flags & NTFS_FLAGS_NODISCARD)
+		return -EOPNOTSUPP;
+
+	if (!sbi->options.discard)
+		return -EOPNOTSUPP;
+
+	lbo =3D (u64)lcn << sbi->cluster_bits;
+	bytes =3D (u64)len << sbi->cluster_bits;
+
+	/* Align up 'start' on discard_granularity */
+	start =3D (lbo + sbi->discard_granularity - 1) &
+		sbi->discard_granularity_mask_inv;
+	/* Align down 'end' on discard_granularity */
+	end =3D (lbo + bytes) & sbi->discard_granularity_mask_inv;
+
+	sb =3D sbi->sb;
+	if (start >=3D end)
+		return 0;
+
+	err =3D blkdev_issue_discard(sb->s_bdev, start >> 9, (end - start) >> 9,
+				   GFP_NOFS, 0);
+
+	if (err =3D=3D -EOPNOTSUPP)
+		sbi->flags |=3D NTFS_FLAGS_NODISCARD;
+
+	return err;
+}
+
+static struct dentry *ntfs_mount(struct file_system_type *fs_type, int fla=
gs,
+				 const char *dev_name, void *data)
+{
+	return mount_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
+}
+
+static struct file_system_type ntfs_fs_type =3D {
+	.owner =3D THIS_MODULE,
+	.name =3D "ntfs3",
+	.mount =3D ntfs_mount,
+	.kill_sb =3D kill_block_super,
+	.fs_flags =3D FS_REQUIRES_DEV,
+};
+
+static int __init init_ntfs_fs(void)
+{
+	int err;
+
+	ntfs_init_trace_file();
+
+#ifdef NTFS3_INDEX_BINARY_SEARCH
+	pr_notice("ntfs3: +index binary search");
+#endif
+
+#ifdef NTFS3_CHECK_FREE_CLST
+	pr_notice("ntfs3: +check free clusters");
+#endif
+
+#ifdef NTFS3_PREALLOCATE
+	pr_notice("ntfs3: +preallocate");
+#endif
+
+#if NTFS_LINK_MAX < 0xffff
+	pr_notice("ntfs3: max link count %u", NTFS_LINK_MAX);
+#endif
+
+#ifdef NTFS3_64BIT_CLUSTER
+	pr_notice("ntfs3: 64 bits per cluster");
+#else
+	pr_notice("ntfs3: 32 bits per cluster");
+#endif
+
+	ntfs_inode_cachep =3D kmem_cache_create(
+		"ntfs_inode_cache", sizeof(ntfs_inode), 0,
+		(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+		init_once);
+	if (!ntfs_inode_cachep) {
+		err =3D -ENOMEM;
+		goto failed;
+	}
+
+	err =3D register_filesystem(&ntfs_fs_type);
+	if (!err)
+		return 0;
+
+failed:
+	return err;
+}
+
+static void __exit exit_ntfs_fs(void)
+{
+	if (ntfs_inode_cachep) {
+		rcu_barrier();
+		kmem_cache_destroy(ntfs_inode_cachep);
+	}
+
+	unregister_filesystem(&ntfs_fs_type);
+
+	trace_mem_report(1);
+	ntfs_close_trace_file();
+}
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ntfs3 filesystem");
+MODULE_AUTHOR("Konstantin   Komarov");
+MODULE_ALIAS_FS("ntfs3");
+
+module_init(init_ntfs_fs) module_exit(exit_ntfs_fs)
--=20
2.25.2

