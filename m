Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FC3C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F54420656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551735;
	bh=micotk57/YyCbC9O+mxgFISmiIDBkthE9XBBlTkxP7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bMhwOqiK5kz7w0GdMd9T2HNFP8QQoUuRjErcH7cW0PCvF6BoMswzMWOaHvdPsGnbi
	 Ghs89tQSnCDNKKtj1aWeEQHKLoaClryboDxBbhrmI5Np8CB2AWY4zRQuuakQ0c61/E
	 5v56xo69K665UaphNknTsFIU3n280Bks5s+wNmc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgDVKfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgDVKXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:23:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E522A2071E;
        Wed, 22 Apr 2020 10:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551012;
        bh=micotk57/YyCbC9O+mxgFISmiIDBkthE9XBBlTkxP7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkhhVBNyMgjIVI6iepKoaDwSPCK6omcjzTXd8hbuHDNQBgq+u2Hh8ZD0ng4GzGsLl
         +OFi3A3UO3Eh1PmSYa+GKI30qUO7DigJoTUEwC32en2H2e0qe4e3UQcw7raTnWr5yP
         eP1/mikO/bOeDe4SMGxf0LL7vXir1F524hpcP2HA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 063/166] xfs: fix use-after-free when aborting corrupt attr inactivation
Date:   Wed, 22 Apr 2020 11:56:30 +0200
Message-Id: <20200422095055.594423338@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

[ Upstream commit 496b9bcd62b0b3a160be61e3265a086f97adcbd3 ]

Log the corrupt buffer before we release the buffer.

Fixes: a5155b870d687 ("xfs: always log corruption errors")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_attr_inactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_attr_inactive.c b/fs/xfs/xfs_attr_inactive.c
index bbfa6ba84dcd7..fe8f60b59ec4d 100644
--- a/fs/xfs/xfs_attr_inactive.c
+++ b/fs/xfs/xfs_attr_inactive.c
@@ -145,8 +145,8 @@ xfs_attr3_node_inactive(
 	 * Since this code is recursive (gasp!) we must protect ourselves.
 	 */
 	if (level > XFS_DA_NODE_MAXDEPTH) {
-		xfs_trans_brelse(*trans, bp);	/* no locks for later trans */
 		xfs_buf_corruption_error(bp);
+		xfs_trans_brelse(*trans, bp);	/* no locks for later trans */
 		return -EFSCORRUPTED;
 	}
 
-- 
2.20.1



