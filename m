Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DFCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA912072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693017;
	bh=Hxk7UHen0BwilFAy+VLDUeF9jJ/l/efGTHNGUWn3nYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0tpB9M4s64mU/liNcFqFwW/vpSEUTFVVRjRQLlImK4Xg/+lp5WtL3j3kQuwkVd6hs
	 DWtVHt+G7ksXJdMGeHDeL/v34qWo9RQOwuv8diksXWCMEDOWwfBf105E7pbylX9jLU
	 /Is7JIO39uBfzcCvpS7wcKlRCyX7lUC1Dq7Efxog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbgHQTgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbgHQP2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:28:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791C423A32;
        Mon, 17 Aug 2020 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678092;
        bh=Hxk7UHen0BwilFAy+VLDUeF9jJ/l/efGTHNGUWn3nYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SenPNbw+mxoN8HFoIjd0QgzI5nlNp7+4Z+vunA+URdYkDFf/MKAA3olhPBzWPWung
         tMCOtE8tpdsaxTb374Qoe9O4seG954E52X/4CkSI4P0GWPaGkbPySM6+eWvm/9oNwf
         NY6Uc5GLKvq7z/CW46pBZFMh+v56tjhKiX5J6w10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 214/464] iomap: Make sure iomap_end is called after iomap_begin
Date:   Mon, 17 Aug 2020 17:12:47 +0200
Message-Id: <20200817143844.062314049@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 856473cd5d17dbbf3055710857c67a4af6d9fcc0 ]

Make sure iomap_end is always called when iomap_begin succeeds.

Without this fix, iomap_end won't be called when a filesystem's
iomap_begin operation returns an invalid mapping, bypassing any
unlocking done in iomap_end.  With this fix, the unlocking will still
happen.

This bug was found by Bob Peterson during code review.  It's unlikely
that such iomap_begin bugs will survive to affect users, so backporting
this fix seems unnecessary.

Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/apply.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 76925b40b5fd2..26ab6563181fc 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -46,10 +46,14 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
 	if (ret)
 		return ret;
-	if (WARN_ON(iomap.offset > pos))
-		return -EIO;
-	if (WARN_ON(iomap.length == 0))
-		return -EIO;
+	if (WARN_ON(iomap.offset > pos)) {
+		written = -EIO;
+		goto out;
+	}
+	if (WARN_ON(iomap.length == 0)) {
+		written = -EIO;
+		goto out;
+	}
 
 	trace_iomap_apply_dstmap(inode, &iomap);
 	if (srcmap.type != IOMAP_HOLE)
@@ -80,6 +84,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	written = actor(inode, pos, length, data, &iomap,
 			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
 
+out:
 	/*
 	 * Now the data has been copied, commit the range we've copied.  This
 	 * should not fail unless the filesystem has had a fatal error.
-- 
2.25.1



