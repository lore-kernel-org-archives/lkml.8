Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0461C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C417720656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462182;
	bh=eISxDRQGqvnifGfBTu9Mpzrk1QNYu/9Er5waF/zjx+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CeEFOtX02xymJy+R8o2/g7ODor55WEyuIM8XhnuaKBsc72c0cAB1wLe/EIexh2Acd
	 7/UXvSa+Sh9i/WrxHfqBW3QrT3N6NWAMDm55GFgIoemifrd3BUCi9XMq8FEaw11brm
	 +Za599Tjz6CU4+dQ7fV/jebRZ/zo2DzmOnMWjr20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbgF2UXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732577AbgF2TZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0673925454;
        Mon, 29 Jun 2020 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445409;
        bh=eISxDRQGqvnifGfBTu9Mpzrk1QNYu/9Er5waF/zjx+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIAoB9INVFJdkfSCOTm1aUndyFzZtrerfHMQA7xqzwPHV/G++oCwi2T/ebbD42IrC
         1EYAnpCEp3aDTQ0wJbVnYaIyCE+X+j1IuPvx54VmO+aHUFkNOAQqDMTPqOqOzpPRae
         jq+bvXq0BwMCZgVo8vYxr7eFlpbQdcvvgKIpUWRo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 160/191] cifs/smb3: Fix data inconsistent when zero file range
Date:   Mon, 29 Jun 2020 11:39:36 -0400
Message-Id: <20200629154007.2495120-161-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

[ Upstream commit 6b69040247e14b43419a520f841f2b3052833df9 ]

CIFS implements the fallocate(FALLOC_FL_ZERO_RANGE) with send SMB
ioctl(FSCTL_SET_ZERO_DATA) to server. It just set the range of the
remote file to zero, but local page cache not update, then the data
inconsistent with server, which leads the xfstest generic/008 failed.

So we need to remove the local page caches before send SMB
ioctl(FSCTL_SET_ZERO_DATA) to server. After next read, it will
re-cache it.

Fixes: 30175628bf7f5 ("[SMB3] Enable fallocate -z support for SMB3 mounts")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Cc: stable@vger.kernel.org # v3.17
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 9c29317deef56..edd4c7292be00 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1220,6 +1220,12 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	inode = d_inode(cfile->dentry);
 	cifsi = CIFS_I(inode);
 
+	/*
+	 * We zero the range through ioctl, so we need remove the page caches
+	 * first, otherwise the data may be inconsistent with the server.
+	 */
+	truncate_pagecache_range(inode, offset, offset + len - 1);
+
 	/* if file not oplocked can't be sure whether asking to extend size */
 	if (!CIFS_CACHE_READ(cifsi))
 		if (keep_size == false)
-- 
2.25.1

