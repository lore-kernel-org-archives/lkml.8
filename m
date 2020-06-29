Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B780C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E658E207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593463050;
	bh=x3sYIjc4nFgaVNKHDQ3rLvb6gJE9x3T2UeHwEIxBN34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cgzJ+dd0DSlo+awIVcixRjE9CZ+wWBYqPGaxoRig6KH3QLX2KqZND6mNRams/jD0n
	 h+5n+JiePXlkkKDtTYKL5a22jfk2cf0Ry2gQYHm6vMULQ5PwDtbTCXgfn7RwlV+Qe8
	 1gzxrdioJ9EshSF6gd6SBdDPqMEw/UNoe2RE/3yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbgF2Uh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732103AbgF2TUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:20:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDB725489;
        Mon, 29 Jun 2020 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445447;
        bh=x3sYIjc4nFgaVNKHDQ3rLvb6gJE9x3T2UeHwEIxBN34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4Hdk4q0ITE9uVyl9dqkkBHsN7EKNItp6Y8fIzArWjkRN5qzfw4FYZzJ2f/ZHD89B
         vFl6J2PZySGzNDWHchnJ1VoRuX7FVWpwoMFszhv2t+m/8Di/7fh8he3VCt+NlomfMi
         zg/Ue11EoXf+s01uxJBtO61x2U+P1Hmtg7xA3WyY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.9 187/191] pNFS/flexfiles: Fix list corruption if the mirror count changes
Date:   Mon, 29 Jun 2020 11:40:03 -0400
Message-Id: <20200629154007.2495120-188-sashal@kernel.org>
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
index 4539008502ce6..83149cbae0931 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -939,9 +939,8 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 		goto out_mds;
 
 	/* Use a direct mapping of ds_idx to pgio mirror_idx */
-	if (WARN_ON_ONCE(pgio->pg_mirror_count !=
-	    FF_LAYOUT_MIRROR_COUNT(pgio->pg_lseg)))
-		goto out_mds;
+	if (pgio->pg_mirror_count != FF_LAYOUT_MIRROR_COUNT(pgio->pg_lseg))
+		goto out_eagain;
 
 	for (i = 0; i < pgio->pg_mirror_count; i++) {
 		ds = nfs4_ff_layout_prepare_ds(pgio->pg_lseg, i, true);
@@ -960,11 +959,15 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	}
 
 	return;
-
+out_eagain:
+	pnfs_generic_pg_cleanup(pgio);
+	pgio->pg_error = -EAGAIN;
+	return;
 out_mds:
 	pnfs_put_lseg(pgio->pg_lseg);
 	pgio->pg_lseg = NULL;
 	nfs_pageio_reset_write_mds(pgio);
+	pgio->pg_error = -EAGAIN;
 }
 
 static unsigned int
-- 
2.25.1

