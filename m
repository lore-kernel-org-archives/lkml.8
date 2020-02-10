Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2A9C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594AB20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338194;
	bh=88GHOlgGcroTMYABt4ulbBTzeF5yg4F+IwrvRpMFaEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C7IODwhgnndFUpNveH6t18Zl+h7Re545tAp9muPpjYvdCzaPjahUOrqd9f3IqIwCE
	 MCQjbG7FWjNU8Q/sSTGqxlNp0Noq+IiIp3haxOpgZ4H2I55hXvG85NTRLzz1Niy4qd
	 y/KWBtC00pM9cTsjFuRlUw/KzOtz+a8rXU1cBdYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgBJMgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbgBJMfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:51 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C002F24650;
        Mon, 10 Feb 2020 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338150;
        bh=88GHOlgGcroTMYABt4ulbBTzeF5yg4F+IwrvRpMFaEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJRlkUoDFe489aTXGFi7gsT8Azau8vMB/IbzcBQIEXhoXpX6UFfZ+HNV9Rw64UT0+
         o8kvUk7h+WHQOy6JKbM4B/YbiIrQw6EcBT3KSM9jfPs4aTpvHtrN1nGytqe3sUyMZn
         Jkxo2LU1udQ3L9oJJSqDr7PdygxxRa4XwY7Skb8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 4.19 113/195] gfs2: move setting current->backing_dev_info
Date:   Mon, 10 Feb 2020 04:32:51 -0800
Message-Id: <20200210122316.533767848@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit 4c0e8dda608a51855225c611b5c6b442f95fbc56 upstream.

Set current->backing_dev_info just around the buffered write calls to
prepare for the next fix.

Fixes: 967bcc91b044 ("gfs2: iomap direct I/O support")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/file.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -800,18 +800,15 @@ static ssize_t gfs2_file_write_iter(stru
 	inode_lock(inode);
 	ret = generic_write_checks(iocb, from);
 	if (ret <= 0)
-		goto out;
-
-	/* We can write back this queue in page reclaim */
-	current->backing_dev_info = inode_to_bdi(inode);
+		goto out_unlock;
 
 	ret = file_remove_privs(file);
 	if (ret)
-		goto out2;
+		goto out_unlock;
 
 	ret = file_update_time(file);
 	if (ret)
-		goto out2;
+		goto out_unlock;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		struct address_space *mapping = file->f_mapping;
@@ -820,11 +817,13 @@ static ssize_t gfs2_file_write_iter(stru
 
 		written = gfs2_file_direct_write(iocb, from);
 		if (written < 0 || !iov_iter_count(from))
-			goto out2;
+			goto out_unlock;
 
+		current->backing_dev_info = inode_to_bdi(inode);
 		ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+		current->backing_dev_info = NULL;
 		if (unlikely(ret < 0))
-			goto out2;
+			goto out_unlock;
 		buffered = ret;
 
 		/*
@@ -848,14 +847,14 @@ static ssize_t gfs2_file_write_iter(stru
 			 */
 		}
 	} else {
+		current->backing_dev_info = inode_to_bdi(inode);
 		ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+		current->backing_dev_info = NULL;
 		if (likely(ret > 0))
 			iocb->ki_pos += ret;
 	}
 
-out2:
-	current->backing_dev_info = NULL;
-out:
+out_unlock:
 	inode_unlock(inode);
 	if (likely(ret > 0)) {
 		/* Handle various SYNC-type writes */


