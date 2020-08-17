Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6DDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68EFE20738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597688119;
	bh=fdxp09zgqQqA8BlemkbFg7J+9Sh+Rmm7GyIlGeQcGyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2A1EyLQG/yZJcso9xczIZoru8T5L2OSQVHBfdjUdwxLEiTgtwraMYnjvcUL0FZ+ml
	 ZSR5niMKjsWNVPgup3ksiVDbz8z23eRkc7VNca7pMPc0VW5K6cer+HtauV6Nq9LFxU
	 bEffTB58K7kLH2Bx62zzFss8eg0ImI3q19JGjtuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390656AbgHQSPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731050AbgHQQGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:06:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27DA02173E;
        Mon, 17 Aug 2020 16:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680368;
        bh=fdxp09zgqQqA8BlemkbFg7J+9Sh+Rmm7GyIlGeQcGyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yaGutq8VxqECrlLEc1vLUCkkppa3ry1W1PNlAjdTY/HTLVtDiafCfgtKYKswZ9ca9
         PVy3KR8pv1KLs6M2RmI5etUdIRzPJeXvg9ooIXCndWqMNSO6YiPdN5YvM5cyR8voV2
         zpQ0djSLcV1wLD7f+r1lTVBk/gwIXvrgK9M+Ic8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 129/270] iomap: Make sure iomap_end is called after iomap_begin
Date:   Mon, 17 Aug 2020 17:15:30 +0200
Message-Id: <20200817143802.211923175@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
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
index 54c02aecf3cd8..c2281a6a7f320 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -41,10 +41,14 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	ret = ops->iomap_begin(inode, pos, length, flags, &iomap);
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
 
 	/*
 	 * Cut down the length to the one actually provided by the filesystem,
@@ -60,6 +64,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	 */
 	written = actor(inode, pos, length, data, &iomap);
 
+out:
 	/*
 	 * Now the data has been copied, commit the range we've copied.  This
 	 * should not fail unless the filesystem has had a fatal error.
-- 
2.25.1



