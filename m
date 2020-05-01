Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E725EC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9118208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339837;
	bh=pK8rpwRXJJ+r3FLwYrNmNp9fLSHFTOSSEl7EYItdVMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YMX7qa+hBz1vJZQWNSSLJi9phJANtJDj0ur+URScY+y555tMtSKgWdWM3eZ3g2Pcl
	 fWqKLD19fB02n6Yr0U8S9lcbvNYb8EACTIz9l5Qar/GIWtQFJCqMKv9zmYYd/0AMhF
	 yt4e3D3AnvDGLHHXU7GP6lnpfIGy2KoI4vj692x0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgEANag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729949AbgEANa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:30:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D64A20757;
        Fri,  1 May 2020 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339827;
        bh=pK8rpwRXJJ+r3FLwYrNmNp9fLSHFTOSSEl7EYItdVMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2QakmI75nFnbQmVo/GsqckQAWnTwS5kwGR+0JGxbCFNQfTZQznxEzO6uuF3jMcnvc
         1MHBePgkYPl6BuWS7xhSEhndBfDcag5dcnmcMa5uwtj+U1NqWpJdvzjwk8mJagaY60
         ZNjOePt8sGdL48PsUu/fKWzapluQf0GN20+r8a2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org, Ashwin H <ashwinh@vmware.com>
Subject: [PATCH 4.9 76/80] ext4: protect journal inodes blocks using block_validity
Date:   Fri,  1 May 2020 15:22:10 +0200
Message-Id: <20200501131536.921913235@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.810761598@linuxfoundation.org>
References: <20200501131513.810761598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit 345c0dbf3a30872d9b204db96b5857cd00808cae upstream.

Add the blocks which belong to the journal inode to block_validity's
system zone so attempts to deallocate or overwrite the journal due a
corrupted file system where the journal blocks are also claimed by
another inode.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202879
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Ashwin H <ashwinh@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/block_validity.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/inode.c          |    4 +++
 2 files changed, 52 insertions(+)

--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -136,6 +136,48 @@ static void debug_print_tree(struct ext4
 	printk(KERN_CONT "\n");
 }
 
+static int ext4_protect_reserved_inode(struct super_block *sb, u32 ino)
+{
+	struct inode *inode;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_map_blocks map;
+	u32 i = 0, err = 0, num, n;
+
+	if ((ino < EXT4_ROOT_INO) ||
+	    (ino > le32_to_cpu(sbi->s_es->s_inodes_count)))
+		return -EINVAL;
+	inode = ext4_iget(sb, ino, EXT4_IGET_SPECIAL);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+	num = (inode->i_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
+	while (i < num) {
+		map.m_lblk = i;
+		map.m_len = num - i;
+		n = ext4_map_blocks(NULL, inode, &map, 0);
+		if (n < 0) {
+			err = n;
+			break;
+		}
+		if (n == 0) {
+			i++;
+		} else {
+			if (!ext4_data_block_valid(sbi, map.m_pblk, n)) {
+				ext4_error(sb, "blocks %llu-%llu from inode %u "
+					   "overlap system zone", map.m_pblk,
+					   map.m_pblk + map.m_len - 1, ino);
+				err = -EFSCORRUPTED;
+				break;
+			}
+			err = add_system_zone(sbi, map.m_pblk, n);
+			if (err < 0)
+				break;
+			i += n;
+		}
+	}
+	iput(inode);
+	return err;
+}
+
 int ext4_setup_system_zone(struct super_block *sb)
 {
 	ext4_group_t ngroups = ext4_get_groups_count(sb);
@@ -170,6 +212,12 @@ int ext4_setup_system_zone(struct super_
 		if (ret)
 			return ret;
 	}
+	if (ext4_has_feature_journal(sb) && sbi->s_es->s_journal_inum) {
+		ret = ext4_protect_reserved_inode(sb,
+				le32_to_cpu(sbi->s_es->s_journal_inum));
+		if (ret)
+			return ret;
+	}
 
 	if (test_opt(sb, DEBUG))
 		debug_print_tree(EXT4_SB(sb));
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -374,6 +374,10 @@ static int __check_block_validity(struct
 				unsigned int line,
 				struct ext4_map_blocks *map)
 {
+	if (ext4_has_feature_journal(inode->i_sb) &&
+	    (inode->i_ino ==
+	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+		return 0;
 	if (!ext4_data_block_valid(EXT4_SB(inode->i_sb), map->m_pblk,
 				   map->m_len)) {
 		ext4_error_inode(inode, func, line, map->m_pblk,


