Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0F6C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A617220838
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588692701;
	bh=10UQQl3GPfT8mcIMbnLtvCSvPWaMAUPM/kBH8ajFl40=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tiLtH5rda0oa7Nkob6zqz0S/eDxA/WXcXPhZJHEzE05qGAcxSIOPL/SPdbpmjFkYQ
	 32fXlyLEVm4vmyDBRjXlgV5wmTkptDu+IhjSq5WMuEnh04f5yfNIyOcnHsE/L1e4NF
	 nIMx8BxdmDXIdZeLbBTBJer1RQEvRUYYbgyy/QN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgEEPbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbgEEPbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:31:40 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EDF92078C;
        Tue,  5 May 2020 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588692700;
        bh=10UQQl3GPfT8mcIMbnLtvCSvPWaMAUPM/kBH8ajFl40=;
        h=From:To:Cc:Subject:Date:From;
        b=HVY0pEgbAVyz6IqLvBZ+IAFiCCA7HoCpCBshkAB7xGhGO4uSDrUtwD2ZVCZ9I4C+C
         jbloa10/2h+K7Ygp7jK04JFUsG6e0EtkkH/eTnRXAMrtKnRkaoO6ETvjAO0Z9+36t5
         aVt+W3WZEw3RkFaT4DxJJAMSc7dYncstrhRsW7bA=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: get parent inode when recovering pino
Date:   Tue,  5 May 2020 08:31:39 -0700
Message-Id: <20200505153139.201697-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had to grab the inode before retrieving i_ino.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a0a4413d6083b..9d4c3e3503567 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -168,6 +168,7 @@ static const struct vm_operations_struct f2fs_file_vm_ops = {
 static int get_parent_ino(struct inode *inode, nid_t *pino)
 {
 	struct dentry *dentry;
+	struct inode *parent;
 
 	inode = igrab(inode);
 	dentry = d_find_any_alias(inode);
@@ -175,8 +176,13 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
 	if (!dentry)
 		return 0;
 
-	*pino = parent_ino(dentry);
+	parent = igrab(d_inode(dentry->d_parent));
 	dput(dentry);
+	if (!parent)
+		return 0;
+
+	*pino = parent->i_ino;
+	iput(parent);
 	return 1;
 }
 
-- 
2.26.2.526.g744177e7f7-goog

