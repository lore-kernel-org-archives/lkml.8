Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B23C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA31B2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596097027;
	bh=3eUOrbV3MNqsL345YCOhECWV2Pf/2AonifviYDZxljo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w+gKou0qJfDxEmtJpsLDhAyvONsytDMzlM1Mwbc0bYHu1HpQQAiIykuoRzEFMbT6T
	 MaJVSetWKcuexqsqPPbJDxdsp9nJ6YngzleHycnBTXotr2HkZAn6irz9PPfd79lGDE
	 FNultLrY04xiq2XCM9pH4cscimW51aWt947vDkqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgG3IRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbgG3IKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:10:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D4082083B;
        Thu, 30 Jul 2020 08:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096618;
        bh=3eUOrbV3MNqsL345YCOhECWV2Pf/2AonifviYDZxljo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/L3Ttx8m/DlQ6ypRBM5dPDiDeln7b75ABreb22KMBAqmQ3KeHjfQBYeYCMaV99Fk
         k8LAAWvFcssqjJl1FKp5zT8YWozh0S6OKkXHL+fZmqMDP73FwteqzcdYEXBAgT9tTg
         WFtJ5cgPzmDHnGXbnbEO+nycc3BNDqUVKs8nQ3tU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Nobuhiro Iwamatsu (CIP)" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.9 57/61] xfs: set format back to extents if xfs_bmap_extents_to_btree
Date:   Thu, 30 Jul 2020 10:05:15 +0200
Message-Id: <20200730074423.598169168@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.811058810@linuxfoundation.org>
References: <20200730074420.811058810@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sandeen <sandeen@redhat.com>

commit 2c4306f719b083d17df2963bc761777576b8ad1b upstream.

If xfs_bmap_extents_to_btree fails in a mode where we call
xfs_iroot_realloc(-1) to de-allocate the root, set the
format back to extents.

Otherwise we can assume we can dereference ifp->if_broot
based on the XFS_DINODE_FMT_BTREE format, and crash.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199423
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_bmap.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -781,6 +781,8 @@ try_another_ag:
 	*logflagsp = 0;
 	if ((error = xfs_alloc_vextent(&args))) {
 		xfs_iroot_realloc(ip, -1, whichfork);
+		ASSERT(ifp->if_broot == NULL);
+		XFS_IFORK_FMT_SET(ip, whichfork, XFS_DINODE_FMT_EXTENTS);
 		xfs_btree_del_cursor(cur, XFS_BTREE_ERROR);
 		return error;
 	}
@@ -801,6 +803,8 @@ try_another_ag:
 	}
 	if (WARN_ON_ONCE(args.fsbno == NULLFSBLOCK)) {
 		xfs_iroot_realloc(ip, -1, whichfork);
+		ASSERT(ifp->if_broot == NULL);
+		XFS_IFORK_FMT_SET(ip, whichfork, XFS_DINODE_FMT_EXTENTS);
 		xfs_btree_del_cursor(cur, XFS_BTREE_ERROR);
 		return -ENOSPC;
 	}


