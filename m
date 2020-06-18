Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDDAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3242223F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445604;
	bh=WFhN86/8PgIVAw+/GByvJEeVx2pstmpPDYtGP6ft++4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wlxa5MMaRsy25G/YVszrrLTqjqLi0cs61sGUGtlcV7VRKu45iVoX5bUSJxVTnGtOG
	 T6Z2+IdQzDeHnHkAKYplA4gPWHg/TuB4MoqnH2uS3cxxdquPksDgYx3qreI18XkvZz
	 3sZfsVi7kuwneoTf4D4aHCTR5N4tROJU7nCNd/Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbgFRBY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729734AbgFRBVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:21:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7623214DB;
        Thu, 18 Jun 2020 01:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443270;
        bh=WFhN86/8PgIVAw+/GByvJEeVx2pstmpPDYtGP6ft++4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L480iq4Qyq3l+fk06aSRUDNESa8Ce0ilsjEr+lI2qstVz+1+ACafi+Br7v4un05fc
         jWfpUmnjA/dte9l1BpO5aQzVinczKYDRVEDy9LdMmnX6un8IXT1KWTtcLdfr/cKkci
         KOBvxjhPxyrBraNTsUAEP1FHZO0JRHxJcwhW//7s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luis Henriques <lhenriques@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 216/266] ceph: don't return -ESTALE if there's still an open file
Date:   Wed, 17 Jun 2020 21:15:41 -0400
Message-Id: <20200618011631.604574-216-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Henriques <lhenriques@suse.com>

[ Upstream commit 878dabb64117406abd40977b87544d05bb3031fc ]

Similarly to commit 03f219041fdb ("ceph: check i_nlink while converting
a file handle to dentry"), this fixes another corner case with
name_to_handle_at/open_by_handle_at.  The issue has been detected by
xfstest generic/467, when doing:

 - name_to_handle_at("/cephfs/myfile")
 - open("/cephfs/myfile")
 - unlink("/cephfs/myfile")
 - sync; sync;
 - drop caches
 - open_by_handle_at()

The call to open_by_handle_at should not fail because the file hasn't been
deleted yet (only unlinked) and we do have a valid handle to it.  -ESTALE
shall be returned only if i_nlink is 0 *and* i_count is 1.

This patch also makes sure we have LINK caps before checking i_nlink.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/export.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 79dc06881e78..e088843a7734 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -172,9 +172,16 @@ struct inode *ceph_lookup_inode(struct super_block *sb, u64 ino)
 static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
 {
 	struct inode *inode = __lookup_inode(sb, ino);
+	int err;
+
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
-	if (inode->i_nlink == 0) {
+	/* We need LINK caps to reliably check i_nlink */
+	err = ceph_do_getattr(inode, CEPH_CAP_LINK_SHARED, false);
+	if (err)
+		return ERR_PTR(err);
+	/* -ESTALE if inode as been unlinked and no file is open */
+	if ((inode->i_nlink == 0) && (atomic_read(&inode->i_count) == 1)) {
 		iput(inode);
 		return ERR_PTR(-ESTALE);
 	}
-- 
2.25.1

