Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C8FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED3820720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593465333;
	bh=iglSSy/eC9l0eP21No46s42jVb9ef03e/eA03aL4duw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cLzEmhkgiauigQvHsgJQ6iZGAOZKGnJNLfZDJ5dBPp/115CqlxtvCWfHdDHaoxbkC
	 3LVsnlplrOteF0gqJUlO3ULePWgtQ6jVI3FPNueOlSqRZVjs/4kLGpAYsC2kd7Td/e
	 QH9lGvlXDDH6Fv0hBaVV7JRoEABPp/7lVv510gNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390661AbgF2VPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729949AbgF2SzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCDFB2557A;
        Mon, 29 Jun 2020 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446144;
        bh=iglSSy/eC9l0eP21No46s42jVb9ef03e/eA03aL4duw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKHYGsuJRuOyRjMFHu2GTgtZk2U53wp9Mb5SixYgYCIaWbj4FztGNrylIdLD6yXI/
         uYe9BJvn0DFigr66xcadpIVnxCXpl4Ugix9Bj/blCQECIZDPKYyv+Hcg7WWrG/wTK4
         Lrg/jPiXB0VjHUtmVvQrsPKSvivw0rqfmYtJsqxo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Neil Brown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 132/135] NFSv4 fix CLOSE not waiting for direct IO compeletion
Date:   Mon, 29 Jun 2020 11:53:06 -0400
Message-Id: <20200629155309.2495516-133-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
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
index 7789f0b9b999e..4d76e9a97538d 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -385,8 +385,6 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq, bool write)
 	if (write)
 		nfs_zap_mapping(inode, inode->i_mapping);
 
-	inode_dio_end(inode);
-
 	if (dreq->iocb) {
 		long res = (long) dreq->error;
 		if (!res)
@@ -396,7 +394,10 @@ static void nfs_direct_complete(struct nfs_direct_req *dreq, bool write)
 
 	complete_all(&dreq->completion);
 
+	igrab(inode);
 	nfs_direct_req_release(dreq);
+	inode_dio_end(inode);
+	iput(inode);
 }
 
 static void nfs_direct_readpage_release(struct nfs_page *req)
@@ -537,8 +538,10 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
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
 
@@ -939,8 +942,10 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
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
index dc875cd0e11d5..eaa6697d256ea 100644
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

