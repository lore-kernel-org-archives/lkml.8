Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4F3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8653D21707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584093;
	bh=CDbuC6NeE0DQQKmZTYLkb0wr4fPE3gNaAz8iQPAkSnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TdFKNwhK9beCxBG9xXIKhTDBtmh3Dzkc9wWdqegtG8jG26xCcPoi4ZUf0DSYmFnw8
	 MZmUVfsSEn5dPcvwDlFnvYSR8doDPr8EuJgWLqu0JF6ef7f6AVF5D5alfVWUvDD/4N
	 cfs8ykzMRb2PTK7S6Ej7aYFYNB4LEogOkWgdUw/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394917AbgFSQ1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389970AbgFSOz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:55:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED167217D9;
        Fri, 19 Jun 2020 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578528;
        bh=CDbuC6NeE0DQQKmZTYLkb0wr4fPE3gNaAz8iQPAkSnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JY+d15uVjmwGcC9xQHhqCPGj4E9d4hvjCvc4kLrOWf1jyY6+DL+VqQgUVeoSuK9av
         hCQlAiQQtS+hhbRNxRXkyY9tHcpMlj1Ad3pxFOg5Pl/bZFhymQf85Bw3IrZQbao/BE
         8PmoQrz6kNEbmMvoo6zl4zsmsMw2x8ASZpG1N/L4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avi Kivity <avi@scylladb.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.19 026/267] aio: fix async fsync creds
Date:   Fri, 19 Jun 2020 16:30:11 +0200
Message-Id: <20200619141650.119038260@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit 530f32fc370fd1431ea9802dbc53ab5601dfccdb upstream.

Avi Kivity reports that on fuse filesystems running in a user namespace
asyncronous fsync fails with EOVERFLOW.

The reason is that f_ops->fsync() is called with the creds of the kthread
performing aio work instead of the creds of the process originally
submitting IOCB_CMD_FSYNC.

Fuse sends the creds of the caller in the request header and it needs to
translate the uid and gid into the server's user namespace.  Since the
kthread is running in init_user_ns, the translation will fail and the
operation returns an error.

It can be argued that fsync doesn't actually need any creds, but just
zeroing out those fields in the header (as with requests that currently
don't take creds) is a backward compatibility risk.

Instead of working around this issue in fuse, solve the core of the problem
by calling the filesystem with the proper creds.

Reported-by: Avi Kivity <avi@scylladb.com>
Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
Fixes: c9582eb0ff7d ("fuse: Fail all requests with invalid uids or gids")
Cc: stable@vger.kernel.org  # 4.18+
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/aio.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -169,6 +169,7 @@ struct fsync_iocb {
 	struct file		*file;
 	struct work_struct	work;
 	bool			datasync;
+	struct cred		*creds;
 };
 
 struct poll_iocb {
@@ -1579,8 +1580,11 @@ static ssize_t aio_write(struct kiocb *r
 static void aio_fsync_work(struct work_struct *work)
 {
 	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
+	const struct cred *old_cred = override_creds(iocb->fsync.creds);
 
 	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
+	revert_creds(old_cred);
+	put_cred(iocb->fsync.creds);
 	iocb_put(iocb);
 }
 
@@ -1594,6 +1598,10 @@ static int aio_fsync(struct fsync_iocb *
 	if (unlikely(!req->file->f_op->fsync))
 		return -EINVAL;
 
+	req->creds = prepare_creds();
+	if (!req->creds)
+		return -ENOMEM;
+
 	req->datasync = datasync;
 	INIT_WORK(&req->work, aio_fsync_work);
 	schedule_work(&req->work);


