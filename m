Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276CCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F1420639
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919817;
	bh=yagczh+iHj1VfsCNXZk3FCq2susSWJzKubnXov3ZVQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DaQkDGf5oxApfl5vmxk2QAhLodZOE9B33dNFkaipoXHwD/U9tqUGTunBvUeDsElnj
	 D5H7NeYJVj8GIa99l6q3K7fckfFVCJ1rnBb3qEw68ra4JJjOYAjZhO86Ypma5pn1F1
	 LaDK1QuhIgzJYqfKz6zV6Kskh5+dsf7jKSotuO3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHTKgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731386AbgHTKSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:18:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFC842067C;
        Thu, 20 Aug 2020 10:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918714;
        bh=yagczh+iHj1VfsCNXZk3FCq2susSWJzKubnXov3ZVQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slubSfLaUdS+IzwDA09iBQbBPk4nxkKojr2FCBQ7HpUu6xoMAEmxe6u7EAnQ9xyut
         z0YplaiggEfnzVbUvjNk1CHXetkxtzclvhRn3HxCTDRiXRzfoK7vpM+9PSuHSDUac8
         qIyBAti4PXdy5NkV9EB7polOiwdT2Q71FpWnLr5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 010/149] f2fs: check memory boundary by insane namelen
Date:   Thu, 20 Aug 2020 11:21:27 +0200
Message-Id: <20200820092126.196020416@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 4e240d1bab1ead280ddf5eb05058dba6bbd57d10 ]

If namelen is corrupted to have very long value, fill_dentries can copy
wrong memory area.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 92a240616f520..5411d6667781f 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -805,6 +805,16 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 		de_name.name = d->filename[bit_pos];
 		de_name.len = le16_to_cpu(de->name_len);
 
+		/* check memory boundary before moving forward */
+		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
+		if (unlikely(bit_pos > d->max)) {
+			f2fs_msg(F2FS_I_SB(d->inode)->sb, KERN_WARNING,
+				"%s: corrupted namelen=%d, run fsck to fix.",
+				__func__, le16_to_cpu(de->name_len));
+			set_sbi_flag(F2FS_I_SB(d->inode)->sb->s_fs_info, SBI_NEED_FSCK);
+			return -EINVAL;
+		}
+
 		if (f2fs_encrypted_inode(d->inode)) {
 			int save_len = fstr->len;
 			int ret;
@@ -829,7 +839,6 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 					le32_to_cpu(de->ino), d_type))
 			return true;
 
-		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 		ctx->pos = start_pos + bit_pos;
 	}
 	return false;
-- 
2.25.1



