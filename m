Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE29C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CFC20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="bsJvM52t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHUQaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:30:02 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:59055 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728653AbgHUQZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:25:54 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 55E25821BD;
        Fri, 21 Aug 2020 19:25:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598027116;
        bh=9sqN00bmVy4+tUnUmFxSP6FgAsxIqB8a/YSQl2+JWe0=;
        h=From:To:CC:Subject:Date;
        b=bsJvM52tMVYpsoU30z3rEJJ3nAcycgwYc0Afoo9Q5cOyh3wRPrICO5SSwX1oqQ8uo
         is4L/RcqVNPTYpvDOR+gEQx+OLtuXaXUFPWqt9t4qurLg2ObL7dUegcw39NYsfbxI9
         DoQ5qt25+wZ7cFc2IlimMQQLNQvdquOSkSx0BGSQ=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 21 Aug 2020 19:25:15 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 21 Aug 2020 19:25:15 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: [PATCH v2 04/10] fs/ntfs3: Add file operations and implementation
Thread-Topic: [PATCH v2 04/10] fs/ntfs3: Add file operations and
 implementation
Thread-Index: AdZ30xLVoDYYB7UKQnicP7vQuyMYSg==
Date:   Fri, 21 Aug 2020 16:25:15 +0000
Message-ID: <f8b5a938664e43c3b81df41f5c430c68@paragon-software.com>
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

This adds file operations and implementation

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com=
>
---
 fs/ntfs3/dir.c     |  529 +++++++++++
 fs/ntfs3/file.c    | 1179 ++++++++++++++++++++++++
 fs/ntfs3/frecord.c | 2179 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/namei.c   |  566 ++++++++++++
 fs/ntfs3/record.c  |  612 +++++++++++++
 fs/ntfs3/run.c     | 1188 ++++++++++++++++++++++++
 6 files changed, 6253 insertions(+)
 create mode 100644 fs/ntfs3/dir.c
 create mode 100644 fs/ntfs3/file.c
 create mode 100644 fs/ntfs3/frecord.c
 create mode 100644 fs/ntfs3/namei.c
 create mode 100644 fs/ntfs3/record.c
 create mode 100644 fs/ntfs3/run.c

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
new file mode 100644
index 000000000000..5f1105f1283c
--- /dev/null
+++ b/fs/ntfs3/dir.c
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/dir.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ *  directory handling functions for ntfs-based filesystems
+ *
+ */
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/iversion.h>
+#include <linux/nls.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+/*
+ * Convert little endian Unicode 16 to UTF-8.
+ */
+int uni_to_x8(ntfs_sb_info *sbi, const struct le_str *uni, u8 *buf, int bu=
f_len)
+{
+	const __le16 *ip =3D uni->name;
+	u8 *op =3D buf;
+	struct nls_table *nls =3D sbi->nls;
+	int uni_len =3D uni->len;
+
+	static_assert(sizeof(wchar_t) =3D=3D sizeof(__le16));
+
+	while (uni_len--) {
+		u16 ec;
+		int charlen;
+
+		if (buf_len < NLS_MAX_CHARSET_SIZE) {
+			ntfs_warning(
+				sbi->sb,
+				"filename was truncated while converting.");
+			break;
+		}
+
+		ec =3D le16_to_cpu(*ip++);
+		charlen =3D nls->uni2char(ec, op, buf_len);
+
+		if (charlen > 0) {
+			op +=3D charlen;
+			buf_len -=3D charlen;
+		} else {
+			*op++ =3D ':';
+			op =3D hex_byte_pack(op, ec >> 8);
+			op =3D hex_byte_pack(op, ec);
+			buf_len -=3D 5;
+		}
+	}
+
+	*op =3D 0;
+	return op - buf;
+}
+
+static inline u8 get_digit(u8 d)
+{
+	u8 x =3D d & 0xf;
+
+	return x <=3D 9 ? ('0' + x) : ('A' + x - 10);
+}
+
+/*
+ * Convert input string to unicode
+ * max_ulen - maximum possible unicode length
+ * endian - unicode endian
+ */
+int x8_to_uni(ntfs_sb_info *sbi, const u8 *name, u32 name_len,
+	      struct cpu_str *uni, u32 max_ulen, enum utf16_endian endian)
+{
+	int i, ret, clen;
+	u32 tail;
+	const u8 *str =3D name;
+	const u8 *end =3D name + name_len;
+	u16 *uname =3D uni->name;
+	struct nls_table *nls =3D sbi->nls;
+	int warn =3D 0;
+
+	static_assert(sizeof(wchar_t) =3D=3D sizeof(u16));
+
+	for (ret =3D 0; str < end; ret +=3D 1, uname +=3D 1, str +=3D clen) {
+		if (ret >=3D max_ulen)
+			return -ENAMETOOLONG;
+		tail =3D end - str;
+
+		clen =3D nls->char2uni(str, tail, uname);
+		if (clen > 0)
+			continue;
+
+		if (!warn) {
+			warn =3D 1;
+			ntfs_warning(
+				sbi->sb,
+				"%s -> unicode failed: '%.*s', pos %d, chars %x %x %x",
+				nls->charset, name_len, name, (int)(str - name),
+				str[0], tail > 1 ? str[1] : 0,
+				tail > 2 ? str[2] : 0);
+		}
+
+		if (ret + 3 > max_ulen)
+			return -ENAMETOOLONG;
+
+		uname[0] =3D '%';
+		uname[1] =3D get_digit(*str >> 4);
+		uname[2] =3D get_digit(*str >> 0);
+
+		uname +=3D 2;
+		ret +=3D 2; // +1 will be added in for ( .... )
+		clen =3D 1;
+	}
+
+#ifdef __BIG_ENDIAN
+	if (endian =3D=3D UTF16_LITTLE_ENDIAN) {
+		__le16 *uname =3D (__le16 *)uni->name;
+
+		for (i =3D 0; i < ret; i++, uname++)
+			*uname =3D cpu_to_le16(*name);
+	}
+#else
+	if (endian =3D=3D UTF16_BIG_ENDIAN) {
+		__be16 *uname =3D (__be16 *)uni->name;
+
+		for (i =3D 0; i < ret; i++, uname++)
+			*uname =3D cpu_to_be16(*name);
+	}
+#endif
+
+	uni->len =3D ret;
+	return ret;
+}
+
+/* helper function */
+struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
+			   struct ntfs_fnd *fnd)
+{
+	int err =3D 0;
+	struct super_block *sb =3D dir->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	ntfs_inode *ni =3D ntfs_i(dir);
+	NTFS_DE *e;
+	int diff;
+	struct inode *inode =3D NULL;
+	struct ntfs_fnd *fnd_a =3D NULL;
+
+	if (!fnd) {
+		fnd_a =3D fnd_get(&ni->dir);
+		if (!fnd_a) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+		fnd =3D fnd_a;
+	}
+
+	err =3D indx_find(&ni->dir, ni, NULL, uni, 0, sbi, &diff, &e, fnd);
+
+	if (err)
+		goto out;
+
+	if (diff) {
+		err =3D -ENOENT;
+		goto out;
+	}
+
+	inode =3D ntfs_iget5(sb, &e->ref, uni);
+	if (!IS_ERR(inode) && is_bad_inode(inode)) {
+		iput(inode);
+		err =3D -EINVAL;
+	}
+out:
+	fnd_put(fnd_a);
+
+	return err =3D=3D -ENOENT ? NULL : err ? ERR_PTR(err) : inode;
+}
+
+/* helper function */
+struct inode *dir_search(struct inode *dir, const struct qstr *name,
+			 struct ntfs_fnd *fnd)
+{
+	struct super_block *sb =3D dir->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	int err;
+	struct inode *inode;
+	struct cpu_str *uni =3D __getname();
+	const u8 *n =3D name->name;
+
+	if (!uni)
+		return ERR_PTR(-ENOMEM);
+
+	err =3D x8_to_uni(sbi, n, name->len, uni, NTFS_NAME_LEN,
+			UTF16_HOST_ENDIAN);
+
+	inode =3D err < 0 ? ERR_PTR(err) : dir_search_u(dir, uni, fnd);
+
+	__putname(uni);
+
+	return inode;
+}
+
+static inline int ntfs_filldir(ntfs_sb_info *sbi, ntfs_inode *ni,
+			       const NTFS_DE *e, u8 *name,
+			       struct dir_context *ctx)
+{
+	const ATTR_FILE_NAME *fname;
+	unsigned long ino;
+	int name_len;
+	u32 dt_type;
+
+	fname =3D Add2Ptr(e, sizeof(NTFS_DE));
+
+	if (fname->type =3D=3D FILE_NAME_DOS)
+		return 0;
+
+	if (!mi_is_ref(&ni->mi, &fname->home))
+		return 0;
+
+	ino =3D ino_get(&e->ref);
+
+	if (ino =3D=3D MFT_REC_ROOT)
+		return 0;
+
+	/* Skip meta files ( unless option to show metafiles is set ) */
+	if (!sbi->options.showmeta && ntfs_is_meta_file(sbi, ino))
+		return 0;
+
+	if (sbi->options.nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
+		return 0;
+
+	name_len =3D uni_to_x8(sbi, (struct le_str *)&fname->name_len, name,
+			     PATH_MAX);
+	if (name_len <=3D 0) {
+		ntfs_warning(sbi->sb, "failed to convert name for inode %lx.",
+			     ino);
+		return 0;
+	}
+
+	dt_type =3D (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
+
+	return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
+}
+
+/*
+ * ntfs_read_hdr
+ *
+ * helper function 'ntfs_readdir'
+ */
+static int ntfs_read_hdr(ntfs_sb_info *sbi, ntfs_inode *ni,
+			 const INDEX_HDR *hdr, u64 vbo, u64 pos, u8 *name,
+			 struct dir_context *ctx)
+{
+	int err;
+	const NTFS_DE *e;
+	u32 e_size;
+	u32 end =3D le32_to_cpu(hdr->used);
+	u32 off =3D le32_to_cpu(hdr->de_off);
+
+next:
+	if (off + sizeof(NTFS_DE) > end)
+		return -1;
+
+	e =3D Add2Ptr(hdr, off);
+	e_size =3D le16_to_cpu(e->size);
+	if (e_size < sizeof(NTFS_DE) || off + e_size > end)
+		return -1;
+
+	if (de_is_last(e))
+		return 0;
+
+	/* Skip already enumerated*/
+	if (vbo + off < pos) {
+		off +=3D e_size;
+		goto next;
+	}
+
+	if (le16_to_cpu(e->key_size) < SIZEOF_ATTRIBUTE_FILENAME)
+		return -1;
+
+	ctx->pos =3D vbo + off;
+
+	/* Submit the name to the filldir callback. */
+	err =3D ntfs_filldir(sbi, ni, e, name, ctx);
+	if (err)
+		return err;
+
+	off +=3D e_size;
+	goto next;
+}
+
+/*
+ * file_operations::iterate_shared
+ *
+ * Use non sorted enumeration.
+ * We have an example of broken volume where sorted enumeration
+ * counts each name twice
+ */
+static int ntfs_readdir(struct file *file, struct dir_context *ctx)
+{
+	const INDEX_ROOT *root;
+	const INDEX_HDR *hdr;
+	u64 vbo;
+	size_t bit;
+	loff_t eod;
+	int err =3D 0;
+	struct inode *dir =3D file_inode(file);
+	ntfs_inode *ni =3D ntfs_i(dir);
+	struct super_block *sb =3D dir->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	loff_t i_size =3D dir->i_size;
+	u32 pos =3D ctx->pos;
+	u8 *name =3D NULL;
+	struct indx_node *node =3D NULL;
+	u8 index_bits =3D ni->dir.index_bits;
+
+	/* name is a buffer of PATH_MAX length */
+	static_assert(NTFS_NAME_LEN * 4 < PATH_MAX);
+
+	if (ni->dir.changed) {
+		ni->dir.changed =3D false;
+		pos =3D 0;
+	}
+
+	eod =3D i_size + sbi->record_size;
+
+	if (pos >=3D eod)
+		return 0;
+
+	if (!dir_emit_dots(file, ctx))
+		return 0;
+
+	name =3D __getname();
+	if (!name)
+		return -ENOMEM;
+
+	ni_lock(ni);
+
+	root =3D indx_get_root(&ni->dir, ni, NULL, NULL);
+	if (!root) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (pos >=3D sbi->record_size) {
+		bit =3D (pos - sbi->record_size) >> index_bits;
+		goto index_enum;
+	}
+
+	hdr =3D &root->ihdr;
+
+	err =3D ntfs_read_hdr(sbi, ni, hdr, 0, pos, name, ctx);
+	if (err)
+		goto out;
+
+	bit =3D 0;
+
+index_enum:
+
+	if (!i_size) {
+		ctx->pos =3D eod;
+		goto out;
+	}
+
+next_vcn:
+	vbo =3D (u64)bit << index_bits;
+	if (vbo >=3D i_size) {
+		ctx->pos =3D eod;
+		goto out;
+	}
+
+	err =3D indx_used_bit(&ni->dir, ni, &bit);
+	if (err)
+		goto out;
+
+	if (bit =3D=3D MINUS_ONE_T) {
+		ctx->pos =3D eod;
+		goto out;
+	}
+
+	vbo =3D (u64)bit << index_bits;
+	if (vbo >=3D i_size)
+		goto fs_error;
+
+	err =3D indx_read(&ni->dir, ni, bit << ni->dir.idx2vbn_bits, &node);
+	if (err)
+		goto out;
+
+	hdr =3D &node->index->ihdr;
+	err =3D ntfs_read_hdr(sbi, ni, hdr, vbo + sbi->record_size, pos, name,
+			    ctx);
+	if (err)
+		goto out;
+
+	bit +=3D 1;
+	goto next_vcn;
+
+fs_error:
+	ntfs_inode_error(dir, "Looks like your dir is corrupt");
+	err =3D -EINVAL;
+out:
+
+	__putname(name);
+	put_indx_node(node);
+
+	if (err =3D=3D -ENOENT) {
+		err =3D 0;
+		ctx->pos =3D pos;
+	}
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
+			  size_t *files)
+{
+	int err =3D 0;
+	ntfs_inode *ni =3D ntfs_i(dir);
+	NTFS_DE *e =3D NULL;
+	INDEX_ROOT *root;
+	INDEX_HDR *hdr;
+	const ATTR_FILE_NAME *fname;
+	u32 e_size, off, end;
+	u64 vbo =3D 0;
+	size_t drs =3D 0, fles =3D 0, bit =3D 0;
+	loff_t i_size =3D ni->vfs_inode.i_size;
+	struct indx_node *node =3D NULL;
+	u8 index_bits =3D ni->dir.index_bits;
+
+	if (is_empty)
+		*is_empty =3D true;
+
+	root =3D indx_get_root(&ni->dir, ni, NULL, NULL);
+	if (!root)
+		return -EINVAL;
+
+	hdr =3D &root->ihdr;
+
+next_vcn:
+
+	end =3D le32_to_cpu(hdr->used);
+	off =3D le32_to_cpu(hdr->de_off);
+
+next_de:
+	if (off + sizeof(NTFS_DE) > end)
+		goto next_hdr;
+
+	e =3D Add2Ptr(hdr, off);
+	e_size =3D le16_to_cpu(e->size);
+	if (e_size < sizeof(NTFS_DE) || off + e_size > end)
+		goto next_hdr;
+
+	if (de_is_last(e))
+		goto next_hdr;
+
+	fname =3D de_get_fname(e);
+	if (!fname)
+		goto next_hdr;
+
+	if (fname->type =3D=3D FILE_NAME_DOS)
+		goto next_de;
+
+	if (is_empty) {
+		*is_empty =3D false;
+		if (!dirs && !files)
+			goto out;
+	}
+
+	if (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY)
+		drs +=3D 1;
+	else
+		fles +=3D 1;
+
+	off +=3D e_size;
+	goto next_de;
+
+next_hdr:
+	if (vbo >=3D i_size)
+		goto out;
+
+	err =3D indx_used_bit(&ni->dir, ni, &bit);
+	if (err)
+		goto out;
+
+	if (bit =3D=3D MINUS_ONE_T)
+		goto out;
+
+	vbo =3D (u64)bit << index_bits;
+	if (vbo >=3D i_size)
+		goto out;
+
+	err =3D indx_read(&ni->dir, ni, bit << ni->dir.idx2vbn_bits, &node);
+	if (err)
+		goto out;
+
+	hdr =3D &node->index->ihdr;
+	bit +=3D 1;
+	vbo =3D (u64)bit << ni->dir.idx2vbn_bits;
+	goto next_vcn;
+
+out:
+	put_indx_node(node);
+	if (dirs)
+		*dirs =3D drs;
+	if (files)
+		*files =3D fles;
+
+	return err;
+}
+
+bool dir_is_empty(struct inode *dir)
+{
+	bool is_empty =3D false;
+
+	ntfs_dir_count(dir, &is_empty, NULL, NULL);
+
+	return is_empty;
+}
+
+const struct file_operations ntfs_dir_operations =3D {
+	.llseek =3D generic_file_llseek,
+	.read =3D generic_read_dir,
+	.iterate =3D ntfs_readdir,
+	.fsync =3D ntfs_file_fsync,
+	.open =3D ntfs_file_open,
+};
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
new file mode 100644
index 000000000000..e4f971d65586
--- /dev/null
+++ b/fs/ntfs3/file.c
@@ -0,0 +1,1179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/file.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ *  regular file handling primitives for ntfs-based filesystems
+ */
+#include <linux/backing-dev.h>
+#include <linux/buffer_head.h>
+#include <linux/compat.h>
+#include <linux/falloc.h>
+#include <linux/msdos_fs.h> /* FAT_IOCTL_XXX */
+#include <linux/nls.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+static int ntfs_ioctl_fitrim(ntfs_sb_info *sbi, unsigned long arg)
+{
+	struct fstrim_range __user *user_range;
+	struct fstrim_range range;
+	struct request_queue *q =3D bdev_get_queue(sbi->sb->s_bdev);
+	int err;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!blk_queue_discard(q))
+		return -EOPNOTSUPP;
+
+	user_range =3D (struct fstrim_range __user *)arg;
+	if (copy_from_user(&range, user_range, sizeof(range)))
+		return -EFAULT;
+
+	range.minlen =3D max_t(u32, range.minlen, q->limits.discard_granularity);
+
+	err =3D ntfs_trim_fs(sbi, &range);
+	if (err < 0)
+		return err;
+
+	if (copy_to_user(user_range, &range, sizeof(range)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
+{
+	struct inode *inode =3D file_inode(filp);
+	ntfs_sb_info *sbi =3D inode->i_sb->s_fs_info;
+	u32 __user *user_attr =3D (u32 __user *)arg;
+
+	switch (cmd) {
+	case FAT_IOCTL_GET_ATTRIBUTES:
+		return put_user(le32_to_cpu(ntfs_i(inode)->std_fa), user_attr);
+
+	case FAT_IOCTL_GET_VOLUME_ID:
+		return put_user(sbi->volume.ser_num, user_attr);
+
+	case FITRIM:
+		return ntfs_ioctl_fitrim(sbi, arg);
+	}
+	return -ENOTTY; /* Inappropriate ioctl for device */
+}
+
+#ifdef CONFIG_COMPAT
+static long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long ar=
g)
+
+{
+	return ntfs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
+/*
+ * inode_operations::getattr
+ */
+int ntfs_getattr(const struct path *path, struct kstat *stat, u32 request_=
mask,
+		 u32 flags)
+{
+	struct inode *inode =3D d_inode(path->dentry);
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	ntfs_inode *ni =3D ntfs_i(inode);
+
+	if (is_compressed(ni))
+		stat->attributes |=3D STATX_ATTR_COMPRESSED;
+
+	if (is_encrypted(ni))
+		stat->attributes |=3D STATX_ATTR_ENCRYPTED;
+
+	stat->attributes_mask |=3D STATX_ATTR_COMPRESSED | STATX_ATTR_ENCRYPTED;
+
+	generic_fillattr(inode, stat);
+
+	stat->result_mask |=3D STATX_BTIME;
+	stat->btime.tv_sec =3D ni->i_crtime.tv_sec;
+	stat->btime.tv_nsec =3D ni->i_crtime.tv_nsec;
+	stat->blksize =3D sbi->cluster_size;
+	stat->blocks <<=3D sbi->cluster_bits - 9;
+
+	return 0;
+}
+
+static int ntfs_extend_initialized_size(struct file *file, ntfs_inode *ni,
+					const loff_t valid,
+					const loff_t new_valid)
+{
+	struct inode *inode =3D &ni->vfs_inode;
+	struct address_space *mapping =3D inode->i_mapping;
+	ntfs_sb_info *sbi =3D inode->i_sb->s_fs_info;
+	loff_t pos =3D valid;
+	int err;
+
+	WARN_ON(is_compressed(ni));
+	WARN_ON(valid >=3D new_valid);
+
+	for (;;) {
+		u32 zerofrom, len;
+		struct page *page;
+		void *fsdata;
+		u8 bits;
+		CLST vcn, lcn, clen;
+
+		if (is_sparsed(ni)) {
+			bits =3D sbi->cluster_bits;
+			vcn =3D pos >> bits;
+
+			err =3D attr_data_get_block(ni, vcn, &lcn, &clen, NULL);
+
+			if (err)
+				goto out;
+
+			if (lcn =3D=3D SPARSE_LCN) {
+				loff_t vbo =3D (loff_t)vcn << bits;
+				loff_t to =3D vbo + ((loff_t)clen << bits);
+
+				if (to <=3D new_valid) {
+					ni->i_valid =3D to;
+					pos =3D to;
+					goto next;
+				}
+
+				if (vbo < pos)
+					pos =3D vbo;
+				else {
+					to =3D (new_valid >> bits) << bits;
+					if (pos < to) {
+						ni->i_valid =3D to;
+						pos =3D to;
+						goto next;
+					}
+				}
+			}
+		}
+
+		zerofrom =3D pos & (PAGE_SIZE - 1);
+		len =3D PAGE_SIZE - zerofrom;
+
+		if (pos + len > new_valid)
+			len =3D new_valid - pos;
+
+		err =3D pagecache_write_begin(file, mapping, pos, len, 0, &page,
+					    &fsdata);
+		if (err)
+			goto out;
+
+		zero_user_segment(page, zerofrom, PAGE_SIZE);
+
+		/* this function in any case puts page*/
+		err =3D pagecache_write_end(file, mapping, pos, len, len, page,
+					  fsdata);
+		if (err < 0)
+			goto out;
+		pos +=3D len;
+
+next:
+		if (pos >=3D new_valid)
+			break;
+		balance_dirty_pages_ratelimited(mapping);
+	}
+
+	mark_inode_dirty(inode);
+
+	return 0;
+
+out:
+	ni->i_valid =3D valid;
+	ntfs_inode_warning(inode, "failed to extend initialized size to %llx.",
+			   new_valid);
+	return err;
+}
+
+static int ntfs_extend_initialized_size_cmpr(struct file *file, ntfs_inode=
 *ni,
+					     const loff_t valid,
+					     const loff_t new_valid)
+{
+	struct inode *inode =3D &ni->vfs_inode;
+	struct address_space *mapping =3D inode->i_mapping;
+	ntfs_sb_info *sbi =3D inode->i_sb->s_fs_info;
+	loff_t pos =3D valid;
+	u8 bits =3D NTFS_LZNT_CUNIT + sbi->cluster_bits;
+	int err;
+
+	WARN_ON(!is_compressed(ni));
+	WARN_ON(valid >=3D new_valid);
+
+	for (;;) {
+		u32 zerofrom, len;
+		struct page *page;
+		CLST frame, vcn, lcn, clen;
+
+		frame =3D pos >> bits;
+		vcn =3D frame << NTFS_LZNT_CUNIT;
+
+		err =3D attr_data_get_block(ni, vcn, &lcn, &clen, NULL);
+
+		if (err)
+			goto out;
+
+		if (lcn =3D=3D SPARSE_LCN) {
+			loff_t vbo =3D (loff_t)frame << bits;
+			loff_t to =3D vbo + ((u64)clen << sbi->cluster_bits);
+
+			if (to <=3D new_valid) {
+				ni->i_valid =3D to;
+				pos =3D to;
+				goto next;
+			}
+
+			if (vbo >=3D pos) {
+				to =3D (new_valid >> bits) << bits;
+				if (pos < to) {
+					ni->i_valid =3D to;
+					pos =3D to;
+					goto next;
+				}
+			}
+		}
+
+		zerofrom =3D pos & (PAGE_SIZE - 1);
+		len =3D PAGE_SIZE - zerofrom;
+
+		if (pos + len > new_valid)
+			len =3D new_valid - pos;
+again:
+		page =3D find_or_create_page(mapping, pos >> PAGE_SHIFT,
+					   mapping_gfp_constraint(mapping,
+								  ~__GFP_FS));
+
+		if (!page) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+
+		if (zerofrom && !PageUptodate(page)) {
+			err =3D ntfs_readpage(NULL, page);
+			lock_page(page);
+			if (page->mapping !=3D mapping) {
+				unlock_page(page);
+				put_page(page);
+				goto again;
+			}
+			if (!PageUptodate(page)) {
+				err =3D -EIO;
+				unlock_page(page);
+				put_page(page);
+				goto out;
+			}
+		}
+
+		wait_on_page_writeback(page);
+
+		zero_user_segment(page, zerofrom, PAGE_SIZE);
+		if (!zerofrom)
+			SetPageUptodate(page);
+
+		ClearPageChecked(page);
+		set_page_dirty(page);
+		unlock_page(page);
+		put_page(page);
+		pos +=3D len;
+		ni->i_valid =3D pos;
+next:
+		if (pos >=3D new_valid)
+			break;
+		balance_dirty_pages_ratelimited(mapping);
+	}
+
+	mark_inode_dirty(inode);
+
+	return 0;
+
+out:
+	ni->i_valid =3D valid;
+	ntfs_inode_warning(
+		inode, "failed to extend initialized compressed size to %llx.",
+		new_valid);
+	return err;
+}
+
+/*
+ * ntfs_sparse_cluster
+ *
+ * Helper function to zero a new allocated clusters
+ */
+void ntfs_sparse_cluster(struct inode *inode, struct page *page0, loff_t v=
bo,
+			 u32 bytes)
+{
+	struct address_space *mapping =3D inode->i_mapping;
+	ntfs_sb_info *sbi =3D inode->i_sb->s_fs_info;
+	u32 blocksize =3D 1 << inode->i_blkbits;
+	pgoff_t idx0 =3D page0 ? page0->index : -1;
+	loff_t vbo_clst =3D vbo & sbi->cluster_mask_inv;
+	loff_t end =3D ntfs_up_cluster(sbi, vbo + bytes);
+	pgoff_t idx =3D vbo_clst >> PAGE_SHIFT;
+	u32 from =3D vbo_clst & (PAGE_SIZE - 1);
+	pgoff_t idx_end =3D (end + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	loff_t page_off;
+	u32 to;
+	bool partial;
+	struct page *page;
+
+	for (; idx < idx_end; idx +=3D 1, from =3D 0) {
+		page =3D idx =3D=3D idx0 ? page0 : grab_cache_page(mapping, idx);
+
+		if (!page)
+			continue;
+
+		page_off =3D (loff_t)idx << PAGE_SHIFT;
+		to =3D (page_off + PAGE_SIZE) > end ? (end - page_off) :
+						    PAGE_SIZE;
+		partial =3D false;
+
+		if ((from || PAGE_SIZE !=3D to) &&
+		    likely(!page_has_buffers(page))) {
+			create_empty_buffers(page, blocksize, 0);
+			if (!page_has_buffers(page)) {
+				ntfs_inode_error(
+					inode,
+					"failed to allocate page buffers.");
+				/*err =3D -ENOMEM;*/
+				goto unlock_page;
+			}
+		}
+
+		if (page_has_buffers(page)) {
+			struct buffer_head *head, *bh;
+			u32 bh_off =3D 0;
+
+			bh =3D head =3D page_buffers(page);
+			do {
+				u32 bh_next =3D bh_off + blocksize;
+
+				if (from <=3D bh_off && bh_next <=3D to) {
+					set_buffer_uptodate(bh);
+					mark_buffer_dirty(bh);
+				} else if (!buffer_uptodate(bh))
+					partial =3D true;
+				bh_off =3D bh_next;
+			} while (head !=3D (bh =3D bh->b_this_page));
+		}
+
+		zero_user_segment(page, from, to);
+
+		if (!partial) {
+			if (!PageUptodate(page))
+				SetPageUptodate(page);
+			set_page_dirty(page);
+		}
+
+unlock_page:
+		if (idx !=3D idx0) {
+			unlock_page(page);
+			put_page(page);
+		}
+	}
+
+	mark_inode_dirty(inode);
+}
+
+struct ntfs_file_vm_ops {
+	atomic_t refcnt;
+	loff_t to;
+
+	const struct vm_operations_struct *base;
+	struct vm_operations_struct vm_ops;
+};
+
+/*
+ * vm_operations_struct::open
+ */
+static void ntfs_filemap_open(struct vm_area_struct *vma)
+{
+	struct ntfs_file_vm_ops *vm_ops;
+	const struct vm_operations_struct *base;
+
+	vm_ops =3D container_of(vma->vm_ops, struct ntfs_file_vm_ops, vm_ops);
+	base =3D vm_ops->base;
+
+	atomic_inc(&vm_ops->refcnt);
+
+	if (base->open)
+		base->open(vma);
+}
+
+/*
+ * vm_operations_struct::close
+ */
+static void ntfs_filemap_close(struct vm_area_struct *vma)
+{
+	struct ntfs_file_vm_ops *vm_ops;
+	const struct vm_operations_struct *base;
+	struct inode *inode;
+	ntfs_inode *ni;
+	// unsigned long flags;
+
+	vm_ops =3D container_of(vma->vm_ops, struct ntfs_file_vm_ops, vm_ops);
+
+	if (!atomic_dec_and_test(&vm_ops->refcnt))
+		return;
+
+	base =3D vm_ops->base;
+	if (!(vma->vm_flags & VM_WRITE))
+		goto close_base;
+
+	inode =3D file_inode(vma->vm_file);
+	ni =3D ntfs_i(inode);
+
+	// Update valid size
+	// write_lock_irqsave( &ni->rwlock, flags );
+	ni->i_valid =3D max_t(loff_t, ni->i_valid,
+			    min_t(loff_t, i_size_read(inode), vm_ops->to));
+	// write_unlock_irqrestore( &u->rwlock, flags );
+
+close_base:
+	if (base->close)
+		base->close(vma);
+
+	vma->vm_ops =3D base;
+	ntfs_free(vm_ops);
+}
+
+/*
+ * vm_operations_struct::fault
+ */
+static vm_fault_t ntfs_filemap_fault(struct vm_fault *vmf)
+{
+	vm_fault_t ret;
+	struct ntfs_file_vm_ops *vm_ops;
+	struct vm_area_struct *vma =3D vmf->vma;
+
+	vm_ops =3D container_of(vma->vm_ops, struct ntfs_file_vm_ops, vm_ops);
+
+	/* Call base function */
+	ret =3D vm_ops->base->fault(vmf);
+
+	if (VM_FAULT_LOCKED & ret) {
+		/* Update maximum mapped range */
+		loff_t to =3D (loff_t)(vmf->pgoff + 1) << PAGE_SHIFT;
+
+		if (vm_ops->to < to)
+			vm_ops->to =3D to;
+	}
+
+	return ret;
+}
+
+/*
+ * file_operations::mmap
+ */
+static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *inode =3D file->f_mapping->host;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	u64 to, from =3D ((u64)vma->vm_pgoff << PAGE_SHIFT);
+	bool rw =3D vma->vm_flags & VM_WRITE;
+	struct ntfs_file_vm_ops *vm_ops =3D NULL;
+	int err;
+
+	if (is_encrypted(ni)) {
+		err =3D -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!rw)
+		goto generic;
+
+	if (is_compressed(ni)) {
+		err =3D -EOPNOTSUPP;
+		goto out;
+	}
+
+	/*
+	 * Allocate and init small struct to keep track the mapping operations
+	 * It is useful when mmap(size) + truncate(size/2) + unmap(). see
+	 * xfstests/generic/039
+	 */
+	vm_ops =3D ntfs_alloc(sizeof(struct ntfs_file_vm_ops), 1);
+	if (unlikely(!vm_ops)) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	// map for write
+	inode_lock(inode);
+
+	to =3D from + vma->vm_end - vma->vm_start;
+
+	if (to > inode->i_size)
+		to =3D inode->i_size;
+
+	if (is_sparsed(ni)) {
+		/* allocate clusters for rw map */
+		ntfs_sb_info *sbi =3D inode->i_sb->s_fs_info;
+		CLST vcn, lcn, len;
+		CLST end =3D bytes_to_cluster(sbi, to);
+		bool new;
+
+		for (vcn =3D from >> sbi->cluster_bits; vcn < end; vcn +=3D len) {
+			err =3D attr_data_get_block(ni, vcn, &lcn, &len, &new);
+			if (err) {
+				inode_unlock(inode);
+				goto out;
+			}
+			if (!new)
+				continue;
+			ntfs_sparse_cluster(inode, NULL,
+					    (u64)vcn << sbi->cluster_bits,
+					    sbi->cluster_size);
+		}
+	}
+
+	err =3D ni->i_valid < to ?
+		      ntfs_extend_initialized_size(file, ni, ni->i_valid, to) :
+		      0;
+
+	inode_unlock(inode);
+	if (err)
+		goto out;
+
+generic:
+	err =3D generic_file_mmap(file, vma);
+	if (err)
+		goto out;
+
+	if (rw) {
+		atomic_set(&vm_ops->refcnt, 1);
+		vm_ops->to =3D to;
+		vm_ops->base =3D vma->vm_ops;
+		memcpy(&vm_ops->vm_ops, vma->vm_ops,
+		       sizeof(struct vm_operations_struct));
+		vm_ops->vm_ops.fault =3D &ntfs_filemap_fault;
+		vm_ops->vm_ops.open =3D &ntfs_filemap_open;
+		vm_ops->vm_ops.close =3D &ntfs_filemap_close;
+		vma->vm_ops =3D &vm_ops->vm_ops;
+	}
+
+out:
+	if (err)
+		ntfs_free(vm_ops);
+
+	return err;
+}
+
+/*
+ * file_operations::fsync
+ */
+int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end, int datas=
ync)
+{
+	return generic_file_fsync(filp, start, end, datasync);
+}
+
+static int ntfs_extend_ex(struct inode *inode, loff_t pos, size_t count,
+			  struct file *file)
+{
+	ntfs_inode *ni =3D ntfs_i(inode);
+	struct address_space *mapping =3D inode->i_mapping;
+	loff_t end =3D pos + count;
+	int err;
+	bool extend_init =3D file && pos > ni->i_valid;
+
+	if (end <=3D inode->i_size && !extend_init)
+		return 0;
+
+	/*mark rw ntfs as dirty. it will be cleared at umount*/
+	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_DIRTY);
+
+	if (end > inode->i_size) {
+		err =3D ntfs_set_size(inode, end);
+		if (err)
+			goto out;
+		inode->i_size =3D end;
+	}
+
+	if (extend_init) {
+		err =3D (is_compressed(ni) ? ntfs_extend_initialized_size_cmpr :
+					   ntfs_extend_initialized_size)(
+			file, ni, ni->i_valid, pos);
+		if (err)
+			goto out;
+	}
+
+	inode->i_ctime =3D inode->i_mtime =3D current_time(inode);
+	ni->ni_flags |=3D NI_FLAG_UPDATE_PARENT;
+	mark_inode_dirty(inode);
+
+	if (IS_SYNC(inode)) {
+		int err2;
+
+		err =3D filemap_fdatawrite_range(mapping, pos, end - 1);
+		err2 =3D sync_mapping_buffers(mapping);
+		if (!err)
+			err =3D err2;
+		err2 =3D write_inode_now(inode, 1);
+		if (!err)
+			err =3D err2;
+		if (!err)
+			err =3D filemap_fdatawait_range(mapping, pos, end - 1);
+	}
+
+out:
+	return err;
+}
+
+/*
+ * Preallocate space for a file. This implements ntfs's fallocate file
+ * operation, which gets called from sys_fallocate system call. User
+ * space requests len bytes at offset. If FALLOC_FL_KEEP_SIZE is set
+ * we just allocate clusters without zeroing them out. Otherwise we
+ * allocate and zero out clusters via an expanding truncate.
+ */
+static long ntfs_fallocate(struct file *file, int mode, loff_t offset,
+			   loff_t len)
+{
+	struct inode *inode =3D file->f_mapping->host;
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	loff_t end;
+	int err;
+
+	/* No support for dir */
+	if (!S_ISREG(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	/* Return error if mode is not supported */
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
+		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
+		     FALLOC_FL_INSERT_RANGE))
+		return -EOPNOTSUPP;
+
+	inode_lock(inode);
+
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+			err =3D -EINVAL;
+			goto out;
+		}
+		/*TODO*/
+		err =3D -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (mode & FALLOC_FL_COLLAPSE_RANGE) {
+		if (mode & ~FALLOC_FL_COLLAPSE_RANGE) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		/*TODO*/
+		err =3D -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (mode & FALLOC_FL_INSERT_RANGE) {
+		err =3D -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (mode & FALLOC_FL_ZERO_RANGE) {
+		err =3D -EOPNOTSUPP;
+		goto out;
+	}
+
+	end =3D offset + len;
+	if (mode & FALLOC_FL_KEEP_SIZE) {
+		/* Start the allocation.We are not zeroing out the clusters */
+		err =3D ntfs_set_size(inode, bytes_to_cluster(sbi, end));
+		goto out;
+	}
+
+	err =3D 0;
+
+	if (end <=3D i_size_read(inode))
+		goto out;
+
+	/*
+	 * Allocate clusters but does not change 'valid'
+	 */
+	err =3D ntfs_extend_ex(inode, offset, len, NULL);
+
+out:
+	if (err =3D=3D -EFBIG)
+		err =3D -ENOSPC;
+
+	inode_unlock(inode);
+	return err;
+}
+
+void ntfs_truncate_blocks(struct inode *inode, loff_t new_size)
+{
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	int err, dirty =3D 0;
+	u32 vcn;
+	u64 new_valid;
+
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	vcn =3D bytes_to_cluster(sbi, new_size);
+	new_valid =3D ntfs_up_block(sb, min(ni->i_valid, new_size));
+
+	ni_lock(ni);
+	down_write(&ni->file.run_lock);
+
+	truncate_setsize(inode, new_size);
+
+	err =3D attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
+			    &new_valid, true, NULL);
+
+	if (new_valid < ni->i_valid)
+		ni->i_valid =3D new_valid;
+
+	up_write(&ni->file.run_lock);
+	ni_unlock(ni);
+
+	ni->std_fa |=3D FILE_ATTRIBUTE_ARCHIVE;
+	inode->i_ctime =3D inode->i_mtime =3D current_time(inode);
+	if (!IS_DIRSYNC(inode)) {
+		dirty =3D 1;
+	} else {
+		err =3D ntfs_sync_inode(inode);
+		if (err)
+			return;
+	}
+
+	inode->i_blocks =3D vcn;
+
+	if (dirty)
+		mark_inode_dirty(inode);
+
+	/*ntfs_flush_inodes(inode->i_sb, inode, NULL);*/
+}
+
+/*
+ * inode_operations::setattr
+ */
+int ntfs_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	struct super_block *sb =3D dentry->d_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	struct inode *inode =3D d_inode(dentry);
+	ntfs_inode *ni =3D ntfs_i(inode);
+	u32 ia_valid =3D attr->ia_valid;
+	umode_t mode =3D inode->i_mode;
+	int err;
+
+	if (sbi->options.no_acs_rules) {
+		/* "no access rules" - force any changes of time etc. */
+		attr->ia_valid |=3D ATTR_FORCE;
+		/* and disable for editing some attributes */
+		attr->ia_valid &=3D ~(ATTR_UID | ATTR_GID | ATTR_MODE);
+		ia_valid =3D attr->ia_valid;
+	}
+
+	err =3D setattr_prepare(dentry, attr);
+	if (err) {
+		if (sbi->options.quiet)
+			err =3D 0;
+		goto out;
+	}
+
+	if (ia_valid & ATTR_SIZE) {
+		loff_t oldsize =3D inode->i_size;
+
+		inode_dio_wait(inode);
+
+		if (attr->ia_size < oldsize) {
+			err =3D block_truncate_page(inode->i_mapping,
+						  attr->ia_size,
+						  ntfs_get_block);
+			if (err)
+				goto out;
+			ntfs_truncate_blocks(inode, attr->ia_size);
+		} else if (attr->ia_size > oldsize) {
+			err =3D ntfs_extend_ex(inode, attr->ia_size, 0, NULL);
+			if (err)
+				goto out;
+		}
+
+		ni->ni_flags |=3D NI_FLAG_UPDATE_PARENT;
+	}
+
+	setattr_copy(inode, attr);
+
+	if (mode !=3D inode->i_mode) {
+		err =3D ntfs_acl_chmod(inode);
+		if (err)
+			goto out;
+
+		/* linux 'w' -> windows 'ro' */
+		if (0222 & inode->i_mode)
+			ni->std_fa &=3D ~FILE_ATTRIBUTE_READONLY;
+		else
+			ni->std_fa |=3D FILE_ATTRIBUTE_READONLY;
+	}
+
+	mark_inode_dirty(inode);
+out:
+
+	return err;
+}
+
+static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *it=
er)
+{
+	ssize_t err;
+	size_t count =3D iov_iter_count(iter);
+	struct file *file =3D iocb->ki_filp;
+	struct inode *inode =3D file->f_mapping->host;
+	ntfs_inode *ni =3D ntfs_i(inode);
+
+	if (is_encrypted(ni))
+		return -EOPNOTSUPP;
+
+	if (is_dedup(ni))
+		return -EOPNOTSUPP;
+
+	err =3D count ? generic_file_read_iter(iocb, iter) : 0;
+
+	return err;
+}
+
+/*
+ * on error we return an unlocked page and the error value
+ * on success we return a locked page and 0
+ */
+static int prepare_uptodate_page(struct inode *inode, struct page *page,
+				 u64 pos, bool force_uptodate)
+{
+	int err =3D 0;
+
+	if (((pos & (PAGE_SIZE - 1)) || force_uptodate) &&
+	    !PageUptodate(page)) {
+		err =3D ntfs_readpage(NULL, page);
+		if (err)
+			return err;
+		lock_page(page);
+		if (!PageUptodate(page)) {
+			unlock_page(page);
+			return -EIO;
+		}
+		if (page->mapping !=3D inode->i_mapping) {
+			unlock_page(page);
+			return -EAGAIN;
+		}
+	}
+	return 0;
+}
+
+/*helper for ntfs_file_write_iter (compressed files)*/
+static noinline ssize_t ntfs_compress_write(struct kiocb *iocb,
+					    struct iov_iter *from)
+{
+	int err;
+	struct file *file =3D iocb->ki_filp;
+	size_t count =3D iov_iter_count(from);
+	loff_t pos =3D iocb->ki_pos;
+	loff_t end =3D pos + count;
+	struct inode *inode =3D file_inode(file);
+	struct address_space *mapping =3D inode->i_mapping;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	// struct ntfs_sb_info *sbi =3D ni->mi.sbi;
+	struct page *page, **pages =3D NULL;
+	size_t ip, max_pages, written =3D 0;
+	bool force_uptodate =3D false;
+	pgoff_t from_idx, end_idx;
+	u32 off;
+	gfp_t mask =3D mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_WRITE;
+
+	from_idx =3D pos >> PAGE_SHIFT;
+	end_idx =3D (end + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	max_pages =3D end_idx - from_idx;
+	if (max_pages > 16)
+		max_pages =3D 16;
+	WARN_ON(end_idx <=3D from_idx);
+
+	pages =3D ntfs_alloc(max_pages * sizeof(struct page *), 1);
+	if (!pages)
+		return -ENOMEM;
+
+	current->backing_dev_info =3D inode_to_bdi(inode);
+	err =3D file_remove_privs(file);
+	if (err)
+		goto out;
+
+	err =3D file_update_time(file);
+	if (err)
+		goto out;
+
+	while (count) {
+		pgoff_t index =3D pos >> PAGE_SHIFT;
+		size_t offset =3D offset_in_page(pos);
+		size_t bytes =3D max_pages * PAGE_SIZE - offset;
+		size_t wpages, copied;
+
+		if (bytes > count)
+			bytes =3D count;
+
+		wpages =3D (offset + bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+		WARN_ON(wpages > max_pages);
+
+		if (unlikely(iov_iter_fault_in_readable(from, bytes))) {
+			err =3D -EFAULT;
+			goto out;
+		}
+
+		for (ip =3D 0; ip < wpages; ip++) {
+again:
+			page =3D find_or_create_page(mapping, index + ip, mask);
+			if (!page) {
+				err =3D -ENOMEM;
+fail:
+				while (ip--) {
+					page =3D pages[ip];
+					unlock_page(page);
+					put_page(page);
+				}
+
+				goto out;
+			}
+
+			pages[ip] =3D page;
+
+			if (!ip)
+				err =3D prepare_uptodate_page(inode, page, pos,
+							    force_uptodate);
+
+			if (!err && ip =3D=3D wpages - 1)
+				err =3D prepare_uptodate_page(inode, page,
+							    pos + bytes, false);
+
+			if (err) {
+				put_page(page);
+				if (err =3D=3D -EAGAIN) {
+					err =3D 0;
+					goto again;
+				}
+				goto fail;
+			}
+			wait_on_page_writeback(page);
+		}
+
+		WARN_ON(!bytes);
+		copied =3D 0;
+		ip =3D 0;
+		off =3D offset_in_page(pos);
+
+		for (;;) {
+			size_t tail =3D PAGE_SIZE - off;
+			size_t count =3D min(tail, bytes);
+			size_t cp;
+
+			page =3D pages[ip];
+
+			cp =3D iov_iter_copy_from_user_atomic(page, from, off,
+							    count);
+
+			flush_dcache_page(page);
+
+			if (!PageUptodate(page) && cp < count)
+				cp =3D 0;
+
+			iov_iter_advance(from, cp);
+			copied +=3D cp;
+			bytes -=3D cp;
+			if (!bytes || !cp)
+				break;
+
+			if (cp < tail)
+				off +=3D cp;
+			else {
+				ip++;
+				off =3D 0;
+			}
+		}
+
+		if (!copied)
+			force_uptodate =3D true;
+		else {
+			size_t dpages;
+
+			force_uptodate =3D false;
+			dpages =3D
+				(offset + copied + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+			for (ip =3D 0; ip < dpages; ip++) {
+				page =3D pages[ip];
+				SetPageUptodate(page);
+				ClearPageChecked(page);
+				set_page_dirty(page);
+			}
+		}
+
+		for (ip =3D 0; ip < wpages; ip++) {
+			page =3D pages[ip];
+			ClearPageChecked(page);
+			unlock_page(page);
+			put_page(page);
+		}
+
+		cond_resched();
+
+		balance_dirty_pages_ratelimited(mapping);
+
+		pos +=3D copied;
+		written +=3D copied;
+
+		count =3D iov_iter_count(from);
+	}
+
+out:
+	ntfs_free(pages);
+
+	current->backing_dev_info =3D NULL;
+
+	if (err < 0)
+		return err;
+
+	iocb->ki_pos +=3D written;
+	if (iocb->ki_pos > ni->i_valid)
+		ni->i_valid =3D iocb->ki_pos;
+
+	return written;
+}
+
+/*
+ * file_operations::write_iter
+ */
+static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *f=
rom)
+{
+	struct file *file =3D iocb->ki_filp;
+	struct address_space *mapping =3D file->f_mapping;
+	struct inode *inode =3D mapping->host;
+	ssize_t ret;
+	ntfs_inode *ni =3D ntfs_i(inode);
+
+	if (is_encrypted(ni)) {
+		ntfs_inode_warning(inode, "encrypted i/o not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
+		ntfs_inode_warning(inode,
+				   "direct i/o + compressed not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
+		ntfs_inode_warning(
+			inode,
+			"write into external compressed file not supported (temporary)");
+		return -EOPNOTSUPP;
+	}
+
+	if (is_dedup(ni)) {
+		ntfs_inode_warning(inode,
+				   "write into deduplicated not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (!inode_trylock(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock(inode);
+	}
+
+	ret =3D generic_write_checks(iocb, from);
+	if (ret <=3D 0)
+		goto out;
+
+	ret =3D ntfs_extend_ex(inode, iocb->ki_pos, ret, file);
+	if (ret)
+		goto out;
+
+	ret =3D is_compressed(ni) ? ntfs_compress_write(iocb, from) :
+				  __generic_file_write_iter(iocb, from);
+
+out:
+	inode_unlock(inode);
+
+	if (ret > 0)
+		ret =3D generic_write_sync(iocb, ret);
+
+	return ret;
+}
+
+/*
+ * file_operations::open
+ */
+int ntfs_file_open(struct inode *inode, struct file *file)
+{
+	ntfs_inode *ni =3D ntfs_i(inode);
+
+	if (unlikely((is_compressed(ni) || is_encrypted(ni)) &&
+		     (file->f_flags & O_DIRECT))) {
+		return -ENOTBLK;
+	}
+
+	return generic_file_open(inode, file);
+}
+
+#ifdef NTFS3_PREALLOCATE
+/*
+ * file_operations::release
+ */
+static int ntfs_file_release(struct inode *inode, struct file *file)
+{
+	ntfs_inode *ni =3D ntfs_i(inode);
+	int err;
+
+	/* if we are the last writer on the inode, drop the block reservation */
+	if (!(file->f_mode & FMODE_WRITE) ||
+	    atomic_read(&inode->i_writecount) !=3D 1)
+		return 0;
+
+	ni_lock(ni);
+
+	err =3D attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run,
+			    inode->i_size, &ni->i_valid, false, NULL);
+
+	ni_unlock(ni);
+
+	/*congestion_wait(BLK_RW_ASYNC, HZ / 10);*/
+
+	return err;
+}
+#endif
+
+const struct inode_operations ntfs_file_inode_operations =3D {
+	.getattr =3D ntfs_getattr,
+	.setattr =3D ntfs_setattr,
+	.listxattr =3D ntfs_listxattr,
+	.permission =3D ntfs_permission,
+	.get_acl =3D ntfs_get_acl,
+	.set_acl =3D ntfs_set_acl,
+};
+
+const struct file_operations ntfs_file_operations =3D {
+	.llseek =3D generic_file_llseek,
+	.read_iter =3D ntfs_file_read_iter,
+	.write_iter =3D ntfs_file_write_iter,
+	.unlocked_ioctl =3D ntfs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =3D ntfs_compat_ioctl,
+#endif
+	.splice_read =3D generic_file_splice_read,
+	.mmap =3D ntfs_file_mmap,
+	.open =3D ntfs_file_open,
+	.fsync =3D ntfs_file_fsync,
+	.splice_write =3D iter_file_splice_write,
+	.fallocate =3D ntfs_fallocate,
+#ifdef NTFS3_PREALLOCATE
+	.release =3D ntfs_file_release,
+#endif
+};
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
new file mode 100644
index 000000000000..918291e7f629
--- /dev/null
+++ b/fs/ntfs3/frecord.c
@@ -0,0 +1,2179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/frecord.c
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
+static inline void get_mi_ref(const mft_inode *mi, MFT_REF *ref)
+{
+#ifdef NTFS3_64BIT_CLUSTER
+	ref->low =3D cpu_to_le32(mi->rno);
+	ref->high =3D cpu_to_le16(mi->rno >> 32);
+#else
+	ref->low =3D cpu_to_le32(mi->rno);
+	ref->high =3D 0;
+#endif
+	ref->seq =3D mi->mrec->seq;
+}
+
+static mft_inode *ni_ins_mi(ntfs_inode *ni, struct rb_root *tree, CLST ino=
,
+			    struct rb_node *ins)
+{
+	struct rb_node **p =3D &tree->rb_node;
+	struct rb_node *pr =3D NULL;
+
+	while (*p) {
+		mft_inode *mi;
+
+		pr =3D *p;
+		mi =3D rb_entry(pr, mft_inode, node);
+		if (mi->rno > ino)
+			p =3D &pr->rb_left;
+		else if (mi->rno < ino)
+			p =3D &pr->rb_right;
+		else
+			return mi;
+	}
+
+	if (!ins)
+		return NULL;
+
+	rb_link_node(ins, pr, p);
+	rb_insert_color(ins, tree);
+	return rb_entry(ins, mft_inode, node);
+}
+
+/*
+ * ni_find_mi
+ *
+ * finds mft_inode by record number
+ */
+static mft_inode *ni_find_mi(ntfs_inode *ni, CLST rno)
+{
+	return ni_ins_mi(ni, &ni->mi_tree, rno, NULL);
+}
+
+/*
+ * ni_add_mi
+ *
+ * adds new mft_inode into ntfs_inode
+ */
+static void ni_add_mi(ntfs_inode *ni, mft_inode *mi)
+{
+	ni_ins_mi(ni, &ni->mi_tree, mi->rno, &mi->node);
+}
+
+/*
+ * ni_remove_mi
+ *
+ * removes mft_inode from ntfs_inode
+ */
+void ni_remove_mi(ntfs_inode *ni, mft_inode *mi)
+{
+	rb_erase(&mi->node, &ni->mi_tree);
+}
+
+/*
+ * ni_std
+ *
+ * returns pointer into std_info from primary record
+ */
+ATTR_STD_INFO *ni_std(ntfs_inode *ni)
+{
+	const ATTRIB *attr;
+
+	attr =3D mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
+
+	return attr ? resident_data_ex(attr, sizeof(ATTR_STD_INFO)) : NULL;
+}
+
+/*
+ * ni_clear
+ *
+ * clears resources allocated by ntfs_inode
+ */
+void ni_clear(ntfs_inode *ni)
+{
+	struct rb_node *node;
+
+	if (!ni->vfs_inode.i_nlink)
+		ni_delete_all(ni);
+
+	al_destroy(ni);
+
+	for (node =3D rb_first(&ni->mi_tree); node;) {
+		struct rb_node *next =3D rb_next(node);
+		mft_inode *mi =3D rb_entry(node, mft_inode, node);
+
+		rb_erase(node, &ni->mi_tree);
+		mi_put(mi);
+		node =3D next;
+	}
+
+	/* bad inode always has mode =3D=3D S_IFREG */
+	if (ni->ni_flags & NI_FLAG_DIR)
+		indx_clear(&ni->dir);
+	else
+		run_close(&ni->file.run);
+
+	mi_clear(&ni->mi);
+}
+
+/*
+ * ni_load_mi_ex
+ *
+ * finds mft_inode by record number.
+ */
+int ni_load_mi_ex(ntfs_inode *ni, CLST rno, mft_inode **mi)
+{
+	int err;
+	mft_inode *r;
+
+	r =3D ni_find_mi(ni, rno);
+	if (r)
+		goto out;
+
+	err =3D mi_get(ni->mi.sbi, rno, &r);
+	if (err)
+		return err;
+
+	ni_add_mi(ni, r);
+
+out:
+	if (mi)
+		*mi =3D r;
+	return 0;
+}
+
+/*
+ * ni_load_mi
+ *
+ * load mft_inode corresponded list_entry
+ */
+int ni_load_mi(ntfs_inode *ni, ATTR_LIST_ENTRY *le, mft_inode **mi)
+{
+	CLST rno;
+
+	if (!le) {
+		*mi =3D &ni->mi;
+		return 0;
+	}
+
+	rno =3D ino_get(&le->ref);
+	if (rno =3D=3D ni->mi.rno) {
+		*mi =3D &ni->mi;
+		return 0;
+	}
+	return ni_load_mi_ex(ni, rno, mi);
+}
+
+/*
+ * ni_find_attr
+ *
+ * returns attribute and record this attribute belongs to
+ */
+ATTRIB *ni_find_attr(ntfs_inode *ni, ATTRIB *attr, ATTR_LIST_ENTRY **le_o,
+		     ATTR_TYPE type, const __le16 *name, u8 name_len,
+		     const CLST *vcn, mft_inode **mi)
+{
+	ATTR_LIST_ENTRY *le;
+	mft_inode *m;
+
+	if (!ni->attr_list.size ||
+	    (!name_len && (type =3D=3D ATTR_LIST || type =3D=3D ATTR_STD))) {
+		if (le_o)
+			*le_o =3D NULL;
+		if (mi)
+			*mi =3D &ni->mi;
+
+		/* Look for required attribute in primary record */
+		return mi_find_attr(&ni->mi, attr, type, name, name_len, NULL);
+	}
+
+	/* first look for list entry of required type */
+	le =3D al_find_ex(ni, le_o ? *le_o : NULL, type, name, name_len, vcn);
+	if (!le)
+		return NULL;
+
+	if (le_o)
+		*le_o =3D le;
+
+	/* Load record that contains this attribute */
+	if (ni_load_mi(ni, le, &m))
+		return NULL;
+
+	/* Look for required attribute */
+	attr =3D mi_find_attr(m, NULL, type, name, name_len, &le->id);
+
+	if (!attr)
+		goto out;
+
+	if (!attr->non_res) {
+		if (vcn && *vcn)
+			goto out;
+	} else if (!vcn) {
+		if (attr->nres.svcn)
+			goto out;
+	} else if (le64_to_cpu(attr->nres.svcn) > *vcn ||
+		   *vcn > le64_to_cpu(attr->nres.evcn)) {
+		goto out;
+	}
+
+	if (mi)
+		*mi =3D m;
+	return attr;
+
+out:
+	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+	return NULL;
+}
+
+/*
+ * ni_enum_attr_ex
+ *
+ * enumerates attributes in ntfs_inode
+ */
+ATTRIB *ni_enum_attr_ex(ntfs_inode *ni, ATTRIB *attr, ATTR_LIST_ENTRY **le=
)
+{
+	mft_inode *mi;
+	ATTR_LIST_ENTRY *le2;
+
+	/* Do we have an attribute list? */
+	if (!ni->attr_list.size) {
+		*le =3D NULL;
+		/* Enum attributes in primary record */
+		return mi_enum_attr(&ni->mi, attr);
+	}
+
+	/* get next list entry */
+	le2 =3D *le =3D al_enumerate(ni, attr ? *le : NULL);
+	if (!le2)
+		return NULL;
+
+	/* Load record that contains the required atribute */
+	if (ni_load_mi(ni, le2, &mi))
+		return NULL;
+
+	/* Find attribute in loaded record */
+	attr =3D rec_find_attr_le(mi, le2);
+
+	return attr;
+}
+
+/*
+ * ni_load_attr
+ *
+ * loads attribute that contains given vcn
+ */
+ATTRIB *ni_load_attr(ntfs_inode *ni, ATTR_TYPE type, const __le16 *name,
+		     u8 name_len, CLST vcn, mft_inode **pmi)
+{
+	ATTR_LIST_ENTRY *le;
+	ATTRIB *attr;
+	mft_inode *mi;
+	ATTR_LIST_ENTRY *next;
+
+	if (!ni->attr_list.size) {
+		if (pmi)
+			*pmi =3D &ni->mi;
+		return mi_find_attr(&ni->mi, NULL, type, name, name_len, NULL);
+	}
+
+	le =3D al_find_ex(ni, NULL, type, name, name_len, NULL);
+
+	if (!le)
+		return NULL;
+
+	/*
+	 * Unfortunately ATTR_LIST_ENTRY contains only start vcn
+	 * So to find the ATTRIB segment that contains Vcn we should
+	 * enumerate some entries
+	 */
+	if (!vcn)
+		goto load_rec;
+
+next_le:
+	next =3D al_find_ex(ni, le, type, name, name_len, NULL);
+	if (!next || le64_to_cpu(next->vcn) > vcn)
+		goto load_rec;
+
+	le =3D next;
+	goto next_le;
+
+load_rec:
+	if (ni_load_mi(ni, le, &mi))
+		return NULL;
+
+	if (pmi)
+		*pmi =3D mi;
+
+	attr =3D mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+	if (!attr)
+		return NULL;
+
+	if (!attr->non_res)
+		return attr;
+
+	if (le64_to_cpu(attr->nres.svcn) <=3D vcn &&
+	    vcn <=3D le64_to_cpu(attr->nres.evcn))
+		return attr;
+
+	return NULL;
+}
+
+/*
+ * ni_load_all_mi
+ *
+ * loads all subrecords
+ */
+int ni_load_all_mi(ntfs_inode *ni)
+{
+	int err;
+	ATTR_LIST_ENTRY *le;
+
+	if (!ni->attr_list.size)
+		return 0;
+
+	le =3D NULL;
+
+	while ((le =3D al_enumerate(ni, le))) {
+		CLST rno =3D ino_get(&le->ref);
+
+		if (rno =3D=3D ni->mi.rno)
+			continue;
+
+		err =3D ni_load_mi_ex(ni, rno, NULL);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ni_add_subrecord
+ *
+ * allocate + format + attach a new subrecord
+ */
+bool ni_add_subrecord(ntfs_inode *ni, CLST rno, mft_inode **mi)
+{
+	mft_inode *m;
+
+	m =3D ntfs_alloc(sizeof(mft_inode), 1);
+	if (!m)
+		return false;
+
+	if (mi_format_new(m, ni->mi.sbi, rno, 0, ni->mi.rno =3D=3D MFT_REC_MFT)) =
{
+		mi_put(m);
+		return false;
+	}
+
+	get_mi_ref(&ni->mi, &m->mrec->parent_ref);
+
+	ni_add_mi(ni, m);
+	*mi =3D m;
+	return true;
+}
+
+/*
+ * ni_remove_attr
+ *
+ * removes all attributes for the given type/name/id
+ */
+int ni_remove_attr(ntfs_inode *ni, ATTR_TYPE type, const __le16 *name,
+		   size_t name_len, bool base_only, const __le16 *id)
+{
+	int err;
+	ATTRIB *attr;
+	ATTR_LIST_ENTRY *le;
+	mft_inode *mi;
+	u32 type_in;
+	int diff;
+
+	if (base_only || type =3D=3D ATTR_LIST || !ni->attr_list.size) {
+		attr =3D mi_find_attr(&ni->mi, NULL, type, name, name_len, id);
+		if (!attr)
+			return -ENOENT;
+
+		mi_remove_attr(&ni->mi, attr);
+		return 0;
+	}
+
+	type_in =3D le32_to_cpu(type);
+	le =3D NULL;
+
+	for (;;) {
+		le =3D al_enumerate(ni, le);
+		if (!le)
+			return 0;
+
+next_le2:
+		diff =3D le32_to_cpu(le->type) - type_in;
+		if (diff < 0)
+			continue;
+
+		if (diff > 0)
+			return 0;
+
+		if (le->name_len !=3D name_len)
+			continue;
+
+		if (name_len &&
+		    memcmp(le_name(le), name, name_len * sizeof(short)))
+			continue;
+
+		if (id && le->id !=3D *id)
+			continue;
+		err =3D ni_load_mi(ni, le, &mi);
+		if (err)
+			return err;
+
+		al_remove_le(ni, le);
+
+		attr =3D mi_find_attr(mi, NULL, type, name, name_len, id);
+		if (!attr)
+			return -ENOENT;
+
+		mi_remove_attr(mi, attr);
+
+		if (PtrOffset(ni->attr_list.le, le) >=3D ni->attr_list.size)
+			return 0;
+		goto next_le2;
+	}
+}
+
+/*
+ * ni_ins_new_attr
+ *
+ * inserts the attribute into record
+ * Returns not full constructed attribute or NULL if not possible to creat=
e
+ */
+static ATTRIB *ni_ins_new_attr(ntfs_inode *ni, mft_inode *mi,
+			       ATTR_LIST_ENTRY *le, ATTR_TYPE type,
+			       const __le16 *name, u8 name_len, u32 asize,
+			       u16 name_off, CLST svcn)
+{
+	int err;
+	ATTRIB *attr;
+	bool le_added =3D false;
+	MFT_REF ref;
+
+	get_mi_ref(mi, &ref);
+
+	if (type !=3D ATTR_LIST && !le && ni->attr_list.size) {
+		err =3D al_add_le(ni, type, name, name_len, svcn, cpu_to_le16(-1),
+				&ref, &le);
+		if (err)
+			return NULL;
+		le_added =3D true;
+
+		/*
+		 * al_add_le -> attr_set_size (list) -> ni_expand_list
+		 * which moves some attributes out of primary record
+		 * this means that name may point into moved memory
+		 * reinit 'name' from le
+		 */
+		name =3D le->name;
+	}
+
+	attr =3D mi_insert_attr(mi, type, name, name_len, asize, name_off);
+	if (!attr) {
+		if (le_added)
+			al_remove_le(ni, le);
+		return NULL;
+	}
+
+	if (type =3D=3D ATTR_LIST)
+		goto out;
+
+	if (!le)
+		goto out;
+
+	/* Update ATTRIB Id and record reference */
+	le->id =3D attr->id;
+	ni->attr_list.dirty =3D true;
+	le->ref =3D ref;
+
+out:
+
+	return attr;
+}
+
+/*
+ * ni_create_attr_list
+ *
+ * generates an attribute list for this primary record
+ */
+int ni_create_attr_list(ntfs_inode *ni)
+{
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+	int err;
+	u32 lsize;
+	ATTRIB *attr;
+	ATTRIB *arr_move[3];
+	ATTR_LIST_ENTRY *le, *le_b[3];
+	MFT_REC *rec;
+	bool is_mft;
+	CLST rno =3D 0;
+	mft_inode *mi;
+	u32 free_b, nb, to_free, rs;
+	u16 sz;
+
+	is_mft =3D ni->mi.rno =3D=3D MFT_REC_MFT;
+	rec =3D ni->mi.mrec;
+	rs =3D sbi->record_size;
+
+	/*
+	 * Skip estimating exact memory requirement
+	 * Looks like one record_size is always enough
+	 */
+	le =3D ntfs_alloc(al_aligned(rs), 0);
+	if (!le) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	get_mi_ref(&ni->mi, &le->ref);
+	ni->attr_list.le =3D le;
+
+	attr =3D NULL;
+	nb =3D 0;
+	free_b =3D 0;
+	attr =3D NULL;
+
+	for (; (attr =3D mi_enum_attr(&ni->mi, attr)); le =3D Add2Ptr(le, sz)) {
+		sz =3D le_size(attr->name_len);
+		WARN_ON(PtrOffset(ni->attr_list.le, le) + sz > rs);
+
+		le->type =3D attr->type;
+		le->size =3D cpu_to_le16(sz);
+		le->name_len =3D attr->name_len;
+		le->name_off =3D offsetof(ATTR_LIST_ENTRY, name);
+		le->vcn =3D 0;
+		if (le !=3D ni->attr_list.le)
+			le->ref =3D ((ATTR_LIST_ENTRY *)ni->attr_list.le)->ref;
+		le->id =3D attr->id;
+
+		if (attr->name_len)
+			memcpy(le->name, attr_name(attr),
+			       sizeof(short) * attr->name_len);
+		else if (attr->type =3D=3D ATTR_STD)
+			continue;
+		else if (attr->type =3D=3D ATTR_LIST)
+			continue;
+		else if (is_mft && attr->type =3D=3D ATTR_DATA)
+			continue;
+
+		if (!nb || nb < ARRAY_SIZE(arr_move)) {
+			le_b[nb] =3D le;
+			arr_move[nb++] =3D attr;
+			free_b +=3D le32_to_cpu(attr->size);
+		}
+	}
+
+	lsize =3D PtrOffset(ni->attr_list.le, le);
+	ni->attr_list.size =3D lsize;
+
+	to_free =3D le32_to_cpu(rec->used) + lsize + SIZEOF_RESIDENT;
+	if (to_free <=3D rs)
+		to_free =3D 0;
+	else {
+		to_free -=3D rs;
+
+		if (to_free > free_b) {
+			err =3D -EINVAL;
+			goto out1;
+		}
+	}
+
+	/* Allocate child mft. */
+	err =3D ntfs_look_free_mft(sbi, &rno, is_mft, ni, &mi);
+	if (err)
+		goto out1;
+
+	/* Call 'mi_remove_attr' in reverse order to keep pointers 'arr_move' val=
id */
+	while (to_free > 0) {
+		ATTRIB *b =3D arr_move[--nb];
+		u32 asize =3D le32_to_cpu(b->size);
+		u16 name_off =3D le16_to_cpu(b->name_off);
+
+		attr =3D mi_insert_attr(mi, b->type, Add2Ptr(b, name_off),
+				      b->name_len, asize, name_off);
+		WARN_ON(!attr);
+
+		get_mi_ref(mi, &le_b[nb]->ref);
+		le_b[nb]->id =3D attr->id;
+
+		/* copy all except id */
+		memcpy(attr, b, asize);
+		attr->id =3D le_b[nb]->id;
+
+		WARN_ON(!mi_remove_attr(&ni->mi, b));
+
+		if (to_free <=3D asize)
+			break;
+		to_free -=3D asize;
+		WARN_ON(!nb);
+	}
+
+	attr =3D mi_insert_attr(&ni->mi, ATTR_LIST, NULL, 0,
+			      lsize + SIZEOF_RESIDENT, SIZEOF_RESIDENT);
+	WARN_ON(!attr);
+
+	attr->non_res =3D 0;
+	attr->flags =3D 0;
+	attr->res.data_size =3D cpu_to_le32(lsize);
+	attr->res.data_off =3D SIZEOF_RESIDENT_LE;
+	attr->res.flags =3D 0;
+	attr->res.res =3D 0;
+
+	memcpy(resident_data_ex(attr, lsize), ni->attr_list.le, lsize);
+
+	ni->attr_list.dirty =3D false;
+
+	mark_inode_dirty(&ni->vfs_inode);
+	goto out;
+
+out1:
+	ntfs_free(ni->attr_list.le);
+	ni->attr_list.le =3D NULL;
+	ni->attr_list.size =3D 0;
+
+out:
+	return err;
+}
+
+/*
+ * ni_ins_attr_ext
+ *
+ * This method adds an external attribute to the ntfs_inode.
+ */
+static int ni_ins_attr_ext(ntfs_inode *ni, ATTR_LIST_ENTRY *le, ATTR_TYPE =
type,
+			   const __le16 *name, u8 name_len, u32 asize,
+			   CLST svcn, u16 name_off, bool force_ext,
+			   ATTRIB **ins_attr, mft_inode **ins_mi)
+{
+	ATTRIB *attr;
+	mft_inode *mi;
+	MFT_REC *rec;
+	CLST rno;
+	u64 vbo;
+	struct rb_node *node;
+	int err;
+	bool is_mft, is_mft_data;
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+
+	rec =3D ni->mi.mrec;
+	is_mft =3D ni->mi.rno =3D=3D MFT_REC_MFT;
+	is_mft_data =3D is_mft && type =3D=3D ATTR_DATA && !name_len;
+
+	if (asize > sbi->max_bytes_per_attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * standard information and attr_list cannot be made external.
+	 * The Log File cannot have any external attributes
+	 */
+	if (type =3D=3D ATTR_STD || type =3D=3D ATTR_LIST ||
+	    ni->mi.rno =3D=3D MFT_REC_LOG) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* Create attribute list if it is not already existed */
+	if (!ni->attr_list.size) {
+		err =3D ni_create_attr_list(ni);
+		if (err)
+			goto out;
+	}
+
+	vbo =3D is_mft_data ? (svcn << sbi->cluster_bits) : 0;
+
+	if (force_ext)
+		goto insert_ext;
+
+	/* Load all subrecords into memory. */
+	err =3D ni_load_all_mi(ni);
+	if (err)
+		goto out;
+
+	/* Check each of loaded subrecord */
+	for (node =3D rb_first(&ni->mi_tree); node; node =3D rb_next(node)) {
+		mi =3D rb_entry(node, mft_inode, node);
+
+		if (is_mft_data &&
+		    (mi_enum_attr(mi, NULL) ||
+		     vbo <=3D ((u64)mi->rno << sbi->record_bits))) {
+			/* We can't accept this record 'case MFT's bootstrapping */
+			continue;
+		}
+		if (is_mft &&
+		    mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0, NULL)) {
+			/*
+			 * This child record already has a ATTR_DATA.
+			 * So it can't accept any other records.
+			 */
+			continue;
+		}
+
+		if ((type !=3D ATTR_NAME || name_len) &&
+		    mi_find_attr(mi, NULL, type, name, name_len, NULL)) {
+			/* Only indexed attributes can share same record */
+			continue;
+		}
+
+		/* Try to insert attribute into this subrecord */
+		attr =3D ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
+				       name_off, svcn);
+		if (!attr)
+			continue;
+
+		if (ins_attr)
+			*ins_attr =3D attr;
+		return 0;
+	}
+
+insert_ext:
+	/* We have to allocate a new child subrecord*/
+	err =3D ntfs_look_free_mft(sbi, &rno, is_mft_data, ni, &mi);
+	if (err)
+		goto out;
+
+	if (is_mft_data && vbo <=3D ((u64)rno << sbi->record_bits)) {
+		err =3D -EINVAL;
+		goto out1;
+	}
+
+	attr =3D ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
+			       name_off, svcn);
+	if (!attr)
+		goto out2;
+
+	if (ins_attr)
+		*ins_attr =3D attr;
+	if (ins_mi)
+		*ins_mi =3D mi;
+
+	return 0;
+
+out2:
+	ni_remove_mi(ni, mi);
+	mi_put(mi);
+	err =3D -EINVAL;
+
+out1:
+	ntfs_mark_rec_free(sbi, rno);
+
+out:
+	return err;
+}
+
+/*
+ * ni_insert_attr
+ *
+ * inserts an attribute into the file.
+ *
+ * If the primary record has room, it will just insert the attribute.
+ * If not, it may make the attribute external.
+ * For $MFT::Data it may make room for the attribute by
+ * making other attributes external.
+ *
+ * NOTE:
+ * The ATTR_LIST and ATTR_STD cannot be made external.
+ * This function does not fill new attribute full
+ * It only fills 'size'/'type'/'id'/'name_len' fields
+ */
+static int ni_insert_attr(ntfs_inode *ni, ATTR_TYPE type, const __le16 *na=
me,
+			  u8 name_len, u32 asize, u16 name_off, CLST svcn,
+			  ATTRIB **ins_attr, mft_inode **ins_mi)
+{
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+	int err;
+	ATTRIB *attr, *eattr;
+	MFT_REC *rec;
+	bool is_mft;
+	ATTR_LIST_ENTRY *le;
+	u32 list_reserve, max_free, free, used, t32;
+	__le16 id;
+	u16 t16;
+
+	is_mft =3D ni->mi.rno =3D=3D MFT_REC_MFT;
+	rec =3D ni->mi.mrec;
+
+	list_reserve =3D SIZEOF_NONRESIDENT + 3 * (1 + 2 * sizeof(u32));
+	used =3D le32_to_cpu(rec->used);
+	free =3D sbi->record_size - used;
+
+	if (is_mft && type !=3D ATTR_LIST) {
+		/* Reserve space for the ATTRIB List. */
+		if (free < list_reserve)
+			free =3D 0;
+		else
+			free -=3D list_reserve;
+	}
+
+	if (asize > free)
+		goto insert_ext;
+
+	attr =3D ni_ins_new_attr(ni, &ni->mi, NULL, type, name, name_len, asize,
+			       name_off, svcn);
+	if (attr) {
+		if (ins_attr)
+			*ins_attr =3D attr;
+		if (ins_mi)
+			*ins_mi =3D &ni->mi;
+		err =3D 0;
+		goto out;
+	}
+
+insert_ext:
+	if (!is_mft || type !=3D ATTR_DATA || svcn) {
+		/* This ATTRIB will be external. */
+		err =3D ni_ins_attr_ext(ni, NULL, type, name, name_len, asize,
+				      svcn, name_off, false, ins_attr, ins_mi);
+		goto out;
+	}
+
+	/*
+	 * Here we have: "is_mft && type =3D=3D ATTR_DATA && !svcn
+	 *
+	 * The first chunk of the $MFT::Data ATTRIB must be the base record.
+	 * Evict as many other attributes as possible.
+	 */
+	max_free =3D free;
+
+	/* Estimate the result of moving all possible attributes away.*/
+	attr =3D NULL;
+
+	while ((attr =3D mi_enum_attr(&ni->mi, attr))) {
+		if (attr->type =3D=3D ATTR_STD)
+			continue;
+		if (attr->type =3D=3D ATTR_LIST)
+			continue;
+		max_free +=3D le32_to_cpu(attr->size);
+	}
+
+	if (max_free < asize + list_reserve) {
+		/* Impossible to insert this attribute into primary record */
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* Start real attribute moving */
+	attr =3D NULL;
+next_move:
+
+	attr =3D mi_enum_attr(&ni->mi, attr);
+	if (!attr) {
+		/* We should never be here 'cause we have already check this case */
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/* Skip attributes that MUST be primary record */
+	if (attr->type =3D=3D ATTR_STD)
+		goto next_move;
+	if (attr->type =3D=3D ATTR_LIST)
+		goto next_move;
+
+	le =3D NULL;
+	if (ni->attr_list.size) {
+		le =3D al_find_le(ni, NULL, attr);
+		if (!le) {
+			/* Really this is a serious bug */
+			err =3D -EINVAL;
+			goto out;
+		}
+	}
+
+	t32 =3D le32_to_cpu(attr->size);
+	t16 =3D le16_to_cpu(attr->name_off);
+	err =3D ni_ins_attr_ext(ni, le, attr->type, Add2Ptr(attr, t16),
+			      attr->name_len, t32, attr_svcn(attr), t16, false,
+			      &eattr, NULL);
+	if (err)
+		return err;
+
+	id =3D eattr->id;
+	memcpy(eattr, attr, t32);
+	eattr->id =3D id;
+
+	/* remove attrib from primary record */
+	mi_remove_attr(&ni->mi, attr);
+
+	/* attr now points to next attribute */
+	if (attr->type =3D=3D ATTR_END)
+		goto out;
+
+	/* Try to insert when the free space is enough */
+	if (asize + list_reserve > sbi->record_size - le32_to_cpu(rec->used))
+		goto next_move;
+
+	attr =3D ni_ins_new_attr(ni, &ni->mi, NULL, type, name, name_len, asize,
+			       name_off, svcn);
+	if (!attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (ins_attr)
+		*ins_attr =3D attr;
+	if (ins_mi)
+		*ins_mi =3D &ni->mi;
+
+out:
+	return err;
+}
+
+/*
+ * ni_expand_mft_list
+ *
+ * This method splits ATTR_DATA of $MFT
+ */
+static int ni_expand_mft_list(ntfs_inode *ni)
+{
+	int err =3D 0;
+	struct runs_tree *run =3D &ni->file.run;
+	u32 asize, run_size, done =3D 0;
+	ATTRIB *attr;
+	struct rb_node *node;
+	CLST mft_min, mft_new, svcn, evcn, plen;
+	mft_inode *mi, *mi_min, *mi_new;
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+
+	/* Find the nearest Mft */
+	mft_min =3D 0;
+	mft_new =3D 0;
+	mi_min =3D NULL;
+
+	for (node =3D rb_first(&ni->mi_tree); node; node =3D rb_next(node)) {
+		mi =3D rb_entry(node, mft_inode, node);
+
+		attr =3D mi_enum_attr(mi, NULL);
+
+		if (!attr) {
+			mft_min =3D mi->rno;
+			mi_min =3D mi;
+			break;
+		}
+	}
+
+	if (ntfs_look_free_mft(sbi, &mft_new, true, ni, &mi_new)) {
+		mft_new =3D 0;
+		// really this is not critical
+	} else if (mft_min > mft_new) {
+		mft_min =3D mft_new;
+		mi_min =3D mi_new;
+	} else {
+		ntfs_mark_rec_free(sbi, mft_new);
+		mft_new =3D 0;
+		ni_remove_mi(ni, mi_new);
+	}
+
+	attr =3D mi_find_attr(&ni->mi, NULL, ATTR_DATA, NULL, 0, NULL);
+	if (!attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	asize =3D le32_to_cpu(attr->size);
+
+	evcn =3D le64_to_cpu(attr->nres.evcn);
+	svcn =3D bytes_to_cluster(sbi, (u64)(mft_min + 1) << sbi->record_bits);
+	if (evcn + 1 >=3D svcn) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * split primary attribute [0 evcn] in two parts [0 svcn) + [svcn evcn]
+	 *
+	 * Update first part of ATTR_DATA in 'primary MFT
+	 */
+	err =3D run_pack(run, 0, svcn, Add2Ptr(attr, SIZEOF_NONRESIDENT),
+		       asize - SIZEOF_NONRESIDENT, &plen);
+	if (err < 0)
+		goto out;
+
+	run_size =3D QuadAlign(err);
+	err =3D 0;
+
+	if (plen < svcn) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	attr->nres.evcn =3D cpu_to_le64(svcn - 1);
+	attr->size =3D cpu_to_le32(run_size + SIZEOF_NONRESIDENT);
+	/* 'done' - how many bytes of primary MFT becomes free */
+	done =3D asize - run_size - SIZEOF_NONRESIDENT;
+	le32_sub_cpu(&ni->mi.mrec->used, done);
+
+	/* Estimate the size of second part: run_buf=3DNULL */
+	err =3D run_pack(run, svcn, evcn + 1 - svcn, NULL, sbi->record_size,
+		       &plen);
+	if (err < 0)
+		goto out;
+
+	run_size =3D QuadAlign(err);
+	err =3D 0;
+
+	if (plen < evcn + 1 - svcn) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * This function may implicitly call expand attr_list
+	 * Insert second part of ATTR_DATA in 'mi_min'
+	 */
+	attr =3D ni_ins_new_attr(ni, mi_min, NULL, ATTR_DATA, NULL, 0,
+			       SIZEOF_NONRESIDENT + run_size,
+			       SIZEOF_NONRESIDENT, svcn);
+	if (!attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	attr->non_res =3D 1;
+	attr->name_off =3D SIZEOF_NONRESIDENT_LE;
+	attr->flags =3D 0;
+
+	run_pack(run, svcn, evcn + 1 - svcn, Add2Ptr(attr, SIZEOF_NONRESIDENT),
+		 run_size, &plen);
+
+	attr->nres.svcn =3D cpu_to_le64(svcn);
+	attr->nres.evcn =3D cpu_to_le64(evcn);
+	attr->nres.run_off =3D cpu_to_le16(SIZEOF_NONRESIDENT);
+
+out:
+	if (mft_new) {
+		ntfs_mark_rec_free(sbi, mft_new);
+		ni_remove_mi(ni, mi_new);
+	}
+
+	return !err && !done ? -EOPNOTSUPP : err;
+}
+
+/*
+ * ni_expand_list
+ *
+ * This method moves all possible attributes out of primary record
+ */
+int ni_expand_list(ntfs_inode *ni)
+{
+	int err =3D 0;
+	u32 asize, done =3D 0;
+	ATTRIB *attr, *ins_attr;
+	ATTR_LIST_ENTRY *le;
+	bool is_mft;
+	MFT_REF ref;
+
+	is_mft =3D ni->mi.rno =3D=3D MFT_REC_MFT;
+
+	get_mi_ref(&ni->mi, &ref);
+	le =3D NULL;
+
+	while ((le =3D al_enumerate(ni, le))) {
+		if (le->type =3D=3D ATTR_STD)
+			continue;
+
+		if (memcmp(&ref, &le->ref, sizeof(MFT_REF)))
+			continue;
+
+		if (is_mft && le->type =3D=3D ATTR_DATA)
+			continue;
+
+		/* Find attribute in primary record */
+		attr =3D rec_find_attr_le(&ni->mi, le);
+		if (!attr) {
+			err =3D -EINVAL;
+			goto out;
+		}
+
+		asize =3D le32_to_cpu(attr->size);
+
+		/* Always insert into new record to avoid collisions (deep recursive) */
+		err =3D ni_ins_attr_ext(ni, le, attr->type, attr_name(attr),
+				      attr->name_len, asize, attr_svcn(attr),
+				      le16_to_cpu(attr->name_off), true,
+				      &ins_attr, NULL);
+
+		if (err)
+			goto out;
+
+		memcpy(ins_attr, attr, asize);
+		ins_attr->id =3D le->id;
+		mi_remove_attr(&ni->mi, attr);
+
+		done +=3D asize;
+		goto out;
+	}
+
+	if (!is_mft) {
+		err =3D -EFBIG; /* attr list is too big(?) */
+		goto out;
+	}
+
+	/* split mft data as much as possible */
+	err =3D ni_expand_mft_list(ni);
+	if (err)
+		goto out;
+
+out:
+	return !err && !done ? -EOPNOTSUPP : err;
+}
+
+/*
+ * ni_insert_nonresident
+ *
+ * inserts new nonresident attribute
+ */
+int ni_insert_nonresident(ntfs_inode *ni, ATTR_TYPE type, const __le16 *na=
me,
+			  u8 name_len, const struct runs_tree *run, CLST svcn,
+			  CLST len, __le16 flags, ATTRIB **new_attr,
+			  mft_inode **mi)
+{
+	int err;
+	CLST plen;
+	ATTRIB *attr;
+	bool is_ext =3D
+		(flags & (ATTR_FLAG_SPARSED | ATTR_FLAG_COMPRESSED)) && !svcn;
+	u32 name_size =3D QuadAlign(name_len * sizeof(short));
+	u32 name_off =3D is_ext ? SIZEOF_NONRESIDENT_EX : SIZEOF_NONRESIDENT;
+	u32 run_off =3D name_off + name_size;
+	u32 run_size, asize;
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+
+	err =3D run_pack(run, svcn, len, NULL, sbi->max_bytes_per_attr - run_off,
+		       &plen);
+	if (err < 0)
+		goto out;
+
+	run_size =3D QuadAlign(err);
+
+	if (plen < len) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	asize =3D run_off + run_size;
+
+	if (asize > sbi->max_bytes_per_attr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	err =3D ni_insert_attr(ni, type, name, name_len, asize, name_off, svcn,
+			     &attr, mi);
+
+	if (err)
+		goto out;
+
+	attr->non_res =3D 1;
+	attr->name_off =3D cpu_to_le16(name_off);
+	attr->flags =3D flags;
+
+	run_pack(run, svcn, len, Add2Ptr(attr, run_off), run_size, &plen);
+
+	attr->nres.svcn =3D cpu_to_le64(svcn);
+	attr->nres.evcn =3D cpu_to_le64((u64)svcn + len - 1);
+
+	err =3D 0;
+	if (new_attr)
+		*new_attr =3D attr;
+
+	*(__le64 *)&attr->nres.run_off =3D cpu_to_le64(run_off);
+
+	attr->nres.alloc_size =3D
+		svcn ? 0 : cpu_to_le64((u64)len << ni->mi.sbi->cluster_bits);
+	attr->nres.data_size =3D attr->nres.alloc_size;
+	attr->nres.valid_size =3D attr->nres.alloc_size;
+
+	if (is_ext) {
+		if (flags & ATTR_FLAG_COMPRESSED)
+			attr->nres.c_unit =3D COMPRESSION_UNIT;
+		attr->nres.total_size =3D attr->nres.alloc_size;
+	}
+
+out:
+	return err;
+}
+
+/*
+ * ni_insert_resident
+ *
+ * inserts new resident attribute
+ */
+int ni_insert_resident(ntfs_inode *ni, u32 data_size, ATTR_TYPE type,
+		       const __le16 *name, u8 name_len, ATTRIB **new_attr,
+		       mft_inode **mi)
+{
+	int err;
+	u32 name_size =3D QuadAlign(name_len * sizeof(short));
+	u32 asize =3D SIZEOF_RESIDENT + name_size + QuadAlign(data_size);
+	ATTRIB *attr;
+
+	err =3D ni_insert_attr(ni, type, name, name_len, asize, SIZEOF_RESIDENT,
+			     0, &attr, mi);
+	if (err)
+		return err;
+
+	attr->non_res =3D 0;
+	attr->flags =3D 0;
+
+	attr->res.data_size =3D cpu_to_le32(data_size);
+	attr->res.data_off =3D cpu_to_le16(SIZEOF_RESIDENT + name_size);
+	if (type =3D=3D ATTR_NAME)
+		attr->res.flags =3D RESIDENT_FLAG_INDEXED;
+	attr->res.res =3D 0;
+
+	if (new_attr)
+		*new_attr =3D attr;
+	return 0;
+}
+
+/*
+ * ni_remove_attr_le
+ *
+ * removes attribute from record
+ */
+int ni_remove_attr_le(ntfs_inode *ni, ATTRIB *attr, ATTR_LIST_ENTRY *le)
+{
+	int err;
+	mft_inode *mi;
+
+	err =3D ni_load_mi(ni, le, &mi);
+	if (err)
+		return err;
+
+	mi_remove_attr(mi, attr);
+
+	if (le)
+		al_remove_le(ni, le);
+
+	return 0;
+}
+
+/*
+ * ni_delete_all
+ *
+ * removes all attributes and frees allocates space
+ * ntfs_evict_inode->ntfs_clear_inode->ni_delete_all (if no links)
+ */
+int ni_delete_all(ntfs_inode *ni)
+{
+	int err;
+	ATTR_LIST_ENTRY *le =3D NULL;
+	ATTRIB *attr =3D NULL;
+	struct rb_node *node;
+	u16 roff;
+	u32 asize;
+	CLST svcn, evcn;
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+	bool nt5 =3D is_nt5(sbi);
+	MFT_REF ref;
+
+next_attr:
+	attr =3D ni_enum_attr_ex(ni, attr, &le);
+	if (!attr)
+		goto attr_list;
+
+	if (!nt5 || attr->name_len)
+		;
+	else if (attr->type =3D=3D ATTR_REPARSE) {
+		get_mi_ref(&ni->mi, &ref);
+		err =3D ntfs_remove_reparse(sbi, 0, &ref);
+	} else if (attr->type =3D=3D ATTR_ID) {
+		if (!attr->non_res &&
+		    le32_to_cpu(attr->res.data_size) >=3D sizeof(GUID))
+			err =3D ntfs_objid_remove(sbi, resident_data(attr));
+	}
+
+	if (!attr->non_res)
+		goto next_attr;
+
+	svcn =3D le64_to_cpu(attr->nres.svcn);
+	evcn =3D le64_to_cpu(attr->nres.evcn);
+
+	if (evcn + 1 <=3D svcn)
+		goto next_attr;
+
+	asize =3D le32_to_cpu(attr->size);
+	roff =3D le16_to_cpu(attr->nres.run_off);
+
+	err =3D run_unpack_ex((struct runs_tree *)(size_t)1, sbi, ni->mi.rno,
+			    svcn, evcn, Add2Ptr(attr, roff), asize - roff);
+	if (err < 0)
+		goto next_attr;
+	err =3D 0;
+
+	goto next_attr;
+
+attr_list:
+	if (!ni->attr_list.size)
+		goto free_subrecord;
+
+	run_deallocate(ni->mi.sbi, &ni->attr_list.run, true);
+	al_destroy(ni);
+
+free_subrecord:
+	/* Free all subrecords */
+	for (node =3D rb_first(&ni->mi_tree); node;) {
+		struct rb_node *next =3D rb_next(node);
+		mft_inode *mi =3D rb_entry(node, mft_inode, node);
+
+		clear_rec_inuse(mi->mrec);
+		mi->dirty =3D true;
+		mi_write(mi, 0);
+
+		ntfs_mark_rec_free(sbi, mi->rno);
+		ni_remove_mi(ni, mi);
+		mi_put(mi);
+		node =3D next;
+	}
+
+	// Free base record
+	clear_rec_inuse(ni->mi.mrec);
+	ni->mi.dirty =3D true;
+	err =3D mi_write(&ni->mi, 0);
+	ntfs_mark_rec_free(sbi, ni->mi.rno);
+
+	return err;
+}
+
+/*
+ * ni_fname_name
+ *
+ * returns file name attribute by its value
+ */
+ATTR_FILE_NAME *ni_fname_name(ntfs_inode *ni, const struct cpu_str *uni,
+			      const MFT_REF *home_dir, ATTR_LIST_ENTRY **le)
+{
+	ATTRIB *attr =3D NULL;
+	ATTR_FILE_NAME *fname;
+
+	*le =3D NULL;
+
+	/* Enumerate all names */
+next:
+	attr =3D ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL, NULL);
+	if (!attr)
+		return NULL;
+
+	fname =3D resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
+	if (!fname)
+		goto next;
+
+	if (home_dir && memcmp(home_dir, &fname->home, sizeof(*home_dir)))
+		goto next;
+
+	if (!uni)
+		goto next;
+
+	if (uni->len !=3D fname->name_len)
+		goto next;
+
+	if (ntfs_cmp_names_cpu(uni, (struct le_str *)&fname->name_len, NULL))
+		goto next;
+
+	return fname;
+}
+
+/*
+ * ni_fname_type
+ *
+ * returns file name attribute with given type
+ */
+ATTR_FILE_NAME *ni_fname_type(ntfs_inode *ni, u8 name_type,
+			      ATTR_LIST_ENTRY **le)
+{
+	ATTRIB *attr =3D NULL;
+	ATTR_FILE_NAME *fname;
+
+	*le =3D NULL;
+
+	/* Enumerate all names */
+next_name:
+	attr =3D ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL, NULL);
+	if (!attr)
+		return NULL;
+
+	fname =3D resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
+	if (fname && name_type =3D=3D fname->type)
+		return fname;
+	goto next_name;
+}
+
+/*
+ * ni_init_compress
+ *
+ * allocates and fill 'compress_ctx'
+ * used to decompress lzx and xpress
+ */
+int ni_init_compress(ntfs_inode *ni, struct COMPRESS_CTX *ctx)
+{
+	u32 c_format =3D ((ni->ni_flags & NI_FLAG_COMPRESSED_MASK) >> 8) - 1;
+	u32 chunk_bits;
+
+	switch (c_format) {
+	case WOF_COMPRESSION_XPRESS4K:
+		chunk_bits =3D 12; // 4k
+		break;
+	case WOF_COMPRESSION_LZX:
+		chunk_bits =3D 15; // 32k
+		break;
+	case WOF_COMPRESSION_XPRESS8K:
+		chunk_bits =3D 13; // 8k
+		break;
+	case WOF_COMPRESSION_XPRESS16K:
+		chunk_bits =3D 14; // 16k
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ctx->chunk_bits =3D chunk_bits;
+	ctx->offset_bits =3D ni->vfs_inode.i_size < 0x100000000ull ?
+				   2 :
+				   3; // 32 or 64 bits per offsets
+
+	ctx->compress_format =3D c_format;
+	ctx->chunk_size =3D 1u << chunk_bits;
+	ctx->chunk_num =3D -1;
+	ctx->first_chunk =3D -1;
+	ctx->total_chunks =3D (ni->vfs_inode.i_size - 1) >> chunk_bits;
+	ctx->chunk0_off =3D ctx->total_chunks << ctx->offset_bits;
+
+	return 0;
+}
+
+/*
+ * ni_parse_reparse
+ *
+ * buffer is at least 24 bytes
+ */
+enum REPARSE_SIGN ni_parse_reparse(ntfs_inode *ni, ATTRIB *attr, void *buf=
fer)
+{
+	const REPARSE_DATA_BUFFER *rp =3D NULL;
+	u32 c_format;
+	u16 len;
+	typeof(rp->CompressReparseBuffer) *cmpr;
+
+	/* Try to estimate reparse point */
+	if (!attr->non_res) {
+		rp =3D resident_data_ex(attr, sizeof(REPARSE_DATA_BUFFER));
+	} else if (le64_to_cpu(attr->nres.data_size) >=3D
+		   sizeof(REPARSE_DATA_BUFFER)) {
+		struct runs_tree run;
+
+		run_init(&run);
+
+		if (!attr_load_runs_vcn(ni, ATTR_REPARSE, NULL, 0, &run, 0) &&
+		    !ntfs_read_run_nb(ni->mi.sbi, &run, 0, buffer,
+				      sizeof(REPARSE_DATA_BUFFER), NULL)) {
+			rp =3D buffer;
+		}
+
+		run_close(&run);
+	}
+
+	if (!rp)
+		return REPARSE_NONE;
+
+	len =3D le16_to_cpu(rp->ReparseDataLength);
+	switch (rp->ReparseTag) {
+	case (IO_REPARSE_TAG_MICROSOFT | IO_REPARSE_TAG_SYMBOLIC_LINK):
+		break; /* Symbolic link */
+	case IO_REPARSE_TAG_MOUNT_POINT:
+		break; /* Mount points and junctions */
+	case IO_REPARSE_TAG_SYMLINK:
+		break;
+	case IO_REPARSE_TAG_COMPRESS:
+		cmpr =3D &rp->CompressReparseBuffer;
+		if (len < sizeof(*cmpr) ||
+		    cmpr->WofVersion !=3D WOF_CURRENT_VERSION ||
+		    cmpr->WofProvider !=3D WOF_PROVIDER_SYSTEM ||
+		    cmpr->ProviderVer !=3D WOF_PROVIDER_CURRENT_VERSION) {
+			return REPARSE_NONE;
+		}
+		c_format =3D le32_to_cpu(cmpr->CompressionFormat);
+		if (c_format > 3)
+			return REPARSE_NONE;
+
+		ni->ni_flags |=3D (c_format + 1) << 8;
+		return REPARSE_COMPRESSED;
+
+	case IO_REPARSE_TAG_DEDUP:
+		ni->ni_flags |=3D NI_FLAG_DEDUPLICATED;
+		return REPARSE_DEDUPLICATED;
+
+	default:
+		if (rp->ReparseTag & IO_REPARSE_TAG_NAME_SURROGATE)
+			break;
+
+		return REPARSE_NONE;
+	}
+
+	/* Looks like normal symlink */
+	return REPARSE_LINK;
+}
+
+/*
+ * When decompressing, we typically obtain more than one page per referenc=
e.
+ * We inject the additional pages into the page cache.
+ */
+int ni_readpage_cmpr(ntfs_inode *ni, struct page *page)
+{
+	int err;
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+	struct address_space *mapping =3D page->mapping;
+	ATTR_LIST_ENTRY *le;
+	ATTRIB *attr;
+	u8 frame_bits;
+	u32 frame_size, i, idx;
+	CLST frame, clst_data;
+	struct page *pg;
+	pgoff_t index =3D page->index, end_index;
+	u64 vbo =3D (u64)index << PAGE_SHIFT;
+	u32 pages_per_frame =3D 0;
+	struct page **pages =3D NULL;
+	char *frame_buf =3D NULL;
+	char *frame_unc;
+	u32 cmpr_size, unc_size;
+	u64 frame_vbo, valid_size;
+	size_t unc_size_fin;
+	struct COMPRESS_CTX *ctx =3D NULL;
+	bool is_compr =3D false;
+
+	end_index =3D (ni->vfs_inode.i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	if (index >=3D end_index) {
+		SetPageUptodate(page);
+		err =3D 0;
+		goto out;
+	}
+
+	le =3D NULL;
+	attr =3D ni_find_attr(ni, NULL, &le, ATTR_DATA, NULL, 0, NULL, NULL);
+	if (!attr) {
+		err =3D -ENOENT;
+		goto out;
+	}
+
+	WARN_ON(!attr->non_res);
+
+	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
+		ctx =3D ntfs_alloc(sizeof(*ctx), 1);
+		if (!ctx) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+		err =3D ni_init_compress(ni, ctx);
+		if (err)
+			goto out;
+
+		frame_bits =3D ctx->chunk_bits;
+		frame_size =3D ctx->chunk_size;
+		frame =3D vbo >> frame_bits;
+		frame_vbo =3D (u64)frame << frame_bits;
+
+		/* TODO: port lzx/xpress */
+		err =3D -EOPNOTSUPP;
+		goto out;
+	} else if (is_attr_compressed(attr)) {
+		if (sbi->cluster_size > NTFS_LZNT_MAX_CLUSTER) {
+			err =3D -EOPNOTSUPP;
+			goto out;
+		}
+
+		if (attr->nres.c_unit !=3D NTFS_LZNT_CUNIT) {
+			err =3D -EOPNOTSUPP;
+			goto out;
+		}
+
+		frame_bits =3D 4 + sbi->cluster_bits;
+		frame_size =3D 16 << sbi->cluster_bits;
+		frame =3D vbo >> frame_bits;
+		frame_vbo =3D (u64)frame << frame_bits;
+
+		err =3D attr_is_frame_compressed(ni, attr, frame, &clst_data,
+					       &is_compr);
+		if (err)
+			goto out;
+	} else {
+		WARN_ON(1);
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	pages_per_frame =3D frame_size >> PAGE_SHIFT;
+	pages =3D ntfs_alloc(pages_per_frame * sizeof(*pages), 1);
+	if (!pages) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	idx =3D (vbo - frame_vbo) >> PAGE_SHIFT;
+	pages[idx] =3D page;
+	index =3D frame_vbo >> PAGE_SHIFT;
+	kmap(page);
+
+	for (i =3D 0; i < pages_per_frame && index < end_index; i++, index++) {
+		if (i =3D=3D idx)
+			continue;
+
+		pg =3D grab_cache_page_nowait(mapping, index);
+		if (!pg)
+			continue;
+
+		pages[i] =3D pg;
+		if (!PageDirty(pg) && (!PageUptodate(pg) || PageError(pg)))
+			ClearPageError(pg);
+		kmap(pg);
+	}
+
+	valid_size =3D ni->i_valid;
+
+	if (frame_vbo >=3D valid_size || !clst_data) {
+		for (i =3D 0; i < pages_per_frame; i++) {
+			pg =3D pages[i];
+			if (!pg || PageDirty(pg) ||
+			    (PageUptodate(pg) && !PageError(pg)))
+				continue;
+
+			memset(page_address(pg), 0, PAGE_SIZE);
+			flush_dcache_page(pg);
+			SetPageUptodate(pg);
+		}
+		err =3D 0;
+		goto out1;
+	}
+
+	unc_size =3D frame_vbo + frame_size > valid_size ?
+			   (valid_size - frame_vbo) :
+			   frame_size;
+
+	/* read 'clst_data' clusters from disk */
+	cmpr_size =3D clst_data << sbi->cluster_bits;
+	frame_buf =3D ntfs_alloc(cmpr_size, 0);
+	if (!frame_buf) {
+		err =3D -ENOMEM;
+		goto out1;
+	}
+
+	err =3D ntfs_read_run_nb(sbi, &ni->file.run, frame_vbo, frame_buf,
+			       cmpr_size, NULL);
+	if (err)
+		goto out2;
+
+	spin_lock(&sbi->compress.lock);
+	frame_unc =3D sbi->compress.frame_unc;
+
+	if (!is_compr) {
+		unc_size_fin =3D unc_size;
+		frame_unc =3D frame_buf;
+	} else {
+		/* decompress: frame_buf -> frame_unc */
+		unc_size_fin =3D decompress_lznt(frame_buf, cmpr_size, frame_unc,
+					       frame_size);
+		if ((ssize_t)unc_size_fin < 0) {
+			err =3D unc_size_fin;
+			goto out3;
+		}
+
+		if (!unc_size_fin || unc_size_fin > frame_size) {
+			err =3D -EINVAL;
+			goto out3;
+		}
+	}
+
+	for (i =3D 0; i < pages_per_frame; i++) {
+		u8 *pa;
+		u32 use, done;
+		loff_t vbo;
+
+		pg =3D pages[i];
+		if (!pg)
+			continue;
+
+		if (PageDirty(pg) || (PageUptodate(pg) && !PageError(pg)))
+			continue;
+
+		pa =3D page_address(pg);
+
+		use =3D 0;
+		done =3D i * PAGE_SIZE;
+		vbo =3D frame_vbo + done;
+
+		if (vbo < valid_size && unc_size_fin > done) {
+			use =3D unc_size_fin - done;
+			if (use > PAGE_SIZE)
+				use =3D PAGE_SIZE;
+			if (vbo + use > valid_size)
+				use =3D valid_size - vbo;
+			memcpy(pa, frame_unc + done, use);
+		}
+
+		if (use < PAGE_SIZE)
+			memset(pa + use, 0, PAGE_SIZE - use);
+
+		flush_dcache_page(pg);
+		SetPageUptodate(pg);
+	}
+
+out3:
+	spin_unlock(&sbi->compress.lock);
+
+out2:
+	ntfs_free(frame_buf);
+out1:
+	for (i =3D 0; i < pages_per_frame; i++) {
+		pg =3D pages[i];
+		if (i =3D=3D idx || !pg)
+			continue;
+		kunmap(pg);
+		unlock_page(pg);
+		put_page(pg);
+	}
+
+	if (err)
+		SetPageError(page);
+	kunmap(page);
+
+out:
+	/* At this point, err contains 0 or -EIO depending on the "critical" page=
 */
+	ntfs_free(pages);
+	unlock_page(page);
+
+	ntfs_free(ctx);
+
+	return err;
+}
+
+/*
+ * ni_writepage_cmpr
+ *
+ * helper for ntfs_writepage_cmpr
+ */
+int ni_writepage_cmpr(struct page *page, int sync)
+{
+	int err;
+	struct address_space *mapping =3D page->mapping;
+	struct inode *inode =3D mapping->host;
+	loff_t i_size =3D i_size_read(inode);
+	ntfs_inode *ni =3D ntfs_i(inode);
+	ntfs_sb_info *sbi =3D ni->mi.sbi;
+	pgoff_t index =3D page->index, end_index;
+	u64 vbo =3D (u64)index << PAGE_SHIFT;
+	u32 pages_per_frame =3D 0;
+	struct page **pages =3D NULL;
+	char *frame_buf =3D NULL;
+	ATTR_LIST_ENTRY *le;
+	ATTRIB *attr;
+	u8 frame_bits;
+	u32 frame_size, i, idx, unc_size;
+	CLST frame;
+	struct page *pg;
+	char *frame_unc;
+	u64 frame_vbo;
+	size_t cmpr_size_fin, cmpr_size_clst;
+	gfp_t mask;
+
+	end_index =3D (i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	if (index >=3D end_index) {
+		SetPageUptodate(page);
+		err =3D 0;
+		goto out;
+	}
+
+	le =3D NULL;
+	attr =3D ni_find_attr(ni, NULL, &le, ATTR_DATA, NULL, 0, NULL, NULL);
+	if (!attr) {
+		err =3D -ENOENT;
+		goto out;
+	}
+
+	if (!attr->non_res) {
+		WARN_ON(1);
+		err =3D 0;
+		goto out;
+	}
+
+	if (!is_attr_compressed(attr)) {
+		WARN_ON(1);
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	if (sbi->cluster_size > NTFS_LZNT_MAX_CLUSTER) {
+		err =3D -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (attr->nres.c_unit !=3D NTFS_LZNT_CUNIT) {
+		err =3D -EOPNOTSUPP;
+		goto out;
+	}
+
+	frame_bits =3D NTFS_LZNT_CUNIT + sbi->cluster_bits;
+	frame_size =3D sbi->cluster_size << NTFS_LZNT_CUNIT;
+	frame =3D vbo >> frame_bits;
+	frame_vbo =3D (u64)frame << frame_bits;
+	unc_size =3D frame_vbo + frame_size > i_size ? (i_size - frame_vbo) :
+						     frame_size;
+
+	frame_buf =3D ntfs_alloc(frame_size, 0);
+	if (!frame_buf) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	pages_per_frame =3D frame_size >> PAGE_SHIFT;
+	pages =3D ntfs_alloc(pages_per_frame * sizeof(*pages), 1);
+	if (!pages) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
+	idx =3D (vbo - frame_vbo) >> PAGE_SHIFT;
+	pages[idx] =3D page;
+	index =3D frame_vbo >> PAGE_SHIFT;
+	mask =3D mapping_gfp_mask(mapping);
+	kmap(page);
+
+	for (i =3D 0; i < pages_per_frame && index < end_index; i++, index++) {
+		if (i =3D=3D idx)
+			continue;
+
+		// added FGP_CREAT
+		pg =3D pagecache_get_page(
+			mapping, index,
+			FGP_LOCK | FGP_NOFS | FGP_CREAT | FGP_NOWAIT, mask);
+		if (!pg)
+			continue;
+
+		pages[i] =3D pg;
+
+		if (PageError(pg)) {
+			err =3D -EIO;
+			goto out2;
+		}
+
+		if (!PageDirty(pg) && !PageUptodate(pg)) {
+			memset(page_address(pg), 0, PAGE_SIZE);
+			flush_dcache_page(pg);
+			SetPageUptodate(pg);
+		}
+
+		kmap(pg);
+	}
+
+	spin_lock(&sbi->compress.lock);
+	frame_unc =3D sbi->compress.frame_unc;
+
+	for (i =3D 0; i < pages_per_frame; i++) {
+		pg =3D pages[i];
+		if (pg)
+			memcpy(frame_unc + i * PAGE_SIZE, page_address(pg),
+			       PAGE_SIZE);
+		else
+			memset(frame_unc + i * PAGE_SIZE, 0, PAGE_SIZE);
+	}
+
+	/* compress: frame_unc -> frame_buf */
+	cmpr_size_fin =3D compress_lznt(frame_unc, unc_size, frame_buf,
+				      frame_size, sbi->compress.ctx);
+
+	cmpr_size_clst =3D ntfs_up_cluster(sbi, cmpr_size_fin);
+	if (cmpr_size_clst + sbi->cluster_size > frame_size) {
+		/* write frame as is */
+		memcpy(frame_buf, frame_unc, frame_size);
+		cmpr_size_fin =3D frame_size;
+	} else if (cmpr_size_fin) {
+		memset(frame_buf + cmpr_size_fin, 0,
+		       cmpr_size_clst - cmpr_size_fin);
+	}
+	spin_unlock(&sbi->compress.lock);
+
+	err =3D attr_allocate_frame(ni, frame, cmpr_size_fin, ni->i_valid);
+	if (err)
+		goto out2;
+
+	if (!cmpr_size_clst)
+		goto out2;
+
+	err =3D ntfs_sb_write_run(sbi, &ni->file.run, frame_vbo, frame_buf,
+				cmpr_size_clst);
+	if (err)
+		goto out2;
+
+out2:
+	ntfs_free(frame_buf);
+	for (i =3D 0; i < pages_per_frame; i++) {
+		pg =3D pages[i];
+		if (!pg || i =3D=3D idx)
+			continue;
+		kunmap(pg);
+		SetPageUptodate(pg);
+		/* clear page dirty so that writepages wouldn't work for us. */
+		ClearPageDirty(pg);
+		unlock_page(pg);
+		put_page(pg);
+	}
+
+	if (err)
+		SetPageError(page);
+	kunmap(page);
+
+out:
+	/* At this point, err contains 0 or -EIO depending on the "critical" page=
 */
+	ntfs_free(pages);
+	set_page_writeback(page);
+	unlock_page(page);
+	end_page_writeback(page);
+
+	return err;
+}
+
+/*
+ * ni_write_inode
+ *
+ * write mft base record and all subrecords to disk
+ */
+int ni_write_inode(struct inode *inode, int sync, const char *hint)
+{
+	int err =3D 0, err2;
+	ntfs_inode *ni =3D ntfs_i(inode);
+	struct super_block *sb =3D inode->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	bool modified, re_dirty =3D false;
+	mft_inode *mi;
+	MFT_REC *rec;
+	ATTR_STD_INFO *std;
+	struct rb_node *node, *next;
+	ATTR_LIST_ENTRY *le;
+	ATTRIB *attr;
+	NTFS_DUP_INFO dup;
+	bool is_meta;
+
+	if (is_bad_inode(inode))
+		return 0;
+
+	if (!ni_trylock(ni)) {
+		/* 'ni' is under modification, skip for now */
+		return 0;
+	}
+
+	is_meta =3D ntfs_is_meta_file(sbi, inode->i_ino);
+	rec =3D ni->mi.mrec;
+
+	if (!is_rec_inuse(rec) || (sbi->flags & NTFS_FLAGS_LOG_REPLAING))
+		goto write_subrecords;
+
+	if (!inode->i_nlink)
+		goto write_subrecords;
+
+	/* update times in standard attribute */
+	std =3D ni_std(ni);
+	if (!std) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	modified =3D false;
+	/* Update the access times if they have changed. */
+	dup.m_time =3D kernel2nt(&inode->i_mtime);
+	if (std->m_time !=3D dup.m_time) {
+		std->m_time =3D dup.m_time;
+		modified =3D true;
+	}
+
+	dup.c_time =3D kernel2nt(&inode->i_ctime);
+	if (std->c_time !=3D dup.c_time) {
+		std->c_time =3D dup.c_time;
+		modified =3D true;
+	}
+
+	dup.a_time =3D kernel2nt(&inode->i_atime);
+	if (std->a_time !=3D dup.a_time) {
+		std->a_time =3D dup.a_time;
+		modified =3D true;
+	}
+
+	dup.fa =3D ni->std_fa;
+	if (std->fa !=3D dup.fa) {
+		std->fa =3D dup.fa;
+		modified =3D true;
+	}
+
+	if (modified)
+		ni->mi.dirty =3D true;
+
+	if (is_meta || (!modified && !(ni->ni_flags & NI_FLAG_UPDATE_PARENT)))
+		goto skip_dir_update;
+
+	dup.cr_time =3D std->cr_time;
+	le =3D NULL;
+
+	if (ni->mi.mrec->flags & RECORD_FLAG_DIR) {
+		dup.fa |=3D FILE_ATTRIBUTE_DIRECTORY;
+		attr =3D NULL;
+		dup.alloc_size =3D 0;
+		dup.data_size =3D 0;
+	} else {
+		dup.fa &=3D ~FILE_ATTRIBUTE_DIRECTORY;
+
+		attr =3D ni_find_attr(ni, NULL, &le, ATTR_DATA, NULL, 0, NULL,
+				    &mi);
+		if (!attr)
+			dup.alloc_size =3D dup.data_size =3D 0;
+		else if (!attr->non_res) {
+			u32 data_size =3D le32_to_cpu(attr->res.data_size);
+
+			dup.alloc_size =3D cpu_to_le64(QuadAlign(data_size));
+			dup.data_size =3D cpu_to_le64(data_size);
+		} else {
+			u64 new_valid =3D ni->i_valid;
+			u64 data_size =3D le64_to_cpu(attr->nres.data_size);
+
+			dup.alloc_size =3D is_attr_ext(attr) ?
+						 attr->nres.total_size :
+						 attr->nres.alloc_size;
+			dup.data_size =3D attr->nres.data_size;
+
+			if (new_valid > data_size)
+				new_valid =3D data_size;
+			if (new_valid !=3D le64_to_cpu(attr->nres.valid_size)) {
+				attr->nres.valid_size =3D cpu_to_le64(new_valid);
+				mi->dirty =3D true;
+			}
+		}
+	}
+
+	/* TODO: fill reparse info */
+	dup.reparse =3D 0;
+	dup.ea_size =3D 0;
+
+	if (ni->ni_flags & NI_FLAG_EA) {
+		attr =3D ni_find_attr(ni, attr, &le, ATTR_EA_INFO, NULL, 0, NULL,
+				    NULL);
+		if (attr) {
+			const EA_INFO *info =3D
+				resident_data_ex(attr, sizeof(EA_INFO));
+
+			dup.ea_size =3D info->size_pack;
+		}
+	}
+
+	attr =3D NULL;
+	le =3D NULL;
+
+	while ((attr =3D ni_find_attr(ni, attr, &le, ATTR_NAME, NULL, 0, NULL,
+				    &mi))) {
+		struct inode *dir;
+		ATTR_FILE_NAME *fname;
+
+		fname =3D resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
+		if (!fname)
+			continue;
+
+		if (!memcmp(&fname->dup, &dup, sizeof(fname->dup)))
+			continue;
+
+		dir =3D ntfs_iget5(sb, &fname->home, NULL);
+
+		if (IS_ERR(dir)) {
+			;
+		} else if (is_bad_inode(dir)) {
+			iput(dir);
+		} else {
+			ntfs_inode *dir_ni =3D ntfs_i(dir);
+
+			if (!ni_trylock(dir_ni)) {
+				re_dirty =3D true;
+				iput(dir);
+				break;
+			}
+
+			indx_update_dup(dir_ni, sbi, fname, &dup, sync);
+
+			ni_unlock(dir_ni);
+			iput(dir);
+		}
+
+		memcpy(&fname->dup, &dup, sizeof(fname->dup));
+		mi->dirty =3D true;
+	}
+
+	if (re_dirty)
+		ni->ni_flags |=3D NI_FLAG_UPDATE_PARENT;
+	else
+		ni->ni_flags &=3D ~NI_FLAG_UPDATE_PARENT;
+
+skip_dir_update:
+	err =3D al_update(ni);
+	if (err)
+		goto out;
+
+write_subrecords:
+	for (node =3D rb_first(&ni->mi_tree); node; node =3D next) {
+		mft_inode *mi =3D rb_entry(node, mft_inode, node);
+		bool is_empty;
+
+		next =3D rb_next(node);
+
+		if (!mi->dirty)
+			continue;
+
+		is_empty =3D !mi_enum_attr(mi, NULL);
+
+		if (is_empty)
+			clear_rec_inuse(mi->mrec);
+
+		err2 =3D mi_write(mi, sync);
+		if (!err && err2)
+			err =3D err2;
+
+		if (is_empty) {
+			ntfs_mark_rec_free(sbi, mi->rno);
+			rb_erase(node, &ni->mi_tree);
+			mi_put(mi);
+		}
+	}
+
+	err2 =3D mi_write(&ni->mi, sync);
+	if (!err && err2)
+		err =3D err2;
+
+out:
+	ni_unlock(ni);
+
+	if (err) {
+		ntfs_error(sb, "%s r=3D%lx failed, %d.", hint, inode->i_ino, err);
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		return err;
+	}
+
+	if (re_dirty && (sb->s_flags & SB_ACTIVE))
+		mark_inode_dirty_sync(inode);
+
+	if (inode->i_ino < sbi->mft.recs_mirr)
+		sbi->flags |=3D NTFS_FLAGS_MFTMIRR;
+	return 0;
+}
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
new file mode 100644
index 000000000000..a26da5c88344
--- /dev/null
+++ b/fs/ntfs3/namei.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/namei.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/iversion.h>
+#include <linux/namei.h>
+#include <linux/nls.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+/*
+ * fill_name_de
+ *
+ * formats NTFS_DE in 'buf'
+ */
+int fill_name_de(ntfs_sb_info *sbi, void *buf, const struct qstr *name)
+{
+	int err;
+	NTFS_DE *e =3D buf;
+	u16 data_size;
+	ATTR_FILE_NAME *fname =3D (ATTR_FILE_NAME *)(e + 1);
+
+#ifndef NTFS3_64BIT_CLUSTER
+	e->ref.high =3D fname->home.high =3D 0;
+#endif
+	/* Convert input string to unicode */
+	err =3D x8_to_uni(sbi, name->name, name->len,
+			(struct cpu_str *)&fname->name_len, NTFS_NAME_LEN,
+			UTF16_LITTLE_ENDIAN);
+	if (err < 0)
+		return err;
+
+	fname->type =3D FILE_NAME_POSIX;
+	data_size =3D fname_full_size(fname);
+
+	e->size =3D cpu_to_le16(QuadAlign(data_size) + sizeof(NTFS_DE));
+	e->key_size =3D cpu_to_le16(data_size);
+	e->flags =3D 0;
+	e->Reserved =3D 0;
+
+	return 0;
+}
+
+static struct dentry *__ntfs_lookup(struct inode *dir, struct dentry *dent=
ry,
+				    struct ntfs_fnd *fnd)
+{
+	struct dentry *d;
+	struct inode *inode;
+
+	inode =3D dir_search(dir, &dentry->d_name, fnd);
+
+	if (!inode) {
+		d_add(dentry, NULL);
+		d =3D NULL;
+		goto out;
+	}
+
+	if (IS_ERR(inode)) {
+		d =3D ERR_CAST(inode);
+		goto out;
+	}
+
+	d =3D d_splice_alias(inode, dentry);
+	if (IS_ERR(d)) {
+		iput(inode);
+		goto out;
+	}
+
+out:
+	return d;
+}
+
+/*
+ * ntfs_lookup
+ *
+ * inode_operations::lookup
+ */
+static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry=
,
+				  u32 flags)
+{
+	struct dentry *de;
+	ntfs_inode *ni =3D ntfs_i(dir);
+
+	ni_lock(ni);
+
+	de =3D __ntfs_lookup(dir, dentry, NULL);
+
+	ni_unlock(ni);
+	return de;
+}
+
+/*
+ * ntfs_create
+ *
+ * inode_operations::create
+ */
+static int ntfs_create(struct inode *dir, struct dentry *dentry, umode_t m=
ode,
+		       bool excl)
+{
+	int err;
+	ntfs_inode *ni =3D ntfs_i(dir);
+	struct inode *inode;
+
+	ni_lock(ni);
+
+	err =3D ntfs_create_inode(dir, dentry, NULL, S_IFREG | mode, 0, NULL, 0,
+				excl, NULL, &inode);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_link
+ *
+ * inode_operations::link
+ */
+static int ntfs_link(struct dentry *ode, struct inode *dir, struct dentry =
*de)
+{
+	int err;
+	struct inode *inode =3D d_inode(ode);
+	ntfs_inode *ni =3D ntfs_i(inode);
+
+	if (S_ISDIR(inode->i_mode))
+		return -EPERM;
+
+	if (inode->i_nlink >=3D NTFS_LINK_MAX)
+		return -EMLINK;
+
+	ni_lock(ni);
+
+	dir->i_ctime =3D dir->i_mtime =3D inode->i_ctime =3D current_time(inode);
+	inc_nlink(inode);
+	ihold(inode);
+
+	err =3D ntfs_link_inode(inode, de);
+	if (!err) {
+		mark_inode_dirty(inode);
+		d_instantiate(de, inode);
+	} else {
+		drop_nlink(inode);
+		iput(inode);
+	}
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_unlink
+ *
+ * inode_operations::unlink
+ */
+static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	ntfs_inode *ni =3D ntfs_i(dir);
+	int err;
+
+	ni_lock(ni);
+
+	err =3D ntfs_unlink_inode(dir, dentry);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_symlink
+ *
+ * inode_operations::symlink
+ */
+static int ntfs_symlink(struct inode *dir, struct dentry *dentry,
+			const char *symname)
+{
+	int err;
+	u32 size =3D strlen(symname);
+	struct inode *inode;
+	ntfs_inode *ni =3D ntfs_i(dir);
+
+	ni_lock(ni);
+
+	err =3D ntfs_create_inode(dir, dentry, NULL, S_IFLNK | 0777, 0, symname,
+				size, 0, NULL, &inode);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_mkdir
+ *
+ * inode_operations::mkdir
+ */
+static int ntfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mo=
de)
+{
+	int err;
+	struct inode *inode;
+	ntfs_inode *ni =3D ntfs_i(dir);
+
+	ni_lock(ni);
+
+	err =3D ntfs_create_inode(dir, dentry, NULL, S_IFDIR | mode, 0, NULL, -1,
+				0, NULL, &inode);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_rmdir
+ *
+ * inode_operations::rm_dir
+ */
+static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	ntfs_inode *ni =3D ntfs_i(dir);
+	int err;
+
+	ni_lock(ni);
+
+	err =3D ntfs_unlink_inode(dir, dentry);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_rename
+ *
+ * inode_operations::rename
+ */
+static int ntfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+		       struct inode *new_dir, struct dentry *new_dentry,
+		       u32 flags)
+{
+	int err;
+	struct super_block *sb =3D old_dir->i_sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	ntfs_inode *old_diri =3D ntfs_i(old_dir);
+	ntfs_inode *new_diri =3D ntfs_i(new_dir);
+	ntfs_inode *ni;
+	ATTR_FILE_NAME *old_name, *new_name, *fname;
+	u8 name_type;
+	bool is_same;
+	struct inode *old_inode, *new_inode;
+	NTFS_DE *old_de, *new_de;
+	ATTRIB *attr;
+	ATTR_LIST_ENTRY *le;
+	u16 new_de_key_size;
+
+	static_assert(SIZEOF_ATTRIBUTE_FILENAME_MAX + SIZEOF_RESIDENT < 1024);
+	static_assert(SIZEOF_ATTRIBUTE_FILENAME_MAX + sizeof(NTFS_DE) < 1024);
+	static_assert(PATH_MAX >=3D 4 * 1024);
+
+	if (flags & ~RENAME_NOREPLACE)
+		return -EINVAL;
+
+	old_inode =3D d_inode(old_dentry);
+	new_inode =3D d_inode(new_dentry);
+
+	ni =3D ntfs_i(old_inode);
+
+	ni_lock(ni);
+
+	is_same =3D old_dentry->d_name.len =3D=3D new_dentry->d_name.len &&
+		  !memcmp(old_dentry->d_name.name, new_dentry->d_name.name,
+			  old_dentry->d_name.len);
+
+	if (is_same && old_dir =3D=3D new_dir) {
+		/* Nothing to do */
+		err =3D 0;
+		goto out1;
+	}
+
+	if (ntfs_is_meta_file(sbi, old_inode->i_ino)) {
+		err =3D -EINVAL;
+		goto out1;
+	}
+
+	if (new_inode) {
+		/*target name exists. unlink it*/
+		dget(new_dentry);
+		err =3D ntfs_unlink_inode(new_dir, new_dentry);
+		dput(new_dentry);
+		if (err)
+			goto out1;
+	}
+
+	old_de =3D __getname();
+	if (!old_de) {
+		err =3D -ENOMEM;
+		goto out1;
+	}
+
+	err =3D fill_name_de(sbi, old_de, &old_dentry->d_name);
+	if (err < 0)
+		goto out2;
+
+	old_name =3D (ATTR_FILE_NAME *)(old_de + 1);
+
+	if (is_same) {
+		new_de =3D old_de;
+	} else {
+		new_de =3D Add2Ptr(old_de, 1024);
+		err =3D fill_name_de(sbi, new_de, &new_dentry->d_name);
+		if (err < 0)
+			goto out2;
+	}
+
+	old_name->home.low =3D cpu_to_le32(old_dir->i_ino);
+#ifdef NTFS3_64BIT_CLUSTER
+	old_name->home.high =3D cpu_to_le16(old_dir->i_ino >> 32);
+#endif
+	old_name->home.seq =3D ntfs_i(old_dir)->mi.mrec->seq;
+
+	/*get pointer to file_name in mft*/
+	fname =3D ni_fname_name(ni, (struct cpu_str *)&old_name->name_len,
+			      &old_name->home, &le);
+	if (!fname) {
+		err =3D -EINVAL;
+		goto out2;
+	}
+
+	/* Copy fname info from record into new fname */
+	new_name =3D (ATTR_FILE_NAME *)(new_de + 1);
+	memcpy(&new_name->dup, &fname->dup, sizeof(fname->dup));
+
+	name_type =3D paired_name(fname->type);
+
+	/* remove first name from directory */
+	err =3D indx_delete_entry(&old_diri->dir, old_diri, old_de + 1,
+				le16_to_cpu(old_de->key_size), sbi);
+	if (err)
+		goto out3;
+
+	/* remove first name from mft */
+	err =3D ni_remove_attr_le(ni, attr_from_name(fname), le);
+	if (err)
+		goto out4;
+
+	le16_add_cpu(&ni->mi.mrec->hard_links, -1);
+	ni->mi.dirty =3D true;
+
+	if (name_type =3D=3D FILE_NAME_POSIX)
+		goto skip_short;
+
+	/* get paired name */
+	fname =3D ni_fname_type(ni, name_type, &le);
+	if (!fname)
+		goto skip_short;
+
+	/* remove second name from directory */
+	err =3D indx_delete_entry(&old_diri->dir, old_diri, fname,
+				fname_full_size(fname), sbi);
+	if (err)
+		goto out5;
+
+	/* remove second name from mft */
+	err =3D ni_remove_attr_le(ni, attr_from_name(fname), le);
+	if (err)
+		goto out6;
+
+	le16_add_cpu(&ni->mi.mrec->hard_links, -1);
+	ni->mi.dirty =3D true;
+
+skip_short:
+
+	/* Add new name */
+	new_de->ref.low =3D cpu_to_le32(old_inode->i_ino);
+#ifdef NTFS3_64BIT_CLUSTER
+	new_de->ref.high =3D cpu_to_le16(old_inode->i_ino >> 32);
+	new_name->home.high =3D cpu_to_le16(new_dir->i_ino >> 32);
+#endif
+	new_de->ref.seq =3D ni->mi.mrec->seq;
+
+	new_name->home.low =3D cpu_to_le32(new_dir->i_ino);
+	new_name->home.seq =3D ntfs_i(new_dir)->mi.mrec->seq;
+
+	new_de_key_size =3D le16_to_cpu(new_de->key_size);
+
+	/* insert new name in mft */
+	err =3D ni_insert_resident(ni, new_de_key_size, ATTR_NAME, NULL, 0, &attr=
,
+				 NULL);
+	if (err)
+		goto out7;
+
+	attr->res.flags =3D RESIDENT_FLAG_INDEXED;
+
+	memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), new_name, new_de_key_size);
+
+	le16_add_cpu(&ni->mi.mrec->hard_links, 1);
+	ni->mi.dirty =3D true;
+
+	/* insert new name in directory */
+	err =3D indx_insert_entry(&new_diri->dir, new_diri, new_de, sbi, NULL);
+	if (err)
+		goto out8;
+
+	if (IS_DIRSYNC(new_dir))
+		err =3D ntfs_sync_inode(old_inode);
+	else
+		mark_inode_dirty(old_inode);
+
+	old_dir->i_ctime =3D old_dir->i_mtime =3D current_time(old_dir);
+	if (IS_DIRSYNC(old_dir))
+		(void)ntfs_sync_inode(old_dir);
+	else
+		mark_inode_dirty(old_dir);
+
+	if (old_dir !=3D new_dir) {
+		new_dir->i_mtime =3D new_dir->i_ctime =3D old_dir->i_ctime;
+		mark_inode_dirty(new_dir);
+#ifdef NTFS_COUNT_CONTAINED
+		if (S_ISDIR(old_inode->i_mode)) {
+			drop_nlink(old_dir);
+			if (!new_inode)
+				inc_nlink(new_dir);
+		}
+#endif
+	}
+
+	if (old_inode) {
+		old_inode->i_ctime =3D old_dir->i_ctime;
+		mark_inode_dirty(old_inode);
+	}
+
+	err =3D 0;
+	goto out2;
+
+out8:
+	mi_remove_attr(&ni->mi, attr);
+
+out7:
+out6:
+out5:
+out4:
+	/* Undo:
+	 *err =3D indx_delete_entry(&old_diri->dir, old_diri, old_de + 1,
+	 *			old_de->key_size, NULL);
+	 */
+
+out3:
+out2:
+	__putname(old_de);
+out1:
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_atomic_open
+ *
+ * inode_operations::atomic_open
+ */
+static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
+			    struct file *file, u32 flags, umode_t mode)
+{
+	int err;
+	bool excl =3D !!(flags & O_EXCL);
+	struct inode *inode;
+	struct ntfs_fnd *fnd =3D NULL;
+	ntfs_inode *ni =3D ntfs_i(dir);
+
+	ni_lock(ni);
+
+	if (d_in_lookup(dentry)) {
+		struct dentry *d;
+
+		fnd =3D fnd_get(&ntfs_i(dir)->dir);
+		if (!fnd) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+
+		d =3D __ntfs_lookup(dir, dentry, fnd);
+		if (IS_ERR(d)) {
+			err =3D PTR_ERR(d);
+			d =3D NULL;
+			goto out1;
+		}
+
+		if (d)
+			dentry =3D d;
+
+		if (d_really_is_positive(dentry)) {
+			if (file->f_mode & FMODE_OPENED) {
+				dput(d);
+				err =3D 0;
+			} else
+				err =3D finish_no_open(file, d);
+			goto out1;
+		}
+		WARN_ON(d);
+	}
+
+	if (!(flags & O_CREAT)) {
+		err =3D -ENOENT;
+		goto out1;
+	}
+
+	err =3D ntfs_create_inode(dir, dentry, file, mode, 0, NULL, 0, excl, fnd,
+				&inode);
+
+out1:
+	fnd_put(fnd);
+out:
+	ni_unlock(ni);
+
+	return err;
+}
+
+struct dentry *ntfs_get_parent(struct dentry *child)
+{
+	struct inode *inode =3D d_inode(child);
+	ntfs_inode *ni =3D ntfs_i(inode);
+
+	ATTR_LIST_ENTRY *le =3D NULL;
+	ATTRIB *attr =3D NULL;
+	ATTR_FILE_NAME *fname;
+
+	while ((attr =3D ni_find_attr(ni, attr, &le, ATTR_NAME, NULL, 0, NULL,
+				    NULL))) {
+		fname =3D resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
+		if (!fname)
+			continue;
+
+		return d_obtain_alias(
+			ntfs_iget5(inode->i_sb, &fname->home, NULL));
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+const struct inode_operations ntfs_dir_inode_operations =3D {
+	.lookup =3D ntfs_lookup,
+	.create =3D ntfs_create,
+	.link =3D ntfs_link,
+	.unlink =3D ntfs_unlink,
+	.symlink =3D ntfs_symlink,
+	.mkdir =3D ntfs_mkdir,
+	.rmdir =3D ntfs_rmdir,
+	.rename =3D ntfs_rename,
+	.permission =3D ntfs_permission,
+	.get_acl =3D ntfs_get_acl,
+	.set_acl =3D ntfs_set_acl,
+	.setattr =3D ntfs_setattr,
+	.getattr =3D ntfs_getattr,
+	.listxattr =3D ntfs_listxattr,
+	.atomic_open =3D ntfs_atomic_open,
+};
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
new file mode 100644
index 000000000000..ffa08f552823
--- /dev/null
+++ b/fs/ntfs3/record.c
@@ -0,0 +1,612 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/record.c
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
+static inline int compare_attr(const ATTRIB *left, ATTR_TYPE type,
+			       const __le16 *name, u8 name_len,
+			       const u16 *upcase)
+{
+	/* First, compare the type codes: */
+	int diff =3D le32_to_cpu(left->type) - le32_to_cpu(type);
+
+	if (diff)
+		return diff;
+
+	/*
+	 * They have the same type code, so we have to compare the names.
+	 * First compare case insensitive
+	 */
+	diff =3D ntfs_cmp_names(attr_name(left), left->name_len, name, name_len,
+			      upcase);
+	if (diff)
+		return diff;
+
+	/* Second compare case sensitive */
+	return ntfs_cmp_names(attr_name(left), left->name_len, name, name_len,
+			      NULL);
+}
+
+/*
+ * mi_new_attt_id
+ *
+ * returns unused attribute id that is less than mrec->next_attr_id
+ */
+static __le16 mi_new_attt_id(mft_inode *mi)
+{
+	u16 free_id, max_id, t16;
+	MFT_REC *rec =3D mi->mrec;
+	ATTRIB *attr;
+	__le16 id;
+
+	id =3D rec->next_attr_id;
+	free_id =3D le16_to_cpu(id);
+	if (free_id < 0x7FFF) {
+		rec->next_attr_id =3D cpu_to_le16(free_id + 1);
+		return id;
+	}
+
+	/* One record can store up to 1024/24 ~=3D 42 attributes */
+	free_id =3D 0;
+	max_id =3D 0;
+
+	attr =3D NULL;
+
+next_attr:
+	attr =3D mi_enum_attr(mi, attr);
+	if (!attr) {
+		rec->next_attr_id =3D cpu_to_le16(max_id + 1);
+		mi->dirty =3D true;
+		return cpu_to_le16(free_id);
+	}
+
+	t16 =3D le16_to_cpu(attr->id);
+	if (t16 =3D=3D free_id) {
+		free_id +=3D 1;
+		attr =3D NULL;
+		goto next_attr;
+	}
+
+	if (max_id < t16)
+		max_id =3D t16;
+	goto next_attr;
+}
+
+int mi_get(ntfs_sb_info *sbi, CLST rno, mft_inode **mi)
+{
+	int err;
+	mft_inode *m =3D ntfs_alloc(sizeof(mft_inode), 1);
+
+	if (!m)
+		return -ENOMEM;
+
+	err =3D mi_init(m, sbi, rno);
+	if (!err)
+		err =3D mi_read(m, false);
+
+	if (err) {
+		mi_put(m);
+		return err;
+	}
+
+	*mi =3D m;
+	return 0;
+}
+
+void mi_put(mft_inode *mi)
+{
+	mi_clear(mi);
+	ntfs_free(mi);
+}
+
+int mi_init(mft_inode *mi, ntfs_sb_info *sbi, CLST rno)
+{
+	mi->sbi =3D sbi;
+	mi->rno =3D rno;
+	mi->mrec =3D ntfs_alloc(sbi->record_size, 0);
+	if (!mi->mrec)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * mi_read
+ *
+ * reads MFT data
+ */
+int mi_read(mft_inode *mi, bool is_mft)
+{
+	int err;
+	MFT_REC *rec =3D mi->mrec;
+	ntfs_sb_info *sbi =3D mi->sbi;
+	u32 bpr =3D sbi->record_size;
+	u64 vbo =3D (u64)mi->rno << sbi->record_bits;
+	ntfs_inode *mft_ni =3D sbi->mft.ni;
+	struct runs_tree *run =3D mft_ni ? &mft_ni->file.run : NULL;
+	struct rw_semaphore *rw_lock =3D NULL;
+
+	if (is_mounted(sbi)) {
+		if (!is_mft) {
+			rw_lock =3D &mft_ni->file.run_lock;
+			down_read(rw_lock);
+		}
+	}
+
+	err =3D ntfs_read_bh_ex(sbi, run, vbo, &rec->rhdr, bpr, &mi->nb);
+	if (rw_lock)
+		up_read(rw_lock);
+	if (!err)
+		goto ok;
+
+	if (err =3D=3D 1) {
+		mi->dirty =3D true;
+		goto ok;
+	}
+
+	if (err !=3D -ENOENT)
+		goto out;
+
+	if (rw_lock) {
+		ni_lock(mft_ni);
+		down_write(rw_lock);
+	}
+	err =3D attr_load_runs_vcn(mft_ni, ATTR_DATA, NULL, 0, &mft_ni->file.run,
+				 vbo >> sbi->cluster_bits);
+	if (rw_lock) {
+		up_write(rw_lock);
+		ni_unlock(mft_ni);
+	}
+	if (err)
+		goto out;
+
+	if (rw_lock)
+		down_read(rw_lock);
+	err =3D ntfs_read_bh_ex(sbi, run, vbo, &rec->rhdr, bpr, &mi->nb);
+	if (rw_lock)
+		up_read(rw_lock);
+
+	if (err =3D=3D 1) {
+		mi->dirty =3D true;
+		goto ok;
+	}
+	if (err)
+		goto out;
+
+ok:
+	/* check field 'total' only here */
+	if (le32_to_cpu(rec->total) !=3D bpr) {
+		err =3D -EINVAL;
+		goto out;
+	}
+
+	return 0;
+
+out:
+	return err;
+}
+
+ATTRIB *mi_enum_attr(mft_inode *mi, ATTRIB *attr)
+{
+	const MFT_REC *rec =3D mi->mrec;
+	u32 used =3D le32_to_cpu(rec->used);
+	u32 t32, off, asize;
+	u16 t16;
+
+	if (!attr) {
+		u32 total =3D le32_to_cpu(rec->total);
+
+		off =3D le16_to_cpu(rec->attr_off);
+
+		if (used > total)
+			goto out;
+
+		if (off >=3D used || off < MFTRECORD_FIXUP_OFFSET_1 ||
+		    !IsDwordAligned(off)) {
+			goto out;
+		}
+
+		/* Skip non-resident records */
+		if (!is_rec_inuse(rec))
+			goto out;
+
+		attr =3D Add2Ptr(rec, off);
+	} else {
+		/* Check if input attr inside record */
+		off =3D PtrOffset(rec, attr);
+		if (off >=3D used)
+			goto out;
+
+		asize =3D le32_to_cpu(attr->size);
+		if (asize < SIZEOF_RESIDENT)
+			goto out;
+
+		attr =3D Add2Ptr(attr, asize);
+		off +=3D asize;
+	}
+
+	asize =3D le32_to_cpu(attr->size);
+
+	/* Can we use the first field (attr->type) */
+	if (off + 8 > used) {
+		static_assert(QuadAlign(sizeof(ATTR_TYPE)) =3D=3D 8);
+		goto out;
+	}
+
+	if (attr->type =3D=3D ATTR_END) {
+		if (used !=3D off + 8)
+			goto out;
+		return NULL;
+	}
+
+	t32 =3D le32_to_cpu(attr->type);
+	if ((t32 & 0xf) || (t32 > 0x100))
+		goto out;
+
+	/* Check boundary */
+	if (off + asize > used)
+		goto out;
+
+	/* Check size of attribute */
+	if (!attr->non_res) {
+		if (asize < SIZEOF_RESIDENT)
+			goto out;
+
+		t16 =3D le16_to_cpu(attr->res.data_off);
+
+		if (t16 > asize)
+			goto out;
+
+		t32 =3D le32_to_cpu(attr->res.data_size);
+		if (t16 + t32 > asize)
+			goto out;
+
+		return attr;
+	}
+
+	/* Check some nonresident fields */
+	if (attr->name_len &&
+	    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len >
+		    le16_to_cpu(attr->nres.run_off)) {
+		goto out;
+	}
+
+	if (attr->nres.svcn || !is_attr_ext(attr)) {
+		if (asize + 8 < SIZEOF_NONRESIDENT)
+			goto out;
+
+		if (attr->nres.c_unit)
+			goto out;
+	} else if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+		goto out;
+
+	return attr;
+
+out:
+	return NULL;
+}
+
+/*
+ * mi_find_attr
+ *
+ * finds the attribute by type and name and id
+ */
+ATTRIB *mi_find_attr(mft_inode *mi, ATTRIB *attr, ATTR_TYPE type,
+		     const __le16 *name, size_t name_len, const __le16 *id)
+{
+	u32 type_in =3D le32_to_cpu(type);
+	u32 atype;
+
+next_attr:
+	attr =3D mi_enum_attr(mi, attr);
+	if (!attr)
+		return NULL;
+
+	atype =3D le32_to_cpu(attr->type);
+	if (atype > type_in)
+		return NULL;
+
+	if (atype < type_in)
+		goto next_attr;
+
+	if (attr->name_len !=3D name_len)
+		goto next_attr;
+
+	if (name_len && memcmp(attr_name(attr), name, name_len * sizeof(short)))
+		goto next_attr;
+
+	if (id && *id !=3D attr->id)
+		goto next_attr;
+
+	return attr;
+}
+
+int mi_write(mft_inode *mi, int wait)
+{
+	MFT_REC *rec;
+	int err;
+	ntfs_sb_info *sbi;
+
+	if (!mi->dirty)
+		return 0;
+
+	sbi =3D mi->sbi;
+	rec =3D mi->mrec;
+
+	err =3D ntfs_write_bh_ex(sbi, &rec->rhdr, &mi->nb, wait);
+	if (err)
+		return err;
+
+	mi->dirty =3D false;
+
+	return 0;
+}
+
+int mi_format_new(mft_inode *mi, ntfs_sb_info *sbi, CLST rno, __le16 flags=
,
+		  bool is_mft)
+{
+	int err;
+	u16 seq =3D 1;
+	MFT_REC *rec;
+	u64 vbo =3D (u64)rno << sbi->record_bits;
+
+	err =3D mi_init(mi, sbi, rno);
+	if (err)
+		return err;
+
+	rec =3D mi->mrec;
+
+	if (rno =3D=3D MFT_REC_MFT)
+		;
+	else if (rno < MFT_REC_FREE)
+		seq =3D rno;
+	else if (rno >=3D sbi->mft.used)
+		;
+	else if (mi_read(mi, is_mft))
+		;
+	else if (rec->rhdr.sign =3D=3D NTFS_FILE_SIGNATURE) {
+		/* Record is reused. Update its sequence number */
+		seq =3D le16_to_cpu(rec->seq) + 1;
+		if (!seq)
+			seq =3D 1;
+	}
+
+	memcpy(rec, sbi->new_rec, sbi->record_size);
+
+	rec->seq =3D cpu_to_le16(seq);
+	rec->flags =3D RECORD_FLAG_IN_USE | flags;
+
+	mi->dirty =3D true;
+
+	if (!mi->nb.nbufs) {
+		ntfs_inode *ni =3D sbi->mft.ni;
+		bool lock =3D false;
+
+		if (is_mounted(sbi) && !is_mft) {
+			down_read(&ni->file.run_lock);
+			lock =3D true;
+		}
+
+		err =3D ntfs_get_bh(sbi, &ni->file.run, vbo, sbi->record_size,
+				  &mi->nb);
+		if (lock)
+			up_read(&ni->file.run_lock);
+	}
+
+	return err;
+}
+
+/*
+ * mi_mark_free
+ *
+ * marks record as unused and marks it as free in bitmap
+ */
+void mi_mark_free(mft_inode *mi)
+{
+	CLST rno =3D mi->rno;
+	ntfs_sb_info *sbi =3D mi->sbi;
+
+	if (rno >=3D MFT_REC_RESERVED && rno < MFT_REC_FREE) {
+		ntfs_clear_mft_tail(sbi, rno, rno + 1);
+		mi->dirty =3D false;
+		return;
+	}
+
+	if (mi->mrec) {
+		clear_rec_inuse(mi->mrec);
+		mi->dirty =3D true;
+		mi_write(mi, 0);
+	}
+	ntfs_mark_rec_free(sbi, rno);
+}
+
+/*
+ * mi_insert_attr
+ *
+ * reserves space for new attribute
+ * returns not full constructed attribute or NULL if not possible to creat=
e
+ */
+ATTRIB *mi_insert_attr(mft_inode *mi, ATTR_TYPE type, const __le16 *name,
+		       u8 name_len, u32 asize, u16 name_off)
+{
+	size_t tail;
+	ATTRIB *attr;
+	__le16 id;
+	MFT_REC *rec =3D mi->mrec;
+	ntfs_sb_info *sbi =3D mi->sbi;
+	u32 used =3D le32_to_cpu(rec->used);
+	const u16 *upcase =3D sbi->upcase;
+	int diff;
+
+	/* Can we insert mi attribute? */
+	if (used + asize > mi->sbi->record_size)
+		return NULL;
+
+	/*
+	 * Scan through the list of attributes to find the point
+	 * at which we should insert it.
+	 */
+	attr =3D NULL;
+	while ((attr =3D mi_enum_attr(mi, attr))) {
+		diff =3D compare_attr(attr, type, name, name_len, upcase);
+		if (diff > 0)
+			break;
+		if (diff < 0)
+			continue;
+
+		if (!is_attr_indexed(attr))
+			return NULL;
+		break;
+	}
+
+	if (!attr) {
+		tail =3D 8; /* not used, just to suppress warning */
+		attr =3D Add2Ptr(rec, used - 8);
+	} else {
+		tail =3D used - PtrOffset(rec, attr);
+	}
+
+	id =3D mi_new_attt_id(mi);
+
+	memmove(Add2Ptr(attr, asize), attr, tail);
+	memset(attr, 0, asize);
+
+	attr->type =3D type;
+	attr->size =3D cpu_to_le32(asize);
+	attr->name_len =3D name_len;
+	attr->name_off =3D cpu_to_le16(name_off);
+	attr->id =3D id;
+
+	memmove(Add2Ptr(attr, name_off), name, name_len * sizeof(short));
+	rec->used =3D cpu_to_le32(used + asize);
+
+	mi->dirty =3D true;
+
+	return attr;
+}
+
+/*
+ * mi_remove_attr
+ *
+ * removes the attribute from record
+ * NOTE: The source attr will point to next attribute
+ */
+bool mi_remove_attr(mft_inode *mi, ATTRIB *attr)
+{
+	MFT_REC *rec =3D mi->mrec;
+	u32 aoff =3D PtrOffset(rec, attr);
+	u32 used =3D le32_to_cpu(rec->used);
+	u32 asize =3D le32_to_cpu(attr->size);
+
+	if (aoff + asize > used)
+		return false;
+
+	used -=3D asize;
+	memmove(attr, Add2Ptr(attr, asize), used - aoff);
+	rec->used =3D cpu_to_le32(used);
+	mi->dirty =3D true;
+
+	return true;
+}
+
+bool mi_resize_attr(mft_inode *mi, ATTRIB *attr, int bytes)
+{
+	MFT_REC *rec =3D mi->mrec;
+	u32 aoff =3D PtrOffset(rec, attr);
+	u32 total, used =3D le32_to_cpu(rec->used);
+	u32 nsize, asize =3D le32_to_cpu(attr->size);
+	u32 rsize =3D le32_to_cpu(attr->res.data_size);
+	int tail =3D (int)(used - aoff - asize);
+	int dsize;
+	char *next;
+
+	if (tail < 0 || aoff >=3D used)
+		return false;
+
+	if (!bytes)
+		return true;
+
+	total =3D le32_to_cpu(rec->total);
+	next =3D Add2Ptr(attr, asize);
+
+	if (bytes > 0) {
+		dsize =3D QuadAlign(bytes);
+		if (used + dsize > total)
+			return false;
+		nsize =3D asize + dsize;
+		// move tail
+		memmove(next + dsize, next, tail);
+		memset(next, 0, dsize);
+		used +=3D dsize;
+		rsize +=3D dsize;
+	} else {
+		dsize =3D QuadAlign(-bytes);
+		if (dsize > asize)
+			return false;
+		nsize =3D asize - dsize;
+		memmove(next - dsize, next, tail);
+		used -=3D dsize;
+		rsize -=3D dsize;
+	}
+
+	rec->used =3D cpu_to_le32(used);
+	attr->size =3D cpu_to_le32(nsize);
+	if (!attr->non_res)
+		attr->res.data_size =3D cpu_to_le32(rsize);
+	mi->dirty =3D true;
+
+	return true;
+}
+
+int mi_pack_runs(mft_inode *mi, ATTRIB *attr, struct runs_tree *run, CLST =
len)
+{
+	int err =3D 0;
+	ntfs_sb_info *sbi =3D mi->sbi;
+	u32 new_run_size;
+	CLST plen;
+	MFT_REC *rec =3D mi->mrec;
+	CLST svcn =3D le64_to_cpu(attr->nres.svcn);
+	u32 used =3D le32_to_cpu(rec->used);
+	u32 aoff =3D PtrOffset(rec, attr);
+	u32 asize =3D le32_to_cpu(attr->size);
+	char *next =3D Add2Ptr(attr, asize);
+	u16 run_off =3D le16_to_cpu(attr->nres.run_off);
+	u32 run_size =3D asize - run_off;
+	u32 tail =3D used - aoff - asize;
+	u32 dsize =3D sbi->record_size - used;
+
+	/* Make a maximum gap in current record */
+	memmove(next + dsize, next, tail);
+
+	/* Pack as much as possible */
+	err =3D run_pack(run, svcn, len, Add2Ptr(attr, run_off), run_size + dsize=
,
+		       &plen);
+	if (err < 0) {
+		memmove(next, next + dsize, tail);
+		return err;
+	}
+
+	new_run_size =3D QuadAlign(err);
+
+	memmove(next + new_run_size - run_size, next + dsize, tail);
+
+	attr->size =3D cpu_to_le32(asize + new_run_size - run_size);
+	attr->nres.evcn =3D cpu_to_le64(svcn + plen - 1);
+	rec->used =3D cpu_to_le32(used + new_run_size - run_size);
+	mi->dirty =3D true;
+
+	return 0;
+}
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
new file mode 100644
index 000000000000..b500200be231
--- /dev/null
+++ b/fs/ntfs3/run.c
@@ -0,0 +1,1188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/run.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/nls.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+struct ntfs_run {
+	CLST vcn; /* virtual cluster number */
+	CLST len; /* length in clusters */
+	CLST lcn; /* logical cluster number */
+};
+
+/*
+ * run_lookup
+ *
+ * Lookup the index of a MCB entry that is first <=3D vcn.
+ * case of success it will return non-zero value and set
+ * 'index' parameter to index of entry been found.
+ * case of entry missing from list 'index' will be set to
+ * point to insertion position for the entry question.
+ */
+bool run_lookup(const struct runs_tree *run, CLST vcn, size_t *index)
+{
+	size_t min_idx, max_idx, mid_idx;
+	struct ntfs_run *r;
+
+	if (!run->count) {
+		*index =3D 0;
+		return false;
+	}
+
+	min_idx =3D 0;
+	max_idx =3D run->count - 1;
+
+	/* Check boundary cases specially, 'cause they cover the often requests *=
/
+	r =3D run->runs_;
+	if (vcn < r->vcn) {
+		*index =3D 0;
+		return false;
+	}
+
+	if (vcn < r->vcn + r->len) {
+		*index =3D 0;
+		return true;
+	}
+
+	r +=3D max_idx;
+	if (vcn >=3D r->vcn + r->len) {
+		*index =3D run->count;
+		return false;
+	}
+
+	if (vcn >=3D r->vcn) {
+		*index =3D max_idx;
+		return true;
+	}
+
+	do {
+		mid_idx =3D min_idx + ((max_idx - min_idx) >> 1);
+		r =3D run->runs_ + mid_idx;
+
+		if (vcn < r->vcn) {
+			max_idx =3D mid_idx - 1;
+			if (!mid_idx)
+				break;
+		} else if (vcn >=3D r->vcn + r->len) {
+			min_idx =3D mid_idx + 1;
+		} else {
+			*index =3D mid_idx;
+			return true;
+		}
+	} while (min_idx <=3D max_idx);
+
+	*index =3D max_idx + 1;
+	return false;
+}
+
+/*
+ * run_consolidate
+ *
+ * consolidate runs starting from a given one.
+ */
+static void run_consolidate(struct runs_tree *run, size_t index)
+{
+	size_t i;
+	struct ntfs_run *r =3D run->runs_ + index;
+
+	while (index + 1 < run->count) {
+		/*
+		 * I should merge current run with next
+		 * if start of the next run lies inside one being tested.
+		 */
+		struct ntfs_run *n =3D r + 1;
+		CLST end =3D r->vcn + r->len;
+		CLST dl;
+
+		/* Stop if runs are not aligned one to another. */
+		if (n->vcn > end)
+			break;
+
+		dl =3D end - n->vcn;
+
+		/*
+		 * If range at index overlaps with next one
+		 * then I will either adjust it's start position
+		 * or (if completely matches) dust remove one from the list.
+		 */
+		if (dl > 0) {
+			if (n->len <=3D dl)
+				goto remove_next_range;
+
+			n->len -=3D dl;
+			n->vcn +=3D dl;
+			if (n->lcn !=3D SPARSE_LCN)
+				n->lcn +=3D dl;
+		}
+
+		/*
+		 * Stop if sparse mode does not match
+		 * both current and next runs.
+		 */
+		if ((n->lcn =3D=3D SPARSE_LCN) !=3D (r->lcn =3D=3D SPARSE_LCN)) {
+			index +=3D 1;
+			r =3D n;
+			continue;
+		}
+
+		/*
+		 * Check if volume block
+		 * of a next run lcn does not match
+		 * last volume block of the current run.
+		 */
+		if (n->lcn !=3D SPARSE_LCN && n->lcn !=3D r->lcn + r->len)
+			break;
+
+		/*
+		 * Next and current are siblings.
+		 * Eat/join.
+		 */
+		r->len +=3D n->len - dl;
+
+remove_next_range:
+		i =3D run->count - (index + 1);
+		if (i > 1)
+			memmove(n, n + 1, sizeof(*n) * (i - 1));
+
+		run->count -=3D 1;
+	}
+}
+
+bool run_is_mapped_full(const struct runs_tree *run, CLST svcn, CLST evcn)
+{
+	size_t index;
+
+	if (!run_lookup(run, svcn, &index))
+		return false;
+
+	do {
+		const struct ntfs_run *m =3D run->runs_ + index;
+		CLST end =3D m->vcn + m->len;
+
+		if (end > evcn)
+			return true;
+	} while (++index < run->count);
+
+	return false;
+}
+
+bool run_lookup_entry(const struct runs_tree *run, CLST vcn, CLST *lcn,
+		      CLST *len, size_t *index)
+{
+	size_t idx;
+	CLST gap;
+	struct ntfs_run *r;
+
+	/* Fail immediately if nrun was not touched yet. */
+	if (!run->runs_)
+		return false;
+
+	if (!run_lookup(run, vcn, &idx))
+		return false;
+
+	r =3D run->runs_ + idx;
+
+	if (vcn >=3D r->vcn + r->len)
+		return false;
+
+	gap =3D vcn - r->vcn;
+	if (r->len <=3D gap)
+		return false;
+
+	*lcn =3D r->lcn =3D=3D SPARSE_LCN ? SPARSE_LCN : (r->lcn + gap);
+
+	if (len)
+		*len =3D r->len - gap;
+	if (index)
+		*index =3D idx;
+
+	return true;
+}
+
+/*
+ * run_truncate_head
+ *
+ * decommit the range before vcn
+ */
+void run_truncate_head(struct runs_tree *run, CLST vcn)
+{
+	size_t index;
+	struct ntfs_run *r;
+
+	if (run_lookup(run, vcn, &index)) {
+		r =3D run->runs_ + index;
+
+		if (vcn > r->vcn) {
+			CLST dlen =3D vcn - r->vcn;
+
+			r->vcn =3D vcn;
+			r->len -=3D dlen;
+			if (r->lcn !=3D SPARSE_LCN)
+				r->lcn +=3D dlen;
+		}
+
+		if (!index)
+			return;
+	}
+	r =3D run->runs_;
+	memmove(r, r + index, sizeof(*r) * (run->count - index));
+
+	run->count -=3D index;
+
+	if (!run->count) {
+		ntfs_free(run->runs_);
+		run->runs_ =3D NULL;
+		run->allocated =3D 0;
+	}
+}
+
+/*
+ * run_truncate
+ *
+ * decommit the range after vcn
+ */
+void run_truncate(struct runs_tree *run, CLST vcn)
+{
+	size_t index;
+
+	/*
+	 * If I hit the range then
+	 * I have to truncate one.
+	 * If range to be truncated is becoming empty
+	 * then it will entirely be removed.
+	 */
+	if (run_lookup(run, vcn, &index)) {
+		struct ntfs_run *r =3D run->runs_ + index;
+
+		r->len =3D vcn - r->vcn;
+
+		if (r->len > 0)
+			index +=3D 1;
+	}
+
+	/*
+	 * At this point 'index' is set to
+	 * position that should be thrown away (including index itself)
+	 * Simple one - just set the limit.
+	 */
+	run->count =3D index;
+
+	/* Do not reallocate array 'runs'. Only free if possible */
+	if (!index) {
+		ntfs_free(run->runs_);
+		run->runs_ =3D NULL;
+		run->allocated =3D 0;
+	}
+}
+
+/*
+ * run_add_entry
+ *
+ * sets location to known state.
+ * run to be added may overlap with existing location.
+ * returns false if of memory
+ */
+bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len)
+{
+	size_t used, index;
+	struct ntfs_run *r;
+	bool inrange;
+	CLST tail_vcn =3D 0, tail_len =3D 0, tail_lcn =3D 0;
+	bool should_add_tail =3D false;
+
+	/*
+	 * Lookup the insertion point.
+	 *
+	 * Execute bsearch for the entry containing
+	 * start position question.
+	 */
+	inrange =3D run_lookup(run, vcn, &index);
+
+	/*
+	 * Shortcut here would be case of
+	 * range not been found but one been added
+	 * continues previous run.
+	 * this case I can directly make use of
+	 * existing range as my start point.
+	 */
+	if (!inrange && index > 0) {
+		struct ntfs_run *t =3D run->runs_ + index - 1;
+
+		if (t->vcn + t->len =3D=3D vcn &&
+		    (t->lcn =3D=3D SPARSE_LCN) =3D=3D (lcn =3D=3D SPARSE_LCN) &&
+		    (lcn =3D=3D SPARSE_LCN || lcn =3D=3D t->lcn + t->len)) {
+			inrange =3D true;
+			index -=3D 1;
+		}
+	}
+
+	/*
+	 * At this point 'index' either points to the range
+	 * containing start position or to the insertion position
+	 * for a new range.
+	 * So first let's check if range I'm probing is here already.
+	 */
+	if (!inrange)
+		goto requires_new_range;
+
+	r =3D run->runs_ + index;
+
+	/*
+	 * If one of ranges was not allocated
+	 * then I have to split location I just matched.
+	 * and insert current one
+	 * a common case this requires tail to be reinserted
+	 * a recursive call.
+	 */
+	if (((lcn =3D=3D SPARSE_LCN) !=3D (r->lcn =3D=3D SPARSE_LCN)) ||
+	    (lcn !=3D SPARSE_LCN && lcn !=3D r->lcn + (vcn - r->vcn))) {
+		CLST to_eat =3D vcn - r->vcn;
+		CLST Tovcn =3D to_eat + len;
+
+		should_add_tail =3D Tovcn < r->len;
+
+		if (should_add_tail) {
+			if (r->lcn =3D=3D SPARSE_LCN)
+				tail_lcn =3D (CLST)SPARSE_LCN;
+			else
+				tail_lcn =3D r->lcn + Tovcn;
+			tail_vcn =3D r->vcn + Tovcn;
+			tail_len =3D r->len - Tovcn;
+		}
+
+		if (to_eat > 0) {
+			r->len =3D to_eat;
+			inrange =3D false;
+			index +=3D 1;
+			goto requires_new_range;
+		}
+
+		/* lcn should match one I'm going to add. */
+		r->lcn =3D lcn;
+	}
+
+	/*
+	 * If existing range fits then I'm done.
+	 * Otherwise extend found one and fall back to range jocode.
+	 */
+	if (r->vcn + r->len < vcn + len)
+		r->len +=3D len - ((r->vcn + r->len) - vcn);
+	goto consolidate;
+
+requires_new_range:
+	/*
+	 * Range was not found.
+	 * Insert at position.
+	 * 'index' points to the insertion point.
+	 * Here is also the place to check
+	 * if allocated size exceeded specified limit.
+	 * If it does, third part of allocation will be thrown away.
+	 */
+	used =3D run->count * sizeof(struct ntfs_run);
+
+	/*
+	 * Check allocated space.
+	 * If one is not enough to get one more entry
+	 * then it will be reallocated
+	 */
+	if (run->allocated < used + sizeof(struct ntfs_run)) {
+		size_t bytes;
+		struct ntfs_run *new_ptr;
+
+		/* Use power of 2 for 'bytes'*/
+		if (!used)
+			bytes =3D 64;
+		else if (used <=3D 16 * PAGE_SIZE) {
+			if (is_power_of2(run->allocated))
+				bytes =3D run->allocated << 1;
+			else
+				bytes =3D (size_t)1 << (2 + blksize_bits(used));
+		} else {
+			bytes =3D run->allocated + (16 * PAGE_SIZE);
+		}
+
+		new_ptr =3D ntfs_alloc(bytes, 0);
+		if (!new_ptr)
+			return false;
+
+		r =3D new_ptr + index;
+		memcpy(new_ptr, run->runs_, index * sizeof(struct ntfs_run));
+		memcpy(r + 1, run->runs_ + index,
+		       sizeof(struct ntfs_run) * (run->count - index));
+
+		ntfs_free(run->runs_);
+		run->runs_ =3D new_ptr;
+		run->allocated =3D bytes;
+
+	} else {
+		size_t i =3D run->count - index;
+
+		r =3D run->runs_ + index;
+
+		/* memmove appears to be a bottle neck here... */
+		if (i > 0)
+			memmove(r + 1, r, sizeof(struct ntfs_run) * i);
+	}
+
+	r->vcn =3D vcn;
+	r->lcn =3D lcn;
+	r->len =3D len;
+	run->count +=3D 1;
+
+consolidate:
+
+	/*
+	 * And normalize it starting from insertion point.
+	 * It's possible that no insertion needed case if
+	 * start point lies withthe range of an entry
+	 * that 'index' points to.
+	 */
+	if (inrange && index > 0)
+		index -=3D 1;
+	run_consolidate(run, index);
+	run_consolidate(run, index + 1);
+
+	/*
+	 * a special case
+	 * I have to add extra range a tail.
+	 */
+	if (should_add_tail &&
+	    !run_add_entry(run, tail_vcn, tail_lcn, tail_len))
+		return false;
+
+	return true;
+}
+
+/*
+ * run_get_entry
+ *
+ * returns index-th mapped region
+ */
+bool run_get_entry(const struct runs_tree *run, size_t index, CLST *vcn,
+		   CLST *lcn, CLST *len)
+{
+	const struct ntfs_run *r;
+
+	if (index >=3D run->count)
+		return false;
+
+	r =3D run->runs_ + index;
+
+	if (!r->len)
+		return false;
+
+	if (vcn)
+		*vcn =3D r->vcn;
+	if (lcn)
+		*lcn =3D r->lcn;
+	if (len)
+		*len =3D r->len;
+	return true;
+}
+
+/*
+ * run_packed_size
+ *
+ * calculates the size of packed int64
+ */
+static inline int run_packed_size(const s64 *n)
+{
+#ifdef __BIG_ENDIAN
+	const u8 *p =3D (const u8 *)n + sizeof(*n) - 1;
+
+	if (*n >=3D 0) {
+		if (p[-7] || p[-6] || p[-5] || p[-4])
+			p -=3D 4;
+		if (p[-3] || p[-2])
+			p -=3D 2;
+		if (p[-1])
+			p -=3D 1;
+		if (p[0] & 0x80)
+			p -=3D 1;
+	} else {
+		if (p[-7] !=3D 0xff || p[-6] !=3D 0xff || p[-5] !=3D 0xff ||
+		    p[-4] !=3D 0xff)
+			p -=3D 4;
+		if (p[-3] !=3D 0xff || p[-2] !=3D 0xff)
+			p -=3D 2;
+		if (p[-1] !=3D 0xff)
+			p -=3D 1;
+		if (!(p[0] & 0x80))
+			p -=3D 1;
+	}
+	return (const u8 *)n + sizeof(*n) - p;
+#else
+	const u8 *p =3D (const u8 *)n;
+
+	if (*n >=3D 0) {
+		if (p[7] || p[6] || p[5] || p[4])
+			p +=3D 4;
+		if (p[3] || p[2])
+			p +=3D 2;
+		if (p[1])
+			p +=3D 1;
+		if (p[0] & 0x80)
+			p +=3D 1;
+	} else {
+		if (p[7] !=3D 0xff || p[6] !=3D 0xff || p[5] !=3D 0xff ||
+		    p[4] !=3D 0xff)
+			p +=3D 4;
+		if (p[3] !=3D 0xff || p[2] !=3D 0xff)
+			p +=3D 2;
+		if (p[1] !=3D 0xff)
+			p +=3D 1;
+		if (!(p[0] & 0x80))
+			p +=3D 1;
+	}
+
+	return 1 + p - (const u8 *)n;
+#endif
+}
+
+/*
+ * run_pack
+ *
+ * packs runs into buffer
+ * packed_vcns - how much runs we have packed
+ * packed_size - how much bytes we have used run_buf
+ */
+int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf=
,
+	     u32 run_buf_size, CLST *packed_vcns)
+{
+	CLST next_vcn, vcn, lcn;
+	CLST prev_lcn =3D 0;
+	CLST evcn1 =3D svcn + len;
+	int packed_size =3D 0;
+	size_t i;
+	bool ok;
+	s64 dlcn, len64;
+	int offset_size, size_size, t;
+	const u8 *p;
+
+	next_vcn =3D vcn =3D svcn;
+
+	*packed_vcns =3D 0;
+
+	if (!len)
+		goto out;
+
+	ok =3D run_lookup_entry(run, vcn, &lcn, &len, &i);
+
+	if (!ok)
+		goto error;
+
+	if (next_vcn !=3D vcn)
+		goto error;
+
+next_entry:
+	/* offset of current fragment relatively to previous fragment */
+	dlcn =3D 0;
+	next_vcn =3D vcn + len;
+
+	if (next_vcn > evcn1)
+		len =3D evcn1 - vcn;
+
+	/*
+	 * mirror of len, but signed, because run_packed_size()
+	 * works with signed int only
+	 */
+	len64 =3D len;
+
+	/* how much bytes is packed len64 */
+	size_size =3D run_packed_size(&len64);
+
+	/* offset_size - how much bytes is packed dlcn */
+	if (lcn =3D=3D SPARSE_LCN)
+		offset_size =3D 0;
+	else {
+		/* NOTE: lcn can be less than prev_lcn! */
+		dlcn =3D (s64)lcn - prev_lcn;
+		offset_size =3D run_packed_size(&dlcn);
+		prev_lcn =3D lcn;
+	}
+
+	t =3D run_buf_size - packed_size - 2 - offset_size;
+	if (t <=3D 0)
+		goto out;
+
+	/* can we store this entire run */
+	if (t < size_size)
+		goto out;
+
+	if (!run_buf)
+		goto skip_pack;
+
+	p =3D (u8 *)&len64;
+
+	/* pack run header */
+	run_buf[0] =3D ((u8)(size_size | (offset_size << 4)));
+	run_buf +=3D 1;
+
+	/* Pack the length of run */
+	switch (size_size) {
+#ifdef __BIG_ENDIAN
+	case 8:
+		run_buf[7] =3D p[0];
+		fallthrough;
+	case 7:
+		run_buf[6] =3D p[1];
+		fallthrough;
+	case 6:
+		run_buf[5] =3D p[2];
+		fallthrough;
+	case 5:
+		run_buf[4] =3D p[3];
+		fallthrough;
+	case 4:
+		run_buf[3] =3D p[4];
+		fallthrough;
+	case 3:
+		run_buf[2] =3D p[5];
+		fallthrough;
+	case 2:
+		run_buf[1] =3D p[6];
+		fallthrough;
+	case 1:
+		run_buf[0] =3D p[7];
+#else
+	case 8:
+		run_buf[7] =3D p[7];
+		fallthrough;
+	case 7:
+		run_buf[6] =3D p[6];
+		fallthrough;
+	case 6:
+		run_buf[5] =3D p[5];
+		fallthrough;
+	case 5:
+		run_buf[4] =3D p[4];
+		fallthrough;
+	case 4:
+		run_buf[3] =3D p[3];
+		fallthrough;
+	case 3:
+		run_buf[2] =3D p[2];
+		fallthrough;
+	case 2:
+		run_buf[1] =3D p[1];
+		fallthrough;
+	case 1:
+		run_buf[0] =3D p[0];
+#endif
+	}
+
+	run_buf +=3D size_size;
+	p =3D (u8 *)&dlcn;
+
+	/* Pack the offset from previous lcn */
+	switch (offset_size) {
+#ifdef __BIG_ENDIAN
+	case 8:
+		run_buf[7] =3D p[0];
+		fallthrough;
+	case 7:
+		run_buf[6] =3D p[1];
+		fallthrough;
+	case 6:
+		run_buf[5] =3D p[2];
+		fallthrough;
+	case 5:
+		run_buf[4] =3D p[3];
+		fallthrough;
+	case 4:
+		run_buf[3] =3D p[4];
+		fallthrough;
+	case 3:
+		run_buf[2] =3D p[5];
+		fallthrough;
+	case 2:
+		run_buf[1] =3D p[6];
+		fallthrough;
+	case 1:
+		run_buf[0] =3D p[7];
+#else
+	case 8:
+		run_buf[7] =3D p[7];
+		fallthrough;
+	case 7:
+		run_buf[6] =3D p[6];
+		fallthrough;
+	case 6:
+		run_buf[5] =3D p[5];
+		fallthrough;
+	case 5:
+		run_buf[4] =3D p[4];
+		fallthrough;
+	case 4:
+		run_buf[3] =3D p[3];
+		fallthrough;
+	case 3:
+		run_buf[2] =3D p[2];
+		fallthrough;
+	case 2:
+		run_buf[1] =3D p[1];
+		fallthrough;
+	case 1:
+		run_buf[0] =3D p[0];
+#endif
+	}
+
+	run_buf +=3D offset_size;
+
+skip_pack:
+
+	packed_size +=3D 1 + offset_size + size_size;
+	*packed_vcns +=3D len;
+
+	if (packed_size + 1 >=3D run_buf_size || next_vcn >=3D evcn1)
+		goto out;
+
+	ok =3D run_get_entry(run, ++i, &vcn, &lcn, &len);
+	if (!ok)
+		goto error;
+
+	if (next_vcn !=3D vcn)
+		goto error;
+
+	goto next_entry;
+
+out:
+	/* Store last zero */
+	if (run_buf)
+		run_buf[0] =3D 0;
+
+	return packed_size + 1;
+
+error:
+	return -EOPNOTSUPP;
+}
+
+/*
+ * run_unpack
+ *
+ * unpacks packed runs from "run_buf"
+ * returns error, if negative, or real used bytes
+ */
+int run_unpack(struct runs_tree *run, ntfs_sb_info *sbi, CLST ino, CLST sv=
cn,
+	       CLST evcn, const u8 *run_buf, u32 run_buf_size)
+{
+	u64 prev_lcn, vcn;
+	const u8 *run_last, *run_0;
+	u64 lcn, len;
+	/* size_size - how much bytes is packed len */
+	u8 size_size;
+	/* offset_size - how much bytes is packed dlcn */
+	u8 offset_size;
+	u8 *p;
+	u64 next_vcn;
+	s64 dlcn;
+
+	/* Check for empty */
+	if (evcn + 1 =3D=3D svcn)
+		return 0;
+
+	if (evcn < svcn)
+		return -EINVAL;
+
+	run_0 =3D run_buf;
+	run_last =3D run_buf + run_buf_size;
+	prev_lcn =3D 0;
+	vcn =3D svcn;
+
+	/* Read all runs the chain */
+next_run:
+	/* size_size - how much bytes is packed len */
+	size_size =3D *run_buf & 0xF;
+	/* offset_size - how much bytes is packed dlcn */
+	offset_size =3D *run_buf++ >> 4;
+
+	/*
+	 * Unpack runs.
+	 * NOTE: runs are stored little endian order
+	 * "len" is unsigned value, "dlcn" is signed
+	 */
+	if (!size_size)
+		goto out;
+
+	/*
+	 * Large positive number requires to store 5 bytes
+	 * e.g.: 05 FF 7E FF FF 00 00 00
+	 */
+	len =3D 0;
+	p =3D (u8 *)&len;
+
+	switch (size_size) {
+	default:
+error:
+		return -EINVAL;
+
+#ifdef __BIG_ENDIAN
+	case 8:
+		p[0] =3D run_buf[7];
+		fallthrough;
+	case 7:
+		p[1] =3D run_buf[6];
+		fallthrough;
+	case 6:
+		p[2] =3D run_buf[5];
+		fallthrough;
+	case 5:
+		p[3] =3D run_buf[4];
+		fallthrough;
+	case 4:
+		p[4] =3D run_buf[3];
+		fallthrough;
+	case 3:
+		p[5] =3D run_buf[2];
+		fallthrough;
+	case 2:
+		p[6] =3D run_buf[1];
+		fallthrough;
+	case 1:
+		p[7] =3D run_buf[0];
+#else
+	case 8:
+		p[7] =3D run_buf[7];
+		fallthrough;
+	case 7:
+		p[6] =3D run_buf[6];
+		fallthrough;
+	case 6:
+		p[5] =3D run_buf[5];
+		fallthrough;
+	case 5:
+		p[4] =3D run_buf[4];
+		fallthrough;
+	case 4:
+		p[3] =3D run_buf[3];
+		fallthrough;
+	case 3:
+		p[2] =3D run_buf[2];
+		fallthrough;
+	case 2:
+		p[1] =3D run_buf[1];
+		fallthrough;
+	case 1:
+		p[0] =3D run_buf[0];
+#endif
+	}
+
+	/* skip size_size */
+	run_buf +=3D size_size;
+
+	if (!len)
+		goto error;
+
+	if (!offset_size) {
+		lcn =3D SPARSE_LCN;
+		goto next_vcn;
+	}
+	/* Check sign */
+	dlcn =3D (run_buf[offset_size - 1] & 0x80) ? (s64)-1 : 0;
+	p =3D (u8 *)&dlcn;
+
+	switch (offset_size) {
+	default:
+		goto error;
+
+#ifdef __BIG_ENDIAN
+	case 8:
+		p[0] =3D run_buf[7];
+		fallthrough;
+	case 7:
+		p[1] =3D run_buf[6];
+		fallthrough;
+	case 6:
+		p[2] =3D run_buf[5];
+		fallthrough;
+	case 5:
+		p[3] =3D run_buf[4];
+		fallthrough;
+	case 4:
+		p[4] =3D run_buf[3];
+		fallthrough;
+	case 3:
+		p[5] =3D run_buf[2];
+		fallthrough;
+	case 2:
+		p[6] =3D run_buf[1];
+		fallthrough;
+	case 1:
+		p[7] =3D run_buf[0];
+#else
+	case 8:
+		p[7] =3D run_buf[7];
+		fallthrough;
+	case 7:
+		p[6] =3D run_buf[6];
+		fallthrough;
+	case 6:
+		p[5] =3D run_buf[5];
+		fallthrough;
+	case 5:
+		p[4] =3D run_buf[4];
+		fallthrough;
+	case 4:
+		p[3] =3D run_buf[3];
+		fallthrough;
+	case 3:
+		p[2] =3D run_buf[2];
+		fallthrough;
+	case 2:
+		p[1] =3D run_buf[1];
+		fallthrough;
+	case 1:
+		p[0] =3D run_buf[0];
+#endif
+	}
+
+	/* skip offset_size */
+	run_buf +=3D offset_size;
+	lcn =3D prev_lcn + dlcn;
+	prev_lcn =3D lcn;
+
+next_vcn:
+	next_vcn =3D vcn + len;
+	/* check boundary */
+	if (next_vcn > evcn + 1)
+		goto error;
+
+#ifndef NTFS3_64BIT_CLUSTER
+	if ((vcn >> 32)
+	    /* 0xffffffffffffffff is a valid 'lcn' */
+	    || (lcn + 1) > 0x100000000ull || (len >> 32)) {
+		goto error;
+	}
+#endif
+
+	if (!run)
+		; /* called from check_attr(fslog.c) to check run */
+	else if ((size_t)run =3D=3D 1) {
+		/* called from ni_delete_all to free clusters without storing in run */
+		if (lcn !=3D SPARSE_LCN)
+			mark_as_free_ex(sbi, lcn, len, true);
+	} else if (!run_add_entry(run, vcn, lcn, len))
+		return -ENOMEM;
+
+	if (lcn !=3D SPARSE_LCN && lcn + len > sbi->used.bitmap.nbits)
+		return -EINVAL;
+
+	vcn =3D next_vcn;
+
+	if (run_buf < run_last)
+		goto next_run;
+
+out:
+	/* Check vcn consistency */
+	if (vcn =3D=3D evcn + 1)
+		return run_buf - run_0;
+
+	return -EINVAL;
+}
+
+#ifdef NTFS3_CHECK_FREE_CLST
+/*
+ * run_unpack_ex
+ *
+ * unpacks packed runs from "run_buf"
+ * checks unpacked runs to be used in bitmap
+ * returns error, if negative, or real used bytes
+ */
+int run_unpack_ex(struct runs_tree *run, ntfs_sb_info *sbi, CLST ino, CLST=
 svcn,
+		  CLST evcn, const u8 *run_buf, u32 run_buf_size)
+{
+	int ret, err;
+	CLST next_vcn, vcn, lcn, len;
+	size_t index;
+	bool ok;
+	wnd_bitmap *wnd;
+
+	ret =3D run_unpack(run, sbi, ino, svcn, evcn, run_buf, run_buf_size);
+	if (ret < 0)
+		return ret;
+
+	if (!sbi->used.bitmap.sb || !run || (size_t)run =3D=3D 1)
+		return ret;
+
+	if (ino =3D=3D MFT_REC_BADCLUST)
+		return ret;
+
+	next_vcn =3D vcn =3D svcn;
+	wnd =3D &sbi->used.bitmap;
+
+	for (ok =3D run_lookup_entry(run, vcn, &lcn, &len, &index);
+	     next_vcn <=3D evcn;
+	     ok =3D run_get_entry(run, ++index, &vcn, &lcn, &len)) {
+		CLST real_free, i;
+
+		if (!ok || next_vcn !=3D vcn)
+			return -EINVAL;
+
+		next_vcn =3D vcn + len;
+
+		if (lcn =3D=3D SPARSE_LCN)
+			continue;
+
+		if (sbi->flags & NTFS_FLAGS_NEED_REPLAY)
+			continue;
+
+next:
+		down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
+		/* Check for free blocks */
+		ok =3D wnd_is_used(wnd, lcn, len);
+		up_read(&wnd->rw_lock);
+		if (ok)
+			continue;
+
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+
+		if (!down_write_trylock(&wnd->rw_lock))
+			continue;
+
+		/* Find first free */
+		real_free =3D len;
+		while (real_free && !wnd_is_free(wnd, lcn, 1)) {
+			lcn +=3D 1;
+			real_free -=3D 1;
+		}
+
+		if (!real_free) {
+			up_write(&wnd->rw_lock);
+			continue;
+		}
+
+		/* Find total free */
+		i =3D 1;
+		while (i < real_free && wnd_is_free(wnd, lcn + i, 1))
+			i +=3D 1;
+
+		real_free =3D i;
+
+		err =3D wnd_set_used(wnd, lcn, real_free);
+		up_write(&wnd->rw_lock);
+
+		if (err)
+			return err;
+
+		if (len !=3D real_free) {
+			len -=3D real_free + 1;
+			lcn +=3D real_free + 1;
+			goto next;
+		}
+	}
+
+	return ret;
+}
+#endif
+
+/*
+ * run_get_highest_vcn
+ *
+ * returns the highest vcn from a mapping pairs array
+ * it used while replaying log file
+ */
+int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
+{
+	const u8 *run =3D run_buf;
+	u64 vcn64 =3D vcn;
+	u8 size_size;
+	u8 offset_size;
+	u64 len;
+	u8 *p;
+
+next_run:
+	size_size =3D *run & 0xF;
+	if (!size_size)
+		goto out;
+
+	offset_size =3D *run++ >> 4;
+
+	len =3D 0;
+	p =3D (u8 *)&len;
+
+	switch (size_size) {
+	default:
+error:
+		return -EINVAL;
+
+#ifdef __BIG_ENDIAN
+	case 8:
+		p[0] =3D run[7];
+		fallthrough;
+	case 7:
+		p[1] =3D run[6];
+		fallthrough;
+	case 6:
+		p[2] =3D run[5];
+		fallthrough;
+	case 5:
+		p[3] =3D run[4];
+		fallthrough;
+	case 4:
+		p[4] =3D run[3];
+		fallthrough;
+	case 3:
+		p[5] =3D run[2];
+		fallthrough;
+	case 2:
+		p[6] =3D run[1];
+		fallthrough;
+	case 1:
+		p[7] =3D run[0];
+#else
+	case 8:
+		p[7] =3D run[7];
+		fallthrough;
+	case 7:
+		p[6] =3D run[6];
+		fallthrough;
+	case 6:
+		p[5] =3D run[5];
+		fallthrough;
+	case 5:
+		p[4] =3D run[4];
+		fallthrough;
+	case 4:
+		p[3] =3D run[3];
+		fallthrough;
+	case 3:
+		p[2] =3D run[2];
+		fallthrough;
+	case 2:
+		p[1] =3D run[1];
+		fallthrough;
+	case 1:
+		p[0] =3D run[0];
+#endif
+	}
+
+	/* skip size_size */
+	run +=3D size_size;
+
+	if (!len)
+		goto error;
+
+	run +=3D offset_size;
+
+#ifdef NTFS3_64BIT_CLUSTER
+	if ((vcn >> 32) || (len >> 32))
+		goto error;
+#endif
+	vcn64 +=3D len;
+	goto next_run;
+
+out:
+	*highest_vcn =3D vcn64 - 1;
+	return 0;
+}
--=20
2.25.2

