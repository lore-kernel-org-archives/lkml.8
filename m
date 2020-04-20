Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F32EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4745206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387054;
	bh=8WPosGjN0jxtOq3cCBjVoeG6FQNU+YhySU9UeScm48Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OQb5HGN630yExKbHJTDhulrO52t9YEP+E6BTc8OIZumWWAuJFas49R7DYTiZmtjoP
	 PWcT34lrofs6kXXt+0GSdOTPkSMy8OKanySd+zUKOrD3DvBYzXGnWmTXndlCRgwwk2
	 VAuLh+vlNom/ZQ4VVYX3/lB/Q4Z/E2tUk8iLehEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgDTMux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbgDTMs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:48:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8CD020747;
        Mon, 20 Apr 2020 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386938;
        bh=8WPosGjN0jxtOq3cCBjVoeG6FQNU+YhySU9UeScm48Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yi9wSPRQqX18PCYpLrBwp4LxutrxTBRazaeFJhff+ye0wYcixlWnN752UsmPoWL6o
         PwI1Vr6aIMf1Pj7UdkOL4AhuriqaB/bvRYRBg/74DhHLow7pMnftwDN0MbPbvLOw0R
         uOaBoGa+zdAG7trs5zNc+mZrMkrz3gr1Yx25CaiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.19 28/40] ext4: do not zeroout extents beyond i_disksize
Date:   Mon, 20 Apr 2020 14:39:38 +0200
Message-Id: <20200420121503.040390506@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121444.178150063@linuxfoundation.org>
References: <20200420121444.178150063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 801674f34ecfed033b062a0f217506b93c8d5e8a upstream.

We do not want to create initialized extents beyond end of file because
for e2fsck it is impossible to distinguish them from a case of corrupted
file size / extent tree and so it complains like:

Inode 12, i_size is 147456, should be 163840.  Fix? no

Code in ext4_ext_convert_to_initialized() and
ext4_split_convert_extents() try to make sure it does not create
initialized extents beyond inode size however they check against
inode->i_size which is wrong. They should instead check against
EXT4_I(inode)->i_disksize which is the current inode size on disk.
That's what e2fsck is going to see in case of crash before all dirty
data is written. This bug manifests as generic/456 test failure (with
recent enough fstests where fsx got fixed to properly pass
FALLOC_KEEP_SIZE_FL flags to the kernel) when run with dioread_lock
mount option.

CC: stable@vger.kernel.org
Fixes: 21ca087a3891 ("ext4: Do not zero out uninitialized extents beyond i_size")
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20200331105016.8674-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/extents.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3438,8 +3438,8 @@ static int ext4_ext_convert_to_initializ
 		(unsigned long long)map->m_lblk, map_len);
 
 	sbi = EXT4_SB(inode->i_sb);
-	eof_block = (inode->i_size + inode->i_sb->s_blocksize - 1) >>
-		inode->i_sb->s_blocksize_bits;
+	eof_block = (EXT4_I(inode)->i_disksize + inode->i_sb->s_blocksize - 1)
+			>> inode->i_sb->s_blocksize_bits;
 	if (eof_block < map->m_lblk + map_len)
 		eof_block = map->m_lblk + map_len;
 
@@ -3694,8 +3694,8 @@ static int ext4_split_convert_extents(ha
 		  __func__, inode->i_ino,
 		  (unsigned long long)map->m_lblk, map->m_len);
 
-	eof_block = (inode->i_size + inode->i_sb->s_blocksize - 1) >>
-		inode->i_sb->s_blocksize_bits;
+	eof_block = (EXT4_I(inode)->i_disksize + inode->i_sb->s_blocksize - 1)
+			>> inode->i_sb->s_blocksize_bits;
 	if (eof_block < map->m_lblk + map->m_len)
 		eof_block = map->m_lblk + map->m_len;
 	/*


