Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3253BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A1A20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690608;
	bh=Hxk7UHen0BwilFAy+VLDUeF9jJ/l/efGTHNGUWn3nYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uYMUEkcTcb84XXNTmfy1qGO0vtYFTKR3r02Mg+L8USYzp9sBPmwvQlmjGHSoSc0JV
	 kIMHvICz3unx56k3VZLxoGmfBoBJ/vs3VocenLexeG24F++vf0m6Tqg03Vd8jFup5l
	 C1RK65YPwL2fRzkMSCDN6c+kLAepHTeJp59S+Bqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbgHQS4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbgHQPuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:50:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD84120855;
        Mon, 17 Aug 2020 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679422;
        bh=Hxk7UHen0BwilFAy+VLDUeF9jJ/l/efGTHNGUWn3nYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkk7PqZTzQLk/NpezIpCxjfOWzsM2GCJsAk3B0HMdOI9REBSRx1zpJ3O9RVYoccp7
         gfz8jMwF4qm1FkicjrmrMCjlBPZjX+KncUPTqiU2byF9e8kMy7fJ302tFoeKoSoFNM
         ZIaJC6Bu9B7FUbvGOsQxRkpsqJLXQt0z15q2SbGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 188/393] iomap: Make sure iomap_end is called after iomap_begin
Date:   Mon, 17 Aug 2020 17:13:58 +0200
Message-Id: <20200817143828.740143105@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
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



