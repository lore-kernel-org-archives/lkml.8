Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F0AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9A62063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686395;
	bh=UtwFBT0kfB+9WFyN4pTtQzi7oPQ09ioq8/mdTHXrjxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uhFfelgFbf7fEDKSqRyEyBHfk6rGQrh+fENw9bdqFxi8Iumpx9n8Z3L/CU2qiNv4h
	 Fot3TRLF0B/JLyW9QYuq7RR+7M7viEJ48Sa/PXUdU8/EyuMkIMD2z+YKXz5DVNo6pM
	 YmdO0CMI60LE82UoTsOG3u5tRKxYoWdog9Jxo3GU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbgHQRqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388592AbgHQQNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:13:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0383720760;
        Mon, 17 Aug 2020 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680830;
        bh=UtwFBT0kfB+9WFyN4pTtQzi7oPQ09ioq8/mdTHXrjxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgPj9rjlB5dyIu5w5mOKPxeYmbZ4lhtiwk+fuoXryMHSBhQvZ699w7X0K2eFHZrYV
         6D2PKpYvcEXjld5ErdHEr2MrR7aokW5ZboP5545VUydzs2kyfJQGlZwY0XOgmbPHNu
         nCYwjDIgLJ8dsZpUkbqB1mu5uqRBIvc8Y5hH7K9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/168] xfs: dont eat an EIO/ENOSPC writeback error when scrubbing data fork
Date:   Mon, 17 Aug 2020 17:16:46 +0200
Message-Id: <20200817143737.462486829@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

[ Upstream commit eb0efe5063bb10bcb653e4f8e92a74719c03a347 ]

The data fork scrubber calls filemap_write_and_wait to flush dirty pages
and delalloc reservations out to disk prior to checking the data fork's
extent mappings.  Unfortunately, this means that scrub can consume the
EIO/ENOSPC errors that would otherwise have stayed around in the address
space until (we hope) the writer application calls fsync to persist data
and collect errors.  The end result is that programs that wrote to a
file might never see the error code and proceed as if nothing were
wrong.

xfs_scrub is not in a position to notify file writers about the
writeback failure, and it's only here to check metadata, not file
contents.  Therefore, if writeback fails, we should stuff the error code
back into the address space so that an fsync by the writer application
can pick that up.

Fixes: 99d9d8d05da2 ("xfs: scrub inode block mappings")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/bmap.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index e1d11f3223e36..f84a58e523bc8 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -53,9 +53,27 @@ xchk_setup_inode_bmap(
 	 */
 	if (S_ISREG(VFS_I(sc->ip)->i_mode) &&
 	    sc->sm->sm_type == XFS_SCRUB_TYPE_BMBTD) {
+		struct address_space	*mapping = VFS_I(sc->ip)->i_mapping;
+
 		inode_dio_wait(VFS_I(sc->ip));
-		error = filemap_write_and_wait(VFS_I(sc->ip)->i_mapping);
-		if (error)
+
+		/*
+		 * Try to flush all incore state to disk before we examine the
+		 * space mappings for the data fork.  Leave accumulated errors
+		 * in the mapping for the writer threads to consume.
+		 *
+		 * On ENOSPC or EIO writeback errors, we continue into the
+		 * extent mapping checks because write failures do not
+		 * necessarily imply anything about the correctness of the file
+		 * metadata.  The metadata and the file data could be on
+		 * completely separate devices; a media failure might only
+		 * affect a subset of the disk, etc.  We can handle delalloc
+		 * extents in the scrubber, so leaving them in memory is fine.
+		 */
+		error = filemap_fdatawrite(mapping);
+		if (!error)
+			error = filemap_fdatawait_keep_errors(mapping);
+		if (error && (error != -ENOSPC && error != -EIO))
 			goto out;
 	}
 
-- 
2.25.1



