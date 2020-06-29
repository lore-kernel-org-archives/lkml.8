Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F848C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED16206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462408;
	bh=BQdAqSdPS3iRhcepvseUBv/Xhst8nit7E9e0iguDRwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ApE3Q733avUVaeHNA0jNcW0Uap6mV+XrfAEQ1mKuGt0Y0vuOEusBG2y6OAoX8nM8s
	 fO12ybudYnYZoGevKUu/16kxLpoQtF2UEoPKJ3/W4qwXCa3HA/anvxoHhpV+jBY7FF
	 OxkVGp135AE6jc4sVW1uMpcHquXah8VDi0Dij8eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgF2U03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732520AbgF2TZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E8F2548B;
        Mon, 29 Jun 2020 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445448;
        bh=BQdAqSdPS3iRhcepvseUBv/Xhst8nit7E9e0iguDRwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ticfH3YdPyauEJBVIMTByXziPLfqjYY/ckUzYsAGNJ+Sz1yDjbLJ7/PwyQKjIOKe5
         ZA6p0dhqGdS6ICKd+ZKEgnxyWjP68kD2qUTHTMGRGWGqTJn4A9Px7IRKJOhppvEtKO
         yeC+8MbaGUpLpEVeBqxVPd5xGJH5L6rVO2AEd0tw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Neil Brown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.9 188/191] NFSv4 fix CLOSE not waiting for direct IO compeletion
Date:   Mon, 29 Jun 2020 11:40:04 -0400
Message-Id: <20200629154007.2495120-189-sashal@kernel.org>
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

From: Olga Kornievskaia <olga.kornievskaia@gmail.com>

commit d03727b248d0dae6199569a8d7b629a681154633 upstream.

Figuring out the root case for the REMOVE/CLOSE race and
suggesting the solution was done by Neil Brown.

Currently what happens is that direct IO calls hold a reference
on the open context which is decremented as an asynchronous task
in the nfs_direct_complete(). Before reference is decremented,
control is returned to the application which is free to close the
file. When close is being processed, it decrements its reference
on the open_context but since directIO still holds one, it doesn't
sent a close on the wire. It returns control to the application
which is free to do other operations. For instance, it can delete a
file. Direct IO is finally releasing its reference and triggering
an asynchronous close. Which races with the REMOVE. On the server,
REMOVE can be processed before the CLOSE, failing the REMOVE with
EACCES as the file is still opened.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Suggested-by: Neil Brown <neilb@suse.com>
CC: stable@vger.kernel.org
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/direct.c | 13 +++++++++----
 fs/nfs/file.c   |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index de135d2591ffb..1affdec237299 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -379,8 +379,6 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq)
 {
 	struct inode *inode = dreq->inode;
 
-	inode_dio_end(inode);
-
 	if (dreq->iocb) {
 		long res = (long) dreq->error;
 		if (dreq->count != 0) {
@@ -392,7 +390,10 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq)
 
 	complete(&dreq->completion);
 
+	igrab(inode);
 	nfs_direct_req_release(dreq);
+	inode_dio_end(inode);
+	iput(inode);
 }
 
 static void nfs_direct_readpage_release(struct nfs_page *req)
@@ -534,8 +535,10 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	 * generic layer handle the completion.
 	 */
 	if (requested_bytes == 0) {
-		inode_dio_end(inode);
+		igrab(inode);
 		nfs_direct_req_release(dreq);
+		inode_dio_end(inode);
+		iput(inode);
 		return result < 0 ? result : -EIO;
 	}
 
@@ -953,8 +956,10 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 	 * generic layer handle the completion.
 	 */
 	if (requested_bytes == 0) {
-		inode_dio_end(inode);
+		igrab(inode);
 		nfs_direct_req_release(dreq);
+		inode_dio_end(inode);
+		iput(inode);
 		return result < 0 ? result : -EIO;
 	}
 
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1eec947c562d2..a89d2f793c1b8 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -82,6 +82,7 @@ nfs_file_release(struct inode *inode, struct file *filp)
 	dprintk("NFS: release(%pD2)\n", filp);
 
 	nfs_inc_stats(inode, NFSIOS_VFSRELEASE);
+	inode_dio_wait(inode);
 	nfs_file_clear_open_context(filp);
 	return 0;
 }
-- 
2.25.1

