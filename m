Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B50C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 04:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B386207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 04:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl3q2kBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgFEE1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 00:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEE1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 00:27:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CFFC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 21:27:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so4307389pfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 21:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4gO2P4HM+S0K7NAiU9zSajGl6Mf1LW7417QDCiFsO0=;
        b=Cl3q2kBpre6ES1SBH7Q+x/Xxlz3bZfK3zZhzj5CyngUuu1ApZBHoYZc0QO4aFiM4YG
         j1uVW45ecr5nC+R5VHk3dCTdBvtyNyQwCam1yrWd9h846dVcgFoC5cIPx+pekhxchmwe
         tnCQd4Rp8aTtwSEZevwyD77oTMVtReG8Z/gr8Y5gGTCKVoKT4Xjd1I5D5Jrp1XGG18Zl
         OJO6hXIYhYERBW4uj7y3yF7xalnLsCujMQw+3EwWwkfzq4ji5OglQbI8XXeIarRD/buF
         NRdZw240GK8crOYxZ2Rb8NA2+d9SLIrXriuEn7E1hO9VkZ+W9jg3Z+Tjhod+rtc4Zftd
         El+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4gO2P4HM+S0K7NAiU9zSajGl6Mf1LW7417QDCiFsO0=;
        b=QluSefDDEsvzUqoLrCvmgd7tHby8F9rQ8i+0lKxon9+Rp5JhLJPH6MvkABkezj6gJd
         cUA+DvDAQzkb9AbIoRL1cxSbxGSMZu1ihh95b78b3BzH+Hl45GS3z0LQ6TxTkF6BlUNR
         zlcli4jAUx77SevuNh9wwirQB3EMr7lo4gKD8hFpVtHgQIlkQU9CucEWOgg2kX7dPCsO
         g5I57wwBWI+/gcccD9f2R5VqjuoUww4K9Be7S3zNc6S3JQg61Qy0iwGUHibmhpktX8K0
         skQa44lvtz2iNjinW5BYJekYxLf6OV2G0P4zZQx6SQIdclJXeDg0DfKn+eBZHskKq696
         fEtg==
X-Gm-Message-State: AOAM533bv+BBcs3GgXfS0iMAlnjAsm/oz47h9nTcB+s2f6muOqA22vpF
        S4fn4b59HiWM72yyZDi+wQ1rEWAvlf/Fww==
X-Google-Smtp-Source: ABdhPJx+R+ErD2StoSMjRqvvvAhK6Sqh0XxoMWkhmdbu0Gnfu/0ZHEjnOj0wXOQ1afowPYxQcNQFcQ==
X-Received: by 2002:a62:4e8a:: with SMTP id c132mr7253898pfb.22.1591331273119;
        Thu, 04 Jun 2020 21:27:53 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:b8f4:bbde:37ba:20bd])
        by smtp.gmail.com with ESMTPSA id x19sm5863627pfo.96.2020.06.04.21.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 21:27:52 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: add F2FS_IOC_TRIM_FILE ioctl
Date:   Fri,  5 Jun 2020 13:27:46 +0900
Message-Id: <20200605042746.201180-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added a new ioctl to send discard commands to whole data area of
a regular file for security reason.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h |   1 +
 fs/f2fs/file.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c812fb8e2d9c..9ae81d0fefa0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -434,6 +434,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
 #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
 					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
+#define F2FS_IOC_TRIM_FILE		_IO(F2FS_IOCTL_MAGIC, 20)
 
 #define F2FS_IOC_GET_VOLUME_NAME	FS_IOC_GETFSLABEL
 #define F2FS_IOC_SET_VOLUME_NAME	FS_IOC_SETFSLABEL
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index dfa1ac2d751a..58507bb5649c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3749,6 +3749,132 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int f2fs_trim_file(struct file *filp)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct address_space *mapping = inode->i_mapping;
+	struct bio *bio = NULL;
+	struct block_device *prev_bdev = NULL;
+	loff_t file_size;
+	pgoff_t index, pg_start = 0, pg_end;
+	block_t prev_block = 0, len = 0;
+	int ret = 0;
+
+	if (!f2fs_hw_support_discard(sbi))
+		return -EOPNOTSUPP;
+
+	if (!S_ISREG(inode->i_mode) || f2fs_is_atomic_file(inode) ||
+			f2fs_compressed_file(inode))
+		return -EINVAL;
+
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	inode_lock(inode);
+
+	file_size = i_size_read(inode);
+	if (!file_size)
+		goto err;
+	pg_end = (pgoff_t)round_up(file_size, PAGE_SIZE) >> PAGE_SHIFT;
+
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		goto err;
+
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
+
+	ret = filemap_write_and_wait(mapping);
+	if (ret)
+		goto out;
+
+	truncate_inode_pages(mapping, 0);
+
+	for (index = pg_start; index < pg_end;) {
+		struct dnode_of_data dn;
+		unsigned int end_offset;
+
+		set_new_dnode(&dn, inode, NULL, NULL, 0);
+		ret = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
+		if (ret)
+			goto out;
+
+		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
+		if (pg_end < end_offset + index)
+			end_offset = pg_end - index;
+
+		for (; dn.ofs_in_node < end_offset;
+				dn.ofs_in_node++, index++) {
+			struct block_device *cur_bdev;
+			block_t blkaddr = f2fs_data_blkaddr(&dn);
+
+			if (__is_valid_data_blkaddr(blkaddr)) {
+				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
+					blkaddr, DATA_GENERIC_ENHANCE)) {
+					ret = -EFSCORRUPTED;
+					goto out;
+				}
+			} else
+				continue;
+
+			cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
+			if (f2fs_is_multi_device(sbi)) {
+				int i = f2fs_target_device_index(sbi, blkaddr);
+
+				blkaddr -= FDEV(i).start_blk;
+			}
+
+			if (len) {
+				if (prev_bdev == cur_bdev &&
+					blkaddr == prev_block + len) {
+					len++;
+				} else {
+					ret = __blkdev_issue_discard(prev_bdev,
+						SECTOR_FROM_BLOCK(prev_block),
+						SECTOR_FROM_BLOCK(len),
+						GFP_NOFS, 0, &bio);
+					if (ret)
+						goto out;
+
+					len = 0;
+				}
+			}
+
+			if (!len) {
+				prev_bdev = cur_bdev;
+				prev_block = blkaddr;
+				len = 1;
+			}
+		}
+
+		f2fs_put_dnode(&dn);
+	}
+
+	if (len)
+		ret = __blkdev_issue_discard(prev_bdev,
+					SECTOR_FROM_BLOCK(prev_block),
+					SECTOR_FROM_BLOCK(len),
+					GFP_NOFS, 0, &bio);
+out:
+	if (bio) {
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+
+	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+err:
+	inode_unlock(inode);
+	mnt_drop_write_file(filp);
+
+	return ret;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -3835,6 +3961,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_release_compress_blocks(filp, arg);
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
 		return f2fs_reserve_compress_blocks(filp, arg);
+	case F2FS_IOC_TRIM_FILE:
+		return f2fs_trim_file(filp);
 	default:
 		return -ENOTTY;
 	}
@@ -4004,6 +4132,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_COMPRESS_BLOCKS:
 	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
+	case F2FS_IOC_TRIM_FILE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.27.0.278.ge193c7cf3a9-goog

