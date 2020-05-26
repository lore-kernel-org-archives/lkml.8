Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133B2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50A1208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520028;
	bh=4VPdxXWjr16mx7dly3zIokwM4xa2s8mgnV64LSzfatA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sfbXuk16A5ROJK6889t0Ze1bMoVAUg8tdZ53qDKvWmTKmx26kqDFaJfaq/0zGC4k1
	 1JOX9xQnsAwrwXqMCpUbXeoMfJBIT/ddupFgyzKW4DNG2D9kpU7lEF7FMeUmErY5yW
	 fsojhIXbjYKHHd3OQnKLukCL67gCc0pH7SmBiq1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391696AbgEZTHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389901AbgEZTG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:06:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A9C2208B3;
        Tue, 26 May 2020 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520019;
        bh=4VPdxXWjr16mx7dly3zIokwM4xa2s8mgnV64LSzfatA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okNSGQKFxtfTd/7RoLv8Oc16G6PVNdKMNDCWbwCokQc6ZCxB9zHYxA6Pm1jrYW07O
         gGSvJRazMQCJ0vj0all4ucGPGPVOM/WMQgVsIEiRZxORSVGLkZM0/qaYh48Kr84SuC
         VLwKXIx5RrlpFCB+h4p0zDYeOlDBVFW1Fn7QQkzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 026/111] configfs: fix config_item refcnt leak in configfs_rmdir()
Date:   Tue, 26 May 2020 20:52:44 +0200
Message-Id: <20200526183935.217763918@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
References: <20200526183932.245016380@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit 8aebfffacfa379ba400da573a5bf9e49634e38cb ]

configfs_rmdir() invokes configfs_get_config_item(), which returns a
reference of the specified config_item object to "parent_item" with
increased refcnt.

When configfs_rmdir() returns, local variable "parent_item" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one exception handling path of
configfs_rmdir(). When down_write_killable() fails, the function forgets
to decrease the refcnt increased by configfs_get_config_item(), causing
a refcnt leak.

Fix this issue by calling config_item_put() when down_write_killable()
fails.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/configfs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index cf7b7e1d5bd7..cb733652ecca 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1519,6 +1519,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
 		spin_lock(&configfs_dirent_lock);
 		configfs_detach_rollback(dentry);
 		spin_unlock(&configfs_dirent_lock);
+		config_item_put(parent_item);
 		return -EINTR;
 	}
 	frag->frag_dead = true;
-- 
2.25.1



