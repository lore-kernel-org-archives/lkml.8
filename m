Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA551C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B711120724
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460360;
	bh=uiUgCBJW+P2z3Y1CbQBk2mXh7Nit/giMRJsltz66ggs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vk8yINstNBti69eY0qP2PKAuFemVB5tq6ayHrkENnM6fB7l2RD1SUP9eLSU4sH9le
	 igvAt2+7E4y4DIEF74EeEyFOivebcO52t5i4Ktrf7QogTKoIU9A+3+vYDiea8p+tWm
	 6KuKAorQULyZrdxNb86zqHZ74WheIlncvKevKFkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbgF2Twj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387700AbgF2Tk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73087251C2;
        Mon, 29 Jun 2020 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444495;
        bh=uiUgCBJW+P2z3Y1CbQBk2mXh7Nit/giMRJsltz66ggs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QUJDsGHrOKcFBFMSv0Nt0WWPZ7a1Wy10Te+wkNQsdTqbK6yTC4DWXmsb/gEjXbLSW
         9D4WLSs+d6rJcIEkSuKBt9wDE4o45dJp/L9YR8Az+jiZUoL2icqG3pUoXBEDxCImw9
         EB7ybgASUl0jSzdpCh28cjUwso6lDaY+1YsyhbM4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4 172/178] pNFS/flexfiles: Fix list corruption if the mirror count changes
Date:   Mon, 29 Jun 2020 11:25:17 -0400
Message-Id: <20200629152523.2494198-173-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 8b04013737341442ed914b336cde866b902664ae upstream.

If the mirror count changes in the new layout we pick up inside
ff_layout_pg_init_write(), then we can end up adding the
request to the wrong mirror and corrupting the mirror->pg_list.

Fixes: d600ad1f2bdb ("NFS41: pop some layoutget errors to application")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 5657b7f2611f1..1741d902b0d8f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -984,9 +984,8 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 		goto out_mds;
 
 	/* Use a direct mapping of ds_idx to pgio mirror_idx */
-	if (WARN_ON_ONCE(pgio->pg_mirror_count !=
-	    FF_LAYOUT_MIRROR_COUNT(pgio->pg_lseg)))
-		goto out_mds;
+	if (pgio->pg_mirror_count != FF_LAYOUT_MIRROR_COUNT(pgio->pg_lseg))
+		goto out_eagain;
 
 	for (i = 0; i < pgio->pg_mirror_count; i++) {
 		mirror = FF_LAYOUT_COMP(pgio->pg_lseg, i);
@@ -1008,7 +1007,10 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
 		pgio->pg_maxretrans = io_maxretrans;
 	return;
-
+out_eagain:
+	pnfs_generic_pg_cleanup(pgio);
+	pgio->pg_error = -EAGAIN;
+	return;
 out_mds:
 	trace_pnfs_mds_fallback_pg_init_write(pgio->pg_inode,
 			0, NFS4_MAX_UINT64, IOMODE_RW,
@@ -1018,6 +1020,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	pgio->pg_lseg = NULL;
 	pgio->pg_maxretrans = 0;
 	nfs_pageio_reset_write_mds(pgio);
+	pgio->pg_error = -EAGAIN;
 }
 
 static unsigned int
-- 
2.25.1

