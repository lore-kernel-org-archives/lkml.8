Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4991EC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C9024959
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339726;
	bh=O7IiGYCyA78pu2aucLrcQB8qvkxN+WNISdcEwwWrdf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SmMrfYV/xA/Zsncj3A1eg1ZayBzbLt+mBsE3nY0G9feiMf5YFnJ1Cs2Wdx+OZn9z2
	 v7iYKVL5CaLOThZuZdLQCUVE46/F4jch0A5x1yEpVHeUYw1vkzwH+sPVKxqQzDvm4t
	 yGv5K3MTJXRgB3KKfs4usgcEdUGAiG81QSQ2Wf34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgEAN2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729643AbgEAN2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:28:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02DA22166E;
        Fri,  1 May 2020 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339721;
        bh=O7IiGYCyA78pu2aucLrcQB8qvkxN+WNISdcEwwWrdf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIHbxeTqFx5KKl1T0rrKFQqn+J8mmiHboOhDB3Im5cR85j99nIxeSUj5pb0vfmb65
         RgF7zxjhsEFYbT984SoVQ5GqOxCFKvA1Yun29ly8QBfQZo/lfp4vRK83V+VLWBUuDD
         raMrfRbjWWX3caiouG57Aynh04S1sdQ9zF/PAy8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Piotr Krysiuk <piotras@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 33/80] fs/namespace.c: fix mountpoint reference counter race
Date:   Fri,  1 May 2020 15:21:27 +0200
Message-Id: <20200501131524.742617650@linuxfoundation.org>
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


From: Piotr Krysiuk <piotras@gmail.com>

A race condition between threads updating mountpoint reference counter
affects longterm releases 4.4.220, 4.9.220, 4.14.177 and 4.19.118.

The mountpoint reference counter corruption may occur when:
* one thread increments m_count member of struct mountpoint
  [under namespace_sem, but not holding mount_lock]
    pivot_root()
* another thread simultaneously decrements the same m_count
  [under mount_lock, but not holding namespace_sem]
    put_mountpoint()
      unhash_mnt()
        umount_mnt()
          mntput_no_expire()

To fix this race condition, grab mount_lock before updating m_count in
pivot_root().

Reference: CVE-2020-12114
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Piotr Krysiuk <piotras@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namespace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3184,8 +3184,8 @@ SYSCALL_DEFINE2(pivot_root, const char _
 	/* make certain new is below the root */
 	if (!is_path_reachable(new_mnt, new.dentry, &root))
 		goto out4;
-	root_mp->m_count++; /* pin it so it won't go away */
 	lock_mount_hash();
+	root_mp->m_count++; /* pin it so it won't go away */
 	detach_mnt(new_mnt, &parent_path);
 	detach_mnt(root_mnt, &root_parent);
 	if (root_mnt->mnt.mnt_flags & MNT_LOCKED) {


