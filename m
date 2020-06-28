Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ACFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BCC820702
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593327691;
	bh=LYiWGqhuibBKH+a+dZQwq8XA2JNHsSqHlHrxb93HHY4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=w8jO8mlErqEyZL8O4blYN9fzjwsuK4M+QPRj8N9PJZ1M+VXyAt2kJ0nxYRcDB9e6W
	 KGbn1gCf2Mnyt7W9Aj/UWU0hVk5+JQ6EfsFO9kygukJqHA2QtyFukjn27S/LG45ylE
	 kIWHKP0svbmACK+51+IdQKP8YeaKygbAXHcrxCsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgF1HBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgF1HB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:01:29 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F9F20702;
        Sun, 28 Jun 2020 07:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593327689;
        bh=LYiWGqhuibBKH+a+dZQwq8XA2JNHsSqHlHrxb93HHY4=;
        h=From:To:Cc:Subject:Date:From;
        b=fvwVcGIpBm5O34hr2mOI48xAS5F6/Szmr5TmIqrbtgZbos1qjw+aGdKhDX4uvphjB
         4lkcyNX4TPYDR4pa5hxYSdUfWMuWgGK13HPKF+1M4iNWK6OYmqfyKX5+a1wSDWpkAg
         2OqIdHy1Pj2+pfWwY5GsqZy7VDCrC2FsyR5FVM+M=
From:   Eric Biggers <ebiggers@kernel.org>
To:     reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        syzbot+187510916eb6a14598f7@syzkaller.appspotmail.com
Subject: [PATCH] reiserfs: only call unlock_new_inode() if I_NEW
Date:   Sun, 28 Jun 2020 00:00:57 -0700
Message-Id: <20200628070057.820213-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

unlock_new_inode() is only meant to be called after a new inode has
already been inserted into the hash table.  But reiserfs_new_inode() can
call it even before it has inserted the inode, triggering the WARNING in
unlock_new_inode().  Fix this by only calling unlock_new_inode() if the
inode has the I_NEW flag set, indicating that it's in the table.

This addresses the syzbot report "WARNING in unlock_new_inode"
(https://syzkaller.appspot.com/bug?extid=187510916eb6a14598f7).

Reported-by: syzbot+187510916eb6a14598f7@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/reiserfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 1509775da040..e3af44c61524 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2163,7 +2163,8 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 out_inserted_sd:
 	clear_nlink(inode);
 	th->t_trans_id = 0;	/* so the caller can't use this handle later */
-	unlock_new_inode(inode); /* OK to do even if we hadn't locked it */
+	if (inode->i_state & I_NEW)
+		unlock_new_inode(inode);
 	iput(inode);
 	return err;
 }
-- 
2.27.0

